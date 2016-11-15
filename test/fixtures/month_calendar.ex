defmodule EZCalendar.Fixtures.MonthCalendar do

  def calendar do
    %EZCalendar.MonthCalendar{
      dates: [
        [
          %{data: [%EZCalendar.Event{}], day: 30, month: 10, today?: true, trailing?: true, weekday: "Sunday", year: 2016},
          %{data: [], day: 31, month: 10, today?: false, trailing?: true, weekday: "Monday", year: 2016},
          %{data: [], day: 1, month: 11, today?: false, trailing?: false, weekday: "Tuesday", year: 2016},
          %{data: [], day: 2, month: 11, today?: false, trailing?: false, weekday: "Wednesday", year: 2016},
          %{data: [], day: 3, month: 11, today?: false, trailing?: false, weekday: "Thursday", year: 2016},
          %{data: [], day: 4, month: 11, today?: false, trailing?: false, weekday: "Friday", year: 2016},
          %{data: [], day: 5, month: 11, today?: false, trailing?: false, weekday: "Saturday", year: 2016}
        ],
        [
          %{data: [], day: 6, month: 11, today?: false, trailing?: false, weekday: "Sunday", year: 2016},
          %{data: [], day: 7, month: 11, today?: false, trailing?: false, weekday: "Monday", year: 2016},
          %{data: [], day: 8, month: 11, today?: false, trailing?: false, weekday: "Tuesday", year: 2016},
          %{data: [], day: 9, month: 11, today?: false, trailing?: false, weekday: "Wednesday", year: 2016},
          %{data: [], day: 10, month: 11, today?: false, trailing?: false, weekday: "Thursday", year: 2016},
          %{data: [], day: 11, month: 11, today?: false, trailing?: false, weekday: "Friday", year: 2016},
          %{data: [], day: 12, month: 11, today?: false, trailing?: false, weekday: "Saturday", year: 2016}
        ],
        [
          %{data: [], day: 13, month: 11, today?: false, trailing?: false, weekday: "Sunday", year: 2016},
          %{data: [], day: 14, month: 11, today?: false, trailing?: false, weekday: "Monday", year: 2016},
          %{data: [], day: 15, month: 11, today?: false, trailing?: false, weekday: "Tuesday", year: 2016},
          %{data: [], day: 16, month: 11, today?: false, trailing?: false, weekday: "Wednesday", year: 2016},
          %{data: [], day: 17, month: 11, today?: false, trailing?: false, weekday: "Thursday", year: 2016},
          %{data: [], day: 18, month: 11, today?: false, trailing?: false, weekday: "Friday", year: 2016},
          %{data: [], day: 19, month: 11, today?: false, trailing?: false, weekday: "Saturday", year: 2016}
        ],
        [
          %{data: [], day: 20, month: 11, today?: false, trailing?: false, weekday: "Sunday", year: 2016},
          %{data: [], day: 21, month: 11, today?: false, trailing?: false, weekday: "Monday", year: 2016},
          %{data: [], day: 22, month: 11, today?: false, trailing?: false, weekday: "Tuesday", year: 2016},
          %{data: [], day: 23, month: 11, today?: false, trailing?: false, weekday: "Wednesday", year: 2016},
          %{data: [], day: 24, month: 11, today?: false, trailing?: false, weekday: "Thursday", year: 2016},
          %{data: [], day: 25, month: 11, today?: false, trailing?: false, weekday: "Friday", year: 2016},
          %{data: [], day: 26, month: 11, today?: false, trailing?: false, weekday: "Saturday", year: 2016}
        ],
        [
          %{data: [], day: 27, month: 11, today?: false, trailing?: false, weekday: "Sunday", year: 2016},
          %{data: [], day: 28, month: 11, today?: false, trailing?: false, weekday: "Monday", year: 2016},
          %{data: [], day: 29, month: 11, today?: false, trailing?: false, weekday: "Tuesday", year: 2016},
          %{data: [], day: 30, month: 11, today?: false, trailing?: false, weekday: "Wednesday", year: 2016},
          %{data: [], day: 1, month: 12, today?: false, trailing?: true, weekday: "Thursday", year: 2016},
          %{data: [], day: 2, month: 12, today?: false, trailing?: true, weekday: "Friday", year: 2016},
          %{data: [], day: 3, month: 12, today?: false, trailing?: true, weekday: "Saturday", year: 2016}
        ]
      ], 
      next: %{day: 1, month: 12, year: 2016},
      params: %{day: 1, month: 11, year: 2016},
      prev: %{day: 1, month: 10, year: 2016}, 
      title: "November 2016"
    }    
  end

  def html do
    """
    <table class="ez-calendar">\
    <tr class="weekdays">\
    <td>Sunday</td>\
    <td>Monday</td>\
    <td>Tuesday</td>\
    <td>Wednesday</td>\
    <td>Thursday</td>\
    <td>Friday</td>\
    <td>Saturday</td>\
    </tr>\
    <tr>\
    <td class="today trailing day sunday">\
    <div class="date">30</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>Event Content</div>\
    </div>\
    </td>\
    <td class="trailing day monday">\
    <div class="date">31</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day tuesday">\
    <div class="date">1</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day wednesday">\
    <div class="date">2</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day thursday">\
    <div class="date">3</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day friday">\
    <div class="date">4</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day saturday">\
    <div class="date">5</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    </tr>\
    <tr>\
    <td class="day sunday">\
    <div class="date">6</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day monday">\
    <div class="date">7</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day tuesday">\
    <div class="date">8</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day wednesday">\
    <div class="date">9</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day thursday">\
    <div class="date">10</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day friday">\
    <div class="date">11</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day saturday">\
    <div class="date">12</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    </tr>\
    <tr>\
    <td class="day sunday">\
    <div class="date">13</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day monday">\
    <div class="date">14</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day tuesday">\
    <div class="date">15</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day wednesday">\
    <div class="date">16</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day thursday">\
    <div class="date">17</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day friday">\
    <div class="date">18</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day saturday">\
    <div class="date">19</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    </tr>\
    <tr>\
    <td class="day sunday">\
    <div class="date">20</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day monday">\
    <div class="date">21</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day tuesday">\
    <div class="date">22</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day wednesday">\
    <div class="date">23</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day thursday">\
    <div class="date">24</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day friday">\
    <div class="date">25</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day saturday">\
    <div class="date">26</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    </tr>\
    <tr>\
    <td class="day sunday">\
    <div class="date">27</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day monday">\
    <div class="date">28</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day tuesday">\
    <div class="date">29</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="day wednesday">\
    <div class="date">30</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="trailing day thursday">\
    <div class="date">1</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="trailing day friday">\
    <div class="date">2</div>\
    <div class="data">\
    <div>Date Content</div>\
    <div>\
    </div>\
    </div>\
    </td>\
    <td class="trailing day saturday">\
    <div class="date">3</div>\
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