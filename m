Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB69C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 02:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6251161100;
	Tue, 28 Mar 2023 02:17:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6251161100
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=SGWozEcb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 65G99XowwJ6V; Tue, 28 Mar 2023 02:17:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 895C661105;
	Tue, 28 Mar 2023 02:17:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 895C661105
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52D80C007E;
	Tue, 28 Mar 2023 02:17:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5B7BC007C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16A5761117
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16A5761117
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rD1g6ZJeVcDs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB1A161105
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB1A161105
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:36 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32S23u8o015249; Tue, 28 Mar 2023 02:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=Qj3Fe1GyJCFzGcGqCwRbpyBcHYj7Sm01q1zwBCCBvRI=;
 b=SGWozEcbFNaacX2bTHUV8QQjunUSNRylqNUFZN92hJwYerYCX+1fSSq7yMEF76ahSinU
 tif1tKOAdPFUnOq6RdCxvC+lUdZdci6SxUMtrNEzGQXZke7DuwetuAVOIgeF+/UgH5M0
 MMzB3PKoxG1i2gnTVKVJX3POGCe8b44XQgqZFTCFbrhRxjasyoXttwnX8Ga59kTcGCMx
 +68ygT2Kdpc/nxTSe2YLuYUuwvA+XL1ZGn+dhPDjNjknD35clp1XwJLmQrvVYLf0y5U9
 /OihfMss7eglbsmgzKp4g6ymgI5PqFg6geOtXbGnepztlsvabrk/PDv8M+ipqxb/90AL JQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkq4gr0fs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Mar 2023 02:17:35 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32S2BC3p020294; Tue, 28 Mar 2023 02:17:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3phqd61bw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Mar 2023 02:17:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32S2FZlx038246;
 Tue, 28 Mar 2023 02:17:34 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-123-40.vpn.oracle.com
 [10.154.123.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3phqd61bky-12; Tue, 28 Mar 2023 02:17:34 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v6 11/11] vhost: allow userspace to create workers
Date: Mon, 27 Mar 2023 21:17:17 -0500
Message-Id: <20230328021717.42268-12-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328021717.42268-1-michael.christie@oracle.com>
References: <20230328021717.42268-1-michael.christie@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=951 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280016
X-Proofpoint-GUID: D6OMEp4OR-912ZPkvImpyHETC6ALu_fb
X-Proofpoint-ORIG-GUID: D6OMEp4OR-912ZPkvImpyHETC6ALu_fb
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

For vhost-scsi with 3 vqs and a workload like that tries to use those vqs
like:

fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
--ioengine=libaio --iodepth=128  --numjobs=3

the single vhost worker thread will become a bottlneck and we are stuck
at around 500K IOPs no matter how many jobs, virtqueues, and CPUs are
used.

To better utilize virtqueues and available CPUs, this patch allows
userspace to create workers and bind them to vqs. You can have N workers
per dev and also share N workers with M vqs.

