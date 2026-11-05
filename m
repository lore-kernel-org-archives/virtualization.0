Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838912;
	b=GPvioEUCtfRBXJc3UEQsz18BX5GwQM3Cru+UThybiJc0NcjhPtbtUuNvzcc2jDVBKqkp
	 qiAaoarP05h/KgSNBBEkmUVETvd4JbzdUkHvu7ULs1T2WMGCN6rOg23ZcanNkqEaK0Non
	 4m0WBHUNPIZbMmIqT2zrAIqylX3M4hMKP1QkeHOT01rHXFPywBXVBRqhT7N0xB/xsaj5x
	 YozFQNH9JZSRUf4QMRiTp8MXDmVDYgn+1+jwlWU+jM/BfSijA76fpxntM+r660EqAS06v
	 uGdpwY76mp3A3YB2BRJrzkKMyohI7n6ZaMBB8Bf6ovgx8pVs4xLZB8kl1zJ1Mrl9HhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838912;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MNUAjqboXRSqTg1RNqmKQl2g1fAisx7I2z8stzqSWgU=;
	b=Zxk0UZX1l9ouqyTf5YMZbyomqYkMiPKF9b3gR0ATKnUcROHMz9FbyXmFF5FUwGWPXDic
	 7l0/MmDeA9iQEx7fkubXCaw/VXXdfhLgtut71XKhevyrUzQ+ht3EX342bF/7mH9v/IRxb
	 qsUFVNIvXdWzcnqnr6l1jbQT4r2Xc3D4PaIbm6ZSOkMJpQH43bBu19f1CfEei67Ov4/PJ
	 6adEilCqQf2v5F+eDh8dBgQ+uISMFtOVO+qg4qmDK9NqxYPoaA+4AEH6q7n30ouXi+aOg
	 Hck80Rzy9+KIQQrBk9Y69UbEHNs7cX6IWQgAQ9NJ6Mc09U/QZKardm5ml0QKkU3HlRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1Feecjb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E079606A31B;
	Thu,  5 Nov 2026 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1Feecjb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC861F000C1;
	Thu,  5 Nov 2026 00:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793838912;
	bh=MNUAjqboXRSqTg1RNqmKQl2g1fAisx7I2z8stzqSWgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a1Feecjb0dhZglkU0NE5RHrfoX3p0ty/kte8jXHLRKXnrcyWfAG2BYp5Lk9LluTyb
	 Y0ybVlvhqC57XfEzUD+jfQRkPaLY7xWLktcJXrkNd7e3VUWGTznXEvhoQCJ1HZyS7L
	 eA7IcpmXUz3refvH3Czy4AsrGAmMDqHQgtpDg7m0USnNQi8zABxji2mbWgDMduHsX6
	 8DDnqNYN3Ku5elz3tfmqAChVVZlgkSgT5Ky+koWca7VJWtIzhe53GoVJXJMPSmpWsJ
	 KvzDvzlQRq3WkLs7QxZaRIhYS5zlsxK1awmM6BCIJh6qejJDkrBnUdIEK/uJ8/Og1t
	 UzJ2ZfbvEmaqw==
Message-ID: <sashiko-outbox-198363@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 07/12] ALSA: virtio: Keep PCM DMA buffers alive
 through device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000915.15177-8-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
 <20261105000915.15177-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:35:11 +0000
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
- [Medium] ALSA: virtio: unvalidated slice order in virtsnd_pcm_msg_complet=
e()
--

commit b2a39e63df7fac644d0bf6ab9ec43939a12f17f0
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Keep PCM DMA buffers alive through device ownership

