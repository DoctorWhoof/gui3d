
Namespace gui3d

Private

Global _lastMousePick:RayCastResult
Global _lastMouseClick:RayCastResult

Public

Class Scene Extension
	
	Method UpdateGui3D( camera:Camera, coords:Vec2f, mask:Int = -1 )
		'Pick it!
		Local pick := camera.Pick( coords, mask )
		
		'Handle events
		If _lastMousePick
			If pick
				If _lastMousePick.body <> pick.body
					_lastMousePick.body.Entity.MouseLeaveEvent()
				End
			Else
				_lastMousePick.body.Entity.MouseLeaveEvent()
			End
		End
		
		If pick
			If _lastMousePick
				If pick.body <> _lastMousePick.body
					pick.body.Entity.MouseEnterEvent()
				End
			Else
				pick.body.Entity.MouseEnterEvent()
			End
			_lastMousePick = pick
			_lastMousePick.body.Entity.MouseOverEvent()
			
			'Mouse click
			If Mouse.ButtonPressed( MouseButton.Left )
				pick.body.Entity.MouseClickEvent( MouseButton.Left )
				_lastMouseClick = pick
			Elseif Mouse.ButtonPressed( MouseButton.Middle )
				pick.body.Entity.MouseClickEvent( MouseButton.Middle )
				_lastMouseClick = pick
			Elseif Mouse.ButtonPressed( MouseButton.Right )
				pick.body.Entity.MouseClickEvent( MouseButton.Right )
				_lastMouseClick = pick
			End
			
			'Mouse hold
			If Mouse.ButtonDown( MouseButton.Left )
				pick.body.Entity.MouseHoldEvent( MouseButton.Left )
			Elseif Mouse.ButtonDown( MouseButton.Middle )
				pick.body.Entity.MouseHoldEvent( MouseButton.Middle )
			Elseif Mouse.ButtonDown( MouseButton.Right )
				pick.body.Entity.MouseHoldEvent( MouseButton.Right )
			End
			
		Else
			_lastMousePick = Null
		End
		
		'Mouse released
		If Mouse.ButtonReleased( MouseButton.Left )
			If _lastMouseClick
				_lastMouseClick.body.Entity.MouseReleaseEvent( MouseButton.Left )
			End
			_lastMouseClick = Null
		Elseif Mouse.ButtonReleased( MouseButton.Middle )
			If _lastMouseClick
				_lastMouseClick.body.Entity.MouseReleaseEvent( MouseButton.Middle )
			End
			_lastMouseClick = Null
		Elseif Mouse.ButtonReleased( MouseButton.Right )
			If _lastMouseClick
				_lastMouseClick.body.Entity.MouseReleaseEvent( MouseButton.Right )
			End
			_lastMouseClick = Null
		End
		
	End
	
	
'	Method DrawGui3D( canvas:Canvas )
'		For Local e := Eachin GetRootEntities()
'			Local guistack := gui3d.componentMap[ e ]
'			If guistack
'				For Local c := Eachin guistack
'					c.OnDraw( canvas )
'				Next
'			End
'		Next
'	End
	
End