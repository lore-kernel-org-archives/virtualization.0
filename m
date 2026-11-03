Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721000;
	b=1xrFR5IFSfxFq/JI0/DhvPh82Jpmlc6AYLLtbs3sJ3FjrUXolzWLo90CTPNbV1ewJsDX
	 JM6ii6WC4JQchNmfaVqp/Kj5zxfmyBkXfDhpPg/tXciqUhxSeMib0Ri+YzmBC8erNYK32
	 N6FFnPcPdF/OS/qWYeNRD8qjgnWmByw60tMpiPMa9KJdn6UgAzWgi3R/cwrQYL1lMBmIZ
	 Oi3+ywMyaFriZDkhJd4qb0GeM9zWWDn8YDmzVqCTHiMleX1wdAenOzs0zBN03k8tOWkE2
	 qAH5rORyyvk553z+CfIaFLZ36KqPKFpElwFxhvb7t7SxzA8a9swHPi0imBMlgr3Z02w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721000;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CzNm5ufLEkKiD+9WE1yeAdszs6ektB4d5s/qATYQLj0=;
	b=t24VRi0IHzCaIak6K6imzFOC/OwNlNxQ0JxfOrk0RvGPAvDiABSsNJfa+uAcXahRvnMz
	 jzznpLZGD8qFrvE7bZReqIsi+7uXciIoTzVVnNxPdlx+AxtnBcpfzIqId7lZ+KR8hok2l
	 wY+dQBwq4dwz/YEXDiKg5N5du8LB1gyWf6Ng4IMnjyqQKYDripTHgxJZQ4xpIubkrs4rZ
	 YW/VSw16S7wJNLwnaxLcgK7JlmAZN5ulcSZZqqvbUEia/ftTXbXGVOpbWk+PeMYLk7Mtg
	 +VWLl1ckWlokXGAtybuRBDCb9DSES1WGxvHerFnfpCLNxeSDVb1qepcDQJA/jbICZ1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eR1CMRLH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B17606A327;
	Tue,  3 Nov 2026 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eR1CMRLH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4761F000C1;
	Tue,  3 Nov 2026 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720999;
	bh=CzNm5ufLEkKiD+9WE1yeAdszs6ektB4d5s/qATYQLj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eR1CMRLHZ6qwAOnNvevFZIH1aw1Y4+Q65qn6p5t7di6xeMEoSc8z+kVArdQqN+Ecg
	 0gP6tJSRbd4xWI+1Ah2yQJ9hIQRu2fx7EEc7koBrdD5kumug6UZBmulmllMC7caT5Q
	 V2eA0BVMZ4ipO98RnrwBeHsukwHG5m0NtsmMc7N74d9i8a04ztdD8Iver9bmq7HS+B
	 z6QEzU8e5J6LndIwddFpvOHb/Tvsm5Dq9O+gFPUXY6UbqYcYgIFJkSOPFTnijTC7ss
	 vOzPVolhAq5ntJe8AxC35JLMjJWQ1QZPkUCK4tp4cGr2pHuXWjLybyFRaLTX6RcU8K
	 Ax0ietBedshQg==
Message-ID: <sashiko-outbox-195658@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] of: Add support for "iommu-ranges" on a device
 node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikash Garodia" <vikash.garodia@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-add_iommu_ranges-v6-2-361f3921a133@oss.qualcomm.com>
References: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
 <20261103-add_iommu_ranges-v6-2-361f3921a133@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:49:58 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] iommu: of_iommu_derive_resv_regions() corrupts iovad->anchor o=
n 32-bit LPAE
- [High] iommu: of_iommu_derive_resv_regions() PHYS_ADDR_MAX end overflows =
merge
--

commit 138d9a14b5fdb2f77facac6b1fa8a670c0862071
Author: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

of: Add support for "iommu-ranges" on a device node

This commit adds support for parsing the "iommu-ranges" device tree property
on a device node to derive reserved IOVA regions outside the usable ranges,
and restricts "iommu-addresses" on reserved-memory nodes to identity mappin=
gs
backed by a "reg" property.

> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 5c266511db789..0428ceb50dec5 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -185,11 +185,118 @@ iommu_resv_region_get_type(struct device *dev,

[ ... ]

> +static void of_iommu_derive_resv_regions(struct device *dev, struct list=
_head *list)
> +{

[ ... ]

> +	list_for_each_entry_safe(pos, next_range, &ranges, node) {
> +		if (pos->start > next) {
> +			region =3D iommu_alloc_resv_region(next, pos->start - next, prot,
> +							 IOMMU_RESV_RESERVED, GFP_KERNEL);
> +			if (region)
> +				list_add_tail(&region->list, list);
> +		}
> +
> +		if (pos->end =3D=3D PHYS_ADDR_MAX)
> +			goto exit;
> +
> +		if (pos->end >=3D next)
> +			next =3D pos->end + 1;
> +
> +		list_del(&pos->node);
> +		kfree(pos);
> +	}
> +
> +	region =3D iommu_alloc_resv_region(next, PHYS_ADDR_MAX - next + 1,
> +					 prot, IOMMU_RESV_RESERVED, GFP_KERNEL);
> +	if (region)
> +		list_add_tail(&region->list, list);

[Severity: Critical]
On 32-bit systems with 64-bit phys_addr_t and dma_addr_t (such as ARM LPAE
with CONFIG_PHYS_ADDR_T_64BIT=3Dy), can reserving this trailing region up to
PHYS_ADDR_MAX corrupt iovad->anchor and lead to slab corruption when the
IOVA domain is freed?

In of_iommu_derive_resv_regions(), the trailing reserved region is allocated
with start =3D next and length =3D PHYS_ADDR_MAX - next + 1, giving it an
inclusive end address of 0xffffffffffffffffULL.

When a device attaches to a DMA domain, iova_reserve_iommu_regions() in
drivers/iommu/dma-iommu.c reserves each region:

    lo =3D iova_pfn(iovad, region->start);
    hi =3D iova_pfn(iovad, region->start + region->length - 1);
    reserve_iova(iovad, lo, hi);

Because iova_pfn() returns an unsigned long (32-bit on 32-bit architectures=
),
shifting 0xffffffffffffffffULL right by iova_shift(iovad) and truncating to
unsigned long yields hi =3D 0xffffffffUL, which is IOVA_ANCHOR (~0UL).

In drivers/iommu/iova.c:reserve_iova(), the upper-bound check compares
32-bit unsigned long values against (ULLONG_MAX >> iova_shift(iovad)), which
does not trigger on 32-bit LPAE. The rbtree walk then finds &iovad->anchor
(where pfn_lo =3D pfn_hi =3D IOVA_ANCHOR):

    for (node =3D rb_first(&iovad->rbroot); node; node =3D rb_next(node)) {
        if (__is_range_overlap(node, pfn_lo, pfn_hi)) {
            iova =3D to_iova(node);
            __adjust_overlap_range(iova, &pfn_lo, &pfn_hi);

__adjust_overlap_range() overwrites iovad->anchor.pfn_lo with lo. Later, wh=
en
put_iova_domain() tears down the domain and calls free_iova_mem(&iovad->anc=
hor),
iova->pfn_lo !=3D IOVA_ANCHOR is true and kmem_cache_free(iova_cache, &iova=
d->anchor)
is called on the anchor embedded inside struct iommu_dma_cookie.

[Severity: High]
Does setting the trailing reserved region's end to PHYS_ADDR_MAX also cause
unsigned integer wraparound in iommu_insert_resv_region() when merging
group reserved regions?

When iommu_get_group_resv_regions() merges device reserved regions through
iommu_insert_device_resv_regions() -> iommu_insert_resv_region() in
drivers/iommu/iommu.c:

    top_end =3D top->start + top->length - 1;

    if (iter->start > top_end + 1) {
        list_move_tail(&iter->list, &stack);
    } else {
        top->length =3D max(top_end, iter_end) - top->start + 1;

First, when top is a reserved region ending at top_end =3D=3D PHYS_ADDR_MAX,
top_end + 1 wraps around to 0 in phys_addr_t arithmetic. Any subsequent
overlapping IOMMU_RESV_RESERVED region with iter->start > 0 satisfies
iter->start > 0 and fails to merge.

Second, if a reserved region starting at top->start =3D=3D 0 is merged with=
 an
overlapping or adjacent region ending at iter_end =3D=3D PHYS_ADDR_MAX (for
instance, when two devices in the same IOMMU group have disjoint usable
iommu-ranges), max(top_end, iter_end) - top->start + 1 evaluates
PHYS_ADDR_MAX - 0 + 1, wrapping top->length around to 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-add_iommu_=
ranges-v6-0-361f3921a133@oss.qualcomm.com?part=3D2
