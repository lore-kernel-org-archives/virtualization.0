Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04BFC4727D
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:24:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE7E23600
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 03:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3OgYQCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE7E23600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 213B32DE22;
	Thu, 24 Sep 2020 03:24:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UZd2RXQ8yjyq; Thu, 24 Sep 2020 03:24:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9CDFC2DE25;
	Thu, 24 Sep 2020 03:24:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A33FC0889;
	Thu, 24 Sep 2020 03:24:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FEF0C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0A2742DE25
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:24:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ud22wawm6LKF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:24:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id BDE9F2DE22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 03:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600917847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jxhWuQvQJfouIbNkDtCkuvd21/UB6/8QLtvL6jnnfc=;
 b=N3OgYQCL3nKG+qslOQDjHoIC+qA0Wdo/RhwicsGidgdACo+nysd5hKqFPGbdQQW7FnAy+4
 Ig96D0wSPRqVk2EEvf5piRvKiCG/Y82B1arOYBhavf2XA+Sh+xyVAog2rVHpnFMmJu+G+L
 NR0NuYJzdJNMOfRyIWZhyiHok3YmD8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-km9jTzOUO3mytN-x6bV2YQ-1; Wed, 23 Sep 2020 23:24:03 -0400
X-MC-Unique: km9jTzOUO3mytN-x6bV2YQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BC7A8910B7;
 Thu, 24 Sep 2020 03:24:02 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-193.pek2.redhat.com [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87CB93782;
 Thu, 24 Sep 2020 03:23:50 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH 12/24] vhost: support ASID in IOTLB API
Date: Thu, 24 Sep 2020 11:21:13 +0800
Message-Id: <20200924032125.18619-13-jasowang@redhat.com>
In-Reply-To: <20200924032125.18619-1-jasowang@redhat.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: lulu@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, eli@mellanox.com,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

This patches allows userspace to send ASID based IOTLB message to
vhost. This idea is to use the reserved u32 field in the existing V2
IOTLB message. Vhost device should advertise this capability via
VHOST_BACKEND_F_IOTLB_ASID backend feature.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c             |  5 ++++-
 drivers/vhost/vhost.c            | 23 ++++++++++++++++++-----
 drivers/vhost/vhost.h            |  4 ++--
 include/uapi/linux/vhost_types.h |  5 ++++-
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index eeefcd971e3f..6552987544d7 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -675,7 +675,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	return ret;
 }
 
-static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
+static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
 					struct vhost_iotlb_msg *msg)
 {
 	struct vhost_vdpa *v = container_of(dev, struct vhost_vdpa, vdev);
@@ -684,6 +684,9 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 	struct vhost_iotlb *iotlb = v->iotlb;
 	int r = 0;
 
+	if (asid != 0)
+		return -EINVAL;
+
 	r = vhost_dev_check_owner(dev);
 	if (r)
 		return r;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b45519ca66a7..060662b12de3 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -463,7 +463,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		    struct vhost_virtqueue **vqs, int nvqs,
 		    int iov_limit, int weight, int byte_weight,
 		    bool use_worker,
-		    int (*msg_handler)(struct vhost_dev *dev,
+		    int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 				       struct vhost_iotlb_msg *msg))
 {
 	struct vhost_virtqueue *vq;
@@ -1079,11 +1079,14 @@ static bool umem_access_ok(u64 uaddr, u64 size, int access)
 	return true;
 }
 
-static int vhost_process_iotlb_msg(struct vhost_dev *dev,
+static int vhost_process_iotlb_msg(struct vhost_dev *dev, u16 asid,
 				   struct vhost_iotlb_msg *msg)
 {
 	int ret = 0;
 
+	if (asid != 0)
+		return -EINVAL;
+
 	mutex_lock(&dev->mutex);
 	vhost_dev_lock_vqs(dev);
 	switch (msg->type) {
@@ -1130,6 +1133,7 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 	struct vhost_iotlb_msg msg;
 	size_t offset;
 	int type, ret;
+	u16 asid = 0;
 
 	ret = copy_from_iter(&type, sizeof(type), from);
 	if (ret != sizeof(type)) {
@@ -1145,7 +1149,16 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 		offset = offsetof(struct vhost_msg, iotlb) - sizeof(int);
 		break;
 	case VHOST_IOTLB_MSG_V2:
-		offset = sizeof(__u32);
+		if (vhost_backend_has_feature(dev->vqs[0],
+					      VHOST_BACKEND_F_IOTLB_ASID)) {
+			ret = copy_from_iter(&asid, sizeof(asid), from);
+			if (ret != sizeof(asid)) {
+				ret = -EINVAL;
+				goto done;
+			}
+			offset = sizeof(__u16);
+		} else
+			offset = sizeof(__u32);
 		break;
 	default:
 		ret = -EINVAL;
@@ -1160,9 +1173,9 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 	}
 
 	if (dev->msg_handler)
-		ret = dev->msg_handler(dev, &msg);
+		ret = dev->msg_handler(dev, asid, &msg);
 	else
-		ret = vhost_process_iotlb_msg(dev, &msg);
+		ret = vhost_process_iotlb_msg(dev, asid, &msg);
 	if (ret) {
 		ret = -EFAULT;
 		goto done;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 9032d3c2a9f4..05e7aaf6071b 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -162,7 +162,7 @@ struct vhost_dev {
 	int byte_weight;
 	u64 kcov_handle;
 	bool use_worker;
-	int (*msg_handler)(struct vhost_dev *dev,
+	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
 };
 
@@ -170,7 +170,7 @@ bool vhost_exceeds_weight(struct vhost_virtqueue *vq, int pkts, int total_len);
 void vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue **vqs,
 		    int nvqs, int iov_limit, int weight, int byte_weight,
 		    bool use_worker,
-		    int (*msg_handler)(struct vhost_dev *dev,
+		    int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 				       struct vhost_iotlb_msg *msg));
 long vhost_dev_set_owner(struct vhost_dev *dev);
 bool vhost_dev_has_owner(struct vhost_dev *dev);
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 532571571b4b..2eb55fc9bf2e 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -87,7 +87,7 @@ struct vhost_msg {
 
 struct vhost_msg_v2 {
 	__u32 type;
-	__u32 reserved;
+	__u32 asid;
 	union {
 		struct vhost_iotlb_msg iotlb;
 		__u8 padding[64];
@@ -148,5 +148,8 @@ struct vhost_vdpa_config {
 #define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
 /* IOTLB can accept batching hints */
 #define VHOST_BACKEND_F_IOTLB_BATCH  0x2
+/* IOTLB can accept address space identifier through V2 type of IOTLB
+   message */
+#define VHOST_BACKEND_F_IOTLB_ASID  0x3
 
 #endif
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
