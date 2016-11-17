defmodule EZCalendar.Fixtures.BiweeklyCalendar do

  def calendar do
    %EZCalendar.BiweeklyCalendar{
      dates: [
        [
          %{data: [%EZCalendar.Event{}], day: 4, month: 1, today?: true, weekday: "Monday", year: 2016},
          %{data: [], day: 5, month: 1, today?: false, weekday: "Tuesday", year: 2016},
          %{data: [], day: 6, month: 1, today?: false, weekday: "Wednesday", year: 2016},
          %{data: [], day: 7, month: 1, today?: false, weekday: "Thursday", year: 2016},
          %{data: [], day: 8, month: 1, today?: false, weekday: "Friday", year: 2016},
          %{data: [], day: 9, month: 1, today?: false, weekday: "Saturday", year: 2016},
          %{data: [], day: 10, month: 1, today?: false, weekday: "Sunday", year: 2016}
        ],
        [
          %{data: [], day: 11, month: 1, today?: false, weekday: "Monday", year: 2016},
          %{data: [], day: 12, month: 1, today?: false, weekday: "Tuesday", year: 2016},
          %{data: [], day: 13, month: 1, today?: false, weekday: "Wednesday", year: 2016},
          %{data: [], day: 14, month: 1, today?: false, weekday: "Thursday", year: 2016},
          %{data: [], day: 15, month: 1, today?: false, weekday: "Friday", year: 2016},
          %{data: [], day: 16, month: 1, today?: false, weekday: "Saturday", year: 2016},
          %{data: [], day: 17, month: 1, today?: false, weekday: "Sunday", year: 2016}
        ]
      ],
      next: %{day: 18, month: 1, year: 2016},
      params: %{day: 4, month: 1, year: 2016},
      prev: %{day: 21, month: 12, year: 2015}, 
      title: "04 Jan 2016 - 17 Jan 2016"
    }
  end

  def html do
    """
    <table class="ez-calendar biweekly-calendar">\
    <tr class="weekdays">\
    <td>Monday</td>\
    <td>Tuesday</td>\
    <td>Wednesday</td>\
    <td>Thursday</td>\
    <td>Friday</td>\
    <td>Saturday</td>\
    <td>Sunday</td>\
    </tr>\
    <tr>\
    <td class="today monday day">\
    <div class="date">4</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>Event Content</div>\
    </div>\
    </td>\
    <td class="tuesday day">\
    <div class="date">5</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="wednesday day">\
    <div class="date">6</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="thursday day">\
    <div class="date">7</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="friday day">\
    <div class="date">8</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="saturday day">\
    <div class="date">9</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="sunday day">\
    <div class="date">10</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    </tr>\
    <tr>\
    <td class="monday day">\
    <div class="date">11</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="tuesday day">\
    <div class="date">12</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="wednesday day">\
    <div class="date">13</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="thursday day">\
    <div class="date">14</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="friday day">\
    <div class="date">15</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="saturday day">\
    <div class="date">16</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="sunday day">\
    <div class="date">17</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    </tr>\
    </table>\
    """
  end
  
end