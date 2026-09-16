Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F93D9DAC;
	Wed, 16 Sep 2026 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595771; cv=none; b=At5xaSODSp7kYWayGEBx3JWyafJRF1PeuGWwLn7LJHpp/Ek/GzHwZDgpO5NB/3AKnxcCBQDr8kezvoEWjF6qLvLzjSNbd0r6lGCFOey0Fm+UtBjO9ac5klMHj5thXXbNTdwISyBGWxD1lFNW8cNk7Wb0Z0SZzhQZQ/2YChiuH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595771; c=relaxed/simple;
	bh=kxL/KTIrFrxfLTJnkEaZ5/lFJp6PdSr11dbiSnYkx2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FMrEB78QlH7kUgGgr4pLyseB4PrEj3EVwbDCUg8GVZ08/vPCFGrOBtMXTk2UgZaZbhYe0OP+ZkQIyddLxM/0yqEjAp58DPk4tRtLYmPHPfNFS5TLrG8SomUGMvMkFCGUi51Jq2Qn+MzbuJ7Llh5jD5Kd+2xkO8Z8s9YqeZJ+H64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUqgRwBd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUqgRwBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03051F000FF;
	Wed, 16 Sep 2026 21:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789595756;
	bh=2br22E5jCA+g7CeaKH91Zr+c5Avsr8LMfV6qR+aG3eA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hUqgRwBdz+0kDdTdz21mQmKmcoi18HmqwztFoFsatfmCLqOMkyDTuclyK0GHedkB7
	 t0CjsmCqsw9vy1S0zB2wWU3DZxxVzko5jQWhouYZ/6bddS3Kkn4HwQ40b9xEnghCtz
	 4BXciUpQsYYkn0cjEOxnCPdSTpomo+Rupv4RY2VHRO8WW5QfMc20KQh35a5BIjcTPe
	 DRnaLD0cUlyCO7doxUe9XJPELobeHXZlaeN3DoiDtqgYK5WXfbCvOqmVrXhslt6AuY
	 RBugj0uZiE2wCZ+8fckOhHu3tAGBm2xDOsQr2DygTxl/Y9Xkk3Yt1ERIjgdyhCxMmJ
	 vH/qLfBgIY0NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/12] dma-coherent: add base and size APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: devicetree@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, Frank.Li@kernel.org, robh@kernel.org, conor+dt@kernel.org, imx@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260916-remoteproc_virtio_map-v1-4-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-4-dac8c5eb4aa9@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:55:55 +0000
Message-Id: <20260916215555.F03051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dma: integer overflow in dma_dev_coherent_size()
--

commit c7a3821680bbb5546ff7e7a9e6fe376429788c67
Author: Francesco Valla <francesco@valla.it>

dma-coherent: add base and size APIs

This commit adds two new APIs, dma_dev_coherent_size() and
dma_dev_coherent_base(), to retrieve the size and base address of the
coherent memory pool associated with a device.

> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index 45bbae947f4be..f4aa5813604b8 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
[ ... ]
> @@ -277,6 +277,40 @@ int dma_mmap_from_dev_coherent(struct device *dev, s=
truct vm_area_struct *vma,
[ ... ]
> +size_t dma_dev_coherent_size(struct device *dev)
> +{
> +	struct dma_coherent_mem *mem =3D dev_get_coherent_memory(dev);
> +
> +	if (!mem)
> +		return 0;
> +
> +	return (mem->size << PAGE_SHIFT);

[Severity: High]
Could this left shift overflow for large coherent pools?

If the pool size is 2GB or larger, mem->size (which is an int representing
the number of pages) will be >=3D 524288. Shifting a signed 32-bit integer =
by
PAGE_SHIFT overflows in this case, and the result incorrectly sign-extends
when implicitly cast to size_t.

This might cause the function to return an astronomically large size_t value
instead of the actual pool size, which could lead to out-of-bounds accesses
or allocation failures in callers trusting the returned size.

Would casting mem->size to size_t before the shift prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-remoteproc=
_virtio_map-v1-0-dac8c5eb4aa9@valla.it?part=3D4
