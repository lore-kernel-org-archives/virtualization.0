Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667059;
	b=BUWrgSM5qq55ZYR1NjuDjDVnjee9vVnfPASxQ95SempOROTIHPPN9apNXvYFIy3FhAj6
	 DQ+uQVUHQm7JUe6sxzj6+KLA7y3SkETU1neGyAewmJJA3wBlsTWUlcuSyEG8cWQKTI+od
	 Q1hLxnkLXo6iML76mYCqdwbSXq11RJJw8mMRGK0UByjbZLLEsGlR7DGIia5LjLKS7G/vX
	 66DmWt8r4boXZIvcvhkTFpnUniwZyEJwZw/hqQxKCitrASogfuX7/r+Ve/jRES6mD/f0T
	 j5PKj2XX1K3muOWX56o32qvuDoTgsJTZQRRmb6get8hZl8swf1NVY7T+45/HBE35+GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667059;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QHncc/LDgWJdN2ks5rdQyNmBU8tIp0PjUaMMNH+RIAo=;
	b=uW9Ec+DDAA68MIw2hS1XWXNtZQqHsA07Iyf4xc+QNaeiMOUT6h3Hdb0xmHBVNzGlqTiQ
	 MQrIs5HRKZgvhPVm8kxVvrME0dlUfDBhzviUNmOWEFlcp45AFLFap9t7JEoRRmnwQW0Pp
	 EdWHv5ZyNgx3blm9pDCWEzj7seKpZ4lbRFQMEZ5t5Zhx/0mdw9/AsMOWUdq9fRX5kh092
	 nJgLU171zS1uIO+E1npPADOnhE00OVPjb+EaKSZDf5GSZhcyUvWKi1mM/9Z49DJsU9r/a
	 Hv9bYwkynEeY9xYVh05ZnupLF+UD8Dn8U6Padl1Tri6XceCPfMvyvD1wpiAmaweboXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EDvi/mjP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02792606A324;
	Tue,  3 Nov 2026 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDvi/mjP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD821F000C1;
	Tue,  3 Nov 2026 00:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667058;
	bh=QHncc/LDgWJdN2ks5rdQyNmBU8tIp0PjUaMMNH+RIAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EDvi/mjP8La+5vFYmsp6JeNcyb2+LahqY7WAsjiMPyVMvAcZUdVwggEpRh+Wy7nNc
	 Utm16LhadQADti9DVHicwdvd7UEF/WUkiTOlKqgEeRo1iMIpOUdbzqUndI1PCiIIex
	 /ujSptZeaKuuRn9quioyLpUm82gDLwffF4InocpicSwl6v9XDsCa1A16Mk9fUxS7ZQ
	 M5YMBUSEg7NARhWFIMan17MI7JiHSYG0SRaUN0+SaM5u9eDyFqmcpwgBQJYjA6Szyy
	 Qu67VADyPLVmNc6XU0hAgA4Ui3z6vbhhwG4zZXvG5uTKLOeulvt8PR1jZsKgn5pkfe
	 GvgCnEMyGYWZg==
Message-ID: <sashiko-outbox-194389@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 10/12] ALSA: virtio: add staged capture and
 serialize PCM lifecycle accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103000403.67106-11-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
 <20261103000403.67106-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:50:58 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] ALSA: virtio: broken indirect ring state in virtsnd_pcm_playback_r=
eset()
- [High] ALSA: virtio: post-stop capture RX not retired in virtsnd_pcm_msg_=
complete()
- [Medium] ALSA: virtio: missing prepared and preparing checks in virtsnd_p=
cm_cp_pointer()
- [Medium] ALSA: virtio: vss->preparing gate leaked on prepare failure and =
reset races
- [Medium] ALSA: virtio: stale vss->suspended flag across open and virtsnd_=
pcm_hw_params()
- [Medium] ALSA: virtio: sub-byte frame truncation in virtsnd_pcm_capture_s=
taged_ack()
- [Medium] ALSA: virtio: missing state and xrun checks in virtsnd_pcm_pb_ac=
k() and pointer
- [Medium] ALSA: virtio: stale vss->suspended across virtsnd_pcm_open() and=
 hw_params()
