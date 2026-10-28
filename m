Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146768;
	b=nM7N/c3wuvqSSrfiQwsP70MJnboEVA8foAXx2UvGAOOdGd6tzj1bjXkOx+B2w5R4MzW3
	 p/D/eW5N/eFINraV1yEalGHsH5BnCVAwyL9DrbzPJDSKn5QHR1Ed8C8ihsGy2VnVHKdxp
	 1s0oZpTM3er8MufsVUdSFP63pwYUGK/4DgLGr28hPH10/1zywObDZ01F/ktCkdLao0fe2
	 QBC0BxhiHYh3oG6u9anuS2fqiJYDX9nCzqR8qE7alYpGB6NG8eqF3z28x/cUnRVGTCpmK
	 4oPXx45e/rxMcKdYG0vdzo7Sf4HHy7TuSu46T5M4szUZ75dSF08JTckHv4pwNg1XlWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146768;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i3G8Cs8iAy6CSb5kVfEiU25BaJRD3JP4wZIQpsE79tk=;
	b=UeSqXprmh9cTpRnzReCUFyX3ZtMJb1rTPEjVoG024yLtb/n38KKiFSl8p9iL+6G5futs
	 QOxjD9ctgZ1+FIP15/ZHlU1/u+dKhn2ahQyhrXMXwFyaalKaEEWouQ+Gp0HWaRqD9uFK1
	 6G/Flu3MaPETK6Tn4yCTebc0ATzS6j/eU+tf1zrb3JKBF+lrgxqoNvDctMMc0hzC4E/7n
	 YJbw7U3dlySMwz75/le6kkppri8lE31lVVWcZ/ZzSoh03gWv9dHuE9QWB3xl41sHoNMFH
	 G6ACd4/IlNTlH8D81oQV20VJYLmotRX19gV7cazBU9ccEozZpoNnyLDy6f2h2V6iNYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpwbJs4X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7DD606A31D;
	Wed, 28 Oct 2026 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YpwbJs4X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B871F01825;
	Wed, 28 Oct 2026 00:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146767;
	bh=i3G8Cs8iAy6CSb5kVfEiU25BaJRD3JP4wZIQpsE79tk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YpwbJs4XQGPu48prqYiLarqomFBr4dYtJzd1PeyXvXoDese/X6bzXfuK5NpoBT0eP
	 ZjmBVC/523SxuFxtiuoDd7LXooKix/JgpltO8M/KP0PjaqSQy7QtA7ZFt49y5A0+Lz
	 UZvnMwPQwH269cTX7Z+nj9DBN35frNnxn8DGG1wsCQ2VEO3ezGECFEGdBLD2Zeidup
	 XJarxCCiBpmXt2QkxzUAo6ygYLnU46zG6EQVAS05QjZmpd1uo2U1XQyAQ2zcVE8rnj
	 t4j+IT71YtRn6E3UYF+KHPYVqrsSA3X4Xcu0gkNrRXyJZOYGMzcc9+Wt9DinbieGCl
	 7M7o6tbywhjPA==
Message-ID: <sashiko-outbox-187269@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/11] ALSA: virtio: stage VZ capture and restart
 paused streams
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261027234334.32551-8-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
 <20261027234334.32551-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 00:19:27 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] ALSA: virtio: UAF and NULL deref of runtime in virtsnd_pcm_period_=
elapsed()
- [High] ALSA: virtio: virtsnd_pcm_pause_restart_send() bricks stream on si=
gnal or error
- [Medium] ALSA: virtio: pause_restart_state not reconciled across suspend =
and resume
- [Medium] ALSA: virtio: virtsnd_pcm_pause_restart_pause() skips flush on R=
ELEASE_SENT
- [Medium] ALSA: virtio: unlocked state reset in virtsnd_pcm_prepare() race=
s with ack
- [Medium] ALSA: virtio: virtsnd_pcm_cp_ack() checks acked bytes against co=
pied_total
- [Low] ALSA: virtio: undocumented module parameters in virtio_pcm_ops.c
- [Low] ALSA: virtio: unused pause_restart parameter in virtsnd_pcm_start_f=
ailed()
--

commit d608f6a99cc3b67a96be954c9e03a4e0866d62bf
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: stage VZ capture and restart paused streams

