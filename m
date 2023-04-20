Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8966C77B72
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 06:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B725400F1;
	Thu, 20 Apr 2023 06:13:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B725400F1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=m/zx+gYM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ls4v1bGon6Q6; Thu, 20 Apr 2023 06:13:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 16815400D1;
	Thu, 20 Apr 2023 06:13:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16815400D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC96EC0036;
	Thu, 20 Apr 2023 06:12:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7E19C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C94D2400F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:12:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C94D2400F1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b_lzf-bN6298
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:12:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C830A400D1
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C830A400D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=VvxWfujovCtVXzYeAUJjYQFMS4G5zuDe6AKlUF+GOvw=; b=m/zx+gYM4jCsPrOJXtRSMp8Tl3
 8LwvrQXASzU57ZHaKfOYUz4Rnao8JdUBNUUu2fMcIIStr3JjVVdiJ1/k+SxT55vpZMI52Y4cgeL8f
 44aw0qOTlRwHMVkGOoDsZCZs7Pu8BaZHAFf0PqQbJcsqj3h+yEPIqTt2E4UOPKzU4VdXdpDCTYWYV
 FqqU3qoKiUW+U92jT5mpKDvIM/zoNSOYUMzsvL/C48LK2TgJ169an9S8YFjgvyYa/vU9tiv7GtV0z
 Ht0pTOgDzlRUDr65HTe6a84uwyRs3CisaPMZwsqWNRRAJHcOJfBjdA6olWm9/AcpwvlN+3GCDElRn
 TGA5FZdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1ppNWu-007A2p-2v; Thu, 20 Apr 2023 06:12:28 +0000
Date: Wed, 19 Apr 2023 23:12:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Message-ID: <ZEDXzGqvSiQ3036r@infradead.org>
References: <20230417032750.7086-1-xuanzhuo@linux.alibaba.com>
 <88d5a2f6-af43-c3f9-615d-701ef01d923d@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <88d5a2f6-af43-c3f9-615d-701ef01d923d@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Wed, Apr 19, 2023 at 03:22:39PM +0200, Alexander Lobakin wrote:
> If DMA syncs are not needed on your x86_64 DMA-coherent system, it
> doesn't mean we all don't need it.

If the DMA isn't actually a DMA (as in the virtio case, or other
cases that instead have to do their own dma mapping at much lower
layers) syncs generally don't make sense.

> Instead of filling pointers with
> "default" callbacks, you could instead avoid indirect calls at all when
> no custom DMA ops are specified. Pls see how for example Christoph did
> that for direct DMA. It would cost only one if-else for case without
> custom DMA ops here instead of an indirect call each time.

So yes, I think the abstraction here should not be another layer of
DMA ops, but the option to DMA map or not at all.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
