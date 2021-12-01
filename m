Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A26DC433F5
	for <virtualization@archiver.kernel.org>; Wed,  1 Dec 2021 11:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 221994020B;
	Wed,  1 Dec 2021 11:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8jkTtcwvwyq1; Wed,  1 Dec 2021 11:20:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 939A7400D1;
	Wed,  1 Dec 2021 11:20:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55608C0012;
	Wed,  1 Dec 2021 11:20:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81945C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 11:20:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B1EE81A73
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 11:20:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m38TMeUNHERs
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 11:20:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A597981A6A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 11:20:33 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 104AFCE1DCC;
 Wed,  1 Dec 2021 11:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7584C53FAD;
 Wed,  1 Dec 2021 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638357625;
 bh=h4pe6R3IKPLJE7gAZEY/78vP3LYUKYBWeqawkRntwQg=;
 h=From:To:Cc:Subject:Date:From;
 b=rqqFWwbSSaAMiyYSJOyFLyotOWNhV3ERbAJDmUBeWTjkRLj5UfTrkBwuuqBO8cSZw
 Tj180waDZ1dHfzfe8DHOo2dPaom9ddarw0WhcTuGNil42e+8sMxd9C6RDeAAn/n8Jm
 0UFyINaz4IQPr237FbFAAZ4m2qMNn7caiyA+6vW0DIi11I9l9XiX3iVuUZ3u4Nqyc7
 vmJ6LrXaI1L/h8hdiykTW/P4rHbDsJJ9zgZb5+pCpxB8SHNjVzzHeQvVOWv7vdxKk8
 3n7qU96pZg+Rkp+9hg1QzKDNyfkgULq27IToMUawE/ce2MNQnNNQOTZiWTI4qI5dqy
 ZrReUmphWF8gw==
From: Will Deacon <will@kernel.org>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_ring: Fix querying of maximum DMA mapping size for
 virtio device
Date: Wed,  1 Dec 2021 11:20:18 +0000
Message-Id: <20211201112018.25276-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Quentin Perret <qperret@google.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>
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

virtio_max_dma_size() returns the maximum DMA mapping size of the virtio
device by querying dma_max_mapping_size() for the device when the DMA
API is in use for the vring. Unfortunately, the device passed is
initialised by register_virtio_device() and does not inherit the DMA
configuration from its parent, resulting in SWIOTLB errors when bouncing
is enabled and the default 256K mapping limit (IO_TLB_SEGSIZE) is not
respected:

  | virtio-pci 0000:00:01.0: swiotlb buffer is full (sz: 294912 bytes), total 1024 (slots), used 725 (slots)

Follow the pattern used elsewhere in the virtio_ring code when calling
into the DMA layer and pass the parent device to dma_max_mapping_size()
instead.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6d2614e34470..028b05d44546 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -268,7 +268,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
 	size_t max_segment_size = SIZE_MAX;
 
 	if (vring_use_dma_api(vdev))
-		max_segment_size = dma_max_mapping_size(&vdev->dev);
+		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
 
 	return max_segment_size;
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