This commit adds opt-in capture staging with response validation and
accounting, along with a pause release and reprepare state machine for
capture streams.

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

[Severity: High]
Can virtsnd_pcm_period_elapsed() dereference a null or freed
substream->runtime when calling snd_pcm_running(substream) here?

In virtsnd_pcm_pause_restart_sync_stop() in sound/virtio/virtio_pcm_ops.c,
cancel_work_sync(&vss->elapsed_period) is called at entry, but every
subsequent error branch calls virtsnd_pcm_pause_restart_fail():

	cancel_work_sync(&vss->elapsed_period);

	if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
	    virtsnd_pcm_pause_restart_transitioning(state)) {
		virtsnd_pcm_pause_restart_fail(vss, true);
		...
		return -EIO;
	}

In turn, virtsnd_pcm_pause_restart_fail() checks !vss->xfer_xrun and
schedules vss->elapsed_period even when vss->runtime_active and
vss->xfer_enabled are false:

	scoped_guard(spinlock_irqsave, &vss->lock) {
		notify_xrun =3D !vss->xfer_xrun;
		...
	}
	if (notify_xrun)
		schedule_work(&vss->elapsed_period);

When virtsnd_pcm_open() calls virtsnd_pcm_sync_stop() ->
virtsnd_pcm_pause_restart_sync_stop() and it fails (for example, after a
prior failed control message or a RELEASE flush timeout), vss->elapsed_peri=
od
is re-queued and virtsnd_pcm_open() returns an error to
snd_pcm_open_substream().

Because substream->ops->open() failed before substream->hw_opened is set,
snd_pcm_release_substream() skips virtsnd_pcm_close() and frees
substream->runtime via snd_pcm_detach_substream() without holding
pcm_stream_lock. When virtsnd_pcm_period_elapsed() then runs,
snd_pcm_running(substream) dereferences substream->runtime->state before
substream->runtime is checked for null.

Should virtsnd_pcm_pause_restart_fail() avoid scheduling vss->elapsed_period
when the stream is not active, and should virtsnd_pcm_period_elapsed() also
verify substream->runtime before calling snd_pcm_running(substream)?

[ ... ]

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index f74bf365065b6..003832d112551 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -3,10 +3,41 @@
>   * virtio-snd: Virtio sound device
>   * Copyright (C) 2021 OpenSynergy GmbH
>   */
> +#include <linux/moduleparam.h>
> +#include <linux/overflow.h>
>  #include <sound/pcm_params.h>
> =20
>  #include "virtio_card.h"
> =20
> +bool virtsnd_capture_staging;
> +module_param_named(capture_staging, virtsnd_capture_staging, bool, 0444);
> +MODULE_PARM_DESC(capture_staging,
> +		 "Use request-owned buffers for experimental PCM capture");
> +
> +bool virtsnd_capture_packed_status;
> +module_param_named(capture_packed_status, virtsnd_capture_packed_status,
> +		   bool, 0444);
> +MODULE_PARM_DESC(capture_packed_status,
> +		 "Read staged capture status after the actual audio payload");
> +
> +bool virtsnd_capture_allow_short;
> +module_param_named(capture_allow_short, virtsnd_capture_allow_short,
> +		   bool, 0444);
> +MODULE_PARM_DESC(capture_allow_short,
> +		 "Accept non-empty short staged capture responses");
> +
> +bool virtsnd_capture_allow_empty;
> +module_param_named(capture_allow_empty, virtsnd_capture_allow_empty,
> +		   bool, 0444);
> +MODULE_PARM_DESC(capture_allow_empty,
> +		 "Retry bounded empty startup capture responses");
> +
> +static bool virtsnd_capture_pause_restart;
> +module_param_named(capture_pause_restart, virtsnd_capture_pause_restart,
> +		   bool, 0444);
> +MODULE_PARM_DESC(capture_pause_restart,
> +		 "Release and reprepare staged capture streams across pause");

[Severity: Low]
Should these five new module parameters (capture_staging,
capture_packed_status, capture_allow_short, capture_allow_empty, and
capture_pause_restart) be documented in
Documentation/admin-guide/kernel-parameters.txt?

