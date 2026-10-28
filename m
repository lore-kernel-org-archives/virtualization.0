Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146505;
	b=M6178UUff5uvBT2Lbmi85ao2ciIfPiwzUFbdpHcM3F0PnHRAS9s+j/lYO2s0t34Gv1ys
	 tMk+8+LUP84oE8cFTIZkGDn9B/pMS7ZGQ5mCHUINo+xGiKPQI99r/RYUz2ea/MIja86wF
	 G4YdvY16BdwmzLwlJtEnhZpEkKymy4eZ0lSm4FptN/7QZ4AzmdYpkLEORgqnlTGy1Yrbi
	 t4pCeRNZm3lsx01DSrPXw3yx2ph1X7fhtLg/WViXhT83x53x98+Lsx5WwQKRLI744xyPg
	 PHYEY7DsN6qScUwcTJqtjkn9OA7uSU1AiZKqlDjnAw2ZoubjsfPZFWFyw7bSry+ICnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146505;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SbGOypr2s5oy8xsCB+we0s3wDQQz9vgKw44H4ZQ5h6w=;
	b=zcNcufQ+OfG0EnhYoQPUOiXl/7IbhmCmoRDXbNK2rGyhOguHhH5X47I46/3tF0fSzidp
	 oj4I0Cb7vkw5X08h3o+ZCSg6kEiQjg9BFQoeklxQK3BLPAyaERSoIIGQHlZtbUSJa6mAv
	 sUElvCGuejXsOPP/lB2EuW1cGn1tGM5dW5wS+45PcHawVqbPZR5UzFJqjwWn6Z34vBSJS
	 +/LFw++gyppIBB+fkINUGxv88VyWORbOU+uMJyw+IMf9jinsTP6aL2r9AumYlw/J0zwKK
	 a7Qa00xArLxSHKp7sz60OFkHM7DS8nqkkcp+YorHvX1q9Wsr/mxzwnsnftPQbZjAAbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqEsu5jm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA31606A31A;
	Wed, 28 Oct 2026 00:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqEsu5jm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED851F01825;
	Wed, 28 Oct 2026 00:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146504;
	bh=SbGOypr2s5oy8xsCB+we0s3wDQQz9vgKw44H4ZQ5h6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OqEsu5jmqCcsvI/kv59HNkDYL5hdtWEigFNvXqU5HSEJmcZOuOgeR1dbS1sf+b9j1
	 HlFKs7uptRqJDQ1gkRqqGNnPcp22dFZYyLKu0Wsgbi3t4lz4Yo2TuBX25pjAFFsviW
	 wI7hSWRrQqbzGRZQIRxImGHyCVlxBzlF3KCk21qYxem7qYi0ab1leXoUfu9BuSnXv0
	 VOxHw0MwIhDuD0qyJBwpQrSLF9XM+kAQ0RIqz9UIzvnPEPIuGDadp5j19k9FrwFBOp
	 63Wz0Zf0A6z5kViUB1mj588uHPk6pUBF6ffejbDp8vFmC4nlM2mQjVDoYy1a+4jQD2
	 VrCjnoJIzYJqA==
Message-ID: <sashiko-outbox-187265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/11] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261027234334.32551-4-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
 <20261027234334.32551-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 00:15:04 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ALSA: virtio: NULL vqueue dereference in virtsnd_pcm_msg_send() af=
ter freeze
- [High] ALSA: virtio: virtsnd_reset_vqs() leaves stale substream state on =
reset
--

commit 00a0945381a2dc9d6b91d5ecac16bfd8128b97f3
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Retain queued messages through device reset

This patch retains the control virtqueue through snd_card_free() during
device removal, blocks new control messages and cancels pending ones across
device reset, and detaches unused virtqueue buffers in virtsnd_reset_vqs()
before deleting the virtqueues.

> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index 6f35276416fed..df7091b74a521 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c
> @@ -337,6 +337,38 @@ static int virtsnd_probe(struct virtio_device *vdev)
>  	return rc;
>  }
> =20
> +/**
> + * virtsnd_reset_vqs() - Stop device access and unmap outstanding buffer=
s.
> + * @snd: VirtIO sound device.
> + *
> + * Context: Any context that permits to sleep.
> + */
> +static void virtsnd_reset_vqs(struct virtio_snd *snd)
> +{
> +	struct virtio_device *vdev =3D snd->vdev;
> +	unsigned int i;
> +
> +	virtio_reset_device(vdev);
> +
> +	/* Deleting a virtqueue does not unmap its outstanding descriptors. */
> +	for (i =3D 0; i < VIRTIO_SND_VQ_MAX; ++i) {
> +		struct virtio_snd_queue *queue =3D &snd->queues[i];
> +		unsigned long flags;
> +		void *msg;
> +
> +		spin_lock_irqsave(&queue->lock, flags);
> +		if (queue->vqueue)
> +			while ((msg =3D virtqueue_detach_unused_buf(queue->vqueue)))
> +				if (i =3D=3D VIRTIO_SND_VQ_TX || i =3D=3D VIRTIO_SND_VQ_RX)
> +					virtsnd_pcm_msg_cancel(msg);
> +		spin_unlock_irqrestore(&queue->lock, flags);
> +	}
> +
> +	vdev->config->del_vqs(vdev);
> +	for (i =3D 0; i < VIRTIO_SND_VQ_MAX; ++i)
> +		snd->queues[i].vqueue =3D NULL;
> +}

[Severity: High]
Can this lead to a NULL pointer dereference in virtsnd_pcm_msg_send() after
virtsnd_freeze() clears snd->queues[i].vqueue?

During system sleep, do_pcm_suspend() -> snd_pcm_suspend_all() leaves
vss->stopped as false (either because the substream was not running, because
virtsnd_pcm_sync_stop() flushed the queue and cleared vss->stopped, or
because virtsnd_pcm_msg_cancel() only clears vss->xfer_enabled).
virtsnd_freeze() then calls virtsnd_reset_vqs(), which deletes the
virtqueues and sets snd->queues[i].vqueue =3D NULL, but unlike the control
queue, nothing blocks submissions to the TX/RX PCM queues.

If virtsnd_restore() fails (for example in virtsnd_find_vqs() or feature
negotiation), snd->queues[VIRTIO_SND_VQ_TX/RX].vqueue remains NULL. If
userspace then issues SNDRV_PCM_IOCTL_SYNC_PTR with an advanced appl_ptr,
snd_pcm_common_ioctl() only checks for SNDRV_PCM_STATE_DISCONNECTED (and
snd_power_wait() is a no-op since virtio-snd does not update
card->power_state), calling:

snd_pcm_sync_ptr()
  -> pcm_lib_apply_appl_ptr()
    -> virtsnd_pcm_pb_ack() / virtsnd_pcm_cp_ack()

In sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_pb_ack():
	scoped_guard(spinlock_irqsave, &queue->lock) {
		guard(spinlock)(&vss->lock);
		transfer.indirect =3D vss->pcm_indirect;
		if (vss->stopped) {
			rc =3D -EPIPE;
		} else {
			rc =3D snd_pcm_indirect_playback_transfer(substream,
								&transfer.indirect,
								virtsnd_pcm_trans_copy);
		}

Because vss->stopped is false, this calls virtsnd_pcm_trans_copy() ->
virtsnd_pcm_msg_send():

	struct virtqueue *vqueue =3D virtsnd_pcm_queue(vss)->vqueue;
	...
	rc =3D virtqueue_add_sgs(vqueue, psgs, 2, 1, msg, GFP_ATOMIC);

which passes a NULL vqueue to virtqueue_add_sgs() under the spinlocks. Even
when virtsnd_restore() succeeds, the same SNDRV_PCM_IOCTL_SYNC_PTR -> ack()
path can queue PCM buffers onto the newly recreated virtqueue while the
substream is still in SNDRV_PCM_STATE_SUSPENDED (or SNDRV_PCM_STATE_SETUP)
before VIRTIO_SND_R_PCM_SET_PARAMS and VIRTIO_SND_R_PCM_PREPARE have been
sent to the reset device.

[ ... ]

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index 5371f4985fd06..762480363b861 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
> @@ -307,6 +307,35 @@ unsigned int virtsnd_pcm_msg_pending_num(struct virt=
io_pcm_substream *vss)
>  	return vss->msg_count;
>  }
> =20
> +/**
> + * virtsnd_pcm_msg_cancel() - Cancel a message detached during device re=
set.
> + * @msg: Message returned by virtqueue_detach_unused_buf().
> + *
> + * Reset cancellation retires the queue token without treating it as a d=
evice
> + * completion. In particular, it does not advance the PCM hardware point=
er or
> + * schedule period work.
> + *
> + * Context: Process context with the PCM queue lock held.
> + */
> +void virtsnd_pcm_msg_cancel(struct virtio_pcm_msg *msg)
> +{
> +	struct virtio_pcm_substream *vss =3D msg->substream;
> +	bool wake;
> +
> +	{
> +		guard(spinlock)(&vss->lock);
> +		msg->length =3D 0;
> +		vss->xfer_enabled =3D false;
> +		if (WARN_ON_ONCE(!vss->msg_count))
> +			return;
> +		vss->msg_count--;
> +		wake =3D !vss->msg_count;
> +	}
> +
> +	if (wake)
> +		wake_up_all(&vss->msg_empty);
> +}

