Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA6AC83F2C
	for <virtualization@archiver.kernel.org>; Mon,  4 Sep 2023 06:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2201E81427;
	Mon,  4 Sep 2023 06:14:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2201E81427
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YjbLjCpm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jmFCAlLE8VuK; Mon,  4 Sep 2023 06:14:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5AB0D8141D;
	Mon,  4 Sep 2023 06:14:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AB0D8141D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D273C0039;
	Mon,  4 Sep 2023 06:14:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF871C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 06:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A1D9C414E2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 06:14:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1D9C414E2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=YjbLjCpm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tGbZkbEQxWRO
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 06:14:33 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E8A7410CA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 06:14:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E8A7410CA
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-56a8794b5adso758197a12.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Sep 2023 23:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1693808072; x=1694412872;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0Ypb7k0otVq6eC7pO2i8Tc3phnCnFLJFKEC4oYPS6f4=;
 b=YjbLjCpmGlyumcGc5SDkN4mUzdN0muW2HJeFpqlnZJSsXEB2dN5N+nu4wjoYqRgk4K
 nqNBT76xctdLYIO+mol8iCSGa4Ksum9QzTbB391BOofzd+BdAYtT+dV8xOUGirUQQlxm
 GPKjhbalrebX2ROjFhKELWfSe4qBmasE2DhEV6vFISyezfu2Bxylwgxu9UDzVkAgS57J
 zPXScePOHLx74r7R35EYeUdgX1y0vO/yA+IHRG/ylIU9zhCAEitu/kyzR2svxH32iMcF
 ij3iSPlh1C361x6G4xfhE/q9TlIhqRDh+FZHkZR0kWIZlJmxMni1ZRiMSNFOzrySmywt
 micw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693808072; x=1694412872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Ypb7k0otVq6eC7pO2i8Tc3phnCnFLJFKEC4oYPS6f4=;
 b=N+kCGPcA78tb0VZuipCuKm6kfj/kk+qEAAqDtT4Et4zI8LIjo7CPaAXd4//VkfsL+U
 3K9WGcL0pPzKjQEegbAZrcyuZJ0NMlJdzjTvBkKLs481j47osY+hRJd7A7m+lqiAeVGZ
 8JF40h6WeNf1DuTOOe39fl7ZWC175aMzfSXw0ouM7uszR80+8FjXdM42+qY1RstTgmN1
 7LIZ26u+gDHmGAs0gLRLtVlAwFHE8YP/iBx8EpnWJA+Ygf7af2KramnV6DpxNPU4eeaS
 sjI41L9fGiZcGspV48lrmc6CbnsMFEqZ1xWtM7jAfv+5k1FbupAFYrDjjNtFdynfzyxA
 Cl6g==
X-Gm-Message-State: AOJu0YwRhrcq1305b2a4rBcbkEYyKYukPZYpBwLJusok01BPDK4GZ0W4
 Uaq6qUBOZHxJDSQpPwSOG7b5yg==
X-Google-Smtp-Source: AGHT+IFnnyXtaTN3uKtZijN84zL4eh2k0aLZkCYLJYhH1so77+cHFDePDfPC0UKfIzFEmDTPSxa/Hg==
X-Received: by 2002:a05:6a21:3299:b0:138:2fb8:6b42 with SMTP id
 yt25-20020a056a21329900b001382fb86b42mr13014430pzb.14.1693808072551; 
 Sun, 03 Sep 2023 23:14:32 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.10])
 by smtp.gmail.com with ESMTPSA id
 x52-20020a056a000bf400b006889348ba6esm6573542pfu.127.2023.09.03.23.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 23:14:31 -0700 (PDT)
To: mst@redhat.com,
	jasowang@redhat.com,
	axboe@kernel.dk
Subject: [PATCH] virtio-blk: fix implicit overflow on virtio_max_dma_size
Date: Mon,  4 Sep 2023 14:10:45 +0800
Message-Id: <20230904061045.510460-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
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
From: zhenwei pi via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: zhenwei pi <pizhenwei@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The following codes have an implicit conversion from size_t to u32:
(u32)max_size = (size_t)virtio_max_dma_size(vdev);

This may lead overflow, Ex (size_t)4G -> (u32)0. Once
virtio_max_dma_size() has a larger size than U32_MAX, use U32_MAX
instead.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/block/virtio_blk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 1fe011676d07..4a4b9bad551e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1313,6 +1313,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
 	unsigned int queue_depth;
+	size_t max_dma_size;
 
 	if (!vdev->config->get) {
 		dev_err(&vdev->dev, "%s failure: config access disabled\n",
@@ -1411,7 +1412,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	/* No real sector limit. */
 	blk_queue_max_hw_sectors(q, UINT_MAX);
 
-	max_size = virtio_max_dma_size(vdev);
+	max_dma_size = virtio_max_dma_size(vdev);
+	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
 
 	/* Host can optionally specify maximum segment size and number of
 	 * segments. */
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