- [Medium] ALSA: virtio: virtsnd_pcm_pause_restart_start() returns -EBADFD =
on xfer_xrun
- [Medium] ALSA: virtio: incomplete xrun and pointer rebase in virtsnd_pcm_=
reset()
--

commit aed4d30e1eeffd3a8fd687d7393b3bfcaedf5c71
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: add staged capture and serialize PCM lifecycle accounting

This commit adds opt-in staged PCM capture using request-owned DMA buffers =
and
serializes PCM lifecycle, reset, and acknowledgment accounting under the qu=
eue
and substream locks.

Link: https://sashiko.dev/#/patchset/20261031020855.2402-1-mynameisjune111%=
40gmail.com

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index b94ab24f5ffef..ed340ecfb289e 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c

[ ... ]

> @@ -540,19 +880,52 @@ static void virtsnd_pcm_msg_complete(struct virtio_=
pcm_msg *msg,
>  				     size_t written_bytes)
>  {
>  	struct virtio_pcm_substream *vss =3D msg->substream;
> +	size_t completed_bytes;
> +	u32 latency_bytes;
> +
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +	    vss->capture_staging) {
> +		virtsnd_pcm_capture_complete(msg, written_bytes);
> +		return;
> +	}
> =20
> -	/*
> -	 * hw_ptr always indicates the buffer position of the first I/O message
> -	 * in the virtqueue. Therefore, on each completion of an I/O message,
> -	 * the hw_ptr value is unconditionally advanced.
> -	 */
> +	/* Only completed TX requests and valid RX audio advance the pointer. */
>  	guard(spinlock)(&vss->lock);
> +	/* Empty STOP returns retire ownership without inventing captured data.=
 */
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +	    (!vss->prepared ||
> +	     (vss->stopped && written_bytes <=3D sizeof(*msg->status)))) {
> +		msg->length =3D 0;
> +		vss->msg_count--;
> +		if (!vss->msg_count)
> +			wake_up_all(&vss->msg_empty);
> +		return;
> +	}

[Severity: High]
As reported by Sashiko on v11 [1], what happens in virtsnd_pcm_msg_complete=
()
when an in-flight ordinary capture RX buffer completes with
written_bytes > sizeof(*msg->status) after vss->stopped has been set?

On an ordinary capture substream, SNDRV_PCM_TRIGGER_STOP (called during
capture drain in snd_pcm_do_drain_init(), snd_pcm_drop(), or
virtsnd_pcm_sync_stop_locked()) sets vss->stopped =3D true while vss->prepa=
red
remains true until VIRTIO_SND_R_PCM_RELEASE completes. Unlike staged capture
in virtsnd_pcm_capture_complete(), which ignores all completions when
vss->stopped is true, virtsnd_pcm_msg_complete() only retires stopped captu=
re
completions early if written_bytes <=3D sizeof(*msg->status).

During SNDRV_PCM_STATE_DRAINING, ALSA stops calling ops->pointer(), so
vss->capture_pointer_seen_total stops advancing while the application drains
already-captured frames via virtsnd_pcm_cp_ack_locked(). If pending RX buff=
ers
complete with audio payloads after STOP, they advance
vss->capture_copied_total until
vss->capture_copied_total - vss->capture_pointer_seen_total >=3D vss->buffe=
r_bytes
(or fail virtsnd_pcm_capture_status() if completed with a non-OK status),
latching vss->xfer_xrun =3D true and causing virtsnd_pcm_cp_ack_locked() to
abort capture drain with -EPIPE.

In addition, during virtsnd_pcm_sync_stop_locked(), cancel_work_sync() runs
before VIRTIO_SND_R_PCM_STOP and VIRTIO_SND_R_PCM_RELEASE are sent:

virtsnd_pcm_sync_stop_locked()
    cancel_work_sync(&vss->elapsed_period);
    rc =3D virtsnd_pcm_stop_device(vss, epoch);
    ...
    rc =3D virtsnd_pcm_send_sync(vss, msg); /* VIRTIO_SND_R_PCM_RELEASE */
    scoped_guard(spinlock_irqsave, &vss->lock) {
        ...
        vss->prepared =3D false;
    }

