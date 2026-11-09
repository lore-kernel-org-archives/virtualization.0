Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203674;
	b=khzJnysKjl/8GT2VdoMqkfVoVDFceIRc658g14r8SypMHKrVIBEZlbBhDvJeppo7nh4X
	 68Gz1h7e8dJtDBvvOcRUpvg47eHRhN75i+sUNfhsfw2OKqwkzKdFWe3mdvbB0FwGW9nJR
	 aLkeal97zM1/8vMIbaRN4byy0DmuqJe/UhGyM7dZcVQlhr3wkrTt5FXtBKjLJ7DM4gkPj
	 lIZ1QaODqmhlD7Y3spNtuE/Jq6LJdzBO5osUWEKr2+tb3jxLnlxvOLR5LJlvhofWndIG+
	 LhHqjtIdYwn3F1KvPs0/5pm1O1A61l73PqSJBQwZT1aKbZkOv7Q8pb2bHb7RPdQRLNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203674;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uBOBJ0aM3mjmzffqmN4XXCz6SYzcGrmriPlZl3XzQiI=;
	b=JJTY9PhtoJ7WIF48mBGAOacGx4OoRNsRJnI3tp1MGp4CghEXVUIORklIOKyWMFvZl3E+
	 0m4fP0FlW75O35JByNGL8YRuQ1QjHdCBbeI6d1tEpuBsxBvOUaIzG0CnUoBGtTjQRkDDZ
	 aOiICJvoBtFYNPHaMpuhhskZK9OjkI2yL3Cp99ZP9dZUfPkyQbxMx/AYyClnChJfimicF
	 j+PsHbxJ3rN0/VyQhsGmeaIIaVT9V4YpX2s9hkmcafbEyJhoXtVBVkcyPLorJTzUMiVjd
	 5OZvD/zvkJeGxY1zg91wi1Aj5mjNAvxar/R4h3J8Hex18uECSYZkX3fgtzX9tE1N+3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHRtGMvh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1C606A31C;
	Mon,  9 Nov 2026 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHRtGMvh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1481F0089F;
	Mon,  9 Nov 2026 05:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203674;
	bh=uBOBJ0aM3mjmzffqmN4XXCz6SYzcGrmriPlZl3XzQiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WHRtGMvhqdvhsyPJvAgyTf2YmT7oZrRwhYEEDVfKCQUewaYA5J5phzc/gBeXfCak9
	 PEpBM0OVBdSvhq4qxMsV5vJQyhOzUDKlhWCw8J32qvE4p9LKPq1wvnG0AkVJCaQy+Z
	 kd1+mSZhhLX33+x7+wvdEJdyvDeLcWxqD6fBIvSn56DMiQELy0DXjkyr3RbUt9CYPM
	 LoLl7ghOnaKQss0t1sZnl8aVmNkBFB1bnYVSg5GnKpEveyLoFEM+AIgxnYtDzoQNyx
	 vkoqQZzv2KUYWHOsrF8BSUoeD5YNL3cgbZ5a6ajO2/jJuSgfSlPHwgsl6nfIUBTS7f
	 4tGtwm1RkWUxw==
Message-ID: <sashiko-outbox-204463@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 11/13] ALSA: virtio: gate starts during PCM prepare
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109051618.22506-12-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
 <20261109051618.22506-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:54:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] ALSA: virtio: missing playback XRUN state in
  virtsnd_pcm_start_failed()
- [Medium] ALSA: virtio: PAUSE_PUSH rollback re-enables queue in
  virtsnd_pcm_trigger_inner()
- [Medium] ALSA: virtio: paused ACK validation skips XRUN latch in
  virtsnd_pcm_cp_ack_locked()
- [Medium] ALSA: virtio: unaligned appl_ptr in
  virtsnd_pcm_capture_staged_ack() passes hw_ptr
- [Low] ALSA: virtio: commit message omits staged capture, reset, and
  param changes
--

commit e0eac3208f73f40e886712be3453157819f1fd9f
Author: Joonho Lee <mynameisjune111@gmail.com>

> ALSA: virtio: gate starts during PCM prepare
>
> Use the prepare-completion callback to keep ACK admission closed until
> every linked member finishes device prepare and the core pointer reset.
> Clear the gate after success or failure, and keep failed members
> unprepared so a later ACK cannot use stale accounting.
>
> Keep START and PAUSE_RELEASE admission checks at the virtio trigger and
> deferred restart entry points. Preserve the existing capture lifecycle
> and reset rules.
>
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

[Severity: Low]
Does the commit message match the actual changes in this patch?

