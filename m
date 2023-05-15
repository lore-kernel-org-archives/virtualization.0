Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E253FC77B7D
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 02:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 505EF408AE;
	Mon, 15 May 2023 02:12:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 505EF408AE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zKMVsGmJVD3h; Mon, 15 May 2023 02:12:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 86ABE402E7;
	Mon, 15 May 2023 02:12:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 86ABE402E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A911C0036;
	Mon, 15 May 2023 02:12:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06BD8C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB6DD4048E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:12:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB6DD4048E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ePQr9Quu9oDk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:12:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B5C0402E7
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B5C0402E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 02:12:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R991e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0ViZ.M3F_1684116723; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0ViZ.M3F_1684116723) by smtp.aliyun-inc.com;
 Mon, 15 May 2023 10:12:04 +0800
Message-ID: <1684116040.6590629-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v8 01/12] virtio_ring: split: separate dma codes
Date: Mon, 15 May 2023 10:00:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Christoph Hellwig <hch@infradead.org>
References: <20230509080902.104619-1-xuanzhuo@linux.alibaba.com>
 <20230509080902.104619-2-xuanzhuo@linux.alibaba.com>
 <ZF5Vv40TWNyFl0IN@infradead.org>
In-Reply-To: <ZF5Vv40TWNyFl0IN@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, 12 May 2023 08:05:35 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> As said before, please don't try to do weird runtime checks based
> on the scatterlist.  What you have works for now, but there are
> plans to repalce the page + offset tuple in the scatterlist with
> just a phys_addr_t.  And with that your "clever" scheme will break
> instantly.


Sorry, I missed this email for some reason. Thanks for Jason's reply.

Although, I think that the interface sg_page() should not have any problems.
If we use phys_addr_t replace the page + offset, this interface sg_page() should
be update or replace. But i will follow your advice.

I have another question. I done some modification on scatterlist
(inside virtqueue_map_sgs()) in the patch using dma_address to save the dma
address got by virtio core. I want to know if this behavior is suitable.

Thanks.




> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
