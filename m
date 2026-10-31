Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793415065;
	b=hWBRpHdtz4lDRE4HDE07m+bJJiqbFcVfbcf6T/t+IEk0YDRVXmfzv4vOtFritSUs499z
	 qxB6I/KEqwKLTHWFo9CRn0z9Zb+DTh74Ld2ayjW2syvAYLsXePGasncuPv9l9Mt/cdSB2
	 KYFJbRqlyUlCS425JgGDDQo9dpAAhf3iiPek1NajS6GakBaffMQbm0yztHbHXlYdmaqFK
	 JZzJGVVXrWYc03q95qfZ/5GF5BKeQ5ATxCrI2WKu3elBCBUe9IhVBu4cre57gtXpvdUZD
	 b1GjtQk3TtIR4LC9fj79pHfzLfzkKG8b2mkKCQBqQm5O5qFCrdsTLAHBsxF+hkfVvXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793415065;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LzoYHOMoLB0LqfF9NMl4OYWWeK+7KEdxi2FDKqa8ToU=;
	b=U2zcupqT7R1PGzRbud53K7zvkoNnqRpTEn1VjjF24Wzoj3G+A2b7bRcO6lmmrKhCyfAR
	 Ym+qE0ZKtIj7mu9KMeDORZ9Yk199ZYHh/G9vZejxFMCYx7IHqaHCU40l4YJEs6HcksXLg
	 aPto/j9WegUc7AKATBfhB99y8D6LUGMXK0nj+8yx6NgQiFjczyCzP+72Evq5n7Y/sGs+3
	 HcR73lnagJDoDlgTUfN9+Ea9d8psYnnRXkKZVUNlHDfmAlcW3End+rxEafeB3rGY4lfRb
	 LtCrNuE5EeaNNG9NLJo0xsPJI3R9x/TKQVWAc956ndPCO3FD0AXCuNo+i/s7dLleilg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YN76sLiS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C3606A31A;
	Sat, 31 Oct 2026 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YN76sLiS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05F41F000C1;
	Sat, 31 Oct 2026 02:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793415064;
	bh=LzoYHOMoLB0LqfF9NMl4OYWWeK+7KEdxi2FDKqa8ToU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YN76sLiS67qs+Y8E0AHfG/XHMhFxPWNM5MB281/XgKbKVUKIPZ/hFXJ7otetJMfsY
	 wKjGZxm4y0ZvakJr0t/GcVD7UawbFPn9z7WMVdKFRHPGWefenWzSUXkth/cZaS13ma
	 +cJ7oNJJvUTcmgNfb3dvipsOMcZjkou40t20aeO/h2C6SUSQB6DswhsFtubB9f97N9
	 F/BU64rakaUxYvd1hO8SwhpDhZLrnrBx665puBhFUyhsttbm0GFQAjln2rsUUhNo1M
	 ORBZL+TquVJiFxNiMxAlxTM02xi4DTNyfXwWg5FCNhmHxVYElsjqZgSQyOl9F8GWir
	 s3umW1wHlRGkg==
Message-ID: <sashiko-outbox-191718@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/14] ALSA: virtio: add staged capture accounting
 and lifecycle recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031020855.2402-10-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
 <20261031020855.2402-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:51:04 +0000
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
- [High] ALSA: virtio: false XRUN on capture drain in virtsnd_pcm_msg_compl=
ete()
- [High] ALSA: virtio: buffer_mutex trylock in ack corrupts indirect PCM st=
ate
- [High] ALSA: virtio: buffer_mutex trylock in virtsnd_pcm_pb_ack() fails d=
uring RESET
- [Medium] ALSA: virtio: staged capture drops RX completions during pause i=
n virtsnd_pcm_capture_complete()
- [Medium] ALSA: virtio: missed XRUN wakeup when RX ring fills during pause=
 in virtsnd_pcm_msg_complete()