While the changelog describes gating ACK and start admission during
prepare and claims to preserve the existing capture lifecycle and reset
rules, the patch adds a request-owned staged capture path, five new
module parameters (capture_staging, capture_packed_status,
capture_allow_short, capture_allow_empty, and capture_pause_restart), a
pause-restart state machine, custom reset callbacks
(virtsnd_pcm_playback_reset(), virtsnd_pcm_indirect_reset(), and
virtsnd_pcm_reset()), and manual DMA buffer management replacing
snd_pcm_set_managed_buffer_all().

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index b9728d04ce608..b2a569866d5c9 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -97,46 +131,265 @@ static const struct virtsnd_a2v_rate g_a2v_rate_map=
[] =3D {
>  };
> =20
>  static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);
> +static int virtsnd_pcm_sync_stop_locked(struct snd_pcm_substream *substr=
eam);
> +static int virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream =
*substream);
> =20
> -/**
> - * virtsnd_pcm_close_ack() - Update PCM prepare admission state.
> - * @substream: Kernel ALSA substream.
> - * @preparing: True while driver prepare and the core pointer reset are =
active.
> - *
> - * Context: Process context.
> - */
> -static void virtsnd_pcm_close_ack(struct snd_pcm_substream *substream,
> -				  bool preparing)
> +static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss, u=
64 epoch)
>  {
> -	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	bool notify;
> =20
> -	scoped_guard(pcm_stream_lock_irqsave, substream) {
> -		guard(spinlock_irqsave)(&vss->lock);
> -		vss->prepared =3D false;
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (vss->resetting || vss->reset_epoch !=3D epoch)
> +			return;
>  		vss->xfer_enabled =3D false;
> -		vss->preparing =3D preparing;
> +		vss->stopped =3D vss->release_required || vss->msg_count;
> +		notify =3D vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +			 (!vss->capture_staging || vss->runtime_active);
> +		if (notify)
> +			vss->xfer_xrun =3D true;
>  	}
> +	vss->substream->runtime->stop_operating =3D true;
> +	if (notify)
> +		virtsnd_pcm_schedule_period_elapsed(vss);
>  }

[Severity: Medium]
Should virtsnd_pcm_start_failed() also latch vss->xfer_xrun and schedule
vss->elapsed_period for playback streams?

When SNDRV_PCM_TRIGGER_START or SNDRV_PCM_TRIGGER_PAUSE_RELEASE fails on
a playback substream, vss->stopped is set to true while vss->xfer_xrun
remains false.  A subsequent SNDRV_PCM_TRIGGER_PAUSE_RELEASE (such as
during snd_pcm_drop() or snd_pcm_prepare() on a paused stream) then skips
virtsnd_pcm_defer_resume_xrun() and fails in virtsnd_pcm_start_queue()
with -EBADFD, and a start failure during snd_pcm_do_drain_init() or
snd_pcm_undo_pause() leaves the stream in RUNNING or DRAINING without
virtsnd_pcm_pb_pointer() ever reporting SNDRV_PCM_POS_XRUN.

[ ... ]

> +		rc =3D virtsnd_pcm_stop_device(vss, epoch);
> +		if (rc && command !=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH) {
> +			guard(spinlock_irqsave)(&vss->lock);
> =20
> -		return virtsnd_ctl_msg_send_sync(snd, msg);
> +			if (vss->reset_epoch =3D=3D epoch && !vss->resetting) {
> +				vss->xfer_xrun =3D true;
> +				substream->runtime->stop_operating =3D true;
> +				if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE)
> +					virtsnd_pcm_schedule_period_elapsed(vss);
> +			}
> +		}
> +		if (rc && command =3D=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH) {
> +			if (virtsnd_pcm_start_queue(vss, epoch)) {
> +				guard(spinlock_irqsave)(&vss->lock);
> +				if (vss->reset_epoch =3D=3D epoch && !vss->resetting) {
> +					vss->xfer_xrun =3D true;
> +					vss->stopped =3D true;
> +					substream->runtime->stop_operating =3D true;
> +					virtsnd_pcm_schedule_period_elapsed(vss);
> +				}
> +			} else if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> +				virtsnd_pcm_schedule_period_elapsed(vss);
> +			}
> +		}
> +		return rc;

[Severity: Medium]
Can a failed SNDRV_PCM_TRIGGER_PAUSE_PUSH re-enable the queue while
substream->runtime->state is SNDRV_PCM_STATE_PAUSED?

When resuming a linked group from pause fails on a later member,
snd_pcm_undo_pause() calls trigger(SNDRV_PCM_TRIGGER_PAUSE_PUSH) on
earlier members while their runtime->state is still
SNDRV_PCM_STATE_PAUSED and ignores the return value.  If
virtsnd_pcm_stop_device() fails during that rollback, calling
virtsnd_pcm_start_queue() leaves vss->xfer_enabled set and capture
buffers queued on a paused substream instead of latching vss->xfer_xrun
and vss->stopped.

[ ... ]

