module.exports = {

  SessionUser: function() {
    var self = this;

    self.wwid = '';
    self.first_name = '';
    self.last_name = '';
    self.is_admin = false;
    self.loggedIn = false;
  },

  CPU: function(serial_num, spec, mm, frequency, stepping, llc, cores,
    codename, cpu_class, external_name, architecture, user, checked_in, notes,
    scrapped, user_name, button_type, reserve_status, reservation_date) {
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
    self.scrapped = scrapped;
    self.user_name = user_name;
    self.button_type = button_type;
    self.reserve_status = reserve_status;
    self.reservation_date = reservation_date;
  },

  SSD: function(serial_num, manufacturer, model, capacity, user,
    checked_in, notes, scrapped, user_name, button_type, reserve_status,
    reservation_date) {
    var self = this;
    
    self.serial_num = serial_num;
    self.manufacturer = manufacturer;
    self.model = model;
    self.capacity = capacity;
    self.user = user;
    self.checked_in = checked_in;
    self.notes = notes;
    self.scrapped = scrapped;
    self.user_name = user_name;
    self.button_type = button_type;
    self.reserve_status = reserve_status;
    self.reservation_date = reservation_date;
  },

  Memory: function(serial_num, manufacturer, physical_size, memory_type,
    capacity, speed, ecc, ranks, user, checked_in, notes, scrapped, user_name,
    button_type, reserve_status, reservation_date) {
    var self = this;
    
    self.serial_num = serial_num;
    self.manufacturer = manufacturer;
    self.physical_size = physical_size;
    self.memory_type = memory_type;
    self.capacity = capacity;
    self.speed = speed;
    self.ecc = ecc;
    self.ranks = ranks;
    self.user = user;
    self.checked_in = checked_in;
    self.notes = notes;
    self.scrapped = scrapped;
    self.user_name = user_name;
    self.button_type = button_type;
    self.reserve_status = reserve_status;
    self.reservation_date = reservation_date;
  },

  Flash_Drive: function(serial_num, capacity, manufacturer, user, checked_in, notes,
    scrapped, user_name, button_type, reserve_status, reservation_date) {
    var self = this;
    
    self.serial_num = serial_num;
    self.capacity = capacity;
    self.manufacturer = manufacturer;
    self.user = user;
    self.checked_in = checked_in;
    self.notes = notes;
    self.scrapped = scrapped;
    self.user_name = user_name;
    self.button_type = button_type;
    self.reserve_status = reserve_status;
    self.reservation_date = reservation_date;    
  },

  Board: function(serial_num, fpga, bios, mac, fab, user, checked_in, notes, scrapped,
    user_name, reserve_status, reservation_date) {
    var self = this;

    self.serial_num = serial_num;
    self.fpga = fpga;
    self.bios = bios;
    self.mac = mac;
    self.fab = fab;
    self.user = user;
    self.checked_in = checked_in;
    self.notes = notes;
    self.scrapped = scrapped;
    self.user_name = user_name;
    self.button_type = button_type;
    self.reserve_status = reserve_status;
    self.reservation_date = reservation_date;
  }
}