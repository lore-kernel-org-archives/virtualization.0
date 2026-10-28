Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793183162;
	b=xGuSVCcV5/bLDCQdoWBvFqittnlsBei3a/KTRZcTLk77lr8yWk4jO6ZjR9rt9K0pK264
	 2Awst02ryrIi3a2NTXINbDLGUNHhEB9ek0vqq5+7go6nY5Dm8/lTLLlrdCKc0RG4epgaU
	 rtfMXsg5yVI/5b5mleFKuxXo2RO6BDw0YUHbM42OCvz7xDTWAftGEqphSTb+ByfPmYSS5
	 ERHzy/UzIfZ+WeAtXM/waxDgErCAKoxGKqDyFkT+0XAWlDyXa4QywyPhpC5HRBWWn/1nY
	 b3PPRhFzl7x/bWGBzQQjrrjIZJ089fdwkN4H4fT8vsZdZp786a21IgngUnyD+xHnasA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793183162;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DTtnX18+3a7Bru01EFim5NtH8sxGeEEa5KovEDfF6Gk=;
	b=Y85du9ojvLu/aZRmSYDsZwNRjFs1hvp4kQ1IOe17S3WgsmVHsnpNiYgreD+Yy2htDa9L
	 nx52rR1IWCgR4NLI5N4ruqBivmqAvoVRAw1bwcvhbSfa8O7t+pstonfpEx+eql2JUFB9l
	 bXqRDeucqZ1zYbOacU2ovlRIS2aOOnsIeYy0a27Lx3EMZ7m7hhMr5qwLsuHA1rGMGcIeH
	 kvDPh7LnXOu1y/VyRsfJawwA6laSa2pTFySmRFFy5VfdcNt8NKAsdxZZmDjeYVDeN2aqr
	 R6FR9QWiK+80+nljcdID9rKMVUwxGNeDOiYTL7mr0JGqlXAXBOuW0L4r5NwfvJRMWAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RT5De/l0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91D3606A31A;
	Wed, 28 Oct 2026 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RT5De/l0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335EF1F01825;
	Wed, 28 Oct 2026 10:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793183161;
	bh=DTtnX18+3a7Bru01EFim5NtH8sxGeEEa5KovEDfF6Gk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RT5De/l0KvfTA0tG5g2BTVMJ5/l86ZAGD3uMoDh+L4s+3jf0inCPtzEzynJ2bKMyO
	 T6F4fMVP0dO1ISl/YM2+CwSBllgUFsQtX9zmxAEcpui6jGT6XJ13l8PYMxL8wiQQ7K
	 gxTQEtvBquO3oSuzslLpnhcssIu87gVLA+L2x4VVoGGqVp3zhn+G8sVAbkMh7mxliq
	 TPdPhfG/qw8L2ztDGDXDaN+qCOTFWdw7aHLWXI9ZqclvS4RLx6qrERq2QT2SCqXM9c
	 fJEg/rRWzYwWw2SNP6oYXgsBGucCXWWKQ9LpbyoaBxRHZVFb9H6Xri736hSJdBXAyQ
	 gvh2amA+oyypw==
Message-ID: <sashiko-outbox-187746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/16] ALSA: virtio: serialize capture lifecycle and
 reset state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-17-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-17-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 10:26:00 +0000
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
- [High] ALSA: virtio: checking vss->suspended in sync_stop wedges suspende=
d streams
- [High] ALSA: virtio: split reset_epoch update and missing checks corrupt =
pause state
- [High] ALSA: virtio: race and missing RX refill in virtsnd_pcm_ioctl() on=
 RESET
- [Medium] ALSA: virtio: missing failure handling and state check in pause =
retry path
- [Medium] ALSA: virtio: missing XRUN wakeup on staged native-pause release=
 failure
- [Medium] ALSA: virtio: race between snd_pcm_drop() and virtsnd_pcm_prepar=
e()
--

commit 24d284e1ac3e3d50dab01d4de1927240e8a33acb
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: serialize capture lifecycle and reset state

This patch serializes PCM lifecycle callbacks with a per-substream mutex,
rebases staged capture counters on RESET, and adds reset epoch and suspend
checks to control and sync-stop paths.

> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index 852cc27ac4a45..2fd8595046563 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c
> @@ -354,6 +354,7 @@ static void virtsnd_reset_vqs(struct virtio_snd *snd)
> =20
>  		guard(spinlock_irqsave)(&queue->lock);
>  		guard(spinlock)(&vss->lock);
> +		vss->reset_epoch++;
>  		vss->prepared =3D false;
>  		vss->xfer_enabled =3D false;
>  		vss->suspended =3D true;

