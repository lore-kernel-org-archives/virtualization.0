Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD0835E548
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833243; cv=none; b=khe2YW1jyrVtf/lMU6CFWpCy0c2pQ9w8Ccbe/dH6Biq9UXAKnGzvlYKHZfnJfuVkjFf62d4hRRAqU6EuGdX01qFTNfmH0h84xN9jbhnCHWTZOz2r1TfnDvcOLYycT4g9IpSpaW7G4c8jFdqPuawd1fJqMrxG6f1welVW+/R3B8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833243; c=relaxed/simple;
	bh=BcdUoZxF9PhEagE7qYf3YHZPnuZv9qE5ZFPYKMsFwfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXZIRrBT0uQ371GNjJLRAkDdwvM1Seo6DZxrO+zQ2s25xjRtVHPzXjIDhFZloOiNW3OUtYgo5hvQDHw7+J+Jce25WV0G4gonKvjb9GWl3GxjHoHt/19qO5u2w9+D0nLmyx3uE+aesoxoi87dnv6ggxwtNYiR680OYmVRTc21lYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFIHk+U/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFIHk+U/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768833239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvcEyg4/KWesHt9o6s3Qi82wNGFYIbHPJhprxpEagJE=;
	b=ZFIHk+U/nMVF/mQi6K9PUDm9F44+tJPQ96JuAPNliabXWb7a9fo7F4zuBXY2gAXvBiXNFG
	ZYzV4teaFMDQn1LzkmHTNxQAZPB6PCjOyiblZqrpYQwpD0Swvh/fbhtR2CzCiMUC1zR1vU
	4Gky3cHVvCEK8pNedRF3ClwVGVHaKnE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-W-PyALbsOJ2MpwfIO_wFzw-1; Mon,
 19 Jan 2026 09:33:58 -0500
X-MC-Unique: W-PyALbsOJ2MpwfIO_wFzw-1
X-Mimecast-MFC-AGG-ID: W-PyALbsOJ2MpwfIO_wFzw_1768833237
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14DC81956054;
	Mon, 19 Jan 2026 14:33:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.172])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CBB91800240;
	Mon, 19 Jan 2026 14:33:53 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
	Yongji Xie <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	jasowang@redhat.com,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v15 11/13] vduse: add vq group asid support
Date: Mon, 19 Jan 2026 15:33:04 +0100
Message-ID: <20260119143306.1818855-12-eperezma@redhat.com>
In-Reply-To: <20260119143306.1818855-1-eperezma@redhat.com>
References: <20260119143306.1818855-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add support for assigning Address Space Identifiers (ASIDs) to each VQ
group.  This enables mapping each group into a distinct memory space.

The vq group to ASID association is protected by a rwlock now.  But the
mutex domain_lock keeps protecting the domains of all ASIDs, as some
operations like the one related with the bounce buffer size still
requires to lock all the ASIDs.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

---
Future improvements can include performance optimizations on top like
ore to RCU or thread synchronized atomics, or hardening by tracking ASID
or ASID hashes on unused bits of the DMA address.

Tested virtio_vdpa by adding manually two threads in vduse_set_status:
one of them modifies the vq group 0 ASID and the other one map and unmap
memory continuously.  After a while, the two threads stop and the usual
work continues.  Test with version 0, version 1 with the old ioctl, and
version 1 with the new ioctl.

Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUSE.  A few
workaround were needed in some parts:
* Do not enable CVQ before data vqs in QEMU, as VDUSE does not forward
  the enable message to the userland device.  This will be solved in the
  future.
* Share the suspended state between all vhost devices in QEMU:
  https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg02947.html
* Implement a fake VDUSE suspend vdpa operation callback that always
  returns true in the kernel.  DPDK suspend the device at the first
  GET_VRING_BASE.
* Remove the CVQ blocker in ASID.

The driver vhost_vdpa was also tested with version 0, version 1 with the
old ioctl, version 1 with the new ioctl but only one ASID, and version 1
with many ASID.

---
v15:
* Fix doc typo (Alok).
* Document vduse config @nas member.

v13:
* Add documentation for VDUSE_SET_VQ_READY VDUSE message to userspace.

v12:
* Using scoped guards for vq group rwlock, so the one queue optimization
  is not missed (Jason proposed to factor them into helpers).
* Add the _v2 suffix to vduse_iova_range_v2 struct name fixing the doc
  (MST).
* s/verion/version/ in patch message.
* Remove trailing ; after a comment (Jason).

v11:
* Remove duplicated free_pages_exact in vduse_domain_free_coherent
  (Jason).
* Do not take the vq groups lock if nas == 1.
* Do not reset the vq group ASID in vq reset (Jason).  Removed extra
  function vduse_set_group_asid_nomsg, not needed anymore.
* Move the vduse_iotlb_entry_v2 argument to a new ioctl, as argument
  didn't match the previous VDUSE_IOTLB_GET_FD.