If a non-empty RX completion arrives while STOP or RELEASE is in flight and
vss->xfer_xrun is set, virtsnd_pcm_msg_complete() will call
virtsnd_pcm_schedule_period_elapsed(vss) after cancel_work_sync() has alrea=
dy
returned, and will also skip the else-if wake_up_all(&vss->msg_empty) when
vss->msg_count reaches zero. Should virtsnd_pcm_msg_complete() retire all
capture completions whenever !vss->prepared || vss->stopped?

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index ad602b6b6530b..54065662083ed 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -119,23 +381,42 @@ static int virtsnd_pcm_open(struct snd_pcm_substrea=
m *substream)

[ ... ]

>  	snd_pcm_hw_constraint_integer(substream->runtime,
>  				      SNDRV_PCM_HW_PARAM_PERIODS);
> =20
>  	scoped_guard(spinlock_irqsave, &vss->lock)
>  		vss->stopped |=3D !!vss->msg_count;
> -	vss->suspended =3D false;

[Severity: Medium]
If vss->suspended =3D false is removed from virtsnd_pcm_open() and is not
cleared in virtsnd_pcm_hw_params() either, can vss->suspended remain stale
until virtsnd_pcm_prepare_locked()?

When virtsnd_reset_vqs() runs during device reset or freeze/restore, it sets
vss->suspended =3D true on all substreams (including closed ones), and clos=
ing a
substream after SNDRV_PCM_TRIGGER_SUSPEND also leaves vss->suspended =3D tr=
ue.
When the substream is subsequently opened via virtsnd_pcm_open() and
configured via virtsnd_pcm_hw_params(), virtsnd_pcm_hw_params() sends
VIRTIO_SND_R_PCM_SET_PARAMS to the device, but vss->suspended remains true.

When virtsnd_pcm_prepare_locked() then runs, it sees suspended =3D=3D true,=
 which
skips the !virtsnd_pcm_msg_pending_num(vss) queue sanity check and sends a
redundant VIRTIO_SND_R_PCM_SET_PARAMS request to the device. Should
vss->suspended be cleared in virtsnd_pcm_open() or when
virtsnd_pcm_dev_set_params() succeeds in virtsnd_pcm_hw_params()?

[ ... ]