[Severity: High]
Can incrementing vss->reset_epoch in the first loop of virtsnd_reset_vqs()
while resetting vss->pause_restart_state in the fourth loop corrupt the
pause-restart state machine if a control operation runs concurrently?

In virtsnd_reset_vqs(), the first loop increments vss->reset_epoch and
clears vss->prepared, while the fourth loop later resets
vss->pause_restart_state:

sound/virtio/virtio_card.c:virtsnd_reset_vqs() {
	...
	for (i =3D 0; snd->substreams && i < snd->nsubstreams; ++i) {
		cancel_work_sync(&vss->elapsed_period);
		guard(spinlock_irqsave)(&vss->lock);
		vss->stopped =3D false;
		vss->xfer_xrun =3D false;
		vss->pause_restart_state =3D VIRTSND_PCM_PAUSE_RESTART_NONE;
	}
}

If virtsnd_pcm_pause_restart_send() enters between the first and fourth
loops, it samples the already-incremented vss->reset_epoch and transitions
vss->pause_restart_state to submitted_state. After the fourth loop resets
vss->pause_restart_state to VIRTSND_PCM_PAUSE_RESTART_NONE, the post-send
check in virtsnd_pcm_pause_restart_send() sees vss->reset_epoch =3D=3D epoch
and vss->pause_restart_state !=3D submitted_state, poisoning
vss->pause_restart_state to VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED
across virtsnd_restore().

Similarly, in virtsnd_pcm_pause_release_flush(), waking from
wait_event_timeout(vss->msg_empty, ...) when virtsnd_reset_vqs() cancels
pending RX buffers does not check vss->reset_epoch: if it runs before the
fourth loop it transitions to VIRTSND_PCM_PAUSE_RESTART_RELEASED and
returns 0 across a reset, and if it runs after the fourth loop it sees
vss->pause_restart_state =3D=3D VIRTSND_PCM_PAUSE_RESTART_NONE and returns
-ETIMEDOUT instead of -ECANCELED. In virtsnd_pcm_pause_restart_start(),
the two locked blocks after virtsnd_pcm_pause_prepare() also omit
vss->reset_epoch checks, allowing vss->prepared =3D true to be set after the
first loop of virtsnd_reset_vqs() or returning -EBADFD instead of
-ECANCELED after the fourth loop.

[ ... ]

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 0685a001cf95d..573fab6525a61 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -667,6 +724,14 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substr=
eam *substream)
>  	return rc;
>  }
> =20
> +static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +
> +	guard(mutex)(&vss->lifecycle_lock);
> +	return virtsnd_pcm_prepare_locked(substream);
> +}

[Severity: Medium]
Can a concurrent snd_pcm_drop() and snd_pcm_prepare() still race despite
vss->lifecycle_lock?

In sound/core/pcm_native.c, snd_pcm_drop() stops the stream (setting
vss->stopped =3D true and runtime->stop_operating =3D true), drops the stre=
am
lock, and calls snd_pcm_sync_stop() without holding runtime->buffer_mutex.
snd_pcm_sync_stop() clears runtime->stop_operating =3D false before calling
substream->ops->sync_stop(substream) (virtsnd_pcm_sync_stop()), which only
then acquires vss->lifecycle_lock.

If a concurrent snd_pcm_prepare() runs after snd_pcm_drop() clears
runtime->stop_operating =3D false in snd_pcm_sync_stop() but before
virtsnd_pcm_sync_stop() acquires vss->lifecycle_lock, the prepare path's
own snd_pcm_sync_stop() sees runtime->stop_operating =3D=3D false and skips
calling virtsnd_pcm_sync_stop(). If virtsnd_pcm_prepare() then acquires
vss->lifecycle_lock first, virtsnd_pcm_prepare_locked() does not call
virtsnd_pcm_sync_stop_locked() (unlike virtsnd_pcm_hw_params()), so it
observes vss->stopped =3D=3D true and fails with -EBADFD.

