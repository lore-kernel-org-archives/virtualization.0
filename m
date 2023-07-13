Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988BFEB64DD
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 11:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 159B882CEC;
	Thu, 13 Jul 2023 11:14:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 159B882CEC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wYDk+bN1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7UrMKVT8H-it; Thu, 13 Jul 2023 11:14:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 917C582792;
	Thu, 13 Jul 2023 11:14:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 917C582792
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64AABC0072;
	Thu, 13 Jul 2023 11:14:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA8EEC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 11:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7811582893
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 11:14:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7811582893
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5-3tdhc6-KiG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 11:14:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A95A82792
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A95A82792
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 11:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MDuT703ngKhFlRZyWWMSEsAM8ty4gmUzqQMXJQcuvVk=; b=wYDk+bN1++5rhyjrI8cgWC7POg
 DA2dP0rGbqmN9RskyM2L70JP8xgSx8GQ1Le2mFgzrQmGX1tVs//odE1KLPY/OvxYDCVdtFQC+eJBt
 SVuxX0ZGL0Ypzj9q/geyGyF2D1rByT9ZVyQgMvmzjlq6CkHiJOH7WyhMmSg2kMvKw9aC3Sgmp7pia
 N9jIQLDN8sbzZ1Br3d0dptlPpJtXRshxzqPaZQ1Q/e0dVraBupePz2s02k69AgQGBlZA/SLJZHzDa
 NI45kxHVkjzxplnEacIbr1fVJFcwpUuqx7eShf8M6QOjPdPnDWgDCIk+RoyoN0W3BjtNfTd205eFD
 ykdxn+AQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qJuHV-00339M-2s; Thu, 13 Jul 2023 11:14:45 +0000
Date: Thu, 13 Jul 2023 04:14:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 03/10] virtio_ring: introduce
 virtqueue_set_premapped()
Message-ID: <ZK/cpSceLMovhmfR@infradead.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-4-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230710034237.12391-4-xuanzhuo@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Mon, Jul 10, 2023 at 11:42:30AM +0800, Xuan Zhuo wrote:
> This helper allows the driver change the dma mode to premapped mode.
> Under the premapped mode, the virtio core do not do dma mapping
> internally.
> 
> This just work when the use_dma_api is true. If the use_dma_api is false,
> the dma options is not through the DMA APIs, that is not the standard
> way of the linux kernel.

I have a hard time parsing this.

More importantly having two modes seems very error prone going down
the route.  If the premapping is so important, why don't we do it
always?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