> @@ -320,129 +717,615 @@ static int virtsnd_pcm_prepare(struct snd_pcm_sub=
stream *substream)
> +	scoped_guard(pcm_stream_lock_irqsave, substream) {
> +		guard(spinlock_irqsave)(&vss->lock);
> +		if (vss->resetting || vss->reset_epoch !=3D epoch)
> +			return -ECANCELED;
> +		vss->prepared =3D false;
> +		vss->preparing =3D true;
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

[Severity: Medium]
If virtsnd_pcm_prepare_locked() fails after setting vss->preparing =3D true,
what clears vss->preparing?

In snd_pcm_do_prepare(), the core only calls snd_pcm_reset_substream() (whi=
ch
invokes substream->ops->reset() and clears vss->preparing =3D false) if
substream->ops->prepare() returns 0. If virtsnd_pcm_prepare_locked() returns
an error on any of the subsequent failure paths (such as the pause_restart
state check, the stopped check, pending messages, virtsnd_pcm_dev_set_param=
s(),
virtsnd_pcm_dev_prepare(), or virtsnd_pcm_capture_refresh_mode_locked()),
vss->preparing remains stuck at true.

Similarly, in virtsnd_pcm_indirect_reset(), virtsnd_pcm_reset(), and
virtsnd_reset_vqs(), if a device reset occurs (setting vss->resetting =3D t=
rue),
virtsnd_pcm_indirect_reset() and virtsnd_pcm_reset() return early at
if (vss->resetting) return 0; before clearing vss->preparing =3D false, and
virtsnd_reset_vqs() does not clear vss->preparing either. While vss->prepar=
ing
is stuck at true, pointer and ACK callbacks remain locked out and return
SNDRV_PCM_POS_XRUN or -EBADFD instead of -EPIPE.

[ ... ]

> +static int virtsnd_pcm_pause_restart_start(struct virtio_pcm_substream *=
vss,
> +					   bool resume)
> +{
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	struct virtio_snd_msg *msg;
> +	enum virtio_pcm_pause_restart_state state;
> +	bool reset_required;
> +	bool invalid_state;
> +	int rc =3D 0;
> +	u64 epoch;
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (vss->resetting)
> +			return -ECANCELED;
> +		epoch =3D vss->reset_epoch;
> +		state =3D vss->pause_restart_state;
> +		reset_required =3D
> +			state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
> +			virtsnd_pcm_pause_restart_transitioning(state);
> +		invalid_state =3D
> +			vss->xfer_xrun ||
> +			(resume &&\n+			 (state !=3D VIRTSND_PCM_PAUSE_RESTART_RELEASED ||
> +			  !vss->stopped || vss->msg_count ||
> +			  !vss->runtime_active)) ||
> +			(!resume &&\n+			 (state !=3D VIRTSND_PCM_PAUSE_RESTART_PREPARED ||
> +			  vss->stopped));
> +	}
> +	if (reset_required) {
> +		virtsnd_pcm_pause_restart_fail(vss, true, epoch);
> +		return -EIO;
> +	}
> +	if (invalid_state) {
> +		virtsnd_pcm_pause_restart_fail(vss, false, epoch);
> +		return -EBADFD;
> +	}

[Severity: Medium]
In virtsnd_pcm_pause_restart_start(), if vss->xfer_xrun is already latched
(for example via VIRTIO_SND_EVT_PCM_XRUN in virtsnd_pcm_event() while prepa=
red
or before queueing in the second check below), should this return -EPIPE
instead of -EBADFD, matching virtsnd_pcm_start_queue()?

In snd_pcm_do_start(), the ALSA core only transitions the runtime state to
SNDRV_PCM_STATE_XRUN when trigger(SNDRV_PCM_TRIGGER_START) returns -EPIPE.
Returning -EBADFD leaves the substream in SNDRV_PCM_STATE_PREPARED with
vss->stopped =3D true and vss->xfer_xrun =3D true, where
virtsnd_pcm_period_elapsed() will not move it to XRUN either because
snd_pcm_running() is false.

[ ... ]

> @@ -521,10 +1426,16 @@ static snd_pcm_uframes_t
>  virtsnd_pcm_pb_pointer(struct snd_pcm_substream *substream)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	size_t hw_ptr;
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (!vss->prepared || vss->preparing)
> +			return SNDRV_PCM_POS_XRUN;
> +		hw_ptr =3D vss->hw_ptr;
> +	}
> =20
>  	return snd_pcm_indirect_playback_pointer(substream,
> -		&vss->pcm_indirect,
> -		vss->hw_ptr);
> +		&vss->pcm_indirect, hw_ptr);
>  }
> =20
>  /**
> @@ -539,10 +1450,62 @@ static snd_pcm_uframes_t
>  virtsnd_pcm_cp_pointer(struct snd_pcm_substream *substream)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	size_t hw_ptr =3D 0;
> +	u64 total;
> +	bool free_running;
> +	bool xrun;
> +
> +	if (vss->capture_staging) {
> +		scoped_guard(spinlock_irqsave, &vss->lock) {
> +			xrun =3D vss->xfer_xrun;
> +			if (!xrun &&
> +			    virtsnd_pcm_capture_refresh_mode_locked(vss,
> +								    &free_running))
> +				xrun =3D true;
> +			if (!xrun && !virtsnd_pcm_capture_counters_valid(vss))
> +				xrun =3D true;

[Severity: Medium]
Unlike virtsnd_pcm_pb_pointer(), the non-staged branch of
virtsnd_pcm_cp_pointer(), and virtsnd_pcm_capture_staged_ack(), the staged
capture branch of virtsnd_pcm_cp_pointer() does not check vss->prepared,
vss->preparing, or vss->suspended.

When virtsnd_reset_vqs() runs during a device reset, it sets
vss->prepared =3D false, vss->xfer_enabled =3D false, vss->suspended =3D tr=
ue, and
vss->xfer_xrun =3D false, while leaving vss->runtime_active, vss->buffer_by=
tes,
vss->capture_boundary, and the staged capture counters intact. Likewise,
virtsnd_pcm_prepare_locked() sets vss->prepared =3D false and
vss->preparing =3D true before dropping the PCM stream lock. Because neither
virtsnd_pcm_capture_refresh_mode_locked() nor
virtsnd_pcm_capture_counters_valid() checks vss->prepared, vss->preparing, =
or
vss->suspended, won't pointer queries on a reset or preparing staged capture
substream return a stale ring offset instead of SNDRV_PCM_POS_XRUN?

[ ... ]

> @@ -571,7 +1536,7 @@ static void virtsnd_pcm_transfer_failed(struct virti=
o_pcm_substream *vss)
>  	vss->substream->runtime->stop_operating =3D true;
>  }
> =20
> -static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
> +static int virtsnd_pcm_pb_ack_locked(struct snd_pcm_substream *substream)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
>  	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> @@ -580,6 +1545,8 @@ static int virtsnd_pcm_pb_ack(struct snd_pcm_substre=
am *substream)
> =20
>  	scoped_guard(spinlock_irqsave, &queue->lock) {
>  		guard(spinlock)(&vss->lock);
> +		if (!vss->prepared || vss->preparing)
> +			return -EBADFD;
>  		transfer.indirect =3D vss->pcm_indirect;
>  		if (vss->stopped) {
>  			rc =3D -EPIPE;
> @@ -606,17 +1573,136 @@ static int virtsnd_pcm_pb_ack(struct snd_pcm_subs=
tream *substream)
>  	return 0;
>  }
> =20
> -static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
> +/* The PCM lock serializes ACK with prepare's accounting reset. */
> +static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +
> +	if (vss->indirect_reset_observing)
> +		return 0;
> +	return virtsnd_pcm_pb_ack_locked(substream);
> +}

