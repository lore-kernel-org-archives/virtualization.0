Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342128;
	b=xoUazMSFJozizk2F56dCdJId37kBADD01sVMYvSZXkWgssOK4AAopWNWM1IY1vXZz8Q7
	 EQPNPFIjKr7ZZA1SppjpWQy2TlwLj/xKQl3TchuwRZ56HX5qQ0NeenQa6CNktYaO93HyM
	 NRGraQ5TLC61i2RU1iih6LMXPsAe4dVCnIheqPf98AfazqVAaIqLDSQxiXzx1ymnMFt3N
	 RJs8IsRJ5hxSYc1MuzhJNDmHXfzsu/IzJpR3C8rlvxcm99OpOQwTIUhZRNMvgo1Wq0ER6
	 aHwGM9BUQpMn2TOra1pDrebr76HcqKLWUu+P70Wz8WRpM3yQuWy/lZOhAz7422ASFCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342128;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=55x1/LXOkLzgf1skZEHnRDR9Mf3QC8gLrscUdEUD5P0=;
	b=tL9ba7gxWhX2uyyoM7231+ifLVrh0GBKyCoQAy6SUTfU6e6sJ/VLBIj5nf/E0UerohQP
	 LdoZ1E/d8LHLDX8ffc7L64kmUTY/6qQotSRxYDe2cwz32iBMAkA6hOelkafF6KRIPrXpT
	 AzKGrEb4M4mAXN0RGkITI6Dtj7oJDqpggyzPKTxTwKxLraMvk/8aQxcUhZq78nDXD5vjl
	 z0INjxaO2cuHSsBvMnmx2s49aJVZa3PKD1lPbUOHM61UctGG49V0IL4jqnQz4/v5+YV/T
	 /31wwySWg2SUtXsuLi2LNYhfzoPb1iKndvZiAGgZiL+f/4KGEuj2AaA2+2GPwAMgM7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESEfCB+y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988B606A31C;
	Fri, 30 Oct 2026 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESEfCB+y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9921F000C1;
	Fri, 30 Oct 2026 06:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793342128;
	bh=55x1/LXOkLzgf1skZEHnRDR9Mf3QC8gLrscUdEUD5P0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ESEfCB+ybAQcn6N0No2x0Uc2xzwiH4qIXayVL0YGCjBDewjHElqrB6IvCjuW+GtRc
	 YvJGM047g9W9nqCnYHr+wkbLRzqBUJ08S0IHqE7Nz2ei6i42RWnwDObUWEIXjk6MAH
	 vRohqVG7YluYFX021hNKELAmegzQfBIk/VdDljlEd4Bs+GlBwRGFMuf1vpMcEMH2D1
	 YUNsq3UHTzp0ugXndYjenLL95ufGrwLmEUYLwzZOyQsT4lBYGyv7kIv0Mlp6GxZqtU
	 1r8oWbNB28GypAAsC62OnQBSKwHEmYblz+2qoM9AeQDy17qnRVlccwcr2PiCRb23bg
	 e4i94Ap9xKQXQ==
Message-ID: <sashiko-outbox-190603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 14/14] ALSA: virtio: rebase ordinary capture
 accounting on RESET
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030052629.27742-15-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
 <20261030052629.27742-15-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 06:35:27 +0000
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
- [High] ALSA: virtio: missing xfer_xrun checks in virtsnd_pcm_indirect_res=
et() and ACK
- [High] ALSA: virtio: RX msg->length corruption on PAUSE_RELEASE after pau=
sed RESET
- [Medium] ALSA: virtio: unlocked paused pointer update in virtsnd_pcm_indi=
rect_reset()
--

commit 1a67c9c10a3b46bd06be6cb2ef4d737b79406386
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: rebase ordinary capture accounting on RESET

This commit adds an indirect reset callback for ordinary capture streams so
that indirect accounting follows the common ALSA reset observation while
preserving fixed DMA ring offsets. It also suppresses nested ACK refills
during pointer observation and preserves latched capture XRUN errors across
late I/O completions.

