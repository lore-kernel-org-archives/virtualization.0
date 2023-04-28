Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89C9C77B61
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 16:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 892C942A50;
	Fri, 28 Apr 2023 16:32:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 892C942A50
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=WXSQZXMy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rqKpuw8PgV_i; Fri, 28 Apr 2023 16:31:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A57AA42A5B;
	Fri, 28 Apr 2023 16:31:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A57AA42A5B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA389C008C;
	Fri, 28 Apr 2023 16:31:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 832B4C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C73A428A0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C73A428A0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=WXSQZXMy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b9HNw8JcOqa5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FE3D428AA
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FE3D428AA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:54 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33SF3vdc007223; Fri, 28 Apr 2023 16:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=yoP1VqZlrY3j95UTVYPC9CmkJpfo5fwrKQ5CSdOy6Wo=;
 b=WXSQZXMydKiyPBgH2Xb0JcY0eYI3z1bPG31TybMYhLf5f0MtMGt3SDvOsv3h5Hj6PrVy
 fLah/e5ISRnVP9aLhpFJhGZ8bizjDqMsRRjRb3YgcAXvSVl19Gq/UsaTNKJvbNi97tbh
 fWiS6u/JmLt0O1mC6kfJULgNi0WKq1x/SvG0vZQVlGoGTRw80Gg+Igl803ZTKS26BmJK
 HENblSWc1rn0/gS6VF5pSsqj6F4zjyErcQqUXkkeCg+ewOFmC6otnMhnVVpqD6MnTydU
 sNhGmnp8FdrCznwqt3HiVIzE04j1jP7mHrGrUBv1nG60dH1HaaeNj4zYVJA/YEtJnCAj TQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46c4esf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:31:53 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 33SFlJXf020314; Fri, 28 Apr 2023 16:31:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3q461h8mjd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:31:52 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SGVYPv023567;
 Fri, 28 Apr 2023 16:31:52 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-109-59.vpn.oracle.com
 [10.154.109.59])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3q461h8m7j-13; Fri, 28 Apr 2023 16:31:51 +0000
From: Mike Christie <michael.christie@oracle.com>
To: virtualization@lists.linux-foundation.org, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: [PATCH 13/14] vhost: allow userspace to create workers
Date: Fri, 28 Apr 2023 11:31:30 -0500
Message-Id: <20230428163131.92777-13-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428163131.92777-1-michael.christie@oracle.com>
References: <20230428163131.92777-1-michael.christie@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=990
 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280133
X-Proofpoint-GUID: 70GMz-vaPVvdimW-Xr3bz5Jah8eeXlcr
X-Proofpoint-ORIG-GUID: 70GMz-vaPVvdimW-Xr3bz5Jah8eeXlcr
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

For vhost-scsi with 3 vqs or more and a workload that tries to use
them in parallel like:

fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
--ioengine=libaio --iodepth=128  --numjobs=3

the single vhost worker thread will become a bottlneck and we are stuck
at around 500K IOPs no matter how many jobs, virtqueues, and CPUs are
used.

To better utilize virtqueues and available CPUs, this patch allows
userspace to create workers and bind them to vqs. You can have N workers
per dev and also share N workers with M vqs on that dev.

This patch adds the interface related code and the next patch will hook
vhost-scsi into it. The patches do not try to hook net and vsock into
the interface because:

1. multiple workers don't seem to help vsock. The problem is that with
only 2 virtqueues we never fully use the existing worker when doing
bidirectional tests. This seems to match vhost-scsi where we don't see
the worker as a bottleneck until 3 virtqueues are used.

2. net already has a way to use multiple workers.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c            | 145 ++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h            |   3 +
 include/uapi/linux/vhost.h       |  33 +++++++
 include/uapi/linux/vhost_types.h |  16 ++++
 4 files changed, 196 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4b0b82292379..e8f829f35814 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -630,6 +630,80 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	return NULL;
 }
 
