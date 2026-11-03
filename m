Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703930;
	b=mcawAohlQ3pqzgtVbG7xGO3xKI3j5GRTv7Mw5g03h1qcE95+ZlTObthxQeXR0w2LpVKv
	 qHaVbjy3StwCPLwcpXL6CB9QMhp2EPGsap6sy43hzitnVvbABtzRviO2zCBwoLM8Il36t
	 XAzkKC26pzzcmIpUAeVs2UF+MP3MreyFlkrGChH7uZYun3CfmhfPBHxt3NBdG5IrwjiaT
	 51enILrQO18EKcIMis3n9qlgBC1b0Qf6du2qfk5SS2wYiguXyUWGcZk4SYNGSI76B3lfo
	 E3CfYH3XMmd83gswE6s4pHS91bgs5n8gYBO68Tz9/pi3d11r2jVxBeyVEqBzPuL5xnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703930;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ApZQrHrVAmPU5lLYKZkbNSAgRILm1AMvMRFjpqvGNsw=;
	b=vNQvSkENildyweTRk2gl0NW3jsbFwN3pw8eB2CTZk9RmPvaPWSFQQ9qlCYO45TF7sG11
	 +3cLas/jWhG01Bo8/5PU2uOxM19Tx+Au+IoZTRNAIzSf5JvLxl1F7wDD1vjd23TlJa9Fd
	 2PSt+VnU0cNK3ZXoqvoB5eaeBFW9QQNt5P4HCTE8jWmL6bVCAIUuK1L2Z6irtufLJ4Q0o
	 T2KIkPhkv8NWZW3B2MI1V8odVrsVY3l0AOpFm/5jaILX8eQKICmLNH0VIdGHBhJBGC/3s
	 wLPbzFMUmKHqt9T8Iz3pggLLxtuWbfaAHAQyWCzZvx7VcyKKLFZ39o2V6+Moe0UX6tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DD8vaxuD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08878606ED92;
	Tue,  3 Nov 2026 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DD8vaxuD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F97B1F00A15;
	Tue,  3 Nov 2026 11:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703929;
	bh=ApZQrHrVAmPU5lLYKZkbNSAgRILm1AMvMRFjpqvGNsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DD8vaxuDUepJHVsFYclfXNl9tIkuXuSa9w+zTyhiFWSSDXhVBxNSto2CS8aW7XU3R
	 pppFTLmpbh7Z1zYexXeyBHBMgRN70aMKyz3abqAv8cfE/MqeTk0q8aXptxSSStEtgc
	 CZCzoyipYS8zEY/xxO2S7lLIT2kdwweDEWM3k96dWTHxhJEm2RLHrEw7TtSkkyChk3
	 //4/vRI8Ysw1bAXrVHqli2kAVpTvltgXM9xAUKMt5xdQilIMb+JR0Ly/fgaHFRI3rF
	 735mL3OhKGTJ7QDfb+vJjoVMypN7MOScETLF2Hs/4FaCJWEp7UYNeDBcK0VRXhbY+q
	 sUkqQO4YGuBlw==
Message-ID: <sashiko-outbox-195105@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 10/12] ALSA: virtio: add staged capture and
 serialize PCM lifecycle accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103080821.16983-11-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
 <20261103080821.16983-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:05:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Medium] ALSA: virtio: missing stop_operating arming on -EPIPE in ACK and=
 start paths
- [Medium] ALSA: virtio: skipped NOMMU post-STOP copy in virtsnd_pcm_msg_co=
mplete()
- [Medium] ALSA: virtio: cancel_work_sync() in virtsnd_reset_vqs() stalls c=
tl cleanup
- [Medium] ALSA: virtio: missing stop_operating on XRUN in pause_restart tr=
igger
- [Medium] ALSA: virtio: delayed preparing gate and stale release_required =
in prepare
- [Medium] ALSA: virtio: virtsnd_pcm_pause_restart_stop() skips setting sus=
pended
- [Medium] ALSA: virtio: virtsnd_pcm_indirect_reset() skips cursor rebase o=
n error
- [Medium] ALSA: virtio: virtsnd_pcm_capture_staged_ack() rejects sub-byte =
carryover
- [Medium] ALSA: virtio: unaligned byte ACK in virtsnd_pcm_capture_staged_a=
ck()
--

