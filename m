Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C495EB64DA
	for <virtualization@archiver.kernel.org>; Wed,  5 Jul 2023 10:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2115140526;
	Wed,  5 Jul 2023 10:04:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2115140526
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Haf07Cay
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yb0_-39QCnSW; Wed,  5 Jul 2023 10:04:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A3362400D9;
	Wed,  5 Jul 2023 10:04:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3362400D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8ACD2C0072;
	Wed,  5 Jul 2023 10:04:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1477CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 10:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 607DE40498
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 10:04:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 607DE40498
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fLpVWqVphDvR
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 10:04:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9BE4B4020B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9BE4B4020B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jul 2023 10:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688551486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hwC5y47T6/UzpMniXD0dlaNgSU/p+1EVDrFsA80r7Q=;
 b=Haf07Cay7BxZODGjV7vciuoahkwyB+6fB8VHiTE7FfXiavSA16pj3IZfWrlCkaB8wAa1Fl
 /5IAHopQ/HKY3+5cg2ONsDGMG9a4UfPTp4HRj7dJ3loZkEQrhRDt9ez7Qb2VPSK4gjkhLP
 lgA1/fGT8jS5VP+sdbiDFlYAod2pk/E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-cO98A2tqP06Uvdywyz-xNQ-1; Wed, 05 Jul 2023 06:04:43 -0400
X-MC-Unique: cO98A2tqP06Uvdywyz-xNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D85BF1C172AB;
 Wed,  5 Jul 2023 10:04:42 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 813FE4021523;
 Wed,  5 Jul 2023 10:04:40 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: xieyongji@bytedance.com, jasowang@redhat.com, mst@redhat.com,
 david.marchand@redhat.com, lulu@redhat.com
Subject: [PATCH v3 3/3] vduse: Temporarily disable control queue features
Date: Wed,  5 Jul 2023 12:04:30 +0200
Message-ID: <20230705100430.61927-4-maxime.coquelin@redhat.com>
In-Reply-To: <20230705100430.61927-1-maxime.coquelin@redhat.com>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>
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
let's filter out control virtqueue and features that depend
on it by keeping only features known to be supported.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 1271c9796517..7345071db0a8 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -46,6 +46,30 @@
 
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
+	 BIT_ULL(VIRTIO_F_EVENT_IDX) |          \
+	 BIT_ULL(VIRTIO_F_VERSION_1) |          \
+	 BIT_ULL(VIRTIO_F_IOMMU_PLATFORM) |     \
+	 BIT_ULL(VIRTIO_F_RING_PACKED) |        \
+	 BIT_ULL(VIRTIO_F_IN_ORDER))
+
 struct vduse_virtqueue {
 	u16 index;
 	u16 num_max;
@@ -1778,6 +1802,16 @@ static struct attribute *vduse_dev_attrs[] = {
 
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
@@ -1793,6 +1827,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
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
