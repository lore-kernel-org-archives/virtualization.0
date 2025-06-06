Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5527C28852B
	for <virtualization@lists.linux.dev>; Fri,  6 Jun 2025 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210633; cv=none; b=Jl/eIWSqWUogHpWbSVDAeQqNj8UvGswJwK9/KMy8MFKFsbLAUI1wRxgHWDhCi+efLHsgcO8cWqDJZM5Dqv5qxEQtr2NM580npeoE3jirCxpY+YkeRvdacrEVo07dxMR6pQuT1lGaL9uLfpDgT5DQdS+nf2H9u9xzjS/LDqyGz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210633; c=relaxed/simple;
	bh=UgsieFu3Kz0njZbZT/Zg810et6OCXfsW1n4LV9dgZgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3TKnl7XUZdgNLPIwuqRVkBoLlXZdJgov6uAK3p9fFlP0RdFx4CrNNwG9FBAaNSUwz+6P0VzdEUEGPzAYAn+L4dA6YD0/vdpDajLBMAA7kcNpiGyWF/Oh/vqx/e7zqpu68Km/5WsiqH4LxviKjZk/cV0I0/K/tO4RM+9h76s1B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEyYQV8R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEyYQV8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749210630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZUnE9Fp7JTLv3YsV0naKvxGFvbyveDrK723yBnXOgQ=;
	b=bEyYQV8RZL5di/8ME44bFb8m/if1zeoPr1zTP2xwxOZeTZlory76J9jRMVFSHtGIDPdejq
	nuz6UgYq/G1c13gWj2cx7F2SImBEU1jDRt09zzhaRvf8u+RnR7dPoe3R1d8Z2B3+wIsEBP
	1DuHI/Dkbmg1OVg+m9ErFfbhcP/2Ke8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-g9yncyHAMdO1cDyUatHMvg-1; Fri,
 06 Jun 2025 07:50:29 -0400
X-MC-Unique: g9yncyHAMdO1cDyUatHMvg-1
X-Mimecast-MFC-AGG-ID: g9yncyHAMdO1cDyUatHMvg_1749210628
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED08A195608B;
	Fri,  6 Jun 2025 11:50:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B5AC19560B2;
	Fri,  6 Jun 2025 11:50:23 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: jasowang@redhat.com
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [RFC 2/6] vduse: add vq group support
Date: Fri,  6 Jun 2025 13:50:08 +0200
Message-ID: <20250606115012.1331551-3-eperezma@redhat.com>
In-Reply-To: <20250606115012.1331551-1-eperezma@redhat.com>
References: <20250606115012.1331551-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The virtqueue group is the minimal set of virtqueues that must share an
address space.  And the address space identifier could only be attached
to a specific virtqueue group.  The virtqueue is attached to a
virtqueue group for all the life of the device.

During vDPA device allocation, the VDUSE device needs to report the
number of virtqueue groups supported. At this moment only vhost_vdpa is
able to do it.

This helps to isolate the environments for the virtqueue that will not
be assigned directly. E.g in the case of virtio-net, the control
virtqueue will not be assigned directly to guest.

As we need to back the vq groups with a struct device for the file
operations, let's keep this number as low as possible at the moment: 2.
We can back one VQ group with the vduse device and the other one with
the vdpa device.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 44 +++++++++++++++++++++++++++++-
 include/uapi/linux/vduse.h         | 17 +++++++++++-
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 6a9a37351310..6fa687bc4912 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -46,6 +46,11 @@
 #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
 #define VDUSE_MSG_DEFAULT_TIMEOUT 30
 
