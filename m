Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145343;
	b=FYywMQIuZQ3t0BVlret7CSYc4+L7ffoLhTI2OTqGkJ8PzzvcjP85QRoYE80ZuI/3osay
	 QQJMn/kdtW81hULEjkvNegfpx77JY/Bjke0IzE+nWFOOI2dexqn4PxSVoNHxIWiCyXyqi
	 TCUy2WnufWB5xiUj78E2m9liJYAj4aDF/2hycPOWARIFE1cFAYpt+mLErRyROPFJwKE6+
	 UEEFFE8bW8mSNMMe9dKoaMSWQCCSYLV5K0S8fP/ifkKPHIo0Vvlnapm+IWTKvbbUQ4qN6
	 ui/LOyzonEzkWn5MfbS66vkrpu2hXObn2OBTK7aQhqHRwSp3wjsLfXP5rUGIEZI3xLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145343;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tnlgzbpDWkaBV+j/E2BQNW2CJVix5snP5Css6owCKXs=;
	b=cYHYbXVr6FXRa9PgJRG6cBP6IVpJ3n32A9bcuCbfAmWxf2eOs1/XGHqv6FUMjBfxp0x/
	 vzcp92UPjviKCGSW3ROHgt7k7lA0sLBrkT1iGbLyRZRCdd33m1eyv7+UM6ujo/VX9b0oY
	 Vm9ixoSwtOqS90W3bXolI5dm2zgSsWhOretVq4PULkSfCX4aygnrJ1MLfrBQPQdbMpPui
	 /PW6lYUhWiA60tQKM0O/X+DxqsaiDYwUXgZdtq4B5/pv6sNmQuU/E9ckJrMMRNhw8Jdcd
	 WGPTm5Z0EO7Kv3/VtT9CfnB/mDkwELdngAduPvSEaAkF7+xd8xv6AJWPsSEc4A+1ewA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tp/BpH+8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47199606A32C;
	Tue, 27 Oct 2026 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tp/BpH+8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1771F01829;
	Tue, 27 Oct 2026 23:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793145343;
	bh=tnlgzbpDWkaBV+j/E2BQNW2CJVix5snP5Css6owCKXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tp/BpH+8mjj8GJpkLooR2HJL/Nw4xiig0WpzjVwkxaRjFgpXBo9aqO30lM5Wp2sCr
	 sFmbwJaTmVREVNFOyryezFPr4AW+KRt1tuZT7dm/tGJeIEFrZ6fOwsb/FYNRZX0/kZ
	 qkPEHyL+Ncj0a9PBXGVdgDSibe5zHUQoZKX0dTmDol9GdDtZ8BZ7WFUChAVELc+6b2
	 kMQiYVE1nNgTcILKhCCZxdHvKg4K24pdJMkwYtA2R6u6QTbpnL9ogRvDt1nmZdyO9E
	 48WO+4QcJRWD+IiOAOvmsyxUtwDTtHwgwVf99RkjBm1ips0Y0jz7xCcpfc/VW30l49
	 k8/Z/a71DAHOA==
Message-ID: <sashiko-outbox-187245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/11] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261027234334.32551-6-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
 <20261027234334.32551-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:55:42 +0000
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
- [Medium] ALSA: virtio: misaligned control value access in virtsnd_kctl_ge=
t()
--

commit 15e13c28bcb1079484dfa947a5ae6109ebb5b3c9
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Keep control payloads alive through DMA completion

This commit moves control request and response payloads into a
reference-counted DMA buffer owned by struct virtio_snd_msg so caller
buffers are not exposed to DMA after a timeout or interruption. It also
aligns each scatterlist region to the greater of the DMA cacheline size
and the alignment of struct virtio_snd_ctl_value.

> diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
> index 7114bea4033a5..2e0ff15e729da 100644
> --- a/sound/virtio/virtio_ctl_msg.c
> +++ b/sound/virtio/virtio_ctl_msg.c
[ ... ]
> @@ -85,20 +161,85 @@ void *virtsnd_ctl_msg_response(struct virtio_snd_msg=
 *msg)
>  struct virtio_snd_msg *virtsnd_ctl_msg_alloc(size_t request_size,
> -					     size_t response_size, gfp_t gfp)
> +					     size_t response_size,
> +					     size_t request_data_size,
> +					     size_t response_data_size,
> +					     gfp_t gfp)
>  {
[ ... ]
> +	cache_alignment =3D dma_get_cache_alignment();
> +	if (cache_alignment <=3D 0)
> +		return NULL;
> +	/* DMA coherence does not remove the CPU's type alignment requirement. =
*/
> +	alignment =3D max_t(size_t, cache_alignment,
> +			  __alignof__(struct virtio_snd_ctl_value));
[ ... ]
> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> index 45f7b6a5b3080..4cf75dedbe9a3 100644
> --- a/sound/virtio/virtio_kctl.c
> +++ b/sound/virtio/virtio_kctl.c
[ ... ]
> @@ -161,10 +163,12 @@ static int virtsnd_kctl_get(struct snd_kcontrol *kc=
ontrol,
>  	unsigned int i;
>  	int rc;
> =20
> -	msg =3D virtsnd_ctl_msg_alloc(request_size, response_size, GFP_KERNEL);
> +	msg =3D virtsnd_ctl_msg_alloc(request_size, response_size, 0, 0,
> +				    GFP_KERNEL);
>  	if (!msg)
>  		return -ENOMEM;

[Severity: Medium]
Does packing both the response header and struct virtio_snd_ctl_value into
sg_response leave kvalue misaligned in virtsnd_kctl_get()?

In virtsnd_ctl_msg_alloc(), each scatterlist region is aligned to at least
__alignof__(struct virtio_snd_ctl_value), which is 8 bytes because of the
__le64 integer64[64] array.

In virtsnd_kctl_put(), the request header is struct virtio_snd_ctl_hdr (8
bytes), so placing kvalue immediately after it preserves 8-byte alignment.

However, in virtsnd_kctl_get(), response_data_size is passed as 0 and
response_size is sizeof(struct virtio_snd_hdr) + sizeof(*kvalue), with
kvalue computed right after the 4-byte struct virtio_snd_hdr:

sound/virtio/virtio_kctl.c:virtsnd_kctl_get() {
	...
	kvalue =3D (void *)((u8 *)virtsnd_ctl_msg_response(msg) +
			  sizeof(struct virtio_snd_hdr));

	switch (type) {
	...
	case VIRTIO_SND_CTL_TYPE_INTEGER64:
		for (i =3D 0; i < count; ++i)
			uvalue->value.integer64.value[i] =3D
				le64_to_cpu(kvalue->value.integer64[i]);
		break;
	...
}

Since virtsnd_ctl_msg_response(msg) is aligned to a multiple of 8 bytes and
sizeof(struct virtio_snd_hdr) is 4 bytes, kvalue is guaranteed to land at an
8n + 4 address, causing unaligned 64-bit loads when reading a
VIRTIO_SND_CTL_TYPE_INTEGER64 control.

Should the control value payload be placed in response_data (or the
request/response payloads placed in sg_request_data and sg_response_data) so
that kvalue starts on an aligned boundary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027234334.3255=
1-1-mynameisjune111@gmail.com?part=3D5
