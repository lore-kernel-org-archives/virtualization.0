Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342316;
	b=SBz7EZAvjU5q5BTyyrOZMd3NnGmGN6/qD6RJEt6nzkj57S7poP13g5snSar/4xfzv51B
	 0pDdzlhxEa+w7Xnib+Ks9B3/I0WHTdY5vYnwuMH6go4jApbcjoadiZt/fI2SeDlfUj/Po
	 bVPaS12/LGczESY7yek3hHX/m7LF77Byw4zFhhgaNxs5E/aJDL6hwXpdbAoy0gJenSVIk
	 uiTdy0Erudi7cpWWbw7LYgLV2Qa2U8FYOl061MFSagxf/yOc8Gr0vMVU1/RdXKiBZ8YNi
	 znGfRCmmSAyav78FhrLZbJB7JrKjcQBknIGQ+f9kOMe1Cw9I1URd5xvCPyp551W2VeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342316;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d/qmFXvTziso2+q5m79Mnjdg2EYzLiTKOZ6UyZa9QSQ=;
	b=y7eqyT4XvKyX7kpuDsFibk+ySlc9SxSKzF/iwVIOE9JfSWvY21JRb8DJK7ks0F6wLktx
	 7/fW/5z0Yfb0V9vmtGObH4d4YonnGYwTPFTNkR/sywD3D28iWQqNemK+gpCON4RPL++wX
	 8z0aA0c+YVsPyFMhycBiFHOgtqtB2XBKmMlACDTdYZmLs8OJPzKYu/0sxYOOg7l/oSX1g
	 3fQ0qeVZkpaTY75WTtPiySEOMq9IigFkpjXFXA0oRqTSHXkl6F2IVnyrW/fUxsVIvYXf5
	 +97RXOE1HOoTf3vIK9sCXFK4EV8AIbqDLqPbnt8K0xMEHYptrsIzcnv5XHKcN1rlYfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzhmYk44;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E497606A31A;
	Fri, 30 Oct 2026 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzhmYk44
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FD81F00A02;
	Fri, 30 Oct 2026 06:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793342315;
	bh=d/qmFXvTziso2+q5m79Mnjdg2EYzLiTKOZ6UyZa9QSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hzhmYk44RkfTPyyDRL5MdXzVqoV82/K/WjeOm6aeqvx3w7/mDXgqdqu3eiE8mwE9C
	 zi+GnoDte5LnhF6AUxjjbnmA/mUbxreooWDck9cyxxWouiGkcFUVqvSfX+U4nX6ynX
	 1uJQ2YlanOty5zMRtxtMSYsdLSGL4dh/R6FVtgAoGYp3grBPHkuUAGCRN4C38EN8px
	 gP0HXEAqKrc+Y/zvJ6Yr63zYnO5h4PdFvWHc3i8ukaZtiA08gw+TlgK5u81HGuJ4J6
	 kyQkdgUttEW9fsBpexe/EDS7REHIPYMtLLDbG8oN9craHLT5mo46JFt1IWcvQlAJ0e
	 zjJkkU9m4t6jA==
Message-ID: <sashiko-outbox-190604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 09/14] ALSA: virtio: add staged capture accounting
 and lifecycle recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030052629.27742-10-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
 <20261030052629.27742-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 06:38:35 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] ALSA: virtio: duplicate RX buffer enqueue on non-staged pause rele=
ase
- [Medium] ALSA: virtio: detached virtqueue race in virtsnd_reset_vqs() and=
 notify_cb
- [Medium] ALSA: virtio: incomplete pause rejection recovery in virtsnd_pcm=
_trigger()
- [Medium] ALSA: virtio: missing virtsnd_pcm_start_failed() on running trig=
ger error
--

commit 4e7eab1d20a52ea1742792d7fd3cc04245ceba41
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: add staged capture accounting and lifecycle recovery

This commit adds staged capture accounting using request-owned DMA buffers
and introduces lifecycle recovery and epoch tracking across PCM operations
and device resets.

Link: https://sashiko.dev/#/patchset/20261029085032.70689-1-mynameisjune111=
%40gmail.com?part=3D9

> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index df7091b74a521..07d66225ce04a 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c
> @@ -348,6 +348,22 @@ static void virtsnd_reset_vqs(struct virtio_snd *snd)
>  	struct virtio_device *vdev =3D snd->vdev;
>  	unsigned int i;
> =20
> +	for (i =3D 0; snd->substreams && i < snd->nsubstreams; ++i) {
> +		struct virtio_pcm_substream *vss =3D &snd->substreams[i];
> +		struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +
> +		guard(spinlock_irqsave)(&queue->lock);
> +		guard(spinlock)(&vss->lock);
> +		vss->reset_epoch++;
> +		vss->resetting =3D true;
> +		vss->prepared =3D false;
> +		vss->device_running =3D false;
> +		vss->release_required =3D false;
> +		vss->control_uncertain =3D false;
> +		vss->capture_reset_observing =3D false;
> +		vss->xfer_enabled =3D false;
> +		vss->suspended =3D true;
> +	}
>  	virtio_reset_device(vdev);
> =20
>  	/* Deleting a virtqueue does not unmap its outstanding descriptors. */
> @@ -364,9 +380,20 @@ static void virtsnd_reset_vqs(struct virtio_snd *snd)
>  		spin_unlock_irqrestore(&queue->lock, flags);
>  	}
> =20
> -	vdev->config->del_vqs(vdev);
> -	for (i =3D 0; i < VIRTIO_SND_VQ_MAX; ++i)
> +	for (i =3D 0; i < VIRTIO_SND_VQ_MAX; ++i) {
> +		guard(spinlock_irqsave)(&snd->queues[i].lock);
>  		snd->queues[i].vqueue =3D NULL;
> +	}

[Severity: Medium]
As reported by Sashiko on v9 [1], can an IRQ callback still observe a
non-NULL queue->vqueue after its buffers have been detached in
virtsnd_reset_vqs()?

In virtsnd_reset_vqs(), the first loop over VIRTIO_SND_VQ_MAX detaches
unused buffers under queue->lock and then drops the lock:

	for (i =3D 0; i < VIRTIO_SND_VQ_MAX; ++i) {
		struct virtio_snd_queue *queue =3D &snd->queues[i];
		unsigned long flags;
		void *msg;

		spin_lock_irqsave(&queue->lock, flags);
		if (queue->vqueue)
			while ((msg =3D virtqueue_detach_unused_buf(queue->vqueue)))
				if (i =3D=3D VIRTIO_SND_VQ_TX || i =3D=3D VIRTIO_SND_VQ_RX)
					virtsnd_pcm_msg_cancel(msg);
		spin_unlock_irqrestore(&queue->lock, flags);
	}

Only in the separate loop above does virtsnd_reset_vqs() re-acquire
snd->queues[i].lock to set snd->queues[i].vqueue =3D NULL.

Because virtqueue_detach_unused_buf_split() clears
vq->split.desc_state[i].data =3D NULL without advancing vq->last_used_idx,
if virtsnd_pcm_notify_cb() acquires queue->lock between those two loops,
it will see queue->vqueue !=3D NULL and call virtqueue_get_buf() on a ring
whose descriptor state was already cleared, triggering BAD_RING() in
virtqueue_get_buf_ctx_split() if the device wrote a used entry just before
virtio_reset_device().

In addition, virtsnd_ctl_notify_cb() in sound/virtio/virtio_ctl_msg.c and
virtsnd_event_notify_cb() in sound/virtio/virtio_card.c do not check
queue->vqueue under queue->lock at all before calling virtqueue_get_buf(),
virtqueue_enable_cb(), or virtsnd_event_send().

Should queue->vqueue =3D NULL be set inside the same queue->lock critical
section that calls virtqueue_detach_unused_buf(), and should
virtsnd_ctl_notify_cb() and virtsnd_event_notify_cb() also check
if (!queue->vqueue) under queue->lock?

[ ... ]

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index de11bf162006e..8a6499d0cfea7 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> +static int virtsnd_pcm_start_queue(struct virtio_pcm_substream *vss, u64=
 epoch)
> +{
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	int rc =3D 0;
> +
> +	guard(spinlock_irqsave)(&queue->lock);
> +	guard(spinlock)(&vss->lock);
> +	if (vss->resetting || vss->reset_epoch !=3D epoch)
> +		return -ECANCELED;
> +	if (vss->stopped || !vss->prepared || vss->xfer_xrun)
> +		return vss->xfer_xrun ? -EPIPE : -EBADFD;
> +	if (vss->control_uncertain)
> +		return -EIO;
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> +		if (vss->capture_staging)
> +			rc =3D vss->runtime_active ? virtsnd_pcm_capture_send(vss) : -EBADFD;
> +		else if (!vss->device_running)
> +			rc =3D virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
> +	}

[Severity: High]
On a non-staged capture stream, won't resuming from pause via
SNDRV_PCM_TRIGGER_PAUSE_RELEASE re-submit the entire capture buffer while
descriptors from before the pause are still queued or hold unread data?

