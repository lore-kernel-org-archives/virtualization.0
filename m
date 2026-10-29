Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254072;
	b=P/WEoUE3Pxj3zqmVam5r8RoINHdy1spjWYhhgcZo5Y2LdTC8odDGvve7QEMK+hNj/KwR
	 pGHNogJ87NoAGZ21Lez5Ef8GFvuhhy1NPSE0Y6ipVKclV1tdTUHxj/N9wvaIy84kF0fT6
	 xbcPg48rHSABGyWCndyAlRTdTY+Yz1kxBBsbdEH3Ej2EUGoS2ROVAZoM2QMoTeYD0Bh5V
	 BXTyt0oUxVZh3ZpQqK1I3hvksjOmNNWaxk3CYkeknFkapDjzoRb+3rQaNTIlHyoWStHqQ
	 Iq9BioSqJ0T8+NIcUFiDxrBp5uq7dzHpozPtUG5tZD6pSz8dEQOZ5cVzdFptyQXm62Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254072;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9/w12gC2Flq4f1MChoH3uqKpVNeD2xjUZFA6jng+zrg=;
	b=dzS4bOKWqG3A6zuMYVLfNib4WpQlcMdKD9IA8IJ3aNEoqnjYSfYqsbwzxRB7gnTuTwhN
	 zlptl3h9wYEKnWMJb2Ys18OkxeZ28APB1rviCVS/b2hOubkok2YO3KEI4oV/txIiEUGIg
	 VKrdG/jPkgN681QuqA4HS2YQ6+iTTJsBMT2I975ProO66Xpbd8iYoedr5yugnZFDXlESj
	 LJx3Wafgx4QMIoPrI5flt+RLXxIsfg21gs11lagysQohmegIE00dyz+WlZ2+ptSJRMQrj
	 3nlqLIPo11bFhk1xfISSE5jAuxnKdiKZ33ZOUJxTNtmhXaIp22eoyeHWCBdAaeckZnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+RwfhPA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DF6606A31A;
	Thu, 29 Oct 2026 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+RwfhPA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07121F01825;
	Thu, 29 Oct 2026 06:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793254071;
	bh=9/w12gC2Flq4f1MChoH3uqKpVNeD2xjUZFA6jng+zrg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g+RwfhPA1Mt6O6UVpev5um1RJ8s3LyPQF+6+aHd1g93pl7JREKQN+0SCWOlmE3irP
	 AC2wIhDBwKQHGxjd4QrthcQTPA5fIZBEMIIz5+yQ2Hiybg1E62r6c13D0YQ/AcfGq4
	 VWvB+4nQVzlEuWBj1U8DHdFpMtj6NF2euH0QmNj1CC6/MsTZFV2Qy9YhsE7BZExs7e
	 0ttVSkcpDudQaO/MWjGSL2b7e6V1pIxyC63TaP0TxFMCt7he/7KtpGcRP4TeRYR6iA
	 w6qzt/VYV56VxJ40VMZOGk92SYKnkJg9hzTCewolb0JubY0lDv6GfsgmgIBeDtO5tU
	 rWPSzovTTnV7A==
Message-ID: <sashiko-outbox-188794@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/14] ALSA: virtio: Keep PCM DMA buffers alive
 through device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029054354.2931-5-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
 <20261029054354.2931-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:07:51 +0000
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
- [High] ALSA: virtio: out-of-bounds vss->msgs[] access when buffer_bytes <=
 dma_bytes
--

commit 5684205c20865cb426276aaf2c41df707838c019
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Keep PCM DMA buffers alive through device ownership

This commit retains references to pages backing ALSA vmalloc buffers (or us=
es
a driver-owned DMA buffer on NOMMU systems) until queued virtio-snd I/O
messages are freed. It also adds buffer validation during message allocation
and clamps device-reported capture completion lengths to the message capaci=
ty.

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index 762480363b861..b7f2334bb221c 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c

[ ... ]

