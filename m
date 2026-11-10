Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270048;
	b=Rk0ih4kSEb/8ztBuqUR9T7asurNOGX9U9OF42WnDCb18Yop7wIjcufT2st4J5dofhHep
	 klnofB0IV06uQEqSDBndWFEij1KeXfi6dRStZ1ctbTSSUuzrM1Kuz0KvVPmrDTOk6hKkM
	 Kktxs9DzA+D3liNDwums9pdWBBNK+rOC3VO7av6cJJ9Is4iREGkeaBiz9wB1FD2+z9sHY
	 2cyiDpfM4Q+Y1GyWQHFCUtbIC+k3VS1HT0wXSp96NOPuc6P6bRseu22ATw04wB9dFVfLe
	 zA60og5Gds8BoVElwh4+469OteBBNKFfZwFAWwbu4xpRwlD77Q8zTry8DxTaDbHJvYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270048;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0L87P+N9joXMhhBF1nwBLGuVj0pgq6z2RXd0RKbGDsw=;
	b=v4G3lTuTGYTT3gElA0IIdKfDzjEKSCoP5ZL/M2FDfXugUDrPwODFW+rOUK7X0UphvzBG
	 Ggnym5SvfCaaE8okvPRhtNEb8QbznJY0wtVhmVHeHckDXN20iOSD+QKP62JXTuX2xHsNR
	 SqX41TkJvxOJ05NlWCXopW/tVQ4ezmwdOtR28T96bqB/BmWhK09Cui83Prixqq7q3il5t
	 YINx1rm6KRytAY4kNlC814Kk4qqSjSAK8JUGWnkLJg0GbBMK0pIbuawdtoHpqetCDfeUL
	 6x2lRkm4U2MEO5xMCYFf+bg93/1x8mgQ5jTN1ie6b07yRZj3Pn6iO6/2Xbf7nsSnwYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVCwDeXv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674FB606A335;
	Tue, 10 Nov 2026 00:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVCwDeXv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0AA1F008A1;
	Tue, 10 Nov 2026 00:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794270047;
	bh=0L87P+N9joXMhhBF1nwBLGuVj0pgq6z2RXd0RKbGDsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PVCwDeXvB/+aXex7FXvRx77Qq+Xghq1R2KcYXx3SmhgxYg849eS5bindN+lAvzsv/
	 KpNlMmYNaIl0ZLGtPzdvYWSCD4gSmCRGaIf99ko+qmXgGnJlUfd4Y+y1OkFgoyJDhr
	 z6Q133Bxv0oz/Xk1uM4Km2FTY3PiiNshU2oBVluQOxt/1lQwUXwKlPIvMR593WRq9C
	 tfWgLV3/Zbg4yrH1pN8T9Qk3jPRNq8jjWL3MV+RIbLWu5N1VU+HbJjSRuQP9bhhpR4
	 WcnTBJAEmSRUApHhfbhmzQdMtq81KcUWFjRcakPe9w84Veh2IkRWR3NQmaBQe9T+p6
	 /wY5H6q+NuXFA==
Message-ID: <sashiko-outbox-205838@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 09/14] ALSA: virtio: bound PCM transfers and retain
 DMA buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-10-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:20:46 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] ALSA: virtio: partial RX on stop latches XRUN in
  virtsnd_pcm_msg_complete()
--

commit 8701e733a8297edcfeb307fc6817693d437f58dc
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: bound PCM transfers and retain DMA buffers

This commit validates PCM buffer geometry, ACK transfer bounds, and RX
completions while retaining backing DMA pages until virtqueue messages are
freed.

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index 59ad99e21e899..c728e8fafb37f 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c

[ ... ]

> @@ -356,42 +536,81 @@ static void virtsnd_pcm_msg_complete(struct virtio_=
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
> +	    (!vss->prepared || vss->xfer_xrun ||
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
> +	/* Only the next complete ring slice can extend captured data. */
> +	if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +	    (msg->data_offset !=3D vss->hw_ptr ||
> +	     written_bytes < sizeof(msg->status) ||
> +	     le32_to_cpu(msg->status.status) !=3D VIRTIO_SND_S_OK ||
> +	     written_bytes - sizeof(msg->status) !=3D msg->length)) {
> +		dev_err_ratelimited(&vss->snd->vdev->dev,
> +				    "SID %u: invalid capture position, status or length\n",
> +			vss->sid);
> +		vss->xfer_xrun =3D true;
> +		capture_invalid =3D true;
> +	}

[Severity: Medium]
Does this latch vss->xfer_xrun when the device completes a partially filled=
 RX
buffer upon VIRTIO_SND_R_PCM_STOP?

Under the VirtIO Sound specification (section 5.14.6.8.2.1), the last RX
buffer returned when a capture stream stops may contain fewer than
period_bytes of PCM frames.  During SNDRV_PCM_IOCTL_DRAIN,
virtsnd_pcm_trigger(SNDRV_PCM_TRIGGER_STOP) sets vss->stopped =3D true and =
sends
VIRTIO_SND_R_PCM_STOP while leaving the substream in SNDRV_PCM_STATE_DRAINI=
NG.
A partial RX completion has written_bytes > sizeof(msg->status) and
written_bytes - sizeof(msg->status) < msg->length, so it bypasses the early
return and sets vss->xfer_xrun =3D true.  That causes virtsnd_pcm_cp_ack() =
to
fail with -EBADFD and virtsnd_pcm_cp_pointer() to report SNDRV_PCM_POS_XRUN,
preventing userspace from draining full periods that had already completed
before STOP.

Similarly, SNDRV_PCM_TRIGGER_PAUSE_PUSH sends VIRTIO_SND_R_PCM_STOP without
setting vss->stopped, so any empty or partial in-flight RX buffer returned =
on
pause also latches vss->xfer_xrun.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D9
