Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E372C77B6C
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 07:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE1F941DBA;
	Thu, 13 Apr 2023 07:16:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE1F941DBA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id unQec580_v0Y; Thu, 13 Apr 2023 07:16:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6B6B441E48;
	Thu, 13 Apr 2023 07:16:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B6B441E48
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40DD4C0036;
	Thu, 13 Apr 2023 07:16:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB689C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 721B560E0B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:16:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 721B560E0B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h9m8ZB7CwkB1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:16:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAC1F60DA5
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAC1F60DA5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:16:16 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R991e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0Vg-LcGG_1681370170; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vg-LcGG_1681370170) by smtp.aliyun-inc.com;
 Thu, 13 Apr 2023 15:16:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
Subject: [PATCH] MAINTAINERS: make me a reviewer of VIRTIO CORE AND NET DRIVERS
Date: Thu, 13 Apr 2023 15:16:10 +0800
Message-Id: <20230413071610.43659-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: eb09d48d9ef9
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

First of all, I personally love open source, linux and virtio. I have
also participated in community work such as virtio for a long time.

I think I am familiar enough with virtio/virtio-net and is adequate as a
reviewer.

Every time there is some patch/bug, I wish I can get pinged
and I will feedback on that.

For me personally, being a reviewer is an honor and a responsibility,
and it also makes it easier for me to participate in virtio-related
work. And I will spend more time reviewing virtio patch. Better advance
virtio development

I had some contributions to virtio/virtio-net and some support for it.

* per-queue reset
* virtio-net xdp
* some bug fix
* ......

I make a humble request to grant the reviewer role for the virtio core
and net drivers.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cacd6074fb89..700b00a9e225 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22064,6 +22064,7 @@ F:	include/uapi/linux/virtio_console.h
 VIRTIO CORE AND NET DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
+R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-vdpa
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