This commit retains references to the pages backing ALSA vmalloc buffers
(or uses driver-owned buffers on NOMMU systems) until queued I/O messages
are freed, and adds validation for PCM buffer bounds, period sizes, and
capture completion status and payload lengths.

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index 59ad99e21e899..9fb966a02d923 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
[ ... ]
> @@ -356,42 +540,80 @@ static void virtsnd_pcm_msg_complete(struct virtio_=
pcm_msg *msg,
>  				     size_t written_bytes)
>  {
>  	struct virtio_pcm_substream *vss =3D msg->substream;
> +	bool capture_invalid =3D false;
> =20
>  	/*
> -	 * hw_ptr always indicates the buffer position of the first I/O message
> -	 * in the virtqueue. Therefore, on each completion of an I/O message,
> -	 * the hw_ptr value is unconditionally advanced.
> +	 * Completed requests can return captured data after STOP while the PCM
> +	 * buffer remains prepared. Once preparation ends, completions only ret=
ire
> +	 * queue ownership.
>  	 */
>  	guard(spinlock)(&vss->lock);
> -	/*
> -	 * If the capture substream returned an incorrect status, then just
> -	 * increase the hw_ptr by the message size.
> -	 */
> -	if (vss->direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK ||
> -	    written_bytes <=3D sizeof(msg->status))
> -		vss->hw_ptr +=3D msg->length;
> -	else
> -		vss->hw_ptr +=3D written_bytes - sizeof(msg->status);
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +	    (!vss->prepared ||
> +	     (vss->stopped && written_bytes <=3D sizeof(msg->status)))) {
> +		msg->length =3D 0;
> +		vss->msg_count--;
> +		if (!vss->msg_count)
> +			wake_up_all(&vss->msg_empty);
> +		return;
> +	}
> =20
> -	if (vss->hw_ptr >=3D vss->buffer_bytes)
> -		vss->hw_ptr -=3D vss->buffer_bytes;
> +	/* A non-staged capture request must return its full payload. */
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +	    (written_bytes < sizeof(msg->status) ||
> +	     le32_to_cpu(msg->status.status) !=3D VIRTIO_SND_S_OK ||
> +	     written_bytes - sizeof(msg->status) !=3D msg->length)) {
> +		dev_err_ratelimited(&vss->snd->vdev->dev,
> +				    "SID %u: invalid capture status or length\n",
> +			vss->sid);
> +		vss->xfer_xrun =3D true;
> +		capture_invalid =3D true;
> +	}
> +#ifndef CONFIG_MMU
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +	    vss->prepared && !capture_invalid &&
> +	    written_bytes > sizeof(msg->status)) {
> +		struct snd_pcm_runtime *runtime =3D
> +			vss->substream ? vss->substream->runtime : NULL;
> +
> +		if (!runtime || !runtime->dma_area || !vss->owned_dma_area ||
> +		    msg->data_offset > runtime->dma_bytes ||
> +		    msg->length > runtime->dma_bytes - msg->data_offset ||
> +		    msg->data_offset > vss->owned_dma_bytes ||
> +		    msg->length > vss->owned_dma_bytes - msg->data_offset) {
> +			dev_err_ratelimited(&vss->snd->vdev->dev,
> +					    "SID %u: invalid capture buffer for I/O message\n",
> +				vss->sid);
> +			vss->xfer_xrun =3D true;
> +			capture_invalid =3D true;
> +		} else {
> +			memcpy(runtime->dma_area + msg->data_offset,
> +			       vss->owned_dma_area + msg->data_offset, msg->length);
> +		}
> +	}
> +#endif
> +	/* Publish pointer progress only for a complete TX or valid RX request.=
 */
> +	if (!capture_invalid) {
> +		vss->hw_ptr +=3D msg->length;
> +		if (vss->hw_ptr >=3D vss->buffer_bytes)
> +			vss->hw_ptr -=3D vss->buffer_bytes;
> +	}

[Severity: Medium]
Can virtsnd_pcm_msg_complete() expose unwritten ring buffer slices to
userspace if capture descriptors complete out of order or after an earlier
descriptor is retired without advancing vss->hw_ptr?

In ordinary capture mode, each descriptor vss->msgs[i] targets a fixed
ring buffer slice at offset i * period_bytes, while
virtsnd_pcm_msg_complete() advances vss->hw_ptr by msg->length without
checking that the completing msg corresponds to the slice at vss->hw_ptr.

When vss->stopped is true while vss->prepared remains true (such as after
SNDRV_PCM_TRIGGER_STOP), if vss->msgs[0] (slice 0) completes empty with
written_bytes <=3D sizeof(msg->status), virtsnd_pcm_msg_complete() retires
vss->msgs[0] and returns early without advancing vss->hw_ptr or latching
vss->xfer_xrun.

If vss->msgs[1] (slice 1, at offset period_bytes) subsequently completes
with a full period, or if the device completes vss->msgs[1] before
vss->msgs[0] out of order, virtsnd_pcm_msg_complete() writes or copies the
payload into slice 1 at offset period_bytes and advances vss->hw_ptr from
0 to period_bytes. Subsequent calls to virtsnd_pcm_pointer() and
virtsnd_pcm_ack() see vss->xfer_xrun =3D=3D false and publish slice 0, which
was never filled by vss->msgs[0], as readable captured audio.

Similarly, if an earlier capture descriptor failed validation and set
vss->xfer_xrun =3D true without advancing vss->hw_ptr, a later valid
descriptor completion still copies NOMMU data into its own offset and
advances vss->hw_ptr because virtsnd_pcm_msg_complete() only checks the
local capture_invalid flag rather than vss->xfer_xrun.

Should virtsnd_pcm_msg_complete() verify that the completing message matches
the expected ring slice at vss->hw_ptr and avoid advancing vss->hw_ptr (or
accepting further completions) once an empty stopped descriptor has been
retired or vss->xfer_xrun has been latched?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000915.1517=
7-1-mynameisjune111@gmail.com?part=3D7
