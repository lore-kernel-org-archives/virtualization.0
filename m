Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE024A0A
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuKUC7BM"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EACA611D5
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 15:38:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EACA611D5
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JuKUC7BM
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MoQWcbOf5PWg
	for <virtualization@lists.linux-foundation.org>;
	Thu,  4 Jan 2024 15:38:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DF430611CC
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 15:38:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF430611CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704382686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jY+Y8f7msSBOyPpnVlDqciKOzAOrzUzlYnkERV/e6aE=;
	b=JuKUC7BM16pCbSK8dmnC0wBXSYn/pawjqwQz5aQs9B6PG/iWki5C5/Ggw8QUJXO7UAj+dZ
	GXXe00An9Jrenn06NmqsZkZQb7aXd95tuHiDt0DRznKFaBOZnxQFYLYqywd9hLx1y7xL4q
	Edcj1DuElQQrS9usoRhod2f/j9l2HpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-0ZYvtpH_MeCHbJRHQRxZqg-1; Thu, 04 Jan 2024 10:38:03 -0500
X-MC-Unique: 0ZYvtpH_MeCHbJRHQRxZqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1302E862F78;
	Thu,  4 Jan 2024 15:38:03 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 06558C15E6A;
	Thu,  4 Jan 2024 15:38:00 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	david.marchand@redhat.com,
	lulu@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v6 2/3] vduse: Temporarily fail if control queue features requested
Date: Thu,  4 Jan 2024 16:37:52 +0100
Message-ID: <20240104153753.2931026-3-maxime.coquelin@redhat.com>
In-Reply-To: <20240104153753.2931026-1-maxime.coquelin@redhat.com>
References: <20240104153753.2931026-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Virtio-net driver control queue implementation is not safe
when used with VDUSE. If the VDUSE application does not
reply to control queue messages, it currently ends up
hanging the kernel thread sending this command.

Some work is on-going to make the control queue
implementation robust with VDUSE. Until it is completed,
let's fail features check if any control-queue related
feature is requested.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0486ff672408..94f54ea2eb06 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -28,6 +28,7 @@
 #include <uapi/linux/virtio_config.h>
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_blk.h>
+#include <uapi/linux/virtio_ring.h>
 #include <linux/mod_devicetable.h>
 
 #include "iova_domain.h"
@@ -46,6 +47,15 @@
 
 #define IRQ_UNBOUND -1
 
+#define VDUSE_NET_INVALID_FEATURES_MASK         \
+	(BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |        \
+	 BIT_ULL(VIRTIO_NET_F_CTRL_RX)   |      \
+	 BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |      \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) | \
+	 BIT_ULL(VIRTIO_NET_F_MQ) |             \
+	 BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |  \
+	 BIT_ULL(VIRTIO_NET_F_RSS))
+
 struct vduse_virtqueue {
 	u16 index;
 	u16 num_max;
@@ -1680,6 +1690,9 @@ static bool features_is_valid(struct vduse_dev_config *config)
 	if ((config->device_id == VIRTIO_ID_BLOCK) &&
 			(config->features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE)))
 		return false;
+	else if ((config->device_id == VIRTIO_ID_NET) &&
+			(config->features & VDUSE_NET_INVALID_FEATURES_MASK))
+		return false;
 
 	return true;
 }
-- 
2.43.0

