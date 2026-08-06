Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA230568D
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025461; cv=none; b=XCmxfzrKDkm1WI6/GL2oOSsWKbWROQsdnlS1kWHQjYC5uD4lv37CXUkGqszkaAJ/XMI2U3YcafrlldoZKIRUDPRri3FkIabsSQ7/isjX0S+EFAcfwRnp1cRQxVHGYGnf8HfwU2BOcA6JvW24q47/cqgbMLJxiB0kzGHdBxpY7nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025461; c=relaxed/simple;
	bh=NwBIt/uJ4VdZ7/SW+rBwQSYexGMFFGSBY0Idlnk8YHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t6XPVpRpIY42jYZySCGrLg4scPVmHNk+uXaoAhCAcUIGE1BPwAaGlKolnXbiPf4zVvgrU2LDU5QF/iuwMmvWwYH3Tk+6n3Y26exK5SLHg2rFGpebrA0LA0Jvlh2GQBAJnZpx2ylCi6CcdxaKdck6pjVko7/Ta1DfNN0VHAQQcj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+s68SOr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+s68SOr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so28689605ad.1
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786025459; x=1786630259; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ePY+/1fTaXFojTIYlblnOIxB+i9LU95CuQeSgwNz2HQ=;
        b=g+s68SOrn+59Gaba7bnzmurWztUKbtA1uSOKNZ4XMQIEV4/FyPHXkgKDAVQoCyAMlv
         ZNNobgq4uf+X/FFRwAKYrDveGu+X3yzJDmilErRmCNGXu6ZemYZgsr5qI7Hax7hx1NQ3
         Qf8FwbRfaIUC8eogB8J8jR/3uxFzQhUL5gafKyeDOSbh9mHWAvElicgRZXjOrjmL33N3
         AVriuwRp7VCWqIZQvby+P0Q4nVIvyWuFio8eAEkOFZ5LLegG/PidXSWFoMMJogYjFcfa
         sRbDMmfj2TTU3K9InCix0tZLSgTrrct5OaGvwRfYPpdTiIFvDQ+W+Ql8wAra3Tm4VQCi
         9J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025459; x=1786630259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ePY+/1fTaXFojTIYlblnOIxB+i9LU95CuQeSgwNz2HQ=;
        b=sPSPIFOAem6h9vejD9+1Tt0lMb31ZoKYk3FJpJph/i9mY7vkE+aYgW4XoUFR3GBUcu
         WA6jB9OWrQBM1p9KMQ0Q2DhGxeZde5EL2qOUmsLaNgalXfCa9KspdY3wxrvj93Yr0ulb
         kjH9bVUZeF9yYZvyVU72jei4ImIbwaNQmYEnggmjzxP/SjsTYiOzsO5vIRV1b+EF/XSt
         fYgs+7FfKF4fvbUXGWqd/EtR/urezHQfK0qvtbS22YCI+oH67N9crou942Ly9KjOUK4T
         onPhLRgX42zaDKQImt98xcahad/f+gv6DO+deixFhNw9AzlMzwfa6M4OAheZWXlqV4GR
         uz1w==
X-Forwarded-Encrypted: i=1; AHgh+RpjVniTgKZIeqX2be8NJzpQtatYp+92xb5iY26Ym1x9+iVavlJv4NhOMazuqgPUyo6BFCGH1L4nEy104VRf6g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2ezuodE/lB6Ol+cTu78NyvVDrDNEHCRnTWeAURMR+EGATwrE+
	pUsQFn60xebVeobLpZZENAMfGP3B5ajU0R8JPOhaz11APQiIxsXncOr5
