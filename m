Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266201;
	b=122SVSRYCaR87uDHSDnz6xu6snVr168KCRUMvu7ssg4rT/yVb+myy3+cc3CUsxuEjwxe
	 EAVzI8tDrd+I8JXfWB02xY+uF1VeZv9U/KNz4Eort+2TLb/XWzqFFC/Pnir1CnAPzLNck
	 S8jhpXdTFCCLFqyZe1pvpBJPiy+pXAMC/BSYrd7zME0qmltRAYZTOo4Ch/lr4XCAlc5kO
	 FsMqs25yVq9yEVIaIu8EkOYY2t7ilr3TL8UdnWyVOLhfhaehIHSmszrEu58GDo0COXZMC
	 JHzWfMSDvywfsTTZxilPcbiTpdMBjhE493H2+49QJeklUN7LcGKdkRCMUM5R4aVCRzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266201;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ukw7Si4gnhLNE5FAtsb1C1HEdv132jGO+wxFZaVUSoc=;
	b=wXhjYBXXKgPggwNW1P8TXxk8vD1rZwnEC0vWp4x21jlQOfzdqdw1/ytZjQvchR68juy1
	 datqNj1fN5pqhNjV7CyhqDR6oQWbT8GWBJt58iYR3cI9dQhDSKR8QJVdUvqCMr9w0Srt5
	 TQFguAWM8gfXDMg/l7RpmD14nVyAf0bB0ZVLSWXQtx/RihY08Hb1rr8SftaDIAC+rOWRG
	 e5amUKOqvsL1HElCUfOq2sFXZ6LKnNDGBDqCnQo41aDOehiabsDq/a/rX9jrR1UQd2QpW
	 tbzWSHtAooX3lqQr7yp/SHMwPj+7xsEeA3+SK5U10nFcf7N0JtV9M2w5/ZwLyN+/BAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lnEV7GqG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421BA606A31C;
	Thu, 29 Oct 2026 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lnEV7GqG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3411F01825;
	Thu, 29 Oct 2026 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793266200;
	bh=ukw7Si4gnhLNE5FAtsb1C1HEdv132jGO+wxFZaVUSoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lnEV7GqGhjssi4VBikfxFVysRWogAKXLp94wpIXQsFhdNB1/d/ruCkOuTxWrHzz+x
	 Il81ryQXpOkaZuhX/5kWoDjyt+AlQY7LhQtWjKQ2R9LFGObhTcvBsks5FCa41KpDRw
	 KltsvFYcvt81k9+D4GJQE0O8S1jxCy6nf40jG2y+n1RidHv1tUunwBS7U7f3zwdV0m
	 nxNPFTiM7wL3Ha87elFkAP99+FgTPZ9OjSTB4E4MEXwcYccZLMg2uNArhfLH6Gd2uq
	 8QEy30U+D4Jv91hMdoypWzmgF2SvM2xIn3/LAMif31xv82gqgtkuDfq9HDGNMi4IDs
	 dOBXff4JeI5EQ==
Message-ID: <sashiko-outbox-189039@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/14] ALSA: virtio: add staged capture accounting
 and lifecycle recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029085032.70689-10-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
 <20261029085032.70689-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:29:59 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] ALSA: virtio: race clearing vqueue in virtsnd_reset_vqs() before d=
el_vqs()
- [High] ALSA: virtio: uncanceled elapsed_period work on sync_stop and clos=
e paths
- [Medium] ALSA: virtio: incomplete pause failure recovery in virtsnd_pcm_t=
rigger()
- [Medium] ALSA: virtio: race in virtsnd_pcm_sync_stop() across prepare gen=
erations
- [Medium] ALSA: virtio: race between virtsnd_pcm_prepare_locked() and stag=
ed ack()
--

commit a385aa4275f0e96bd41c0f455c953ca4c07a25b9
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: add staged capture accounting and lifecycle recovery

This commit introduces staged capture with request-owned DMA buffers and
separate produced, observed, and consumed accounting positions for virtio-s=
nd.
It also adds lifecycle serialization and state tracking for control request=
s,
pause-restart recovery, and virtqueue resets.

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
> +	vdev->config->del_vqs(vdev);