Conversely, if the delayed virtsnd_pcm_sync_stop() from snd_pcm_drop()
acquires vss->lifecycle_lock after a concurrent prepare completes,
virtsnd_pcm_sync_stop_locked() now includes vss->prepared in need_release
(and virtsnd_pcm_pause_restart_sync_stop() releases
VIRTSND_PCM_PAUSE_RESTART_PREPARED), so it sends VIRTIO_SND_R_PCM_RELEASE
and clears vss->prepared =3D false on the newly prepared stream.

[ ... ]

> @@ -771,20 +849,31 @@ static int virtsnd_pcm_pause_restart_pause(struct v=
irtio_pcm_substream *vss)
> =20
>  	scoped_guard(spinlock_irqsave, &vss->lock) {
>  		state =3D vss->pause_restart_state;
> -		if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEASED)
> +		if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEASED) {
> +			if (vss->xfer_xrun)
> +				virtsnd_pcm_schedule_period_elapsed(vss);
>  			return vss->xfer_xrun ? -EPIPE : 0;
> +		}
>  		vss->xfer_enabled =3D false;
>  		vss->stopped =3D true;
>  	}
> =20
>  	if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT) {
> -		rc =3D virtsnd_pcm_pause_restart_sync_stop(vss->substream);
> -		if (!rc) {
> -			guard(spinlock_irqsave)(&vss->lock);
> -			vss->stopped =3D true;
> -			if (vss->xfer_xrun)
> -				rc =3D -EPIPE;
> +		unsigned int js =3D msecs_to_jiffies(virtsnd_msg_timeout_ms);
> +
> +		/* Trigger holds the PCM lock: never cancel the period worker here. */
> +		if (!wait_event_timeout(vss->msg_empty,
> +				       !virtsnd_pcm_msg_pending_num(vss), js))
> +			return -ETIMEDOUT;
> +		scoped_guard(spinlock_irqsave, &vss->lock) {
> +			if (vss->suspended)
> +				return -ECANCELED;
> +			vss->prepared =3D false;
> +			vss->pause_restart_state =3D VIRTSND_PCM_PAUSE_RESTART_RELEASED;
> +			rc =3D vss->xfer_xrun ? -EPIPE : 0;
>  		}
> +		if (rc)
> +			virtsnd_pcm_pause_restart_failed(vss);
>  		return rc;
>  	}

[Severity: Medium]
In the VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT branch of
virtsnd_pcm_pause_restart_pause(), does returning -ETIMEDOUT directly on
wait_event_timeout() failure skip calling virtsnd_pcm_pause_restart_failed(=
)?

Previously this path called virtsnd_pcm_pause_restart_sync_stop(), which
invoked virtsnd_pcm_pause_restart_fail(vss, false) on timeout to set
vss->xfer_xrun =3D true, schedule vss->elapsed_period, and set
substream->runtime->stop_operating =3D true. In the new open-coded path,
timing out leaves vss->stopped =3D true while runtime->stop_operating and
vss->xfer_xrun remain false.

Also, when wait_event_timeout() returns non-zero, should the locked block
re-verify that vss->msg_count =3D=3D 0 and vss->pause_restart_state =3D=3D
VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT before setting
VIRTSND_PCM_PAUSE_RESTART_RELEASED, matching
virtsnd_pcm_pause_release_flush() and virtsnd_pcm_pause_restart_sync_stop()?

[ ... ]

> @@ -945,10 +1039,12 @@ static int virtsnd_pcm_trigger(struct snd_pcm_subs=
tream *substream, int command)
>  			return -ENOMEM;
>  		}
> =20
> -		rc =3D virtsnd_ctl_msg_send_sync(snd, msg);
> -		if (rc)
> +		rc =3D virtsnd_pcm_send_sync(vss, msg);
> +		if (rc && rc !=3D -ECANCELED)
>  			virtsnd_pcm_start_failed(vss);
> =20
> +		if (!rc && vss->capture_staging)
> +			virtsnd_pcm_schedule_period_elapsed(vss);
>  		return rc;

[Severity: Medium]
When SNDRV_PCM_TRIGGER_PAUSE_RELEASE fails for a staged capture stream in
native-pause mode (vss->capture_staging &&
!virtsnd_pcm_pause_restart_enabled(vss)), does calling
virtsnd_pcm_start_failed() leave paused capture readers sleeping without
an XRUN notification?