> @@ -132,36 +211,99 @@ static void virtsnd_pcm_sg_from(struct scatterlist =
*sgs, int nsgs, u8 *data,
>  int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
>  			  unsigned int periods, unsigned int period_bytes)
>  {
> -	struct snd_pcm_runtime *runtime =3D vss->substream->runtime;
> +	struct snd_pcm_runtime *runtime;
> +	size_t buffer_bytes;
>  	unsigned int i;
> +	int rc;
> =20
> -	vss->msgs =3D kzalloc_objs(*vss->msgs, periods);
> -	if (!vss->msgs)
> +	if (vss->msgs || vss->nmsgs || vss->dma_pages || vss->ndma_pages)
> +		return -EBUSY;
> +#ifndef CONFIG_MMU
> +	if (vss->owned_dma_area || vss->owned_dma_bytes)
> +		return -EBUSY;
> +#endif
> +	if (!periods || !period_bytes)
> +		return -EINVAL;
> +
> +	if (check_mul_overflow((size_t)periods, (size_t)period_bytes,
> +			       &buffer_bytes))
> +		return -EOVERFLOW;
> +
> +	if (!vss->substream || !vss->substream->runtime)
> +		return -EINVAL;
> +	runtime =3D vss->substream->runtime;
> +	if (!runtime->dma_area || buffer_bytes > runtime->dma_bytes)
> +		return -EINVAL;

[Severity: High]
Can this validation allow buffer_bytes < runtime->dma_bytes to pass and lead
to an out-of-bounds read on vss->msgs[] in virtsnd_pcm_msg_send()?

virtsnd_pcm_open() constrains SNDRV_PCM_HW_PARAM_PERIODS to an integer, and
ALSA core constrains SNDRV_PCM_HW_PARAM_PERIOD_SIZE and
SNDRV_PCM_HW_PARAM_BUFFER_BYTES to integers, but SNDRV_PCM_HW_PARAM_PERIOD_=
BYTES
is not constrained to an integer. When the device supports the 4-bit
SNDRV_PCM_FORMAT_IMA_ADPCM format (VIRTIO_SND_PCM_FMT_IMA_ADPCM), a 1-chann=
el
stream (frame_bits =3D=3D 4) configured with an odd period_size (for exampl=
e, 2001
frames) and an even number of periods (for example, 2, giving buffer_size =
=3D=3D
4002 frames) refines SNDRV_PCM_HW_PARAM_BUFFER_BYTES to the exact integer 2=
001
(so runtime->dma_bytes is 2001), while SNDRV_PCM_HW_PARAM_PERIOD_BYTES refi=
nes
to the non-empty open interval (1000, 1001). Both params_period_bytes() and
snd_pcm_lib_period_bytes() truncate that period byte size to 1000.

In virtsnd_pcm_msg_alloc(), buffer_bytes is computed as periods * period_by=
tes
(2000), which passes buffer_bytes > runtime->dma_bytes and allocates only
vss->nmsgs =3D 2 messages (along with 2000 bytes of retained pages or
owned_dma_area).

Later, virtsnd_pcm_prepare() sets vss->buffer_bytes and the pcm_indirect
buffer sizes from snd_pcm_lib_buffer_bytes(substream) (2001):

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_prepare() {
	...
		vss->buffer_bytes =3D snd_pcm_lib_buffer_bytes(substream);
		vss->hw_ptr =3D 0;
	...
	vss->pcm_indirect.sw_buffer_size =3D
		vss->pcm_indirect.hw_buffer_size =3D
		snd_pcm_lib_buffer_bytes(substream);
}

When capture starts via virtsnd_pcm_trigger() ->
virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes), or playback transfers the
final byte of the buffer via virtsnd_pcm_pb_ack() -> virtsnd_pcm_msg_send(),
virtsnd_pcm_msg_send() computes end =3D (offset + bytes - 1) / period_bytes=
 =3D
2000 / 1000 =3D 2 and indexes vss->msgs[2] past the end of the 2-element
vss->msgs[] array:

sound/virtio/virtio_pcm_msg.c:virtsnd_pcm_msg_send() {
	...
	start =3D offset / period_bytes;
	end =3D (offset + bytes - 1) / period_bytes;

	for (i =3D start; i <=3D end; i++) {
		struct virtio_pcm_msg *msg =3D vss->msgs[i];
	...
}

Should virtsnd_pcm_msg_alloc() check buffer_bytes !=3D runtime->dma_bytes (=
or
constrain SNDRV_PCM_HW_PARAM_PERIOD_BYTES to an integer in virtsnd_pcm_open=
())
so that periods * period_bytes always covers the full PCM buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029054354.2931=
-1-mynameisjune111@gmail.com?part=3D4