- [Medium] ALSA: virtio: virtsnd_pcm_event() skips period work for ordinary=
 capture XRUN events
- [Medium] ALSA: virtio: virtsnd_pcm_start_queue() drops period notificatio=
ns
- [Medium] ALSA: virtio: failed STOP in virtsnd_pcm_trigger() misses xfer_x=
run latch
- [Medium] ALSA: virtio: premature state reset in virtsnd_pcm_prepare_locke=
d()
- [Medium] ALSA: virtio: missing stopped check in virtsnd_pcm_capture_stage=
d_ack()
--

commit 89969d05596ec30bdd3e3e6560275f8867f0911d
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: add staged capture accounting and lifecycle recovery

This commit adds staged capture accounting using request-owned DMA buffers =
and
monotonic position counters, while separating device running state, RELEASE
obligations, and reset epochs from ALSA runtime state. It also serializes P=
CM
lifecycle callbacks with lifecycle_lock and updates pause, XRUN, and period
wakeup handling across ordinary and staged capture paths.

Link: https://sashiko.dev/#/patchset/20261030052629.27742-1-mynameisjune111=
%40gmail.com?part=3D9

> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index be3893de40a55..aed94a892aaa4 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c

[ ... ]

> @@ -517,8 +630,11 @@ void virtsnd_pcm_event(struct virtio_snd *snd, struc=
t virtio_snd_event *event)
>  		break;
>  	case VIRTIO_SND_EVT_PCM_XRUN:
>  		scoped_guard(spinlock, &vss->lock) {
> -			if (vss->xfer_enabled)
> +			if (vss->xfer_enabled) {
>  				vss->xfer_xrun =3D true;
> +				if (vss->capture_staging)
> +					virtsnd_pcm_schedule_period_elapsed(vss);
> +			}
>  		}
>  		break;
>  	}

[Severity: Medium]
When VIRTIO_SND_EVT_PCM_XRUN arrives in virtsnd_pcm_event() while
vss->xfer_enabled is true, why is virtsnd_pcm_schedule_period_elapsed(vss)
only called when vss->capture_staging is set?

In virtsnd_pcm_period_elapsed(), ordinary capture now checks vss->xfer_xrun
and calls snd_pcm_progress_under_stream_lock(substream), which observes
SNDRV_PCM_POS_XRUN from virtsnd_pcm_cp_pointer() and triggers
__snd_pcm_xrun().

However, if the device sends VIRTIO_SND_EVT_PCM_XRUN on an ordinary capture
substream (!vss->capture_staging) and stops completing RX buffers, skipping
virtsnd_pcm_schedule_period_elapsed(vss) here leaves ALSA unaware of the XR=
UN
until a read timeout expires. Should this check vss->direction =3D=3D
SNDRV_PCM_STREAM_CAPTURE instead of vss->capture_staging?

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index b94ab24f5ffef..cdd26729568a1 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c

[ ... ]

> @@ -478,6 +530,290 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substrea=
m *vss, unsigned long offset,

[ ... ]

