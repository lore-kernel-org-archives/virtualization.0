Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4735C45041C;
	Sun,  4 Oct 2026 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118896; cv=none; b=eTWYmCQORRqV8+TjoJQ2IAXMhtbEF+ZVqyi3Xf4jfikGM9sovOnGC96TJS5Am27nmfryisSXV+OvIYtCnZdfrJh+Rw5M9Ied9uoyGDeeIrACyGbLh0MqIaoJZAJRnAmsfEISTMdS3GzdRhCTGXjmGVjnDDksv3IGbegiSurztak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118896; c=relaxed/simple;
	bh=mfUaFcZYqkVJqitlN13YmY5Dk01ph7q2xThl/6efWGs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dHtnC/c/GR1gdFsKThm+zjLxYHWpPeNcfa93TjhUJDqrUCUsJugOQXp+3Wq5lVI1zn5BSqgLMLaAw35sb2nX+aUkZt+6FBsvzT/kQE+FKCWisIvQ8ZuLaodgIu4EpECnOUUABqYGhmERHiF5c37ZWG8QyKaaWt4h3r8WdC4vco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=r5Xr0Ujb; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="r5Xr0Ujb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791118889; bh=/Gpb1MJc8GoBPuty8IFwcD8PfPxx1MzaXkRX/KqQeMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r5Xr0UjbWea6HmobxfmaAty9oJ6U6Gv5/5uSEuBgBg22apNfT8VwzTnKFlSDpM3Cr
	 NEVkBrkokZFyy5HC+1in8EMd6cKOAZ+Or162aaNd4wx/htrcr8CbKZS7XjAHT0+H/g
	 djEkgMEE/kZRA8gdyhO6+YT775eg53vxWN6C8paM=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4EAF2BA; Sun, 04 Oct 2026 21:01:14 +0800
X-QQ-mid: xmsmtpt1791118886tby8awh9f
Message-ID: <tencent_5FCFC7891F9B565EBA65B56B951EDC219B08@qq.com>
X-QQ-XMAILINFO: NBMltDMjH0L19/E8hhJGj7LXCGPJjwUdp4Su2Gw9+f3n/mSCij2dNCrjcQgJrq
	 dG4a3p48x+oEUUbaXs9tj2cEDDEEj90DjqP+hrwTYD2IApomMJLKpZnqzdvuOb4KvBIpZvaut8sQ
	 ePYPLv+sTYYAlKW0YNd0Q9tR9roY7n1FNAocxdI4xMkkw/iTZkR7SInc4AhJHAXjwkWyfO7p17oo
	 9JIf6FEoTsTqq/HPYZxzizSJHHISfHrxYAToGB2Ys7WcrY2I9KKX0OwDDNxQmzSClkWkKPij7O3F
	 ZOYdwtNcgK7vks0gGX+77n6mZSh8uZMNok7Jht/sEeJ3YSR9DI4QL5x25SiEudtuVQLb3A3HEHUE
	 3TJ2HXbZ5u++UdCJuro/K799T/yq+K8CPvtXswtRRTIlJhQX3wbxz4g47VqEzYwK3foigBu+KRA1
	 KO9dZzk27HCplgapZyWdyIgPWJEUrtHquX2fv3Gw/c4/UvddO7OSpAZzci3d3bDs0ENm4VhUCFDc
	 u0DcBrvetm++XtJ9QuGgsiCDM0WaDvRaGd/2IGEoShLKMmnjPmFBkHTv2idQKYHMj2EOcei4N0ZK
	 AEBDW24SePyK2M65b5ychDhpFH5jWDdv5XhWjCZLWL0E3mMq1doarSb9ZIuCZ7wpdFct851FHFYH
	 BXfSwacmOIlOxaPTUpBPo/P8Te6cHjPT9lRE5xXYzbd48X42Is2vNsjursABp31E7PaoPy/vvUOo
	 xeeUaFmRUQ+nIB6dJ9ipWJwTku1dsWNnxapphnR6L5c8SMFQ32AU2Q+/1aQv04ftry7sUwdWpHFm
	 jmXFns6FEP6H+JTRqxUIJ+wUExO9ilCEgjR4bCGYXoT10xD6nprKTvtAsuX/lhDbWnVGQEdHLRHU
	 n2rjavODYSQIhWh8fpiNTaPCLjEZKdiaNdkqDQdz47aTALnrIDf1CTWtagEJ/GIbkSyzHg3CKwFL
	 /z5fSdru56BVdQy89J8BXhmDTMf0IIsD+vPEA/D4WWXt799+XVH9QAQJbMapLe1oEH/ztbKkA8HB
	 W5OX4VoS4GSTbcKeLjjbuPr8jGLLPa2Kj27DVEpvOatFxRiexSFW+e+c1EJ4r85HI8/cWMhLGNtW
	 tooXvzD9nQFSdAC4SukefqpYNo/yf9NXpwbtvzIcS3lAakn0Rr2V1dJouclNX/7NJEYNXRuJVcSL
	 fl7nI=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Anlai Lu <agicy@qq.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anlai Lu <agicy@qq.com>
