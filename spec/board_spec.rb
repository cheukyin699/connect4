require 'rspec'
require './lib/board.rb'

shared_examples 'a checker' do |n|
  context "given a horizontal line of #{n}s" do
    before do
      for i in 0..3
        b.put(i, n)
      end
    end

    for i in 0..3
      it "returns #{n} when checking position [#{i}][0]" do
        expect(b.check(i, 0)).to eq(n)
      end
    end
  end

  context "given a vertical line of #{n}s" do
    before do
      for i in 0..3
        b.put(0, n)
      end
    end

    for i in 0..3
      it "returns #{n} when checking position [0][#{i}]" do
        expect(b.check(0, i)).to eq(n)
      end
    end
  end

  context "given a diagonal line of #{n}s" do
    context "bottom left to top right" do
      before do
        for i in 0..3
          b.g[i][i] = n
        end
      end

      for i in 0..3
        it "returns #{n} when checking [#{i}][#{i}]" do
          expect(b.check(i, i)).to eq(n)
        end
      end
    end

    context "top left to bottom right" do
      before do
        for i in 0..3
          b.g[i][3-i] = n
        end
      end

      for i in 0..3
        it "returns #{n} when checking [#{i}][#{3-i}]" do
          expect(b.check(i, 3-i)).to eq(n)
        end
      end
    end
  end
end

describe Board do
  let(:b) { Board.new }

  describe '.put' do
    context 'given an empty board' do
      it 'places a piece at the bottom' do
        b.put(0, 1)
        expect(b.g[0][0]).to eq(1)
      end
    end

    context 'given a board with 1 piece' do
      it 'places a piece on top of the existing piece' do
        b.g[0][0] = 2

        b.put(0, 1)
        expect(b.g[0][1]).to eq(1)
      end
    end

    context 'given a full board' do
      it 'doesn\'t let you place it' do
        b.g[0] = Array.new(6, 1)
        expect{ b.put(0, 1) }.to raise_error "column is full"
      end
    end
  end

  describe '.check' do
    context 'given an empty board' do
      it 'returns 0 (not finished)' do
        expect(b.check(0, 0)).to eq(0)
      end
    end

    it_should_behave_like 'a checker', 1
    it_should_behave_like 'a checker', 2
  end
end