Link: https://sashiko.dev/#/patchset/20261029085032.70689-1-mynameisjune111=
%40gmail.com?part=3D14

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 8060858d88203..4ab73c5e78f8e 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -1738,6 +1746,77 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_su=
bstream *substream)
>  	return virtsnd_pcm_sync_stop_locked(substream);
>  }
> =20
> +/*
> + * The PCM lock covers indirect accounting and core completion. Once lib=
_reset
> + * changes hw_ptr, complete the core rebase even if refilling fails. The=
 latched
> + * XRUN rejects subsequent pointer/ACK operations; the worker publishes =
XRUN to
> + * paused streams too. RESET success therefore does not imply stream rec=
overy.
> + */
> +static int virtsnd_pcm_indirect_reset(struct snd_pcm_substream *substrea=
m)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	struct virtsnd_pcm_transfer transfer =3D {};
> +	snd_pcm_uframes_t paused_ptr =3D 0;
> +	bool paused =3D runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED;
> +	unsigned int hw_ptr;
> +	int rc;
> +
> +	/* Only PCM-locked callbacks access this observation flag. */
> +	vss->indirect_reset_observing =3D true;
> +	if (paused) {
> +		scoped_guard(spinlock_irqsave, &vss->lock)
> +			hw_ptr =3D vss->hw_ptr;
> +		paused_ptr =3D snd_pcm_indirect_capture_pointer(substream,
> +						&vss->pcm_indirect, hw_ptr);
> +	}

[Severity: Medium]
When resetting a paused stream in virtsnd_pcm_indirect_reset(), vss->hw_ptr
is sampled under a temporary vss->lock guard and
snd_pcm_indirect_capture_pointer() mutates vss->pcm_indirect before
queue->lock and vss->lock are acquired below.

Because snd_pcm_running(substream) is false in SNDRV_PCM_STATE_PAUSED,
snd_pcm_lib_reset() does not inspect vss->pcm_indirect or call
substream->ops->pointer(), and simply zeros runtime->status->hw_ptr and
runtime->hw_ptr_wrap.

If a late RX completion interrupt arrives via
virtsnd_pcm_rx_notify_cb()->virtsnd_pcm_msg_complete() between releasing
vss->lock here and acquiring queue->lock and vss->lock below, vss->hw_ptr
advances and msg->length is cleared to 0 while vss->xfer_enabled is false.
Wouldn't virtsnd_pcm_indirect_reset() then rebase runtime->status->hw_ptr to
the stale paused_ptr and miss re-enqueueing the newly completed RX
descriptor?

In addition, since snd_pcm_indirect_capture_pointer() mutates
vss->pcm_indirect (hw_io, hw_ready, sw_io) before the locked checks for
vss->resetting, !vss->prepared, and vss->stopped, can those early returns
leave vss->pcm_indirect out of sync with runtime->status->hw_ptr?

> +	rc =3D snd_pcm_lib_reset(substream);
> +	vss->indirect_reset_observing =3D false;
> +	if (rc)
> +		return rc;
> +	if (!snd_pcm_running(substream) &&
> +	    runtime->state !=3D SNDRV_PCM_STATE_PAUSED)
> +		return 0;
> +
> +	guard(spinlock_irqsave)(&queue->lock);
> +	guard(spinlock)(&vss->lock);
> +	if (vss->resetting)
> +		return 0;
> +	if (!vss->prepared || vss->stopped ||
> +	    (paused && paused_ptr =3D=3D SNDRV_PCM_POS_XRUN)) {
> +		virtsnd_pcm_transfer_failed(vss);
> +		vss->xfer_xrun =3D true;
> +		virtsnd_pcm_schedule_period_elapsed(vss);
> +		return 0;
> +	}

[Severity: High]
As reported by Sashiko on v9 [1], what happens if vss->xfer_xrun is already
latched when virtsnd_pcm_indirect_reset() or virtsnd_pcm_cp_ack_locked()
runs?

In sound/virtio/virtio_pcm.c:virtsnd_pcm_event(), receiving
VIRTIO_SND_EVT_PCM_XRUN on an active ordinary capture stream sets
vss->xfer_xrun =3D true without setting vss->stopped =3D true:

sound/virtio/virtio_pcm.c:virtsnd_pcm_event() {
	case VIRTIO_SND_EVT_PCM_XRUN:
		scoped_guard(spinlock, &vss->lock) {
			if (vss->xfer_enabled) {
				vss->xfer_xrun =3D true;
				if (vss->capture_staging)
					virtsnd_pcm_schedule_period_elapsed(vss);
			}
		}
		break;
}

