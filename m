Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158051;
	b=gGJk5zIVUf3dBtAsfZI6UIHb1ObI0qTIRtxaQuHjSxL7efB724PqzNTbev8Br7Kttnv5
	 PcRVVoFU0ydcXntiMrcfSc0U8V86r57Z0MEdk3rJVBU8NjNTnlJb/Khh7VT3AuUaOWbBb
	 5UDb9FanQEQKP0hlCplshSv/2iPqu5kZ8Bzg9ygz+CSMtznwvbuVDmeRd42/QMjpJff01
	 FYx11qLxizWNTx1VntyvSBIVzYm7gejA4XehsIfERzL++h2iVwHia1nUHB3dezCablSyQ
	 mQEKedoPx5dRevIAt/luoD9F5rdHznqWQuVRRi4YuvnDrQ56bOwbMwt2Dgn4T206/0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158051;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q6hc77R+42guRLUrYCpxV5Wv7InZ1hzpEKeR4PVks24=;
	b=UdV/X4r8gv++9FzN2wJns15dTO+vq5v1ucOAyzLGwFbdOywV3UWxn1vbympSusT3DmZr
	 Tp+UvQNkjhAv0i9sdct6Hv7yufOQl1a0CjJC/KqgNNtymb6VeDaXUianEQEXs1M4mLk8D
	 Zm7HNrIj+sv+MkuR4qxtyrcwHoVNgg+MMXVhaUuAX+GqD5ZcT+cP/D+NcBlLxd2SWmTv8
	 AlGm+NJzERdu5j1/Ips1ExZ6i5QVpzfwrCSiUzaj9yXO11kyyLU9Ynlc7dW52vw5UapkL
	 2lFzMavP26Uy0xy8j251vzp3fuSuFNHyzn+AmKU7ZazBsr9Gcqk66b+Y2YQO9Uo3kAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUf0Krd9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56FB606A31A;
	Wed, 28 Oct 2026 03:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUf0Krd9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8545A1F01828;
	Wed, 28 Oct 2026 03:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793158050;
	bh=Q6hc77R+42guRLUrYCpxV5Wv7InZ1hzpEKeR4PVks24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aUf0Krd9etkpemJ1TO3Cn2kl4mvUjmnHq8sge+7iAq/r/3YZD0StEz2pUyZ72KdZB
	 ehMaEddwJQYQpVM5lUnmIuSv1PEpgTFs790XLWdqynN3cwobMIHh6i0HqOltgkLEBN
	 +T/ktsu60F2USwUTBSIoilYurHyt4G5qzWWKO69aSApIpM0AFqQa6wlcyUJyUk2uTe
	 UodUXAUG/8g9b73Q9lvaM3+XC1U/AMvse2/l8bZEOdCRw5n50fwpWAeVgN+rnOrkgh
	 v7JPLcZbvvn1rZNWPDONc9/jDye9vexTri9dyvFl8buvgZneiGQf4Ri/Lx82vQzBEW
	 swyvkmYNirCuA==
Message-ID: <sashiko-outbox-187421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/14] ALSA: virtio: fence staged capture state and
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028025317.92450-14-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
 <20261028025317.92450-14-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:27:30 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] ALSA: virtio: deadlock and broken retry in virtsnd_pcm_pause_resta=
rt_pause()
- [High] ALSA: virtio: XRUN wakeup suppressed in virtsnd_pcm_pause_restart_=
fail()
- [High] ALSA: virtio: premature paused stop arming in virtsnd_pcm_cp_ack()
- [High] ALSA: virtio: post-reset substream state clobbered after virtsnd_r=
eset_vqs()
- [High] ALSA: virtio: desynchronized prepared and stopped state on prepare=
 and stop
- [High] ALSA: virtio: missing paused stop arming in non-staged virtsnd_pcm=
_cp_ack()
--

commit ff9dabc7b348389a68870e8f3710dbf75bdbd0a8
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: fence staged capture state and recovery

This commit tracks device preparation under the substream lock, fences
virtqueue submissions and state transitions across pause, reset, and open
failure paths, and updates staged capture ACK and XRUN recovery handling.

> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index df7091b74a521..852cc27ac4a45 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c
> @@ -348,6 +348,16 @@ static void virtsnd_reset_vqs(struct virtio_snd *snd)
>  	struct virtio_device *vdev =3D snd->vdev;
>  	unsigned int i;
> =20
> +	for (i =3D 0; snd->substreams && i < snd->nsubstreams; ++i) {
> +		struct virtio_pcm_substream *vss =3D &snd->substreams[i];
> +		struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +
> +		guard(spinlock_irqsave)(&queue->lock);
> +		guard(spinlock)(&vss->lock);
> +		vss->prepared =3D false;
> +		vss->xfer_enabled =3D false;
> +		vss->suspended =3D true;
> +	}
>  	virtio_reset_device(vdev);
> =20
>  	/* Deleting a virtqueue does not unmap its outstanding descriptors. */
> @@ -364,9 +374,20 @@ static void virtsnd_reset_vqs(struct virtio_snd *snd)
>  		spin_unlock_irqrestore(&queue->lock, flags);
>  	}
> =20
> -	vdev->config->del_vqs(vdev);
> -	for (i =3D 0; i < VIRTIO_SND_VQ_MAX; ++i)
> +	for (i =3D 0; i < VIRTIO_SND_VQ_MAX; ++i) {
> +		guard(spinlock_irqsave)(&snd->queues[i].lock);
>  		snd->queues[i].vqueue =3D NULL;
> +	}
> +	vdev->config->del_vqs(vdev);
> +	for (i =3D 0; snd->substreams && i < snd->nsubstreams; ++i) {
> +		struct virtio_pcm_substream *vss =3D &snd->substreams[i];
> +
> +		cancel_work_sync(&vss->elapsed_period);
> +		guard(spinlock_irqsave)(&vss->lock);
> +		vss->stopped =3D false;
> +		vss->xfer_xrun =3D false;
> +		vss->pause_restart_state =3D VIRTSND_PCM_PAUSE_RESTART_NONE;
> +	}
>  }

[Severity: High]
Can resetting vss->stopped, vss->xfer_xrun, and vss->pause_restart_state
inside virtsnd_reset_vqs() get clobbered by in-flight control message
senders that are only woken up afterwards?

In virtsnd_freeze() (and virtsnd_remove()), the teardown sequence runs:

  virtsnd_ctl_msg_cancel_all(snd);
  virtsnd_reset_vqs(snd);
  virtsnd_ctl_msg_cleanup(snd);

virtsnd_ctl_msg_cancel_all() marks pending control messages with
msg->cancelled =3D true, but it does not complete msg->notify. The threads
waiting in virtsnd_ctl_msg_send_sync() are only woken later when
virtsnd_ctl_msg_cleanup() calls virtsnd_ctl_msg_complete().

When a thread blocked in virtsnd_pcm_pause_restart_send() wakes up after
virtsnd_reset_vqs() has already reset the substream state,
virtsnd_ctl_msg_uncertain(msg, rc) returns true and vss->pause_restart_state
(now VIRTSND_PCM_PAUSE_RESTART_NONE) no longer matches submitted_state:

  scoped_guard(spinlock_irqsave, &vss->lock) {
          if ((rc && uncertain) || vss->pause_restart_state !=3D submitted_=
state) {
                  vss->pause_restart_state =3D
                          VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
                  if (!rc)
                          rc =3D -EIO;
          } ...
  }

The woken caller then runs virtsnd_pcm_pause_restart_fail() (or
virtsnd_pcm_start_failed() in non-pause-restart mode), overwriting
vss->pause_restart_state with VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED and
setting vss->stopped =3D true and vss->xfer_xrun =3D true after the reset h=
as
already completed, leaving the substream wedged after virtsnd_restore().

