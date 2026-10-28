Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158035;
	b=qaI1AL00jgKny4OCYiIytR3ierXnOeBH2nfueZaPf8/4v32wk+aTpC9JG8Vn822XXaTQ
	 DD+amLcztXMo5KOj6R+w/Xp6M8zO8Dta8M9TSMsHSNK2QxFzdsT94i+i6Fund/j6eUxje
	 2oGweg0/PgqBLUkO/TcLeYYa6u2LbBGw1hnD1lOvN2tzIprt1idhlG5h6c5NYHHVjmgkC
	 CwMmB4wF4YlSKhLw8fDaBf3PLruovhW9w4ttJMokmEoryMX19PzYqoOKVXrqXp3cN3iIa
	 7jSH10kZw9aBg6b25CX6iaFURPJ46Mncv2DTmr4EiRT3xbMnwkPrGODsDsNz4en54Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FiAyuvfDt7Lo7U7ff8w+xX2Qwp10ccWP1jO0lNR4T2k=;
	b=mgXwHelBcLEUNpbu2MA0gtP0UFcVucP+Jj+KGB6347xwDIWkpEMjdPwg1CnaJ2SjXT0c
	 nzhuy4YGRW+Y34KASEvz271tlQVRl1Uto5s7bVmlmJatcYQO19p1WyXovYgxB5GgiTNwD
	 uG2Xzlj1kl6R9pnL+3Qw/NU2cihK+oHwSlu7hp1oZIPaPmKnSnlLw/kzC9/txWQ5Whp4q
	 Wpa2NQvtTZ7zsMrqAjPRtBCVXToPa4pg/B8ypuChPxa2FCFZ8H6EDJgV1lc81zz8ZPdBW
	 mxxrWNg0MkXboi4NbcSLnm6S06CwzMjKbgG9DEm5fGX0tqL5iNS2tkB1/oOnB2BPg5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozvMFb8U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30541606A31A;
	Wed, 28 Oct 2026 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozvMFb8U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AE61F01825;
	Wed, 28 Oct 2026 03:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793158035;
	bh=FiAyuvfDt7Lo7U7ff8w+xX2Qwp10ccWP1jO0lNR4T2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ozvMFb8U7Z4Vy3jT520zS0mvDJWSOR6NH1g8yQfFAru0qeSIUHpAbEeTXK/sG7QGu
	 byhZCA1tJcWh3ynuEWiSrgqzB4SSlAgtYHy2ZGtL+ohQegagd3xaap4xtzaop15ElX
	 iNlEWTPyRdPE02ijazmL4tbDVgskZvUBnxsxaNrwOEfrWOSfslyefdpEcjESD6J2KV
	 ntPxeKaVNKok2EpQlyBKdlvO1hWZSD0shJTMFT6cIQttjNMnuCvOiuPAE6unLIcFuR
	 TEQ1wJyc3qBdEN1HjJSohmSWFdMPlq622Ad12GE4z9vpL9N3+bL/G4yoVJm3VQySb2
	 2f2LxPlMKp0Ow==
Message-ID: <sashiko-outbox-187420@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/14] ALSA: virtio: stage VZ capture and restart
 paused streams
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028025317.92450-8-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
 <20261028025317.92450-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:27:14 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] ALSA: virtio: unnotified capture periods across pause cause lost=
 wakeup or XRUN
- [Medium] ALSA: virtio: staged capture counters not updated on SNDRV_PCM_I=
OCTL_RESET
- [Medium] ALSA: virtio: race between virtsnd_pcm_pause_restart_sync_stop()=
 and prepare
--

commit 769b2eda886498f63ca7e4ba1a0aa3578ffd2f05
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: stage VZ capture and restart paused streams

This commit adds opt-in capture staging using request-owned buffers with
response validation and ring accounting, along with a pause release and
reprepare state machine for staged capture streams.

> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index be3893de40a55..a3478fc8848db 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c
> @@ -310,8 +310,94 @@ static void virtsnd_pcm_period_elapsed(struct work_s=
truct *work)
>  {
>  	struct virtio_pcm_substream *vss =3D
>  		container_of(work, struct virtio_pcm_substream, elapsed_period);
> +	struct snd_pcm_substream *substream =3D vss->substream;
> +	struct snd_pcm_runtime *runtime;
> +	size_t period_bytes;
> +	u64 period_floor;
> +	u64 snapshot;
> +	bool staged_capture;
> +	bool paused_xrun =3D false;
> +	bool notify =3D false;
> +	bool requeue =3D false;
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		staged_capture =3D vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +				 vss->capture_staging;
> +	}
> +
> +	if (!staged_capture) {
> +		snd_pcm_period_elapsed(substream);
> +		return;
> +	}
> +
> +	/* Serialize the pointer snapshot with ALSA's pointer and ACK callbacks=
. */
> +	guard(pcm_stream_lock_irqsave)(substream);
> +	if (!snd_pcm_running(substream)) {
> +		scoped_guard(spinlock_irqsave, &vss->lock) {
> +			runtime =3D substream->runtime;
> +			paused_xrun =3D runtime &&
> +				      runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED &&
> +				      vss->runtime_active && vss->xfer_xrun;
> +		}
> +		if (paused_xrun) {
> +			/* Wake readers without sending STOP for a paused stream. */
> +			snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
> +		}
> +		return;
> +	}