X-Gm-Gg: AR+sD12fH3Eru5naKYYoy6ocBMY3NekdmqJ/bs/6cwqyptsyy7v+8x7QjOUpic3jny/
	/3RZhCpJmISAHuzrWNhw6iZI07+gHGLSZzbuG5oH3BK2a6hx/Yszud0kr2/QkcpeUa4d2e+hujv
	XL5csVVyt+E9yfF8ehC1jFBSvYJT66EB61Yn6+6j3A1V6Mq1s7bwfb7NXhkOmfQIu58E6/Yj9ez
	j3AG7lfn3NVeq9I1TOq/ja2IcvoAm808Hg8c01cpCrYia5ILFk1kpNV3ty7O3Mp2am91NSoxBX9
	ffynQuhJpZwiwd6VZyMOTnOrQ9mnyAOJXAtRgwY3/XgbrpNffmPH0xh62ur7B+DVKK8Ba8RyCGh
	KnfwOfl38jlNpe6ji/nG6anDbyAg3WeGvxEw9oGWUj4dVlGFII+7kfu+78ZmNEBTMB9ECbnVSHR
	2+C2h3HGVDOr3l7BOjLhVrXjcYb/Sg7T8NEx9QFobfmT8oqVhEBDvDCS9Zz7fU3aGbKrjaUZJxG
	rtCNz57rKg=
X-Received: by 2002:a17:902:d98b:b0:2ca:20b1:3e0a with SMTP id d9443c01a7336-2d0ca7af30fmr195609985ad.3.1786025458423;
        Thu, 06 Aug 2026 07:10:58 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4bbc5csm32060905ad.62.2026.08.06.07.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:10:58 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [RFC PATCH] vhost: coalesce and retry IOTLB miss messages
Date: Thu,  6 Aug 2026 22:06:16 +0800
Message-Id: <20260806140616.59025-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_iotlb_miss() allocates a vhost_msg_node for each descriptor
translation miss. The node is linked on dev->read_list. After userspace
reads it, vhost_chr_read_iter() moves it to dev->pending_list. It stays
there until an IOTLB UPDATE covers the missed IOVA.

The failure was reproduced on a server with no swap device. Start
vhost-net with VIRTIO_F_ACCESS_PLATFORM, post a descriptor for an
unmapped IOVA, and keep kicking the same virtqueue. Leave the vhost fd
unread, or read the MISS messages without installing a covering mapping.

The virtqueue does not advance past the descriptor that missed. Each kick
hits the same missing translation and allocates another message. The
read_list grows when userspace does not read the fd. The pending_list
grows when userspace reads the MISS messages but does not install the
mapping. On the test server the accumulated nodes consumed available
memory and the OOM killer ran.

A device-wide hard limit was considered as a smaller change. One
virtqueue can fill the limit with repeated reports for the same IOVA.
When another virtqueue misses, vhost_new_msg() returns NULL and no MISS is
placed on read_list. translate_desc() still returns -EAGAIN and does not
record that the second virtqueue needs another attempt. Freeing entries
from the limit does not retry that virtqueue. It remains stopped unless
the guest happens to kick it again.

I did not find a smaller fix which also retries a virtqueue after a full
limit.

Record the current miss on each virtqueue by IOVA and permission.
Repeated misses for that IOVA and permission return without allocating a
new message.

For N reports of the same unresolved miss, the old code performs N
allocations, N read-list insertions and N wakeups. This change performs
one allocation, one insertion and one wakeup. It removes N-1 allocations,
insertions and wakeups. The first report takes two iotlb_lock passes.
Later reports take one pass and stop at the per-virtqueue check. Compared
with the old code, N repeated reports add one iotlb_lock pass in total and
remove N-1 allocations, insertions and wakeups.

Keep a device-wide count for message nodes that are already in their
read/copy/pending lifetime. When the count reaches the limit, put the
virtqueue on a FIFO wait list. Freeing a MISS message wakes one waiter so
it can retry the translation and report its current miss.

IOTLB UPDATE checks the current miss recorded on each virtqueue. A
covering update clears the current miss and wakes the virtqueue. Old
message nodes keep their normal lifetime; freeing an old node clears the
virtqueue pointer only when it still points to that node.


Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vhost.c | 212 ++++++++++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h |  15 +++
 2 files changed, 209 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4c525b3e16ea..cfbff17761d8 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -34,6 +34,8 @@
 
 #include "vhost.h"
 