> +static void virtsnd_pcm_capture_complete(struct virtio_pcm_msg *msg,
> +					 size_t written_bytes)
> +{
> +	struct virtio_pcm_substream *vss =3D msg->substream;
> +	size_t audio_bytes =3D 0;
> +	size_t next_ready =3D 0;
> +	u64 next_copied_total =3D 0;
> +	bool free_running =3D false;
> +	bool got_audio =3D false;
> +
> +	guard(spinlock)(&vss->lock);
> +	vss->msg_count--;
> +	if (vss->runtime_active && vss->xfer_enabled && !vss->xfer_xrun) {
> +		struct snd_pcm_runtime *runtime =3D vss->substream->runtime;

[Severity: Medium]
In virtsnd_pcm_capture_complete(), does gating completion processing on
vss->xfer_enabled drop in-flight RX completions during a native pause
transition?

When userspace triggers SNDRV_PCM_TRIGGER_PAUSE_PUSH on an active staged
capture stream (with virtsnd_capture_pause_restart disabled),
virtsnd_pcm_trigger() clears vss->xfer_enabled =3D false under vss->lock wh=
ile
keeping vss->prepared =3D true and vss->stopped =3D false, and then calls
virtsnd_pcm_stop_device() to send VIRTIO_SND_R_PCM_STOP synchronously:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_trigger() {
	...
	case SNDRV_PCM_TRIGGER_STOP:
	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
		scoped_guard(spinlock_irqsave, &vss->lock) {
			if (!vss->prepared)
				return 0;
			if (command !=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH)
				vss->stopped =3D true;
			vss->xfer_enabled =3D false;
			if (!vss->device_running)
				return 0;
		}

		rc =3D virtsnd_pcm_stop_device(vss, epoch);
}

While VIRTIO_SND_R_PCM_STOP is in flight (both when STOP succeeds and when
the device rejects STOP), the device can complete already-queued RX request=
s.
Unlike ordinary capture in virtsnd_pcm_msg_complete(), which checks
vss->prepared && !vss->stopped for NOMMU copyout and still updates
vss->hw_ptr, vss->capture_copied_total, and vss->xfer_xrun when
vss->xfer_enabled is false, virtsnd_pcm_capture_complete() skips status
validation, overrun checks, memcpy() into runtime->dma_area, and counter
updates, and then resets msg->length =3D 0.

When pause is rejected or later resumed via SNDRV_PCM_TRIGGER_PAUSE_RELEASE,
virtsnd_pcm_capture_enqueue() zeroes and re-queues those descriptors,
permanently losing the captured audio frames and any device status or ring
overrun error.

[ ... ]

> @@ -580,14 +924,22 @@ static void virtsnd_pcm_msg_complete(struct virtio_=
pcm_msg *msg,
>  	 * the actual SG payload capacity before accounting them.
>  	 */
>  	if (vss->direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK ||
> -	    written_bytes <=3D sizeof(msg->status)) {
> -		vss->hw_ptr +=3D msg->length;
> -	} else {
> -		size_t data_bytes =3D min_t(size_t,
> -					  written_bytes - sizeof(msg->status),
> -					  msg->length);
> -
> -		vss->hw_ptr +=3D data_bytes;
> +	    written_bytes <=3D sizeof(*msg->status))
> +		completed_bytes =3D msg->length;
> +	else
> +		completed_bytes =3D min_t(size_t,
> +					written_bytes - sizeof(*msg->status),
> +					msg->length);
> +	vss->hw_ptr +=3D completed_bytes;
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> +		/* A full unseen ring cannot be represented by the modulo pointer. */
> +		if (check_add_overflow(vss->capture_copied_total,
> +				       (u64)completed_bytes,
> +				       &vss->capture_copied_total) ||
> +		    vss->capture_copied_total < vss->capture_pointer_seen_total ||
> +		    vss->capture_copied_total - vss->capture_pointer_seen_total >=3D
> +			vss->buffer_bytes)
> +			vss->xfer_xrun =3D true;
>  	}

[Severity: High]
Can this unconditional update of vss->capture_copied_total in
virtsnd_pcm_msg_complete() trigger a false XRUN during capture drain?

When an application calls snd_pcm_drain() (SNDRV_PCM_IOCTL_DRAIN) on a
running ordinary capture stream with unread frames in the buffer,
snd_pcm_do_drain_init() transitions the stream to SNDRV_PCM_STATE_DRAINING
and invokes virtsnd_pcm_trigger(SNDRV_PCM_TRIGGER_STOP), which sets
vss->stopped =3D true and vss->xfer_enabled =3D false and sends
VIRTIO_SND_R_PCM_STOP.

In SNDRV_PCM_STATE_DRAINING, snd_pcm_running(substream) is false and
virtsnd_pcm_cp_pointer() is no longer called, so
vss->capture_pointer_seen_total stops advancing. However,
virtsnd_pcm_msg_complete() continues to add completed_bytes (including a fu=
ll
period msg->length when written_bytes <=3D sizeof(*msg->status) for empty or
status-only completions) to vss->hw_ptr and vss->capture_copied_total even
when vss->stopped is true.

When the seeded RX ring descriptors complete after STOP or RELEASE,
vss->capture_copied_total - vss->capture_pointer_seen_total reaches
vss->buffer_bytes and latches vss->xfer_xrun =3D true. Subsequent draining
reads via snd_pcm_readi() or SNDRV_PCM_IOCTL_SYNC_PTR then call
virtsnd_pcm_cp_ack_locked(), which checks:

	if (vss->xfer_xrun ||
	    (vss->stopped && runtime->state !=3D SNDRV_PCM_STATE_DRAINING)) {
		rc =3D -EPIPE;
	}

and aborts the capture drain with -EPIPE, discarding the already-captured
audio frames.

>  	if (vss->hw_ptr >=3D vss->buffer_bytes)
> @@ -595,7 +947,9 @@ static void virtsnd_pcm_msg_complete(struct virtio_pc=
m_msg *msg,
> =20
>  	msg->length =3D 0;
> =20
> -	vss->xfer_xrun =3D false;
> +	/* Preserve a latched capture error until prepare recovers it. */
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		vss->xfer_xrun =3D false;
>  	vss->msg_count--;
> =20
>  	if (vss->xfer_enabled) {
> @@ -603,8 +957,8 @@ static void virtsnd_pcm_msg_complete(struct virtio_pc=
m_msg *msg,
> =20
>  		runtime->delay =3D
>  			bytes_to_frames(runtime,
> -					le32_to_cpu(msg->status.latency_bytes));
> -		schedule_work(&vss->elapsed_period);
> +					le32_to_cpu(msg->status->latency_bytes));
> +		virtsnd_pcm_schedule_period_elapsed(vss);
>  	} else if (!vss->msg_count) {
>  		wake_up_all(&vss->msg_empty);
>  	}

[Severity: Medium]
What happens if in-flight ordinary capture RX completions fill the unread
ring while SNDRV_PCM_TRIGGER_PAUSE_PUSH is waiting for VIRTIO_SND_R_PCM_STOP
and the STOP request succeeds?

During SNDRV_PCM_TRIGGER_PAUSE_PUSH, virtsnd_pcm_trigger() clears
vss->xfer_enabled =3D false before calling virtsnd_pcm_stop_device(vss, epo=
ch).
If the device completes queued RX requests before processing
VIRTIO_SND_R_PCM_STOP and vss->capture_copied_total -
vss->capture_pointer_seen_total reaches vss->buffer_bytes,
virtsnd_pcm_msg_complete() latches vss->xfer_xrun =3D true, but skips
virtsnd_pcm_schedule_period_elapsed(vss) because vss->xfer_enabled is false.

When virtsnd_pcm_stop_device() returns 0, virtsnd_pcm_trigger() only checks
if (rc && command =3D=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH) and returns 0 without
scheduling elapsed_period. ALSA transitions runtime->state to
SNDRV_PCM_STATE_PAUSED, and the paused_xrun handler in
virtsnd_pcm_period_elapsed() never runs to move the stream to
SNDRV_PCM_STATE_XRUN, leaving readers in wait_for_avail() sleeping
indefinitely.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index ad602b6b6530b..d587c8f699553 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -320,47 +706,383 @@ static int virtsnd_pcm_prepare(struct snd_pcm_subs=
tream *substream)

[ ... ]

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
> +
> +	rc =3D virtsnd_pcm_dev_prepare(vss, epoch);
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (epoch !=3D vss->reset_epoch || vss->resetting)
> +			return -ECANCELED;
> +		vss->prepared =3D !rc;
> +		if (!rc)
> +			vss->release_required =3D true;
> +	}
> +	if (pause_restart) {
> +		if (rc) {
> +			if (rc =3D=3D -ECANCELED)
> +				return rc;
> +			virtsnd_pcm_pause_restart_fail(vss, false, epoch);
> +		} else {
> +			scoped_guard(spinlock_irqsave, &vss->lock) {
> +				if (vss->resetting || vss->reset_epoch !=3D epoch)
> +					return -ECANCELED;
> +				vss->stopped =3D false;
> +				vss->xfer_xrun =3D false;
> +			}
> +		}
> +	}
> +
> +	return rc;
> +}

[Severity: Medium]
In virtsnd_pcm_prepare_locked(), if virtsnd_pcm_dev_prepare() fails when
pause_restart is false, doesn't clearing vss->xfer_xrun and resetting
vss->pcm_indirect and the capture counters before sending
VIRTIO_SND_R_PCM_PREPARE leave the driver out of sync with ALSA's runtime
state?

When userspace invokes SNDRV_PCM_IOCTL_PREPARE on a capture substream in
SNDRV_PCM_STATE_XRUN or SNDRV_PCM_STATE_DRAINING, snd_pcm_do_prepare() calls
virtsnd_pcm_prepare_locked(). Before virtsnd_pcm_dev_prepare() is called,
this block clears vss->xfer_xrun =3D false (when !pause_restart), calls
virtsnd_pcm_msg_reset(vss), and zeroes vss->pcm_indirect.

If virtsnd_pcm_dev_prepare() then returns an error, snd_pcm_do_prepare()
aborts before snd_pcm_do_reset() and snd_pcm_post_prepare(), leaving
runtime->state and runtime->control->appl_ptr unchanged. Because only the
pause_restart branch restores vss->xfer_xrun =3D true and vss->stopped =3D =
true
on failure:

- If the stream was in SNDRV_PCM_STATE_XRUN, the latched vss->xfer_xrun sta=
te
  is lost even though prepare failed.
- If the stream was in SNDRV_PCM_STATE_DRAINING, runtime->state remains
  SNDRV_PCM_STATE_DRAINING with runtime->control->appl_ptr at its pre-prepa=
re
  value while vss->pcm_indirect is zeroed and vss->prepared, vss->stopped,
  and vss->xfer_xrun are all false; a subsequent read or
  SNDRV_PCM_IOCTL_SYNC_PTR in SNDRV_PCM_STATE_DRAINING bypasses the
  !vss->prepared and vss->stopped checks in virtsnd_pcm_cp_ack_locked() and
  subtracts appl_ptr from a zeroed vss->pcm_indirect.sw_ready.

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
> +		if (vss->capture_staging) {
> +			rc =3D vss->runtime_active ? virtsnd_pcm_capture_send(vss) : -EBADFD;
> +		} else if (!vss->capture_rx_seeded) {
> +			rc =3D virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
> +			if (!rc)
> +				vss->capture_rx_seeded =3D true;
> +		}
> +	}
>  	if (!rc) {
> -		guard(spinlock_irqsave)(&vss->lock);
> -		vss->release_required =3D true;
> +		if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +		    !vss->capture_staging) {
> +			size_t period =3D snd_pcm_lib_period_bytes(vss->substream);
> +
> +			/* A synthetic resume notification is not a new period IRQ. */
> +			vss->capture_notified_periods =3D period ?
> +				div64_ul(vss->capture_copied_total, period) : 0;
> +		}
> +		vss->xfer_enabled =3D true;
>  	}
>  	return rc;
>  }

