defmodule EZCalendar.Fixtures.WeekCalendar do
  import EZCalendar.Event

  def calendar do
    %EZCalendar.WeekCalendar{
      dates: [
        %{
          data: [%EZCalendar.Event{}], 
          day: 30, 
          month: 10,
          today?: true, 
          weekday: "Sunday", 
          year: 2016
          },
        %{
          data: [], 
          day: 31, 
          month: 10, 
          today?: false, 
          weekday: "Monday", 
          year: 2016
        },
        %{
          data: [], 
          day: 1, 
          month: 11, 
          today?: false, 
          weekday: "Tuesday", 
          year: 2016
        },
        %{
          data: [], 
          day: 2, 
          month: 11, 
          today?: false, 
          weekday: "Wednesday",
          year: 2016
        },
        %{
          data: [], 
          day: 3, 
          month: 11, 
          today?: false, 
          weekday: "Thursday",
          year: 2016
        },
        %{
          data: [], 
          day: 4, 
          month: 11, 
          today?: false, 
          weekday: "Friday", 
          year: 2016
        },
        %{
          data: [], 
          day: 5, 
          month: 11, 
          today?: false, 
          weekday: "Saturday",
          year: 2016
        }
      ], 
      next: %{day: 8, month: 11, year: 2016},
      params: %{day: 1, month: 11, year: 2016},
      prev: %{day: 25, month: 10, year: 2016}, 
      title: "30 Oct 2016 - 05 Nov 2016"
    } 
  end

  def html do
    """
    <table class="ez-calendar">\
    <tr>\
    <td>Sunday</td>\
    <td>Monday</td>\
    <td>Tuesday</td>\
    <td>Wednesday</td>\
    <td>Thursday</td>\
    <td>Friday</td>\
    <td>Saturday</td>\
    </tr>\
    <td class="today day">\
    <div class="date">30</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>Event Content</div>\
    </div>\
    </td>\
    <td class="day">\
    <div class="date">31</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div></div>\
    </div>\
    </td>\
    <td class="day">\
    <div class="date">1</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day">\
    <div class="date">2</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day">\
    <div class="date">3</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day">\
    <div class="date">4</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day">\
    <div class="date">5</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    </table>\
    """    
  end
end