* Move the asid < dev->nas check to vdpa core.

v10:
* Back to rwlock version so stronger locks are used.
* Take out allocations from rwlock.
* Forbid changing ASID of a vq group after DRIVER_OK (Jason)
* Remove bad fetching again of domain variable in
  vduse_dev_max_mapping_size (Yongji).
* Remove unused vdev definition in vdpa map_ops callbacks (kernel test
  robot).

v9:
* Replace mutex with rwlock, as the vdpa map_ops can run from atomic
  context.

v8:
* Revert the mutex to rwlock change, it needs proper profiling to
  justify it.

v7:
* Take write lock in the error path (Jason).

v6:
* Make vdpa_dev_add use gotos for error handling (MST).
* s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1) ?/
  (MST).
* Fix struct name not matching in the doc.

v5:
* Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_FD
  ioctl (Jason).
* Properly set domain bounce size to divide equally between nas (Jason).
* Exclude "padding" member from the only >V1 members in
  vduse_dev_request.

v4:
* Divide each domain bounce size between the device bounce size (Jason).
* revert unneeded addr = NULL assignment (Jason)
* Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
  return; } (Jason)
* Change a bad multiline comment, using @ caracter instead of * (Jason).
* Consider config->nas == 0 as a fail (Jason).

v3:
* Get the vduse domain through the vduse_as in the map functions
  (Jason).
* Squash with the patch creating the vduse_as struct (Jason).
* Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
  (Jason)

v2:
* Convert the use of mutex to rwlock.

RFC v3:
* Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
  value to reduce memory consumption, but vqs are already limited to
  that value and userspace VDUSE is able to allocate that many vqs.
* Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
  VDUSE_IOTLB_GET_INFO.
* Use of array_index_nospec in VDUSE device ioctls.
* Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
* Move the umem mutex to asid struct so there is no contention between
  ASIDs.

RFC v2:
* Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
  part of the struct is the same.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 385 +++++++++++++++++++----------
 include/uapi/linux/vduse.h         |  66 ++++-
 2 files changed, 315 insertions(+), 136 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index d658f3e1cebf..2727c0c26003 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -9,6 +9,7 @@
  */
 
 #include "linux/virtio_net.h"
+#include <linux/cleanup.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/cdev.h>
@@ -41,6 +42,7 @@
 
 #define VDUSE_DEV_MAX (1U << MINORBITS)
 #define VDUSE_DEV_MAX_GROUPS 0xffff
+#define VDUSE_DEV_MAX_AS 0xffff
 #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
 #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
 #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
@@ -86,7 +88,15 @@ struct vduse_umem {
 	struct mm_struct *mm;
 };
 
+struct vduse_as {
+	struct vduse_iova_domain *domain;
+	struct vduse_umem *umem;
+	struct mutex mem_lock;
+};
+
 struct vduse_vq_group {
+	rwlock_t as_lock;
+	struct vduse_as *as; /* Protected by as_lock */
 	struct vduse_dev *dev;
 };
 
@@ -94,7 +104,7 @@ struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
 	struct vduse_virtqueue **vqs;
-	struct vduse_iova_domain *domain;
+	struct vduse_as *as;
 	char *name;
 	struct mutex lock;
 	spinlock_t msg_lock;
@@ -122,9 +132,8 @@ struct vduse_dev {
 	u32 vq_num;
 	u32 vq_align;
 	u32 ngroups;
-	struct vduse_umem *umem;
+	u32 nas;
 	struct vduse_vq_group *groups;
-	struct mutex mem_lock;
 	unsigned int bounce_size;
 	struct mutex domain_lock;
 };
@@ -314,7 +323,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev, u8 status)
 	return vduse_dev_msg_sync(dev, &msg);
 }
 
-static int vduse_dev_update_iotlb(struct vduse_dev *dev,
+static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
 				  u64 start, u64 last)
 {
 	struct vduse_dev_msg msg = { 0 };
@@ -323,8 +332,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *dev,
 		return -EINVAL;
 
 	msg.req.type = VDUSE_UPDATE_IOTLB;
-	msg.req.iova.start = start;
-	msg.req.iova.last = last;
+	if (dev->api_version < VDUSE_API_VERSION_1) {
+		msg.req.iova.start = start;
+		msg.req.iova.last = last;
+	} else {
+		msg.req.iova_v2.start = start;
+		msg.req.iova_v2.last = last;
+		msg.req.iova_v2.asid = asid;
+	}
 
 	return vduse_dev_msg_sync(dev, &msg);
 }