[Severity: Medium]
Does overwriting vss->capture_notified_periods in virtsnd_pcm_start_queue()
drop period notifications for RX periods that completed while
vss->xfer_enabled was false?

During SNDRV_PCM_TRIGGER_PAUSE_PUSH, virtsnd_pcm_trigger() clears
vss->xfer_enabled =3D false before calling virtsnd_pcm_stop_device(). If on=
e or
more RX periods complete in virtsnd_pcm_msg_complete() while
vss->xfer_enabled is false (either before STOP takes effect or when STOP is
rejected by the device), vss->capture_copied_total advances across a period
boundary without scheduling vss->elapsed_period.

When virtsnd_pcm_start_queue() subsequently runs on rejected PAUSE_PUSH
recovery or on SNDRV_PCM_TRIGGER_PAUSE_RELEASE, it overwrites
vss->capture_notified_periods with div64_ul(vss->capture_copied_total,
period) before virtsnd_pcm_period_elapsed() executes. When
virtsnd_pcm_period_elapsed() then runs:

sound/virtio/virtio_pcm.c:virtsnd_pcm_period_elapsed() {
	...
	partial =3D vss->xfer_xrun ||
		period_floor <=3D vss->capture_notified_periods;
	if (!partial)
		vss->capture_notified_periods =3D period_floor;
}

