Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB83C77B73
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 16:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3024181FB3;
	Thu, 20 Apr 2023 16:16:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3024181FB3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XxVPm6LU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LGrm5xAlceGw; Thu, 20 Apr 2023 16:16:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B548284231;
	Thu, 20 Apr 2023 16:16:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B548284231
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83E73C0037;
	Thu, 20 Apr 2023 16:16:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16834C0037
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 16:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EE0441BAF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 16:15:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4EE0441BAF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XxVPm6LU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TJ8w5t7KxCCv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 16:15:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A03F840977
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A03F840977
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 16:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8cylqzdP0hXk5+N5BXe5Y74wAIWGCOav7qKznB1OcHU=; b=XxVPm6LUtaULMeaI3bbiNdFmBk
 MT0gzQoFXxLpTVFqApMHWsr9uCibCIZH/Ar5VtYm4BE9U8TAoxiELgcvErBDkD1lFZQP73U2jvKK4
 MGYTVF3is9fL2r2XC/7Go/+1wV7CcRP4uV1sVx4d56ODJBNQEBRY89e+WYtlbgEXDo+ng9n4RW/eb
 dhYksqqCLXLJ7oXuPTIzGIA5/HATPY7lArpuLuhiyGunZX1pJYLx/7/P6zeUPXkL9rQiWzB3FXXE5
 ayJBzZCYD0s+XN4JcPD1Uv4CBypRW/SPmfLwW450ZLR5SNuxc9Q+ULPc9mrpfqhyOnTRrBd5zKiAT
 YlsP+2Yw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1ppWwO-008WEu-01; Thu, 20 Apr 2023 16:15:24 +0000
Date: Thu, 20 Apr 2023 09:15:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Message-ID: <ZEFlG9rINkutmpCT@infradead.org>
References: <CACGkMEtPNPXFThHt4aNm4g-fC1DqTLcDnB_iBWb9-cAOHMYV_A@mail.gmail.com>
 <20230417181950.5db68526@kernel.org>
 <1681784379.909136-2-xuanzhuo@linux.alibaba.com>
 <20230417195400.482cfe75@kernel.org>
 <ZD4kMOym15pFcjq+@infradead.org>
 <20230417231947.3972f1a8@kernel.org>
 <ZD95RY9PjVRi7qz3@infradead.org>
 <d18eea7a-a71c-8de0-bde3-7ab000a77539@intel.com>
 <ZEDYt/EQJk39dTuK@infradead.org>
 <ff3d588e-10ac-36dd-06af-d55a79424ede@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ff3d588e-10ac-36dd-06af-d55a79424ede@intel.com>
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

On Thu, Apr 20, 2023 at 03:59:39PM +0200, Alexander Lobakin wrote:
> Hmm, currently almost all Ethernet drivers map Rx pages once and then
> just recycle them, keeping the original DMA mapping. Which means pages
> can have the same first mapping for very long time, often even for the
> lifetime of the struct device. Same for XDP sockets, the lifetime of DMA
> mappings equals the lifetime of sockets.
> Does it mean we'd better review that approach and try switching to
> dma_alloc_*() family (non-coherent/caching in our case)?

Yes, exactly.  dma_alloc_noncoherent can be used exactly as alloc_pages
+ dma_map_* by the driver (including the dma_sync_* calls on reuse), but
has a huge number of advantages.

> Also, I remember I tried to do that for one my driver, but the thing
> that all those functions zero the whole page(s) before returning them to
> the driver ruins the performance -- we don't need to zero buffers for
> receiving packets and spend a ton of cycles on it (esp. in cases when 4k
> gets zeroed each time, but your main body of traffic is 64-byte frames).

Hmm, the single zeroing when doing the initial allocation shows up
in these profiles?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
