Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176211;
	b=uL1CnzgRo9Apyfwvs97FFD2jfXeGTPOWtzRItJR8mrXjZn2qqkoLuyKndYjxtCPVBXAz
	 CcPiu/WPgPZjnu7xf8gVyWYy7D8zDf4YeiDJNjK4iLKG0aWNoTUkl4za4t+4UdxIn9fru
	 r7pssxpnVe4y1PJOWtOioNWtdy/jYGPyKKihgLWyM01vKBOq1a48gNlS3xEWIeSgi2ZFP
	 sqbznt5JMTpauua4bXNNVlW8dU4VmfVIOXnoAUHuYsVFec0vkvjAH0uY3akEjcn13knf6
	 I9z/OLfQgpHNCZubjTpqlaOI7T3/ovi16ZjoSRDr9YLn6hJ8yxyoMvGNd2NbESMMoZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176211;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JpbgjL4knLgXBglW8ypDg+v8ydY1t6Op1Mpp+OkMS2o=;
	b=qrXk838KqRiTrf5e5JgpNniAesTS3tWph/qkO/4db1gDMV/RXA2ChzuuGtKHhsvWQpAU
	 3Xm+rKjW45EWIHRQ5lvvBEVg2hOdTVXwjFdsTlWFix0TkMynzf1riqFfHbilraUmN2y9h
	 j8jfS4oh32dnYX3qTvhr9n+RgejVXYue62adxEZBIWqutbWlQEH9/1qT5zIhr1M2xVqmp
	 8+Z9j6M5q/Z+Y0IC03Bdws0UfwARGOkT2Te9qBHD/FZM+xBNfyQINL3KEy9g9VLQniBSj
	 ip/AYVlWCoe00xkHcvDNWWulwV61S2plKcMTR1grSFPOU6C09jcW0ffzi+s3JRvOUpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vn0+NOAZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5D1606A32C
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vn0+NOAZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37031F000C0;
	Fri, 20 Nov 2026 12:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176211;
	bh=JpbgjL4knLgXBglW8ypDg+v8ydY1t6Op1Mpp+OkMS2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vn0+NOAZAfopI1A1pgN2iZwg5fiq+6haVEGBl6P/tCPbfv+e5mLHIatFy0/p4ztau
	 Ay9Dq2/p5qU0F4FA4EhThhYzloGkTeHqCW7jq4/RDl1PSlxJReiI24iS9Nsaa2nidq
	 BkonfAnQUxtCBg+vVvrutJTXZKL2EGznAbKehoB9mwrgu64gd6G9OxGn2cdHpSBpnn
	 /i5rB4MEDSfVI0PRXx16ON7jCShhXC/60RKHIaKeuey1UBjnaUrXV8j7UadaIh6oCl
	 scPbM8Hb93ryn2VLGRHWne785ZxAptUpD3Rok2aGiCfTNfn6vkdi8yKEvgYR8aqsV9
	 QayHN0UlxxjYQ==
Message-ID: <sashiko-outbox-225115@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 6/7] virtio_balloon: add DEVICE_INIT_REPORTED
 feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Brendan Jackman" <jackmanb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Suren Baghdasaryan" <surenb@google.com>, "Jason
 Wang" <jasowang@redhat.com>, "Andrea Arcangeli" <aarcange@redhat.com>, "Dev
 Jain" <dev.jain@arm.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Greg
 Ungerer" <gerg@linux-m68k.org>, "Gregory Price" <gourry@gourry.net>,
 =?utf-8?b?SHVhbmcsIFlpbmc=?= <ying.huang@linux.alibaba.com>, "Lance Yang" <lance.yang@linux.dev>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Magnus Lindholm" <linmag7@gmail.com>, "Matthew
 Wilcox" <willy@infradead.org>, "Miaohe Lin" <linmiaohe@huawei.com>, "Zi Yan" <ziy@nvidia.com>, linux-mm@kvack.org, virtualization@lists.linux.dev, "Jason
 Wang" <jasowangio@gmail.com>, =?utf-8?b?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, "Xuan
 Zhuo" <xuanzhuo@linux.alibaba.com>
In-Reply-To: <65c518234ce31fac3f6ed436455dcb415d4b1189.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
 <65c518234ce31fac3f6ed436455dcb415d4b1189.1795089715.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:03:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] virtio_balloon: 32-bit used length overflow in
  virtballoon_free_page_report()
- [High] virtio_balloon: stale PG_zeroed flag on free pages across
  hibernation resume
- [Medium] virtio_balloon: missing feature dependency checks in
  virtballoon_validate()
--

commit 45401c714e001e18d0bb9e4b0f46a6691e93f0cb
Author: Michael S. Tsirkin <mst@redhat.com>

virtio_balloon: add DEVICE_INIT_REPORTED feature

This commit adds support for the VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED
feature, allowing page reporting to mark reported pages as zeroed when the
host initializes them on reclaim.

> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 8c1b47ec17a29..4c6630c5f9599 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
[ ... ]
> @@ -205,7 +206,9 @@ static int virtballoon_free_page_report(struct page_r=
eporting_dev_info *pr_dev_i
>  	struct virtio_balloon *vb =3D
>  		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
>  	struct virtqueue *vq =3D vb->reporting_vq;
> -	unsigned int unused, err;
> +	struct scatterlist *entry;
> +	unsigned int len, i;
> +	int err;
> =20
>  	/* We should always be able to add these buffers to an empty queue. */
>  	err =3D virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT);
> @@ -221,9 +224,24 @@ static int virtballoon_free_page_report(struct page_=
reporting_dev_info *pr_dev_i
>  	virtqueue_kick(vq);
> =20
>  	/* When host has read buffer, this completes via balloon_ack */
> -	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
> +	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> =20
> -	return 0;
> +	if (!pr_dev_info->host_zeroes_pages)
> +		return 0;
> +
> +	/*
> +	 * Only a fully initialized batch may be marked reported when reported
> +	 * pages are treated as zeroed. A short completion does not identify
> +	 * which pages were initialized, so reject the entire batch.
> +	 * Subtract each entry to avoid overflowing a total-length accumulator.
> +	 */
> +	for_each_sg(sg, entry, nents, i) {
> +		if (len < entry->length)
> +			return -EIO;
> +		len -=3D entry->length;
> +	}
> +
> +	return len ? -EIO : 0;
>  }

[Severity: High]
Can virtqueue_get_buf() ever return a len large enough for a batch of 4 GiB
or more?

The Virtio used ring stores a 32-bit __virtio32 len field, so len is at most
U32_MAX (4 GiB - 1).  On CONFIG_ARM64_64K_PAGES, MAX_PAGE_ORDER is 13
(512 MiB per block) and capacity is up to PAGE_REPORTING_CAPACITY (32), so a
single scatterlist batch of 8 or more order-13 blocks totals 4 GiB to 16 Gi=
B.
For any batch of 4 GiB or more, subtracting entry->length from the 32-bit l=
en
always hits len < entry->length and returns -EIO, causing
page_reporting_cycle() to abort without marking the pages reported and retry
the same blocks on every reporting pass.

> @@ -1043,6 +1061,9 @@ static int virtballoon_probe(struct virtio_device *=
vdev)
>  #if defined(CONFIG_ARM64) && defined(CONFIG_ARM64_64K_PAGES)
>  		vb->pr_dev_info.order =3D 5;
>  #endif
> +		if (virtio_has_feature(vb->vdev,
> +				      VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED))
> +			vb->pr_dev_info.host_zeroes_pages =3D true;

[Severity: High]
Does enabling host_zeroes_pages leave stale PG_zeroed flags on free buddy
pages across hibernation resume when want_init_on_free() and
page_poisoning_enabled() are false?

During hibernation snapshot creation, free buddy page frames are excluded
from the image, while the vmemmap pages containing their struct page entries
(with PG_zeroed set by page_reporting_drain()) are saved.  During resume, t=
he
boot kernel uses those free physical page frames as temporary safe pages for
struct pbe chains and image buffers, and swsusp_arch_resume() restores the
saved struct page entries with PG_zeroed still set.  Afterward,
clear_or_poison_free_pages() only zeroes free pages when
page_poisoning_enabled() or want_init_on_free() is true:

kernel/power/snapshot.c:clear_or_poison_free_pages() {
    ...
	if (page_poisoning_enabled() || want_init_on_free()) {
		memory_bm_position_reset(bm);
		pfn =3D memory_bm_next_pfn(bm);
		while (pfn !=3D BM_END_OF_MAP) {
			if (pfn_valid(pfn))
				clear_or_poison_free_page(pfn_to_page(pfn));
    ...
}

In the default configuration where both are disabled, post_alloc_hook() and
vma_alloc_zeroed_movable_folio() see PG_zeroed set and skip zeroing, handing
dirty resume-kernel memory to __GFP_ZERO allocations and userspace page
faults.

> @@ -1189,6 +1210,11 @@ static int virtballoon_validate(struct virtio_devi=
ce *vdev)
>  	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
>  		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
> =20
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) ||
> +	    page_poisoning_enabled_static())
> +		__virtio_clear_bit(vdev,
> +				   VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);

[Severity: Medium]
Should virtballoon_validate() clear VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED
when VIRTIO_BALLOON_F_REPORTING is not set, and keep VIRTIO_BALLOON_F_REPOR=
TING
enabled when want_init_on_free() is satisfied by
VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED?

If VIRTIO_BALLOON_F_REPORTING is absent or cleared above,
VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED remains set in vdev->features_array,
which can cause virtio_features_ok() to fail probe with -ENODEV on a device
that requires VIRTIO_BALLOON_F_REPORTING as a prerequisite.  In addition,
when want_init_on_free() is true and page_poisoning_enabled_static() is
false, the check above clears VIRTIO_BALLOON_F_REPORTING if the device does
not offer VIRTIO_BALLOON_F_PAGE_POISON, even when
VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED guarantees zeroed pages.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795089715.gi=
t.mst@redhat.com?part=3D6