[Severity: Medium]
What happens if a staged capture completion crosses a period boundary right
before SNDRV_PCM_TRIGGER_PAUSE_PUSH?

When virtsnd_pcm_capture_complete() copies data crossing a period boundary
and schedules vss->elapsed_period right as snd_pcm_pause() runs,
snd_pcm_pause() holds pcm_stream_lock across virtsnd_pcm_trigger() and
snd_pcm_post_pause(), which sets runtime->state to SNDRV_PCM_STATE_PAUSED.

When virtsnd_pcm_period_elapsed() in sound/virtio/virtio_pcm.c subsequently
acquires pcm_stream_lock, !snd_pcm_running(substream) is true, so it returns
early without advancing vss->capture_notified_periods or calling
snd_pcm_period_elapsed_under_stream_lock() to update runtime->status->hw_pt=
r.

Later, when the stream is resumed via SNDRV_PCM_TRIGGER_PAUSE_RELEASE in
virtsnd_pcm_pause_restart_start() or virtsnd_pcm_trigger() in
sound/virtio/virtio_pcm_ops.c:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_pause_restart_start() {
	...
	scoped_guard(spinlock_irqsave, &queue->lock) {
		guard(spinlock)(&vss->lock);
		if (vss->pause_restart_state !=3D
			    VIRTSND_PCM_PAUSE_RESTART_PREPARED ||
		    vss->msg_count || !vss->runtime_active || vss->xfer_xrun) {
			rc =3D -EBADFD;
		} else {
			rc =3D virtsnd_pcm_capture_send(vss);
			if (!rc)
				vss->xfer_enabled =3D true;
		}
	}
}

vss->elapsed_period is not rescheduled even though
vss->capture_copied_total / period_bytes > vss->capture_notified_periods, a=
nd
snd_pcm_post_pause() does not call snd_pcm_update_hw_ptr().

Could this leave readers in poll() or wait_for_avail() sleeping with
avail =3D=3D 0, and on a 2-period buffer cause the next completed period to=
 hit
audio_bytes >=3D vss->buffer_bytes - vss->capture_ready in
virtsnd_pcm_capture_complete() and force a premature XRUN?

[ ... ]

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index f74bf365065b6..003832d112551 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -420,6 +932,106 @@ static int virtsnd_pcm_trigger(struct snd_pcm_subst=
ream *substream, int command)
>  	}
>  }
> =20
> +static int
> +virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	unsigned int js =3D msecs_to_jiffies(virtsnd_msg_timeout_ms);
> +	enum virtio_pcm_pause_restart_state state;
> +	struct virtio_snd_msg *msg;
> +	long waited;
> +	int rc;
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		vss->xfer_enabled =3D false;
> +		vss->stopped =3D true;
> +		state =3D vss->pause_restart_state;
> +	}
> +	cancel_work_sync(&vss->elapsed_period);
> +
> +	if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
> +	    virtsnd_pcm_pause_restart_transitioning(state)) {
> +		virtsnd_pcm_pause_restart_fail(vss, true);
> +		dev_err(&vss->snd->vdev->dev,
> +			"SID %u: PCM state is unknown; device reprobe required\n",
> +			vss->sid);
> +		return -EIO;
> +	}

[Severity: Medium]
Can a concurrent SNDRV_PCM_IOCTL_DROP and SNDRV_PCM_IOCTL_PREPARE race while
virtsnd_pcm_pause_restart_sync_stop() is sleeping and permanently wedge the
substream in VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED?

In sound/core/pcm_native.c, snd_pcm_drop() transitions runtime->state to
SNDRV_PCM_STATE_SETUP and sets runtime->stop_operating =3D true under
pcm_stream_lock_irq(), then drops the stream lock and calls
snd_pcm_sync_stop(substream, true) without holding runtime->buffer_mutex:

snd_pcm_drop()
  snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP)
    runtime->stop_operating =3D true;
  snd_pcm_stream_unlock_irq(substream)
  snd_pcm_sync_stop(substream, true)
    substream->runtime->stop_operating =3D false;
    substream->ops->sync_stop(substream)
      virtsnd_pcm_pause_restart_sync_stop()

Because snd_pcm_sync_stop() clears runtime->stop_operating before calling
virtsnd_pcm_pause_restart_sync_stop(), a second thread invoking
SNDRV_PCM_IOCTL_PREPARE while virtsnd_pcm_pause_restart_sync_stop() is
sleeping in virtsnd_pcm_pause_restart_send() or wait_event_timeout() will s=
ee
runtime->state =3D=3D SNDRV_PCM_STATE_SETUP and runtime->stop_operating =3D=
=3D false.