+/*
+ * Let's make it 2 for simplicity.
+ */
+#define VDUSE_MAX_VQ_GROUPS 2
+
 #define IRQ_UNBOUND -1
 
 struct vduse_virtqueue {
@@ -114,6 +119,7 @@ struct vduse_dev {
 	u8 status;
 	u32 vq_num;
 	u32 vq_align;
+	u32 ngroups;
 	struct vduse_umem *umem;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
@@ -592,6 +598,25 @@ static int vduse_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 idx,
 	return 0;
 }
 
+static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	struct vduse_dev_msg msg = { 0 };
+	int ret;
+
+	if (dev->api_version < VDUSE_API_VERSION_1)
+		return 0;
+
+	msg.req.type = VDUSE_GET_VQ_GROUP;
+	msg.req.vq_group.index = idx;
+
+	ret = vduse_dev_msg_sync(dev, &msg);
+	if (ret)
+		return ret;
+
+	return msg.resp.vq_group.num;
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -789,6 +814,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_vq_cb		= vduse_vdpa_set_vq_cb,
 	.set_vq_num             = vduse_vdpa_set_vq_num,
 	.get_vq_size		= vduse_vdpa_get_vq_size,
+	.get_vq_group		= vduse_get_vq_group,
 	.set_vq_ready		= vduse_vdpa_set_vq_ready,
 	.get_vq_ready		= vduse_vdpa_get_vq_ready,
 	.set_vq_state		= vduse_vdpa_set_vq_state,
@@ -1850,6 +1876,16 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+	if (dev->api_version >= 1) {
+		if (config->ngroups > VDUSE_MAX_VQ_GROUPS) {
+			pr_err("Not creating a VDUSE device with %u vq groups. Max: %u",
+				config->ngroups, VDUSE_MAX_VQ_GROUPS);
+			goto err_ngroups;
+		}
+		dev->ngroups = config->ngroups ?: 1;
+	} else {
+		dev->ngroups = 1;
+	}
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
 		goto err_str;
@@ -1885,6 +1921,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	idr_remove(&vduse_idr, dev->minor);
 err_idr:
 	kfree(dev->name);
+err_ngroups:
 err_str:
 	vduse_dev_destroy(dev);
 err:
@@ -2003,13 +2040,18 @@ static struct vduse_mgmt_dev *vduse_mgmt;
 static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 {
 	struct vduse_vdpa *vdev;
+	__u32 ngroups = 1;
 	int ret;
 
 	if (dev->vdev)
 		return -EEXIST;
 
+	if (vdev->dev->api_version >= VDUSE_API_VERSION_1)
+		ngroups = vdev->dev->ngroups;
+
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
-				 &vduse_vdpa_config_ops, 1, 1, name, true);
+				 &vduse_vdpa_config_ops, ngroups, 1, name,
+				 true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
 
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 9a56d0416bfe..a779bcddac58 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -45,7 +45,8 @@ struct vduse_dev_config {
 	__u64 features;
 	__u32 vq_num;
 	__u32 vq_align;
-	__u32 reserved[13];
+	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
+	__u32 reserved[12];
 	__u32 config_size;
 	__u8 config[];
 };
@@ -160,6 +161,16 @@ struct vduse_vq_state_packed {
 	__u16 last_used_idx;
 };
 
+/**
+ * struct vduse_vq_group - virtqueue group
+ * @num: Index of the virtqueue group
+ * @num: Group
+ */
+struct vduse_vq_group {
+	__u32 index;
+	__u32 num;
+};
+
 /**
  * struct vduse_vq_info - information of a virtqueue
  * @index: virtqueue index
@@ -182,6 +193,7 @@ struct vduse_vq_info {
 	union {
 		struct vduse_vq_state_split split;
 		struct vduse_vq_state_packed packed;
+		struct vduse_vq_group group;
 	};
 	__u8 ready;
 };
@@ -274,6 +286,7 @@ enum vduse_req_type {
 	VDUSE_GET_VQ_STATE,
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
+	VDUSE_GET_VQ_GROUP,
 };
 
 /**
@@ -328,6 +341,7 @@ struct vduse_dev_request {
 		struct vduse_vq_state vq_state;
 		struct vduse_dev_status s;
 		struct vduse_iova_range iova;
+		struct vduse_vq_group vq_group; /* Only if vduse api version >= 1 */
 		__u32 padding[32];
 	};
 };
@@ -350,6 +364,7 @@ struct vduse_dev_response {
 	__u32 reserved[4];
 	union {
 		struct vduse_vq_state vq_state;
+		struct vduse_vq_group vq_group; /* Only if vduse api version >= 1 */
 		__u32 padding[32];
 	};
 };
-- 
2.49.0