@@ -439,11 +454,14 @@ static __poll_t vduse_dev_poll(struct file *file, poll_table *wait)
 static void vduse_dev_reset(struct vduse_dev *dev)
 {
 	int i;
-	struct vduse_iova_domain *domain = dev->domain;
 
 	/* The coherent mappings are handled in vduse_dev_free_coherent() */
-	if (domain && domain->bounce_map)
-		vduse_domain_reset_bounce_map(domain);
+	for (i = 0; i < dev->nas; i++) {
+		struct vduse_iova_domain *domain = dev->as[i].domain;
+
+		if (domain && domain->bounce_map)
+			vduse_domain_reset_bounce_map(domain);
+	}
 
 	down_write(&dev->rwsem);
 
@@ -622,6 +640,42 @@ static union virtio_map vduse_get_vq_map(struct vdpa_device *vdpa, u16 idx)
 	return ret;
 }
 
+DEFINE_GUARD(vq_group_as_read_lock, struct vduse_vq_group *,
+	if (_T->dev->nas > 1)
+		read_lock(&_T->as_lock),
+	if (_T->dev->nas > 1)
+		read_unlock(&_T->as_lock))
+
+DEFINE_GUARD(vq_group_as_write_lock, struct vduse_vq_group *,
+	if (_T->dev->nas > 1)
+		write_lock(&_T->as_lock),
+	if (_T->dev->nas > 1)
+		write_unlock(&_T->as_lock))
+
+static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
+				unsigned int asid)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	struct vduse_dev_msg msg = { 0 };
+	int r;
+
+	if (dev->api_version < VDUSE_API_VERSION_1)
+		return -EINVAL;
+
+	msg.req.type = VDUSE_SET_VQ_GROUP_ASID;
+	msg.req.vq_group_asid.group = group;
+	msg.req.vq_group_asid.asid = asid;
+
+	r = vduse_dev_msg_sync(dev, &msg);
+	if (r < 0)
+		return r;
+
+	guard(vq_group_as_write_lock)(&dev->groups[group]);
+	dev->groups[group].as = &dev->as[asid];
+
+	return 0;
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -793,13 +847,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	int ret;
 
-	ret = vduse_domain_set_map(dev->domain, iotlb);
+	ret = vduse_domain_set_map(dev->as[asid].domain, iotlb);
 	if (ret)
 		return ret;
 
-	ret = vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
+	ret = vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
 	if (ret) {
-		vduse_domain_clear_map(dev->domain, iotlb);
+		vduse_domain_clear_map(dev->as[asid].domain, iotlb);
 		return ret;
 	}
 
@@ -842,6 +896,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
+	.set_group_asid		= vduse_set_group_asid,
 	.get_vq_map		= vduse_get_vq_map,
 	.free			= vduse_vdpa_free,
 };
@@ -850,15 +905,13 @@ static void vduse_dev_sync_single_for_device(union virtio_map token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct vduse_dev *vdev;
 	struct vduse_iova_domain *domain;
 
 	if (!token.group)
 		return;
 
-	vdev = token.group->dev;
-	domain = vdev->domain;
-
+	guard(vq_group_as_read_lock)(token.group);
+	domain = token.group->as->domain;
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
 }
 
@@ -866,15 +919,13 @@ static void vduse_dev_sync_single_for_cpu(union virtio_map token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct vduse_dev *vdev;
 	struct vduse_iova_domain *domain;
 
 	if (!token.group)
 		return;
 
-	vdev = token.group->dev;
-	domain = vdev->domain;
-
+	guard(vq_group_as_read_lock)(token.group);
+	domain = token.group->as->domain;
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
 }
 
@@ -883,15 +934,13 @@ static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
 				     enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	struct vduse_dev *vdev;
 	struct vduse_iova_domain *domain;
 
 	if (!token.group)
 		return DMA_MAPPING_ERROR;
 
-	vdev = token.group->dev;
-	domain = vdev->domain;
-
+	guard(vq_group_as_read_lock)(token.group);
+	domain = token.group->as->domain;
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
 }
 
@@ -899,23 +948,19 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
 				 size_t size, enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	struct vduse_dev *vdev;
 	struct vduse_iova_domain *domain;
 
 	if (!token.group)
 		return;
 