When SNDRV_PCM_TRIGGER_START initially starts a non-staged capture stream,
virtsnd_pcm_start_queue() calls virtsnd_pcm_msg_send(vss, 0,
vss->buffer_bytes) to queue all vss->nmsgs descriptors with
msg->length =3D period_bytes.

When SNDRV_PCM_TRIGGER_PAUSE_PUSH pauses the stream,
virtsnd_pcm_stop_device() sends VIRTIO_SND_R_PCM_STOP and sets
vss->device_running =3D false without releasing the pending RX descriptors.

When SNDRV_PCM_TRIGGER_PAUSE_RELEASE later resumes the stream,
virtsnd_pcm_start_queue() sees !vss->device_running =3D=3D true and calls
virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes) again across the whole
buffer:

	msg->length +=3D n;
	if (msg->length =3D=3D period_bytes) {

For descriptors still pending in the virtqueue, msg->length is incremented
to 2 * period_bytes, corrupting vss->hw_ptr accounting on error status and
preventing subsequent ACK re-submissions. For descriptors that already
completed before or during pause and are waiting for userspace to read and
ACK them, virtsnd_pcm_msg_send() re-queues them into the RX virtqueue,
allowing the device to overwrite unread audio samples via DMA.

> +	if (!rc)
> +		vss->xfer_enabled =3D true;
> +	return rc;
> +}
> +
>  /**
>   * virtsnd_pcm_trigger() -Start/stop/pause/resume the PCM substream.
>   * @substream: Kernel ALSA substream.
> @@ -377,68 +1087,219 @@ static int virtsnd_pcm_prepare(struct snd_pcm_sub=
stream *substream)
>  static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int =
command)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> -	struct virtio_snd *snd =3D vss->snd;
> -	struct virtio_snd_queue *queue;
>  	struct virtio_snd_msg *msg;
>  	int rc =3D 0;
> +	bool running;
> +	u64 epoch;
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock)
> +		epoch =3D vss->reset_epoch;
> +
> +	if (virtsnd_pcm_pause_restart_enabled(vss)) {
> +		switch (command) {
> +		case SNDRV_PCM_TRIGGER_START:
> +			return virtsnd_pcm_pause_restart_start(vss, false);
> +		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +			return virtsnd_pcm_pause_restart_start(vss, true);
> +		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +			return virtsnd_pcm_pause_restart_pause(vss);
> +		case SNDRV_PCM_TRIGGER_STOP:
> +			return virtsnd_pcm_pause_restart_stop(vss, false);
> +		case SNDRV_PCM_TRIGGER_SUSPEND:
> +			return virtsnd_pcm_pause_restart_stop(vss, true);
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> =20
>  	switch (command) {
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> -		queue =3D virtsnd_pcm_queue(vss);
> -
> -		scoped_guard(spinlock_irqsave, &queue->lock) {
> -			guard(spinlock)(&vss->lock);
> -			if (vss->stopped) {
> -				substream->runtime->stop_operating =3D true;
> -				return -EBADFD;
> -			}
> -			if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE)
> -				rc =3D virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
> -			if (rc) {
> -				vss->stopped =3D true;
> -				substream->runtime->stop_operating =3D true;
> -				return rc;
> -			}
> -			vss->xfer_enabled =3D true;
> +		scoped_guard(spinlock_irqsave, &vss->lock)
> +			running =3D vss->device_running;
> +		/* Refill RX descriptors returned during a rejected native pause. */
> +		if (running)
> +			return virtsnd_pcm_start_queue(vss, epoch);

[Severity: Medium]
As reported by Sashiko on v9 [1], what happens when running is true here
and virtsnd_pcm_start_queue(vss, epoch) fails, or when it succeeds on a
staged capture stream?

When SNDRV_PCM_TRIGGER_PAUSE_PUSH is rejected by the device in
virtsnd_pcm_stop_device(), vss->device_running remains true. When
SNDRV_PCM_TRIGGER_PAUSE_RELEASE subsequently runs (either from
snd_pcm_undo_pause(), which ignores the trigger return value, or a later
resume on a linked substream), virtsnd_pcm_trigger() sees running =3D=3D tr=
ue
and returns virtsnd_pcm_start_queue(vss, epoch) directly.

If virtsnd_pcm_start_queue() fails (for example, if
virtsnd_pcm_capture_refresh_mode_locked() returns -EPIPE after a
stop_threshold update, or virtqueue_add_sgs() fails while refilling
descriptors completed after PAUSE_PUSH), this early return bypasses
virtsnd_pcm_start_failed(vss, epoch), leaving vss->xfer_enabled,
vss->stopped, substream->runtime->stop_operating, and vss->xfer_xrun
unlatched and failing to schedule elapsed_period work to wake blocked
staged-capture readers.

