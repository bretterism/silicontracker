/* Getters for the web interface */

var rootdir = process.env.ROOT_DIR;
var models = require(rootdir + '/app/models');

function isLoggedIn(session) {
	if (session.hasOwnProperty('web')) {
		if (session.web.hasOwnProperty('loggedIn')) {
			if (session.web.loggedIn === true) {
				return true;
			}
		}
	}
	return false;
}

module.exports = function(app, pool) {

  /* 
   * This portion of /data/XXX is returning a json object
   * with data on the specific item.
   * ex: /data/cpu will call the stored procedure 'get_cpu()'
   * and get all the rows from the Processor table.
   */

  app.get('/data/stats', function(req, res) {
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query("CALL get_status();", function(error, results, fields) {
        if(error) {
          throw error;
        }

        jsonToSend.num_scrapped =  results[0][0].num_scrapped;
        jsonToSend.num_active = results[0][0].num_active;
        jsonToSend.num_total = jsonToSend.num_scrapped + jsonToSend.num_active;
        if (isLoggedIn(req.session) && req.session.web.first_name) {
          jsonToSend.first_name = req.session.web.first_name;
        }
        if (isLoggedIn(req.session) && req.session.web.last_name) {
          jsonToSend.last_name = req.session.web.last_name;
        }
        if (isLoggedIn(req.session) && req.session.web.wwid) {
          jsonToSend.is_admin = req.session.web.is_admin;
          conn.query("CALL get_reserve_status('"+req.session.web.wwid+"');",
            function(error, results, fields) {
              if(error) {
                throw error;
              }
              conn.release();
              jsonToSend.num_reserve = results[0][0].num_reserve;
              res.json(jsonToSend);
            });
        } else {
          jsonToSend.is_admin = 0;
          conn.release();
          res.json(jsonToSend);
        }
      });
    });
  });

  app.get('/data/cpu', function(req, res) {
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query("CALL get_cpu();", function(error, results, fields){
        if(error) {
          throw error;
        }
        conn.release();

        // We send admin stats for the table because there are admin-specific
        // elements to the table.
        if (isLoggedIn(req.session) && req.session.web.wwid) {
          jsonToSend.is_admin = req.session.web.is_admin;
        } else {
          jsonToSend.is_admin = 0;
        }
        var a = [];
        var user_name = null;
        for (var i in results[0]) {
          if(results[0][i].first_name == undefined || results[0][i].last_name == undefined) {
            user_name = null;
          } else {
            user_name = results[0][i].first_name + " " + results[0][i].last_name;
          }
          a.push(new models.CPU(results[0][i].serial_num, results[0][i].spec,
            results[0][i].mm, results[0][i].frequency, results[0][i].stepping,
            results[0][i].llc, results[0][i].cores, results[0][i].codename,
            results[0][i].cpu_class, results[0][i].external_name, results[0][i].architecture,
            results[0][i].user, results[0][i].checked_in, results[0][i].notes,
            results[0][i].scrapped, user_name));
        }
        jsonToSend.items = a;
        res.json(jsonToSend);
      });
    });
  });

  app.get('/data/ssd', function(req, res) {
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query("CALL get_ssd();", function(error, results, fields){
        if(error) {
          throw error;
        }
        conn.release();

        // We send admin stats for the table because there are admin-specific
        // elements to the table.
        if (isLoggedIn(req.session) && req.session.web.wwid) {
          jsonToSend.is_admin = req.session.web.is_admin;
        } else {
          jsonToSend.is_admin = 0;
        }
        var a = [];
        var user_name = null;
        for (var i in results[0]) {
          if(results[0][i].first_name == undefined || results[0][i].last_name == undefined) {
            user_name = null;
          } else {
            user_name = results[0][i].first_name + " " + results[0][i].last_name;
          }
          a.push(new models.SSD(results[0][i].serial_num, results[0][i].manufacturer, 
            results[0][i].model, results[0][i].capacity, results[0][i].user,
            results[0][i].checked_in, results[0][i].notes, results[0][i].scrapped, user_name));
        }
        jsonToSend.items = a;
        res.json(jsonToSend);
      });
    });
  });

  app.get('/data/memory', function(req, res) {
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query("CALL get_memory();", function(error, results, fields){
        if(error) {
          throw error;
        }
        conn.release();

        // We send admin stats for the table because there are admin-specific
        // elements to the table.
        if (isLoggedIn(req.session) && req.session.web.wwid) {
          jsonToSend.is_admin = req.session.web.is_admin;
        } else {
          jsonToSend.is_admin = 0;
        }
        var a = [];
        var user_name = null;
        for (var i in results[0]) {
          if(results[0][i].first_name == undefined || results[0][i].last_name == undefined) {
            user_name = null;
          } else {
            user_name = results[0][i].first_name + " " + results[0][i].last_name;
          }
          a.push(new models.Memory(results[0][i].serial_num, results[0][i].manufacturer,
            results[0][i].physical_size, results[0][i].memory_type, results[0][i].capacity, 
            results[0][i].speed, results[0][i].ecc, results[0][i].ranks, results[0][i].user,
            results[0][i].checked_in, results[0][i].notes, results[0][i].scrapped, user_name));
        }
        jsonToSend.items = a;
        res.json(jsonToSend);
      });
    });
  });

  app.get('/data/flash', function(req, res) {
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query("CALL get_flash();", function(error, results, fields){
        if(error) {
          throw error;
        }
        conn.release();

        // We send admin stats for the table because there are admin-specific
        // elements to the table.
        if (isLoggedIn(req.session) && req.session.web.wwid) {
          jsonToSend.is_admin = req.session.web.is_admin;
        } else {
          jsonToSend.is_admin = 0;
        }
        var a = [];
        var user_name = null;
        for (var i in results[0]) {
          if(results[0][i].first_name == undefined || results[0][i].last_name == undefined) {
            user_name = null;
          } else {
            user_name = results[0][i].first_name + " " + results[0][i].last_name;
          }
          a.push(new models.Flash_Drive(results[0][i].serial_num, 
            results[0][i].capacity, results[0][i].manufacturer,
            results[0][i].user, results[0][i].checked_in, results[0][i].notes,
            results[0][i].scrapped, user_name));
        }
        jsonToSend.items = a;
        res.json(jsonToSend);
      });
    });
  });

  app.get('/data/board', function(req, res) {
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query("CALL get_board();", function(error, results, fields){
        if(error) {
          throw error;
        }
        conn.release();

        // We send admin stats for the table because there are admin-specific
        // elements to the table.
        if (isLoggedIn(req.session) && req.session.web.wwid) {
          jsonToSend.is_admin = req.session.web.is_admin;
        } else {
          jsonToSend.is_admin = 0;
        }
        var a = [];
        var user_name = null;
        for (var i in results[0]) {
          if(results[0][i].first_name == undefined || results[0][i].last_name == undefined) {
            user_name = null;
          } else {
            user_name = results[0][i].first_name + " " + results[0][i].last_name;
          }
          a.push(new models.Board(results[0][i].serial_num, results[0][i].fpga,
            results[0][i].bios, results[0][i].mac, results[0][i].fab,
            results[0][i].user, results[0][i].checked_in, results[0][i].notes,
            results[0][i].scrapped, user_name));
        }
        jsonToSend.items = a;
        res.json(jsonToSend);
      });
    });
  });

  app.get('/data/reserve/cpu', function(req, res) {
    var jsonToSend = {};
    var serial_num = [];
    var spec = [];
    var mm = [];
    var frequency = [];
    var stepping = [];
    var llc = [];
    var cores = [];
    var codename = [];
    var cpu_class = [];
    var external_name = [];
    var architecture = [];
    var user = [];
    var checked_in = [];
    var notes = [];
    var scrapped = [];
    var reservation_date;
    var reserve_status;
    var button_class;
    var j = 0;
    var user_name = [];
    pool.getConnection(function(err, conn) {
      conn.query("CALL get_cpu_from_checkout('"+req.session.web.wwid+"');", function(error, results, fields){
        if(error) {
          throw error;
        }

        // We send admin stats for the table because there are admin-specific
        // elements to the table.
        if (isLoggedIn(req.session) && req.session.web.wwid) {
          jsonToSend.is_admin = req.session.web.is_admin;
        } else {
          jsonToSend.is_admin = 0;
        }
        var a = [];
        var total = results[0].length;
        for (var i in results[0]) {
          serial_num[i] = results[0][i].serial_num;
          spec[i] = results[0][i].spec;
          mm[i] = results[0][i].mm;
          frequency[i] = results[0][i].frequency;
          stepping[i] = results[0][i].stepping;
          llc[i] = results[0][i].llc;
          cores[i] = results[0][i].cores;
          codename[i] = results[0][i].codename;
          cpu_class[i] = results[0][i].cpu_class;
          external_name[i] = results[0][i].external_name;
          architecture[i] = results[0][i].architecture;
          user[i] = results[0][i].user;
          checked_in[i] = results[0][i].checked_in;
          notes[i] = results[0][i].notes;
          scrapped[i] = results[0][i].scrapped;
          if(results[0][i].first_name == undefined || results[0][i].last_name == undefined) {
            user_name[i] = null;
          } else {
            user_name[i] = results[0][i].first_name + " " + results[0][i].last_name;
          }
          conn.query("CALL check_checkout('"+ serial_num[i] +"','"+ req.session.web.wwid +"');",
            function(error, results, fields) {
              if(error) {
                throw error;
              }
              if(results[0].length > 0) {
                button_type = '<button class="btn btn-link"><i class="fa fa-lg fa-calendar-check-o"></i></button>';
                reserve_status = 1;
                reservation_date = results[0][0].reservation_date;
              } else {
                button_type = '<button class="btn btn-link"><i class="fa fa-lg fa-calendar"></i></button>';
                reserve_status = 0;
              }
              a.push(new models.CPU(serial_num[j], spec[j], mm[j], frequency[j], stepping[j],
                llc[j], cores[j], codename[j], cpu_class[j], external_name[j], architecture[j],
                user[j], checked_in[j], notes[j], scrapped[j], user_name[j], button_type, reserve_status, reservation_date));
              j++;
              if(j == total) {
                conn.release();
                jsonToSend.items = a;
                res.json(jsonToSend);
              }
            });
        }
        if(total === 0) {
          conn.release();
          jsonToSend.items = a;
          res.json(jsonToSend);
        }
      });
    });
  });

  app.get('/data/reserve/ssd', function(req, res) {
    var jsonToSend = {};
    var serial_num = [];
    var manufacturer = [];
    var model = [];
    var capacity = [];
    var user = [];
    var checked_in = [];
    var notes = [];
    var scrapped = [];
    var reservation_date;
    var reserve_status;
    var button_class;
    var j = 0;
    var user_name = [];
    pool.getConnection(function(err, conn) {
      conn.query("CALL get_ssd_from_checkout('"+req.session.web.wwid+"');", function(error, results, fields){
        if(error) {
          throw error;
        }

        // We send admin stats for the table because there are admin-specific
        // elements to the table.
        if (isLoggedIn(req.session) && req.session.web.wwid) {
          jsonToSend.is_admin = req.session.web.is_admin;
        } else {
          jsonToSend.is_admin = 0;
        }
        var a = [];
        var total = results[0].length;
        for (var i in results[0]) {
          serial_num[i] = results[0][i].serial_num;
          manufacturer[i] = results[0][i].manufacturer;
          model[i] = results[0][i].model;
          capacity[i] = results[0][i].capacity;
          user[i] = results[0][i].user;
          checked_in[i] = results[0][i].checked_in;
          notes[i] = results[0][i].notes;
          scrapped[i] = results[0][i].scrapped;
          if(results[0][i].first_name == undefined || results[0][i].last_name == undefined) {
            user_name[i] = null;
          } else {
            user_name[i] = results[0][i].first_name + " " + results[0][i].last_name;
          }
          conn.query("CALL check_checkout('"+ serial_num[i] +"','"+ req.session.web.wwid +"');",
            function(error, results, fields) {
              if(error) {
                throw error;
              }
              if(results[0].length > 0) {
                button_type = '<button class="btn btn-link"><i class="fa fa-lg fa-calendar-check-o"></i></button>';
                reserve_status = 1;
                reservation_date = results[0][0].reservation_date;
              } else {
                button_type = '<button class="btn btn-link"><i class="fa fa-lg fa-calendar"></i></button>';
                reserve_status = 0;
              }
              a.push(new models.SSD(serial_num[j], manufacturer[j], model[j], capacity[j], user[j],
                checked_in[j], notes[j], scrapped[j], user_name[j], button_type, reserve_status,
                reservation_date));
              j++;
              if(j == total) {
                conn.release();
                jsonToSend.items = a;
                res.json(jsonToSend);
              }
            });
        }
        if(total === 0) {
          conn.release();
          jsonToSend.items = a;
          res.json(jsonToSend);
        }
      });
    });
  });

  app.get('/data/reserve/memory', function(req, res) {
    var jsonToSend = {};
    var serial_num = [];
    var manufacturer = [];
    var physical_size = [];
    var memory_type = [];
    var capacity = [];
    var speed = [];
    var ecc = [];
    var ranks = [];
    var user = [];
    var checked_in = [];
    var notes = [];
    var scrapped = [];
    var reservation_date;
    var reserve_status;
    var button_class;
    var j = 0;
    var user_name = [];
    pool.getConnection(function(err, conn) {
      conn.query("CALL get_memory_from_checkout('"+req.session.web.wwid+"');", function(error, results, fields){
        if(error) {
          throw error;
        }

        // We send admin stats for the table because there are admin-specific
        // elements to the table.
        if (isLoggedIn(req.session) && req.session.web.wwid) {
          jsonToSend.is_admin = req.session.web.is_admin;
        } else {
          jsonToSend.is_admin = 0;
        }
        var a = [];
        var total = results[0].length;
        for (var i in results[0]) {
          serial_num[i] = results[0][i].serial_num;
          manufacturer[i] = results[0][i].manufacturer;
          physical_size[i] = results[0][i].physical_size;
          memory_type[i] = results[0][i].memory_type;
          capacity[i] = results[0][i].capacity;
          speed[i] = results[0][i].speed;
          ecc[i] = results[0][i].ecc;
          ranks[i] = results[0][i].ranks;
          user[i] = results[0][i].user;
          checked_in[i] = results[0][i].checked_in;
          notes[i] = results[0][i].notes;
          scrapped[i] = results[0][i].scrapped;
          if(results[0][i].first_name == undefined || results[0][i].last_name == undefined) {
            user_name[i] = null;
          } else {
            user_name[i] = results[0][i].first_name + " " + results[0][i].last_name;
          }
          conn.query("CALL check_checkout('"+ serial_num[i] +"','"+ req.session.web.wwid +"');",
            function(error, results, fields) {
              if(error) {
                throw error;
              }
              if(results[0].length > 0) {
                button_type = '<button class="btn btn-link"><i class="fa fa-lg fa-calendar-check-o"></i></button>';
                reserve_status = 1;
                reservation_date = results[0][0].reservation_date;
              } else {
                button_type = '<button class="btn btn-link"><i class="fa fa-lg fa-calendar"></i></button>';
                reserve_status = 0;
              }
              a.push(new models.Memory(serial_num[j], manufacturer[j], physical_size[j],
                memory_type[j], capacity[j], speed[j], ecc[j], ranks[j], user[j], checked_in[j],
                notes[j], scrapped[j], user_name[j], button_type, reserve_status, reservation_date));
              j++;
              if(j == total) {
                conn.release();
                jsonToSend.items = a;
                res.json(jsonToSend);
              }
            });
        }
        if(total === 0) {
          conn.release();
          jsonToSend.items = a;
          res.json(jsonToSend);
        }
      });
    });
  });

  app.get('/data/reserve/flash', function(req, res) {
    var jsonToSend = {};
    var serial_num = [];
    var capacity = [];
    var manufacturer = [];
    var user = [];
    var checked_in = [];
    var notes = [];
    var scrapped = [];
    var reservation_date;
    var reserve_status;
    var button_class;
    var j = 0;
    var user_name = [];
    pool.getConnection(function(err, conn) {
      conn.query("CALL get_flash_from_checkout('"+req.session.web.wwid+"');", function(error, results, fields){
        if(error) {
          throw error;
        }

        // We send admin stats for the table because there are admin-specific
        // elements to the table.
        if (isLoggedIn(req.session) && req.session.web.wwid) {
          jsonToSend.is_admin = req.session.web.is_admin;
        } else {
          jsonToSend.is_admin = 0;
        }
        var a = [];
        var total = results[0].length;
        for (var i in results[0]) {
          serial_num[i] = results[0][i].serial_num;
          capacity[i] = results[0][i].capacity;
          manufacturer[i] = results[0][i].manufacturer;
          user[i] = results[0][i].user;
          checked_in[i] = results[0][i].checked_in;
          notes[i] = results[0][i].notes;
          scrapped[i] = results[0][i].scrapped;
          if(results[0][i].first_name == undefined || results[0][i].last_name == undefined) {
            user_name[i] = null;
          } else {
            user_name[i] = results[0][i].first_name + " " + results[0][i].last_name;
          }
          conn.query("CALL check_checkout('"+ serial_num[i] +"','"+ req.session.web.wwid +"');",
            function(error, results, fields) {
              if(error) {
                throw error;
              }
              if(results[0].length > 0) {
                button_type = '<button class="btn btn-link"><i class="fa fa-lg fa-calendar-check-o"></i></button>';
                reserve_status = 1;
                reservation_date = results[0][0].reservation_date;
              } else {
                button_type = '<button class="btn btn-link"><i class="fa fa-lg fa-calendar"></i></button>';
                reserve_status = 0;
              }
              a.push(new models.Flash_Drive(serial_num[j], capacity[j], manufacturer[j], user[j],
                checked_in[j], notes[j], scrapped[j], user_name[j], button_type, reserve_status,
                reservation_date));
              j++;
              if(j == total) {
                conn.release();
                jsonToSend.items = a;
                res.json(jsonToSend);
              }
            });
        }
        if(total === 0) {
          conn.release();
          jsonToSend.items = a;
          res.json(jsonToSend);
        }
      });
    });
  });

  app.get('/data/reserve/board', function(req, res) {
    var jsonToSend = {};
    var serial_num = [];
    var fpga = [];
    var bios = [];
    var mac = [];
    var fab = [];
    var user = [];
    var checked_in = [];
    var notes = [];
    var scrapped = [];
    var reservation_date;
    var reserve_status;
    var button_class;
    var j = 0;
    var user_name = [];
    pool.getConnection(function(err, conn) {
      conn.query("CALL get_board_from_checkout('"+req.session.web.wwid+"');", function(error, results, fields){
        if(error) {
          throw error;
        }

        // We send admin stats for the table because there are admin-specific
        // elements to the table.
        if (isLoggedIn(req.session) && req.session.web.wwid) {
          jsonToSend.is_admin = req.session.web.is_admin;
        } else {
          jsonToSend.is_admin = 0;
        }
        var a = [];
        var total = results[0].length;
        for (var i in results[0]) {
          serial_num[i] = results[0][i].serial_num;
          fpga[i] = results[0][i].fgpa;
          bios[i] = results[0][i].bios;
          mac[i] = results[0][i].mac;
          fab[i] = results[0][i].fab;
          user[i] = results[0][i].user;
          checked_in[i] = results[0][i].checked_in;
          notes[i] = results[0][i].notes;
          scrapped[i] = results[0][i].scrapped;
          if(results[0][i].first_name == undefined || results[0][i].last_name == undefined) {
            user_name[i] = null;
          } else {
            user_name[i] = results[0][i].first_name + " " + results[0][i].last_name;
          }
          conn.query("CALL check_checkout('"+ serial_num[i] +"','"+ req.session.web.wwid +"');",
            function(error, results, fields) {
              if(error) {
                throw error;
              }
              if(results[0].length > 0) {
                button_type = '<button class="btn btn-link"><i class="fa fa-lg fa-calendar-check-o"></i></button>';
                reserve_status = 1;
                reservation_date = results[0][0].reservation_date;
              } else {
                button_type = '<button class="btn btn-link"><i class="fa fa-lg fa-calendar"></i></button>';
                reserve_status = 0;
              }
              a.push(new models.Board(serial_num[j], fpga[j], bios[j], mac[j], fab[j], user[j],
                checked_in[j], notes[j], scrapped[j], user_name[j], button_type, reserve_status,
                reservation_date));
              j++;
              if(j == total) {
                conn.release();
                jsonToSend.items = a;
                res.json(jsonToSend);
              }
            });
        }
        if(total === 0) {
          conn.release();
          jsonToSend.items = a;
          res.json(jsonToSend);
        }
      });
    });
  });

  /* Getters for json data on items in the scrap table */
  app.get('/data/scrap/cpu/:serial', function(req, res) {
    var serial = req.params.serial;
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query('CALL get_cpu_by_serial("'+ serial +'");',
        function(error, results, fields){
          if(error) {
            throw error;
          }
          conn.release();

          if (process.env.ENV == 'dev' && results[0].length > 0) {
            console.log(results[0][0].serial_num);
          }
          if(results[0].length > 0) {
            jsonToSend = new models.CPU(results[0][0].serial_num, results[0][0].spec,
              results[0][0].mm, results[0][0].frequency, results[0][0].stepping,
              results[0][0].llc, results[0][0].cores, results[0][0].codename,
              results[0][0].cpu_class, results[0][0].external_name, results[0][0].architecture,
              results[0][0].user, results[0][0].checked_in, results[0][0].notes,
              results[0][0].scrapped);
          } else {
            jsonToSend = [];
          }
          res.json(jsonToSend);
        });
    });
  });

  app.get('/data/scrap/ssd/:serial', function(req, res) {
    var serial = req.params.serial;
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query('CALL get_ssd_by_serial("'+ serial +'");',
        function(error, results, fields){
          if(error) {
            throw error;
          }
          conn.release();

          if (process.env.ENV == 'dev' && results[0].length > 0) {
            console.log(results[0][0].serial_num);
          }
          if(results[0].length > 0) {
            jsonToSend = new models.SSD(results[0][0].serial_num, results[0][0].manufacturer, 
            results[0][0].model, results[0][0].capacity, results[0][0].user,
            results[0][0].checked_in, results[0][0].notes, results[0][0].scrapped);
          } else {
            jsonToSend = [];
          }
          res.json(jsonToSend);
        });
    });
  });

  app.get('/data/scrap/memory/:serial', function(req, res) {
    var serial = req.params.serial;
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query('CALL get_memory_by_serial("'+ serial +'");',
        function(error, results, fields){
          if(error) {
            throw error;
          }
          conn.release();

          if (process.env.ENV == 'dev' && results[0].length > 0) {
            console.log(results[0][0].serial_num);
          }
          if(results[0].length > 0) {
            jsonToSend = new models.Memory(results[0][0].serial_num, results[0][0].manufacturer,
            results[0][0].physical_size, results[0][0].memory_type, results[0][0].capacity, 
            results[0][0].speed, results[0][0].ecc, results[0][0].ranks, results[0][0].user,
            results[0][0].checked_in, results[0][0].notes, results[0][0].scrapped);
          } else {
            jsonToSend = [];
          }
          res.json(jsonToSend);
        });
    });
  });

  app.get('/data/scrap/flash/:serial', function(req, res) {
    var serial = req.params.serial;
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query('CALL get_flash_by_serial("'+ serial +'");',
        function(error, results, fields){
          if(error) {
            throw error;
          }
          conn.release();

          if (process.env.ENV == 'dev' && results[0].length > 0) {
            console.log(results[0][0].serial_num);
          }
          if(results[0].length > 0) {
            jsonToSend = new models.Flash_Drive(results[0][0].serial_num, 
              results[0][0].capacity, results[0][0].manufacturer, 
              results[0][0].user, results[0][0].checked_in, results[0][0].notes,
              results[0][0].scrapped);
          } else {
            jsonToSend = [];
          }
          res.json(jsonToSend);
        });
    });
  });

  app.get('/data/scrap/board/:serial', function(req, res) {
    var serial = req.params.serial;
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query('CALL get_board_by_serial("'+ serial +'");',
        function(error, results, fields){
          if(error) {
            throw error;
          }
          conn.release();

          if (process.env.ENV == 'dev' && results[0].length > 0) {
            console.log(results[0][0].serial_num);
          }
          if(results[0].length > 0) {
            jsonToSend = new models.Board(results[0][0].serial_num, results[0][0].fpga,
            results[0][0].bios, results[0][0].mac, results[0][0].fab,
            results[0][0].user, results[0][0].checked_in, results[0][0].notes,
            results[0][0].scrapped);
          } else {
            jsonToSend = [];
          }
          res.json(jsonToSend);
        });
    });
  });

  app.get('/data/scrap/cpu', function(req, res) {
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query('CALL get_scrapped_cpu();',
        function(error, results, fields) {
          if(error) {
            throw error;
          }
          conn.release();
          if (isLoggedIn(req.session) && req.session.web.wwid) {
            jsonToSend.is_admin = req.session.web.is_admin;
          } else {
            jsonToSend.is_admin = 0;
          }
          if(results[0].length > 0) {
            var a = [];
            for (var i in results[0]) {
              a.push(new models.CPU(results[0][i].serial_num, results[0][i].spec,
                results[0][i].mm, results[0][i].frequency, results[0][i].stepping,
                results[0][i].llc, results[0][i].cores, results[0][i].codename,
                results[0][i].cpu_class, results[0][i].external_name, results[0][i].architecture,
                results[0][i].user, results[0][i].checked_in, results[0][i].notes,
                results[0][i].scrapped));
            }
            jsonToSend.items = a;
          }
          res.json(jsonToSend);
        });
    });
  });

  app.get('/data/scrap/ssd', function(req, res) {
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query('CALL get_scrapped_ssd();',
        function(error, results, fields) {
          if(error) {
            throw error;
          }
          conn.release();
          if (isLoggedIn(req.session) && req.session.web.wwid) {
            jsonToSend.is_admin = req.session.web.is_admin;
          } else {
            jsonToSend.is_admin = 0;
          }
          if(results[0].length > 0) {
            var a = [];
            for (var i in results[0]) {
              a.push(new models.SSD(results[0][i].serial_num, results[0][i].manufacturer, 
                results[0][i].model, results[0][i].capacity, results[0][i].user,
                results[0][i].checked_in, results[0][i].notes, results[0][i].scrapped));
            }
            jsonToSend.items = a;
          }
          res.json(jsonToSend);
        });
    });
  });

  app.get('/data/scrap/memory', function(req, res) {
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query('CALL get_scrapped_memory();',
        function(error, results, fields) {
          if(error) {
            throw error;
          }
          conn.release();
          if (isLoggedIn(req.session) && req.session.web.wwid) {
            jsonToSend.is_admin = req.session.web.is_admin;
          } else {
            jsonToSend.is_admin = 0;
          }
          if(results[0].length > 0) {
            var a = [];
            for (var i in results[0]) {
              a.push(new models.Memory(results[0][i].serial_num, results[0][i].manufacturer,
                results[0][i].physical_size, results[0][i].memory_type, results[0][i].capacity, 
                results[0][i].speed, results[0][i].ecc, results[0][i].ranks, results[0][i].user,
                results[0][i].checked_in, results[0][i].notes, results[0][i].scrapped));
            }
            jsonToSend.items = a;
          }
          res.json(jsonToSend);
        });
    });
  });

  app.get('/data/scrap/flash', function(req, res) {
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query('CALL get_scrapped_flash();',
        function(error, results, fields) {
          if(error) {
            throw error;
          }
          conn.release();
          if (isLoggedIn(req.session) && req.session.web.wwid) {
            jsonToSend.is_admin = req.session.web.is_admin;
          } else {
            jsonToSend.is_admin = 0;
          }
          if(results[0].length > 0) {
            var a = [];
            for (var i in results[0]) {
              a.push(new models.Flash_Drive(results[0][i].serial_num, 
                results[0][i].capacity, results[0][i].manufacturer,
                results[0][i].user, results[0][i].checked_in, results[0][i].notes,
                results[0][i].scrapped));
            }
            jsonToSend.items = a;
          }
          res.json(jsonToSend);
        });
    });
  });

  app.get('/data/scrap/board', function(req, res) {
    var jsonToSend = {};
    pool.getConnection(function(err, conn) {
      conn.query('CALL get_scrapped_board();',
        function(error, results, fields) {
          if(error) {
            throw error;
          }
          conn.release();
          if (isLoggedIn(req.session) && req.session.web.wwid) {
            jsonToSend.is_admin = req.session.web.is_admin;
          } else {
            jsonToSend.is_admin = 0;
          }
          if(results[0].length > 0) {
            var a = [];
            for (var i in results[0]) {
              a.push(new models.Board(results[0][i].serial_num, results[0][i].fpga,
                results[0][i].bios, results[0][i].mac, results[0][i].fab,
                results[0][i].user, results[0][i].checked_in, results[0][i].notes,
                results[0][i].scrapped));
            }
            jsonToSend.items = a;
          }
          res.json(jsonToSend);
        });
    });
  });

  /* Gets all the different column names that are dropdown menus. */
  app.get('/dd/keys', function(req, res) {
    pool.getConnection(function(err, conn) {
      conn.query('CALL get_dropdown_keys()',
        function(error, results, fields) {
          if (error) {
            throw error;
          }
          conn.release();

          res.send(results[0]);
        });
    });
  });

  /* Gets the dropdown menu items when someone needs to add a new item. */
  app.get('/dd/values/:attr', function(req, res) {
    var attr = req.params.attr;
    pool.getConnection(function(err, conn) {
      conn.query('CALL get_dropdown(\''+attr+'\')',
        function(error, results, fields){
          if(error) {
            throw error;
          }
          conn.release();

          res.send(results[0]);
        });
    });
  });
};