-	vdev = token.group->dev;
-	domain = vdev->domain;
-
-	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
+	guard(vq_group_as_read_lock)(token.group);
+	domain = token.group->as->domain;
+	vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }
 
 static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 				      dma_addr_t *dma_addr, gfp_t flag)
 {
-	struct vduse_dev *vdev;
-	struct vduse_iova_domain *domain;
 	void *addr;
 
 	*dma_addr = DMA_MAPPING_ERROR;
@@ -926,11 +971,15 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 	if (!addr)
 		return NULL;
 
-	vdev = token.group->dev;
-	domain = vdev->domain;
-	*dma_addr = vduse_domain_alloc_coherent(domain, size, addr);
-	if (*dma_addr == DMA_MAPPING_ERROR)
-		goto err;
+	{
+		struct vduse_iova_domain *domain;
+
+		guard(vq_group_as_read_lock)(token.group);
+		domain = token.group->as->domain;
+		*dma_addr = vduse_domain_alloc_coherent(domain, size, addr);
+		if (*dma_addr == DMA_MAPPING_ERROR)
+			goto err;
+	}
 
 	return addr;
 
@@ -943,31 +992,27 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 				    void *vaddr, dma_addr_t dma_addr,
 				    unsigned long attrs)
 {
-	struct vduse_dev *vdev;
-	struct vduse_iova_domain *domain;
-
 	if (!token.group)
 		return;
 
-	vdev = token.group->dev;
-	domain = vdev->domain;
+	{
+		struct vduse_iova_domain *domain;
+
+		guard(vq_group_as_read_lock)(token.group);
+		domain = token.group->as->domain;
+		vduse_domain_free_coherent(domain, size, dma_addr, attrs);
+	}
 
-	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
 	free_pages_exact(vaddr, size);
 }
 
 static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
 {
-	struct vduse_dev *vdev;
-	struct vduse_iova_domain *domain;
-
 	if (!token.group)
 		return false;
 
-	vdev = token.group->dev;
-	domain = vdev->domain;
-
-	return dma_addr < domain->bounce_size;
+	guard(vq_group_as_read_lock)(token.group);
+	return dma_addr < token.group->as->domain->bounce_size;
 }
 
 static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dma_addr)
@@ -979,16 +1024,11 @@ static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dma_addr)
 
 static size_t vduse_dev_max_mapping_size(union virtio_map token)
 {
-	struct vduse_dev *vdev;
-	struct vduse_iova_domain *domain;
-
 	if (!token.group)
 		return 0;
 
-	vdev = token.group->dev;
-	domain = vdev->domain;
-
-	return domain->bounce_size;
+	guard(vq_group_as_read_lock)(token.group);
+	return token.group->as->domain->bounce_size;
 }
 
 static const struct virtio_map_ops vduse_map_ops = {
@@ -1128,39 +1168,40 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 	return ret;
 }
 
-static int vduse_dev_dereg_umem(struct vduse_dev *dev,
+static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
 				u64 iova, u64 size)
 {
 	int ret;
 
-	mutex_lock(&dev->mem_lock);
+	mutex_lock(&dev->as[asid].mem_lock);
 	ret = -ENOENT;
-	if (!dev->umem)
+	if (!dev->as[asid].umem)
 		goto unlock;
 
 	ret = -EINVAL;
-	if (!dev->domain)
+	if (!dev->as[asid].domain)
 		goto unlock;
 
-	if (dev->umem->iova != iova || size != dev->domain->bounce_size)
+	if (dev->as[asid].umem->iova != iova ||
+	    size != dev->as[asid].domain->bounce_size)
 		goto unlock;
 
-	vduse_domain_remove_user_bounce_pages(dev->domain);
-	unpin_user_pages_dirty_lock(dev->umem->pages,
-				    dev->umem->npages, true);
-	atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
-	mmdrop(dev->umem->mm);
-	vfree(dev->umem->pages);
-	kfree(dev->umem);
-	dev->umem = NULL;
+	vduse_domain_remove_user_bounce_pages(dev->as[asid].domain);
+	unpin_user_pages_dirty_lock(dev->as[asid].umem->pages,
+				    dev->as[asid].umem->npages, true);
+	atomic64_sub(dev->as[asid].umem->npages, &dev->as[asid].umem->mm->pinned_vm);
+	mmdrop(dev->as[asid].umem->mm);
+	vfree(dev->as[asid].umem->pages);
+	kfree(dev->as[asid].umem);
+	dev->as[asid].umem = NULL;
 	ret = 0;
 unlock:
-	mutex_unlock(&dev->mem_lock);
+	mutex_unlock(&dev->as[asid].mem_lock);
 	return ret;
 }
 
 static int vduse_dev_reg_umem(struct vduse_dev *dev,
-			      u64 iova, u64 uaddr, u64 size)
+			      u32 asid, u64 iova, u64 uaddr, u64 size)
 {
 	struct page **page_list = NULL;
 	struct vduse_umem *umem = NULL;
@@ -1168,14 +1209,14 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	unsigned long npages, lock_limit;
 	int ret;
 
-	if (!dev->domain || !dev->domain->bounce_map ||
-	    size != dev->domain->bounce_size ||
+	if (!dev->as[asid].domain || !dev->as[asid].domain->bounce_map ||
+	    size != dev->as[asid].domain->bounce_size ||
 	    iova != 0 || uaddr & ~PAGE_MASK)
 		return -EINVAL;
 
-	mutex_lock(&dev->mem_lock);
+	mutex_lock(&dev->as[asid].mem_lock);
 	ret = -EEXIST;
-	if (dev->umem)
+	if (dev->as[asid].umem)
 		goto unlock;
 
 	ret = -ENOMEM;
@@ -1199,7 +1240,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 		goto out;
 	}
 
-	ret = vduse_domain_add_user_bounce_pages(dev->domain,
+	ret = vduse_domain_add_user_bounce_pages(dev->as[asid].domain,
 						 page_list, pinned);
 	if (ret)
 		goto out;
@@ -1212,7 +1253,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	umem->mm = current->mm;
 	mmgrab(current->mm);
 
-	dev->umem = umem;
+	dev->as[asid].umem = umem;
 out:
 	if (ret && pinned > 0)
 		unpin_user_pages(page_list, pinned);
@@ -1223,7 +1264,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 		vfree(page_list);
 		kfree(umem);
 	}
-	mutex_unlock(&dev->mem_lock);
+	mutex_unlock(&dev->as[asid].mem_lock);
 	return ret;
 }
 
