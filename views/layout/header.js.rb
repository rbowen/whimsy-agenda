#
# Header: title on the left, dropdowns on the right
#
# Also keeps the window/tab title in sync with the header title

class Header < React
  def render
    _header.navbar.navbar_fixed_top class: @@item.color do
      _div.navbar_brand @@item.title

      _ul.nav.nav_pills.navbar_right do

        # pending count
        if Pending.count > 0
          _li.label.label_danger do
            _a Pending.count
          end
        end

        # 'info' dropdown
        #
        if @@item.attach
          _li.dropdown do
            _a.dropdown_toggle.nav! data_toggle: "dropdown" do
              _ 'info'
              _b.caret
            end

            _dl.dropdown_menu.dl_horizontal do
              _dt 'Attach'
              _dd @@item.attach

              if @@item.owner
                _dt 'Author'
                _dd @@item.owner
              end

              if @@item.shepherd
                _dt 'Shepherd'
                _dd @@item.shepherd
              end

              if @@item.approved and not @@item.approved.empty?
                _dt 'Approved'
                _dd @@item.approved.join(', ')
              end

              if @@item.roster or @@item.prior_reports or @@item.stats
                _dt 'Links'

                if @@item.roster
                  _dd { _a 'Roster', href: @@item.roster }
                end

                if @@item.prior_reports
                  _dd { _a 'Prior Reports', href: @@item.prior_reports }
                end

                if @@item.stats
                  _dd { _a 'Statistics', href: @@item.stats }
                end
              end
            end
          end
        end

        # 'navigation' dropdown
        #
        _li.dropdown do
          _a.dropdown_toggle.nav! data_toggle: "dropdown" do
            _ 'navigation'
            _b.caret
          end

          _ul.dropdown_menu do
            _li { _Link text: 'Agenda', href: '.' }

            Agenda.index.each do |item|
              _li { _Link text: item.index, href: item.href } if item.index
            end

            _li.divider

            _li { _Link text: 'Search', href: 'search' }
            _li { _Link text: 'Comments', href: 'comments' }
          end
        end

      end
    end
  end

  # set title on initial rendering
  def componentDidMount()
    self.componentDidUpdate()
  end

  # update title to match the item title whenever page changes
  def componentDidUpdate()
    title = ~'title'
    if title.textContent != @@item.title
      title.textContent = @@item.title
    end
  end
end
