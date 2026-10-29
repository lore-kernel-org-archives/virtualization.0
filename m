Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793255007;
	b=4euZLyA/DZEIKejJQOHwQpid0M9LtkNQuNtNbJwxRZ+6t80M6D7MsT5LIe5nofcpv4GB
	 +XAZDf6sOQvFJgeCi9P6FkBc4f0RfKtuMzmIc2WfO/v7g8BMHh5/gumRbeWXcixJW32Zd
	 yQcVeL7yyLoArnRqHRhDSc7+fR9voEHF8C6zyGj5rukQYSwP9CCqPLjB6H7l712rNN2ev
	 9WAG4rptuivYMzPhTKQag3GO8+oSUMIYivJxVqhXSrOXggDx3S23tUrd7RwbxMxqnFRhL
	 KyCF9R7+UhVDieoItlKly786QpBOhWBDJZyiH5TGKs6DPmwFFRNrkQZMG3iNGrxFqSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255007;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0Ms/WuTPVPWJCfn5f/kSqo3PM4pnNWzpUyCXprVsEBY=;
	b=sjWU3WQh7tkBT3wBigZ+ilHyf1mxUfyoEM8R/nOcaMPTJgaudpVtWy3jI5GWVFSYOuIA
	 1Wtqycc5WAhNTfO/Hpsu00hq2GBO4/r9RAxuujKz6eagpX6AE+QMq/UxESiZjM0Rzlvy2
	 rGIhlVkwHoTUJ8KNiRXF1HklmnLtc8xs2CG1mSHgdbqKjYQvGQk21rysP5hEJQ3OZTnPr
	 rE3Q0fubFNmEGgbzmXPJS1Upy6cY18WC4Uh+78zCJtnY1zlC4P3EcRPRPrc7PPsN9j/MV
	 PQdb8eBo5WP8s0SoiDw3XPb1bY6h1IXYRcPg+WNFjvvrg4ZlfssmtyhJlgGUCEPEpSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JK54mUKO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A57A606A31C;
	Thu, 29 Oct 2026 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JK54mUKO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E04D1F01825;
	Thu, 29 Oct 2026 06:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793255006;
	bh=0Ms/WuTPVPWJCfn5f/kSqo3PM4pnNWzpUyCXprVsEBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JK54mUKOBBuKgKpq8qYC9fwSHW88itpq2Ptc4DHd6kzigUTQQ51Fwd4spqhkC7B+O
	 7s6H+Pny/96bFXgmdMMkDZUJZsdw8iV5QbhB+XxuZOyqgs5BZn+rTP66yPXHS40JlU
	 sor5x+6pJW2fLMcH/xh+0zhez8749MD4khL0p+Turo9xcy2Lm7UYNXJVEHQFLokcL6
	 SPnAoncHX4Bvst84cO0l00teXrCf15QM5AfDmpnIfk11GUuUymoXVTekB3z405zYRe
	 ZQ3w/nfp2q/LS9bSN2eiGMhe4JodpTvkQI69OgCj/n+IOfhfFOFeXfosgzWvAWbL97
	 rrgPGGz1R0TPg==
Message-ID: <sashiko-outbox-188815@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/14] ALSA: virtio: add staged capture accounting
 and lifecycle recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029054354.2931-10-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
 <20261029054354.2931-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:23:26 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] ALSA: virtio: virtsnd_pcm_prepare_locked() fails after playback pr=
e-buffering
- [High] ALSA: virtio: virtsnd_pcm_trigger() sends PCM_STOP when stream is =
not running
- [High] ALSA: virtio: virtsnd_pcm_start_failed() marks unprepared stream s=
topped
- [Medium] ALSA: virtio: missed period wakeup in virtsnd_pcm_period_elapsed=
()
- [Medium] ALSA: virtio: unreleased device stream on failed re-prepare in v=
irtsnd_pcm_prepare_locked()
- [Medium] ALSA: virtio: reset_epoch TOCTOU in virtsnd_pcm_send_sync() help=
ers
- [Low] ALSA: virtio: virtsnd_pcm_trigger() mixes goto cleanup with guard()=
 helpers