[ ... ]

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index c7e85b151c5c4..0685a001cf95d 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -223,7 +227,8 @@ virtsnd_pcm_pause_restart_fail(struct virtio_pcm_subs=
tream *vss,
>  	bool notify_xrun;
> =20
>  	scoped_guard(spinlock_irqsave, &vss->lock) {
> -		notify_xrun =3D !vss->xfer_xrun;
> +		notify_xrun =3D vss->runtime_active && vss->xfer_enabled &&
> +			      !vss->xfer_xrun;
>  		vss->xfer_enabled =3D false;
>  		vss->stopped =3D true;
>  		vss->xfer_xrun =3D true;

[Severity: High]
Does requiring vss->xfer_enabled in virtsnd_pcm_pause_restart_fail()
suppress XRUN notifications when SNDRV_PCM_TRIGGER_PAUSE_RELEASE or
SNDRV_PCM_TRIGGER_PAUSE_PUSH fails?

When a stream is paused, vss->xfer_enabled is false. During
SNDRV_PCM_TRIGGER_PAUSE_RELEASE in virtsnd_pcm_pause_restart_start(),
vss->xfer_enabled remains false until virtsnd_pcm_pause_prepare() and
virtsnd_pcm_capture_send() both succeed:

  if (resume) {
          rc =3D virtsnd_pcm_pause_prepare(vss);
          if (rc) {
                  virtsnd_pcm_pause_restart_failed(vss);
                  return rc;
          }
          ...
  }
  scoped_guard(spinlock_irqsave, &queue->lock) {
          guard(spinlock)(&vss->lock);
          ...
          rc =3D virtsnd_pcm_capture_send(vss);
          if (!rc)
                  vss->xfer_enabled =3D true;
  }
  if (rc) {
          virtsnd_pcm_pause_restart_failed(vss);
          return rc;
  }

If either step fails, virtsnd_pcm_pause_restart_fail() sees
vss->xfer_enabled =3D=3D false and skips virtsnd_pcm_schedule_period_elapse=
d().
Because snd_pcm_action_single() runs snd_pcm_undo_pause() (where
vss->xfer_xrun is already true) and skips snd_pcm_post_pause(), the stream
stays in SNDRV_PCM_STATE_PAUSED with vss->xfer_xrun latched to true and
virtsnd_pcm_period_elapsed() is never scheduled to transition it to
SNDRV_PCM_STATE_XRUN and wake blocked readers.

Similarly, in virtsnd_pcm_pause_restart_pause(), vss->xfer_enabled is
cleared to false at function entry before VIRTIO_SND_R_PCM_STOP or
virtsnd_pcm_pause_release_flush() runs, so any failure in
virtsnd_pcm_pause_restart_pause() also sees vss->xfer_enabled =3D=3D false =
and
never schedules virtsnd_pcm_period_elapsed().

[ ... ]

> @@ -599,8 +614,6 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substre=
am *substream)
>  			return -EBADFD;
>  		}
> =20
> -		vss->buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
> -		vss->hw_ptr =3D 0;
>  	} else {
>  		struct snd_pcm_runtime *runtime =3D substream->runtime;
>  		unsigned int buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
> @@ -616,31 +629,30 @@ static int virtsnd_pcm_prepare(struct snd_pcm_subst=
ream *substream)
>  		}
>  	}
> =20
> -	/* ALSA prepare resets its pointers even after a suspended stream. */
> -	if (vss->capture_staging)
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		vss->prepared =3D false;
> +		vss->buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
>  		vss->hw_ptr =3D 0;
> -
> -	if (!pause_restart)
> -		vss->xfer_xrun =3D false;
> -	vss->suspended =3D false;
> -	vss->msg_count =3D 0;
> -	virtsnd_pcm_msg_reset(vss);
> -	if (vss->capture_staging) {
> -		scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (!pause_restart)
> +			vss->xfer_xrun =3D false;
> +		vss->suspended =3D false;
> +		vss->msg_count =3D 0;
> +		virtsnd_pcm_msg_reset(vss);
> +		memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
> +		vss->pcm_indirect.sw_buffer_size =3D vss->buffer_bytes;
> +		vss->pcm_indirect.hw_buffer_size =3D vss->buffer_bytes;
> +		if (vss->capture_staging) {
>  			vss->capture_boundary =3D substream->runtime->boundary;
>  			rc =3D virtsnd_pcm_capture_refresh_mode_locked(vss,
> -								     &free_running);
> +							     &free_running);
> +			if (rc)
> +				return rc;
>  		}
> -		if (rc)
> -			return rc;
>  	}
> =20
> -	memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
> -	vss->pcm_indirect.sw_buffer_size =3D
> -		vss->pcm_indirect.hw_buffer_size =3D
> -		snd_pcm_lib_buffer_bytes(substream);
> -
>  	rc =3D virtsnd_pcm_dev_prepare(vss);
> +	scoped_guard(spinlock_irqsave, &vss->lock)
> +		vss->prepared =3D !rc;
>  	if (pause_restart) {
>  		if (rc) {
>  			virtsnd_pcm_pause_restart_fail(vss, false);
> @@ -759,13 +771,23 @@ static int virtsnd_pcm_pause_restart_pause(struct v=
irtio_pcm_substream *vss)
> =20
>  	scoped_guard(spinlock_irqsave, &vss->lock) {
>  		state =3D vss->pause_restart_state;
> -		if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT ||
> -		    state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEASED)
> -			return 0;
> +		if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEASED)
> +			return vss->xfer_xrun ? -EPIPE : 0;
>  		vss->xfer_enabled =3D false;
>  		vss->stopped =3D true;
>  	}
> =20
> +	if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT) {
> +		rc =3D virtsnd_pcm_pause_restart_sync_stop(vss->substream);
> +		if (!rc) {
> +			guard(spinlock_irqsave)(&vss->lock);
> +			vss->stopped =3D true;
> +			if (vss->xfer_xrun)
> +				rc =3D -EPIPE;
> +		}
> +		return rc;
> +	}

