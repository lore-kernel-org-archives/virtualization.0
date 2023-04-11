Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF360C76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 07:21:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 62ADB4056D;
	Tue, 11 Apr 2023 07:21:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 62ADB4056D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QC88KMOEAsXF; Tue, 11 Apr 2023 07:21:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 10284405BC;
	Tue, 11 Apr 2023 07:21:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10284405BC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBF7CC0036;
	Tue, 11 Apr 2023 07:21:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22CDFC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F1FAE6139A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:21:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1FAE6139A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5f7yP7_vdFHP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:21:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 060F760EA6
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 060F760EA6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:21:09 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R771e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0VfrCuHn_1681197663; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VfrCuHn_1681197663) by smtp.aliyun-inc.com;
 Tue, 11 Apr 2023 15:21:04 +0800
Message-ID: <1681197133.6736434-7-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 11 Apr 2023 15:12:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-9-xuanzhuo@linux.alibaba.com>
 <73a24f95-b779-44ac-be28-45b35d1bf540@roeck-us.net>
 <20230407064634-mutt-send-email-mst@kernel.org>
 <1681097397.338332-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
In-Reply-To: <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
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


Hi Jason

Can we force virtio core to use dma api without VIRTIO_F_ACCESS_PLATFORM?


Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
