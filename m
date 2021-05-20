Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBCCC433B4
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 14:13:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB59608FE
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 14:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB59608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64A0260887;
	Thu, 20 May 2021 14:13:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DWmExqmA0iek; Thu, 20 May 2021 14:13:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02D4F607BE;
	Thu, 20 May 2021 14:13:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDCC3C000E;
	Thu, 20 May 2021 14:13:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A666C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D3FA40218
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:13:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EDHcO3kGmivx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:13:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2DB98400CC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621520000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vkKoZ+CKUsYvNnISKHeZZWH2ryJwgpmqIR8PS+x2z3k=;
 b=WlLpepYbQzrQOOq6ZqkrJRJVH/S2WphTPDvcqaUmbqHpvkrE1TKORfJHVnVDwU5g06U04U
 pQsGx++DMdwH5MoJT6SZkOsiSXD+OZJalSrJZf5dz0f6TnOQQi89raO2zbW05LOflsVSGm
 vlJkN+8EPIDe9weGDDfmcQYe+zjBaZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-iepZhC42MJ6ZH5r6tVwZig-1; Thu, 20 May 2021 10:13:19 -0400
X-MC-Unique: iepZhC42MJ6ZH5r6tVwZig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4AB4180FD61;
 Thu, 20 May 2021 14:13:17 +0000 (UTC)
Received: from localhost (ovpn-115-223.ams2.redhat.com [10.36.115.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96EC51001B2C;
 Thu, 20 May 2021 14:13:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 0/3] virtio_blk: blk-mq io_poll support
Date: Thu, 20 May 2021 15:13:02 +0100
Message-Id: <20210520141305.355961-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Hellwig <hch@lst.de>
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

This patch series implements blk_mq_ops->poll() so REQ_HIPRI requests can be
polled. IOPS for 4k and 16k block sizes increases by 5-18% on a virtio-blk
device with 4 virtqueues backed by an NVMe drive.

- Benchmark: fio ioengine=pvsync2 numjobs=4 direct=1
- Guest: 4 vCPUs with one virtio-blk device (4 virtqueues)
- Disk: Intel Corporation NVMe Datacenter SSD [Optane] [8086:2701]
- CPU: Intel(R) Xeon(R) Silver 4214 CPU @ 2.20GHz

rw          bs hipri=0 hipri=1
------------------------------
randread    4k 149,426 170,763 +14%
randread   16k 118,939 134,269 +12%
randread   64k  34,886  34,906   0%
randread  128k  17,655  17,667   0%
randwrite   4k 138,578 163,600 +18%
randwrite  16k 102,089 120,950 +18%
randwrite  64k  32,364  32,561   0%
randwrite 128k  16,154  16,237   0%
read        4k 146,032 170,620 +16%
read       16k 117,097 130,437 +11%
read       64k  34,834  35,037   0%
read      128k  17,680  17,658   0%
write       4k 134,562 151,422 +12%
write      16k 101,796 107,606  +5%
write      64k  32,364  32,594   0%
write     128k  16,259  16,265   0%

Larger block sizes do not benefit from polling as much but the
improvement is worthwhile for smaller block sizes.

Stefan Hajnoczi (3):
  virtio: add virtioqueue_more_used()
  virtio_blk: avoid repeating vblk->vqs[qid]
  virtio_blk: implement blk_mq_ops->poll()

 include/linux/virtio.h       |   2 +
 drivers/block/virtio_blk.c   | 126 +++++++++++++++++++++++++++++------
 drivers/virtio/virtio_ring.c |  17 +++++
 3 files changed, 123 insertions(+), 22 deletions(-)

-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