[Severity: Medium]
In virtsnd_pcm_cp_ack(), the capture path validates runtime->state (returni=
ng
-EPIPE for SNDRV_PCM_STATE_XRUN and -EBADFD for states other than PREPARED,
RUNNING, PAUSED, and DRAINING), and virtsnd_pcm_cp_ack_locked() and
virtsnd_pcm_cp_pointer() check vss->xfer_xrun.

In contrast, virtsnd_pcm_pb_ack() does not check runtime->state, and neither
virtsnd_pcm_pb_ack_locked() nor virtsnd_pcm_pb_pointer() checks
vss->xfer_xrun. If a prepared playback stream is dropped via
SNDRV_PCM_IOCTL_DROP (where snd_pcm_drop() transitions runtime->state to
SNDRV_PCM_STATE_SETUP without calling trigger(STOP) because snd_pcm_running=
()
is false, leaving vss->prepared =3D=3D true and vss->stopped =3D=3D false),=
 or if a
later member in a linked prepare sleeps or fails after playback prepare
completes, or if VIRTIO_SND_EVT_PCM_XRUN sets vss->xfer_xrun =3D true, won't
SNDRV_PCM_IOCTL_SYNC_PTR still call virtsnd_pcm_pb_ack() and enqueue TX
buffers in invalid or XRUN states?

> +
> +static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *v=
ss,
> +					  struct snd_pcm_runtime *runtime)
> +{

[ ... ]

> +		/* ACK includes any subperiod tail already copied to the ring. */
> +		bytes =3D frames_to_bytes(runtime, diff);
> +		outstanding =3D vss->capture_copied_total -
> +			      vss->capture_acked_total;
> +		if ((!free_running && bytes > vss->capture_ready) ||
> +		    (free_running &&
> +		     (bytes > vss->buffer_bytes || bytes > outstanding)) ||
> +		    check_add_overflow(vss->capture_acked_total, (u64)bytes,
> +				       &next_acked_total) ||
> +		    next_acked_total > vss->capture_pointer_seen_total) {
> +			vss->xfer_xrun =3D true;
> +			virtsnd_pcm_schedule_period_elapsed(vss);
> +			return -EPIPE;
> +		}
> +
> +		vss->capture_acked_total =3D next_acked_total;
> +		if (!free_running)
> +			vss->capture_ready -=3D bytes;
> +		vss->pcm_indirect.appl_ptr =3D appl_ptr;
> +	}

