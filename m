Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39603358D04
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769655357; cv=none; b=Ge/Bu9wLf6tMn3pInw9qc6bqXXBTOmtq9JtDfLZqViHMcFWQrG2y0/M9o1M6Jk7ESQ6t04xFYpBSLxrZXi2X8Mho0UgH75/k4tzO7L5P/tP/u7PUr5AB945I6agG2tsUG6scsgAB3xM3ybXSUqKa2bSn3moVPudu1dZ6TJIKo8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769655357; c=relaxed/simple;
	bh=8WHLTkIFY9R865s0/M6Z7RuX05rqpNFQ6Nu/ELhE7N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ6a7XArbn1A6vU6p1ZqVWxTkl7FWRp82J8XkTfsUVsfEyAuUy5nNuxSyaUTgw8mtkxQYLsuOeCUJj5k7fT5XKpFojGDvYqlg1SdYfmMyFjXrV73fREkkhiuI7HNO+jHo7CJzRT2Bd7NdByVp1eaR1mbWO6J+e1dclYjUg4Aljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwepzzJk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwepzzJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769655348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=laTNjwzjXI7QepEnGjmg2CpRxzpsO5Laq3qTT9ZtSVU=;
	b=JwepzzJkyNlh+mS5FTI0xjJcaaaDDonEkajITZfFURS0X8ToxduFCK1Eg9i6uxJ+g56j0l
	u/RwfBYM1YthNbvnFv6RIITKuLsw+m+kChBDUo3HafkPrNXEvRtWABPC2MrP+7Nhy9PBpG
	SrI1GzwxC/fnsibwTcuFtIWIpU/36G8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-heCQbmbvO_GQFkTZDbv5Lw-1; Wed, 28 Jan 2026 21:55:47 -0500
X-MC-Unique: heCQbmbvO_GQFkTZDbv5Lw-1
X-Mimecast-MFC-AGG-ID: heCQbmbvO_GQFkTZDbv5Lw_1769655346
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so676498a91.0
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 18:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769655346; x=1770260146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=laTNjwzjXI7QepEnGjmg2CpRxzpsO5Laq3qTT9ZtSVU=;
        b=txHYJMWDn1Rd1g+HXBfLEgyMVkbjDwOMtU2DncoLjNEJu5umisLQH70iMbHk4OjUld
         FdT6J55/w8OGhm19eW2hIS+VjNwBIoXzsfKPrIB71zZBu9JU9spwAr9pOqHKxKKsD74+
         AuICU8YFQmnn19F8RkyyOmVgEJBwR3j4JE+vTPavyHn6eCjcIpDlichq5i2vzW8DyWDU
         8OOifaSwlsenclJ1/oxlKpiYvbi12GJERwuTqNcee60rxX94iKhjSD11qJr7paqDGsan
         HjwjIBvuUfIZf1OXG/M0IjdQBcZ0Pl9A5wpGDwCqSjXTAbQ++OwaKzSEAlpL0EecLSn2
         PXgg==
X-Forwarded-Encrypted: i=1; AJvYcCWkk+UqYebRKKoKF3ptfH49Yo/5lRgThs0MH+NrRUuuGKueRU3ND7i1An3UXkco3jh4todeaPVBVkUgU1d3pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjkYwWlij57ZpEYF0f3palI6t1A1+YRb2B+303WWOIoX4WUk13
	bPN7m1HvFhJYbCtDrW8g1p8nwwDlIbzsU0qrPJiAHute8KaPvLDpaK3AErnwTSBcekq3cSzTuux
	8clX33jXwi2xJCrnboloK3OyNRsXp+mJcoP0kzEXKmfhcxvBwoTh7xpxtdD0KDGzpfzzBmceeyj
	JIV8U7vFqz9gio9F5A6BRMSRMFnuCfjPDW0CmVQozXuOs=
X-Gm-Gg: AZuq6aLtlcWVQPe/CUWfwvWRv9e2YB7EXL0IENCXJGaZGtUJiyTS86AGQH6uLuRm/bb
	cZACXdBP0b9l9i9QeVdyaz9FCMLKfdlOKHf9cwFKu4Baq/rAGZEdwo+XUWn5bkJRwPXqyS0Jf9p
	2f/8vPM8yIDtCmPGsZWsHBd4MruQlEhMEGFpKSCsiO5g2k3rLNuj39y5BNzX/6C1vV
X-Received: by 2002:a17:90b:1fce:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-353fed7583dmr7398710a91.23.1769655345894;
        Wed, 28 Jan 2026 18:55:45 -0800 (PST)
X-Received: by 2002:a17:90b:1fce:b0:33b:bed8:891c with SMTP id
 98e67ed59e1d1-353fed7583dmr7398682a91.23.1769655345448; Wed, 28 Jan 2026
 18:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128212031.1431746-1-vishs@meta.com>