[Severity: High]
Could clearing snd->queues[i].vqueue before calling vdev->config->del_vqs(v=
dev)
cause a NULL pointer dereference in virtsnd_pcm_notify_cb()?

On transports whose reset callback does not call synchronize_irq() (such as
virtio_mmio's vm_reset() or virtio_vdpa's virtio_vdpa_reset()), virtqueue I=
RQ
handlers are not synchronized or freed until vdev->config->del_vqs(vdev) ru=
ns.

Unlike virtsnd_ctl_notify_cb() and virtsnd_event_notify_cb(), which use the=
ir
vqueue parameter directly, virtsnd_pcm_notify_cb() in
sound/virtio/virtio_pcm_msg.c dereferences queue->vqueue after acquiring
queue->lock:

	guard(spinlock_irqsave)(&queue->lock);
	do {
		virtqueue_disable_cb(queue->vqueue);
		while ((msg =3D virtqueue_get_buf(queue->vqueue, &written_bytes)))
			virtsnd_pcm_msg_complete(msg, written_bytes);
	} while (!virtqueue_enable_cb(queue->vqueue));

If an in-flight TX or RX interrupt on another CPU has entered
virtsnd_pcm_tx_notify_cb() or virtsnd_pcm_rx_notify_cb() and is spinning on
queue->lock while virtsnd_reset_vqs() sets snd->queues[i].vqueue =3D NULL, =
won't
virtsnd_pcm_notify_cb() dereference a NULL queue->vqueue as soon as
queue->lock is released?

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index de11bf162006e..ee07e5bb3c62f 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -320,48 +706,372 @@ static int virtsnd_pcm_prepare(struct snd_pcm_subs=
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
> =20
> -	memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
> -	vss->pcm_indirect.sw_buffer_size =3D
> -		vss->pcm_indirect.hw_buffer_size =3D
> -		snd_pcm_lib_buffer_bytes(substream);
> +	rc =3D virtsnd_pcm_dev_prepare(vss, epoch);
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (epoch !=3D vss->reset_epoch || vss->resetting)
> +			return -ECANCELED;
> +		vss->prepared =3D !rc;
> +		if (!rc)
> +			vss->release_required =3D true;
> +	}

[Severity: Medium]
Can virtsnd_pcm_prepare_locked() race with a concurrent
virtsnd_pcm_capture_staged_ack() call and latch a false xrun on the newly
prepared substream?

In the ALSA PCM core, snd_pcm_do_prepare() calls substream->ops->prepare()
under runtime->buffer_mutex without holding pcm_stream_lock, and only resets
runtime->control->appl_ptr to 0 afterward in snd_pcm_do_reset().

Here in virtsnd_pcm_prepare_locked(), virtsnd_pcm_msg_reset(vss) zeroes
capture_copied_total, capture_acked_total, capture_pointer_seen_total, and
capture_ready, and memset() zeroes vss->pcm_indirect.appl_ptr while
vss->runtime_active remains true. It then sleeps in virtsnd_pcm_dev_prepare=
()
and sets vss->prepared =3D true before returning to snd_pcm_do_prepare().

Meanwhile, a concurrent snd_pcm_sync_ptr() ioctl (without
SNDRV_PCM_SYNC_PTR_HWSYNC or SNDRV_PCM_SYNC_PTR_APPL) only acquires
pcm_stream_lock and invokes:

  pcm_lib_apply_appl_ptr()
    -> virtsnd_pcm_cp_ack()
      -> virtsnd_pcm_capture_staged_ack()

In virtsnd_pcm_capture_staged_ack():

		if (!vss->prepared && runtime->state !=3D SNDRV_PCM_STATE_DRAINING &&
		    !(runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED &&
		      virtsnd_pcm_pause_restart_enabled(vss) &&
		      vss->pause_restart_state =3D=3D VIRTSND_PCM_PAUSE_RESTART_RELEASED))
			return -EBADFD;

Once vss->prepared is set to true (or while virtsnd_pcm_dev_prepare() is
sleeping if runtime->state is SNDRV_PCM_STATE_DRAINING or PAUSED),
virtsnd_pcm_capture_staged_ack() can compare the unreset pre-prepare
runtime->control->appl_ptr against the zeroed vss->pcm_indirect.appl_ptr and
vss->capture_copied_total, setting vss->xfer_xrun =3D true. Even with the
follow-up commit "ALSA: virtio: synchronize staged capture accounting during
RESET", virtsnd_pcm_reset() returns early when vss->xfer_xrun is true, so
wouldn't the next start fail with -EPIPE?

