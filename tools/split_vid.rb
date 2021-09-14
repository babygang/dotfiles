# frozen_string_literal: true

class SplitVidTool
  def initialize(vid_name, split_sec)
    @vid_name = vid_name
    @split_sec = (split_sec || 3600).to_i

    @extname = File.extname(@vid_name)
    @basename = File.basename(@vid_name).gsub(/#{@extname}$/, '')

    set_playback_sec
  end

  def run
    return if @playback_sec < @split_sec

    split_num = (@playback_sec / @split_sec) + 1
    split_num.times do |i|
      start_sec = @split_sec * i
      end_sec = @split_sec * ( i + 1 )

      `ffmpeg -y -ss #{start_sec} -to #{end_sec} -i "#{@vid_name}" -c copy #{@basename}_#{i + 1}#{@extname}`
    end
  end

  private

  def set_playback_sec
    res = `ffprobe "#{@vid_name}" -hide_banner -show_entries format=duration -v quiet`

    prefix = 'duration='
    @playback_sec = res.lines.find{ |l| l.start_with?(prefix) }.gsub(prefix, '').to_i
  end
end

SplitVidTool.new(ARGV[0], ARGV[1]).run
