Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1C7C388F9
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 09:01:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5398B22253
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 09:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hP7NRqof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5398B22253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C54B3877CD;
	Fri, 23 Oct 2020 09:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ZutPxFyu8+F; Fri, 23 Oct 2020 09:01:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 365ED87239;
	Fri, 23 Oct 2020 09:01:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CC0DC088B;
	Fri, 23 Oct 2020 09:01:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45379C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0E8ED2050C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XOa27nutrVMZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:01:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 27B9A2051A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603443671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFJSwz55+I+RbvNrwRCk58iQpQ7gF+2XNCdKwBBk/qQ=;
 b=hP7NRqoflqgwZo05nSNMYlEIVcduDFI2nCdz+iXzkCcUMhasrwkY2Hr0UaOVsFv9DM8Z72
 SvR3hrWpn0gv7r48eploOaKriZTvgh2ywAAh7sdCmR36i+ujzZNzz/zpaP9VEu52WKX1sA
 vpyclEh+FSV1NtDLRuV1MEcC3Y0iXIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-OxQVMAqdMhqiK10Dftlhqg-1; Fri, 23 Oct 2020 05:01:09 -0400
X-MC-Unique: OxQVMAqdMhqiK10Dftlhqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1E95101EBE2;
 Fri, 23 Oct 2020 09:01:06 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-85.pek2.redhat.com [10.72.13.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 148655B4A1;
 Fri, 23 Oct 2020 09:01:00 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/3] vhost: vdpa: report iova range
Date: Fri, 23 Oct 2020 17:00:42 +0800
Message-Id: <20201023090043.14430-3-jasowang@redhat.com>
In-Reply-To: <20201023090043.14430-1-jasowang@redhat.com>
References: <20201023090043.14430-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 drivers/vhost/vdpa.c             | 41 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost.h       |  4 ++++
 include/uapi/linux/vhost_types.h |  9 +++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a2dbc85e0b0d..846de69d9c01 100644
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
@@ -471,6 +482,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		features = VHOST_VDPA_BACKEND_FEATURES;
 		r = copy_to_user(featurep, &features, sizeof(features));
 		break;
+	case VHOST_VDPA_GET_IOVA_RANGE:
+		r = vhost_vdpa_get_iova_range(v, argp);
+		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
 		if (r == -ENOIOCTLCMD)
@@ -597,6 +611,10 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	long pinned;
 	int ret = 0;
 
+	if (msg->iova < v->range.first ||
+	    msg->iova + msg->size - 1 > v->range.last)
+		return -EINVAL;
+
 	if (vhost_iotlb_itree_first(iotlb, msg->iova,
 				    msg->iova + msg->size - 1))
 		return -EEXIST;
@@ -783,6 +801,27 @@ static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
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
@@ -823,6 +862,8 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
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
