# -*- coding: utf-8 -*-
require_relative '../../integration/spec_helper'

describe Dumpster::Excel::Writer do

  context 'performance when using' do
    path = File.join(File.dirname(__FILE__), 'output')

    before(:all) do
      Dir.glob(File.join(path, '/perf-test-*.xlsx')) do |file|
        File.delete file
      end
    end

    let!(:data) { 5000.times.collect { |t| ['row-' + t.to_s, 11 * t, 11.1 / (t+1), 1111 * t, 'balsd ü sad ksad öéöàä'] } }
    let!(:model) { Dumpster::Model::Generic.new(data) }
    let!(:model_with_types) { Dumpster::Model::Generic.new(data, [:string, :integer, :float, :integer, :string]) }

    it 'default' do
      output_path = File.join(path, 'perf-test-bare.xlsx')
      writer = Dumpster::Excel::Writer.new(model)

      writer.write_to_file(output_path)
    end

    it 'no autowidth' do
      output_path = File.join(path, 'perf-test_no_autowidth.xlsx')
      writer = Dumpster::Excel::Writer.new(model)

      writer.write_to_file(output_path, autowidth=false)
    end

    it 'use types' do
      output_path = File.join(path, 'perf-test_with_types.xlsx')
      writer = Dumpster::Excel::Writer.new(model_with_types)

      writer.write_to_file(output_path)
    end

    it 'use trust input' do
      output_path = File.join(path, 'perf-test-with_trusted-input.xlsx')
      writer = Dumpster::Excel::Writer.new(model)

      writer.write_to_file(output_path, trust_input=true)
    end

    it 'use all optimisations' do
      output_path = File.join(path, 'perf-test-all-optimisations.xlsx')
      writer = Dumpster::Excel::Writer.new(model_with_types)

      writer.write_to_file(output_path, autowidth=false, trust_input=true)
    end
  end
end
