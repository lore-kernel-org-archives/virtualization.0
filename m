Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC63EB64DA
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 08:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 506C240453;
	Thu, 20 Jul 2023 08:21:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 506C240453
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2d/fYZrK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HcmdoGQE7dA0; Thu, 20 Jul 2023 08:21:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D165C401D8;
	Thu, 20 Jul 2023 08:21:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D165C401D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F3D3C0071;
	Thu, 20 Jul 2023 08:21:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41D97C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 08:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B9D741B18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 08:21:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B9D741B18
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2d/fYZrK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8kP7hgJIX-lX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 08:21:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30BB841904
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 08:21:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30BB841904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NqLEMJC7fYxhCSn83KJr6oToHsj8izdq9tSB9Ugi6bU=; b=2d/fYZrKqw67I24WjJ5lvu/zoc
 dul2IKATOMlxqldTLbyOVLkP9BV4xjJCJVylu8pcxCXCLllrbpy2Sb0q0ajxJ5xW6U+Urc6uBhx7J
 W9iV5FEMmaabUufPI+NoOw2c2SDi/JQ73YFg2l8V15JzLVKteaSXww2eHlj6tzh3oa72XEJEto/3o
 xJRhQtdkTQJPVqy4Wo2g64rdSg/gmbUCsTToZ60C7EALMZk99rsLZNLLMqChUkmWdXyQIg1Mulxyr
 jBCLilzUwsIeC4O9IswurY59ogK8VJ8vJJkgn9DXtp4CdhMGY1OoC7QAdys/EZ/XnCr4l1UGmYClk
 ydD/Hqhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qMOut-00AHtv-3C; Thu, 20 Jul 2023 08:21:43 +0000
Date: Thu, 20 Jul 2023 01:21:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH vhost v11 10/10] virtio_net: merge dma operation for one
 page
Message-ID: <ZLjul7mYcMujUfxQ@infradead.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-11-xuanzhuo@linux.alibaba.com>
 <CACGkMEtoiHXese1sNJELeidmFc6nFR8rE1aA8MooaEKKUSw_eg@mail.gmail.com>
 <1689231087.0744615-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsf4+56veqem1HMWiqYhiW5LVw-1CbWX-cQSN6Z0zYMRQ@mail.gmail.com>
 <ZLjS4D7urgIK1MxV@infradead.org>
 <CACGkMEsbzWU3+pA1kLNwGEmwYjP9riRANpUtsmE-YXJmnFAuhw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACGkMEsbzWU3+pA1kLNwGEmwYjP9riRANpUtsmE-YXJmnFAuhw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
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

On Thu, Jul 20, 2023 at 03:41:56PM +0800, Jason Wang wrote:
> > Did you actually check that it works though?
> > Looks like with swiotlb you need to synch to trigger a copy
> > before unmap, and I don't see where it's done in the current
> > patch.
> 
> And this is needed for XDP_REDIRECT as well.

DMA always needs proper syncs, be that for swiotlb or for cache
maintainance, yes.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
