Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22749C77B75
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 02:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B415846B3;
	Wed, 10 May 2023 02:56:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B415846B3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=AJvosUCn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HgEf-yfBIg5a; Wed, 10 May 2023 02:56:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7D24846E4;
	Wed, 10 May 2023 02:56:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7D24846E4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98785C0037;
	Wed, 10 May 2023 02:56:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 946EBC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 02:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6953F60EB8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 02:56:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6953F60EB8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=AJvosUCn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rPUg3u39MBjh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 02:56:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F0CD60E6F
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F0CD60E6F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 02:56:42 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6439b410679so4245308b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 May 2023 19:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1683687401; x=1686279401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hTSesuixdo5vZ8I9+v28R7iSHBf2PWhulvCTlSJ6srA=;
 b=AJvosUCnaL7DVrTLt0wEHVdYm9nezT1Xn8WsRYZ5yIuyP3499YqOnLadpQLSAn9yt2
 05U+onyUhUO0mNusq+LU34DX+jo3WaPD3xduRVgLNMAF77mNjHIkNOYFHbwMi2ZH2trk
 WPZ9SWFvn+9Oms0zV++Xge+Rah4vggZDy/1Uo3NnXa+zOnJLgi0MH0+/ob20TT8QWfu1
 +J9vUcfhAUXHBr43YbyXF3BjQRTXP98x9z9WWJpyRvW/zsSk21J5ZhzoJQPAtU2vN7IN
 xvHx8OiV3wiV9PenK6h+w2quENNK8h/hjJOEtp1BW6HfgIuiAPKYOvDkMTW2ow/8lFG0
 T2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683687401; x=1686279401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hTSesuixdo5vZ8I9+v28R7iSHBf2PWhulvCTlSJ6srA=;
 b=Srx7t06KbV9ficBWiKF7GGmu2MRTOuubbs7Gc+useHoimSFgzojSPCIx1i40/2j0cn
 CiyK5tWL/IwnX9hkKfwOAUAZ9UVT5/D2DRXhevxfZvnkzlSH0YjVD1ray1T+Aw7nJb8S
 MFHc8wlzFOt0usDIxOuM8bgjqq9zz3/K+RZoKdPyMgkysQm7B+klPkMmGymzWMLsIzkM
 vo/keBdshtw23Gjpg53JkCtxdb/m9jEJxdY0KrrQUeEct17xK3iRgtwt/xro4B0wZbx2
 eLtWwJ7P4AtbJ70RaNfmkJ210sEiod6mpKXFu5KMrXKOpb+AUes3HdzbTllmtdrQOqVA
 sVbQ==
X-Gm-Message-State: AC+VfDyEoiKKwO6Bf7X/xjthPXx8eJweIb8zTS1Nut5YqkOXyc5TTh7q
 P9AD/zGt6GVJdzYmsD+P8razJg==
X-Google-Smtp-Source: ACHHUZ7epXyNWWiXW4YoeAFuCY/XUA4Zk4Pul30toUu70L0SWA9Ls5aa6OrepD3ODL0dvoiAKxTHbw==
X-Received: by 2002:a05:6a20:4421:b0:101:914e:da75 with SMTP id
 ce33-20020a056a20442100b00101914eda75mr3401063pzb.25.1683687401584; 
 Tue, 09 May 2023 19:56:41 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.13])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a63e14d000000b00524cfd635cesm2083080pgk.69.2023.05.09.19.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 May 2023 19:56:41 -0700 (PDT)
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Date: Wed, 10 May 2023 10:54:37 +0800
Message-Id: <20230510025437.377807-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: xuanzhuo@linux.alibaba.com, Joerg Roedel <jroedel@suse.de>,
 linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>,
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

Both split ring and packed ring use 32bits to describe the length of
a descriptor: see struct vring_desc and struct vring_packed_desc.
This means the max segment size supported by virtio is U32_MAX.

An example of virtio_max_dma_size in virtio_blk.c:
  u32 v, max_size;

  max_size = virtio_max_dma_size(vdev);  -> implicit convert
  err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
                             struct virtio_blk_config, size_max, &v);
  max_size = min(max_size, v);

There is a risk during implicit convert here, once virtio_max_dma_size
returns 4G, max_size becomes 0.

Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++++----
 include/linux/virtio.h       |  2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c5310eaf8b46..55cfecf030a1 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -289,12 +289,16 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
 	return false;
 }
 
-size_t virtio_max_dma_size(const struct virtio_device *vdev)
+u32 virtio_max_dma_size(const struct virtio_device *vdev)
 {
-	size_t max_segment_size = SIZE_MAX;
+	u32 max_segment_size = U32_MAX;
 
-	if (vring_use_dma_api(vdev))
-		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
+	if (vring_use_dma_api(vdev)) {
+		size_t max_dma_size = dma_max_mapping_size(vdev->dev.parent);
+
+		if (max_dma_size < max_segment_size)
+			max_segment_size = max_dma_size;
+	}
 
 	return max_segment_size;
 }
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b93238db94e3..1a605f408329 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *dev);
 #endif
 void virtio_reset_device(struct virtio_device *dev);
 
-size_t virtio_max_dma_size(const struct virtio_device *vdev);
+u32 virtio_max_dma_size(const struct virtio_device *vdev);
 
 #define virtio_device_for_each_vq(vdev, vq) \
 	list_for_each_entry(vq, &vdev->vqs, list)
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
