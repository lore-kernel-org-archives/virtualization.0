Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385E3A7F6B
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 05:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869990; cv=none; b=d3t8NkxqYXfAfA7oFLdoeERlfeb1gCJIM+NWxOg7fpTaYgT1KPJfQBqCipKR9++3IfaptSImoZK/JY6K3XFaz6bCflyEXZSMMF5WoxFjedfahpegMMPc1ScHrSr8re6RHRZ8Jb2kI70v+Doq3NCXHM83Nb4vdpkVBEU+xpBmxp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869990; c=relaxed/simple;
	bh=N395V7QtUzAE0wOaxV+y0DQhYZoHWnQ8IDvKJD3CQrE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DDZQvlAGA/mhUnH3l2CXuIRFw2nT7ghBLRVT3It/6vxjukzwlTsIleD5OzD0pui/qJLgL4S+2L70PB/FBjsLB0U7/V///ES+Te3HMb5yFimd+SZBP/OdIOQdR/Q3UhwSIPlSMH2Pl5FJ0UROKaqYZ0QpZpMKho+Dxry5bP+eGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKtwYXI0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKtwYXI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34021F00893;
	Tue, 13 Oct 2026 05:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791869988;
	bh=VdVGFFhjM/pdvYZQVqueMRFi4XWlTWm8BAdivhgeElU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mKtwYXI0/dP40puTUm/GQtc+SZT87ppTz0d5BEDBdKMdB6iGZ1ZZ3MXlOVpZ4jWmy
	 Wf1xOi07SdNZeQp6aRmXcZcvIyCpzr30SkmbV5BS/X+tAhtOyqeA6CfdOc4cUexi5+
	 SaFdSiodQRqdbBv2sZ1hIEKtorWFLfbmd9E8PBc5agBj2rPVNdNrgMaaVhvxIi69oS
	 pS2VvQuR7qpgdq84aWelfVknloUjRm0n5EBD4EQ6Qw0XbdjryPtyoc/9vehrvxM866
	 5flHSLNVAqZymrOVIZEfZNNohJ6Ujr+1htY1139JADfzq80Ez9VgvIK1hV7ghywHv1
	 DT7DSKkt9VtWQ==
Message-ID: <sashiko-outbox-169000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/5] ALSA: virtio: Retain PCM DMA pages until
 messages are freed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <6b6421f719a49ce0195c3d43f58b50e40a6e9347.1791867377.git.mynameisjune111@gmail.com>
References: <cover.1791867377.git.mynameisjune111@gmail.com>
 <6b6421f719a49ce0195c3d43f58b50e40a6e9347.1791867377.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 05:39:48 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] alsa/virtio: !is_vmalloc_addr check breaks NOMMU support
--

commit 011a5cf5cd03694cab8083a5256df199dd8e906f
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Retain PCM DMA pages until messages are freed

This patch takes a reference to each page backing the PCM buffer before
building the I/O scatterlists, releasing them only when the messages are
freed. This prevents late device DMA from accessing pages that the
allocator could reuse after ALSA releases the vmalloc mapping.

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index 5371f4985fd06..46bf4df65974f 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
[ ... ]
> +static int virtsnd_pcm_dma_pages_get(struct virtio_pcm_substream *vss,
> +				     u8 *data, size_t length)
> +{
> +	size_t i;
> +	size_t npages;
> +	size_t span;
> +
> +	if (!data || !length || !is_vmalloc_addr(data))
> +		return -EINVAL;

[Severity: High]
Does this check break NOMMU architecture support?

The VirtIO sound driver uses SNDRV_DMA_TYPE_VMALLOC for its PCM buffers.
On NOMMU architectures, vmalloc() typically falls back to kmalloc(), and
is_vmalloc_addr() unconditionally returns false.

Because of this, the new is_vmalloc_addr() check in
virtsnd_pcm_dma_pages_get() will unconditionally fail with -EINVAL on NOMMU
systems, preventing the allocation of PCM messages and breaking audio
playback and capture.

Prior to this patch, vmalloc_to_page() was called directly without this
check, which safely translates the kmalloc address via virt_to_page() on
NOMMU. Can this validation be adjusted to support NOMMU configurations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791867377.gi=
t.mynameisjune111@gmail.com?part=3D4
