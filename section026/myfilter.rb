f = Apache::Filter.new

data = f.flatten
Apache.errlogger Apache::APLOG_NOTICE, "Filtered data size #{data.size}"

f.cleanup
f.insert_tail data

f.insert_head "<html><h1>Filter Sample</h1>\n"

f.insert_tail "<address>admin: h.nakamura0903@gmail.com</address></html>\n"

f.insert_eos