[Severity: High]
Won't calling virtsnd_pcm_pause_restart_sync_stop() from inside
virtsnd_pcm_pause_restart_pause() deadlock on the PCM stream lock when
vss->elapsed_period work is pending or running?

Because vpcm->pcm->nonatomic is true, the ALSA PCM stream lock is a mutex
(substream->self_group.mutex), and ALSA holds it across substream->ops->tri=
gger():

  CPU 0                                  CPU 1 (workqueue)
  snd_pcm_pause_lock_irq()
    pcm_stream_lock_irq()
    snd_pcm_action_single()
      snd_pcm_do_pause()
        virtsnd_pcm_trigger(PAUSE_PUSH)
          virtsnd_pcm_pause_restart_pause()
            virtsnd_pcm_pause_restart_sync_stop()
              cancel_work_sync(&vss->elapsed_period)
                                         virtsnd_pcm_period_elapsed()
                                           guard(pcm_stream_lock_irqsave)(s=
ubstream)

virtsnd_pcm_period_elapsed() blocks waiting for pcm_stream_lock while
virtsnd_pcm_pause_restart_sync_stop() waits for virtsnd_pcm_period_elapsed()
to finish.

In addition, VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT is reached when an
earlier virtsnd_pcm_pause_release_flush() timed out, which called
virtsnd_pcm_pause_restart_failed() and set vss->xfer_xrun =3D true while
ALSA left runtime->state in SNDRV_PCM_STATE_RUNNING. When a subsequent
SNDRV_PCM_TRIGGER_PAUSE_PUSH retry drains the queue and returns -EPIPE
because vss->xfer_xrun is true, snd_pcm_action_single() runs
snd_pcm_undo_pause() and skips snd_pcm_post_pause(), keeping runtime->state
in SNDRV_PCM_STATE_RUNNING where snd_pcm_prepare() is rejected with -EBUSY.

