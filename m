Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE910C77B61
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 16:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D1D26FEE0;
	Fri, 28 Apr 2023 16:31:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D1D26FEE0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=RQDDc7zI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bW_etomqynCb; Fri, 28 Apr 2023 16:31:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3744D60B65;
	Fri, 28 Apr 2023 16:31:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3744D60B65
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 726F1C008C;
	Fri, 28 Apr 2023 16:31:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DEBFC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C3D142A4F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C3D142A4F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=RQDDc7zI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AMptlt3vw9PV
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5340740533
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5340740533
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:39 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33SF3pJv013966; Fri, 28 Apr 2023 16:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=wAJmMoBR6RSKGKGuSvFLocKIqf2jxykw6Ym8hC8i/fo=;
 b=RQDDc7zIks0NuLp3bn9alTeYtMfouzhIQUffCGUPxCVXXqfAO0ERAQYeF4xjjsmdVWhv
 TMbUq9sEZzbHN792u7NOBcD7bkVmof/VTYVVpkhFLQy+Gn6gMeYLCBd5qOiNHMFdUcPc
 wXygQrEjaPhynLqAwYDgAbTfpXdGhUYu89pUrGiD4iKFgKlMQ07oWPPFbGc0WBxibT9o
 SQ3efUOLfKMl7rTcid774dfbWxzjtshJzn4WhWaj2Qd7FwRUzgH6CHnkWPIaIvyeidrg
 ZHX9noXTuNIFmcQWcijPr9XZt2DGC0nebNsTE8bo+kBs1xR8zeafcXsROM9458HjYy8o +A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460dekky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:31:38 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 33SFlJXZ020314; Fri, 28 Apr 2023 16:31:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3q461h8mac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:31:37 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SGVYPb023567;
 Fri, 28 Apr 2023 16:31:37 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-109-59.vpn.oracle.com
 [10.154.109.59])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3q461h8m7j-3; Fri, 28 Apr 2023 16:31:37 +0000
From: Mike Christie <michael.christie@oracle.com>
To: virtualization@lists.linux-foundation.org, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: [PATCH 03/14] vhost: take worker or vq instead of dev for queueing
Date: Fri, 28 Apr 2023 11:31:20 -0500
Message-Id: <20230428163131.92777-3-michael.christie@oracle.com>
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
X-Proofpoint-GUID: QKx5KMA58oLEyfXcbh-uBATzFcjoTfl-
X-Proofpoint-ORIG-GUID: QKx5KMA58oLEyfXcbh-uBATzFcjoTfl-
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

This patch has the core work queueing function take a worker for when we
support multiple workers. It also adds a helper that takes a vq during
queueing so modules can control which vq/worker to queue work on.

This temp leaves vhost_work_queue. It will be removed when the drivers
are converted in the next patches.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 44 +++++++++++++++++++++++++++----------------
 drivers/vhost/vhost.h |  1 +
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index aefb52952e1d..faf1dcf0af30 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -231,6 +231,34 @@ void vhost_poll_stop(struct vhost_poll *poll)
 }
 EXPORT_SYMBOL_GPL(vhost_poll_stop);
 
+static void vhost_work_queue_on(struct vhost_worker *worker,
+				struct vhost_work *work)
+{
+	if (!worker)
+		return;
+
+	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
+		/* We can only add the work to the list after we're
+		 * sure it was not in the list.
+		 * test_and_set_bit() implies a memory barrier.
+		 */
+		llist_add(&work->node, &worker->work_list);
+		wake_up_process(worker->vtsk->task);
+	}
+}
+
+void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
+{
+	vhost_work_queue_on(dev->worker, work);
+}
+EXPORT_SYMBOL_GPL(vhost_work_queue);
+
+void vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
+{
+	vhost_work_queue_on(vq->worker, work);
+}
+EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
+
 void vhost_dev_flush(struct vhost_dev *dev)
 {
 	struct vhost_flush_struct flush;
@@ -245,22 +273,6 @@ void vhost_dev_flush(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
-void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
-{
-	if (!dev->worker)
-		return;
-
-	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
-		/* We can only add the work to the list after we're
-		 * sure it was not in the list.
-		 * test_and_set_bit() implies a memory barrier.
-		 */
-		llist_add(&work->node, &dev->worker->work_list);
-		wake_up_process(dev->worker->vtsk->task);
-	}
-}
-EXPORT_SYMBOL_GPL(vhost_work_queue);
-
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_vq_has_work(struct vhost_virtqueue *vq)
 {
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0dde119fb0ee..b64ee4ef387d 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -194,6 +194,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
 		      struct vhost_log *log, unsigned int *log_num);
 void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
+void vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work);
 bool vhost_vq_has_work(struct vhost_virtqueue *vq);
 bool vhost_vq_is_setup(struct vhost_virtqueue *vq);
 int vhost_vq_init_access(struct vhost_virtqueue *);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