+#define VHOST_MAX_IOTLB_MSGS 2048
+
 static ushort max_mem_regions = 64;
 module_param(max_mem_regions, ushort, 0444);
 MODULE_PARM_DESC(max_mem_regions,
@@ -603,6 +605,8 @@ void vhost_dev_init(struct vhost_dev *dev,
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
+	INIT_LIST_HEAD(&dev->iotlb_wait_list);
+	dev->iotlb_msg_count = 0;
 	spin_lock_init(&dev->iotlb_lock);
 	xa_init_flags(&dev->worker_xa, XA_FLAGS_ALLOC);
 
@@ -615,6 +619,9 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vq->dev = dev;
 		mutex_init(&vq->mutex);
 		vhost_vq_reset(dev, vq);
+		vq->iotlb_miss_node = NULL;
+		vq->iotlb_miss_waiting = false;
+		INIT_LIST_HEAD(&vq->iotlb_miss_wait_node);
 		if (vq->handle_kick)
 			vhost_poll_init(&vq->poll, vq->handle_kick,
 					EPOLLIN, dev, vq);
@@ -1177,20 +1184,104 @@ void vhost_dev_stop(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_stop);
 
+static void vhost_wait_iotlb_miss(struct vhost_dev *dev,
+				  struct vhost_virtqueue *vq)
+{
+	lockdep_assert_held(&dev->iotlb_lock);
+
+	if (vq->iotlb_miss_waiting)
+		return;
+
+	vq->iotlb_miss_waiting = true;
+	list_add_tail(&vq->iotlb_miss_wait_node, &dev->iotlb_wait_list);
+}
+
+static void vhost_unwait_iotlb_miss(struct vhost_dev *dev,
+				    struct vhost_virtqueue *vq)
+{
+	lockdep_assert_held(&dev->iotlb_lock);
+
+	if (!vq->iotlb_miss_waiting)
+		return;
+
+	vq->iotlb_miss_waiting = false;
+	list_del_init(&vq->iotlb_miss_wait_node);
+}
+
+static void vhost_wake_iotlb_waiter(struct vhost_dev *dev)
+{
+	struct vhost_virtqueue *vq;
+
+	lockdep_assert_held(&dev->iotlb_lock);
+
+	if (!dev->iotlb || dev->iotlb_msg_count >= VHOST_MAX_IOTLB_MSGS ||
+	    list_empty(&dev->iotlb_wait_list))
+		return;
+
+	vq = list_first_entry(&dev->iotlb_wait_list,
+			      struct vhost_virtqueue, iotlb_miss_wait_node);
+	vhost_unwait_iotlb_miss(dev, vq);
+	vhost_poll_queue(&vq->poll);
+}
+
+static void __vhost_free_msg(struct vhost_dev *dev,
+			     struct vhost_msg_node *node)
+{
+	bool iotlb_miss = node->iotlb_miss;
+
+	lockdep_assert_held(&dev->iotlb_lock);
+
+	if (iotlb_miss) {
+		if (node->vq->iotlb_miss_node == node)
+			node->vq->iotlb_miss_node = NULL;
+		dev->iotlb_msg_count--;
+	}
+
+	kfree(node);
+
+	if (iotlb_miss)
+		vhost_wake_iotlb_waiter(dev);
+}
+
+static void vhost_free_msg(struct vhost_msg_node *node)
+{
+	struct vhost_dev *dev = node->vq->dev;
+
+	spin_lock(&dev->iotlb_lock);
+	if (node->iotlb_miss)
+		__vhost_free_msg(dev, node);
+	else
+		kfree(node);
+	spin_unlock(&dev->iotlb_lock);
+}
+
 void vhost_clear_msg(struct vhost_dev *dev)
 {
 	struct vhost_msg_node *node, *n;
+	struct vhost_virtqueue *vq, *vq_n;
+	int i;
 
 	spin_lock(&dev->iotlb_lock);
 
 	list_for_each_entry_safe(node, n, &dev->read_list, node) {
-		list_del(&node->node);
-		kfree(node);
+		list_del_init(&node->node);
+		__vhost_free_msg(dev, node);
 	}
 
 	list_for_each_entry_safe(node, n, &dev->pending_list, node) {
-		list_del(&node->node);
-		kfree(node);
+		list_del_init(&node->node);
+		__vhost_free_msg(dev, node);
+	}
+
+	if (!dev->iotlb) {
+		list_for_each_entry_safe(vq, vq_n, &dev->iotlb_wait_list,
+					 iotlb_miss_wait_node) {
+			list_del_init(&vq->iotlb_miss_wait_node);
+			vq->iotlb_miss_waiting = false;
+		}
+
+		for (i = 0; i < dev->nvqs; ++i)
+			dev->vqs[i]->iotlb_miss_node = NULL;
 	}
 
 	spin_unlock(&dev->iotlb_lock);
@@ -1588,18 +1679,25 @@ static inline int vhost_get_desc(struct vhost_virtqueue *vq,
 static void vhost_iotlb_notify_vq(struct vhost_dev *d,
 				  struct vhost_iotlb_msg *msg)
 {
-	struct vhost_msg_node *node, *n;
+	int i;
 
 	spin_lock(&d->iotlb_lock);
 
-	list_for_each_entry_safe(node, n, &d->pending_list, node) {
-		struct vhost_iotlb_msg *vq_msg = &node->msg.iotlb;
-		if (msg->iova <= vq_msg->iova &&
-		    msg->iova + msg->size - 1 >= vq_msg->iova &&
-		    vq_msg->type == VHOST_IOTLB_MISS) {
-			vhost_poll_queue(&node->vq->poll);
-			list_del(&node->node);
-			kfree(node);
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+		struct vhost_msg_node *node = vq->iotlb_miss_node;
+
+		if (!node || msg->iova > node->iotlb_miss_iova ||
+		    msg->iova + msg->size - 1 < node->iotlb_miss_iova)
+			continue;
+
+		vq->iotlb_miss_node = NULL;
+		node->iotlb_miss_resolved = true;
+		vhost_poll_queue(&vq->poll);
+		if (node->iotlb_miss_pending) {
+			node->iotlb_miss_pending = false;
+			list_del_init(&node->node);
+			__vhost_free_msg(d, node);
 		}
 	}
 
@@ -1809,7 +1907,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 
 		ret = copy_to_iter(start, size, to);
 		if (ret != size || msg->type != VHOST_IOTLB_MISS) {
-			kfree(node);
+			vhost_free_msg(node);
 			return ret;
 		}
 		vhost_enqueue_msg(dev, &dev->pending_list, node);
@@ -1819,12 +1917,42 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 }
 EXPORT_SYMBOL_GPL(vhost_chr_read_iter);
 
+static bool vhost_iotlb_miss_exists(struct vhost_virtqueue *vq, u64 iova,
+				    int access)
+{
+	struct vhost_msg_node *node = vq->iotlb_miss_node;
+
+	lockdep_assert_held(&vq->dev->iotlb_lock);
+
+	return node && !node->iotlb_miss_resolved &&
+	       node->iotlb_miss_iova == iova &&
+	       node->iotlb_miss_perm == access;
+}
+
 static int vhost_iotlb_miss(struct vhost_virtqueue *vq, u64 iova, int access)
 {
 	struct vhost_dev *dev = vq->dev;
 	struct vhost_msg_node *node;
 	struct vhost_iotlb_msg *msg;
 	bool v2 = vhost_backend_has_feature(vq, VHOST_BACKEND_F_IOTLB_MSG_V2);
+	bool queued = false;
+	int ret = 0;
+
+	/* A failed translation stops this VQ before another miss can occur. */
+	lockdep_assert_held(&vq->mutex);
+
+	spin_lock(&dev->iotlb_lock);
+	if (vhost_iotlb_miss_exists(vq, iova, access)) {
+		vhost_unwait_iotlb_miss(dev, vq);
+		spin_unlock(&dev->iotlb_lock);
+		return 0;
+	}
+	if (dev->iotlb_msg_count >= VHOST_MAX_IOTLB_MSGS) {
+		vhost_wait_iotlb_miss(dev, vq);
+		spin_unlock(&dev->iotlb_lock);
+		return -ENOSPC;
+	}
+	spin_unlock(&dev->iotlb_lock);
 
 	node = vhost_new_msg(vq, v2 ? VHOST_IOTLB_MSG_V2 : VHOST_IOTLB_MSG);
 	if (!node)
@@ -1840,8 +1968,40 @@ static int vhost_iotlb_miss(struct vhost_virtqueue *vq, u64 iova, int access)
 	msg->type = VHOST_IOTLB_MISS;
 	msg->iova = iova;
 	msg->perm = access;
+	node->iotlb_miss = true;
+	node->iotlb_miss_iova = iova;
+	node->iotlb_miss_perm = access;
 
-	vhost_enqueue_msg(dev, &dev->read_list, node);
+	spin_lock(&dev->iotlb_lock);
+	if (vhost_iotlb_miss_exists(vq, iova, access)) {
+		vhost_unwait_iotlb_miss(dev, vq);
+		goto unlock;
+	}
+	if (WARN_ON_ONCE(vq->iotlb_miss_node)) {
+		ret = -EAGAIN;
+		goto unlock;
+	}
+	if (dev->iotlb_msg_count >= VHOST_MAX_IOTLB_MSGS) {
+		vhost_wait_iotlb_miss(dev, vq);
+		ret = -ENOSPC;
+		goto unlock;
+	}
+
+	dev->iotlb_msg_count++;
+	vq->iotlb_miss_node = node;
+	list_add_tail(&node->node, &dev->read_list);
+	vhost_unwait_iotlb_miss(dev, vq);
+	queued = true;
+
+unlock:
+	spin_unlock(&dev->iotlb_lock);
+
+	if (!queued) {
+		kfree(node);
+		return ret;
+	}
+
+	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
 
 	return 0;
 }
@@ -3283,11 +3443,25 @@ EXPORT_SYMBOL_GPL(vhost_new_msg);
 void vhost_enqueue_msg(struct vhost_dev *dev, struct list_head *head,
 		       struct vhost_msg_node *node)
 {
+	bool free = false;
+
 	spin_lock(&dev->iotlb_lock);
-	list_add_tail(&node->node, head);
+	if (node->iotlb_miss) {
+		node->iotlb_miss_pending = head == &dev->pending_list;
+		if (node->iotlb_miss_pending && node->iotlb_miss_resolved) {
+			__vhost_free_msg(dev, node);
+			free = true;
+		} else {
+			list_add_tail(&node->node, head);
+		}
+	} else {
+		list_add_tail(&node->node, head);
+	}
 	spin_unlock(&dev->iotlb_lock);
 
-	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
+	if (!free)
+		wake_up_interruptible_poll(&dev->wait,
+					   EPOLLIN | EPOLLRDNORM);
 }
 EXPORT_SYMBOL_GPL(vhost_enqueue_msg);
 
@@ -3300,7 +3474,9 @@ struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
 	if (!list_empty(head)) {
 		node = list_first_entry(head, struct vhost_msg_node,
 					node);
-		list_del(&node->node);
+		list_del_init(&node->node);
+		if (node->iotlb_miss)
+			node->iotlb_miss_pending = false;
 	}
 	spin_unlock(&dev->iotlb_lock);
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0192ade6e749..b676bdcc629d 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -29,6 +29,7 @@ struct vhost_work {
 
 struct vhost_worker;
 struct vhost_dev;
+struct vhost_msg_node;
 
 struct vhost_worker_ops {
 	int (*create)(struct vhost_worker *worker, struct vhost_dev *dev,
@@ -164,6 +165,11 @@ struct vhost_virtqueue {
 	bool user_be;
 #endif
 	u32 busyloop_timeout;
+
+	/* Protected by dev->iotlb_lock. */
+	struct vhost_msg_node *iotlb_miss_node;
+	struct list_head iotlb_miss_wait_node;
+	bool iotlb_miss_waiting;
 };
 
 struct vhost_msg_node {
@@ -173,6 +179,12 @@ struct vhost_msg_node {
   };
   struct vhost_virtqueue *vq;
   struct list_head node;
+	/* Protected by vq->dev->iotlb_lock. */
+	u64 iotlb_miss_iova;
+	u8 iotlb_miss_perm;
+	bool iotlb_miss;
+	bool iotlb_miss_resolved;
+	bool iotlb_miss_pending;
 };
 
 struct vhost_dev {
@@ -202,8 +214,11 @@ struct vhost_dev {
 	 * The default value is set by fork_from_owner_default
 	 */
 	bool fork_owner;
+	/* Includes messages being copied to userspace. Protected by iotlb_lock. */
+	u16 iotlb_msg_count;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
+	struct list_head iotlb_wait_list;
 };
 
 bool vhost_exceeds_weight(struct vhost_virtqueue *vq, int pkts, int total_len);