[Severity: Medium]
Can frames_to_bytes(runtime, diff) truncate sub-byte frame deltas here when
capturing 4-bit frames (mono SNDRV_PCM_FORMAT_IMA_ADPCM, where
runtime->frame_bits =3D=3D 4)?

When diff is odd, frames_to_bytes(runtime, diff) computes (diff * 4) / 8 and
truncates the half-byte, while vss->pcm_indirect.appl_ptr =3D appl_ptr adva=
nces
past the full frame delta. Across multiple odd-frame ACKs (for example via
SNDRV_PCM_IOCTL_SYNC_PTR), the uncounted half-bytes are never added to
vss->capture_acked_total or subtracted from vss->capture_ready, leaking
vss->capture_ready in managed mode until virtsnd_pcm_capture_complete()
rejects a completion with ring_full and triggers a false XRUN.

[ ... ]

> +/* The core holds the stream lock through the matching appl_ptr reset. */
> +static int virtsnd_pcm_reset(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	size_t position;
> +	size_t period;
> +	int rc;
> +
> +	/* Reclaim RX space atomically with the pointer observation. */
> +	scoped_guard(spinlock_irqsave, &vss->lock)
> +		vss->capture_reset_observing =3D true;
> +	rc =3D snd_pcm_lib_reset(substream);
> +	scoped_guard(spinlock_irqsave, &vss->lock)
> +		vss->capture_reset_observing =3D false;
> +	if (rc || !vss->capture_staging)
> +		return rc;
> +
> +	guard(spinlock_irqsave)(&queue->lock);
> +	guard(spinlock)(&vss->lock);
> +	if (vss->resetting)
> +		return 0;
> +	vss->preparing =3D false;
> +	/* The common reset has already handled a pointer-reported XRUN. */
> +	if (vss->xfer_xrun)
> +		return 0;

[Severity: Medium]
As reported by Sashiko on v8 [2], what happens in virtsnd_pcm_reset() (and
virtsnd_pcm_indirect_reset()) when vss->xfer_xrun is true, either while the
stream is in SNDRV_PCM_STATE_PAUSED / SNDRV_PCM_STATE_PREPARED or when
vss->xfer_xrun becomes true between snd_pcm_lib_reset() and acquiring
vss->lock?

In snd_pcm_lib_reset(), snd_pcm_update_hw_ptr() is only called when
snd_pcm_running(substream) is true. When the substream is paused or prepared
(or if vss->xfer_xrun raced in after snd_pcm_lib_reset()), snd_pcm_lib_rese=
t()
does not observe the XRUN and returns 0, and snd_pcm_reset_substream() then
rebases runtime->control->appl_ptr =3D runtime->status->hw_ptr. Returning 0
early here leaves vss->pcm_indirect.appl_ptr and the staged capture counters
out of sync with runtime->control->appl_ptr, and in virtsnd_pcm_reset() also
skips scheduling vss->elapsed_period to stop a paused substream on XRUN.

> +	if (snd_pcm_running(substream)) {
> +		/* Keep completions arriving after the core's pointer observation. */
> +		vss->capture_acked_total =3D vss->capture_pointer_seen_total;
> +		vss->capture_ready =3D vss->capture_free_running ? 0 :
> +			vss->capture_copied_total - vss->capture_acked_total;
> +	} else {
> +		position =3D frames_to_bytes(runtime, runtime->status->hw_ptr);
> +		vss->hw_ptr =3D position;
> +		period =3D snd_pcm_lib_period_bytes(substream);
> +		vss->capture_copied_total =3D position;
> +		vss->capture_acked_total =3D position;
> +		vss->capture_pointer_seen_total =3D position;
> +		vss->capture_ready =3D 0;
> +		vss->capture_notified_periods =3D period ? position / period : 0;
> +	}
> +	vss->capture_callback_snapshot =3D 0;
> +	vss->capture_callback_snapshot_active =3D false;
> +	vss->pcm_indirect.appl_ptr =3D runtime->status->hw_ptr;
> +	if (snd_pcm_running(substream) && vss->xfer_enabled && vss->prepared) {
> +		rc =3D virtsnd_pcm_capture_send(vss);
> +		if (rc) {
> +			vss->xfer_xrun =3D true;
> +			virtsnd_pcm_schedule_period_elapsed(vss);
> +		}
> +	}
> +	/* Complete the matching core pointer rebase before reporting XRUN. */
> +	return 0;
> +}
> +
> +/* Keep queued TX ownership while rebasing the application's write curso=
r. */
> +static int virtsnd_pcm_playback_reset(struct snd_pcm_substream *substrea=
m)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	int rc;
> +
> +	vss->indirect_reset_observing =3D true;
> +	rc =3D snd_pcm_lib_reset(substream);
> +	vss->indirect_reset_observing =3D false;
> +	if (rc)
> +		return rc;
> +	guard(spinlock_irqsave)(&vss->lock);
> +	vss->preparing =3D false;
> +	vss->pcm_indirect.appl_ptr =3D substream->runtime->status->hw_ptr;
> +	vss->pcm_indirect.sw_ready =3D 0;
> +	return 0;
> +}