@@ -1244,44 +1285,47 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
 }
 
 static int vduse_dev_iotlb_entry(struct vduse_dev *dev,
-				 struct vduse_iotlb_entry *entry,
+				 struct vduse_iotlb_entry_v2 *entry,
 				 struct file **f, uint64_t *capability)
 {
+	u32 asid;
 	int r = -EINVAL;
 	struct vhost_iotlb_map *map;
 
-	if (entry->start > entry->last)
+	if (entry->v1.start > entry->v1.last || entry->asid >= dev->nas)
 		return -EINVAL;
 
+	asid = array_index_nospec(entry->asid, dev->nas);
 	mutex_lock(&dev->domain_lock);
-	if (!dev->domain)
+
+	if (!dev->as[asid].domain)
 		goto out;
 
-	spin_lock(&dev->domain->iotlb_lock);
-	map = vhost_iotlb_itree_first(dev->domain->iotlb, entry->start,
-				      entry->last);
+	spin_lock(&dev->as[asid].domain->iotlb_lock);
+	map = vhost_iotlb_itree_first(dev->as[asid].domain->iotlb,
+				      entry->v1.start, entry->v1.last);
 	if (map) {
 		if (f) {
 			const struct vdpa_map_file *map_file;
 
 			map_file = (struct vdpa_map_file *)map->opaque;
-			entry->offset = map_file->offset;
+			entry->v1.offset = map_file->offset;
 			*f = get_file(map_file->file);
 		}
-		entry->start = map->start;
-		entry->last = map->last;
-		entry->perm = map->perm;
+		entry->v1.start = map->start;
+		entry->v1.last = map->last;
+		entry->v1.perm = map->perm;
 		if (capability) {
 			*capability = 0;
 
-			if (dev->domain->bounce_map && map->start == 0 &&
-			    map->last == dev->domain->bounce_size - 1)
+			if (dev->as[asid].domain->bounce_map && map->start == 0 &&
+			    map->last == dev->as[asid].domain->bounce_size - 1)
 				*capability |= VDUSE_IOVA_CAP_UMEM;
 		}
 
 		r = 0;
 	}
-	spin_unlock(&dev->domain->iotlb_lock);
+	spin_unlock(&dev->as[asid].domain->iotlb_lock);
 
 out:
 	mutex_unlock(&dev->domain_lock);
@@ -1299,12 +1343,29 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		return -EPERM;
 
 	switch (cmd) {
-	case VDUSE_IOTLB_GET_FD: {
-		struct vduse_iotlb_entry entry;
+	case VDUSE_IOTLB_GET_FD:
+	case VDUSE_IOTLB_GET_FD2: {
+		struct vduse_iotlb_entry_v2 entry = {0};
 		struct file *f = NULL;
 
+		ret = -ENOIOCTLCMD;
+		if (dev->api_version < VDUSE_API_VERSION_1 &&
+		    cmd == VDUSE_IOTLB_GET_FD2)
+			break;
+
 		ret = -EFAULT;
-		if (copy_from_user(&entry, argp, sizeof(entry)))
+		if (cmd == VDUSE_IOTLB_GET_FD2) {
+			if (copy_from_user(&entry, argp, sizeof(entry)))
+				break;
+		} else {
+			if (copy_from_user(&entry.v1, argp,
+					   sizeof(entry.v1)))
+				break;
+		}
+
+		ret = -EINVAL;
+		if (!is_mem_zero((const char *)entry.reserved,
+				 sizeof(entry.reserved)))
 			break;
 
 		ret = vduse_dev_iotlb_entry(dev, &entry, &f, NULL);
@@ -1315,12 +1376,19 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		if (!f)
 			break;
 
-		ret = -EFAULT;
-		if (copy_to_user(argp, &entry, sizeof(entry))) {
+		if (cmd == VDUSE_IOTLB_GET_FD2)
+			ret = copy_to_user(argp, &entry,
+					   sizeof(entry));
+		else
+			ret = copy_to_user(argp, &entry.v1,
+					   sizeof(entry.v1));
+
+		if (ret) {
+			ret = -EFAULT;
 			fput(f);
 			break;
 		}
-		ret = receive_fd(f, NULL, perm_to_file_flags(entry.perm));
+		ret = receive_fd(f, NULL, perm_to_file_flags(entry.v1.perm));
 		fput(f);
 		break;
 	}
@@ -1465,6 +1533,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 	}
 	case VDUSE_IOTLB_REG_UMEM: {
 		struct vduse_iova_umem umem;
+		u32 asid;
 
 		ret = -EFAULT;
 		if (copy_from_user(&umem, argp, sizeof(umem)))
@@ -1472,17 +1541,21 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 
 		ret = -EINVAL;
 		if (!is_mem_zero((const char *)umem.reserved,
-				 sizeof(umem.reserved)))
+				 sizeof(umem.reserved)) ||
+		    (dev->api_version < VDUSE_API_VERSION_1 &&
+		     umem.asid != 0) || umem.asid >= dev->nas)
 			break;
 
 		mutex_lock(&dev->domain_lock);
-		ret = vduse_dev_reg_umem(dev, umem.iova,
+		asid = array_index_nospec(umem.asid, dev->nas);
+		ret = vduse_dev_reg_umem(dev, asid, umem.iova,
 					 umem.uaddr, umem.size);
 		mutex_unlock(&dev->domain_lock);
 		break;
 	}
 	case VDUSE_IOTLB_DEREG_UMEM: {
 		struct vduse_iova_umem umem;
+		u32 asid;
 
 		ret = -EFAULT;
 		if (copy_from_user(&umem, argp, sizeof(umem)))
@@ -1490,17 +1563,22 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 
 		ret = -EINVAL;
 		if (!is_mem_zero((const char *)umem.reserved,
-				 sizeof(umem.reserved)))
+				 sizeof(umem.reserved)) ||
+		    (dev->api_version < VDUSE_API_VERSION_1 &&
+		     umem.asid != 0) ||
+		     umem.asid >= dev->nas)
 			break;
+
 		mutex_lock(&dev->domain_lock);
-		ret = vduse_dev_dereg_umem(dev, umem.iova,
+		asid = array_index_nospec(umem.asid, dev->nas);
+		ret = vduse_dev_dereg_umem(dev, asid, umem.iova,
 					   umem.size);
 		mutex_unlock(&dev->domain_lock);
 		break;
 	}
 	case VDUSE_IOTLB_GET_INFO: {
 		struct vduse_iova_info info;
-		struct vduse_iotlb_entry entry;
+		struct vduse_iotlb_entry_v2 entry;
 
 		ret = -EFAULT;
 		if (copy_from_user(&info, argp, sizeof(info)))
@@ -1510,15 +1588,23 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 				 sizeof(info.reserved)))
 			break;
 
