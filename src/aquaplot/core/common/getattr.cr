macro getattr(fns)
  def getattr(attr_name)
    {% for fn in fns %}
      if {{ fn.id.stringify }} == attr_name
        return self.{{ fn.id }}
      end
    {% end %}
  end
end