--

commit 775188574a684cd4f7321eccd1403d5cf535ff0a
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: add staged capture accounting and lifecycle recovery

This commit introduces staged capture with separate produced, observed, and
consumed positions using request-owned buffers, along with a free-running
capture policy for boundary stop thresholds. It also adds a lifecycle mutex,
reset epoch tracking, and an opt-in pause-restart state machine to handle
control transitions and device reset recovery.

> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index be3893de40a55..ecd017edba72c 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c
> @@ -310,8 +310,98 @@ static void virtsnd_pcm_period_elapsed(struct work_s=
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

[ ... ]

> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		runtime =3D substream->runtime;
> +		if (!vss->runtime_active ||
> +		    (!vss->xfer_enabled && !vss->xfer_xrun) || !runtime)
> +			return;
> +
> +		period_bytes =3D snd_pcm_lib_period_bytes(substream);
> +		if (vss->xfer_xrun) {
> +			notify =3D true;
> +		} else if (!period_bytes || period_bytes >=3D vss->buffer_bytes ||
> +			   !virtsnd_pcm_capture_counters_valid(vss) ||
> +			   vss->capture_notified_periods >
> +				div64_ul(vss->capture_copied_total, period_bytes)) {
> +			vss->xfer_xrun =3D true;
> +			notify =3D true;
> +		} else {
> +			period_floor =3D div64_ul(vss->capture_copied_total, period_bytes);
> +			if (period_floor > vss->capture_notified_periods) {
> +				/* Reserve crossed boundaries before the callback. */
> +				vss->capture_notified_periods =3D period_floor;
> +				notify =3D true;
> +			}
> +		}
> +
> +		if (notify) {
> +			snapshot =3D vss->capture_copied_total;
> +			vss->capture_callback_snapshot =3D snapshot;
> +			vss->capture_callback_snapshot_active =3D true;
> +		}
> +	}

[Severity: Medium]
When virtsnd_capture_staging and virtsnd_capture_allow_short are enabled, c=
an
gating period notifications strictly on integer multiples of period_bytes in
virtsnd_pcm_period_elapsed() miss a period wakeup and trigger a ring_capaci=
ty
xrun?

When virtsnd_pcm_period_elapsed() sets vss->capture_callback_snapshot to
vss->capture_copied_total (or when virtsnd_pcm_cp_pointer() is called
directly), any sub-period tail is exposed to the reader and acknowledged via
virtsnd_pcm_cp_ack() -> virtsnd_pcm_capture_staged_ack().

If a subsequent short completion in virtsnd_pcm_capture_complete() crosses =
the
next integer multiple of period_bytes while total unacknowledged data
(vss->capture_copied_total - vss->capture_acked_total) is still less than o=
ne
period, virtsnd_pcm_period_elapsed() advances vss->capture_notified_periods=
 to
period_floor and calls snd_pcm_period_elapsed_under_stream_lock(), which le=
aves
the reader sleeping because available frames are below avail_min.

If another short completion then arrives within that same period_floor
interval and brings unacknowledged bytes in vss->capture_ready to at least
period_bytes without crossing the next integer period boundary,
period_floor > vss->capture_notified_periods is false and notify remains
false. On a two-period buffer, leaving at least period_bytes unacknowledged=
 in
vss->capture_ready causes the next full-period completion in
virtsnd_pcm_capture_complete() to fail:

	else if (!free_running &&
		 audio_bytes >=3D vss->buffer_bytes - vss->capture_ready)
		invalid_reason =3D "ring_capacity";

