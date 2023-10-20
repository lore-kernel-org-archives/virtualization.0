Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFFEC001DF
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 15:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5ABFC4EE6A;
	Fri, 20 Oct 2023 15:58:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5ABFC4EE6A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qli7GSVp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O2RzTOy-5yUg; Fri, 20 Oct 2023 15:58:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A49E84EE65;
	Fri, 20 Oct 2023 15:58:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A49E84EE65
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73F6EC0071;
	Fri, 20 Oct 2023 15:58:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96BF7C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 15:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65EB2705A6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 15:58:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65EB2705A6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qli7GSVp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zKhYakyM8V-5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 15:58:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 801D0705A5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 15:58:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 801D0705A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697817522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/YaH8GqSCmsbSQK65aeluJxBiMUQ9PtkPz8wZaXPjys=;
 b=Qli7GSVpdmbhpCjfc1IHG0D4iLAscasNA/flZE+/Z+Zx/di4aXjsXUNNn6SJcxzmrhcPk4
 rZivZPnbnXEP+AEUQrCDlpRHaKsuw0uBNaGk9I0VTLbEtvIE9jbTDbM6t5WK0n9OV7KCei
 FUfvYKXUBPKLt6prFaOnNaEnagn+MPg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-GcMYqtHEOs6LTSLRuNoADw-1; Fri, 20 Oct 2023 11:58:39 -0400
X-MC-Unique: GcMYqtHEOs6LTSLRuNoADw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F7E33C28647;
 Fri, 20 Oct 2023 15:58:39 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 219DB10828;
 Fri, 20 Oct 2023 15:58:35 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 stephen.smalley.work@gmail.com, eparis@parisplace.org,
 xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, david.marchand@redhat.com, lulu@redhat.com
Subject: [PATCH v4 3/4] vduse: Temporarily disable control queue features
Date: Fri, 20 Oct 2023 17:58:18 +0200
Message-ID: <20231020155819.24000-4-maxime.coquelin@redhat.com>
In-Reply-To: <20231020155819.24000-1-maxime.coquelin@redhat.com>
References: <20231020155819.24000-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
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

Virtio-net driver control queue implementation is not safe
when used with VDUSE. If the VDUSE application does not
reply to control queue messages, it currently ends up
hanging the kernel thread sending this command.

Some work is on-going to make the control queue
implementation robust with VDUSE. Until it is completed,
let's disable control virtqueue and features that depend on
it.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 73ad3b7efd8e..0243dee9cf0e 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -28,6 +28,7 @@
 #include <uapi/linux/virtio_config.h>
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_blk.h>
+#include <uapi/linux/virtio_ring.h>
 #include <linux/mod_devicetable.h>
 
 #include "iova_domain.h"
@@ -46,6 +47,30 @@
 
 #define IRQ_UNBOUND -1
 
+#define VDUSE_NET_VALID_FEATURES_MASK           \
+	(BIT_ULL(VIRTIO_NET_F_CSUM) |           \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |     \
+	 BIT_ULL(VIRTIO_NET_F_MTU) |            \
+	 BIT_ULL(VIRTIO_NET_F_MAC) |            \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |     \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |     \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |      \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |      \
+	 BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |      \
+	 BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |      \
+	 BIT_ULL(VIRTIO_NET_F_HOST_ECN) |       \
+	 BIT_ULL(VIRTIO_NET_F_HOST_UFO) |       \
+	 BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |      \
+	 BIT_ULL(VIRTIO_NET_F_STATUS) |         \
+	 BIT_ULL(VIRTIO_NET_F_HOST_USO) |       \
+	 BIT_ULL(VIRTIO_F_ANY_LAYOUT) |         \
+	 BIT_ULL(VIRTIO_RING_F_INDIRECT_DESC) | \
+	 BIT_ULL(VIRTIO_RING_F_EVENT_IDX) |          \
+	 BIT_ULL(VIRTIO_F_VERSION_1) |          \
+	 BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |     \
+	 BIT_ULL(VIRTIO_F_RING_PACKED) |        \
+	 BIT_ULL(VIRTIO_F_IN_ORDER))
+
 struct vduse_virtqueue {
 	u16 index;
 	u16 num_max;
@@ -1778,6 +1803,16 @@ static struct attribute *vduse_dev_attrs[] = {
 
 ATTRIBUTE_GROUPS(vduse_dev);
 
+static void vduse_dev_features_filter(struct vduse_dev_config *config)
+{
+	/*
+	 * Temporarily filter out virtio-net's control virtqueue and features
+	 * that depend on it while CVQ is being made more robust for VDUSE.
+	 */
+	if (config->device_id == VIRTIO_ID_NET)
+		config->features &= VDUSE_NET_VALID_FEATURES_MASK;
+}
+
 static int vduse_create_dev(struct vduse_dev_config *config,
 			    void *config_buf, u64 api_version)
 {
@@ -1793,6 +1828,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	if (!dev)
 		goto err;
 
+	vduse_dev_features_filter(config);
+
 	dev->api_version = api_version;
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
