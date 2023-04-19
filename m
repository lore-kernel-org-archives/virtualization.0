Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD52AC77B73
	for <virtualization@archiver.kernel.org>; Wed, 19 Apr 2023 05:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48F7E60EFD;
	Wed, 19 Apr 2023 05:17:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 48F7E60EFD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GZsS8wOz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vLJE-j5jiGtw; Wed, 19 Apr 2023 05:17:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9946860C25;
	Wed, 19 Apr 2023 05:17:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9946860C25
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71AC8C007A;
	Wed, 19 Apr 2023 05:17:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97E5FC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 05:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B2A3408D5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 05:17:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B2A3408D5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GZsS8wOz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yONInhmV32ve
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 05:17:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE6DE4010C
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE6DE4010C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 05:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3TYzjVAO8lFOigoxzvnuNLGE5Ej5y2RKbRN7nPAZnQc=; b=GZsS8wOzLRu165JMIeJQWnqCrJ
 cFugFrh3LbSdfvJz1Z3udGZWBk+BVAZOz/zaz3027PrNh7I7H8vtfpmNDUwzp+Dek7cHaGoXRxlg+
 N2vaKfChTbLEndgPdUy55MG7J48x/9JAdhttQ+YlYP5EIe57jWyFZPkVSsBR3YbZU1MMoAi1viRiJ
 qMXnObMVXkIrqVmv7Dz8s+TWjJ0T6a0/YA2l9Q+WlIXS4cma2t2zwYmGcC1VB3rxY5dDB2IB/iG31
 o3oeOAJ1e2SBbb++bbW7afi+MeVPZpH/idmWCOwbxgG7ppHdtDxUyY66DaY9ifrVbfFFgZxmPxlbd
 4uQUixrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pp0BZ-0045Qx-0m; Wed, 19 Apr 2023 05:16:53 +0000
Date: Tue, 18 Apr 2023 22:16:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Message-ID: <ZD95RY9PjVRi7qz3@infradead.org>
References: <ZDzKAD2SNe1q/XA6@infradead.org>
 <1681711081.378984-2-xuanzhuo@linux.alibaba.com>
 <20230417115610.7763a87c@kernel.org>
 <20230417115753.7fb64b68@kernel.org>
 <CACGkMEtPNPXFThHt4aNm4g-fC1DqTLcDnB_iBWb9-cAOHMYV_A@mail.gmail.com>
 <20230417181950.5db68526@kernel.org>
 <1681784379.909136-2-xuanzhuo@linux.alibaba.com>
 <20230417195400.482cfe75@kernel.org>
 <ZD4kMOym15pFcjq+@infradead.org>
 <20230417231947.3972f1a8@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230417231947.3972f1a8@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Paolo Abeni <pabeni@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
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

On Mon, Apr 17, 2023 at 11:19:47PM -0700, Jakub Kicinski wrote:
> > You can't just do dma mapping outside the driver, because there are
> > drivers that do not require DMA mapping at all.  virtio is an example,
> > but all the classic s390 drivers and some other odd virtualization
> > ones are others.
> 
> What bus are the classic s390 on (in terms of the device model)?

I think most of them are based on struct ccw_device, but I'll let the
s390 maintainers fill in.

Another interesting case that isn't really relevant for your networking
guys, but that caused as problems is RDMA.  For hardware RDMA devices
it wants the ULPs to DMA map, but it turns out we have various software
drivers that map to network drivers that do their own DMA mapping
at a much lower layer and after potentially splitting packets or
even mangling them.

> 
> > > I don't think it's reasonable to be bubbling up custom per-subsystem
> > > DMA ops into all of them for the sake of virtio.  
> > 
> > dma addresses and thus dma mappings are completely driver specific.
> > Upper layers have no business looking at them.
> 
> Damn, that's unfortunate. Thinking aloud -- that means that if we want 
> to continue to pull memory management out of networking drivers to
> improve it for all, cross-optimize with the rest of the stack and
> allow various upcoming forms of zero copy -- then we need to add an
> equivalent of dma_ops and DMA API locally in networking?

Can you explain what the actual use case is?

From the original patchset I suspect it is dma mapping something very
long term and then maybe doing syncs on it as needed?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
