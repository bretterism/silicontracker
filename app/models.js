module.exports = {

	CPU: function(serial_num, spec, mm, frequency, stepping, llc, cores, codename, cpu_class, external_name, architecture, user, checked_in, notes) {
		var self = this;
		
		self.serial_num = serial_num;
		self.spec = spec;
		self.mm = mm;
		self.frequency = frequency;
		self.stepping = stepping;
		self.llc = llc;
		self.cores = cores;
		self.codename = codename;
		self.cpu_class = cpu_class;
		self.external_name = external_name;
		self.architecture = architecture;
		self.user = user;
		self.checked_in = checked_in;
		self.notes = notes;
	},

	SSD: function(serial_num, manufacturer, model, capacity, user, checked_in, notes) {
		var self = this;
		
		self.serial_num = serial_num;
		self.manufacturer = manufacturer;
		self.model = model;
		self.capacity = capacity;
		self.user = user;
		self.checked_in = checked_in;
		self.notes = notes;
	},

	Memory: function(serial_num, manufacturer, physical_size, memory_type, capacity, speed, ecc, rank, user, checked_in, notes) {
		var self = this;
		
		self.serial_num = serial_num;
		self.manufacturer = manufacturer;
		self.physical_size = physical_size;
		self.memory_type = memory_type;
		self.capacity = capacity;
		self.speed = speed;
		self.ecc = ecc;
		self.rank = rank;
		self.user = user;
		self.checked_in = checked_in;
		self.notes = notes;
	},

		Flash_Drive: function(serial_num, manufacturer, capacity, user, checked_in, notes) {
		var self = this;
		
		self.serial_num = serial_num;
		self.manufacturer = manufacturer;
		self.capacity = capacity;
		self.user = user;
		self.checked_in = checked_in;
		self.notes = notes;
	}
}