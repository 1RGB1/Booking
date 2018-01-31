//
//  Constants.swift
//  devslopes-social
//
//  Created by Ahmad Ragab on 10/24/17.
//  Copyright © 2017 Ahmad Ragab. All rights reserved.
//

import UIKit
import Alamofire

// UI Manipulations
let SHADOW_GREY: CGFloat = 120 / 255.0

// REGEX
let USERNAME_REGEX  : String = "^([A-Z]|[a-z]).\\S{0,}$"
let PASSWORD_REGEX  : String = "^\\S{1,}$"
let EMAIL_REGEX     : String = "^[A-Z0-9a-z._%+-]+@+[A-Z0-9a-z]+[.]+[A-Za-z]+$"
let PHONE_REGEX     : String = "^[01][0|1|2|5]+[0-9]{9}$"

// Alert Titles and Messages
let SUCCESS               : String = "Success"
let ERROR                 : String = "Error"
let INFO                  : String = "Info"
let NO_AVAILABLE_ITEMS    : String = "No items available"
let INVALID_USERNAME      : String = "Username must starts with letter followed by any number of charcters, no spaces allowed"
let INVALID_PASSWORD      : String = "Password can't include spaces"
let INVALID_EMAIL         : String = "Invalid email address"
let INVALID_PHONE         : String = "Invalid cell phone number"
let MANDATORY             : String = "All fields are manadory"
let UNKNOWN               : String = "Oops, something went wrong!"
let RESERVATION_REQUESTED : String = "Reservation requested"
let RESERVATION_CANCELLED : String = "Reservation cancelled"
let RESERVATION_DENIED    : String = "Reservation denied"
let RESERVATION_APPROVED  : String = "Reservation approved"
let ITEM_ADDED            : String = "Item added successfuly"

// Availability
let NO  : Int = 0
let YES : Int = 1

// Categories
enum Category : Int {
    case All = 0
    case Hotels
    case Apartments
    case Villas
    case Huts
}

// Reservations Status
enum ReservationStatus : Int {
    case Pending = 0
    case Approved
    case Denied
    case Cancelled
}

// Reservations Actions
enum ReservationsActions : String {
    case Request = "Request Reservation"
    case Cancel = "Cancel Reservation"
    case Approve = "Approve Reservation"
    case Deny = "Deny Reservation"
}

// HTPP Methods
let GET  : HTTPMethod = HTTPMethod.get
let POST : HTTPMethod = HTTPMethod.post

// Calling APIs
let BASE_URL                : String = "http://mahmoudtarek.info/course/booking-api/"
let LOGIN_URL               : String = BASE_URL + "login.php"
let REGISTER_URL            : String = BASE_URL + "register.php"
let USER_RESERTVATIONS_URL  : String = BASE_URL + "my_reservations.php"
let REQUEST_RESERVATION_URL : String = BASE_URL + "request_reservation.php"
let APPROVE_RESERVATION_URL : String = BASE_URL + "approve_reservation.php"
let CANCEL_RESERVATION_URL  : String = BASE_URL + "cancel_reservation.php"
let DENY_RESERVATION_URL    : String = BASE_URL + "deny_reservation.php"
let GET_AVAIL_ITEMS_URL     : String = BASE_URL + "available_items.php"
let ADD_ITEM_URL            : String = BASE_URL + "add_item.php"
let UPLOAD_IMAGE_URL        : String = BASE_URL + "upload_image.php"
let SEARCH_URL              : String = BASE_URL + "search.php"
let USER_ITEMS_URL          : String = BASE_URL + "my_items.php"