period_floor <=3D vss->capture_notified_periods is forced to true (partial =
=3D
true), so it calls snd_pcm_progress_under_stream_lock() instead of
snd_pcm_period_elapsed_under_stream_lock(), losing the period notification,
runtime->hw_ptr_interrupt update, and PCM timer tick for the completed
periods.

> @@ -377,72 +1099,226 @@ static int virtsnd_pcm_prepare(struct snd_pcm_sub=
stream *substream)

[ ... ]

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
>  		}
> +		return rc;

[Severity: Medium]
If virtsnd_pcm_stop_device() fails during SNDRV_PCM_TRIGGER_STOP on a captu=
re
stream, should vss->xfer_xrun also be latched here?

When userspace invokes SNDRV_PCM_IOCTL_DRAIN on a running capture stream wi=
th
unread frames, snd_pcm_do_drain_init() calls snd_pcm_do_stop(substream,
SNDRV_PCM_STATE_DRAINING), which ignores the return value of
substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP) and sets
runtime->state to SNDRV_PCM_STATE_DRAINING.

When virtsnd_pcm_stop_device() fails, vss->device_running remains true.
Unlike virtsnd_pcm_pause_restart_stop(), which calls
virtsnd_pcm_pause_restart_failed() to set vss->xfer_xrun =3D true, normal-m=
ode
virtsnd_pcm_trigger() only handles rc !=3D 0 for SNDRV_PCM_TRIGGER_PAUSE_PU=
SH
and leaves vss->xfer_xrun false. Because both virtsnd_pcm_capture_staged_ac=
k()
and virtsnd_pcm_cp_ack_locked() allow ACK in SNDRV_PCM_STATE_DRAINING when
vss->stopped is true unless vss->xfer_xrun is set, draining capture reads a=
nd
ACKs can proceed while the device is still running and DMA-writing into the
capture buffer.