+/* Caller must have device mutex */
+static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
+				     struct vhost_worker *worker)
+{
+	if (vq->worker)
+		vq->worker->attachment_cnt--;
+	worker->attachment_cnt++;
+	vq->worker = worker;
+}
+
+/**
+ * vhost_vq_attach_worker - set a virtqueue's worker from an ioctl command
+ * @vq: the virtqueue we will set the worker for
+ * @info: the worker userspace has requested us to use
+ *
+ * We only allow userspace to set a virtqueue's worker if it's not active and
+ * polling is not enabled. We also assume drivers supporting this will not be
+ * internally queueing works directly or via calls like vhost_dev_flush at
+ * this time.
+ *
+ * Caller must have device and virtqueue mutex.
+ */
+static int vhost_vq_attach_worker(struct vhost_virtqueue *vq,
+				  struct vhost_vring_worker *info)
+{
+	unsigned long index = info->worker_id;
+	struct vhost_dev *dev = vq->dev;
+	struct vhost_worker *worker;
+
+	if (!dev->use_worker)
+		return -EINVAL;
+
+	if (vhost_vq_get_backend(vq) || vq->kick)
+		return -EBUSY;
+
+	worker = xa_find(&dev->worker_xa, &index, UINT_MAX, XA_PRESENT);
+	if (!worker || worker->id != info->worker_id)
+		return -ENODEV;
+
+	__vhost_vq_attach_worker(vq, worker);
+	return 0;
+}
+
+/* Caller must have device mutex */
+static int vhost_new_worker(struct vhost_dev *dev,
+			    struct vhost_worker_state *info)
+{
+	struct vhost_worker *worker;
+
+	worker = vhost_worker_create(dev);
+	if (!worker)
+		return -ENOMEM;
+
+	info->worker_id = worker->id;
+	return 0;
+}
+
+static int vhost_free_worker(struct vhost_dev *dev,
+			     struct vhost_worker_state *info)
+{
+	unsigned long index = info->worker_id;
+	struct vhost_worker *worker;
+
+	worker = xa_find(&dev->worker_xa, &index, UINT_MAX, XA_PRESENT);
+	if (!worker || worker->id != info->worker_id)
+		return -ENODEV;
+
+	if (worker->attachment_cnt)
+		return -EBUSY;
+
+	vhost_worker_destroy(dev, worker);
+	return 0;
+}
+
 static int vhost_get_vq_from_user(struct vhost_dev *dev, void __user *argp,
 				  struct vhost_virtqueue **vq, u32 *id)
 {
@@ -651,6 +725,75 @@ static int vhost_get_vq_from_user(struct vhost_dev *dev, void __user *argp,
 	return 0;
 }
 
+/* Caller must have device mutex */
+long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
+			void __user *argp)
+{
+	struct vhost_vring_worker ring_worker;
+	struct vhost_worker_state state;
+	struct vhost_virtqueue *vq;
+	long ret;
+	u32 idx;
+
+	if (!dev->use_worker)
+		return -EINVAL;
+
+	if (!vhost_dev_has_owner(dev))
+		return -EINVAL;
+
+	switch (ioctl) {
+	/* dev worker ioctls */
+	case VHOST_NEW_WORKER:
+		ret = vhost_new_worker(dev, &state);
+		if (!ret && copy_to_user(argp, &state, sizeof(state)))
+			ret = -EFAULT;
+		return ret;
+	case VHOST_FREE_WORKER:
+		if (copy_from_user(&state, argp, sizeof(state)))
+			return -EFAULT;
+		return vhost_free_worker(dev, &state);
+	/* vring worker ioctls */
+	case VHOST_ATTACH_VRING_WORKER:
+	case VHOST_GET_VRING_WORKER:
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	ret = vhost_get_vq_from_user(dev, argp, &vq, &idx);
+	if (ret)
+		return ret;
+
+	mutex_lock(&vq->mutex);
+	switch (ioctl) {
+	case VHOST_ATTACH_VRING_WORKER:
+		if (copy_from_user(&ring_worker, argp, sizeof(ring_worker))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = vhost_vq_attach_worker(vq, &ring_worker);
+		if (!ret && copy_to_user(argp, &ring_worker,
+					 sizeof(ring_worker)))
+			ret = -EFAULT;
+		break;
+	case VHOST_GET_VRING_WORKER:
+		ring_worker.index = idx;
+		ring_worker.worker_id = vq->worker->id;
+
+		if (copy_to_user(argp, &ring_worker, sizeof(ring_worker)))
+			ret = -EFAULT;
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	mutex_unlock(&vq->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vhost_worker_ioctl);
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
@@ -671,7 +814,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 			goto err_worker;
 
 		for (i = 0; i < dev->nvqs; i++)
-			dev->vqs[i]->worker = worker;
+			__vhost_vq_attach_worker(dev->vqs[i], worker);
 	}
 
 	err = vhost_dev_alloc_iovecs(dev);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 2eea20d54134..bcb33a2f64f0 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -31,6 +31,7 @@ struct vhost_worker {
 	struct llist_head	work_list;
 	u64			kcov_handle;
 	u32			id;
+	int			attachment_cnt;
 };
 
 /* Poll a file (eventfd or socket) */
@@ -187,6 +188,8 @@ void vhost_dev_cleanup(struct vhost_dev *);
 void vhost_dev_stop(struct vhost_dev *);
 long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
 long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp);
+long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
+			void __user *argp);
 bool vhost_vq_access_ok(struct vhost_virtqueue *vq);
 bool vhost_log_access_ok(struct vhost_dev *);
 void vhost_clear_msg(struct vhost_dev *dev);
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 92e1b700b51c..155710585979 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -45,6 +45,25 @@
 #define VHOST_SET_LOG_BASE _IOW(VHOST_VIRTIO, 0x04, __u64)
 /* Specify an eventfd file descriptor to signal on log write. */
 #define VHOST_SET_LOG_FD _IOW(VHOST_VIRTIO, 0x07, int)
+/* By default, a device gets one vhost_worker that its virtqueues share. This
+ * command allows the owner of the device to create an additional vhost_worker
+ * for the device. It can later be bound to 1 or more of its virtqueues using
+ * the VHOST_ATTACH_VRING_WORKER command.
+ *
+ * This must be called after VHOST_SET_OWNER and the caller must be the owner
+ * of the device. The new thread will inherit caller's cgroups and namespaces,
+ * and will share the caller's memory space. The new thread will also be
+ * counted against the caller's RLIMIT_NPROC value.
+ *
+ * The worker's ID used in other commands will be returned in
+ * vhost_worker_state.
+ */
+#define VHOST_NEW_WORKER _IOR(VHOST_VIRTIO, 0x8, struct vhost_worker_state)
+/* Free a worker created with VHOST_NEW_WORKER if it's not attached to any
+ * virtqueue. If userspace is not able to call this for workers its created,
+ * the kernel will free all the device's workers when the device is closed.
+ */
+#define VHOST_FREE_WORKER _IOW(VHOST_VIRTIO, 0x9, struct vhost_worker_state)
 
 /* Ring setup. */
 /* Set number of descriptors in ring. This parameter can not
@@ -70,6 +89,20 @@
 #define VHOST_VRING_BIG_ENDIAN 1
 #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
 #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
+/* Attach a vhost_worker created with VHOST_NEW_WORKER to one of the device's
+ * virtqueues. This must be done before VHOST_SET_VRING_KICK and the driver
+ * specific ioctl to activate the virtqueue (VHOST_SCSI_SET_ENDPOINT,
+ * VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING) has been run.
+ *
+ * This will replace the virtqueue's existing worker. If the replaced worker
+ * is no longer attached to any virtqueues, it can be freed with
+ * VHOST_FREE_WORKER.
+ */
+#define VHOST_ATTACH_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x15,		\
+					struct vhost_vring_worker)
+/* Return the vring worker's ID */
+#define VHOST_GET_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x16,		\
+				     struct vhost_vring_worker)
 
 /* The following ioctls use eventfd file descriptors to signal and poll
  * for events. */
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index c5690a8992d8..d3aad12ad1fa 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -47,6 +47,22 @@ struct vhost_vring_addr {
 	__u64 log_guest_addr;
 };
 
+struct vhost_worker_state {
+	/*
+	 * For VHOST_NEW_WORKER the kernel will return the new vhost_worker id.
+	 * For VHOST_FREE_WORKER this must be set to the id of the vhost_worker
+	 * to free.
+	 */
+	unsigned int worker_id;
+};
+
+struct vhost_vring_worker {
+	/* vring index */
+	unsigned int index;
+	/* The id of the vhost_worker returned from VHOST_NEW_WORKER */
+	unsigned int worker_id;
+};
+
 /* no alignment requirement */
 struct vhost_iotlb_msg {
 	__u64 iova;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
