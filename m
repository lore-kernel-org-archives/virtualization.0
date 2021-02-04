Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA6EC433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:24:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61C564F65
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61C564F65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 984F886781;
	Thu,  4 Feb 2021 17:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ItQRTihubw2O; Thu,  4 Feb 2021 17:24:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 646CD86739;
	Thu,  4 Feb 2021 17:24:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E14DC1834;
	Thu,  4 Feb 2021 17:24:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30821C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2C6A580D02
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id atZemz+gkJeS
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:23:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9968185C3B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612459436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Yf+Et7og5P1LCPgL7QqqEe0xXXUz8x83KpYPW6A12Y=;
 b=MyY/VLujZTTco6tCSqSeLMjYeBEOzy2C7Xe283C23is6FAr8wvYPyHBIsGlgthFRE0invD
 rWyqpiIihAK/I/jtw0cwc1Q8MUmluEp2K846pl1NRV3iup0KzPQi+4q7HkIANs3Iuc3Q4S
 DL8RutO98LFt/8L7bRlXo0eLPr3usQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-PcjhU0vdNk6VjC4g9_K0BA-1; Thu, 04 Feb 2021 12:23:54 -0500
X-MC-Unique: PcjhU0vdNk6VjC4g9_K0BA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F2718799EB;
 Thu,  4 Feb 2021 17:23:53 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-213.ams2.redhat.com
 [10.36.113.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DB275D6D7;
 Thu,  4 Feb 2021 17:23:45 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 08/13] vdpa: add return value to get_config/set_config
 callbacks
Date: Thu,  4 Feb 2021 18:22:25 +0100
Message-Id: <20210204172230.85853-9-sgarzare@redhat.com>
In-Reply-To: <20210204172230.85853-1-sgarzare@redhat.com>
References: <20210204172230.85853-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

All implementations of these callbacks already validate inputs.

Let's return an error from these callbacks, so the caller doesn't
need to validate the input anymore.

We update all implementations to return -EINVAL in case of invalid
input.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/vdpa.h              | 18 ++++++++++--------
 drivers/vdpa/ifcvf/ifcvf_main.c   | 24 ++++++++++++++++--------
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 +++++++++++------
 drivers/vdpa/vdpa_sim/vdpa_sim.c  | 16 ++++++++++------
 4 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 4ab5494503a8..0e0cbd5fb41b 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -157,6 +157,7 @@ struct vdpa_iova_range {
  *				@buf: buffer used to read to
  *				@len: the length to read from
  *				configuration space
+ *				Returns integer: success (0) or error (< 0)
  * @set_config:			Write to device specific configuration space
  *				@vdev: vdpa device
  *				@offset: offset from the beginning of
@@ -164,6 +165,7 @@ struct vdpa_iova_range {
  *				@buf: buffer used to write from
  *				@len: the length to write to
  *				configuration space
+ *				Returns integer: success (0) or error (< 0)
  * @get_generation:		Get device config generation (optional)
  *				@vdev: vdpa device
  *				Returns u32: device generation
@@ -231,10 +233,10 @@ struct vdpa_config_ops {
 	u32 (*get_vendor_id)(struct vdpa_device *vdev);
 	u8 (*get_status)(struct vdpa_device *vdev);
 	void (*set_status)(struct vdpa_device *vdev, u8 status);
-	void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
-			   void *buf, unsigned int len);
-	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
-			   const void *buf, unsigned int len);
+	int (*get_config)(struct vdpa_device *vdev, unsigned int offset,
+			  void *buf, unsigned int len);
+	int (*set_config)(struct vdpa_device *vdev, unsigned int offset,
+			  const void *buf, unsigned int len);
 	u32 (*get_generation)(struct vdpa_device *vdev);
 	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
 
@@ -329,8 +331,8 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
 }
 
 
-static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
-				   void *buf, unsigned int len)
+static inline int vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
+				  void *buf, unsigned int len)
 {
         const struct vdpa_config_ops *ops = vdev->config;
 
@@ -339,8 +341,8 @@ static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
 	 * If it does happen we assume a legacy guest.
 	 */
 	if (!vdev->features_valid)
-		vdpa_set_features(vdev, 0);
-	ops->get_config(vdev, offset, buf, len);
+		return vdpa_set_features(vdev, 0);
+	return ops->get_config(vdev, offset, buf, len);
 }
 
 /**
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 7c8bbfcf6c3e..f5e6a90d8114 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -332,24 +332,32 @@ static u32 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
 	return IFCVF_QUEUE_ALIGNMENT;
 }
 
-static void ifcvf_vdpa_get_config(struct vdpa_device *vdpa_dev,
-				  unsigned int offset,
-				  void *buf, unsigned int len)
+static int ifcvf_vdpa_get_config(struct vdpa_device *vdpa_dev,
+				 unsigned int offset,
+				 void *buf, unsigned int len)
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	WARN_ON(offset + len > sizeof(struct virtio_net_config));
+	if (offset + len > sizeof(struct virtio_net_config))
+		return -EINVAL;
+
 	ifcvf_read_net_config(vf, offset, buf, len);
+
+	return 0;
 }
 
-static void ifcvf_vdpa_set_config(struct vdpa_device *vdpa_dev,
-				  unsigned int offset, const void *buf,
-				  unsigned int len)
+static int ifcvf_vdpa_set_config(struct vdpa_device *vdpa_dev,
+				 unsigned int offset, const void *buf,
+				 unsigned int len)
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	WARN_ON(offset + len > sizeof(struct virtio_net_config));
+	if (offset + len > sizeof(struct virtio_net_config))
+		return -EINVAL;
+
 	ifcvf_write_net_config(vf, offset, buf, len);
+
+	return 0;
 }
 
 static void ifcvf_vdpa_set_config_cb(struct vdpa_device *vdpa_dev,
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 029822060017..9323b5ff7988 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1796,20 +1796,25 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 	ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
 }
 
-static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset, void *buf,
-				 unsigned int len)
+static int mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset, void *buf,
+				unsigned int len)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 
-	if (offset + len < sizeof(struct virtio_net_config))
-		memcpy(buf, (u8 *)&ndev->config + offset, len);
+	if (offset + len > sizeof(struct virtio_net_config))
+		return -EINVAL;
+
+	memcpy(buf, (u8 *)&ndev->config + offset, len);
+
+	return 0
 }
 
-static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
-				 unsigned int len)
+static int mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
+				unsigned int len)
 {
 	/* not supported */
+	return 0;
 }
 
 static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index a7aeb5d01c3e..3808b01ac703 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -462,32 +462,36 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
 	spin_unlock(&vdpasim->lock);
 }
 
-static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
-			     void *buf, unsigned int len)
+static int vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
+			      void *buf, unsigned int len)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
 	if (offset + len > vdpasim->dev_attr.config_size)
-		return;
+		return -EINVAL;
 
 	if (vdpasim->dev_attr.get_config)
 		vdpasim->dev_attr.get_config(vdpasim, vdpasim->config);
 
 	memcpy(buf, vdpasim->config + offset, len);
+
+	return 0;
 }
 
-static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
-			     const void *buf, unsigned int len)
+static int vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
+			      const void *buf, unsigned int len)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
 	if (offset + len > vdpasim->dev_attr.config_size)
-		return;
+		return -EINVAL;
 
 	memcpy(vdpasim->config + offset, buf, len);
 
 	if (vdpasim->dev_attr.set_config)
 		vdpasim->dev_attr.set_config(vdpasim, vdpasim->config);
+
+	return 0;
 }
 
 static u32 vdpasim_get_generation(struct vdpa_device *vdpa)
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
