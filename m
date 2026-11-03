Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720771;
	b=oUCVoqPi3STQbmH0JglYDOEwpkSCSBIvgCaNbmFfp9vI/EK15EVPd7xGJnekXencKpyq
	 TkatA+XkIOcW4lVdBi4xS2Nh79VNsnmAhnN5h5FVW/Kuq7vKbCYKyLI7MGzoHy3KjDcQ9
	 IDndta3KmHto3Aaz0YPGgD5zWK/gDDitficiPBeU5RiA2AZhvsDsEqamAv9zRqrbo3ALw
	 +dqWmoZ1NhcGoFVnCmw5NHAR/INWFCFVfblwxyt254SrmfFobXY1ch+MDr8xnR5BZgXrh
	 lA8sqrV1DWkwxOJiEK3mB4eKBhPjpBYVbdYdFmRYn80P+i+kpmA7F5RBcYleZmp2hsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DYsODiAhje7z6bFcc/4RMfdYI5s1Q1KfIOEcoW8R254=;
	b=p3tHzmI5hk5EcJ2KeesXzOIYKM3C42h0DPiB7oukF8xCdOXBN6bdj9lfHUZS74lldvrM
	 7C+hc1Fs0uA0i1h1hnKsg4at8+9vmWU833HDXj+oHRMwmJTZKvjCiw6Jy6ZFmxuhHaV8v
	 oBnF9tTq3w579sshR69B/7hlhSzvcTT3zbNh+ro72gso/pC+CgXMVyp4rKJiGOXkKs0C9
	 E5K/EDviZsxL9fSxLIXC/5gBWWqDo2DAeKxZ7unnEnKfrI8yPcw6IlTT+1+gBv4DtTWBS
	 Ret+SL1np8ws73TP8rM+39/bWi8QnkuyqVT2BQ5vDOxPVKWNgzdmzMbF5c+QHC6ojKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDFBinAa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC135606A324;
	Tue,  3 Nov 2026 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDFBinAa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151341F000C1;
	Tue,  3 Nov 2026 15:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720770;
	bh=DYsODiAhje7z6bFcc/4RMfdYI5s1Q1KfIOEcoW8R254=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RDFBinAaQVPScwQr1QspCwP4lXTLdHfJbOYg2rd8n2L53rwNy9bGMreXNXWhqeHai
	 zWl23ASVs8voHknLU/LN2fq2h9F1K+VF3+lJ0tRJvxAl8yFLVT0QVgibDzkVT6IE/P
	 eyZWWv22WkhgkcYv+CJoHiuqhQ8fCT6f4VpmSw6JTQexGN9zTCTXg8KFZk/2ijzA17
	 IGittD4PWhgxE0pEpdGSRST1mHkKKeSgEwTkHEbc3vd41IEniFYkz7GV2nSMt5NH9g
	 Snlx55bkAIBcgUjBRJK9i/c1lIbJJlCgoupQcui3y8MW/IERYpAWB/yzSm/5Doxi0h
	 VCmn9+dqYJ7Tg==
Message-ID: <sashiko-outbox-195650@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] iommu: use resource_size_t for reserved region
 length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikash Garodia" <vikash.garodia@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-add_iommu_ranges-v6-1-361f3921a133@oss.qualcomm.com>
References: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
 <20261103-add_iommu_ranges-v6-1-361f3921a133@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:46:09 +0000
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
- [Medium] vfio/type1: truncation of region->length in vfio_find_dma() on 3=
2-bit LPAE
--

commit 0e9e6ab1dd5582c6a157191dbe1e262f13c108a9
Author: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

iommu: use resource_size_t for reserved region length

This commit widens struct iommu_resv_region.length and related helper
parameters from size_t to resource_size_t so that reserved regions of 4GiB
or larger are not truncated on 32-bit systems with LPAE.

[ ... ]

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ef5043752a365..1d8f9381a358e 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -306,7 +306,7 @@ enum iommu_resv_type {
>  struct iommu_resv_region {
>  	struct list_head	list;
>  	phys_addr_t		start;
> -	size_t			length;
> +	resource_size_t		length;

[Severity: Medium]
Now that region->length can hold values of 4GiB or larger on 32-bit LPAE
systems, could it still get truncated when passed to vfio_find_dma() via
vfio_iommu_type1_attach_group() -> vfio_iommu_resv_conflict()?

In drivers/vfio/vfio_iommu_type1.c, vfio_iommu_resv_conflict() passes
region->length directly to vfio_find_dma():

drivers/vfio/vfio_iommu_type1.c:vfio_iommu_resv_conflict() {
	list_for_each_entry(region, resv_regions, list) {
		if (region->type =3D=3D IOMMU_RESV_DIRECT_RELAXABLE)
			continue;

		if (vfio_find_dma(iommu, region->start, region->length))
			return true;
	}
}

However, vfio_find_dma() still takes size as a 32-bit size_t on 32-bit LPAE
systems:

drivers/vfio/vfio_iommu_type1.c:vfio_find_dma() {
static struct vfio_dma *vfio_find_dma(struct vfio_iommu *iommu,
				      dma_addr_t start, size_t size)
{
	struct rb_node *node =3D iommu->dma_list.rb_node;

	WARN_ON(!size);

	while (node) {
		struct vfio_dma *dma =3D rb_entry(node, struct vfio_dma, node);

		if (start + size - 1 < dma->iova)
...
}

If an IOMMU group with a reserved region of 4GiB or larger is attached to a
VFIO container on a 32-bit LPAE system, region->length will be truncated to
32 bits. When region->length is a multiple of 4GiB, size becomes 0,
triggering WARN_ON(!size) and miscomputing start + size - 1; for other
sizes >=3D 4GiB, the upper portion of the reserved region will not be check=
ed
for conflicting DMA mappings.

Should the size parameter of vfio_find_dma() (or a dedicated range helper)
also be widened to resource_size_t or dma_addr_t?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-add_iommu_=
ranges-v6-0-361f3921a133@oss.qualcomm.com?part=3D1
