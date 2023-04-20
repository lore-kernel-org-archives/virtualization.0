Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D52FC77B73
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 16:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF22B400D3;
	Thu, 20 Apr 2023 16:18:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF22B400D3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2l58lpIs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A38q_j29jj-X; Thu, 20 Apr 2023 16:18:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 59BA2400D8;
	Thu, 20 Apr 2023 16:18:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 59BA2400D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33B3BC0037;
	Thu, 20 Apr 2023 16:18:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFF55C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 16:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DE0660BC0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 16:18:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8DE0660BC0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2l58lpIs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FMULYFyK-oIN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 16:18:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE4006076C
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE4006076C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 16:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WriYvcEYXKuK/u58ncTN0aOBy6C3Ot7CD4a8g8BQ4+4=; b=2l58lpIsSDMv9cBpyQ1xOmrKYd
 GY1YczBXm1i8BazJ2u7OC8T0xxiRCgKPwwenqlQwPF3bypZsMmd+nJcMGl7IZeNexgNrdWdhTkjYK
 jPCEmKIxtYAtxy45FpQ+PEgJ3ZC3XPgnTEDhygBY5E3UOACDCxNAtmxx6jG/lTBQ1k/Bui7KAUSTy
 QGbTVB/8cLEuFxt3wxOe0Xx3P5MVpc96vWpAZyA1Un9xrOlwVgzZDozxqE6WWNnz/4AdbkNNAs4Uy
 nRWNqOPipvvhyY6a0XiqKJ4ZYNBKfkd9FiK41saU96nD/BXapbES0ypRc7j2CuzPyjQnRfty0viil
 cy5VTR7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1ppWzF-008WWw-0D; Thu, 20 Apr 2023 16:18:21 +0000
Date: Thu, 20 Apr 2023 09:18:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Message-ID: <ZEFlzdiyu2IAyX7a@infradead.org>
References: <CACGkMEtPNPXFThHt4aNm4g-fC1DqTLcDnB_iBWb9-cAOHMYV_A@mail.gmail.com>
 <20230417181950.5db68526@kernel.org>
 <1681784379.909136-2-xuanzhuo@linux.alibaba.com>
 <20230417195400.482cfe75@kernel.org>
 <ZD4kMOym15pFcjq+@infradead.org>
 <20230417231947.3972f1a8@kernel.org>
 <ZD95RY9PjVRi7qz3@infradead.org>
 <20230419094506.2658b73f@kernel.org>
 <ZEDZaitjcX+egzvf@infradead.org>
 <1681981908.9700203-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1681981908.9700203-3-xuanzhuo@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
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

On Thu, Apr 20, 2023 at 05:11:48PM +0800, Xuan Zhuo wrote:
> I know that the current design of DMA API only supports some physical hardware,
> but can it be modified or expanded?

I think the important point is that for some cases there is no need
to dma map at all, and upper layers should be fine by that by just
doing the dma mapping in helpers called by the driver.

The virtio drivers then check if platform_access is set, then call the
generic dma mapping helper, or if not just allocate memory using
alloc_pages and also skip all the sync calls.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
