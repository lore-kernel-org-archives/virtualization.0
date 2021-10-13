Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BF0C433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:46:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE3860D07
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7FE3860D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A04E407E3;
	Wed, 13 Oct 2021 12:46:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id un_lmtfYXp2a; Wed, 13 Oct 2021 12:46:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F27AD407E7;
	Wed, 13 Oct 2021 12:46:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8119C000F;
	Wed, 13 Oct 2021 12:46:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75758C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63957407E5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wx7RS6hOi0Yh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:46:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A3344407E3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634129176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=pio+Rp9lSXqTgcX0jd1ToQMieUTpIAr4Wm8ggp456+o=;
 b=SLb5VYEjTIz/mey/xy2cUBuPBysF1YIu/ws8mbDgGnWHo879a6YWgoFerElpKSB0QIq4iN
 AcIWcqr0iJCtaWlpcNdtndwnd4JnWdxrYJ71H+mrdjaozAmg/mseJBEvDkcfmk9a0iKoXJ
 05Ina6lTPsURKKpO9wZh0cd2QH/e9t4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-y_LR3VkVO2qhn49pAjLWlg-1; Wed, 13 Oct 2021 08:46:13 -0400
X-MC-Unique: y_LR3VkVO2qhn49pAjLWlg-1
Received: by mail-wr1-f70.google.com with SMTP id
 10-20020a5d47aa000000b001610cbda93dso1839417wrb.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=pio+Rp9lSXqTgcX0jd1ToQMieUTpIAr4Wm8ggp456+o=;
 b=cVImSqnsr0erSzjpdYPWVFyXoQjXOnVCtgdAHBMTFIqPoD87dyHmSO4ZOXYqa1fx40
 T5hQatjLFxIAKkxL5ViJk8dE/FoKTP2EgfH23bhltzni7Fl/XWCT46qFzCrZVPhHhQkF
 dmP4VYwdC617gLaAcCJRIWUZDE9DxHEaPs1twMIazZ/1sMcR4K+r+TlfDwOQP/ZPl3j/
 sAmz5zGZR33e1eFniE0SloMNiKHzea73wOI//2ft77TPQMKq1f/XT2+dMzO3dPe6xImm
 5k1QUPDjaSN0Y8CIxYwhGOIysmmlmaPj6EOfF7ypzD8FNR2smWeJTbD0Sq2ke++36ie8
 enhg==
X-Gm-Message-State: AOAM531O3UWOe6bauS/V3sBCr4CczIIgu3Y/MJp0CSPCZ8QdvZolvBLf
 OivcuD9mNjeJtl994VXehlTcsdS8jIoLHruBUVHjmyhJ8bpOx9b91ANAWd5H+LC266VJcRuHRzP
 36oY7feysqAEBUFl6VSjNZdY6uDot7cd3+DkP/2q7lQ==
X-Received: by 2002:a1c:3586:: with SMTP id c128mr12804922wma.78.1634129172060; 
 Wed, 13 Oct 2021 05:46:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWON28WQcyoAHS7/UuoGSQN5DfnmTJuEAcV0OBwnEccLiKLDK1QD4fr9pYUdKD+eXE6vI3mA==
X-Received: by 2002:a1c:3586:: with SMTP id c128mr12804894wma.78.1634129171809; 
 Wed, 13 Oct 2021 05:46:11 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id s1sm5015348wmc.47.2021.10.13.05.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:46:11 -0700 (PDT)
Date: Wed, 13 Oct 2021 08:46:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "virtio-blk: Add validation for block size in config
 space"
Message-ID: <20211013124553.23803-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

It turns out that access to config space before completing the feature
negotiation is broken for big endian guests at least with QEMU hosts up
to 6.1 inclusive.  This affects any device that accesses config space in
the validate callback: at the moment that is virtio-net with
VIRTIO_NET_F_MTU but since 82e89ea077b9 ("virtio-blk: Add validation for
block size in config space") that also started affecting virtio-blk with
VIRTIO_BLK_F_BLK_SIZE. Further, unlike VIRTIO_NET_F_MTU which is off by
default on QEMU, VIRTIO_BLK_F_BLK_SIZE is on by default, which resulted
in lots of people not being able to boot VMs on BE.

The spec is very clear that what we are doing is legal so QEMU needs to
be fixed, but given it's been broken for so many years and no one
noticed, we need to give QEMU a bit more time before applying this.

Further, this patch is incomplete (does not check blk size is a power
of two) and it duplicates the logic from nbd.

Revert for now, and we'll reapply a cleaner logic in the next release.

Cc: stable@vger.kernel.org
Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
Cc: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9b3bd083b411..303caf2d17d0 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -689,28 +689,6 @@ static const struct blk_mq_ops virtio_mq_ops = {
 static unsigned int virtblk_queue_depth;
 module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
 
-static int virtblk_validate(struct virtio_device *vdev)
-{
-	u32 blk_size;
-
-	if (!vdev->config->get) {
-		dev_err(&vdev->dev, "%s failure: config access disabled\n",
-			__func__);
-		return -EINVAL;
-	}
-
-	if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
-		return 0;
-
-	blk_size = virtio_cread32(vdev,
-			offsetof(struct virtio_blk_config, blk_size));
-
-	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
-		__virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
-
-	return 0;
-}
-
 static int virtblk_probe(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk;
@@ -722,6 +700,12 @@ static int virtblk_probe(struct virtio_device *vdev)
 	u8 physical_block_exp, alignment_offset;
 	unsigned int queue_depth;
 
+	if (!vdev->config->get) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
 	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
 			     GFP_KERNEL);
 	if (err < 0)
@@ -836,14 +820,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 	else
 		blk_size = queue_logical_block_size(q);
 
-	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE) {
-		dev_err(&vdev->dev,
-			"block size is changed unexpectedly, now is %u\n",
-			blk_size);
-		err = -EINVAL;
-		goto out_cleanup_disk;
-	}
-
 	/* Use topology information if available */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, physical_block_exp,
@@ -1009,7 +985,6 @@ static struct virtio_driver virtio_blk = {
 	.driver.name			= KBUILD_MODNAME,
 	.driver.owner			= THIS_MODULE,
 	.id_table			= id_table,
-	.validate			= virtblk_validate,
 	.probe				= virtblk_probe,
 	.remove				= virtblk_remove,
 	.config_changed			= virtblk_config_changed,
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
