import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:PolyHxApp/components/circle-gravatar.dart';
import 'package:PolyHxApp/components/pill-button.dart';
import 'package:PolyHxApp/components/shirt-size-icon.dart';
import 'package:PolyHxApp/domain/attendee.dart';
import 'package:PolyHxApp/domain/event.dart';
import 'package:PolyHxApp/domain/user.dart';
import 'package:PolyHxApp/utils/constants.dart';

class AttendeeProfilePage extends StatelessWidget {
  final Attendee _attendee;
  final User _user;
  final RegistrationStatus _registrationStatus;
  final VoidCallback onDone;
  final VoidCallback onCancel;
  final bool _doneEnabled;
  final Map<String, dynamic> _values;

  AttendeeProfilePage(this._attendee, this._user, this._registrationStatus, this._doneEnabled, this._values, {this.onDone, this.onCancel});

  Widget _buildAvatar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CircleGravatar(_user.username),
    );
  }

  Widget _buildAttendeeNameWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 100.0),
      child: 
        Text(
          '${_user.firstName} ${_user.lastName}',
          style: TextStyle(
            color: Constants.polyhxGrey,
            fontSize: 24.0,
            fontWeight: FontWeight.w900
          )
      ),
    );
  }

  Widget _buildAttendeeStatusWidget() {
    final statusInfo = {
      RegistrationStatus.AwaitingConfirmation:  {
        'text': _values['awaiting'],
        'color': Colors.yellow
      },
      RegistrationStatus.Confirmed:  {
        'text': _values['confirmed'],
        'color': Colors.green
      },
      RegistrationStatus.Declined:  {
        'text': _values['declined'],
        'color': Colors.red
      },
      RegistrationStatus.NotSelected:  {
        'text': _values['not-selected'],
        'color': Colors.red
      },
      RegistrationStatus.Present: {
        'text': _values['present'],
        'color': Colors.green
      },
    };
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: 
        Text(
          _values['status'] + statusInfo[_registrationStatus]['text'],
          style: TextStyle(
            color: statusInfo[_registrationStatus]['color'],
            fontSize: 20.0,
            fontWeight: FontWeight.w900
          )
      )
    );
  }

  Widget _buildShirtSizeWidget() {
    return Expanded(
      child: ShirtSizeIcon(_attendee.shirtSize)
    );
  }

  Widget _buildDoneButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: PillButton(
          enabled: _doneEnabled,
          onPressed: onDone,
          child: Padding(
            padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
            child: Text(
              _doneEnabled ? _values['done'] : _values['scanning'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              )
            )
          )
        )
      )
    );
  }

  Widget _buildPublicIdWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(_values['id'],
                style: TextStyle(
                  color: Constants.polyhxGrey,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                )
              )
            ),
            Text(_attendee.publicId == null ? _values['unassigned'] : _attendee.publicId,
              style: TextStyle(
                color: Constants.polyhxGrey,
                fontSize: 14.0,
                fontWeight: FontWeight.bold
              )
            )
          ]
        )
      )
    );
  }

  Widget _buildProfileBody() {
    return Padding(
      padding: EdgeInsets.only(top: 40.0),
      child: Material(
        elevation: 1.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          children: <Widget>[
            _buildAttendeeNameWidget(),
            _buildAttendeeStatusWidget(),
            _buildShirtSizeWidget(),
            _buildPublicIdWidget(),
            _buildDoneButton()
          ]
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        _buildProfileBody(),
        _buildAvatar()
      ]
    );
  }
}