And with the change in virtsnd_pcm_msg_complete(), capture I/O completions =
no
longer clear vss->xfer_xrun. If the stream is paused via
SNDRV_PCM_TRIGGER_PAUSE_PUSH before a pointer query observes the XRUN (or if
VIRTIO_SND_EVT_PCM_XRUN arrives on a running stream just after
snd_pcm_lib_reset()), virtsnd_pcm_indirect_reset() calls
snd_pcm_indirect_capture_pointer() directly instead of
virtsnd_pcm_cp_pointer() and does not check vss->xfer_xrun in this condition
(unlike virtsnd_pcm_reset()). Won't it skip virtsnd_pcm_transfer_failed() a=
nd
virtsnd_pcm_schedule_period_elapsed(), overwrite runtime->status->hw_ptr wi=
th
paused_ptr, and re-enqueue RX descriptors onto the virtqueue despite the
latched XRUN?

Similarly, in sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_cp_ack_locked(), the
ordinary capture path checks vss->stopped but not vss->xfer_xrun:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_cp_ack_locked() {
		if (vss->stopped && runtime->state !=3D SNDRV_PCM_STATE_DRAINING) {
			rc =3D -EPIPE;
		} else {
			rc =3D snd_pcm_indirect_capture_transfer(substream,
							       &transfer.indirect,
							       virtsnd_pcm_trans_copy);
		}
}

If an ACK operation does not first pass through virtsnd_pcm_cp_pointer()
(such as reading buffered frames while paused or SNDRV_PCM_IOCTL_SYNC_PTR
without HWSYNC), won't virtsnd_pcm_cp_ack_locked() succeed and enqueue RX
buffers instead of rejecting the ACK with -EPIPE?

> +
> +	/* Discard completions observed through the paused device pointer too. =
*/
> +	if (runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED)
> +		runtime->status->hw_ptr =3D paused_ptr;
> +
> +	transfer.indirect =3D vss->pcm_indirect;
> +	transfer.indirect.sw_ready =3D 0;
> +	/* Consume no application delta while returning discarded RX space. */
> +	transfer.indirect.appl_ptr =3D runtime->control->appl_ptr;
> +	rc =3D snd_pcm_indirect_capture_transfer(substream, &transfer.indirect,
> +					       virtsnd_pcm_trans_copy);

[Severity: High]
When virtsnd_pcm_indirect_reset() runs while the stream is in
SNDRV_PCM_STATE_PAUSED, snd_pcm_indirect_capture_transfer() invokes
virtsnd_pcm_trans_copy()->virtsnd_pcm_msg_send() to re-enqueue completed RX
descriptors into the virtqueue, setting their msg->length to period_bytes
while vss->device_running is false (cleared during
SNDRV_PCM_TRIGGER_PAUSE_PUSH in virtsnd_pcm_stop_device()).

When the stream is subsequently resumed via SNDRV_PCM_TRIGGER_PAUSE_RELEASE,
virtsnd_pcm_trigger() calls virtsnd_pcm_start_queue(), which sees
!vss->device_running and calls virtsnd_pcm_msg_send(vss, 0,
vss->buffer_bytes) across the entire buffer:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_start_queue() {
		if (vss->capture_staging)
			rc =3D virtsnd_pcm_capture_send(vss);
		else if (!vss->device_running)
			rc =3D virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
}

In sound/virtio/virtio_pcm_msg.c:virtsnd_pcm_msg_send(), msg->length +=3D n=
 is
executed unconditionally before checking if msg->length =3D=3D period_bytes:

sound/virtio/virtio_pcm_msg.c:virtsnd_pcm_msg_send() {
		msg->length +=3D n;
		if (msg->length =3D=3D period_bytes) {
			...
		}
}

For every RX descriptor already queued in the virtqueue with
msg->length =3D=3D period_bytes, doesn't this increment msg->length to
2 * period_bytes on PAUSE_RELEASE (and similarly corrupt msg->length if
unread completed descriptors are re-submitted by virtsnd_pcm_start_queue()
and later ACKed by the application)?

[1] https://lore.kernel.org/r/20261029085032.70689-15-mynameisjune111@gmail=
.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030052629.2774=
2-1-mynameisjune111@gmail.com?part=3D14