[ ... ]

> @@ -606,17 +1560,134 @@ static int virtsnd_pcm_pb_ack(struct snd_pcm_subs=
tream *substream)
>  	return 0;
>  }
> =20
> -static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
> +/* The PCM lock is held; exclude every member's buffer reconfiguration. =
*/
> +static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	int rc;
> +
> +	if (!mutex_trylock(&runtime->buffer_mutex))
> +		return -EBADFD;
> +	rc =3D virtsnd_pcm_pb_ack_locked(substream);
> +	mutex_unlock(&runtime->buffer_mutex);
> +	return rc;
> +}

[Severity: High]
Can failing mutex_trylock(&runtime->buffer_mutex) in virtsnd_pcm_pb_ack() a=
nd
virtsnd_pcm_cp_ack() corrupt vss->pcm_indirect when another thread transien=
tly
holds runtime->buffer_mutex on a running stream?

In sound/core/pcm_native.c, snd_pcm_hw_refine_with_lock(),
snd_pcm_hw_params(), snd_pcm_hw_free(), and snd_pcm_action_nonatomic()
acquire runtime->buffer_mutex via snd_pcm_buffer_access_lock() (or
mutex_lock_nested() on linked group members in snd_pcm_action_group()) befo=
re
acquiring the PCM stream lock to check whether runtime->state is
SNDRV_PCM_STATE_RUNNING. Meanwhile, virtsnd_pcm_period_elapsed(),
snd_pcm_status64(), and snd_pcm_sync_ptr() hold the PCM stream lock without
incrementing runtime->buffer_accessing.