-		entry.start = info.start;
-		entry.last = info.last;
+		if (dev->api_version < VDUSE_API_VERSION_1) {
+			if (info.asid)
+				break;
+		} else if (info.asid >= dev->nas)
+			break;
+
+		entry.v1.start = info.start;
+		entry.v1.last = info.last;
+		entry.asid = info.asid;
 		ret = vduse_dev_iotlb_entry(dev, &entry, NULL,
 					    &info.capability);
 		if (ret < 0)
 			break;
 
-		info.start = entry.start;
-		info.last = entry.last;
+		info.start = entry.v1.start;
+		info.last = entry.v1.last;
+		info.asid = entry.asid;
 
 		ret = -EFAULT;
 		if (copy_to_user(argp, &info, sizeof(info)))
@@ -1540,8 +1626,10 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
 	struct vduse_dev *dev = file->private_data;
 
 	mutex_lock(&dev->domain_lock);
-	if (dev->domain)
-		vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
+	for (int i = 0; i < dev->nas; i++)
+		if (dev->as[i].domain)
+			vduse_dev_dereg_umem(dev, i, 0,
+					     dev->as[i].domain->bounce_size);
 	mutex_unlock(&dev->domain_lock);
 	spin_lock(&dev->msg_lock);
 	/* Make sure the inflight messages can processed after reconncection */
@@ -1760,7 +1848,6 @@ static struct vduse_dev *vduse_dev_create(void)
 		return NULL;
 
 	mutex_init(&dev->lock);
-	mutex_init(&dev->mem_lock);
 	mutex_init(&dev->domain_lock);
 	spin_lock_init(&dev->msg_lock);
 	INIT_LIST_HEAD(&dev->send_list);
@@ -1811,8 +1898,11 @@ static int vduse_destroy_dev(char *name)
 	idr_remove(&vduse_idr, dev->minor);
 	kvfree(dev->config);
 	vduse_dev_deinit_vqs(dev);
-	if (dev->domain)
-		vduse_domain_destroy(dev->domain);
+	for (int i = 0; i < dev->nas; i++) {
+		if (dev->as[i].domain)
+			vduse_domain_destroy(dev->as[i].domain);
+	}
+	kfree(dev->as);
 	kfree(dev->name);
 	kfree(dev->groups);
 	vduse_dev_destroy(dev);
