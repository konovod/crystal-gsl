require "./spec_helper"

describe GSL::Stats do
  it "dir_2d has length 1" do
    x, y = GSL::Stats.dir_2d
    (x*x + y*y).should be_close 1, 1e-6
  end
  it "dir_2d is different when default rng is passed" do
    x1, y1 = GSL::Stats.dir_2d
    x2, y2 = GSL::Stats.dir_2d
    x1.should_not eq x2
    y1.should_not eq y2
  end
  it "dir_2d is same when same rng is passed" do
    rng1 = Random::PCG32.new(1u64, 1u64)
    x1, y1 = GSL::Stats.dir_2d(rng1)
    rng1 = Random::PCG32.new(1u64, 1u64)
    x2, y2 = GSL::Stats.dir_2d(rng1)
    x1.should eq x2
    y1.should eq y2
  end

  it "dir_2d works with trig_method: true" do
    x, y = GSL::Stats.dir_2d(trig_method: true)
    (x*x + y*y).should be_close 1, 1e-6
  end
  it "dir_2d works with trig_method: false" do
    x, y = GSL::Stats.dir_2d(trig_method: false)
    (x*x + y*y).should be_close 1, 1e-6
  end

  it "dir_3d has length 1" do
    x, y, z = GSL::Stats.dir_3d
    (x*x + y*y + z*z).should be_close 1, 1e-6
  end

  it "dir_3d is different when default rng is passed" do
    x1, y1, z1 = GSL::Stats.dir_3d
    x2, y2, z2 = GSL::Stats.dir_3d
    x1.should_not eq x2
    y1.should_not eq y2
    z1.should_not eq z2
  end
  it "dir_3d is same when same rng is passed" do
    rng1 = Random::PCG32.new(1u64, 1u64)
    x1, y1, z1 = GSL::Stats.dir_3d(rng1)
    rng1 = Random::PCG32.new(1u64, 1u64)
    x2, y2, z2 = GSL::Stats.dir_3d(rng1)
    x1.should eq x2
    y1.should eq y2
    z1.should eq z2
  end

  it "dir_nd returns array that has length n and norm = 1" do
    v = GSL::Stats.dir_nd(10)
    v.should be_a Array(Float64)
    v.size.should eq 10
    v.sum { |x| x*x }.should be_close 1, 1e-6
  end

  it "dir_nd is different when default rng is passed" do
    v1 = GSL::Stats.dir_nd(10)
    v2 = GSL::Stats.dir_nd(10)
    v1.should_not eq v2
  end
  it "dir_nd is same when same rng is passed" do
    rng1 = Random::PCG32.new(1u64, 1u64)
    v1 = GSL::Stats.dir_nd(10, rng: rng1)
    rng1 = Random::PCG32.new(1u64, 1u64)
    v2 = GSL::Stats.dir_nd(10, rng: rng1)
    v1.should eq v2
  end

  it "dir_nd reuses cache array when given" do
    v1 = GSL::Stats.dir_nd(10)
    old = v1.dup
    v2 = GSL::Stats.dir_nd(10, cache: v1)
    v1.should_not eq old
    v2.should eq v1
  end
end