> @@ -98,15 +129,195 @@ static const struct virtsnd_a2v_rate g_a2v_rate_map=
[] =3D {
> =20
>  static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);
> =20
> -static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss)
> +static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss,
> +				     bool pause_restart)
>  {
>  	scoped_guard(spinlock_irqsave, &vss->lock) {
>  		vss->xfer_enabled =3D false;
>  		vss->stopped =3D true;
> +		if (pause_restart)
> +			vss->xfer_xrun =3D true;
>  	}
>  	vss->substream->runtime->stop_operating =3D true;
>  }

[Severity: Low]
Is the pause_restart parameter in virtsnd_pcm_start_failed() still needed?
Both call sites in virtsnd_pcm_trigger() pass false because the pause_resta=
rt
path returns early via virtsnd_pcm_pause_restart_start().

[ ... ]

> +static int
> +virtsnd_pcm_pause_restart_send(struct virtio_pcm_substream *vss,
> +			       struct virtio_snd_msg *msg,
> +			       unsigned long allowed_states,
> +			       enum virtio_pcm_pause_restart_state submitted_state,
> +			       enum virtio_pcm_pause_restart_state success_state)
> +{
> +	enum virtio_pcm_pause_restart_state state;
> +	int rc;
> +
> +	if (!virtsnd_pcm_pause_restart_enabled(vss))
> +		return virtsnd_ctl_msg_send_sync(vss->snd, msg);
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		state =3D vss->pause_restart_state;
> +		if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED) {
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
> +
> +	if (rc) {
> +		virtsnd_ctl_msg_unref(msg);
> +		return rc;
> +	}
> +
> +	rc =3D virtsnd_ctl_msg_send_sync(vss->snd, msg);
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (rc || vss->pause_restart_state !=3D submitted_state) {
> +			vss->pause_restart_state =3D
> +				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
> +			if (!rc)
> +				rc =3D -EIO;
> +		} else {
> +			vss->pause_restart_state =3D success_state;
> +		}
> +	}

[Severity: High]
What happens if virtsnd_ctl_msg_send_sync() returns -ERESTARTSYS due to a
pending signal (or fails with a control error) during SET_PARAMS, PREPARE, =
or
START?

In virtsnd_ctl_msg_send(), only VIRTIO_SND_R_PCM_STOP and
VIRTIO_SND_R_PCM_RELEASE use uninterruptible waits; SET_PARAMS, PREPARE, and
START use wait_for_completion_interruptible_timeout(), which returns
-ERESTARTSYS immediately when a signal is pending (including during close or
snd_pcm_drop() of a paused stream, where ALSA core first unpauses via
SNDRV_PCM_TRIGGER_PAUSE_RELEASE -> virtsnd_pcm_pause_restart_start()).

Furthermore, in virtsnd_pcm_pause_restart_start(), virtsnd_pcm_capture_send=
()
queues RX capture buffers into the virtqueue (incrementing vss->msg_count)
before calling virtsnd_pcm_pause_restart_send() for VIRTIO_SND_R_PCM_START:

	scoped_guard(spinlock_irqsave, &queue->lock) {
		guard(spinlock)(&vss->lock);
		...
		rc =3D virtsnd_pcm_capture_send(vss);
		if (!rc)
			vss->xfer_enabled =3D true;
	}
	...
	rc =3D virtsnd_pcm_pause_restart_send(vss, msg,
					    BIT(VIRTSND_PCM_PAUSE_RESTART_PREPARED),
					    VIRTSND_PCM_PAUSE_RESTART_START_SUBMITTED,
					    VIRTSND_PCM_PAUSE_RESTART_RUNNING);

When virtsnd_pcm_pause_restart_send() sets vss->pause_restart_state to
VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED on any non-zero rc,
virtsnd_pcm_pause_restart_sync_stop() immediately aborts with -EIO without
sending VIRTIO_SND_R_PCM_RELEASE or waiting for vss->msg_empty.

Doesn't this permanently wedge the substream until device reprobe, while al=
so
leaving the queued RX buffers in the virtqueue so virtsnd_pcm_hw_free()
cannot free vss->msgs and msg->data on close?

[ ... ]

