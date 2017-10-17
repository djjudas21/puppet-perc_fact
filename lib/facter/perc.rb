Facter.add(:perc) do
	confine :manufacturer => 'Dell Inc.'
	confine { File.file?('/opt/dell/srvadmin/bin/omreport') }
	setcode do
		# Split output into lines
		lines = %x{/opt/dell/srvadmin/bin/omreport storage vdisk -fmt ssv | grep ';'}.lines

		# Sample output
		# [jg4461@db3 ~]$ omreport storage vdisk -fmt ssv | grep ';'
		# ID;Status;Name;State;Hot Spare Policy violated;Encrypted;Layout;Size;T10 Protection Information Status;Associated Fluid Cache State ;Device Name;Bus Protocol;Media;Read Policy;Write Policy;Cache Policy;Stripe Element Size;Disk Cache Policy
		# 0;Ok;Virtual Disk 0;Ready;Not Assigned;No;RAID-1;465.25 GB (499558383616 bytes);No;Not Applicable;/dev/sda;SATA;HDD;Adaptive Read Ahead;Write Back;Not Applicable;64 KB;Enabled
		# 1;Ok;Virtual Disk 1;Ready;Not Assigned;No;RAID-10;1,116.75 GB (1199101181952 bytes);No;Not Applicable;/dev/sdb;SAS;HDD;Adaptive Read Ahead;Write Back;Not Applicable;64 KB;Disabled

		# Grab first row which contains semicolon-separated headings and split them up
		headings = lines.delete_at(0).chomp.split(';')

		# Create new hash that will contain the output
		output = Hash.new

		# Split multiline output into lines
		lines.each do |line|

			# Split each line at semicolons
			# For each line of output find the device name
			values = line.chomp.split(';')
			dev = values[10]

			# Create nested hash
			output[dev] = Hash.new

			# For each value in the array, pair it with a heading and stuff it into the hash
			values.each_with_index do |val, i|
				# Take spaces out of keys from head row
				output[dev][headings[i].downcase.tr(" ", "_")] = val
			end
		end

	output
	end
end
