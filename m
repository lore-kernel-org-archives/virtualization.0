Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FB6C77B61
	for <virtualization@archiver.kernel.org>; Mon,  1 May 2023 04:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFF2960E6A;
	Mon,  1 May 2023 04:28:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CFF2960E6A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GKe5hDhy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5WRttYoMtA6o; Mon,  1 May 2023 04:28:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 34981605D5;
	Mon,  1 May 2023 04:28:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34981605D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17ED9C0036;
	Mon,  1 May 2023 04:28:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61822C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 04:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 229D5408CA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 04:28:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 229D5408CA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GKe5hDhy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0JOVHb-59Wqa
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 04:28:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5118340893
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5118340893
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 04:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AEYbMSFzhhiMlFPh01t9v+62fsN5TBDtngScZaFw41c=; b=GKe5hDhykrlOLAIxiCDsQ7GNVy
 Cptq4NVoR+eipLScQ13IuZd3Zt8Y9q0Ab6DlrQfoqrBbY7NBxFoTG9OdQDsu3Aw2eOwFa/5qSgtjq
 c14IQA3NPh3FrD262E/3cwDb4jTLFMiV/Jku1ZMkx60GIv0NKDqO4ppby2ps4p7Ym22yDw92BA3yP
 lqM7ub+DFKHZzAdq14QV6/PpXzh4N7+5n7HhTvl0ri6HfVYyjXVXOTGdWRg4tFvRJ/6j9dd5xjgZc
 p5rFqds/jlzD7QdDUQQgxPBB0BX5G0/HxNbF+OHbfeFLDkWFEbluXRdvAx6iYQw1YAJLVhizJgrvO
 e3veDurQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1ptL97-00FENY-0s; Mon, 01 May 2023 04:28:17 +0000
Date: Sun, 30 Apr 2023 21:28:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Message-ID: <ZE8/4aB8zi7du+N+@infradead.org>
References: <1681784379.909136-2-xuanzhuo@linux.alibaba.com>
 <20230417195400.482cfe75@kernel.org>
 <ZD4kMOym15pFcjq+@infradead.org>
 <20230417231947.3972f1a8@kernel.org>
 <ZD95RY9PjVRi7qz3@infradead.org>
 <d18eea7a-a71c-8de0-bde3-7ab000a77539@intel.com>
 <ZEDYt/EQJk39dTuK@infradead.org>
 <ff3d588e-10ac-36dd-06af-d55a79424ede@intel.com>
 <ZEFlG9rINkutmpCT@infradead.org>
 <b791d25d-8417-06e5-8e8b-6a9d3195c807@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b791d25d-8417-06e5-8e8b-6a9d3195c807@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 netdev@vger.kernel.org, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, bpf@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Apr 20, 2023 at 06:42:17PM +0200, Alexander Lobakin wrote:
> When there's no recycling of pages, then yes. And since recycling is
> done asynchronously, sometimes new allocations happen either way.
> Anyways, that was roughly a couple years ago right when you introduced
> dma_alloc_noncoherent(). Things might've been changed since then.
> I could try again while next is closed (i.e. starting this Sunday), the
> only thing I'd like to mention: Page Pool allocates pages via
> alloc_pages_bulk_array_node(). Bulking helps a lot (and PP uses bulks of
> 16 IIRC), explicit node setting helps when Rx queues are distributed
> between several nodes. We can then have one struct device for several nodes.
> As I can see, there's now no function to allocate in bulks and no
> explicit node setting option (e.g. mlx5 works around this using
> set_dev_node() + allocate + set_dev_node(orig_node)). Could such options
> be added in near future? That would help a lot switching to the
> functions intended for use when DMA mappings can stay for a long time.
> >From what I see from the code, that shouldn't be a problem (except for
> non-direct DMA cases, where we'd need to introduce new callbacks or
> extend the existing ones).

So the node hint is something we can triviall pass through, and
something the mlx5 maintainers should have done from the beginning
instead of this nasty hack.  Patches gladly accepted.

A alloc_pages_bulk_array_node-like allocator also seems doable, we
just need to make sure it has a decent fallback as I don't think
we can wire it up to all the crazy legacy iommu drivers.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
