Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B63AE6F3
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869996; cv=none; b=NeTlRi5a8tvq0Sr6OdR6ZbopoHb1JjbgPBt8ZTivNbEA9IsekwE35oIWxl9h6EQujiV/az+xvE1Uh4MIkIMJ6yQQhh3NA7VvEq79UoNVcMfEBYI2Xx0NQSTgyoxKxTJ/AMKd0Ds8z1REr9EHVR80zAPLt3Yn64r0XTam4sKX88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869996; c=relaxed/simple;
	bh=uVL+GrP5eB/MjqDsVWIh5Wa9qpegE64FUr0twYuOZLI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TUpkY1LqYYeqByXMcCnA1WsG2Yvjgg6Z0iAVspng9nRC+XmBe3Q4H7E1kZP8ZaHf1MHKYh8uijWFfyWJfb4lfAYjJhT0AH59V8xmhOR/Xt9YpnTsmgeCX8JnCceZN/LAVUUo9ZTnFoWvfartcs9ifaJiokm4PisogXPgqztPij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2wnezRJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2wnezRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833AF1F00893;
	Tue, 13 Oct 2026 05:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791869994;
	bh=9GDOssXXSThda6sKcviacNMmJVoC6f9lnZeOErtLr+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C2wnezRJhKZz8/g1JdHBcI6AvTZLOifrcWF2lkLyMA+wCM00Vi2MAKs7CK6XiaS1k
	 B0QdY+ZP5zIXrz18Yb+sx/uNbgDBnQTeR6H6LtLtnBn8k5Q+5UMaANEbvocPfmBqc5
	 +krwIVSOd3ykCPl6YHk/GQcxJxEK7xYRJT54atzMaKbf3Sprki31AlxHNR13j7h3I2
	 Wjm/CtLG2gd8Sw4BG8Jg0gOo98VYM6cUtPGGfeLFaCpmadsNTQXtlwdTTcbNPGqjzw
	 hrNFyT/sa5RTLIBkjtMyZwGAWiOMIBt30aaItg+dQ+yG8rJTW9nmPRGKcVredamUe5
	 7lPV02DD646KA==
Message-ID: <sashiko-outbox-169001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/5] ALSA: virtio: Keep control payloads in
 refcounted messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <9aac47803de024cd66c56cc594560c69b5a8a526.1791867377.git.mynameisjune111@gmail.com>
References: <cover.1791867377.git.mynameisjune111@gmail.com>
 <9aac47803de024cd66c56cc594560c69b5a8a526.1791867377.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 05:39:54 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] virtio/snd: DMA cacheline sharing for control message payloads
--

commit 332dc283a2bc483bd13699b7e6a008d8c41b3af6
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Keep control payloads in refcounted messages
   =20
Control requests can include scatterlists that point to caller-owned
payloads. A synchronous send can time out while the device still owns
those descriptors, so the caller can free a TLV or other payload before
a late device access.

> diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
> index 3ad1e1e1b2054..62d4c529922ca 100644
> --- a/sound/virtio/virtio_ctl_msg.c
> +++ b/sound/virtio/virtio_ctl_msg.c

[ ... ]

> @@ -85,20 +119,43 @@ void *virtsnd_ctl_msg_response(struct virtio_snd_msg=
 *msg)
>   * Return: Allocated message on success, NULL on failure.
>   */
>  struct virtio_snd_msg *virtsnd_ctl_msg_alloc(size_t request_size,
> -					     size_t response_size, gfp_t gfp)
> +					     size_t response_size,
> +					     size_t request_data_size,
> +					     size_t response_data_size,
> +					     gfp_t gfp)
>  {
>  	struct virtio_snd_msg *msg;
> -
> -	if (!request_size || !response_size)
> +	size_t total_size =3D sizeof(*msg);
> +	u8 *data;
> +
> +	if (!request_size || !response_size || request_size > UINT_MAX ||
> +	    response_size > UINT_MAX || request_data_size > UINT_MAX ||
> +	    response_data_size > UINT_MAX ||
> +	    check_add_overflow(total_size, request_size, &total_size) ||
> +	    check_add_overflow(total_size, response_size, &total_size) ||
> +	    check_add_overflow(total_size, request_data_size, &total_size) ||
> +	    check_add_overflow(total_size, response_data_size, &total_size))
>  		return NULL;
> =20
> -	msg =3D kzalloc(sizeof(*msg) + request_size + response_size, gfp);
> +	msg =3D kzalloc(total_size, gfp);
>  	if (!msg)
>  		return NULL;
> =20
> -	sg_init_one(&msg->sg_request, (u8 *)msg + sizeof(*msg), request_size);
> -	sg_init_one(&msg->sg_response, (u8 *)msg + sizeof(*msg) + request_size,
> -		    response_size);
> +	data =3D (u8 *)msg + sizeof(*msg);
> +	sg_init_one(&msg->sg_request, data, (unsigned int)request_size);
> +	data +=3D request_size;
> +	sg_init_one(&msg->sg_response, data, (unsigned int)response_size);
> +	data +=3D response_size;
> +	msg->request_data_size =3D request_data_size;
> +	msg->response_data_size =3D response_data_size;
> +	if (request_data_size) {
> +		sg_init_one(&msg->sg_request_data, data,
> +			    (unsigned int)request_data_size);
> +		data +=3D request_data_size;
> +	}
> +	if (response_data_size)
> +		sg_init_one(&msg->sg_response_data, data,
> +			    (unsigned int)response_data_size);

[Severity: High]
Does packing these DMA buffers tightly together after the virtio_snd_msg
struct cause cacheline sharing issues?

Because sizeof(*msg) and the header sizes are not aligned to
ARCH_DMA_MINALIGN, these buffers might share CPU cachelines with each other
and with CPU-accessed fields of virtio_snd_msg (like ref_count and
cancelled).

On non-cache-coherent architectures, mapping a buffer as DMA_FROM_DEVICE
(such as sg_response and sg_response_data) causes the DMA API to invalidate
the shared cacheline upon unmapping so the CPU sees the device's writes.

If the CPU concurrently modifies msg->cancelled or msg->ref_count in that
same cacheline (e.g., upon a timeout), could those writes be silently
discarded by the cache invalidation?

Previously, payloads were allocated separately via kzalloc(size), which
guaranteed safe ARCH_DMA_MINALIGN boundaries. Embedding them inline appears
to introduce a DMA cacheline sharing hazard.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791867377.gi=
t.mynameisjune111@gmail.com?part=3D5
