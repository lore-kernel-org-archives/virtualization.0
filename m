Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339806;
	b=erVTDOmHeUg8dY9XeJimQz7w0Lhcmg8RofKUKkvIi6kI5b/gw8wAC+D7dyikm9WJDYQI
	 D4+lkSJeQ4ZD6owuBR0tD1ze3QFtFkD2ET3tLksbwIUBYFQ55i79pkrDMsXwIO0uxfd0F
	 +8kKXsa24dOG2LYr1P5kCS4skfrpnSH5dVriS/bguxXfKmtTiaWRAuROwz/kpoYS/cy7E
	 PU1llSPaFPsNVU1DT4s57eqlkc02be0FAgPoHdMxdCDtRWK8wUPPKbSHq2LHcdsDRF0iy
	 cidu6YF+wvPdH5OSvCwhDAyBHye2PgPyWol0Oq66nZc1qQsZU+BxBllghC/i8QXz3vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339806;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8VD8HsTJcDrAkjHPN25yMocgLHQq1/ynKeBsywslWlU=;
	b=KwUbm+d7W+0wqhgDXh9epdzW+5SkKtmybimC/BMfM7wijJthvnuhvcu5njqUZDq1s4La
	 lQIR/BCQP1axUOJ1Mi7OfyfdKL9khVrOh6naQJ5Cf8QJ1nwSqEXUkudBeSBTsP3nI+aSj
	 EINlYWDHWjuRlzSBXoI4CZdK00kWSRgNpuGNNDOqXQPamUImc/EMKZ55bEbVCHwE+n2yy
	 0P5R7zdWT+fPd7luY+h2L2JETegOsP2h9X5rlQZY0oHFGKtBbzNrqX+F9FKs2hXek49B9
	 4+j9uhIwUBUmphDnbqpwpP7ub0ietbxCe2LxQi8x1afg/yaTG4NiZotJ0xmPVXcrYog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxZT7qkg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8FD606A31A;
	Fri, 30 Oct 2026 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxZT7qkg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8803B1F000C1;
	Fri, 30 Oct 2026 05:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793339805;
	bh=8VD8HsTJcDrAkjHPN25yMocgLHQq1/ynKeBsywslWlU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gxZT7qkgL9mLDQ/uAGKRZ9PiYi6XaFD/ls+GiIKl/uMC6JZf5ClU1qKg2rtWy1cSG
	 MYrBp8eF00/LPvs1IKeGZcdqcJ7diXUqZbiXaDAvQjmt+y8PDFKtSMDdSJlYv8SdTQ
	 il4GuHhmkWP0AMvstP9YCJTY8NWIFbl4A6vakJBTWRTji5DyeXfB5cRYJB3NhezyPo
	 k0hjmqyCrIeoBw9VXTLXwPOC8Ly0GEX53lH5HQDEX70Ac0fr6TVhW7sXyK+NKPsqMO
	 /IiYeJYukngiGC3aC+Jr61+IFXhWnwvpMflkHB2DlrORGCvF6fjXpqTtKPUF1G7bGe
	 SfWqs+THU1d0Q==
Message-ID: <sashiko-outbox-190581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/14] ALSA: virtio: Keep PCM DMA buffers alive
 through device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030052629.27742-5-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
 <20261030052629.27742-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:56:45 +0000
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
- [High] ALSA: virtio: pause release inflates msg->length in virtsnd_pcm_ms=
g_send()
--

commit ec627d670b7dce9aa5415f6f76196d33998b7e23
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Keep PCM DMA buffers alive through device ownership

This commit retains references to ALSA's vmalloc buffer pages while I/O
messages are queued (or uses a driver-owned buffer on NOMMU systems), valid=
ates
buffer and period boundaries, and clamps device-reported capture completion
lengths to msg->length.

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index 762480363b861..bc2002312a282 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c

[ ... ]

> @@ -363,15 +546,48 @@ static void virtsnd_pcm_msg_complete(struct virtio_=
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
Can SNDRV_PCM_TRIGGER_PAUSE_RELEASE on a capture substream inflate msg->len=
gth
beyond period_bytes in virtsnd_pcm_msg_send(), bypassing the new clamp in
virtsnd_pcm_msg_complete() and advancing vss->hw_ptr out of bounds?

In sound/virtio/virtio_pcm_ops.c, virtsnd_pcm_trigger() handles both
SNDRV_PCM_TRIGGER_START and SNDRV_PCM_TRIGGER_PAUSE_RELEASE by submitting t=
he
entire buffer on capture substreams:

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_trigger() {
	case SNDRV_PCM_TRIGGER_START:
	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
		...
			if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE)
				rc =3D virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
}

When a capture stream is paused with SNDRV_PCM_TRIGGER_PAUSE_PUSH, the driv=
er
sends VIRTIO_SND_R_PCM_STOP rather than VIRTIO_SND_R_PCM_RELEASE, so uncomp=
leted
RX messages remain queued in the virtqueue with msg->length =3D=3D period_b=
ytes.

When SNDRV_PCM_TRIGGER_PAUSE_RELEASE subsequently calls
virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes), the loop adds n to msg->le=
ngth
unconditionally for every period:

sound/virtio/virtio_pcm_msg.c:virtsnd_pcm_msg_send() {
		n =3D period_bytes - (offset % period_bytes);
		if (n > bytes)
			n =3D bytes;

		msg->length +=3D n;
		if (msg->length =3D=3D period_bytes) {
			...
}

For messages already queued in the virtqueue, msg->length becomes
2 * period_bytes (or (K + 1) * period_bytes after K pause/release cycles), =
and
for any partially acknowledged message (0 < msg->length < period_bytes),
msg->length is incremented past period_bytes without ever matching
msg->length =3D=3D period_bytes to be re-queued.

In virtsnd_pcm_msg_complete(), clamping data_bytes to msg->length then perm=
its
oversized device completions up to the inflated msg->length rather than the
single-period SG payload capacity (copying across adjacent periods on NOMMU=
 and
advancing vss->hw_ptr by multiple periods). Likewise, if the stream is rele=
ased
and pending RX descriptors complete with written_bytes <=3D sizeof(msg->sta=
tus),
vss->hw_ptr +=3D msg->length advances vss->hw_ptr by a multiple of period_b=
ytes,
where the single subtraction of vss->buffer_bytes can leave
vss->hw_ptr >=3D vss->buffer_bytes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030052629.2774=
2-1-mynameisjune111@gmail.com?part=3D4