When virtsnd_pcm_capture_send() fails earlier in virtsnd_pcm_trigger() on
SNDRV_PCM_TRIGGER_PAUSE_RELEASE, the error path sets vss->xfer_xrun =3D true
and calls virtsnd_pcm_schedule_period_elapsed(vss):

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_trigger() {
	...
			if (rc) {
				vss->stopped =3D true;
				substream->runtime->stop_operating =3D true;
				if (vss->capture_staging &&
				    vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
				    command =3D=3D SNDRV_PCM_TRIGGER_PAUSE_RELEASE) {
					/* Pause undo leaves ALSA paused; wake its readers. */
					vss->xfer_xrun =3D true;
					virtsnd_pcm_schedule_period_elapsed(vss);
				}
				return rc;
			}
}

However, if SNDRV_PCM_TRIGGER_PAUSE_RELEASE fails either at the initial
(vss->stopped || !vss->prepared) check or when allocating/sending
VIRTIO_SND_R_PCM_START via virtsnd_pcm_start_failed(), vss->xfer_xrun is
never set and vss->elapsed_period is not scheduled, so ALSA's pause undo
leaves runtime->state in SNDRV_PCM_STATE_PAUSED without transitioning the
stream to XRUN.

[ ... ]

> @@ -1135,8 +1244,12 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_su=
bstream *substream)
>  		return !rc ? -ETIMEDOUT : rc;
>  	}
> =20
> -	scoped_guard(spinlock_irqsave, &vss->lock)
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (vss->suspended)
> +			return -ECANCELED;
> +		vss->prepared =3D false;
>  		vss->stopped =3D false;
> +	}
> =20
>  	return 0;
>  }

[Severity: High]
Won't returning -ECANCELED when vss->suspended is true in
virtsnd_pcm_sync_stop_locked() and virtsnd_pcm_pause_restart_sync_stop()
permanently wedge the substream after SNDRV_PCM_TRIGGER_SUSPEND?

During system suspend, snd_pcm_suspend_all() triggers
SNDRV_PCM_TRIGGER_SUSPEND, which in virtsnd_pcm_trigger() and
virtsnd_pcm_pause_restart_stop(vss, true) sets both vss->suspended =3D true
and vss->stopped =3D true. When virtsnd_pcm_sync_stop_locked() (or
virtsnd_pcm_pause_restart_sync_stop()) then runs, it sends
VIRTIO_SND_R_PCM_RELEASE and flushes the queue, but returns -ECANCELED
because vss->suspended is true, leaving vss->stopped =3D true and
vss->prepared =3D true.

Because this patch also removes vss->suspended =3D false from
virtsnd_pcm_open(), vss->suspended is now only cleared in
virtsnd_pcm_prepare_locked() after the vss->stopped check:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_prepare_locked() {
	...
	scoped_guard(spinlock_irqsave, &vss->lock)
		stopped =3D vss->stopped;
	if (stopped) {
		dev_err(&vdev->dev, "SID %u: stream release failed\n",
			vss->sid);
		substream->runtime->stop_operating =3D true;
		return -EBADFD;
	}
	...
	scoped_guard(spinlock_irqsave, &vss->lock) {
		...
		vss->suspended =3D false;
}

Once vss->stopped and vss->suspended are both true:
- virtsnd_pcm_prepare_locked() sees vss->stopped =3D=3D true, sets
  runtime->stop_operating =3D true, and returns -EBADFD before reaching
  vss->suspended =3D false.
- virtsnd_pcm_hw_params() calls virtsnd_pcm_sync_stop_locked(), which sees
  need_release (vss->stopped is true) and vss->suspended =3D=3D true and fa=
ils
  with -ECANCELED.
- Closing and reopening the PCM device calls virtsnd_pcm_open(), which no
  longer clears vss->suspended and calls virtsnd_pcm_sync_stop(), failing
  open with -ECANCELED.

In addition, virtsnd_pcm_pause_restart_fail() and
virtsnd_pcm_start_failed() now return early when vss->suspended is true.
In virtsnd_pcm_prepare_locked(), the else branch of if (!suspended) calls
virtsnd_pcm_dev_set_params() while vss->suspended is still true; if
virtsnd_pcm_dev_set_params() fails, calling
virtsnd_pcm_pause_restart_fail(vss, false) is a no-op that skips setting
vss->stopped, vss->xfer_xrun, and runtime->stop_operating. Likewise, after
virtsnd_freeze() and virtsnd_restore(), vss->suspended remains true until
prepare succeeds, so a failed resume via SNDRV_PCM_TRIGGER_PAUSE_RELEASE
causes virtsnd_pcm_pause_restart_fail() to return early without setting
vss->xfer_xrun, scheduling vss->elapsed_period, or setting
runtime->stop_operating.

[ ... ]

> @@ -1415,12 +1531,52 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_subs=
tream *substream)
>  	return 0;
>  }
> =20
> +static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +
> +	guard(mutex)(&vss->lifecycle_lock);
> +	return virtsnd_pcm_sync_stop_locked(substream);
> +}
> +
> +static int virtsnd_pcm_ioctl(struct snd_pcm_substream *substream,
> +			    unsigned int cmd, void *arg)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	size_t position;
> +	size_t period;
> +	int rc;
> +
> +	if (cmd !=3D SNDRV_PCM_IOCTL1_RESET || !vss->capture_staging)
> +		return snd_pcm_lib_ioctl(substream, cmd, arg);
> +
> +	rc =3D snd_pcm_lib_ioctl(substream, cmd, arg);
> +	if (rc)
> +		return rc;
> +	guard(pcm_stream_lock_irqsave)(substream);
> +	runtime->status->hw_ptr %=3D runtime->buffer_size;
> +	position =3D frames_to_bytes(runtime, runtime->status->hw_ptr);
> +	period =3D snd_pcm_lib_period_bytes(substream);
> +	guard(spinlock_irqsave)(&vss->lock);
> +	vss->hw_ptr =3D position;
> +	vss->capture_copied_total =3D position;
> +	vss->capture_acked_total =3D position;
> +	vss->capture_pointer_seen_total =3D position;
> +	vss->capture_ready =3D 0;
> +	vss->capture_notified_periods =3D period ? position / period : 0;
> +	vss->capture_callback_snapshot =3D 0;
> +	vss->capture_callback_snapshot_active =3D false;
> +	vss->pcm_indirect.appl_ptr =3D runtime->status->hw_ptr;
> +	return 0;
> +}