Should virtsnd_pcm_period_elapsed() also notify when unacknowledged bytes
reach period_bytes even if period_floor has not advanced?

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index f74bf365065b6..66560d82b7f8e 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -97,14 +128,238 @@ static const struct virtsnd_a2v_rate g_a2v_rate_map=
[] =3D {
>  };
> =20
>  static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);
> +static int virtsnd_pcm_sync_stop_locked(struct snd_pcm_substream *substr=
eam);
> +static int virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream =
*substream);
> =20
> -static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss)
> +static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss, u=
64 epoch)
>  {
> +	bool notify;
> +
>  	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (vss->resetting || vss->reset_epoch !=3D epoch)
> +			return;
>  		vss->xfer_enabled =3D false;
>  		vss->stopped =3D true;
> +		notify =3D vss->runtime_active && vss->capture_staging &&
> +			 vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE;
> +		if (notify)
> +			vss->xfer_xrun =3D true;
>  	}
>  	vss->substream->runtime->stop_operating =3D true;
> +	if (notify)
> +		virtsnd_pcm_schedule_period_elapsed(vss);
> +}

[Severity: High]
Does unconditionally setting vss->stopped =3D true in virtsnd_pcm_start_fai=
led()
cause virtsnd_pcm_sync_stop_locked() to send an invalid release command whe=
n a
stream is not prepared on the device?

After a device reset and restore (virtsnd_reset_vqs() -> virtsnd_restore()),
or after a failed re-prepare in virtsnd_pcm_prepare_locked(), vss->prepared=
 is
false, vss->stopped is false, and vss->msg_count is 0, while the substream
runtime state can still be paused or prepared.

If userspace then drops, prepares, or closes a paused substream (calling
snd_pcm_pause() -> virtsnd_pcm_trigger()), or starts a prepared substream,
virtsnd_pcm_trigger() sees !vss->prepared and jumps to start_failed:

	if (vss->stopped || !vss->prepared || vss->xfer_xrun) {
		rc =3D vss->xfer_xrun ? -EPIPE : -EBADFD;
		goto start_failed;
	}

virtsnd_pcm_start_failed() then sets vss->stopped =3D true and
runtime->stop_operating =3D true even though the device stream was never
prepared in the current epoch and has no queued messages. When
virtsnd_pcm_sync_stop_locked() subsequently runs, need_release evaluates to
true because vss->stopped is set, so it sends a release control message for=
 an
unprepared stream. If the device rejects that release request,
virtsnd_pcm_sync_stop_locked() returns an error with vss->stopped still tru=
e,
wedging subsequent prepare, hw_params, and open calls.

Should virtsnd_pcm_start_failed() only set vss->stopped and
runtime->stop_operating when vss->prepared || vss->msg_count is true?

[ ... ]

> +static int virtsnd_pcm_send_sync(struct virtio_pcm_substream *vss,
> +				 struct virtio_snd_msg *msg)
> +{
> +	u64 epoch;
> +	int rc;
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (vss->resetting) {
> +			virtsnd_ctl_msg_unref(msg);
> +			return -ECANCELED;
> +		}
> +		epoch =3D vss->reset_epoch;
> +	}
> +	rc =3D virtsnd_ctl_msg_send_sync(vss->snd, msg);
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (epoch !=3D vss->reset_epoch || vss->resetting)
> +			return -ECANCELED;
> +	}
> +	return rc;
> +}
> +
> +static int
> +virtsnd_pcm_pause_restart_send(struct virtio_pcm_substream *vss,
> +			       struct virtio_snd_msg *msg,
> +			       unsigned long allowed_states,
> +			       enum virtio_pcm_pause_restart_state submitted_state,
> +			       enum virtio_pcm_pause_restart_state success_state)
> +{
> +	enum virtio_pcm_pause_restart_state state;
> +	bool uncertain;
> +	u64 epoch;
> +	int rc;
> +
> +	if (!virtsnd_pcm_pause_restart_enabled(vss))
> +		return virtsnd_pcm_send_sync(vss, msg);
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		epoch =3D vss->reset_epoch;
> +		state =3D vss->pause_restart_state;
> +		if (vss->resetting) {
> +			rc =3D -ECANCELED;
> +		} else if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED) {
> +			rc =3D -EIO;
> +		} else if (virtsnd_pcm_pause_restart_transitioning(state)) {
> +			vss->pause_restart_state =3D
> +				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
> +			rc =3D -EIO;
> +		} else if (!(allowed_states & BIT(state))) {
> +			rc =3D -EBADFD;
> +		} else {
> +			vss->pause_restart_state =3D submitted_state;
> +			rc =3D 0;
> +		}
> +	}