> @@ -296,9 +564,22 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substr=
eam *substream)
>  {
>  	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
>  	struct virtio_device *vdev =3D vss->snd->vdev;
> -	struct virtio_snd_msg *msg;
> +	bool pause_restart =3D virtsnd_pcm_pause_restart_enabled(vss);
> +	int rc;
>  	bool stopped;
> =20
> +	if (pause_restart) {
> +		enum virtio_pcm_pause_restart_state state;
> +
> +		scoped_guard(spinlock_irqsave, &vss->lock)
> +			state =3D vss->pause_restart_state;
> +		if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
> +		    virtsnd_pcm_pause_restart_transitioning(state)) {
> +			virtsnd_pcm_pause_restart_fail(vss, true);
> +			return -EIO;
> +		}
> +	}
> +
>  	scoped_guard(spinlock_irqsave, &vss->lock)
>  		stopped =3D vss->stopped;
>  	if (stopped) {

[Severity: Medium]
How are vss->pause_restart_state and vss->stopped reconciled across system
suspend and resume?

During virtsnd_freeze(), virtsnd_ctl_msg_cancel_all() cancels any in-flight
control messages (which sets vss->pause_restart_state to
VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED in virtsnd_pcm_pause_restart_send(=
))
and virtsnd_reset_vqs() resets the VirtIO device, returning all streams on
the device to their initial unconfigured state. However, neither
virtsnd_freeze() nor virtsnd_restore() resets vss->pause_restart_state to
VIRTSND_PCM_PAUSE_RESTART_NONE.

In addition, if snd_pcm_suspend_all() suspends a stream that is currently in
SNDRV_PCM_STATE_PAUSED with capture_pause_restart enabled, snd_pcm_do_suspe=
nd()
skips ops->trigger(SNDRV_PCM_TRIGGER_SUSPEND) and does not set
runtime->stop_operating because snd_pcm_running(substream) is false. That
leaves vss->stopped set to true and vss->suspended set to false in
SNDRV_PCM_STATE_SUSPENDED, so a subsequent snd_pcm_prepare() skips
virtsnd_pcm_sync_stop() and fails at the if (stopped) check in
virtsnd_pcm_prepare() with -EBADFD.

Should virtsnd_freeze() / virtsnd_restore() and virtsnd_pcm_prepare() recon=
cile
vss->pause_restart_state and vss->stopped after suspend?

> @@ -321,16 +602,23 @@ static int virtsnd_pcm_prepare(struct snd_pcm_subst=
ream *substream)
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
> +			if (pause_restart)
> +				virtsnd_pcm_pause_restart_fail(vss, false);
>  			return rc;
> +		}
>  	}
> =20
> -	vss->xfer_xrun =3D false;
> +	/* ALSA prepare resets its pointers even after a suspended stream. */
> +	if (vss->capture_staging)
> +		vss->hw_ptr =3D 0;
> +
> +	if (!pause_restart)
> +		vss->xfer_xrun =3D false;
>  	vss->suspended =3D false;
>  	vss->msg_count =3D 0;
>  	virtsnd_pcm_msg_reset(vss);
> @@ -340,12 +628,210 @@ static int virtsnd_pcm_prepare(struct snd_pcm_subs=
tream *substream)
>  		vss->pcm_indirect.hw_buffer_size =3D
>  		snd_pcm_lib_buffer_bytes(substream);

[Severity: Medium]
Can these unlocked updates to vss->buffer_bytes, vss->hw_ptr, vss->xfer_xru=
n,
vss->msg_count, and vss->pcm_indirect in virtsnd_pcm_prepare() race with a
concurrent virtsnd_pcm_cp_ack() call?

Because vpcm->pcm->nonatomic is true, snd_pcm_prepare() calls
virtsnd_pcm_prepare() under runtime->buffer_mutex without holding
pcm_stream_lock. Meanwhile, SNDRV_PCM_IOCTL_SYNC_PTR in snd_pcm_sync_ptr()
acquires pcm_stream_lock and invokes pcm_lib_apply_appl_ptr() ->
virtsnd_pcm_cp_ack(), which enters the staged capture path whenever
vss->runtime_active is true (set in virtsnd_pcm_hw_params()).

