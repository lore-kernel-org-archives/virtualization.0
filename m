Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A0333CE92
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604342; cv=none; b=eTK611GsfaH6cfqQsjpBmSEK4dJLG+ADSUf/ztEmVmFBRY1WDlcq9R3Y0+bxmlF8ZTddLemcy3Zb7BhShIkD7TUVsYyUt/4O63pY+ax+uz7vX8B/70LV55UfvVl8kFSsJ2/md486IWtXZUeMA9DEfkv5BOeoZ3wxj31UZOUQuQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604342; c=relaxed/simple;
	bh=vOqUO0cPzeG6aQUwYOb8NotITcNEuffs9cCb4v4Ei+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Di8mZff/kN02z9KmvdLmFCCgylaq2A96726++7FYZy08XThvnLxl/omKpiIXPXV8mBl4mAh3e+PmR+lJP5Ll4+pZn4yp7IDut1wU5aQb/O6H/XKDiAAqB2Gv5dLSiM2D7jomPQNY6Enwwj82ORrW+mod6cMiJRJby1OtsBzx8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1fdsRlh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1fdsRlh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769604339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzVBQh8ynOpx3vM+BHN969HxbH33+A4edKnI99b4pMw=;
	b=J1fdsRlhZLt+qarQgdwl/9SfDyL3GNxqK9OlsU/EX6Ln8k9hO/Alwo1wq5unqnQzPpz/ZH
	5PhsP9HlAvWZ67lZHkJ55anq3+PuDS3n25I3pvvt4m0gKD43oXObyJXwfQJyeVtwq0DOXM
	YnF+AABbUO0hyoH2oCsWrRXIk5euswA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-30EKy1cQNlmA7Wz3xrjvCQ-1; Wed,
 28 Jan 2026 07:45:36 -0500
X-MC-Unique: 30EKy1cQNlmA7Wz3xrjvCQ-1
X-Mimecast-MFC-AGG-ID: 30EKy1cQNlmA7Wz3xrjvCQ_1769604335
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FAFC180035D;
	Wed, 28 Jan 2026 12:45:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.239])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FAA130001A2;
	Wed, 28 Jan 2026 12:45:31 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 1/6] vduse: ensure vq->ready access is smp safe
Date: Wed, 28 Jan 2026 13:45:19 +0100
Message-ID: <20260128124524.875271-2-eperezma@redhat.com>
In-Reply-To: <20260128124524.875271-1-eperezma@redhat.com>
References: <20260128124524.875271-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The vduse_vdpa_set_vq_ready can be called in the lifetime of the device
well after initial setup, and the device can read it afterwards.

Ensure that reads and writes to vq->ready are SMP safe so that the
caller can trust that virtqueue kicks and calls behave as expected
immediately after the operation returns.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 34 +++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 73d1d517dc6c..a4963aaf9332 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -460,6 +460,24 @@ static __poll_t vduse_dev_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
+static bool vduse_vq_get_ready(const struct vduse_virtqueue *vq)
+{
+	/*
+	 * Paired with vduse_vq_set_ready smp_store, as the driver may modify
+	 * it while the VDUSE instance is reading it.
+	 */
+	return smp_load_acquire(&vq->ready);
+}
+
+static void vduse_vq_set_ready(struct vduse_virtqueue *vq, bool ready)
+{
+	/*
+	 * Paired with vduse_vq_get_ready smp_load, as the driver may modify
+	 * it while the VDUSE instance is reading it.
+	 */
+	smp_store_release(&vq->ready, ready);
+}
+
 static void vduse_dev_reset(struct vduse_dev *dev)
 {
 	int i;
@@ -486,7 +504,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 	for (i = 0; i < dev->vq_num; i++) {
 		struct vduse_virtqueue *vq = dev->vqs[i];
 
-		vq->ready = false;
+		vduse_vq_set_ready(vq, false);
 		vq->desc_addr = 0;
 		vq->driver_addr = 0;
 		vq->device_addr = 0;
@@ -529,7 +547,7 @@ static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
 static void vduse_vq_kick(struct vduse_virtqueue *vq)
 {
 	spin_lock(&vq->kick_lock);
-	if (!vq->ready)
+	if (!vduse_vq_get_ready(vq))
 		goto unlock;
 
 	if (vq->kickfd)
@@ -598,7 +616,7 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	struct vduse_virtqueue *vq = dev->vqs[idx];
 
-	vq->ready = ready;
+	vduse_vq_set_ready(vq, ready);
 }
 
 static bool vduse_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 idx)
@@ -606,7 +624,7 @@ static bool vduse_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 idx)
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	struct vduse_virtqueue *vq = dev->vqs[idx];
 
-	return vq->ready;
+	return vduse_vq_get_ready(vq);
 }
 
 static int vduse_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 idx,
@@ -1097,7 +1115,7 @@ static int vduse_kickfd_setup(struct vduse_dev *dev,
 	if (vq->kickfd)
 		eventfd_ctx_put(vq->kickfd);
 	vq->kickfd = ctx;
-	if (vq->ready && vq->kicked && vq->kickfd) {
+	if (vduse_vq_get_ready(vq) && vq->kicked && vq->kickfd) {
 		eventfd_signal(vq->kickfd);
 		vq->kicked = false;
 	}
@@ -1133,7 +1151,7 @@ static void vduse_vq_irq_inject(struct work_struct *work)
 					struct vduse_virtqueue, inject);
 
 	spin_lock_bh(&vq->irq_lock);
-	if (vq->ready && vq->cb.callback)
+	if (vduse_vq_get_ready(vq) && vq->cb.callback)
 		vq->cb.callback(vq->cb.private);
 	spin_unlock_bh(&vq->irq_lock);
 }
@@ -1146,7 +1164,7 @@ static bool vduse_vq_signal_irqfd(struct vduse_virtqueue *vq)
 		return false;
 
 	spin_lock_irq(&vq->irq_lock);
-	if (vq->ready && vq->cb.trigger) {
+	if (vduse_vq_get_ready(vq) && vq->cb.trigger) {
 		eventfd_signal(vq->cb.trigger);
 		signal = true;
 	}
@@ -1500,7 +1518,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			vq_info.split.avail_index =
 				vq->state.split.avail_index;
 
-		vq_info.ready = vq->ready;
+		vq_info.ready = vduse_vq_get_ready(vq);
 
 		ret = -EFAULT;
 		if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
-- 
2.52.0