@@ -1859,12 +1949,17 @@ static bool vduse_validate_config(struct vduse_dev_config *config,
 			 sizeof(config->reserved)))
 		return false;
 
-	if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
+	if (api_version < VDUSE_API_VERSION_1 &&
+	    (config->ngroups || config->nas))
 		return false;
 
-	if (api_version >= VDUSE_API_VERSION_1 &&
-	    (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS))
-		return false;
+	if (api_version >= VDUSE_API_VERSION_1) {
+		if (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS)
+			return false;
+
+		if (!config->nas || config->nas > VDUSE_DEV_MAX_AS)
+			return false;
+	}
 
 	if (config->vq_align > PAGE_SIZE)
 		return false;
@@ -1929,7 +2024,8 @@ static ssize_t bounce_size_store(struct device *device,
 
 	ret = -EPERM;
 	mutex_lock(&dev->domain_lock);
-	if (dev->domain)
+	/* Assuming that if the first domain is allocated, all are allocated */
+	if (dev->as[0].domain)
 		goto unlock;
 
 	ret = kstrtouint(buf, 10, &bounce_size);
@@ -1981,6 +2077,14 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+
+	dev->nas = (dev->api_version < VDUSE_API_VERSION_1) ? 1 : config->nas;
+	dev->as = kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
+	if (!dev->as)
+		goto err_as;
+	for (int i = 0; i < dev->nas; i++)
+		mutex_init(&dev->as[i].mem_lock);
+
 	dev->ngroups = (dev->api_version < VDUSE_API_VERSION_1)
 		       ? 1
 		       : config->ngroups;
@@ -1988,8 +2092,11 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 			      GFP_KERNEL);
 	if (!dev->groups)
 		goto err_vq_groups;
-	for (u32 i = 0; i < dev->ngroups; ++i)
+	for (u32 i = 0; i < dev->ngroups; ++i) {
 		dev->groups[i].dev = dev;
+		rwlock_init(&dev->groups[i].as_lock);
+		dev->groups[i].as = &dev->as[0];
+	}
 
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
@@ -2029,6 +2136,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 err_str:
 	kfree(dev->groups);
 err_vq_groups:
+	kfree(dev->as);
+err_as:
 	vduse_dev_destroy(dev);
 err:
 	return ret;
@@ -2152,7 +2261,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
 				 &vduse_vdpa_config_ops, &vduse_map_ops,
-				 dev->ngroups, 1, name, true);
+				 dev->ngroups, dev->nas, name, true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
 
@@ -2167,7 +2276,8 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 			const struct vdpa_dev_set_config *config)
 {
 	struct vduse_dev *dev;
-	int ret;
+	size_t domain_bounce_size;
+	int ret, i;
 
 	mutex_lock(&vduse_lock);
 	dev = vduse_find_dev(name);
@@ -2181,29 +2291,38 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return ret;
 
 	mutex_lock(&dev->domain_lock);
-	if (!dev->domain)
-		dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
-						  dev->bounce_size);
-	mutex_unlock(&dev->domain_lock);
-	if (!dev->domain) {
-		ret = -ENOMEM;
-		goto domain_err;
+	ret = 0;
+
+	domain_bounce_size = dev->bounce_size / dev->nas;
+	for (i = 0; i < dev->nas; ++i) {
+		dev->as[i].domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
+							domain_bounce_size);
+		if (!dev->as[i].domain) {
+			ret = -ENOMEM;
+			goto err;
+		}
 	}
 
+	mutex_unlock(&dev->domain_lock);
+
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
-	if (ret) {
-		goto register_err;
-	}
+	if (ret)
+		goto err_register;
 
 	return 0;
 
-register_err:
+err_register:
 	mutex_lock(&dev->domain_lock);
-	vduse_domain_destroy(dev->domain);
-	dev->domain = NULL;
+
+err:
+	for (int j = 0; j < i; j++) {
+		if (dev->as[j].domain) {
+			vduse_domain_destroy(dev->as[j].domain);
+			dev->as[j].domain = NULL;
+		}
+	}
 	mutex_unlock(&dev->domain_lock);
 
-domain_err:
 	put_device(&dev->vdev->vdpa.dev);
 
 	return ret;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index a3d51cf6df3a..68b4287f9fac 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -32,6 +32,7 @@
  * @vq_num: the number of virtqueues
  * @vq_align: the allocation alignment of virtqueue's metadata
  * @ngroups: number of vq groups that VDUSE device declares
+ * @nas: number of address spaces that VDUSE device declares
  * @reserved: for future use, needs to be initialized to zero
  * @config_size: the size of the configuration space
  * @config: the buffer of the configuration space
@@ -47,7 +48,8 @@ struct vduse_dev_config {
 	__u32 vq_num;
 	__u32 vq_align;
 	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
-	__u32 reserved[12];
+	__u32 nas; /* if VDUSE_API_VERSION >= 1 */
+	__u32 reserved[11];
 	__u32 config_size;
 	__u8 config[];
 };