[Severity: Medium]
Can re-sampling vss->reset_epoch inside virtsnd_pcm_send_sync() and
virtsnd_pcm_pause_restart_send() allow a control request from before a devi=
ce
reset to be sent in the new epoch?

Callers such as virtsnd_pcm_trigger(), virtsnd_pcm_prepare_locked(),
virtsnd_pcm_sync_stop_locked(), virtsnd_pcm_pause_release_flush(),
virtsnd_pcm_pause_restart_start(), virtsnd_pcm_pause_restart_pause(), and
virtsnd_pcm_pause_restart_sync_stop() check substream state (and in the sta=
rt
paths, queue virtqueue buffers) under vss->lock while recording
epoch =3D vss->reset_epoch, then drop vss->lock to call cancel_work_sync() =
or
virtsnd_pcm_ctl_msg_alloc() before calling virtsnd_pcm_send_sync() or
virtsnd_pcm_pause_restart_send().

If virtsnd_reset_vqs() and virtsnd_restore() both complete during that
unlocked window, vss->resetting is false again and vss->reset_epoch has been
incremented. Because virtsnd_pcm_send_sync() and
virtsnd_pcm_pause_restart_send() overwrite their local epoch variable with =
the
new vss->reset_epoch instead of checking the caller's epoch, they can send a
stale start, stop, release, or prepare command to the freshly restored devi=
ce,
or fail the state check against the reset pause_restart_state with -EBADFD
instead of -ECANCELED.

Should virtsnd_pcm_send_sync() and virtsnd_pcm_pause_restart_send() take the
caller's expected epoch parameter and return -ECANCELED if vss->reset_epoch=
 no
longer matches?

[ ... ]

> @@ -277,27 +587,90 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_sub=
stream *substream,

[ ... ]

