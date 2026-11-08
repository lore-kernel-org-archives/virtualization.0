Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794116477;
	b=oZzlycrTYv2JXBtRIM2mT9+PRzWK0NvLlT61IA+rPQyUyBLvLy6bPBgTeysLhrZK63Sr
	 vrFE2VOOvROBbWoA1VVDIITR+2ft1eSZys6+H1I0cquqasBapg1nzz9m5WRm2BO2W21rY
	 PFHvTz5M9Wy91sEkUHiW1zk9XEJeb80DMAbgrXIhfTv6WUYVxzm9F46Xuy2fRYI70DWBC
	 QEsv62BL/PR5fcdsMppikTXmMulFoiEB3vkCFeK1bJzMuuV7o6oVst/1tqneFmKiKsDlA
	 n/IowHrOKkCvyQAlYrpUZe3MX8o1mS5TDEx+E6CZSSYFRwjgJ2SuDggnjmNtQZpBkYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794116477;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Y4BnRauqxdriNjwPu4pmz4HUBHW9FKJ4IoblZFFndPo=;
	b=Kf57+TTyAlDbsT0KDXxygCherh7mcGuFgda0hjLZyVnoL5CwFJpGMvXNJn1TLmx0FjfD
	 yz/oKg2CXyuGQtGTvuuFVXdSKsAX7wUOHfZoJOUVr9oqw/aBsy+aA9WZEjQP+7piJQLTn
	 9EqID1cnqBLib2UeD+knXakUebNIm6i7ZZrvYPddWAYcUGmOCzJ3q0zguhuTCeix9v4+X
	 Da5sASLwSiU+tpAoo912O30c1APEWu2LyQhuJcXdbZAcaIbKjA09xDlgoV5FTfRpT99VD
	 +pUs5H57Ds4AvKYdl59R3/QqA3H72zpWEBkNi0g6HPeFdNHFKBz+75FlSXf05GZ9BRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f9z7/u1+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B38F606A31A;
	Sun,  8 Nov 2026 05:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9z7/u1+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188A51F0089F;
	Sun,  8 Nov 2026 05:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794116477;
	bh=Y4BnRauqxdriNjwPu4pmz4HUBHW9FKJ4IoblZFFndPo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f9z7/u1+Z4WkFL1MGxY8DDM31eyxR8d5T1CUogoA30rKuuwWB3yX6ZP7reeJjpqJk
	 jHBFwQgPg+1Ug1GvFFOKnOYckttmv5rrSZB+C5ev0qIF2z0+UngPrndZ7K9d64Ipjt
	 Y4cYz0TYtAusxC4ly+ddp4B1xXZ5jhg+4RY1Pq0Qh939hpTGBDx2BgKkjzpZu1izBg
	 MgsJqOppvP6iUhrg3ojnXkDpSKPL+WlpKezmCaNbgJUbmfrwtB7ri9qr5vZDGP23L9
	 DzX2GzYiMX1x11YwhVnlt+3/Sp29p+rXDRxIvTCbHp7s4W+HsOCOWwJpnUNDk2POqy
	 l4Gb+mFw4U6Rw==
Subject: Re: [PATCH net 1/2] virtio_net: Don't DMA map the kernel image for
 the AF_XDP TX header
From: netdev-bot+sashiko@kernel.org
To: yanhaishuang@cmss.chinamobile.com
Cc: mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, virtualization@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 05:41:15 +0000
Message-ID: <179411647562.994134.8636776015987575971@kernel.org>
In-Reply-To: <20261107125723.33547-2-yanhaishuang@cmss.chinamobile.com>
References: <20261107125723.33547-2-yanhaishuang@cmss.chinamobile.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message's second reason for the change does not match
  what the patch does.

--

virtio_net: Don't DMA map the kernel image for the AF_XDP TX header

This patch removes the static xsk_hdr that lives in the kernel image. In
its place, virtnet_xsk_pool_enable() now kzalloc's a header for each send
queue, and virtnet_xsk_pool_disable() frees it. The point is to stop
virtqueue_map_single_attrs() from rejecting the mapping on arm64, where
the kernel image sits in the vmalloc area.

> and binding an AF_XDP zero-copy socket fails with -ENOMEM. Even where
> the mapping succeeds, the header shares cache lines with unrelated data.

[Severity: Low]
Does the second sentence here match what the patch does? It reads as
though the patch also gives the header its own cache line.

virtnet_xsk_pool_enable() now uses a plain allocation:

    sq->xsk_hdr = kzalloc_obj(*sq->xsk_hdr);

This is a small object of about 24 bytes, the size of struct
virtio_net_hdr_v1_hash_tunnel. It has no cache-line alignment or padding.

__kmalloc_minalign() in mm/slab_common.c can also lower the kmalloc
minimum alignment:

    if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
        is_swiotlb_allocated())
            minalign = ARCH_KMALLOC_MINALIGN;

So the new header can still share cache lines with other slab objects.

The header is also mapped DMA_TO_DEVICE only. That means sharing a cache
line would not cause a correctness problem for this mapping in the first
place.

Could this sentence be dropped, or reworded so it doesn't suggest the
patch provides cache-line isolation? The main reason given, the vmalloc
rejection on arm64, looks correct.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107125723.33547-1-yanhaishuang%40cmss.chinamobile.com
