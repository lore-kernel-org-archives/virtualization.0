Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145565;
	b=G/aZV4dFpuLAL5BBg2e/C7PPEwVGoh5VfnTwtHZYwuwmRT3IQdc72Teu4Sdl+4XBGu8n
	 CqFZ7yaTpHt9IlY3IDXvny/ir7CrA4kle4NZmtyOTMLJU2t8i4ezCXZr1uoUHSOXixKQH
	 kIb54Zo0KhAESBrRXgFnZrA2znoFDI6rUy1f9BrsJO0repyfYpFA2+J4ZbMHgnJFrvPXb
	 bdZO+Q3nib63C6xjWNtXjStasmAB4jHpF/rqy8fwcyIEbY6p9KJmmjDcuA/6+HeKnUqf+
	 OzS7FQf4YyL7nA5VPfYdFUhTtSBtR9zCI7SfMcIPEn2N62Elb3OE1nOnjTybJYf7C2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145565;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BwZysRG4GY8YFxAdX1yt6ByLFv86tbzZVVWemg/Zd9c=;
	b=RyeYI1kwTu51c3HmtUmhSGV8lRmitCLrrZlFvKQ/iA0zZ8nPtui3s+5MTcwu3mPnQqOy
	 57r3GPS/oHA+PWzjIsgd/icOsw5BE+DZC+f20e/k4jR+GPlHgsD4bw+v2eUdIQkUkRNA8
	 /0ZF0rLAGrP8lGebg1EXLyH7RKGlXlbY+3D+Cks7hktmuQmOQ5zCsNF8OVHGkxC1nOL5a
	 LHu5ftoayVqUu8E/aKWONzcxQ89ybKKic78rQUH9UAsr4zN6h7GPf2sXj0X+lb0L/x/SC
	 E9M50Sd9v1FtDhtiW0rZ07iclI/dHJsCoaSJRLGFCGa9J+sGkP5F0igkRdJNw0t8Xuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUF80tpf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C454606A31A;
	Tue, 27 Oct 2026 23:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUF80tpf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA4C1F01825;
	Tue, 27 Oct 2026 23:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793145565;
	bh=BwZysRG4GY8YFxAdX1yt6ByLFv86tbzZVVWemg/Zd9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VUF80tpfZP0AtHRrJDCbXm/GlPRS6PE0f+WBn85PUFSM3U3IEbW5yk6N05qQ5Mg9U
	 gW/m9TMuMCrbWriWtcseM+6oG8ejuVZCmnCePUVm4shUsDhaa27ruVtJAsW15nvc3f
	 ySfGBRp14jHf3s5pspMS/1Ppe4daS85rz3SRmMPYdbwkwWxy7Ol4xMB0tUZzisrYlx
	 TeUqAxTV8k8QO1bzEQz/0jK/SpeJk6V9wqdC3tdl68I5bEZn+GxAr+xq4Y15rxW3ac
	 5sNGXflluKNLAUtdJFX4TartACANEyabOTUpkZpoGuvK6fgtod6RA31w7SpBCMvsI1
	 ZBKir2UTtPX0Q==
Message-ID: <sashiko-outbox-187246@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/11] ALSA: virtio: Keep PCM DMA buffers alive
 through device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261027234334.32551-5-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
 <20261027234334.32551-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:59:24 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ALSA: virtio: virtsnd_pcm_msg_complete() drops NOMMU capture data =
on pause
--

commit a5392b9f568d1dcfcb1d686f254cd14115ceec53
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Keep PCM DMA buffers alive through device ownership

This commit retains references to the pages backing ALSA's vmalloc buffer
until its queued I/O messages are freed, uses a driver-owned bounce buffer =
on
NOMMU systems, and clamps device-reported capture lengths to the message
capacity.

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index 762480363b861..b7f2334bb221c 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
[ ... ]
> @@ -363,15 +539,48 @@ static void virtsnd_pcm_msg_complete(struct virtio_=
pcm_msg *msg,
>  	 * the hw_ptr value is unconditionally advanced.
>  	 */
>  	guard(spinlock)(&vss->lock);
> +#ifndef CONFIG_MMU
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +	    vss->xfer_enabled && written_bytes > sizeof(msg->status)) {
> +		struct snd_pcm_runtime *runtime =3D
> +			vss->substream ? vss->substream->runtime : NULL;
> +		size_t reported_bytes =3D written_bytes - sizeof(msg->status);
> +		size_t data_bytes =3D min_t(size_t, reported_bytes, msg->length);
> +
> +		if (!runtime || !runtime->dma_area || !vss->owned_dma_area ||
> +		    msg->data_offset > runtime->dma_bytes ||
> +		    data_bytes > runtime->dma_bytes - msg->data_offset ||
> +		    msg->data_offset > vss->owned_dma_bytes ||
> +		    data_bytes > vss->owned_dma_bytes - msg->data_offset)
> +			dev_err_ratelimited(&vss->snd->vdev->dev,
> +					    "SID %u: invalid capture buffer for I/O message\n",
> +				vss->sid);
> +		else
> +			memcpy(runtime->dma_area + msg->data_offset,
> +			       vss->owned_dma_area + msg->data_offset, data_bytes);
> +	}
> +#endif
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +	    written_bytes > sizeof(msg->status) &&
> +	    written_bytes - sizeof(msg->status) > msg->length)
> +		dev_err_ratelimited(&vss->snd->vdev->dev,
> +				    "SID %u: capture length exceeds I/O message capacity\n",
> +			vss->sid);
>  	/*
>  	 * If the capture substream returned an incorrect status, then just
> -	 * increase the hw_ptr by the message size.
> +	 * increase the hw_ptr by the message size. Clamp valid capture lengths=
 to
> +	 * the actual SG payload capacity before accounting them.
>  	 */
>  	if (vss->direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK ||
> -	    written_bytes <=3D sizeof(msg->status))
> +	    written_bytes <=3D sizeof(msg->status)) {
>  		vss->hw_ptr +=3D msg->length;
> -	else
> -		vss->hw_ptr +=3D written_bytes - sizeof(msg->status);
> +	} else {
> +		size_t data_bytes =3D min_t(size_t,
> +					  written_bytes - sizeof(msg->status),
> +					  msg->length);
> +
> +		vss->hw_ptr +=3D data_bytes;
> +	}

[Severity: High]
Can gating the NOMMU capture bounce copy on vss->xfer_enabled drop captured
audio data when a stream is paused?

In sound/virtio/virtio_pcm_ops.c, virtsnd_pcm_trigger() handles
SNDRV_PCM_TRIGGER_PAUSE_PUSH by clearing vss->xfer_enabled while leaving
vss->stopped false before synchronously sending VIRTIO_SND_R_PCM_STOP:

	case SNDRV_PCM_TRIGGER_STOP:
	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
		scoped_guard(spinlock_irqsave, &vss->lock) {
			if (command !=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH)
				vss->stopped =3D true;
			vss->xfer_enabled =3D false;
		}

		msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP,
						GFP_KERNEL);
		if (!msg)
			return -ENOMEM;

		return virtsnd_ctl_msg_send_sync(snd, msg);

If an in-flight capture I/O message completes while vss->xfer_enabled is
false during pause, virtsnd_pcm_msg_complete() skips the memcpy() from
vss->owned_dma_area to runtime->dma_area, but still advances vss->hw_ptr by
data_bytes and resets msg->length to 0.

When the stream is later resumed with SNDRV_PCM_TRIGGER_PAUSE_RELEASE, will
userspace read stale or zeroed bytes from runtime->dma_area for that
completed period?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027234334.3255=
1-1-mynameisjune111@gmail.com?part=3D4