>  static int virtsnd_pcm_prepare_locked(struct snd_pcm_substream *substrea=
m)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
>  	struct virtio_device *vdev =3D vss->snd->vdev;
> -	struct virtio_snd_msg *msg;
> +	bool pause_restart =3D virtsnd_pcm_pause_restart_enabled(vss);
> +	bool free_running;
> +	int rc;
>  	bool stopped;
> +	bool suspended;
> +	u64 epoch;
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (vss->resetting)
> +			return -ECANCELED;
> +		stopped =3D vss->stopped;
> +	}
> +	if (stopped) {\n+		rc =3D virtsnd_pcm_sync_stop_locked(substream);
> +		if (rc)
> +			return rc;
> +	}
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		vss->prepared =3D false;
> +		epoch =3D vss->reset_epoch;
> +		suspended =3D vss->suspended;
> +	}
> +
> +	if (pause_restart) {
> +		enum virtio_pcm_pause_restart_state state;
> +
> +		scoped_guard(spinlock_irqsave, &vss->lock)
> +			state =3D vss->pause_restart_state;
> +		if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
> +		    virtsnd_pcm_pause_restart_transitioning(state)) {
> +			virtsnd_pcm_pause_restart_fail(vss, true, epoch);
> +			return -EIO;
> +		}
> +	}
> =20
>  	scoped_guard(spinlock_irqsave, &vss->lock)
>  		stopped =3D vss->stopped;
> @@ -308,44 +681,320 @@ static int virtsnd_pcm_prepare(struct snd_pcm_subs=
tream *substream)
>  		return -EBADFD;
>  	}
> =20
> -	if (!vss->suspended) {
> +	if (!suspended) {
>  		if (virtsnd_pcm_msg_pending_num(vss)) {
>  			dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
>  				vss->sid);
>  			return -EBADFD;
>  		}
> =20
> -		vss->buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
> -		vss->hw_ptr =3D 0;

[Severity: High]
What happens in virtsnd_pcm_prepare_locked() if a playback stream queues
at least one period while in the prepared state before reaching
runtime->start_threshold, and userspace then calls snd_pcm_drop() followed =
by
snd_pcm_prepare() (or calls snd_pcm_prepare() directly)?

During playback pre-buffering, pcm_lib_apply_appl_ptr() ->
virtsnd_pcm_pb_ack() -> snd_pcm_indirect_playback_transfer() ->
virtsnd_pcm_trans_copy() -> virtsnd_pcm_msg_send() submits full periods to =
the
tx virtqueue and increments vss->msg_count while the stream is still in the
prepared state and vss->stopped is false. Because snd_pcm_do_stop() only
invokes trigger(stop) when the stream is running or paused, vss->stopped
remains false.

When virtsnd_pcm_prepare_locked() runs (and similarly in
virtsnd_pcm_sync_stop()), it only checks if (stopped) before calling
virtsnd_pcm_sync_stop_locked(substream), skipping the release flush even
though vss->msg_count > 0. It then clears vss->prepared =3D false and fails=
 the
virtsnd_pcm_msg_pending_num(vss) check with -EBADFD, leaving pending messag=
es
in the queue with vss->stopped =3D=3D false and vss->prepared =3D=3D false =
so
subsequent prepare or write calls cannot recover until hw_params or hw_free.

Should virtsnd_pcm_prepare_locked() and virtsnd_pcm_sync_stop() also run
virtsnd_pcm_sync_stop_locked() when vss->msg_count > 0?

>  	} else {
>  		struct snd_pcm_runtime *runtime =3D substream->runtime;
>  		unsigned int buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
>  		unsigned int period_bytes =3D snd_pcm_lib_period_bytes(substream);
> -		int rc;
> =20
>  		rc =3D virtsnd_pcm_dev_set_params(vss, buffer_bytes, period_bytes,
>  						runtime->channels,
>  						runtime->format, runtime->rate);
> -		if (rc)
> +		if (rc) {
> +			if (pause_restart && rc !=3D -ECANCELED)
> +				virtsnd_pcm_pause_restart_fail(vss, false, epoch);
>  			return rc;
> +		}
>  	}
> =20
> -	vss->xfer_xrun =3D false;
> -	vss->suspended =3D false;
> -	vss->msg_count =3D 0;
> -	virtsnd_pcm_msg_reset(vss);
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (epoch !=3D vss->reset_epoch || vss->resetting)
> +			return -ECANCELED;
> +		vss->prepared =3D false;
> +		vss->buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
> +		vss->hw_ptr =3D 0;
> +		if (!pause_restart)
> +			vss->xfer_xrun =3D false;
> +		vss->suspended =3D false;
> +		vss->msg_count =3D 0;
> +		virtsnd_pcm_msg_reset(vss);
> +		memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
> +		vss->pcm_indirect.sw_buffer_size =3D vss->buffer_bytes;
> +		vss->pcm_indirect.hw_buffer_size =3D vss->buffer_bytes;
> +		if (vss->capture_staging) {
> +			vss->capture_boundary =3D substream->runtime->boundary;
> +			rc =3D virtsnd_pcm_capture_refresh_mode_locked(vss,
> +							     &free_running);
> +			if (rc)
> +				return rc;
> +		}
> +	}
> =20
> -	memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
> -	vss->pcm_indirect.sw_buffer_size =3D
> -		vss->pcm_indirect.hw_buffer_size =3D
> -		snd_pcm_lib_buffer_bytes(substream);
> +	rc =3D virtsnd_pcm_dev_prepare(vss);
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (epoch !=3D vss->reset_epoch || vss->resetting)
> +			return -ECANCELED;
> +		vss->prepared =3D !rc;
> +	}

[Severity: Medium]
In virtsnd_pcm_prepare_locked(), if the substream was already prepared on t=
he
device (vss->prepared was true, vss->stopped was false) and userspace calls
prepare again without pause_restart enabled, what happens if
virtsnd_pcm_dev_prepare() fails (or if virtsnd_pcm_dev_set_params() or
virtsnd_pcm_capture_refresh_mode_locked() fails earlier)?