commit ca5397134e4f3f33edd4ee72441d7b063f6912f2
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: add staged capture and serialize PCM lifecycle accounting

This commit introduces request-owned staged capture buffers with separate
produced, observed, and consumed position tracking, and serializes PCM
lifecycle transitions and ACK accounting using lifecycle_lock and the PCM
stream lock. It also adds reset callbacks for playback and capture streams
and refines XRUN and teardown handling across device resets and pause
transitions.

> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index aec4959c973ca..f32e9fb9e8b1d 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c
> @@ -382,8 +399,16 @@ static void virtsnd_reset_vqs(struct virtio_snd *snd)
>  		queue->vqueue =3D NULL;
>  		spin_unlock_irqrestore(&queue->lock, flags);
>  	}
> -
>  	vdev->config->del_vqs(vdev);
> +	for (i =3D 0; snd->substreams && i < snd->nsubstreams; ++i) {
> +		struct virtio_pcm_substream *vss =3D &snd->substreams[i];
> +
> +		cancel_work_sync(&vss->elapsed_period);

[Severity: Medium]
Can calling cancel_work_sync(&vss->elapsed_period) inside virtsnd_reset_vqs=
()
stall freeze or remove for the full virtsnd_msg_timeout_ms duration?

In virtsnd_freeze() and virtsnd_remove():

  virtsnd_ctl_msg_cancel_all(snd);
  virtsnd_reset_vqs(snd);
  virtsnd_ctl_msg_cleanup(snd);

virtsnd_ctl_msg_cancel_all() marks pending control messages with
msg->cancelled =3D true, but does not complete msg->notify; waking the wait=
ers
only happens later in virtsnd_ctl_msg_cleanup() after virtsnd_reset_vqs()
returns.

Because vpcm->pcm->nonatomic is true, virtsnd_pcm_period_elapsed() acquires
the sleeping PCM stream lock via guard(pcm_stream_lock_irqsave)(substream).
If another thread holds that PCM stream lock while waiting in
virtsnd_ctl_msg_send() on an already-submitted control message (such as in
virtsnd_pcm_trigger()), or if virtsnd_pcm_period_elapsed() itself entered
snd_pcm_stop() -> virtsnd_pcm_trigger(SNDRV_PCM_TRIGGER_STOP) ->
virtsnd_ctl_msg_send_sync() just before virtsnd_reset_vqs() set
vss->resetting =3D true, the device has already been reset and will never
complete that control message.

Waiting in cancel_work_sync(&vss->elapsed_period) before
virtsnd_ctl_msg_cleanup(snd) prevents msg->notify from being completed until
wait_for_completion_timeout(&msg->notify, js) expires. Should control messa=
ge
waiters be woken before synchronously canceling elapsed_period work?

[ ... ]

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index b94ab24f5ffef..d6510d813f3ca 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
> @@ -540,19 +880,52 @@ static void virtsnd_pcm_msg_complete(struct virtio_=
pcm_msg *msg,
>  				     size_t written_bytes)
>  {
>  	struct virtio_pcm_substream *vss =3D msg->substream;
> +	size_t completed_bytes;
> +	u32 latency_bytes;
> =20
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +	    vss->capture_staging) {
> +		virtsnd_pcm_capture_complete(msg, written_bytes);
> +		return;
> +	}
> +
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
> +	completed_bytes =3D msg->length;
> +	latency_bytes =3D le32_to_cpu(msg->status->latency_bytes);
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> +		struct snd_pcm_runtime *runtime =3D vss->substream->runtime;
> +		size_t frame_bytes =3D runtime->frame_bits / gcd(runtime->frame_bits, =
8);
> +
> +		if (virtsnd_pcm_capture_status(msg, written_bytes, frame_bytes,
> +					       &completed_bytes, &latency_bytes) ||
> +		    !completed_bytes) {
> +			vss->xfer_xrun =3D true;
> +			msg->length =3D 0;
> +			vss->msg_count--;
> +			if (!vss->msg_count)
> +				wake_up_all(&vss->msg_empty);
> +			virtsnd_pcm_schedule_period_elapsed(vss);
> +			return;
> +		}
> +	}
>  #ifndef CONFIG_MMU
>  	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> -	    vss->xfer_enabled && written_bytes > sizeof(msg->status)) {
> +	    vss->prepared && !vss->stopped &&
> +	    written_bytes > sizeof(*msg->status)) {
>  		struct snd_pcm_runtime *runtime =3D
>  			vss->substream ? vss->substream->runtime : NULL;
> -		size_t reported_bytes =3D written_bytes - sizeof(msg->status);
> +		size_t reported_bytes =3D written_bytes - sizeof(*msg->status);
>  		size_t data_bytes =3D min_t(size_t, reported_bytes, msg->length);
> =20
>  		if (!runtime || !runtime->dma_area || !vss->owned_dma_area ||
> @@ -568,26 +941,16 @@ static void virtsnd_pcm_msg_complete(struct virtio_=
pcm_msg *msg,
>  			       vss->owned_dma_area + msg->data_offset, data_bytes);
>  	}
>  #endif
> +	vss->hw_ptr +=3D completed_bytes;
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> +		/* A full unseen ring cannot be represented by the modulo pointer. */
> +		if (check_add_overflow(vss->capture_copied_total,
> +				       (u64)completed_bytes,
> +				       &vss->capture_copied_total) ||

[Severity: Medium]
On !CONFIG_MMU systems, does checking !vss->stopped before copying from
vss->owned_dma_area leave stale data in runtime->dma_area on post-STOP
capture completions?

At the top of virtsnd_pcm_msg_complete(), post-STOP capture completions with
written_bytes > sizeof(*msg->status) are intentionally kept so that in-flig=
ht
payloads (such as during capture SNDRV_PCM_STATE_DRAINING after
virtsnd_pcm_trigger(SNDRV_PCM_TRIGGER_STOP) sets vss->stopped =3D true) adv=
ance
vss->hw_ptr and vss->capture_copied_total by completed_bytes.

However, the #ifndef CONFIG_MMU bounce-buffer copy block is gated on
vss->prepared && !vss->stopped. When vss->stopped is true, memcpy() into
runtime->dma_area is skipped even though vss->hw_ptr and
vss->capture_copied_total are advanced, exposing stale or zeroed buffer
contents to userspace. Should the !vss->stopped check be removed from the
!CONFIG_MMU copy condition (and data_bytes use completed_bytes)?

[ ... ]

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index f4b45bddfb09c..05b38d8a67d7a 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -288,28 +622,95 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_sub=
stream *substream,
[ ... ]
>  static int virtsnd_pcm_prepare_locked(struct snd_pcm_substream *substrea=
m)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
>  	struct virtio_device *vdev =3D vss->snd->vdev;
> -	struct virtio_snd_msg *msg;
> -	bool stopped;
> +	bool pause_restart =3D virtsnd_pcm_pause_restart_enabled(vss);
> +	bool free_running;
>  	int rc;
> +	bool stopped;
> +	bool suspended;
> +	u64 epoch;
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (vss->resetting)
> +			return -ECANCELED;
> +		epoch =3D vss->reset_epoch;
> +		stopped =3D vss->stopped || vss->release_required || vss->msg_count;
> +	}
> +	if (stopped) {
> +		rc =3D virtsnd_pcm_sync_stop_locked(substream);
> +		if (rc)
> +			return rc;
> +	}
> +	scoped_guard(pcm_stream_lock_irqsave, substream) {
> +		guard(spinlock_irqsave)(&vss->lock);
> +		if (vss->resetting || vss->reset_epoch !=3D epoch)
> +			return -ECANCELED;
> +		vss->prepared =3D false;
> +		vss->preparing =3D true;
> +		suspended =3D vss->suspended;
> +	}

[Severity: Medium]
When re-preparing a substream that is already in SNDRV_PCM_STATE_PREPARED,
can a concurrent SNDRV_PCM_IOCTL_SYNC_PTR ioctl race with
virtsnd_pcm_sync_stop_locked() before vss->preparing is set?

When snd_pcm_prepare() is called on a prepared substream (where
vss->release_required is true), ALSA core holds runtime->buffer_mutex but n=
ot
the PCM stream lock, and runtime->state remains SNDRV_PCM_STATE_PREPARED
until snd_pcm_post_prepare().

In virtsnd_pcm_prepare_locked(), virtsnd_pcm_sync_stop_locked() runs before
the PCM stream lock is taken to set vss->preparing =3D true and
vss->prepared =3D false. Inside virtsnd_pcm_sync_stop_locked() (and
virtsnd_pcm_pause_restart_sync_stop()), vss->stopped is set to true while
vss->prepared remains true across the sleeping VIRTIO_SND_R_PCM_RELEASE
request:

  virtsnd_pcm_prepare_locked()
    virtsnd_pcm_sync_stop_locked()
      vss->stopped =3D true;
      /* vss->prepared is still true, vss->preparing is still false */
      virtsnd_pcm_send_sync(vss, msg); /* sleeps */

If another thread calls snd_pcm_sync_ptr() -> pcm_lib_apply_appl_ptr() duri=
ng
this window, it acquires the PCM stream lock, passes virtsnd_pcm_ack_state(=
),
sees vss->preparing =3D=3D false, vss->prepared =3D=3D true, and vss->stopp=
ed =3D=3D true
in virtsnd_pcm_pb_ack_locked() or virtsnd_pcm_cp_ack_locked(), and returns
-EPIPE, causing pcm_lib_apply_appl_ptr() to call __snd_pcm_xrun(substream)
mid-prepare.

Additionally, virtsnd_pcm_prepare_locked() sets vss->release_required =3D t=
rue
even when pause_restart is enabled, but neither virtsnd_pcm_release_wait()
nor virtsnd_pcm_pause_restart_sync_stop() clears vss->release_required,
causing stopped to be true on every subsequent prepare. Should vss->prepari=
ng
be armed under the PCM stream lock before calling
virtsnd_pcm_sync_stop_locked(), and should vss->release_required be cleared
when pause_restart releases the stream?

[ ... ]

> +static int virtsnd_pcm_pause_restart_start(struct virtio_pcm_substream *=
vss,
> +					   bool resume)
> +{
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
>  	struct virtio_snd_msg *msg;
> +	enum virtio_pcm_pause_restart_state state;
> +	bool reset_required;
> +	bool invalid_state;
> +	bool xrun;
>  	int rc =3D 0;
> +	u64 epoch;
> =20
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (vss->resetting)
> +			return -ECANCELED;
> +		epoch =3D vss->reset_epoch;
> +		state =3D vss->pause_restart_state;
> +		xrun =3D vss->xfer_xrun;
[ ... ]
> +	}
> +	if (reset_required) {
> +		virtsnd_pcm_pause_restart_fail(vss, true, epoch);
> +		return -EIO;
> +	}
> +	if (xrun)
> +		return -EPIPE;
[ ... ]
> +static int virtsnd_pcm_pause_restart_pause(struct virtio_pcm_substream *=
vss)
> +{
> +	struct virtio_snd_msg *msg;
> +	enum virtio_pcm_pause_restart_state state;
> +	int rc;
> +	u64 epoch;
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (vss->resetting)
> +			return -ECANCELED;
> +		epoch =3D vss->reset_epoch;
> +		state =3D vss->pause_restart_state;
> +		if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEASED) {
> +			if (vss->xfer_xrun)
> +				virtsnd_pcm_schedule_period_elapsed(vss);
> +			return vss->xfer_xrun ? -EPIPE : 0;
> +		}

[Severity: Medium]
In virtsnd_pcm_pause_restart_start() and virtsnd_pcm_pause_restart_pause(),
does returning -EPIPE on a latched XRUN without arming vss->stopped and
runtime->stop_operating prevent subsequent DROP or prepare teardown from
running sync_stop?

In virtsnd_pcm_pause_restart_start(), if xrun is true on entry, it returns
-EPIPE directly without calling virtsnd_pcm_pause_restart_failed(vss, epoch)
(unlike the later vss->xfer_xrun check when queueing capture buffers, and
unlike the native trigger path which calls virtsnd_pcm_start_failed()). When
SNDRV_PCM_TRIGGER_START fails with -EPIPE on a linked substream,
snd_pcm_do_start() sets runtime->state to SNDRV_PCM_STATE_XRUN and
snd_pcm_action_group() only runs undo_action on group members preceding the
failed stream, leaving vss->stopped and runtime->stop_operating false on the
failed stream so SNDRV_PCM_IOCTL_DROP will not release the prepared stream =
on
the device.

Similarly, if a paused stream has vss->xfer_xrun latched and snd_pcm_drop()
or snd_pcm_prepare() calls snd_pcm_pause(substream, false) under the PCM
stream lock, virtsnd_pcm_pause_restart_start() returns -EPIPE and
snd_pcm_undo_pause() -> virtsnd_pcm_pause_restart_pause() also returns -EPI=
PE
in the VIRTSND_PCM_PAUSE_RESTART_RELEASED branch without setting
runtime->stop_operating =3D true (unlike the
VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT branch just below it). Because
runtime->state remains SNDRV_PCM_STATE_PAUSED and runtime->stop_operating is
false, both snd_pcm_do_stop() and snd_pcm_sync_stop() skip teardown.

Should both of these -EPIPE paths call virtsnd_pcm_pause_restart_failed(vss,
epoch) (or arm vss->stopped and runtime->stop_operating)?

[ ... ]

> +static int virtsnd_pcm_pause_restart_stop(struct virtio_pcm_substream *v=
ss,
> +					  bool suspend)
> +{
> +	struct virtio_snd_msg *msg;
> +	enum virtio_pcm_pause_restart_state state;
> +	int rc;
> +	u64 epoch;
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (vss->resetting)
> +			return -ECANCELED;
> +		epoch =3D vss->reset_epoch;
> +		if (!vss->prepared && !vss->msg_count)
> +			return 0;
> +		if (suspend)
> +			vss->suspended =3D true;

[Severity: Medium]
In virtsnd_pcm_pause_restart_stop(), if suspend is true while !vss->prepared
&& !vss->msg_count, won't returning early skip setting vss->suspended =3D t=
rue?

In the native trigger path in virtsnd_pcm_trigger(), SNDRV_PCM_TRIGGER_SUSP=
END
sets vss->suspended =3D true before checking if (!vss->prepared) return 0. =
Here
in virtsnd_pcm_pause_restart_stop(), if (!vss->prepared && !vss->msg_count)
returns 0 before setting vss->suspended =3D true. If a stream in pause_rest=
art
mode has vss->prepared cleared and messages drained (for example, while pau=
sed
in VIRTSND_PCM_PAUSE_RESTART_RELEASED or after a failed pause transition) a=
nd
then receives SNDRV_PCM_TRIGGER_SUSPEND, vss->suspended remains false, so
staged pointer/ACK callbacks will not observe the suspended state and a
subsequent prepare will skip re-sending VIRTIO_SND_R_PCM_SET_PARAMS. Should
if (suspend) vss->suspended =3D true precede the early return check?

[ ... ]

> -static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
> +static int virtsnd_pcm_pb_ack_locked(struct snd_pcm_substream *substream)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
>  	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
>  	struct virtsnd_pcm_transfer transfer =3D {};
>  	int rc;
> =20
> -	rc =3D virtsnd_pcm_ack_state(substream);
> -	if (rc)
> -		return rc;
> -
>  	scoped_guard(spinlock_irqsave, &queue->lock) {
>  		guard(spinlock)(&vss->lock);
> +		if (vss->preparing)
> +			return -EBADFD;
> +		if (vss->xfer_xrun)
> +			return -EPIPE;
> +		if (!vss->prepared)
> +			return -EBADFD;
>  		transfer.indirect =3D vss->pcm_indirect;
>  		if (vss->stopped) {
>  			rc =3D -EPIPE;
> @@ -626,21 +1609,163 @@ static int virtsnd_pcm_pb_ack(struct snd_pcm_subs=
tream *substream)
>  	return 0;
>  }
[ ... ]
> +static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *v=
ss,
> +					  struct snd_pcm_runtime *runtime)
> +{
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	int rc =3D 0;
> +
> +	/*
> +	 * The RX callback holds the queue lock while draining completions.
> +	 * Account ALSA's read under the substream lock alone so completions la=
ter
> +	 * in that drain observe the newly released ring space.
> +	 */
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		snd_pcm_uframes_t appl_ptr;
> +		snd_pcm_sframes_t diff;
> +		size_t bytes;
> +		u64 outstanding;
> +		u64 next_acked_total;
> +		bool free_running;
[ ... ]
> +		appl_ptr =3D runtime->control->appl_ptr;
> +		diff =3D appl_ptr - vss->pcm_indirect.appl_ptr;
> +		if (diff < -(snd_pcm_sframes_t)(runtime->boundary / 2))
> +			diff +=3D runtime->boundary;
> +		if (diff < 0 ||
> +		    (snd_pcm_uframes_t)diff > runtime->buffer_size) {
> +			vss->xfer_xrun =3D true;
> +			virtsnd_pcm_schedule_period_elapsed(vss);
> +			return -EPIPE;
> +		}

[Severity: Medium]
Can carrying over an unconsumed sub-byte frame in vss->pcm_indirect.appl_ptr
cause a subsequent full-buffer ACK to fail this diff > runtime->buffer_size
check with a false -EPIPE?

For a sub-byte frame format such as 1-channel SNDRV_PCM_FORMAT_IMA_ADPCM
(where frame_bits =3D=3D 4), acknowledging 1 frame yields
bytes =3D frames_to_bytes(runtime, 1) =3D 0, leaving vss->pcm_indirect.appl=
_ptr
lagging runtime->control->appl_ptr (old_appl_ptr) by 1 frame.

If the application then advances appl_ptr by runtime->buffer_size frames in
free-running mode (which pcm_lib_apply_appl_ptr() allows because
appl_ptr - old_appl_ptr =3D=3D runtime->buffer_size, and which equals
vss->buffer_bytes in bytes), diff =3D appl_ptr - vss->pcm_indirect.appl_ptr
becomes runtime->buffer_size + 1. Checking
(snd_pcm_uframes_t)diff > runtime->buffer_size then rejects the ACK with
-EPIPE and latches vss->xfer_xrun before frames_to_bytes(runtime, diff) is
computed.

> +
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
> +		/* Keep an unconsumed sub-byte frame for the next acknowledgment. */
> +		vss->pcm_indirect.appl_ptr +=3D bytes_to_frames(runtime, bytes);

[Severity: Medium]
What happens here when an odd number of frames is acknowledged on a
multi-channel fractional-byte format (such as 3-, 5-, or 7-channel
SNDRV_PCM_FORMAT_IMA_ADPCM where frame_bits > 8 and frame_bits % 8 !=3D 0)?

For example, with 3-channel IMA_ADPCM (frame_bits =3D=3D 12, 2 frames =3D=
=3D 3 bytes),
if diff =3D=3D 1 frame, frames_to_bytes(runtime, 1) is 1 byte (or if diff =
=3D=3D 3
frames, bytes is 4 bytes). That unaligned byte count is committed to
vss->capture_acked_total and subtracted from vss->capture_ready, but
bytes_to_frames(runtime, bytes) then truncates 1 byte to 0 frames (or 4 byt=
es
to 2 frames =3D=3D 3 bytes) when advancing vss->pcm_indirect.appl_ptr.

Because vss->pcm_indirect.appl_ptr does not advance for that partial frame's
byte, the next ACK will include that frame again in diff and double-count t=
he
byte in vss->capture_acked_total, desynchronizing vss->capture_acked_total
from vss->pcm_indirect.appl_ptr and triggering a spurious -EPIPE XRUN when
next_acked_total exceeds vss->capture_pointer_seen_total or bytes exceeds
vss->capture_ready. Should bytes be rounded down to a whole number of frames
(for instance, frames_to_bytes(runtime, bytes_to_frames(runtime, bytes)))
before updating vss->capture_acked_total and vss->capture_ready?

[ ... ]

> +static int virtsnd_pcm_cp_ack_locked(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	struct virtsnd_pcm_transfer transfer =3D {};
> +	int rc;
> +
> +	if (vss->capture_staging) {
> +		rc =3D virtsnd_pcm_capture_staged_ack(vss, runtime);
> +		if (rc =3D=3D -EPIPE) {
> +			guard(spinlock_irqsave)(&vss->lock);
> +			virtsnd_pcm_capture_arm_paused_stop(vss);
> +		}
> +		return rc;
> +	}
> +
>  	scoped_guard(spinlock_irqsave, &queue->lock) {
>  		guard(spinlock)(&vss->lock);
> +		if (vss->preparing)
> +			return -EBADFD;
> +		if (vss->xfer_xrun)
> +			return -EPIPE;
> +		if (!vss->prepared)
> +			return -EBADFD;
>  		transfer.indirect =3D vss->pcm_indirect;
> -		if (vss->stopped) {
> +		if (vss->xfer_xrun ||
> +		    (vss->stopped && runtime->state !=3D SNDRV_PCM_STATE_DRAINING)) {
>  			rc =3D -EPIPE;
>  		} else {
>  			rc =3D snd_pcm_indirect_capture_transfer(substream,

[Severity: Medium]
When virtsnd_pcm_pb_ack_locked() or virtsnd_pcm_cp_ack_locked() returns
-EPIPE on a non-running substream (such as in SNDRV_PCM_STATE_PAUSED or
SNDRV_PCM_STATE_PREPARED), can leaving vss->stopped and
runtime->stop_operating unset cause a subsequent SNDRV_PCM_IOCTL_DROP to sk=
ip
virtsnd_pcm_sync_stop()?

In ALSA core, when pcm_lib_apply_appl_ptr() receives -EPIPE from ops->ack(),
it calls __snd_pcm_xrun(substream) -> snd_pcm_stop(substream,
SNDRV_PCM_STATE_XRUN). In snd_pcm_do_stop(), ALSA only invokes
ops->trigger(SNDRV_PCM_TRIGGER_STOP) and sets runtime->stop_operating =3D t=
rue
when snd_pcm_running(substream) is true. Once runtime->state becomes
SNDRV_PCM_STATE_XRUN, virtsnd_pcm_period_elapsed() also sees
runtime->state !=3D SNDRV_PCM_STATE_PAUSED and does not call
virtsnd_pcm_capture_arm_paused_stop().

There are two places where -EPIPE is returned from ACK without arming
vss->stopped and runtime->stop_operating:

1. In both virtsnd_pcm_pb_ack_locked() and virtsnd_pcm_cp_ack_locked(), the
   early check:

     if (vss->xfer_xrun)
             return -EPIPE;

   returns before reaching virtsnd_pcm_transfer_failed(vss) (which also mak=
es
   the second vss->xfer_xrun check in virtsnd_pcm_cp_ack_locked() unreachab=
le).

2. In virtsnd_pcm_cp_ack_locked() for staged capture, when
   virtsnd_pcm_capture_staged_ack() returns -EPIPE,
   virtsnd_pcm_capture_arm_paused_stop() only sets vss->stopped =3D true and
   runtime->stop_operating =3D true when runtime->state =3D=3D SNDRV_PCM_ST=
ATE_PAUSED,
   leaving SNDRV_PCM_STATE_PREPARED (and capture SNDRV_PCM_STATE_DRAINING)
   unarmed.

If the application then calls SNDRV_PCM_IOCTL_DROP, snd_pcm_drop() sees
runtime->state =3D=3D SNDRV_PCM_STATE_XRUN with runtime->stop_operating =3D=
=3D false
and transitions to SNDRV_PCM_STATE_SETUP without calling snd_pcm_sync_stop(=
),
leaving the device stream prepared/active and any queued descriptors
unreleased until prepare or hw_free. Should these -EPIPE paths always arm
vss->stopped and runtime->stop_operating via virtsnd_pcm_transfer_failed()?

[ ... ]

> +static int virtsnd_pcm_indirect_reset(struct snd_pcm_substream *substrea=
m)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	struct virtsnd_pcm_transfer transfer =3D {};
> +	snd_pcm_uframes_t paused_ptr =3D 0;
> +	bool paused =3D runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED;
> +	int rc;
> +
> +	/* Only PCM-locked callbacks access this observation flag. */
> +	vss->indirect_reset_observing =3D true;
> +	rc =3D snd_pcm_lib_reset(substream);
> +	vss->indirect_reset_observing =3D false;
> +	if (rc)
> +		return rc;
> +	guard(spinlock_irqsave)(&queue->lock);
> +	guard(spinlock)(&vss->lock);
> +	vss->preparing =3D false;
> +	if (vss->resetting || vss->xfer_xrun) {
> +		virtsnd_pcm_capture_reset_error(vss, runtime);
> +		return 0;
> +	}
> +	if (!snd_pcm_running(substream) && !paused) {
> +		vss->pcm_indirect.appl_ptr =3D runtime->status->hw_ptr;
> +		vss->pcm_indirect.sw_ready =3D 0;
> +		return 0;
> +	}
> +	if (!vss->prepared || vss->stopped) {
> +		virtsnd_pcm_transfer_failed(vss);
> +		vss->xfer_xrun =3D true;
> +		virtsnd_pcm_schedule_period_elapsed(vss);
> +		return 0;
> +	}
> +
> +	transfer.indirect =3D vss->pcm_indirect;
> +	if (paused) {
> +		/* Observe and reclaim paused completions in one queue transaction. */
> +		vss->capture_pointer_seen_total =3D vss->capture_copied_total;
> +		vss->indirect_reset_observing =3D true;
> +		paused_ptr =3D snd_pcm_indirect_capture_pointer(substream,
> +							      &transfer.indirect, vss->hw_ptr);
> +		vss->indirect_reset_observing =3D false;
> +		if (paused_ptr =3D=3D SNDRV_PCM_POS_XRUN) {
> +			virtsnd_pcm_transfer_failed(vss);
> +			vss->xfer_xrun =3D true;
> +			virtsnd_pcm_schedule_period_elapsed(vss);
> +			return 0;
> +		}
> +		runtime->status->hw_ptr =3D paused_ptr;
> +	}
> +	transfer.indirect.sw_ready =3D 0;
> +	/* Consume no application delta while returning discarded RX space. */
> +	transfer.indirect.appl_ptr =3D runtime->control->appl_ptr;
> +	rc =3D snd_pcm_indirect_capture_transfer(substream, &transfer.indirect,
> +					       virtsnd_pcm_trans_copy);
> +	if (!rc)
> +		rc =3D transfer.error;
> +	if (rc) {
> +		virtsnd_pcm_transfer_failed(vss);
> +		vss->xfer_xrun =3D true;
> +		virtsnd_pcm_schedule_period_elapsed(vss);
> +		return 0;
> +	}

[Severity: Medium]
In virtsnd_pcm_indirect_reset(), shouldn't the three error paths after
snd_pcm_lib_reset() also rebase vss->pcm_indirect.appl_ptr and clear
vss->pcm_indirect.sw_ready?

The commit message notes:

  Complete capture's private cursor rebase on RESET error paths while
  retaining the XRUN latch and notification. This permits the core's
  matching appl_ptr update without claiming stream recovery.

While the first error branch (vss->resetting || vss->xfer_xrun) calls
virtsnd_pcm_capture_reset_error(vss, runtime) to set
vss->pcm_indirect.appl_ptr =3D runtime->status->hw_ptr and
vss->pcm_indirect.sw_ready =3D 0, the other three error branches
(!vss->prepared || vss->stopped, paused_ptr =3D=3D SNDRV_PCM_POS_XRUN, and =
rc !=3D 0
from snd_pcm_indirect_capture_transfer()) return 0 to snd_pcm_reset_substre=
am()
without updating vss->pcm_indirect.appl_ptr or vss->pcm_indirect.sw_ready,
leaving vss->pcm_indirect desynchronized from runtime->control->appl_ptr.
Should those three branches also call virtsnd_pcm_capture_reset_error(vss,
runtime) after setting vss->xfer_xrun =3D true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080821.1698=
3-1-mynameisjune111@gmail.com?part=3D10
