# -*- coding: utf-8 -*-
require_relative '../../integration/spec_helper'

describe Dumpster::Excel::Writer do

  context 'performance when using' do

    let!(:data) { 5000.times.collect { |t| ['row-' + t.to_s, 11 * t, 11.1 / (t+1), 1111 * t, 'balsd ü sad ksad öéöàä'] } }
    let!(:model) { Dumpster::Model::Generic.new(data) }
    let!(:model_with_types) { Dumpster::Model::Generic.new(data, [:string, :integer, :float, :integer, :string]) }

    it 'default' do
      writer = Dumpster::Excel::Writer.new(model)

      writer.write_to_string()
    end

    it 'no autowidth' do
      writer = Dumpster::Excel::Writer.new(model)

      writer.write_to_string({ autowidth: false })
    end

    it 'use types' do
      writer = Dumpster::Excel::Writer.new(model_with_types)

      writer.write_to_string()
    end

    it 'use trust input' do
      writer = Dumpster::Excel::Writer.new(model)

      writer.write_to_string({ trust_input: true })
    end

    it 'use all optimisations' do
      writer = Dumpster::Excel::Writer.new(model_with_types)

      writer.write_to_string({ autowidth: false, trust_input: true })
    end
  end
end
