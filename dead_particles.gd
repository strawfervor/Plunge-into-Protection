extends GPUParticles2D

func _ready(): #on ready start emitting particles
	self.emitting = true

func _process(delta):
	if self.emitting == false: #delte when finished emitting
		queue_free()