With the patches and doing a worker per vq, we can scale to at least
16 vCPUs/vqs (that's my system limit) with the same command fio command
above with numjobs=16:

fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
--ioengine=libaio --iodepth=64  --numjobs=16

which gives around 2326K IOPs.

Note that for testing I dropped depth to 64 above because the vhost/virt
layer supports only 1024 total commands per device. And the only tuning I
did was set LIO's emulate_pr to 0 to avoid LIO's PR lock in the main IO
path which becomes an issue at around 12 jobs/virtqueues.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c            | 177 ++++++++++++++++++++++++++++---
 drivers/vhost/vhost.h            |   4 +-
 include/uapi/linux/vhost.h       |  22 ++++
 include/uapi/linux/vhost_types.h |  15 +++
 4 files changed, 204 insertions(+), 14 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1fa5e9a49092..e40699e83c6d 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -271,7 +271,11 @@ EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
 
 void vhost_dev_flush(struct vhost_dev *dev)
 {
-	vhost_work_flush_on(dev->worker);
+	struct vhost_worker *worker;
+	unsigned long i;
+
+	xa_for_each(&dev->worker_xa, i, worker)
+		vhost_work_flush_on(worker);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
@@ -489,7 +493,6 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->umem = NULL;
 	dev->iotlb = NULL;
 	dev->mm = NULL;
-	dev->worker = NULL;
 	dev->iov_limit = iov_limit;
 	dev->weight = weight;
 	dev->byte_weight = byte_weight;
@@ -499,7 +502,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
 	spin_lock_init(&dev->iotlb_lock);
-
+	xa_init_flags(&dev->worker_xa, XA_FLAGS_ALLOC);
 
 	for (i = 0; i < dev->nvqs; ++i) {
 		vq = dev->vqs[i];
@@ -562,32 +565,67 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
-static void vhost_worker_free(struct vhost_dev *dev)
+static void vhost_worker_put(struct vhost_dev *dev, struct vhost_worker *worker)
 {
-	struct vhost_worker *worker = dev->worker;
-
 	if (!worker)
 		return;
 
-	dev->worker = NULL;
+	if (!refcount_dec_and_test(&worker->refcount))
+		return;
+
 	WARN_ON(!llist_empty(&worker->work_list));
 	vhost_task_stop(worker->vtsk);
 	kfree(worker);
 }
 
+static void vhost_vq_detach_worker(struct vhost_virtqueue *vq)
+{
+	if (vq->worker)
+		vhost_worker_put(vq->dev, vq->worker);
+	vq->worker = NULL;
+}
+
+static void vhost_workers_free(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	unsigned long i;
+
+	if (!dev->use_worker)
+		return;
+
+	for (i = 0; i < dev->nvqs; i++)
+		vhost_vq_detach_worker(dev->vqs[i]);
+	/*
+	 * Drop the refcount taken during allocation, and handle the default
+	 * worker and the cases where userspace might have crashed or was lazy
+	 * and did a VHOST_NEW_WORKER but not a VHOST_FREE_WORKER.
+	 */
+	xa_for_each(&dev->worker_xa, i, worker) {
+		xa_erase(&dev->worker_xa, worker->id);
+		vhost_worker_put(dev, worker);
+	}
+	xa_destroy(&dev->worker_xa);
+}
+
 static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
 	struct vhost_task *vtsk;
 	char name[TASK_COMM_LEN];
+	int ret;
+	u32 id;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
 		return NULL;
 
-	dev->worker = worker;
 	worker->kcov_handle = kcov_common_handle();
 	init_llist_head(&worker->work_list);
+	/*
+	 * We increase the refcount for the initial creation and then
+	 * later each time it's attached to a virtqueue.
+	 */
+	refcount_set(&worker->refcount, 1);
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
 	vtsk = vhost_task_create(vhost_worker, worker, name);
@@ -596,14 +634,104 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 
 	worker->vtsk = vtsk;
 	vhost_task_start(vtsk);
+
+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0)
+		goto stop_worker;
+	worker->id = id;
+
 	return worker;
 
+stop_worker:
+	vhost_task_stop(vtsk);
 free_worker:
 	kfree(worker);
-	dev->worker = NULL;
 	return NULL;
 }
 
+/* Caller must have device and virtqueue mutex */
+static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
+				     struct vhost_worker *worker)
+{
+	refcount_inc(&worker->refcount);
+	vhost_vq_detach_worker(vq);
+	vq->worker = worker;
+}
+
+/* Caller must have device and virtqueue mutex */
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
+	/*
+	 * We don't support setting a worker on an active vq to make flushing
+	 * and removal simple.
+	 */
+	if (vhost_vq_get_backend(vq))
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
+	if (!dev->use_worker)
+		return -EINVAL;
+
+	worker = vhost_worker_create(dev);
+	if (!worker)
+		return -ENOMEM;
+
+	info->worker_id = worker->id;
+	return 0;
+}
+
+/* Caller must have device mutex */
+static int vhost_free_worker(struct vhost_dev *dev,
+			     struct vhost_worker_state *info)
+{
+	unsigned long index = info->worker_id;
+	struct vhost_worker *worker;
+
+	if (!dev->use_worker)
+		return -EINVAL;
+
+	worker = xa_find(&dev->worker_xa, &index, UINT_MAX, XA_PRESENT);
+	if (!worker || worker->id != info->worker_id)
+		return -ENODEV;
+
+	/*
+	 * We can free the worker if it's not attached to any virtqueues.
+	 */
+	if (refcount_read(&worker->refcount) != 1)
+		return -EBUSY;
+
+	xa_erase(&dev->worker_xa, worker->id);
+	/*
+	 * Make sure if there was a flush that saw the worker in the XA that
+	 * it has completed.
+	 */
+	vhost_work_flush_on(worker);
+
+	vhost_worker_put(dev, worker);
+	return 0;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
@@ -624,7 +752,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 			goto err_worker;
 
 		for (i = 0; i < dev->nvqs; i++)
-			dev->vqs[i]->worker = worker;
+			__vhost_vq_attach_worker(dev->vqs[i], worker);
 	}
 
 	err = vhost_dev_alloc_iovecs(dev);
