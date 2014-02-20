class ExtractInfo
  PATTERNS = [
    # The Wire - s01e01 - The Target
    # Seinfeld - s03e15-e16 - The Boyfriend
    %r{
      (?:(?<series>.*)(\s|\.))?
      s(?<season>[\d]{1,2})     # sXX or SXX
      e(?<episode>[\d]{1,2})    # eXX or EXX
    }xi,

    # 101.mp4
    # The Wire - 101.mp4
    # The Wire - 101 - Stuff.mp4
    # Seinfeld - 315-316 - The Boyfriend.mp4
    %r{
      ^(?:.*[\s\.\/]|)          # Either some amount of junk - like a title - followed by a space, period or slash OR absolutely nothing
      (?<season>\d)             # One-digit season number
      (?<episode>[\d]{2})       # Two-digit episode number
      (?:-\k<season>[\d]{2})?   # An optional second episode of the same season, i.e., 305-306
      (?:\s.+|\.\w{1,5}$)       # Either match a space and some more info, or a file extension at the very end
    }x,

    # community.308.hdtv-lol
    # the.west.wing.1x01.pilot.avi
    %r{
      (?<series>.*)\.           # Leading period
      (?<season>\d{1,2})        # One- or two-digit season number
      (?:x|)                    # 'x' or nothing (e.g., 1x04, or 104)
      (?<episode>[\d]{2})       # Two-digit episode number
      (?:\.|-).*                # Trailing period or hyphen
    }x,

    # 4x01 Box Cutter
    %r{
      ^(?:.*[\s\.\/]|)          # Either some amount of junk - like a title - followed by a space, period or slash OR absolutely nothing
      (?<season>\d)             # One-digit season number
      x
      (?<episode>[\d]{2})       # Two-digit episode number
      (?:\s.+|\.\w{1,5}$)       # Either match a space and some more info, or a file extension at the very end
    }x,

    # some.show.0104.avi
    %r{
      (?<series>.*)\.
      0(?<season>\d)
      (?<episode>[\d]{2})
      .*
   }x
  ]

  def self.extract(subject)
    PATTERNS.each do |re|
      return $~ if subject.match(re)
    end

    return {'series' => nil, 'season' => nil, 'episode' => nil}
  end
end

if __FILE__ == $0
  require 'minitest/autorun'

  class ExtractInfoTest < MiniTest::Unit::TestCase
    def check(subject, season, episode)
      match = ExtractInfo.extract(subject)

      assert_equal season.to_i,  match['season'].to_i
      assert_equal episode.to_i, match['episode'].to_i
    end

    def test_series
      match = ExtractInfo.extract('the.wire.s04e05.mp4')
      assert_equal 'the.wire', match['series']

      match = ExtractInfo.extract('community.308.hdtv-lol.mp4')
      assert_equal 'community', match['series']

      match = ExtractInfo.extract('curb.your.enthusiasm.403-med.avi')
      assert_equal 'curb.your.enthusiasm', match['series']

      match = ExtractInfo.extract('the.west.wing.1x01.pilot.avi')
      assert_equal 'the.west.wing', match['series']

      match = ExtractInfo.extract('ink.master.0102-yestv.avi')
      assert_equal 'ink.master', match['series']

      match = ExtractInfo.extract('the.amazing.race.2208.hdtv-lo.mp4')
      assert_equal 'the.amazing.race', match['series']
    end

    def test_sXXeYY_format
      check("the.wire.s04e05.mp4", 4, 5)
    end

    def test_SXXEYY_format
      check("the.wire.S04E05.mp4", 4, 5)
    end

    def test_sXXeYY_eZZ_format
      check("seinfeld.s03e15-e16.mp4", 3, 15)
    end

    def test_sXXeYY_without_series_format
      check("s03e15.mp4", 3, 15)
    end

    def test_XYY_format
      check("the wire - 203 - title.mp4", 2, 3)
    end

    def test_XYY_XZZ_format
      check("seinfeld - 315-316 - title.mp4", 3, 15)
    end

    def test_XYY_format_without_show_or_title
      check("203.mp4", 2, 3)
    end

    def test_XYY_format_without_title
      check("the wire - 203.mp4", 2, 3)
      check("the.wire.203.mp4", 2, 3)
      check("the.simpsons.1503.avi", 15, 3)
    end

    def test_XYY_scene_format
      check("community.308.hdtv-lol.avi", 3, 8)
    end

    def test_0XYY_format
      check("ink.master.0102-yestv.avi", 1, 2)
    end

    def test_ignores_year
      check("archer.2009.101.avi", 1, 1)
    end

    def test_SxEE_format
      check("4x01 Box Cutter.avi", 4, 1)
    end
  end
end
