
Namespace gamecomponents

'A RigidBody that provides support to collision events like OnCollisionEnter.

Class GameBody Extends RigidBody
	
	Const Type:=New ComponentType( "GameBody",-10,ComponentTypeFlags.Singleton )
	
	Protected
	Field _collisions:= New Stack<RigidBody>
	Field _lastCollisions:= New Stack<RigidBody>
	
	Public
	Method New( e:Entity )
		Super.New( e )
		SetupEvents()
	End
	
	Method New( entity:Entity,body:GameBody )
		Super.New( entity, body )
		SetupEvents()
	End
	
	Method SetupEvents()
		Collided += Lambda( other:RigidBody )
			_collisions.Add( other )
			
			If _lastCollisions.Contains( other )
				Entity.CollisionStay( other.Entity )
			Else
				Entity.CollisionEnter( other.Entity )
			End
			
		End
	End
	
	Method OnCopy:GameBody( entity:Entity ) Override
		Local body:=New GameBody( entity,Self )
		Return body
	End
	
	Method OnBeginUpdate() Override
		Super.OnBeginUpdate()
		
		For Local body := Eachin _lastCollisions
			If Not _collisions.Contains( body )
				Entity.CollisionLeave( body.Entity )
			End
		Next
		
		_lastCollisions.Clear()
		_lastCollisions.AddAll( _collisions )
		_collisions.Clear()
	End
	
	Method OnEndUpdate() Override
		Super.OnEndUpdate()
	End
	
End