[ ... ]

> @@ -377,68 +1087,218 @@ static int virtsnd_pcm_prepare(struct snd_pcm_sub=
stream *substream)

[ ... ]

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
> +		scoped_guard(spinlock_irqsave, &vss->lock) {
> +			if (vss->device_running && !vss->control_uncertain &&
> +			    !vss->resetting && !vss->stopped) {
> +				vss->xfer_enabled =3D true;
> +				return 0;
>  			}
> -			vss->xfer_enabled =3D true;
> +		}
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
>  		}
> =20
> +		rc =3D virtsnd_pcm_stop_device(vss, epoch);
> +		if (rc && command =3D=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH) {
> +			guard(spinlock_irqsave)(&vss->lock);
> +			if (vss->reset_epoch =3D=3D epoch && !vss->resetting &&
> +			    !vss->control_uncertain && vss->device_running &&
> +			    !vss->xfer_xrun)
> +				vss->xfer_enabled =3D true;
> +		}
> +		return rc;

[Severity: Medium]
What happens to staged capture RX descriptors if virtsnd_pcm_stop_device()
fails during SNDRV_PCM_TRIGGER_PAUSE_PUSH when pause-restart mode is disabl=
ed?

Before calling virtsnd_pcm_stop_device(), SNDRV_PCM_TRIGGER_PAUSE_PUSH clea=
rs
vss->xfer_enabled =3D false and drops vss->lock while the device is still
running. Any staged capture RX buffers that complete during this window see
vss->xfer_enabled =3D=3D false in virtsnd_pcm_capture_complete(), so their =
audio
is discarded, msg->length is cleared to 0, vss->msg_count is decremented, a=
nd
virtsnd_pcm_capture_enqueue() is skipped.

If virtsnd_pcm_stop_device() fails with a definite error (so
vss->control_uncertain is false and vss->device_running remains true), both
the recovery path above and the SNDRV_PCM_TRIGGER_PAUSE_RELEASE fast path
invoked by snd_pcm_undo_pause() set vss->xfer_enabled =3D true without call=
ing
virtsnd_pcm_capture_send() to refill the drained RX buffers. If all queued =
RX
descriptors completed while vss->xfer_enabled was false, won't vss->msg_cou=
nt
remain 0 and stall capture indefinitely?

Also, the SNDRV_PCM_TRIGGER_PAUSE_RELEASE fast path when vss->device_running
is true does not check !vss->xfer_xrun before setting vss->xfer_enabled =3D=
 true,
and if virtsnd_pcm_stop_device() fails with vss->control_uncertain =3D=3D t=
rue on
a linked substream where snd_pcm_action_group() does not call
snd_pcm_undo_pause() on the failing stream, the substream is left in
SNDRV_PCM_STATE_RUNNING with vss->xfer_enabled =3D=3D false, vss->stopped =
=3D=3D false,
and runtime->stop_operating =3D=3D false.

[ ... ]

> @@ -455,31 +1315,49 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_su=
bstream *substream)
>  	unsigned int js =3D msecs_to_jiffies(virtsnd_msg_timeout_ms);
>  	bool need_release;
>  	int rc;
> +	u64 epoch;
> +
> +	if (virtsnd_pcm_pause_restart_enabled(vss))
> +		return virtsnd_pcm_pause_restart_sync_stop(substream);
> =20
>  	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (vss->resetting)
> +			return -ECANCELED;
> +		epoch =3D vss->reset_epoch;
>  		vss->xfer_enabled =3D false;
>  		need_release =3D vss->release_required;
>  		if (need_release)
>  			vss->stopped =3D true;
>  	}
>  	cancel_work_sync(&vss->elapsed_period);

[Severity: High]
Can vss->elapsed_period remain pending across sync_stop, hw_free, and close,
racing with snd_pcm_detach_substream() freeing substream->runtime?

There appear to be two ways vss->elapsed_period is left uncanceled when a
substream is closed:

1. In virtsnd_reset_vqs(), vss->resetting =3D true is set in the first loop
before virtio_reset_device() and vdev->config->del_vqs() run, while
cancel_work_sync(&vss->elapsed_period) only runs in the final loop (and if
virtsnd_restore() fails in virtsnd_find_vqs(), vss->resetting stays true).
When vss->resetting is true, virtsnd_pcm_sync_stop_locked() and
virtsnd_pcm_pause_restart_sync_stop() return -ECANCELED before reaching
cancel_work_sync(&vss->elapsed_period) (and virtsnd_pcm_sync_stop() also
returns 0 early when !vss->stopped without canceling work). For non-staged
substreams (!vss->capture_staging), neither virtsnd_pcm_hw_free() nor
virtsnd_pcm_close() calls cancel_work_sync(&vss->elapsed_period):

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_close() {
	if (vss->capture_staging) {
		scoped_guard(spinlock_irqsave, &vss->lock) {
			vss->runtime_active =3D false;
			vss->xfer_enabled =3D false;
		}
		cancel_work_sync(&vss->elapsed_period);
	}
}

2. In virtsnd_pcm_pause_restart_sync_stop(), cancel_work_sync() runs near t=
he
beginning of the function, but the subsequent error paths call
virtsnd_pcm_pause_restart_fail(), which re-schedules vss->elapsed_period wh=
en
vss->runtime_active is true.

When snd_pcm_release_substream() then calls snd_pcm_detach_substream(), whi=
ch
clears substream->runtime =3D NULL and calls kfree(runtime) without holding
pcm_stream_lock, can virtsnd_pcm_period_elapsed() concurrently access the
freed runtime?

[ ... ]

> @@ -637,6 +1675,19 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_substr=
eam *substream)
>  	return 0;
>  }
> =20
> +static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +
> +	guard(mutex)(&vss->lifecycle_lock);
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		/* A newer prepare may have consumed this stop generation. */
> +		if (!vss->stopped)
> +			return 0;
> +	}
> +	return virtsnd_pcm_sync_stop_locked(substream);
> +}

[Severity: Medium]
Is checking !vss->stopped under vss->lifecycle_lock sufficient to detect th=
at
a newer prepare already consumed an earlier stop generation?

In sound/core/pcm_native.c, snd_pcm_drop() drops pcm_stream_lock before
calling snd_pcm_sync_stop() without holding runtime->buffer_mutex. If threa=
d A
in snd_pcm_sync_stop() clears runtime->stop_operating =3D false and is pree=
mpted
before acquiring vss->lifecycle_lock in virtsnd_pcm_sync_stop(), thread B c=
an:

1. Call snd_pcm_prepare(), which acquires vss->lifecycle_lock, consumes thr=
ead
   A's stop via virtsnd_pcm_sync_stop_locked(), and prepares a new stream
   generation.
2. Start the stream via virtsnd_pcm_trigger(SNDRV_PCM_TRIGGER_START).
3. Issue SNDRV_PCM_TRIGGER_PAUSE_PUSH or SNDRV_PCM_TRIGGER_STOP, which run
   under pcm_stream_lock without vss->lifecycle_lock and set
   vss->stopped =3D true.

When thread A then acquires vss->lifecycle_lock, vss->stopped is true again,
so thread A proceeds into virtsnd_pcm_sync_stop_locked() against the new
generation.

In pause-restart mode, if thread B is mid-transition inside
virtsnd_pcm_pause_restart_pause() or virtsnd_pcm_pause_restart_stop(), thre=
ad
A will see virtsnd_pcm_pause_restart_transitioning(state) and force
VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED; or if thread B has completed
PAUSE_PUSH (reaching VIRTSND_PCM_PAUSE_RESTART_RELEASED with
vss->stopped =3D=3D true), thread A will clear vss->stopped =3D false in
virtsnd_pcm_pause_restart_sync_stop(), causing a subsequent PAUSE_RELEASE in
virtsnd_pcm_pause_restart_start() to fail with -EBADFD. In normal mode, if
thread B is inside virtsnd_pcm_trigger(SNDRV_PCM_TRIGGER_STOP), thread A can
issue overlapping STOP and RELEASE control requests concurrently.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085032.7068=
9-1-mynameisjune111@gmail.com?part=3D9