Subject: [PATCH v2 4/6] iommu/virtio: stop queueing and draining once the device is removed
Date: Sun,  4 Oct 2026 13:01:11 +0000
X-OQ-MSGID: <20261004130113.3225005-4-agicy@qq.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
References: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

viommu_remove() resets the device and deletes the virtqueues while
userspace may still hold domains that it maps or attaches, and nothing
stopped a request from being queued - or a drain from walking the queue -
on a virtqueue that was being torn down.

Set ->removed under request_lock before the teardown - the lock a
queueing path holds while it checks liveness and adds the request, and
the one the drain holds for its whole run - check it in the queueing
helper, and let the drain return early when it is set.

A drain that returns early leaves the requests still on the queue
behind, and the device cannot complete them either.  Detach them
from the request virtqueue - which unmaps their DMA mappings - and
free them after the device is reset, when it can no longer be using
them, and before the queues are deleted, so that the objects do not
leak.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Signed-off-by: Anlai Lu <agicy@qq.com>
---
 drivers/iommu/virtio-iommu.c | 49 ++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index f886941d8f3b..7119030dbcb3 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -42,6 +42,11 @@ struct viommu_dev {
 	spinlock_t			request_lock;
 	struct list_head		requests;
 	void				*evts;
+	/*
+	 * Set before the teardown: nothing may be queued or drained after
+	 * that.
+	 */
+	bool				removed;
 
 	/* Device configuration */
 	struct iommu_domain_geometry	geometry;
@@ -116,6 +121,16 @@ static struct viommu_domain viommu_identity_domain;
 #define to_viommu_domain(domain)	\
 	container_of(domain, struct viommu_domain, domain)
 
+/*
+ * The device can be removed while its domains still exist (userspace may hold
+ * them for a while), and the queues go away with it: nothing may be queued or
+ * drained after that.
+ */
+static bool viommu_device_live(struct viommu_dev *viommu)
+{
+	return !viommu->removed;
+}
+
 static int viommu_get_req_errno(void *buf, size_t len)
 {
 	struct virtio_iommu_req_tail *tail = buf + len - sizeof(*tail);
@@ -206,6 +221,10 @@ static int viommu_sync_req(struct viommu_dev *viommu)
 	unsigned long flags;
 
 	spin_lock_irqsave(&viommu->request_lock, flags);
+	if (!viommu_device_live(viommu)) {
+		spin_unlock_irqrestore(&viommu->request_lock, flags);
+		return 0;
+	}
 	ret = __viommu_sync_req(viommu);
 	if (ret)
 		dev_dbg(viommu->dev, "could not sync requests (%d)\n", ret);
@@ -229,6 +248,9 @@ static int __viommu_queue_req(struct viommu_dev *viommu,
 
 	assert_spin_locked(&viommu->request_lock);
 
+	if (!viommu_device_live(viommu))
+		return -ENODEV;
+
 	sg_init_one(&top_sg, req->buf, write_offset);
 	sg_init_one(&bottom_sg, req->buf + write_offset,
 		    req->len - write_offset);
@@ -1569,12 +1591,39 @@ static int viommu_probe(struct virtio_device *vdev)
 static void viommu_remove(struct virtio_device *vdev)
 {
 	struct viommu_dev *viommu = vdev->priv;
+	struct viommu_request *req;
+	struct virtqueue *vq;
+	unsigned long flags;
 
 	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
 
+	/*
+	 * The queues go away here: nothing may be queued or drained from now
+	 * on.  Taking request_lock is what tells a drain in flight that it has
+	 * to finish before the teardown, since the drain holds it throughout.
+	 */
+	spin_lock_irqsave(&viommu->request_lock, flags);
+	viommu->removed = true;
+	spin_unlock_irqrestore(&viommu->request_lock, flags);
+
 	/* Stop all virtqueues */
 	virtio_reset_device(vdev);
+
+	/*
+	 * The device cannot complete the requests still on the queue, and
+	 * the drain does not touch them anymore: detach them from the
+	 * request virtqueue - which releases their scatterlists - and free
+	 * them.
+	 */
+	spin_lock_irqsave(&viommu->request_lock, flags);
+	vq = viommu->vqs[VIOMMU_REQUEST_VQ];
+	while ((req = virtqueue_detach_unused_buf(vq))) {
+		list_del(&req->list);
+		kfree(req);
+	}
+	spin_unlock_irqrestore(&viommu->request_lock, flags);
+
 	vdev->config->del_vqs(vdev);
 
 	dev_info(&vdev->dev, "device removed\n");
-- 
2.55.0