[Severity: High]
Does virtsnd_pcm_playback_reset() leave vss->pcm_indirect and
vss->msgs[i]->length in an inconsistent state when SNDRV_PCM_IOCTL_RESET is
called after playback frames have already been acknowledged?

In virtsnd_pcm_pb_ack_locked(), snd_pcm_indirect_playback_transfer() drains
sw_ready into virtsnd_pcm_msg_send(), which advances pcm_indirect.sw_data,
pcm_indirect.hw_data, and pcm_indirect.hw_ready ahead of pcm_indirect.sw_io
and accumulates bytes into vss->msgs[i]->length. When
virtsnd_pcm_playback_reset() runs, snd_pcm_reset_substream() rebases
runtime->control->appl_ptr back to runtime->status->hw_ptr (matching sw_io),
and virtsnd_pcm_playback_reset() sets pcm_indirect.appl_ptr and clears
sw_ready =3D 0, but leaves sw_data, hw_data, hw_ready, and vss->msgs[i]->le=
ngth
untouched:

1. On the next write after RESET, ALSA writes new samples into
   runtime->dma_area starting at runtime->control->appl_ptr (sw_io, overwri=
ting
   in-flight TX period buffers), while snd_pcm_indirect_playback_transfer()
   calls virtsnd_pcm_msg_send() starting from the old sw_data offset, sendi=
ng
   unwritten/stale DMA buffer regions.

2. If a sub-period write occurred before RESET (leaving
   0 < msg->length < period_bytes) or when sw_data wraps into an already-qu=
eued
   period (msg->length =3D=3D period_bytes), virtsnd_pcm_msg_send() adds n =
to the
   existing msg->length, causing msg->length to exceed period_bytes so the
   descriptor is never submitted.

3. Because runtime->control->appl_ptr is rebased back to
   runtime->status->hw_ptr while hw_ready bytes remain queued in the TX
   virtqueue, completion of an in-flight TX period advances
   runtime->status->hw_ptr past runtime->control->appl_ptr and triggers a
   false playback XRUN.

4. If SNDRV_PCM_IOCTL_RESET is called while playback is in
   SNDRV_PCM_STATE_PAUSED after completing at least one period (vss->hw_ptr=
 > 0),
   snd_pcm_lib_reset() sees !snd_pcm_running(substream) and resets
   runtime->status->hw_ptr =3D 0, while vss->hw_ptr, pcm_indirect.hw_io, and
   pcm_indirect.sw_io remain at the non-zero paused offset, causing the next
   virtsnd_pcm_pb_pointer() call to report a large pointer jump and XRUN.

[1] https://lore.kernel.org/r/20261031020855.2402-10-mynameisjune111@gmail.=
com
[2] https://lore.kernel.org/r/sashiko-outbox-188791@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103000403.6710=
6-1-mynameisjune111@gmail.com?part=3D10