@@ -166,6 +168,16 @@ struct vduse_vq_state_packed {
 	__u16 last_used_idx;
 };
 
+/**
+ * struct vduse_vq_group_asid - virtqueue group ASID
+ * @group: Index of the virtqueue group
+ * @asid: Address space ID of the group
+ */
+struct vduse_vq_group_asid {
+	__u32 group;
+	__u32 asid;
+};
+
 /**
  * struct vduse_vq_info - information of a virtqueue
  * @index: virtqueue index
@@ -225,6 +237,7 @@ struct vduse_vq_eventfd {
  * @uaddr: start address of userspace memory, it must be aligned to page size
  * @iova: start of the IOVA region
  * @size: size of the IOVA region
+ * @asid: Address space ID of the IOVA region
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
@@ -234,7 +247,8 @@ struct vduse_iova_umem {
 	__u64 uaddr;
 	__u64 iova;
 	__u64 size;
-	__u64 reserved[3];
+	__u32 asid;
+	__u32 reserved[5];
 };
 
 /* Register userspace memory for IOVA regions */
@@ -248,6 +262,7 @@ struct vduse_iova_umem {
  * @start: start of the IOVA region
  * @last: last of the IOVA region
  * @capability: capability of the IOVA region
+ * @asid: Address space ID of the IOVA region, only if device API version >= 1
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
@@ -258,7 +273,8 @@ struct vduse_iova_info {
 	__u64 last;
 #define VDUSE_IOVA_CAP_UMEM (1 << 0)
 	__u64 capability;
-	__u64 reserved[3];
+	__u32 asid; /* Only if device API version >= 1 */
+	__u32 reserved[5];
 };
 
 /*
@@ -267,6 +283,28 @@ struct vduse_iova_info {
  */
 #define VDUSE_IOTLB_GET_INFO	_IOWR(VDUSE_BASE, 0x1a, struct vduse_iova_info)
 
+/**
+ * struct vduse_iotlb_entry_v2 - entry of IOTLB to describe one IOVA region
+ *
+ * @v1: the original vduse_iotlb_entry
+ * @asid: address space ID of the IOVA region
+ * @reserved: for future use, needs to be initialized to zero
+ *
+ * Structure used by VDUSE_IOTLB_GET_FD2 ioctl to find an overlapped IOVA region.
+ */
+struct vduse_iotlb_entry_v2 {
+	struct vduse_iotlb_entry v1;
+	__u32 asid;
+	__u32 reserved[12];
+};
+
+/*
+ * Same as VDUSE_IOTLB_GET_FD but with vduse_iotlb_entry_v2 argument that
+ * support extra fields.
+ */
+#define VDUSE_IOTLB_GET_FD2	_IOWR(VDUSE_BASE, 0x1b, struct vduse_iotlb_entry_v2)
+
+
 /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
 
 /**
@@ -275,11 +313,14 @@ struct vduse_iova_info {
  * @VDUSE_SET_STATUS: set the device status
  * @VDUSE_UPDATE_IOTLB: Notify userspace to update the memory mapping for
  *                      specified IOVA range via VDUSE_IOTLB_GET_FD ioctl
+ * @VDUSE_SET_VQ_GROUP_ASID: Notify userspace to update the address space of a
+ *                           virtqueue group.
  */
 enum vduse_req_type {
 	VDUSE_GET_VQ_STATE,
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
+	VDUSE_SET_VQ_GROUP_ASID,
 };
 
 /**
@@ -314,6 +355,18 @@ struct vduse_iova_range {
 	__u64 last;
 };
 
+/**
+ * struct vduse_iova_range_v2 - IOVA range [start, last] if API_VERSION >= 1
+ * @start: start of the IOVA range
+ * @last: last of the IOVA range
+ * @asid: address space ID of the IOVA range
+ */
+struct vduse_iova_range_v2 {
+	__u64 start;
+	__u64 last;
+	__u32 asid;
+};
+
 /**
  * struct vduse_dev_request - control request
  * @type: request type
@@ -322,6 +375,8 @@ struct vduse_iova_range {
  * @vq_state: virtqueue state, only index field is available
  * @s: device status
  * @iova: IOVA range for updating
+ * @iova_v2: IOVA range for updating if API_VERSION >= 1
+ * @vq_group_asid: ASID of a virtqueue group
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -334,6 +389,11 @@ struct vduse_dev_request {
 		struct vduse_vq_state vq_state;
 		struct vduse_dev_status s;
 		struct vduse_iova_range iova;
+		/* Following members but padding exist only if vduse api
+		 * version >= 1
+		 */
+		struct vduse_iova_range_v2 iova_v2;
+		struct vduse_vq_group_asid vq_group_asid;
 		__u32 padding[32];
 	};
 };
-- 
2.52.0

