Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D475C77B72
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 06:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F2BC40204;
	Thu, 20 Apr 2023 06:16:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F2BC40204
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=foXj+W8b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eB_aAe3RApiG; Thu, 20 Apr 2023 06:16:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ACBCC400D1;
	Thu, 20 Apr 2023 06:16:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ACBCC400D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F6E7C0036;
	Thu, 20 Apr 2023 06:16:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50E95C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B47140204
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:16:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B47140204
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ej_b2Lg1hVfc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:16:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87978400D1
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87978400D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wW0DLfkuxhOJTHn8csrZy8uKe/oAqpxqTHSHjbmQDXk=; b=foXj+W8bjMYBMeiIxvcDr0GYy2
 uxYKvKG2Iq1YUylO9P11nrg1Q4e5gLLDXr2dXuozjeAkV6fa3Eainbx4kcd8PujJyEdf07MRpq7kj
 QkXcnCbmtv798lzgVmgQtIMevwNX248Pb673Ltwebdu18fQPfpcRVhiI+nse6op8BTyi7liDx1wcY
 iaK8LQCm6+XV3aVDfkwE1SnglsmQeCbUWuU75v8Z4XNSiJItr3flD3/fwrqnjILzB6taI3CDkhZE/
 FnI67NOl8aqRqFQMi0I0L2J2X1lKdFSQTAvhdZd5RVSicUeylgNgagJySD817YPxQ5Im7qDWtwwDg
 ihB3HJOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1ppNah-007AK9-2c; Thu, 20 Apr 2023 06:16:23 +0000
Date: Wed, 19 Apr 2023 23:16:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Message-ID: <ZEDYt/EQJk39dTuK@infradead.org>
References: <20230417115610.7763a87c@kernel.org>
 <20230417115753.7fb64b68@kernel.org>
 <CACGkMEtPNPXFThHt4aNm4g-fC1DqTLcDnB_iBWb9-cAOHMYV_A@mail.gmail.com>
 <20230417181950.5db68526@kernel.org>
 <1681784379.909136-2-xuanzhuo@linux.alibaba.com>
 <20230417195400.482cfe75@kernel.org>
 <ZD4kMOym15pFcjq+@infradead.org>
 <20230417231947.3972f1a8@kernel.org>
 <ZD95RY9PjVRi7qz3@infradead.org>
 <d18eea7a-a71c-8de0-bde3-7ab000a77539@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d18eea7a-a71c-8de0-bde3-7ab000a77539@intel.com>
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

On Wed, Apr 19, 2023 at 03:14:48PM +0200, Alexander Lobakin wrote:
> >>> dma addresses and thus dma mappings are completely driver specific.
> >>> Upper layers have no business looking at them.
> 
> Here it's not an "upper layer". XSk core doesn't look at them or pass
> them between several drivers.

Same for upper layers :)  The just do abstract operations that can sit
on top of a variety of drivers.

> It maps DMA solely via the struct device
> passed from the driver and then just gets-sets addresses for this driver
> only. Just like Page Pool does for regular Rx buffers. This got moved to
> the XSk core to not repeat the same code pattern in each driver.

Which assumes that:

 a) a DMA mapping needs to be done at all
 b) it can be done using a struct device exposed to it
 c) that DMA mapping is actually at the same granularity that it
    operates on

all of which might not be true.

> >>From the original patchset I suspect it is dma mapping something very
> > long term and then maybe doing syncs on it as needed?
> 
> As I mentioned, XSk provides some handy wrappers to map DMA for drivers.
> Previously, XSk was supported by real hardware drivers only, but here
> the developer tries to add support to virtio-net. I suspect he needs to
> use DMA mapping functions different from which the regular driver use.

Yes,  For actual hardware virtio and some more complex virtualized
setups it works just like real hardware.  For legacy virtio there is 
no DMA maping involved at all.  Because of that all DMA mapping needs
to be done inside of virtio.

> So this is far from dma_map_ops, the author picked wrong name :D
> And correct, for XSk we map one big piece of memory only once and then
> reuse it for buffers, no inflight map/unmap on hotpath (only syncs when
> needed). So this mapping is longterm and is stored in XSk core structure
> assigned to the driver which this mapping was done for.
> I think Jakub thinks of something similar, but for the "regular" Rx/Tx,
> not only XDP sockets :)

FYI, dma_map_* is not intended for long term mappings, can lead
to starvation issues.  You need to use dma_alloc_* instead.  And
"you" in that case is as I said the driver, not an upper layer.
If it's just helper called by drivers and never from core code,
that's of course fine.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
