module ApplicationHelper
  def button_classes(variant = :primary)
    base = "inline-flex items-center justify-center rounded-xl px-4 py-2 text-sm font-semibold shadow-sm transition active:scale-[0.98] focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2"

    case variant
    when :primary
      "#{base} bg-indigo-600 text-white hover:bg-indigo-500 focus-visible:outline-indigo-600"
    when :secondary
      "rounded-xl bg-white px-4 py-2 text-sm font-semibold text-slate-900 shadow-sm ring-1 ring-inset ring-slate-200 hover:bg-slate-50 transition active:scale-[0.98]"
    when :danger
      "rounded-xl bg-rose-600 text-white px-4 py-2 text-sm font-semibold hover:bg-rose-500 transition active:scale-[0.98]"
    else
      base
    end
  end
end