If virtsnd_pcm_period_elapsed() or snd_pcm_status64() runs while another
thread holds runtime->buffer_mutex waiting for the PCM stream lock,
virtsnd_pcm_pb_pointer() or virtsnd_pcm_cp_pointer() calls
snd_pcm_indirect_playback_pointer() or snd_pcm_indirect_capture_pointer(),
which first mutates vss->pcm_indirect in place (updating hw_io, hw_ready, a=
nd
sw_io) and then invokes substream->ops->ack(substream).

When mutex_trylock(&runtime->buffer_mutex) fails and returns -EBADFD,
snd_pcm_indirect_playback_pointer() and snd_pcm_indirect_capture_pointer()
ignore the error (only checking err =3D=3D -EPIPE), leaving vss->pcm_indire=
ct
half-updated without running snd_pcm_indirect_playback_transfer() or
snd_pcm_indirect_capture_transfer(). Concurrent SNDRV_PCM_IOCTL_SYNC_PTR
calls without HWSYNC will also fail with -EBADFD whenever another thread is
in the middle of an ioctl that locks buffer_mutex before checking stream
state.

> +
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
> +
> +		if (!vss->runtime_active || !runtime || !runtime->control ||
> +		    !runtime->dma_area || vss->suspended)
> +			return -EBADFD;
> +		if (!vss->prepared && runtime->state !=3D SNDRV_PCM_STATE_DRAINING &&
> +		    !(runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED &&
> +		      virtsnd_pcm_pause_restart_enabled(vss) &&
> +		      vss->pause_restart_state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEAS=
ED))
> +			return -EBADFD;
> +		if (vss->xfer_xrun)
> +			return -EPIPE;

[Severity: Medium]
Should virtsnd_pcm_capture_staged_ack() also check vss->stopped (or verify
that runtime->state permits acknowledgments), similar to
virtsnd_pcm_cp_ack_locked()?

When ALSA transitions a running staged capture substream to
SNDRV_PCM_STATE_XRUN without the virtio driver setting vss->xfer_xrun (for
example, when snd_pcm_update_state() detects avail >=3D runtime->stop_thres=
hold,
or when userspace issues SNDRV_PCM_IOCTL_XRUN via snd_pcm_xrun()),
__snd_pcm_xrun() calls snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN), which
invokes virtsnd_pcm_trigger(substream, SNDRV_PCM_TRIGGER_STOP) without
calling snd_pcm_sync_stop(). That sets vss->stopped =3D true and
vss->xfer_enabled =3D false while leaving vss->prepared =3D true and
vss->xfer_xrun =3D false. Similarly, if SNDRV_PCM_IOCTL_DROP is called whil=
e in
SNDRV_PCM_STATE_PREPARED, snd_pcm_do_stop() transitions runtime->state to
SNDRV_PCM_STATE_SETUP without setting stop_operating, leaving vss->prepared=
 =3D
true.

If userspace then invokes SNDRV_PCM_IOCTL_SYNC_PTR without
SNDRV_PCM_SYNC_PTR_HWSYNC or SNDRV_PCM_SYNC_PTR_APPL, snd_pcm_sync_ptr()
calls pcm_lib_apply_appl_ptr() -> virtsnd_pcm_cp_ack() ->
virtsnd_pcm_capture_staged_ack(). Because virtsnd_pcm_capture_staged_ack()
does not check (vss->stopped && runtime->state !=3D SNDRV_PCM_STATE_DRAININ=
G),
it accepts the ACK and advances vss->capture_acked_total, vss->capture_read=
y,
and vss->pcm_indirect.appl_ptr while the stream is stopped in
SNDRV_PCM_STATE_XRUN or SNDRV_PCM_STATE_SETUP.

