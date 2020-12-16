Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC322C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:49:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5595923370
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5595923370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0BA9786A54;
	Wed, 16 Dec 2020 06:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gv5uEPTw0cuz; Wed, 16 Dec 2020 06:49:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6D55D868A2;
	Wed, 16 Dec 2020 06:49:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 592CFC0893;
	Wed, 16 Dec 2020 06:49:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6A81C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E233487339
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nrgn7Gl+h7P8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2DE59872FC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608101379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ziqdhg3Ply9fENsVm5Em6CyO6Z4ll+1ewm9A2bIY6MA=;
 b=CL/rciBIbcYHeIiwH+O4LZ/nmHSqi4EWtT3/ZRYkRFj605Nnv6tYWOyq4Mxc/0QvXqVCvZ
 9o3dMn2H27kWVTgNBOREDXtl+GxaUZZCgnb7Q/WSyeQ0Ov5OVs3GUJLmmSjamXPZWsstwV
 2tIa/8rAQfJFP55q+3qaLIuQGvHFN/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-5n3tSKaEMeCbSOBOL3qcwQ-1; Wed, 16 Dec 2020 01:49:37 -0500
X-MC-Unique: 5n3tSKaEMeCbSOBOL3qcwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93501107ACE4;
 Wed, 16 Dec 2020 06:49:35 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-210.pek2.redhat.com [10.72.12.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 864A210013C1;
 Wed, 16 Dec 2020 06:49:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 10/21] vhost: support ASID in IOTLB API
Date: Wed, 16 Dec 2020 14:48:07 +0800
Message-Id: <20201216064818.48239-11-jasowang@redhat.com>
In-Reply-To: <20201216064818.48239-1-jasowang@redhat.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, lulu@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com, eli@mellanox.com,
 lingshan.zhu@intel.com, rob.miller@broadcom.com
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
index 03a9b3311c6c..feb6a58df22d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -739,7 +739,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	return ret;
 }
 
-static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
+static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
 					struct vhost_iotlb_msg *msg)
 {
 	struct vhost_vdpa *v = container_of(dev, struct vhost_vdpa, vdev);
@@ -748,6 +748,9 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 	struct vhost_iotlb *iotlb = v->iotlb;
 	int r = 0;
 
+	if (asid != 0)
+		return -EINVAL;
+
 	r = vhost_dev_check_owner(dev);
 	if (r)
 		return r;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a262e12c6dc2..7477b724c29b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -468,7 +468,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		    struct vhost_virtqueue **vqs, int nvqs,
 		    int iov_limit, int weight, int byte_weight,
 		    bool use_worker,
-		    int (*msg_handler)(struct vhost_dev *dev,
+		    int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 				       struct vhost_iotlb_msg *msg))
 {
 	struct vhost_virtqueue *vq;
@@ -1084,11 +1084,14 @@ static bool umem_access_ok(u64 uaddr, u64 size, int access)
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
@@ -1135,6 +1138,7 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 	struct vhost_iotlb_msg msg;
 	size_t offset;
 	int type, ret;
+	u16 asid = 0;
 
 	ret = copy_from_iter(&type, sizeof(type), from);
 	if (ret != sizeof(type)) {
@@ -1150,7 +1154,16 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
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
@@ -1165,9 +1178,9 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
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
index b063324c7669..19753a90875c 100644
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
index 76ee7016c501..222fc66ce2ac 100644
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
@@ -157,5 +157,8 @@ struct vhost_vdpa_iova_range {
 #define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
 /* IOTLB can accept batching hints */
 #define VHOST_BACKEND_F_IOTLB_BATCH  0x2
+/* IOTLB can accept address space identifier through V2 type of IOTLB
+   message */
+#define VHOST_BACKEND_F_IOTLB_ASID  0x3
 
 #endif
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