@@ -633,7 +761,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	return 0;
 err_iovecs:
-	vhost_worker_free(dev);
+	vhost_workers_free(dev);
 err_worker:
 	vhost_detach_mm(dev);
 err_mm:
@@ -726,7 +854,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	vhost_worker_free(dev);
+	vhost_workers_free(dev);
 	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
@@ -1616,6 +1744,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 	struct eventfd_ctx *ctx = NULL;
 	u32 __user *idxp = argp;
 	struct vhost_virtqueue *vq;
+	struct vhost_vring_worker w;
 	struct vhost_vring_state s;
 	struct vhost_vring_file f;
 	u32 idx;
@@ -1723,7 +1852,16 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 		if (copy_to_user(argp, &s, sizeof(s)))
 			r = -EFAULT;
 		break;
-	default:
+	case VHOST_ATTACH_VRING_WORKER:
+		if (copy_from_user(&w, argp, sizeof(w))) {
+			r = -EFAULT;
+			break;
+		}
+		r = vhost_vq_attach_worker(vq, &w);
+		if (!r && copy_to_user(argp, &w, sizeof(w)))
+			r = -EFAULT;
+		break;
+default:
 		r = -ENOIOCTLCMD;
 	}
 
@@ -1776,6 +1914,7 @@ EXPORT_SYMBOL_GPL(vhost_init_device_iotlb);
 /* Caller must have device mutex */
 long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 {
+	struct vhost_worker_state w;
 	struct eventfd_ctx *ctx;
 	u64 p;
 	long r;
@@ -1836,6 +1975,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		if (ctx)
 			eventfd_ctx_put(ctx);
 		break;
+	case VHOST_NEW_WORKER:
+		r = vhost_new_worker(d, &w);
+		if (!r && copy_to_user(argp, &w, sizeof(w)))
+			r = -EFAULT;
+		break;
+	case VHOST_FREE_WORKER:
+		if (copy_from_user(&w, argp, sizeof(w))) {
+			r = -EFAULT;
+			break;
+		}
+		r = vhost_free_worker(d, &w);
+		break;
 	default:
 		r = -ENOIOCTLCMD;
 		break;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 395707c680e5..a67ae8293c38 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -30,6 +30,8 @@ struct vhost_worker {
 	struct vhost_task	*vtsk;
 	struct llist_head	work_list;
 	u64			kcov_handle;
+	refcount_t		refcount;
+	u32			id;
 };
 
 /* Poll a file (eventfd or socket) */
@@ -156,7 +158,6 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
@@ -166,6 +167,7 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
+	struct xarray worker_xa;
 	bool use_worker;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 92e1b700b51c..7329e7f349dd 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -45,6 +45,23 @@
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
+ */
+#define VHOST_NEW_WORKER _IOW(VHOST_VIRTIO, 0x8, struct vhost_worker_state)
+/* Free a worker created with VHOST_NEW_WORKER if it's not attached to any
+ * virtqueue. If userspace is not able to call this for workers its created,
+ * the kernel will free all the device's workers when the device is closed and
+ * the last reference to the device has been released.
+ */
+#define VHOST_FREE_WORKER _IOR(VHOST_VIRTIO, 0x9, struct vhost_worker_state)
 
 /* Ring setup. */
 /* Set number of descriptors in ring. This parameter can not
@@ -70,6 +87,11 @@
 #define VHOST_VRING_BIG_ENDIAN 1
 #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
 #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
+/* Attach a vhost_worker created with VHOST_NEW_WORKER to one of the device's
+ * virtqueues. This must be done before the virtqueue is active.
+ */
+#define VHOST_ATTACH_VRING_WORKER _IOR(VHOST_VIRTIO, 0x15,		\
+				       struct vhost_vring_worker)
 
 /* The following ioctls use eventfd file descriptors to signal and poll
  * for events. */
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index c5690a8992d8..ad0fe2e721be 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -47,6 +47,21 @@ struct vhost_vring_addr {
 	__u64 log_guest_addr;
 };
 
+struct vhost_worker_state {
+	/*
+	 * For VHOST_NEW_WORKER the kernel will return the new vhost_worker id.
+	 * For VHOST_FREE_WORKER this must be set to the id of the vhost_worker
+	 * to free.
+	 */
+	int worker_id;
+};
+
+struct vhost_vring_worker {
+	unsigned int index;
+	/* The id of the vhost_worker returned from VHOST_NEW_WORKER */
+	int worker_id;
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
