Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C830C37C
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877964; cv=none; b=M+ZVLpS6rTVYIdhazA1IkzyvgDRCwT+02wwZyQSkd8iKTNCzQqx2a2u1awX60jA0cZ+te4LvJIoToCOA0JkyfTcuVZTO6Nf/bdM1ANXUX91J2ktvIqvXwl+jcMCHT0nK8ThkLVYT5ENcMyiRTmQJzvDxWhurmD+Y9/2qaCRevFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877964; c=relaxed/simple;
	bh=MPQuSlYA0R9q4Tf4lDYGC7esfo7dFMs3TPCvO4YeYiA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kQD0TUNXezadHbPDvGBOlIh/MwwPELmTJdhiAXnYBEsA5b3oKzZNeNTYkFBJoT9SExbddU63ZWpQLstenRszuEaI0yxR9Ibg8eY5C1VDHaOPdHt1ixdE2FUarypk713KqbZG1/Ykc+MjWP2KtH+/fuAdtkFJSG7iio3nW6L38pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBKZPguG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBKZPguG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97B21F000FF;
	Tue, 13 Oct 2026 07:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791877963;
	bh=gOJJdVxEgIN5ezfyuXkt03f6EgACsyqQeRpYW4yhjrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jBKZPguGiloW8KbPaaIiSG9fb3DK/NDjXUnTtiI7Wf6IhuIWw+pyzB0mQIdwGMTqk
	 SGRfl3vkniaibbUoyKEbHT4QRnXYuln8+5otxKFtBoJ4GM4k7iI2OcuL+VPdb6GzWX
	 gk8PV/xyBLCXBxa5jGTanE2GvQEDNd2kBH4FJZaWM7/xsTOPVc8zrAZ7Zt7+hUx7qa
	 KoPngoQx7tmswsqz3Z0NNCfHbUcmLbWqaiLm47OPQdCIma88rOburOUSEX/xkwso9f
	 1VNvexLQ2N93t0XvG6DWdvyU1jd62DQq0rBWKiUODmpxi+OPcMSysSjRIHRR7vmov9
	 kS8l5xWD3UtsQ==
Message-ID: <sashiko-outbox-169212@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <9fef5c610028744b71ef243edbcd5a020f14180d.1791877396.git.mynameisjune111@gmail.com>
References: <cover.1791877396.git.mynameisjune111@gmail.com>
 <9fef5c610028744b71ef243edbcd5a020f14180d.1791877396.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 07:52:42 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: Unaligned memory access due to +1 offset with small DMA cachel=
ine alignment
--

commit d7c4b679538e28af5e6c452343c3bd0ca83a7fd1
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Keep control payloads alive through DMA completion

Control requests can expose caller-owned payloads to the device after a
synchronous send times out. Allocate request and response headers and
payloads with the reference-counted message, and place each scatterlist
region on separate DMA cacheline boundaries.

> diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
> --- a/sound/virtio/virtio_ctl_msg.c
> +++ b/sound/virtio/virtio_ctl_msg.c

[ ... ]

> @@ -85,20 +161,83 @@ struct virtio_snd_msg *virtsnd_ctl_msg_alloc(size_t =
request_size,

[ ... ]

>  	msg =3D kzalloc(sizeof(*msg), gfp);
>  	if (!msg)
>  		return NULL;
> =20
> -	sg_init_one(&msg->sg_request, (u8 *)msg + sizeof(*msg), request_size);
> -	sg_init_one(&msg->sg_response, (u8 *)msg + sizeof(*msg) + request_size,
> -		    response_size);
> +	msg->dma_buffer =3D kzalloc(dma_buffer_size, gfp);
> +	if (!msg->dma_buffer) {
> +		kfree(msg);
> +		return NULL;
> +	}
> +	data =3D (u8 *)msg->dma_buffer + 1;

[Severity: High]
When dma_get_cache_alignment() returns 1 (as it typically does on
cache-coherent architectures like x86), does this +1 offset force all
subsequent scatterlist entries to be at an odd, unaligned memory address?

Since the alignment is 1, padding =3D address % alignment in
virtsnd_ctl_msg_sg_init() will evaluate to 0, leaving the data address
unaligned without any added padding.

Later, callers like virtsnd_kctl_get() cast this response data to
struct virtio_snd_ctl_value and directly load 64-bit integers:

sound/virtio/virtio_kctl.c:virtsnd_kctl_get() {
    ...
    case VIRTIO_SND_CTL_TYPE_INTEGER64:
        for (i =3D 0; i < count; ++i)
            uvalue->value.integer64.value[i] =3D
                le64_to_cpu(kvalue->value.integer64[i]);
    ...
}

Can this lead to an unaligned memory access exception or a kernel panic
when UBSAN is enabled on strict architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791877396.gi=
t.mynameisjune111@gmail.com?part=3D5