Its own call to snd_pcm_sync_stop() in snd_pcm_do_prepare() will then return
immediately without waiting for the first thread's sync_stop to finish, and
virtsnd_pcm_prepare() (or virtsnd_pcm_pause_restart_send()) in
sound/virtio/virtio_pcm_ops.c will observe the in-flight *_SUBMITTED state:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_prepare() {
	if (pause_restart) {
		enum virtio_pcm_pause_restart_state state;

		scoped_guard(spinlock_irqsave, &vss->lock)
			state =3D vss->pause_restart_state;
		if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
		    virtsnd_pcm_pause_restart_transitioning(state)) {
			virtsnd_pcm_pause_restart_fail(vss, true);
			return -EIO;
		}
	}
}

Wouldn't this transition vss->pause_restart_state to
VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED and leave the substream unusable
until device reprobe?

[ ... ]

> @@ -586,11 +1233,66 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_subst=
ream *substream)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
>  	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
>  	struct virtsnd_pcm_transfer transfer =3D {};
>  	int rc;
> =20
>  	scoped_guard(spinlock_irqsave, &queue->lock) {
>  		guard(spinlock)(&vss->lock);
> +		if (vss->capture_staging) {
> +			snd_pcm_uframes_t appl_ptr;
> +			snd_pcm_sframes_t diff;
> +			size_t bytes;
> +			u64 next_acked_total;
> +
> +			if (!vss->runtime_active || !runtime || !runtime->control ||
> +			    !runtime->dma_area)
> +				return -EBADFD;
> +			if (vss->xfer_xrun)
> +				return -EPIPE;
> +			if (!virtsnd_pcm_capture_counters_valid(vss)) {
> +				vss->xfer_xrun =3D true;
> +				schedule_work(&vss->elapsed_period);
> +				return -EPIPE;
> +			}
> +			appl_ptr =3D runtime->control->appl_ptr;
> +			diff =3D appl_ptr - vss->pcm_indirect.appl_ptr;
> +
> +			if (diff < -(snd_pcm_sframes_t)(runtime->boundary / 2))
> +				diff +=3D runtime->boundary;
> +			if (diff < 0 ||
> +			    (snd_pcm_uframes_t)diff > runtime->buffer_size) {
> +				vss->xfer_xrun =3D true;
> +				schedule_work(&vss->elapsed_period);
> +				return -EPIPE;
> +			}
> +
> +			/* ACK includes any subperiod tail already copied to the ring. */
> +			bytes =3D frames_to_bytes(runtime, diff);
> +			if (bytes > vss->capture_ready ||
> +			    check_add_overflow(vss->capture_acked_total, (u64)bytes,
> +					       &next_acked_total) ||
> +			    next_acked_total > vss->capture_copied_total) {
> +				vss->xfer_xrun =3D true;
> +				schedule_work(&vss->elapsed_period);
> +				return -EPIPE;
> +			}

[Severity: Medium]
How does the staged capture accounting handle SNDRV_PCM_IOCTL_RESET when a
stream is running or paused?

virtsnd_pcm_ops uses snd_pcm_lib_ioctl, which handles SNDRV_PCM_IOCTL1_RESET
via snd_pcm_lib_ioctl_reset(). When the stream is running or paused,
snd_pcm_lib_ioctl_reset() updates runtime->status->hw_ptr (wrapping it modu=
lo
runtime->buffer_size or zeroing it if paused), zeroes runtime->hw_ptr_base,
and sets runtime->control->appl_ptr =3D runtime->status->hw_ptr in
snd_pcm_post_reset() without calling substream->ops->ack().

Because vss->capture_ready, vss->capture_acked_total, and
vss->pcm_indirect.appl_ptr are not synchronized with that reset, any unread
bytes discarded by advancing appl_ptr to hw_ptr remain counted in
vss->capture_ready, which can cause virtsnd_pcm_capture_complete() to reject
subsequent completions with a ring_capacity or ring_full XRUN before the AL=
SA
ring is actually full.

Furthermore, once runtime->hw_ptr_base is non-zero (after a buffer wrap) or
when resetting while paused, resetting runtime->control->appl_ptr without
updating vss->pcm_indirect.appl_ptr causes the next call to
virtsnd_pcm_cp_ack() in sound/virtio/virtio_pcm_ops.c to compute a negative
diff =3D appl_ptr - vss->pcm_indirect.appl_ptr and fail with -EPIPE.

Should SNDRV_PCM_IOCTL1_RESET be intercepted in the ioctl callback to
reconcile vss->pcm_indirect.appl_ptr, vss->capture_acked_total, and
vss->capture_ready when vss->capture_staging is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025317.9245=
0-1-mynameisjune111@gmail.com?part=3D7