Conversely, if virtsnd_pcm_start_queue() succeeds for staged capture on
this running =3D=3D true path, returning early skips the
virtsnd_pcm_schedule_period_elapsed(vss) call at the end of the
SNDRV_PCM_TRIGGER_START / SNDRV_PCM_TRIGGER_PAUSE_RELEASE case.

> +		rc =3D virtsnd_pcm_start_queue(vss, epoch);
> +		if (rc) {
> +			virtsnd_pcm_start_failed(vss, epoch);
> +			return rc;
>  		}
> =20
>  		msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
> -						GFP_KERNEL);
> +						GFP_KERNEL, epoch);
>  		if (!msg) {
> -			virtsnd_pcm_start_failed(vss);
> +			virtsnd_pcm_start_failed(vss, epoch);
>  			return -ENOMEM;
>  		}
> =20
> -		rc =3D virtsnd_ctl_msg_send_sync(snd, msg);
> -		if (rc)
> -			virtsnd_pcm_start_failed(vss);
> +		rc =3D virtsnd_pcm_send_sync(vss, msg);
> +		if (rc && rc !=3D -ECANCELED)
> +			virtsnd_pcm_start_failed(vss, epoch);
> =20
> +		if (!rc) {
> +			guard(spinlock_irqsave)(&vss->lock);
> +			if (vss->resetting || vss->reset_epoch !=3D epoch)
> +				return -ECANCELED;
> +			vss->device_running =3D true;
> +		}
> +		if (!rc && vss->capture_staging)
> +			virtsnd_pcm_schedule_period_elapsed(vss);
>  		return rc;
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
> -		vss->suspended =3D true;
> +		scoped_guard(spinlock_irqsave, &vss->lock)
> +			vss->suspended =3D true;
>  		fallthrough;
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  		scoped_guard(spinlock_irqsave, &vss->lock) {
> +			if (!vss->prepared)
> +				return 0;
>  			if (command !=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH)
>  				vss->stopped =3D true;
>  			vss->xfer_enabled =3D false;
> +			if (!vss->device_running)
> +				return 0;
> +		}
> +
> +		rc =3D virtsnd_pcm_stop_device(vss, epoch);
> +		if (rc && command =3D=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH &&
> +		    virtsnd_pcm_start_queue(vss, epoch)) {
> +			guard(spinlock_irqsave)(&vss->lock);
> +			if (vss->reset_epoch =3D=3D epoch && !vss->resetting) {
> +				vss->xfer_xrun =3D true;
> +				vss->stopped =3D true;
> +				substream->runtime->stop_operating =3D true;
> +				virtsnd_pcm_schedule_period_elapsed(vss);
> +			}
> +		}
> +		return rc;

[Severity: Medium]
As reported by Sashiko on v9 [1], can a non-staged capture stream stall if
VIRTIO_SND_R_PCM_STOP is rejected during SNDRV_PCM_TRIGGER_PAUSE_PUSH?

Before calling virtsnd_pcm_stop_device(vss, epoch),
SNDRV_PCM_TRIGGER_PAUSE_PUSH sets vss->xfer_enabled =3D false. While
VIRTIO_SND_R_PCM_STOP is in flight, the device is still running and can
complete queued RX buffers. In virtsnd_pcm_msg_complete(), completions for
non-staged capture advance vss->hw_ptr, clear msg->length =3D 0, and
decrement vss->msg_count, but skip virtsnd_pcm_schedule_period_elapsed(vss)
because vss->xfer_enabled is false.

When virtsnd_pcm_stop_device() fails and leaves vss->device_running =3D tru=
e,
both virtsnd_pcm_start_queue(vss, epoch) here and the subsequent
SNDRV_PCM_TRIGGER_PAUSE_RELEASE recovery path check:

	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
		if (vss->capture_staging)
			rc =3D vss->runtime_active ? virtsnd_pcm_capture_send(vss) : -EBADFD;
		else if (!vss->device_running)
			rc =3D virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
	}
	if (!rc)
		vss->xfer_enabled =3D true;

Because vss->device_running is still true, virtsnd_pcm_start_queue() only
sets vss->xfer_enabled =3D true without scheduling elapsed_period work or
refilling descriptors. If all queued RX descriptors completed while
vss->xfer_enabled was false, vss->msg_count is 0 and no period work is
scheduled, so ALSA never runs pointer/ack to re-enqueue RX buffers and the
capture stream stalls indefinitely.

[1] https://lore.kernel.org/r/20261029085032.70689-10-mynameisjune111@gmail=
.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030052629.2774=
2-1-mynameisjune111@gmail.com?part=3D9
