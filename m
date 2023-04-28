Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C8CC77B60
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 16:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A0CB842D4;
	Fri, 28 Apr 2023 16:31:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A0CB842D4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=1eSnQpBa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7YrDqf3b3Njs; Fri, 28 Apr 2023 16:31:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D4D36842BE;
	Fri, 28 Apr 2023 16:31:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4D36842BE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE9A9C0036;
	Fri, 28 Apr 2023 16:31:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6B04C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B318E842C4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B318E842C4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kG8sKNct5U75
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB275842D4
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB275842D4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:54 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33SF4cgJ031666; Fri, 28 Apr 2023 16:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=DaQk1MJPMVFgHSj5OrsrQZUnq4KoTllhB1n7uL6uw3g=;
 b=1eSnQpBawaFEHIfmLQatepsPFW8DDLWm6hAtnqKcGGuwZeBsfURZJXyFg8EAZ8HbpjD7
 LDyWy1/druHbvUWjfCPyyW9Cn4FdQFR+dUOGTAOdhev0WCrBUdLOQel7zerv1TDpFBXS
 nWXu81C067la/zEWMiHn5d3167v3/9y2M32bBrzD4ME8aDVCF0Bq2kLHaqDDtRjH8Z/x
 k6mMssQQCCLe12X80OipTAGc+GSTBkbCgzvszGYTVhTmfgw1cPw+FWWRxHnc+yWRGcSb
 489pzaQDwWMG603f/pDcf2v7+AkBxkvsgiePAjQUSlPAtQZDTciBqWJjw6PcjAiAhgHf JA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbxuf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:31:53 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 33SFuXtf020318; Fri, 28 Apr 2023 16:31:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3q461h8mht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:31:51 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SGVYPt023567;
 Fri, 28 Apr 2023 16:31:50 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-109-59.vpn.oracle.com
 [10.154.109.59])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3q461h8m7j-12; Fri, 28 Apr 2023 16:31:50 +0000
From: Mike Christie <michael.christie@oracle.com>
To: virtualization@lists.linux-foundation.org, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: [PATCH 12/14] vhost: replace single worker pointer with xarray
Date: Fri, 28 Apr 2023 11:31:29 -0500
Message-Id: <20230428163131.92777-12-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428163131.92777-1-michael.christie@oracle.com>
References: <20230428163131.92777-1-michael.christie@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=938
 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280133
X-Proofpoint-GUID: 1C9yIcF1ol8kRXX9R9pmMsfZZUSeY92d
X-Proofpoint-ORIG-GUID: 1C9yIcF1ol8kRXX9R9pmMsfZZUSeY92d
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

The next patch allows userspace to create multiple workers per device,
so this patch replaces the vhost_worker pointer with an xarray so we
can store mupltiple workers and look them up.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 48 +++++++++++++++++++++++++++++++++----------
 drivers/vhost/vhost.h |  3 ++-
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 930b703eb6b6..4b0b82292379 100644
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
@@ -562,30 +565,46 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
-static void vhost_worker_free(struct vhost_dev *dev)
+static void vhost_worker_destroy(struct vhost_dev *dev,
+				 struct vhost_worker *worker)
 {
-	struct vhost_worker *worker = dev->worker;
-
 	if (!worker)
 		return;
 
-	dev->worker = NULL;
 	WARN_ON(!llist_empty(&worker->work_list));
+	xa_erase(&dev->worker_xa, worker->id);
 	vhost_task_stop(worker->vtsk);
 	kfree(worker);
 }
 
+static void vhost_workers_free(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	unsigned long i;
+
+	if (!dev->use_worker)
+		return;
+	/*
+	 * Free the default worker we created and cleanup workers userspace
+	 * created but couldn't clean up (it forgot or crashed).
+	 */
+	xa_for_each(&dev->worker_xa, i, worker)
+		vhost_worker_destroy(dev, worker);
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
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
@@ -596,11 +615,18 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 
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
 
@@ -654,7 +680,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	return 0;
 err_iovecs:
-	vhost_worker_free(dev);
+	vhost_workers_free(dev);
 err_worker:
 	vhost_detach_mm(dev);
 err_mm:
@@ -747,7 +773,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	vhost_worker_free(dev);
+	vhost_workers_free(dev);
 	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 395707c680e5..2eea20d54134 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -30,6 +30,7 @@ struct vhost_worker {
 	struct vhost_task	*vtsk;
 	struct llist_head	work_list;
 	u64			kcov_handle;
+	u32			id;
 };
 
 /* Poll a file (eventfd or socket) */
@@ -156,7 +157,6 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
@@ -166,6 +166,7 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
+	struct xarray worker_xa;
 	bool use_worker;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