[ ... ]

> @@ -641,6 +1712,50 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_substr=
eam *substream)
>  	return 0;
>  }
> =20
> +/*
> + * Linked prepare locks each member's buffer_mutex, while buffer_accessi=
ng is
> + * negative only on its initiating member. ACK must exclude every prepar=
e.
> + * The PCM lock is already held, so a failed trylock must return immedia=
tely.
> + */
> +static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	int rc;
> +
> +	if (!mutex_trylock(&runtime->buffer_mutex))
> +		return -EBADFD;
> +	rc =3D virtsnd_pcm_cp_ack_locked(substream);
> +	mutex_unlock(&runtime->buffer_mutex);
> +	return rc;
> +}

[Severity: High]
Won't mutex_trylock(&runtime->buffer_mutex) in virtsnd_pcm_pb_ack() and
virtsnd_pcm_cp_ack() always fail during SNDRV_PCM_IOCTL_RESET on a running
stream?

When userspace invokes SNDRV_PCM_IOCTL_RESET, snd_pcm_reset() calls
snd_pcm_action_nonatomic(&snd_pcm_action_reset, substream,
ACTION_ARG_IGNORE), which acquires substream->runtime->buffer_mutex via
snd_pcm_buffer_access_lock() (and locks runtime->buffer_mutex on all linked
group members in snd_pcm_action_group()).

While holding runtime->buffer_mutex on the same thread, snd_pcm_do_reset()
calls snd_pcm_lib_ioctl_reset() (or snd_pcm_lib_reset()). When the stream is
running, snd_pcm_lib_ioctl_reset() acquires the PCM stream lock and calls
snd_pcm_update_hw_ptr(substream) -> substream->ops->pointer(substream).

For playback (virtsnd_pcm_pb_pointer()) and ordinary capture
(virtsnd_pcm_cp_pointer()), snd_pcm_indirect_playback_pointer() and
snd_pcm_indirect_capture_pointer() first mutate vss->pcm_indirect in place
(updating hw_io, hw_ready, and sw_io) and then invoke
substream->ops->ack(substream). Because the calling thread already holds
runtime->buffer_mutex, mutex_trylock(&runtime->buffer_mutex) in
virtsnd_pcm_pb_ack() and virtsnd_pcm_cp_ack() is guaranteed to fail and
return -EBADFD.

snd_pcm_indirect_playback_pointer() and snd_pcm_indirect_capture_pointer()
ignore -EBADFD (only checking err =3D=3D -EPIPE) and skip
snd_pcm_indirect_playback_transfer() / snd_pcm_indirect_capture_transfer()
after vss->pcm_indirect has already been modified. Immediately afterwards,
snd_pcm_post_reset() sets runtime->control->appl_ptr =3D
runtime->status->hw_ptr without updating vss->pcm_indirect.appl_ptr, causing
the next playback ACK or period completion to compute a negative diff =3D
runtime->control->appl_ptr - rec->appl_ptr and abort the stream with -EPIPE.

Later commits in this series ("ALSA: pcm: add an optional reset operation
under the stream lock", "ALSA: virtio: synchronize staged capture accounting
during RESET", and "ALSA: virtio: rebase ordinary capture accounting on
RESET") add .reset callbacks for capture streams, but playback streams in
virtsnd_pcm_ops[0] still have no .reset callback or bypass in
virtsnd_pcm_pb_ack(), leaving SNDRV_PCM_IOCTL_RESET broken on running
playback streams.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031020855.2402=
-1-mynameisjune111@gmail.com?part=3D9