If virtsnd_pcm_cp_ack() runs after virtsnd_pcm_prepare() sets vss->hw_ptr =
=3D 0
but before virtsnd_pcm_msg_reset() zeroes vss->capture_copied_total under
vss->lock, virtsnd_pcm_capture_counters_valid(vss) in virtsnd_pcm_cp_ack() =
can
see vss->hw_ptr !=3D vss->capture_copied_total % vss->buffer_bytes, set
vss->xfer_xrun =3D true, and return -EPIPE, while memset(&vss->pcm_indirect=
, 0,
sizeof(vss->pcm_indirect)) also races with virtsnd_pcm_cp_ack() reading and
updating vss->pcm_indirect.appl_ptr.

Should all of these state resets in virtsnd_pcm_prepare() be performed
together under vss->lock?

[ ... ]

> +static int virtsnd_pcm_pause_restart_pause(struct virtio_pcm_substream *=
vss)
> +{
> +	struct virtio_snd_msg *msg;
> +	enum virtio_pcm_pause_restart_state state;
> +	int rc;
> +
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		state =3D vss->pause_restart_state;
> +		if (state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT ||
> +		    state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEASED)
> +			return 0;
> +		vss->xfer_enabled =3D false;
> +		vss->stopped =3D true;
> +	}

[Severity: Medium]
Should virtsnd_pcm_pause_restart_pause() return 0 immediately when state is
VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT?

In virtsnd_pcm_pause_release_flush(), sending VIRTIO_SND_R_PCM_RELEASE sets
vss->pause_restart_state to VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT before
waiting on vss->msg_empty:

	rc =3D virtsnd_pcm_pause_restart_send(vss, msg,
					    allowed_states,
					    VIRTSND_PCM_PAUSE_RESTART_RELEASE_SUBMITTED,
					    VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT);
	if (rc)
		return rc;

	waited =3D wait_event_timeout(vss->msg_empty,
				    !virtsnd_pcm_msg_pending_num(vss), js);

If that wait times out, vss->pause_restart_state remains
VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT while RX messages may still be pendi=
ng,
and ALSA keeps the substream in SNDRV_PCM_STATE_RUNNING.

Unlike virtsnd_pcm_pause_restart_sync_stop(), which waits on vss->msg_empty
when in VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT and transitions to
VIRTSND_PCM_PAUSE_RESTART_RELEASED, virtsnd_pcm_pause_restart_pause() retur=
ns
0 immediately without waiting for the queue to drain or updating the state =
to
VIRTSND_PCM_PAUSE_RESTART_RELEASED. A subsequent SNDRV_PCM_TRIGGER_PAUSE_RE=
LEASE
in virtsnd_pcm_pause_restart_start(vss, true) will then fail with -EBADFD
because it requires state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEASED.

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
Should virtsnd_pcm_cp_ack() validate next_acked_total against
vss->capture_pointer_seen_total rather than vss->capture_copied_total?

When virtsnd_pcm_capture_complete() copies completed RX payloads into
runtime->dma_area, it advances vss->capture_copied_total and
vss->capture_ready immediately, whereas runtime->status->hw_ptr and
vss->capture_pointer_seen_total only advance when virtsnd_pcm_cp_pointer()
runs.

If userspace invokes SNDRV_PCM_IOCTL_SYNC_PTR without
SNDRV_PCM_SYNC_PTR_HWSYNC (or while in SNDRV_PCM_STATE_PAUSED, where
do_pcm_hwsync() is a no-op) with appl_ptr advancing into the range between
vss->capture_pointer_seen_total and vss->capture_copied_total,
snd_pcm_sync_ptr() calls pcm_lib_apply_appl_ptr() -> virtsnd_pcm_cp_ack()
without calling virtsnd_pcm_cp_pointer().

Because virtsnd_pcm_cp_ack() checks next_acked_total >
vss->capture_copied_total, it accepts the update and allows
runtime->control->appl_ptr to move ahead of runtime->status->hw_ptr, causing
snd_pcm_capture_avail() to underflow and wrap around runtime->boundary.
(Note: a separate issue here where a virtsnd_pcm_capture_send() failure
returns an error after committing vss->capture_acked_total is addressed in a
later commit in this series, "ALSA: virtio: account staged capture reads
before RX refill".)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027234334.3255=
1-1-mynameisjune111@gmail.com?part=3D7