Because vss->prepared is cleared to false at the start of
virtsnd_pcm_prepare_locked() without recording that the device stream was
already prepared, a failure when !pause_restart leaves both vss->prepared a=
nd
vss->stopped false. When virtsnd_pcm_hw_free() later runs on close:

	scoped_guard(spinlock_irqsave, &vss->lock) {
		vss->stopped |=3D vss->prepared;
		vss->prepared =3D false;
		vss->runtime_active =3D false;
		vss->xfer_enabled =3D false;
	}
	rc =3D virtsnd_pcm_sync_stop_locked(substream);

virtsnd_pcm_sync_stop_locked() sees vss->prepared, vss->stopped, and
vss->msg_count all false/zero and skips sending the release command to the
device. Should a failed re-prepare preserve the need to release a previously
prepared device stream (or release it before re-preparing)?

[ ... ]

> @@ -372,38 +1042,51 @@ static int virtsnd_pcm_trigger(struct snd_pcm_subs=
tream *substream, int command)

[ ... ]

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
>  		}
> =20
>  		msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP,
>  						GFP_KERNEL);
>  		if (!msg)
>  			return -ENOMEM;
> =20
> -		return virtsnd_ctl_msg_send_sync(snd, msg);
> +		return virtsnd_pcm_send_sync(vss, msg);

[Severity: High]
When virtsnd_pcm_pause_restart_enabled(vss) is false, can the stop and
pause_push cases in virtsnd_pcm_trigger() send a stop control request when =
the
device stream is not running?

Unlike virtsnd_pcm_pause_restart_stop(), which returns 0 when the state is =
not
running, this path only checks if (!vss->prepared). That appears to allow
sending an invalid or duplicate stop request in two situations:

1. When a running stream is paused via pause_push, virtsnd_pcm_trigger() se=
nds
a stop request to the device while leaving vss->prepared =3D true and setti=
ng
vss->xfer_enabled =3D false. If that paused stream is then stopped (for exa=
mple
via snd_pcm_drop(), close, or paused xrun handling in
virtsnd_pcm_period_elapsed() -> snd_pcm_stop()), snd_pcm_do_stop() invokes
virtsnd_pcm_trigger() with the stop command while vss->prepared is still tr=
ue,
sending a second stop request to a stream that is already stopped on the
device.

2. If start or pause_release fails in virtsnd_pcm_trigger() on an unlinked
stream, virtsnd_pcm_start_failed() leaves vss->prepared =3D true. In
snd_pcm_action_single(), the error path calls ops->undo_action()
(snd_pcm_undo_start() or snd_pcm_undo_pause()), which invokes
virtsnd_pcm_trigger() with stop or pause_push and sends a stop request even
though start failed.

Also, if pause_push fails in virtsnd_pcm_ctl_msg_alloc() or
virtsnd_pcm_send_sync(), vss->xfer_enabled has already been cleared to false
without marking the stream stopped, and snd_pcm_action_single() will call
snd_pcm_undo_pause() -> virtsnd_pcm_trigger(pause_release) on the still-run=
ning
device stream. Should the non-pause-restart stop/pause path check whether t=
he
stream was actually running before sending the stop request, and call
virtsnd_pcm_start_failed() if sending stop for pause_push fails?

>  	default:
>  		return -EINVAL;
>  	}
> +
> +start_failed:
> +	virtsnd_pcm_start_failed(vss, epoch);
> +	return rc;
> +}

[Severity: Low]
In virtsnd_pcm_trigger(), the start and pause_release case uses
scoped_guard(spinlock_irqsave, &queue->lock) and guard(spinlock)(&vss->lock)
and jumps out of the guarded scope via goto start_failed. Since
include/linux/cleanup.h discourages mixing goto labels with guard() and
scoped_guard() in the same function, could virtsnd_pcm_trigger() break out =
of
the scoped_guard block and handle the error without a goto label?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029054354.2931=
-1-mynameisjune111@gmail.com?part=3D9
