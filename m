Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EA9C7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 07:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86BF9820D0;
	Tue, 11 Apr 2023 07:26:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86BF9820D0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id va3s__5tww7o; Tue, 11 Apr 2023 07:26:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2686D82068;
	Tue, 11 Apr 2023 07:26:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2686D82068
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF0FFC0036;
	Tue, 11 Apr 2023 07:26:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11704C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E058A60E0D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:25:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E058A60E0D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nNDgSP5AoQ-A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:25:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 99AAC60750
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99AAC60750
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:25:58 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VfrKG7x_1681197953; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VfrKG7x_1681197953) by smtp.aliyun-inc.com;
 Tue, 11 Apr 2023 15:25:53 +0800
Message-ID: <1681197823.3277218-8-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 11 Apr 2023 15:23:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Christoph Hellwig <hch@infradead.org>
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-9-xuanzhuo@linux.alibaba.com>
 <73a24f95-b779-44ac-be28-45b35d1bf540@roeck-us.net>
 <20230407064634-mutt-send-email-mst@kernel.org>
 <1681097397.338332-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
 <ZDQq0pDVkr8TvoTM@infradead.org>
 <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
 <ZDTTXCPaW8D1nW4C@infradead.org>
 <1681194222.3822775-2-xuanzhuo@linux.alibaba.com>
 <ZDT+hc2XsqbVifjL@infradead.org>
 <1681194809.9329011-4-xuanzhuo@linux.alibaba.com>
 <ZDUCDeYLqAwQVJe7@infradead.org>
In-Reply-To: <ZDUCDeYLqAwQVJe7@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 virtualization@lists.linux-foundation.org
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

On Mon, 10 Apr 2023 23:45:33 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Apr 11, 2023 at 02:33:29PM +0800, Xuan Zhuo wrote:
> > Do you mean my idea is wrong, right?
> >
> > Can you explain it? Why can't we support a device that uses only dirct map?
>
> If a direct map or not is used is a decision done by the platform code,
> often based on firmware tables.  You can't just override that.


Can Virtio Device set its own dma_ops? It is a device on the virtual bus. It
sets its own DMA_OPS. I think it is reasonable.

Thanks.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
