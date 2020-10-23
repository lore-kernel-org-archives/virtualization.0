Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7552C4363A
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 02:25:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3992421556
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 02:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAM8F9T8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3992421556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BB6B986D38;
	Fri, 23 Oct 2020 02:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oQqLcSuemf1t; Fri, 23 Oct 2020 02:25:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 32F9E86709;
	Fri, 23 Oct 2020 02:25:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C722C08A1;
	Fri, 23 Oct 2020 02:25:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09C9AC0052
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 02:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ECD5C877C3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 02:25:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GdCZagjZctZr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 02:25:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E3503877AC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 02:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603419928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOE97Kgy2/CEcg3VYJ3JC+svlXGnVF61v/gPcb/O0qY=;
 b=NAM8F9T8EF837tvyPPZ38+rawSX8Uce2SzKIk1gEBZT54fvcltOQL2Ibdd+YGWtdAihHvQ
 cKqd+HnsvnojWDLbJYVB9G0UkjroIuQvbzcSg53x5oQBPGVB7+SeEx9/UUV+SfElCyYxJH
 3cVvfz8ssC7IGWrNkKgipjsalhjsFDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-89qbrNWcONqyIxd3b0aNkQ-1; Thu, 22 Oct 2020 22:25:26 -0400
X-MC-Unique: 89qbrNWcONqyIxd3b0aNkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4EFE1084C93;
 Fri, 23 Oct 2020 02:25:24 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-85.pek2.redhat.com [10.72.13.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D32155770;
 Fri, 23 Oct 2020 02:25:15 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] vhost: vdpa: report iova range
Date: Fri, 23 Oct 2020 10:24:53 +0800
Message-Id: <20201023022454.24402-3-jasowang@redhat.com>
In-Reply-To: <20201023022454.24402-1-jasowang@redhat.com>
References: <20201023022454.24402-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, gdawar@xilinx.com,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

This patch introduces a new ioctl for vhost-vdpa device that can
report the iova range by the device.

For device that implements get_iova_range() method, we fetch it from
the vDPA device. If device doesn't implement get_iova_range() but
depends on platform IOMMU, we will query via DOMAIN_ATTR_GEOMETRY,
otherwise [0, ULLONG_MAX] is assumed.

For safety, this patch also rules out the map request which is not in
the valid range.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c             | 40 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost.h       |  4 ++++
 include/uapi/linux/vhost_types.h |  9 +++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a2dbc85e0b0d..562ed99116d1 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -47,6 +47,7 @@ struct vhost_vdpa {
 	int minor;
 	struct eventfd_ctx *config_ctx;
 	int in_batch;
+	struct vdpa_iova_range range;
 };
 
 static DEFINE_IDA(vhost_vdpa_ida);
@@ -337,6 +338,16 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
 	return 0;
 }
 
+static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
+{
+	struct vhost_vdpa_iova_range range = {
+		.first = v->range.first,
+		.last = v->range.last,
+	};
+
+	return copy_to_user(argp, &range, sizeof(range));
+}
+
 static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				   void __user *argp)
 {
@@ -470,6 +481,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_GET_BACKEND_FEATURES:
 		features = VHOST_VDPA_BACKEND_FEATURES;
 		r = copy_to_user(featurep, &features, sizeof(features));
+	case VHOST_VDPA_GET_IOVA_RANGE:
+		r = vhost_vdpa_get_iova_range(v, argp);
 		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
@@ -597,6 +610,10 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	long pinned;
 	int ret = 0;
 
+	if (msg->iova < v->range.first ||
+	    msg->iova + msg->size - 1 > v->range.last)
+		return -EINVAL;
+
 	if (vhost_iotlb_itree_first(iotlb, msg->iova,
 				    msg->iova + msg->size - 1))
 		return -EEXIST;
@@ -783,6 +800,27 @@ static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
 	v->domain = NULL;
 }
 
+static void vhost_vdpa_set_iova_range(struct vhost_vdpa *v)
+{
+	struct vdpa_iova_range *range = &v->range;
+	struct iommu_domain_geometry geo;
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (ops->get_iova_range) {
+		*range = ops->get_iova_range(vdpa);
+	} else if (v->domain &&
+		   !iommu_domain_get_attr(v->domain,
+		   DOMAIN_ATTR_GEOMETRY, &geo) &&
+		   geo.force_aperture) {
+		range->first = geo.aperture_start;
+		range->last = geo.aperture_end;
+	} else {
+		range->first = 0;
+		range->last = ULLONG_MAX;
+	}
+}
+
 static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 {
 	struct vhost_vdpa *v;
@@ -823,6 +861,8 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 	if (r)
 		goto err_init_iotlb;
 
+	vhost_vdpa_set_iova_range(v);
+
 	filep->private_data = v;
 
 	return 0;
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 75232185324a..c998860d7bbc 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -146,4 +146,8 @@
 
 /* Set event fd for config interrupt*/
 #define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, int)
+
+/* Get the valid iova range */
+#define VHOST_VDPA_GET_IOVA_RANGE	_IOR(VHOST_VIRTIO, 0x78, \
+					     struct vhost_vdpa_iova_range)
 #endif
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 9a269a88a6ff..f7f6a3a28977 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -138,6 +138,15 @@ struct vhost_vdpa_config {
 	__u8 buf[0];
 };
 
+/* vhost vdpa IOVA range
+ * @first: First address that can be mapped by vhost-vDPA
+ * @last: Last address that can be mapped by vhost-vDPA
+ */
+struct vhost_vdpa_iova_range {
+	__u64 first;
+	__u64 last;
+};
+
 /* Feature bits */
 /* Log all write descriptors. Can be changed while device is active. */
 #define VHOST_F_LOG_ALL 26
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
