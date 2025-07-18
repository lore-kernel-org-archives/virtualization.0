Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B54289E2D
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825231; cv=none; b=hRYXGSaqbDMv/j53N1uUQPMfD1yvkurbJwXI3rE3lWivr7/xEmG5hE4AtVcZDF/zQmNih3OXI7/fXJkYUr4zoHbFNrziFLWJ36fZ3qfZyriNB0w4IlgBOzungivOOzuFMC1wnE7ZRgkUG/Jg9zuHI8I2WVnO8iSDEmB17LNv2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825231; c=relaxed/simple;
	bh=StCemv/MRCw4cOuxOU1TBBxuq1qT851o/lQbuMDeemE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=IbaH8pXLHsXQNvOvUBJI8bVdZ1KGWK+SvF/Bschf//1C/jm+TAhBDMfhhhoL32uAUfzi0JpSa7fhf0YF8Xd2lEVq8JYBTDYSWubEvvQ8n7zWSuBNHPS5sJzFh4+yILHOc+9xzgry2VknAGBjea+cfbcuLsUj/xtRGHlZ0k5lWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKFSySd8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKFSySd8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752825228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j4g9Zv2QTNSYx+kXeXlIisv0kT2T7YT/xTLfTnXPJjI=;
	b=PKFSySd8E7Eo5zUVQSI6WGhaMjxGTafD4O72T6Jc7sUya9mBGMw6j7d040LXFFBMCSXbDO
	ql6Fq+3RfpSwQRonaS3tqnHjTxYmuwa9HfvBqFE9BW5z7gKt8hnAqzF51E1faeJwCUEq/F
	RejExtkQQb43IUX09XWOiBBalZj+Aso=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-nBTxvXDHOD6LqRM7tzSYgA-1; Fri,
 18 Jul 2025 03:53:46 -0400
X-MC-Unique: nBTxvXDHOD6LqRM7tzSYgA-1
X-Mimecast-MFC-AGG-ID: nBTxvXDHOD6LqRM7tzSYgA_1752825225
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AABE1800165;
	Fri, 18 Jul 2025 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3501195608D;
	Fri, 18 Jul 2025 07:53:40 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org
Subject: [PATCH] vduse: drop depedencies for HAS_DMA and ARCH_HAS_DMA_OPS
Date: Fri, 18 Jul 2025 15:53:36 +0800
Message-ID: <20250718075336.4374-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iRk_b8Xe1nmDo5mV6_Qq-_XETYhqrf3l3zRk1JbgYw8_1752825225
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After commit c2dbb3fc2a97 ("vduse: switch to use virtio map API
instead of DMA API"), vduse doesn't use DMA API. So we can safely drop
the depedencies for HAS_DMA and ARCH_HAS_DMA_OPS.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/Kconfig | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 559fb9d3271f..857cf288c876 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -34,13 +34,7 @@ config VDPA_SIM_BLOCK
 
 config VDPA_USER
 	tristate "VDUSE (vDPA Device in Userspace) support"
-	depends on EVENTFD && MMU && HAS_DMA
-	#
-	# This driver incorrectly tries to override the dma_ops.  It should
-	# never have done that, but for now keep it working on architectures
-	# that use dma ops
-	#
-	depends on ARCH_HAS_DMA_OPS
+	depends on EVENTFD && MMU
 	select VHOST_IOTLB
 	select IOMMU_IOVA
 	help
-- 
2.47.3