[Severity: High]
What prevents virtsnd_pcm_ioctl() on SNDRV_PCM_IOCTL1_RESET from racing
with RX completions and virtsnd_pcm_period_elapsed() on a running staged
capture stream, or leaving RX buffers unqueued after clearing
vss->capture_ready?

When SNDRV_PCM_IOCTL_RESET is called while the stream is in
SNDRV_PCM_STATE_RUNNING:

1. snd_pcm_lib_ioctl() -> snd_pcm_lib_ioctl_reset() acquires the PCM
   stream lock, updates runtime->status->hw_ptr via
   virtsnd_pcm_cp_pointer(), reduces runtime->status->hw_ptr modulo
   runtime->buffer_size, and drops the PCM stream lock. Before
   virtsnd_pcm_ioctl() acquires vss->lock, virtsnd_pcm_capture_complete()
   can run in RX interrupt context: it checks ring capacity against the
   pre-reset vss->capture_ready (which can trigger a false ring_full XRUN)
   and advances vss->hw_ptr and vss->capture_copied_total as new audio is
   copied. virtsnd_pcm_ioctl() then overwrites vss->hw_ptr and
   vss->capture_copied_total with the older position sampled before
   vss->lock was taken, rewinding vss->hw_ptr over newly captured audio.

2. Between snd_pcm_lib_ioctl_reset() dropping the stream lock,
   virtsnd_pcm_ioctl() returning, and snd_pcm_do_reset() /
   snd_pcm_post_reset() re-acquiring the stream lock to zero
   runtime->hw_ptr_base and set runtime->control->appl_ptr =3D
   runtime->status->hw_ptr, virtsnd_pcm_period_elapsed() can run on
   system_highpri_wq. If virtsnd_pcm_period_elapsed() advances
   runtime->status->hw_ptr before snd_pcm_post_reset() sets
   runtime->control->appl_ptr =3D runtime->status->hw_ptr,
   runtime->control->appl_ptr is moved ahead of vss->pcm_indirect.appl_ptr
   and vss->capture_acked_total without an ACK callback, leaving
   vss->capture_ready inflated and causing subsequent ACKs or completions
   to fail with -EPIPE.

3. In bounded capture mode (!vss->capture_free_running),
   virtsnd_pcm_capture_enqueue() throttles queued RX descriptors based on
   vss->buffer_bytes - vss->capture_ready. After virtsnd_pcm_ioctl() resets
   vss->capture_ready =3D 0 on a running stream, nothing calls
   virtsnd_pcm_capture_send(vss) under queue->lock and vss->lock to refill
   held-back RX requests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D16
