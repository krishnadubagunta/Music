var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt');

mongoose.models = {};
mongoose.modelSchemas = {};

var userSchema = new Schema({
	firstName : {
		type : String,
		unique : false,
		required : true
	},
	lastName : {
		type : String,
		unique : false,
		required : true	
	},
	email : {
		type : String,
		unique : true,
		required : true
	},
	password : {
		type : String,
		required : true
	},
	// id : Schema.Types.ObjectId,
	isProfilePicturePresent : Boolean,
	profilePicture : {
		type : String,
		required : false
	}
});

userSchema.pre('save', function (next) {
    var user = this;
    if (this.isModified('password') || this.isNew) {
        bcrypt.genSalt(10, function (err, salt) {
            if (err) {
                return next(err);
            }
            bcrypt.hash(user.password, salt, function (err, hash) {
                if (err) {
                    return next(err);
                }
                user.password = hash;
                next();
            });
        });
    } else {
        return next();
    }
});
 
userSchema.methods.comparePassword = function (passw, cb) {
    bcrypt.compare(passw, this.password, function (err, isMatch) {
        if (err) {
            return cb(err);
        }
        cb(null, isMatch);
    });
};
 
module.exports = mongoose.model('User', userSchema);