[Severity: High]
Should virtsnd_reset_vqs() / virtsnd_pcm_msg_cancel() also reconcile
vss->stopped and vss->suspended when resetting the device during
virtsnd_freeze()?

First, if virtsnd_pcm_sync_stop() fails or times out during
snd_pcm_suspend_all() before virtsnd_freeze() (or if a prior stop/start
failed before suspend), vss->stopped remains true while buffers remain
queued. virtsnd_freeze() -> virtsnd_reset_vqs() then resets the VirtIO
device and detaches all pending buffers via virtsnd_pcm_msg_cancel(),
decrementing vss->msg_count to 0, but leaves vss->stopped as true.

After virtsnd_restore(), vss->stopped blocks virtsnd_pcm_prepare() and
virtsnd_pcm_hw_params() with -EBADFD:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_prepare() {
	scoped_guard(spinlock_irqsave, &vss->lock)
		stopped =3D vss->stopped;
	if (stopped) {
		dev_err(&vdev->dev, "SID %u: stream release failed\n",
			vss->sid);
		substream->runtime->stop_operating =3D true;
		return -EBADFD;
	}

And if userspace tries to recover via snd_pcm_sync_stop() or by closing and
reopening the substream via virtsnd_pcm_open():

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_open() {
	...
	scoped_guard(spinlock_irqsave, &vss->lock)
		vss->stopped |=3D !!vss->msg_count;
	vss->suspended =3D false;

	return virtsnd_pcm_sync_stop(substream);
}

virtsnd_pcm_sync_stop() sees vss->stopped =3D=3D true and sends
VIRTIO_SND_R_PCM_RELEASE to the freshly reset device before
VIRTIO_SND_R_PCM_SET_PARAMS has been sent. If the device rejects RELEASE for
the unconfigured stream, virtsnd_pcm_sync_stop() fails and leaves
vss->stopped set, permanently wedging the substream.

Second, if a substream has queued buffers while in a state where
snd_pcm_running() is false at suspend time (such as SNDRV_PCM_STATE_PAUSED,
capture SNDRV_PCM_STATE_DRAINING, or playback SNDRV_PCM_STATE_PREPARED with
pre-queued buffers), snd_pcm_do_suspend() skips
virtsnd_pcm_trigger(SNDRV_PCM_TRIGGER_SUSPEND) while snd_pcm_post_suspend()
places the substream into SNDRV_PCM_STATE_SUSPENDED with vss->suspended =3D=
=3D
false. When virtsnd_pcm_msg_cancel() drains vss->msg_count to 0 without
setting vss->suspended =3D true, a subsequent virtsnd_pcm_prepare() after
virtsnd_restore() sees !vss->suspended and virtsnd_pcm_msg_pending_num(vss)
=3D=3D 0, skips virtsnd_pcm_dev_set_params(), and sends VIRTIO_SND_R_PCM_PR=
EPARE
to a reset device that has no stream parameters configured.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027234334.3255=
1-1-mynameisjune111@gmail.com?part=3D3