In-Reply-To: <20260128212031.1431746-1-vishs@meta.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jan 2026 10:55:33 +0800
X-Gm-Features: AZwV_Qh3rU3z9hasWrlauUxdKQvDrk_izc_BcKGtFI-jPDEG4gU-QARYYCm_XLY
Message-ID: <CACGkMEvYv-gJFDtQMWgfA9BfsfMQjn+xbqg4cgDET9eXrcRwvA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/2] virtio_net: add page_pool support
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bUCrYBxg-XqeHmoC5TaUfUJ6cW3kOBBXXVroyFRubq4_1769655346
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 5:20=E2=80=AFAM Vishwanath Seshagiri <vishs@meta.co=
m> wrote:
>
> Introduce page_pool support in virtio_net driver to enable page recycling
> in RX buffer allocation and avoid repeated page allocator calls. This
> applies to mergeable and small buffer modes.
>
> Beyond performance improvements, this patch is a prerequisite for enablin=
g
> memory provider-based zero-copy features in virtio_net, specifically devm=
em
> TCP and io_uring ZCRX, which require drivers to use page_pool for buffer
> management.
>
> The implementation preserves the DMA premapping optimization introduced i=
n
> commit 31f3cd4e5756 ("virtio-net: rq submits premapped per-buffer") by
> conditionally using PP_FLAG_DMA_MAP when the virtio backend supports
> standard DMA API (vhost, virtio-pci), and falling back to allocation-only
> mode for backends with custom DMA mechanisms (VDUSE).
>
> Changes in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Addressing reviewer feedback from v1:
>
> - Add "select PAGE_POOL" to Kconfig (Jason Wang)
> - Move page pool creation from ndo_open to probe for device lifetime
>   management (Xuan Zhuo, Jason Wang)
> - Implement conditional DMA strategy using virtqueue_dma_dev():
>   - When non-NULL: use PP_FLAG_DMA_MAP for page_pool-managed DMA premappi=
ng
>   - When NULL (VDUSE): page_pool handles allocation only
> - Use page_pool_get_dma_addr() + virtqueue_add_inbuf_premapped() to
>   preserve DMA premapping optimization from commit 31f3cd4e5756
>   ("virtio-net: rq submits premapped per-buffer") (Jason Wang)
> - Remove dual allocation code paths - page_pool now always used for
>   small/mergeable modes (Jason Wang)
> - Remove unused virtnet_rq_alloc/virtnet_rq_init_one_sg functions
> - Add comprehensive performance data (Michael S. Tsirkin)
> - v1 link: https://lore.kernel.org/virtualization/20260106221924.123856-1=
-vishs@meta.com/
>
> Performance Results
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Tested using iperf3 TCP_STREAM with virtio-net on vhost backend.
> 300-second runs, results show throughput and TCP retransmissions.
> The base kernel is synced to net tree and commit: 709bbb015538.
>
> Mergeable Buffer Mode (mrg_rxbuf=3Don, GSO enabled, MTU 1500):
> +--------+---------+---------+------------+------------+--------+--------=
+
> | Queues | Streams |  Patch  | Throughput |   Retries  | Delta  | Retry% =
|
> +--------+---------+---------+------------+------------+--------+--------=
+
> |   1    |    1    |  base   |  25.7 Gbps |      0     |   -    |   -    =
|
> |   1    |    1    |   pp    |  26.2 Gbps |      0     | +1.9%  |   0%   =
|
> +--------+---------+---------+------------+------------+--------+--------=
+
> |   8    |    8    |  base   |  95.6 Gbps |  236,432   |   -    |   -    =
|
> |   8    |    8    |   pp    |  97.9 Gbps |  188,249   | +2.4%  | -20.4% =
|
> +--------+---------+---------+------------+------------+--------+--------=
+
>
> Small Buffer Mode (mrg_rxbuf=3Doff, GSO disabled, MTU 1500):
> +--------+---------+---------+------------+------------+--------+--------=
+
> | Queues | Streams |  Patch  | Throughput |   Retries  | Delta  | Retry% =
|
> +--------+---------+---------+------------+------------+--------+--------=
+
> |   1    |    1    |  base   |  9.17 Gbps |    15,152  |   -    |   -    =
|
> |   1    |    1    |   pp    |  9.19 Gbps |    12,203  | +0.2%  | -19.5% =
|
> +--------+---------+---------+------------+------------+--------+--------=
+
> |   8    |    8    |  base   | 43.0 Gbps  |   974,500  |   -    |   -    =
|
> |   8    |    8    |   pp    | 44.7 Gbps  |   717,411  | +4.0%  | -26.4% =
|
> +--------+---------+---------+------------+------------+--------+--------=
+

It would be better to have more benchmark like:

PPS (using pktgen on host and XDP_DROP in the guest)

We can see PPS as well as XDP performance as well.

Thanks

>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> The patches have been tested with:
> - iperf3 bulk transfer workloads (multiple queue/stream configurations)
> - Included selftests for buffer circulation verification
> - Edge case testing: device unbind/bind cycles, rapid interface open/clos=
e,
>   traffic during close, ethtool feature toggling, close with pending refi=
ll
>   work, and data integrity verification
>
> Vishwanath Seshagiri (2):
>   virtio_net: add page_pool support for buffer allocation
>   selftests: virtio_net: add buffer circulation test
>
>  drivers/net/Kconfig                           |   1 +
>  drivers/net/virtio_net.c                      | 353 ++++++++++--------
>  .../drivers/net/virtio_net/basic_features.sh  |  70 ++++
>  3 files changed, 273 insertions(+), 151 deletions(-)
>
> --
> 2.47.3
>