>  	if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
>  	    virtsnd_pcm_pause_restart_transitioning(state)) {
>  		virtsnd_pcm_pause_restart_fail(vss, true);
> @@ -813,10 +835,9 @@ static int virtsnd_pcm_pause_restart_stop(struct vir=
tio_pcm_substream *vss,
>  	enum virtio_pcm_pause_restart_state state;
>  	int rc;
> =20
> -	if (suspend)
> -		vss->suspended =3D true;
> -
>  	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (suspend)
> +			vss->suspended =3D true;
>  		vss->xfer_enabled =3D false;
>  		vss->stopped =3D true;
>  		state =3D vss->pause_restart_state;
> @@ -887,7 +908,7 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substre=
am *substream, int command)
> =20
>  		scoped_guard(spinlock_irqsave, &queue->lock) {
>  			guard(spinlock)(&vss->lock);
> -			if (vss->stopped) {
> +			if (vss->stopped || !vss->prepared) {
>  				substream->runtime->stop_operating =3D true;
>  				return -EBADFD;
>  			}
> @@ -920,17 +941,18 @@ static int virtsnd_pcm_trigger(struct snd_pcm_subst=
ream *substream, int command)
>  		msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
>  						GFP_KERNEL);
>  		if (!msg) {
> -			virtsnd_pcm_start_failed(vss, false);
> +			virtsnd_pcm_start_failed(vss);
>  			return -ENOMEM;
>  		}
> =20
>  		rc =3D virtsnd_ctl_msg_send_sync(snd, msg);
>  		if (rc)
> -			virtsnd_pcm_start_failed(vss, false);
> +			virtsnd_pcm_start_failed(vss);
> =20
>  		return rc;
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
> -		vss->suspended =3D true;
> +		scoped_guard(spinlock_irqsave, &vss->lock)
> +			vss->suspended =3D true;
>  		fallthrough;

[Severity: High]
Are vss->prepared, vss->stopped, and vss->suspended kept consistent across
early prepare failures, sync_stop releases, and unprepared stop triggers?

1. In virtsnd_pcm_prepare(), vss->prepared =3D false is only set after the
early return checks for virtsnd_pcm_msg_pending_num(vss) and
virtsnd_pcm_dev_set_params(). If a stream is already in
SNDRV_PCM_STATE_PREPARED (with vss->prepared =3D=3D true) and a re-prepare =
fails
in virtsnd_pcm_dev_set_params() or virtsnd_pcm_msg_pending_num(),
snd_pcm_do_prepare() leaves runtime->state as SNDRV_PCM_STATE_PREPARED and
virtsnd_pcm_prepare() returns with vss->prepared still true, allowing
subsequent START or ACK calls to queue transfers after a failed PREPARE.

2. In virtsnd_pcm_sync_stop() and virtsnd_pcm_pause_restart_sync_stop(),
sending VIRTIO_SND_R_PCM_RELEASE clears vss->stopped =3D false without
setting vss->prepared =3D false. After SNDRV_PCM_IOCTL_DROP releases the
stream on the device and moves runtime->state to SNDRV_PCM_STATE_SETUP,
vss->prepared remains true and vss->stopped is false, so a subsequent
SNDRV_PCM_IOCTL_SYNC_PTR (snd_pcm_sync_ptr() -> pcm_lib_apply_appl_ptr() ->
substream->ops->ack()) passes the !vss->prepared and vss->stopped checks in
virtsnd_pcm_pb_ack() and virtsnd_pcm_cp_ack() and queues descriptors on a
released stream.

3. Conversely, when !vss->prepared (such as after virtsnd_reset_vqs() sets
vss->prepared =3D false and vss->stopped =3D false), if SNDRV_PCM_TRIGGER_S=
TART
returns -EBADFD, snd_pcm_action_single() calls snd_pcm_undo_start() ->
virtsnd_pcm_trigger(SNDRV_PCM_TRIGGER_STOP). Because the
SNDRV_PCM_TRIGGER_STOP case does not check vss->prepared, it sets
vss->stopped =3D true and sends VIRTIO_SND_R_PCM_STOP to an unprepared
stream, and the next virtsnd_pcm_sync_stop() sends VIRTIO_SND_R_PCM_RELEASE
to the unconfigured stream, which fails and leaves vss->stopped latched to
true.

4. Also, vss->suspended =3D false in virtsnd_pcm_open() and the
if (!vss->suspended) check in virtsnd_pcm_prepare() still access
vss->suspended without holding vss->lock.

[ ... ]

> @@ -1352,7 +1376,9 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_substr=
eam *substream)
> =20
>  	if (vss->capture_staging) {
>  		rc =3D virtsnd_pcm_capture_staged_ack(vss, runtime);
> -		if (rc =3D=3D -EPIPE) {
> +		if (rc =3D=3D -EPIPE ||
> +		    (!rc && runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED &&
> +		     snd_pcm_capture_avail(runtime) >=3D runtime->stop_threshold)) {
>  			guard(spinlock_irqsave)(&vss->lock);
>  			virtsnd_pcm_capture_arm_paused_stop(vss);
>  		}

[Severity: High]
Can arming virtsnd_pcm_capture_arm_paused_stop() inside virtsnd_pcm_cp_ack()
when rc =3D=3D 0 leave vss->stopped =3D true while the ALSA substream remai=
ns in
SNDRV_PCM_STATE_PAUSED?

In __snd_pcm_lib_xfer(), a single read that wraps around the ring buffer
boundary is split across two loop iterations. pcm_lib_apply_appl_ptr() ->
substream->ops->ack() is called after each contiguous chunk, whereas
snd_pcm_update_state() is only called once after the entire transfer loop
finishes.

If snd_pcm_capture_avail(runtime) >=3D runtime->stop_threshold after the fi=
rst
chunk at the wrap boundary, but avail drops below runtime->stop_threshold
after the second chunk completes the read, virtsnd_pcm_cp_ack() calls
virtsnd_pcm_capture_arm_paused_stop(vss) on the first chunk (setting
vss->stopped =3D true and vss->xfer_enabled =3D false), while
snd_pcm_update_state() sees avail < runtime->stop_threshold and keeps
runtime->state in SNDRV_PCM_STATE_PAUSED. Calling snd_pcm_forward(),
snd_pcm_rewind(), or snd_pcm_sync_ptr() while paused also invokes
pcm_lib_apply_appl_ptr() -> substream->ops->ack() without calling
snd_pcm_update_state().

When userspace subsequently unpauses the stream with
SNDRV_PCM_TRIGGER_PAUSE_RELEASE in native pause mode, virtsnd_pcm_trigger()
sees vss->stopped =3D=3D true and fails with -EBADFD.

>  		return rc;
>  	}
> =20
>  	scoped_guard(spinlock_irqsave, &queue->lock) {
>  		guard(spinlock)(&vss->lock);
> +		if (!vss->prepared)
> +			return -EBADFD;
>  		transfer.indirect =3D vss->pcm_indirect;
>  		if (vss->stopped && runtime->state !=3D SNDRV_PCM_STATE_DRAINING) {
>  			rc =3D -EPIPE;

[Severity: High]
What happens in the non-staged capture path (!vss->capture_staging) when a
paused read crosses runtime->stop_threshold and snd_pcm_update_state()
moves the substream to SNDRV_PCM_STATE_XRUN?

Because virtsnd_pcm_capture_arm_paused_stop() is only called in the
vss->capture_staging branch of virtsnd_pcm_cp_ack(), a paused non-staged
capture stream that enters SNDRV_PCM_STATE_XRUN from snd_pcm_update_state()
after a partial read (or when virtsnd_pcm_cp_ack() returns -EPIPE) never
sets vss->stopped =3D true or runtime->stop_operating =3D true, since
snd_pcm_do_stop() is a no-op when !snd_pcm_running(substream).

As a result, the queued RX descriptors remain pending in the virtqueue and
subsequent snd_pcm_prepare() calls skip virtsnd_pcm_sync_stop() and fail
with -EBADFD at virtsnd_pcm_msg_pending_num(vss). Furthermore, on
!CONFIG_MMU, because virtsnd_pcm_msg_complete() now checks
vss->prepared && !vss->stopped instead of vss->xfer_enabled:

  #ifndef CONFIG_MMU
  	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
  	    vss->prepared && !vss->stopped &&
  	    written_bytes > sizeof(msg->status)) {
  ...
  		memcpy(runtime->dma_area + msg->data_offset,
  		       vss->owned_dma_area + msg->data_offset, data_bytes);
  	}
  #endif

if userspace calls snd_pcm_drop() followed by snd_pcm_hw_params(),
snd_pcm_lib_malloc_pages() can free and reallocate runtime->dma_area before
virtsnd_pcm_hw_params() clears vss->prepared, allowing a concurrent RX
completion in virtsnd_pcm_msg_complete() to copy into freed
runtime->dma_area.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025317.9245=
0-1-mynameisjune111@gmail.com?part=3D13