> +		appl_ptr =3D runtime->control->appl_ptr;
> +		diff =3D appl_ptr - vss->pcm_indirect.appl_ptr;
> +		if (diff < -(snd_pcm_sframes_t)(runtime->boundary / 2))
> +			diff +=3D runtime->boundary;
> +		if (diff < 0)
> +			return virtsnd_pcm_ack_xrun_locked(vss, runtime);
> +		appl_diff =3D diff;
> +		ack_frames =3D appl_diff - appl_diff % runtime->min_align;
> +		if (ack_frames > runtime->buffer_size ||
> +		    (appl_diff > runtime->buffer_size &&
> +		     appl_diff - runtime->buffer_size >=3D runtime->min_align)) {
> +			return virtsnd_pcm_ack_xrun_locked(vss, runtime);
> +		}
> +
> +		/* ACK includes any subperiod tail already copied to the ring. */
> +		bytes =3D frames_to_bytes(runtime, ack_frames);
> +		outstanding =3D vss->capture_copied_total -
> +			      vss->capture_acked_total;
> +		if ((!free_running && bytes > vss->capture_ready) ||
> +		    (free_running &&
> +		     (bytes > vss->buffer_bytes || bytes > outstanding)) ||
> +		    check_add_overflow(vss->capture_acked_total, (u64)bytes,
> +				       &next_acked_total) ||
> +		    next_acked_total > vss->capture_pointer_seen_total) {
> +			return virtsnd_pcm_ack_xrun_locked(vss, runtime);
> +		}
> +
> +		vss->capture_acked_total =3D next_acked_total;
> +		if (!free_running)
> +			vss->capture_ready -=3D bytes;
> +		/* Keep any unaligned frame tail for the next acknowledgment. */
> +		vss->pcm_indirect.appl_ptr +=3D ack_frames;
> +		if (vss->pcm_indirect.appl_ptr >=3D runtime->boundary)
> +			vss->pcm_indirect.appl_ptr -=3D runtime->boundary;
> +	}

[Severity: Medium]
Can an unaligned appl_ptr update in virtsnd_pcm_capture_staged_ack()
advance runtime->control->appl_ptr past runtime->status->hw_ptr?

For sub-byte frame formats where runtime->min_align > 1 (such as
1-channel SNDRV_PCM_FORMAT_IMA_ADPCM), rounding appl_diff down to
ack_frames and returning 0 lets pcm_lib_apply_appl_ptr() commit the
unaligned runtime->control->appl_ptr even when bytes =3D=3D
vss->capture_ready and no unread sample covers the tail frame.  That puts
appl_ptr ahead of hw_ptr and causes snd_pcm_capture_avail() to underflow
near runtime->boundary.  Rejecting unaligned appl_diff with -EBADFD, as
virtsnd_pcm_capture_ack_validate() does, would prevent the partial-frame
advance.

[ ... ]

> +	scoped_guard(spinlock_irqsave, &queue->lock) {
> +		guard(spinlock)(&vss->lock);
> +		paused =3D runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED;
> +		if (vss->preparing)
> +			return -EBADFD;
> +		/* A latched XRUN must not re-arm sync_stop once teardown began. */
> +		if (vss->stopped && vss->xfer_xrun)
> +			return -EBADFD;
> +		if (vss->xfer_xrun) {
> +			rc =3D virtsnd_pcm_ack_xrun_locked(vss, runtime);
> +		} else {
> +			if (!vss->prepared ||
> +			    (vss->stopped &&
> +			     runtime->state !=3D SNDRV_PCM_STATE_DRAINING))
> +				return -EBADFD;
> +			rc =3D virtsnd_pcm_capture_ack_validate(vss, runtime,
> +							      &skip_transfer);
> +			if (rc =3D=3D -EBADFD || (rc && paused))
> +				return -EBADFD;
> +			if (!rc && skip_transfer)
> +				return 0;
> +			if (!rc) {
>  				transfer.indirect =3D vss->pcm_indirect;
>  				rc =3D snd_pcm_indirect_capture_transfer(substream,
>  								       &transfer.indirect,
>  								       virtsnd_pcm_trans_copy);
>  			}
>  		}
>  		if (!rc)
>  			rc =3D transfer.error;
> -		if (rc)
> -			virtsnd_pcm_transfer_failed(vss);
> -		else
> +		if (rc) {
> +			if (paused)
> +				rc =3D virtsnd_pcm_ack_xrun_locked(vss, runtime);
> +			else
> +				virtsnd_pcm_transfer_failed(vss);
> +		} else {
>  			vss->pcm_indirect =3D transfer.indirect;
> +		}
>  	}

[Severity: Medium]
Does returning -EBADFD on (rc && paused) right after
virtsnd_pcm_capture_ack_validate() skip latching the paused XRUN?

When virtsnd_pcm_capture_ack_validate() returns -EPIPE while paused, the
early return bypasses virtsnd_pcm_ack_xrun_locked() below, so
vss->xfer_xrun is never latched and the XRUN is not deferred to pause
release as in virtsnd_pcm_pb_ack_locked().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109051618.2250=
6-1-mynameisjune111@gmail.com?part=3D11
