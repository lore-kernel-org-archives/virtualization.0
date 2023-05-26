Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C3FC7EE23
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 05:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C623F42885;
	Fri, 26 May 2023 05:47:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C623F42885
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=nNoB88r0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q5UYhY4FmOQP; Fri, 26 May 2023 05:47:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 012744287B;
	Fri, 26 May 2023 05:47:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 012744287B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D03E7C0036;
	Fri, 26 May 2023 05:47:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBC2FC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 05:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89C4241CDC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 05:47:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89C4241CDC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=nNoB88r0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FYSCXj3WvGDl
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 05:47:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE868410A9
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE868410A9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 05:47:12 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d2c865e4eso456827b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 22:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685080032; x=1687672032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+O7euCPhXRepDDaePXuwLJp753j925icSBiznXzRFmA=;
 b=nNoB88r0OJ7b2UzUBLRiGdAodjTSq3AZjkiQhtf8Y8TutlQqSB1g++Mc+IucdgTh3o
 S5uU+8dz0pfype82L0zue8+9At70bDhKb7E5s+SUQATlJkF36MkcC9vBgdz4IZZSJs/4
 wnGZFmrIkc+lAKT2wxrR+zQOEZ/LGISn/KavaN687F0x31YgpbSLjvMgPtvhs7JFZ7sy
 KI2cPK9US0BzLxS8GdQJN8QmuFL6WW7H0aLfqfryzNzPvEld/e6H7X5ssPsVCr0/xOhu
 BTw8gMQwZuYCY6d16abpxbidXVJ+dvniHk89m5aXYZIZ8dpcQhS5XhZAkdbOT4oTVpqu
 H2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685080032; x=1687672032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+O7euCPhXRepDDaePXuwLJp753j925icSBiznXzRFmA=;
 b=Tb+2e4cs1ObWHlmRE43XJGgmvNU3BbFAduaG1d21LZnIjgFxVe0pZy3MUJXlxhcalr
 QZ6fABpHuYKuxN61xQE1X0qRfir/STemhFp1zhML3MLcnq6S/wzX6YQmPhI3VQ1jSSlo
 uiczus+7jKmPfdF/cOh/aHNXBJ7xy3FC3LxIu4mAdCnOBAufjYL7k60hjlFGFpeQqI4C
 Tmvnw1nQsjk0o3AJTigpNoVkRreALUh0qcW0ahk/PmKh3wIsc1DvrqS4PN0EGOS7Cvjr
 E0KCX2x6J8x98FfbF9sBJGq75YeA6Qv319g5UBghWl2191i53bkWfgUmAysm9YTQ/ydx
 JL5A==
X-Gm-Message-State: AC+VfDxUv9qFS+JSXGnUU3tmwKuz42SNDU1DqQvxfWuX5HsKRl1pwSqt
 tZjJOfDeWWeAxoQEJqnzF0o=
X-Google-Smtp-Source: ACHHUZ4LXB/H4JL3WsCpADYGbGBaZt0SRNpsY+rWwEUkolUcHbcEx0swUqfbbOVzMRVc3s0GS8adDA==
X-Received: by 2002:a05:6a20:8421:b0:10c:7676:73af with SMTP id
 c33-20020a056a20842100b0010c767673afmr778211pzd.53.1685080032355; 
 Thu, 25 May 2023 22:47:12 -0700 (PDT)
Received: from localhost.localdomain ([104.149.188.130])
 by smtp.gmail.com with ESMTPSA id
 b23-20020a6567d7000000b0050a0227a4bcsm1836485pgs.57.2023.05.25.22.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 22:47:11 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH net-next 5/5] virtio_net: Implement DMA pre-handler
Date: Fri, 26 May 2023 13:46:21 +0800
Message-Id: <20230526054621.18371-5-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230526054621.18371-1-liangchen.linux@gmail.com>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
MIME-Version: 1.0
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

Adding a DMA pre-handler that utilizes page pool for managing DMA mappings.
When IOMMU is enabled, turning on the page_pool_dma_map module parameter to
select page pool for DMA mapping management gives a significant reduction
in the overhead caused by DMA mappings.

In testing environments with a single core vm and qemu emulated IOMMU,
significant performance improvements can be observed:
  Upstream codebase: 1.76 Gbits/sec
  Upstream codebase with page pool fragmentation support: 1.81 Gbits/sec
  Upstream codebase with page pool fragmentation and DMA support: 19.3
  Gbits/sec

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/virtio_net.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ac40b8c66c59..73cc4f9fe4fa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -22,6 +22,7 @@
 #include <net/route.h>
 #include <net/xdp.h>
 #include <net/net_failover.h>
+#include <linux/iommu.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -33,8 +34,10 @@ module_param(napi_tx, bool, 0644);
 
 static bool page_pool_enabled;
 static bool page_pool_frag;
+static bool page_pool_dma_map;
 module_param(page_pool_enabled, bool, 0400);
 module_param(page_pool_frag, bool, 0400);
+module_param(page_pool_dma_map, bool, 0400);
 
 /* FIXME: MTU in config. */
 #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
@@ -3830,6 +3833,49 @@ static void virtnet_del_vqs(struct virtnet_info *vi)
 	virtnet_free_queues(vi);
 }
 
+static dma_addr_t virtnet_pp_dma_map_page(struct device *dev, struct page *page,
+					  unsigned long offset, size_t size,
+					  enum dma_data_direction dir, unsigned long attrs)
+{
+	struct page *head_page;
+
+	if (dir != DMA_FROM_DEVICE)
+		return 0;
+
+	head_page = compound_head(page);
+	return page_pool_get_dma_addr(head_page)
+		+ (page - head_page) * PAGE_SIZE
+		+ offset;
+}
+
+static bool virtnet_pp_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
+				      size_t size, enum dma_data_direction dir,
+				      unsigned long attrs)
+{
+	phys_addr_t phys;
+
+	/* Handle only the RX direction, and sync the DMA memory only if it's not
+	 * a DMA coherent architecture.
+	 */
+	if (dir != DMA_FROM_DEVICE)
+		return false;
+
+	if (dev_is_dma_coherent(dev))
+		return true;
+
+	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
+	if (WARN_ON(!phys))
+		return false;
+
+	arch_sync_dma_for_cpu(phys, size, dir);
+	return true;
+}
+
+static struct virtqueue_pre_dma_ops virtnet_pp_pre_dma_ops = {
+	.map_page = virtnet_pp_dma_map_page,
+	.unmap_page = virtnet_pp_dma_unmap_page,
+};
+
 static void virtnet_alloc_page_pool(struct receive_queue *rq)
 {
 	struct virtio_device *vdev = rq->vq->vdev;
@@ -3845,6 +3891,15 @@ static void virtnet_alloc_page_pool(struct receive_queue *rq)
 	if (page_pool_frag)
 		pp_params.flags |= PP_FLAG_PAGE_FRAG;
 
+	/* Consider using page pool DMA support only when DMA API is used. */
+	if (virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM) &&
+	    page_pool_dma_map) {
+		pp_params.flags |= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+		pp_params.dma_dir = DMA_FROM_DEVICE;
+		pp_params.max_len = PAGE_SIZE << pp_params.order;
+		virtqueue_register_pre_dma_ops(rq->vq, &virtnet_pp_pre_dma_ops);
+	}
+
 	rq->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(rq->page_pool)) {
 		dev_warn(&vdev->dev, "page pool creation failed: %ld\n",
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
