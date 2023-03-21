Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB315C77B62
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 02:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B5F181F0A;
	Tue, 21 Mar 2023 02:06:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B5F181F0A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=es1YJ3vs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cy0bbcoF9ztJ; Tue, 21 Mar 2023 02:06:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E54DE81F24;
	Tue, 21 Mar 2023 02:06:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E54DE81F24
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC3BAC007C;
	Tue, 21 Mar 2023 02:06:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D575C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BC18610A0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BC18610A0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=es1YJ3vs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MpU9VE8QWwBc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F58261093
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F58261093
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:42 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32KM4pHX026340; Tue, 21 Mar 2023 02:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=H9r2il6PViKSpQVaulibxENpxkzMyrAhWfxHwqY8eGY=;
 b=es1YJ3vsQyoGuNvLze/XpPDfgf1/9n0YiY8ET6tPdm0G6Xe+tW1owSTHQykgY5664oIU
 7B89dEivBZd0KEkx3vQb71ZoBCEMfGoMq05v6Ba0oq+8f+zobcMdCMorTNYMOGNvVD+O
 cGCw50BnEn0a8Vx1FowwibdiUGkWCL3C86bwj7dGTX+8eeSmx7t0O7r2w26K+m/qZJDC
 vWhPq3Q1EGeVBrTLbSr7f7XZ5mGndwybn6d510PPetcWQjpVD/7cw6p3kGc0Ug7xWwFh
 vSTJpfLwOF93bDI/h69Q59mbwWZL6jWCTUcjOxXfYDCRgSpzOSxhBBba+gFHBUdNcG8R 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd47tn0sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 02:06:41 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32KNExeQ010388; Tue, 21 Mar 2023 02:06:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3peqjn4c5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 02:06:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32L26T9e007440;
 Tue, 21 Mar 2023 02:06:39 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-165-250.vpn.oracle.com
 [10.154.165.250])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3peqjn4c0v-8; Tue, 21 Mar 2023 02:06:39 +0000
From: Mike Christie <michael.christie@oracle.com>
To: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
 stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v2 7/7] vhost-scsi: Reduce vhost_scsi_mutex use
Date: Mon, 20 Mar 2023 21:06:24 -0500
Message-Id: <20230321020624.13323-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321020624.13323-1-michael.christie@oracle.com>
References: <20230321020624.13323-1-michael.christie@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_18,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210017
X-Proofpoint-GUID: QtG3BjkRHARJkLjfhDuFDNXl5a2DGMFy
X-Proofpoint-ORIG-GUID: QtG3BjkRHARJkLjfhDuFDNXl5a2DGMFy
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

We on longer need to hold the vhost_scsi_mutex the entire time we
set/clear the endpoint. The tv_tpg_mutex handles tpg accesses not related
to the tpg list, the port link/unlink functions use the tv_tpg_mutex while
accessing the tpg->vhost_scsi pointer, vhost_scsi_do_plug will no longer
queue events after the virtqueue's backend has been cleared and flushed,
and we don't drop our refcount to the tpg until after we have stopped
cmds and wait for outstanding cmds to complete.

This moves the vhost_scsi_mutex use to it's documented use of being used
to access the tpg list. We then don't need to hold it while a flush is
being performed causing other device's vhost_scsi_set_endpoint
and vhost_scsi_make_tpg/vhost_scsi_drop_tpg calls to have to wait on a
flakey device.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index d4372a4aff49..3b0b556c57ef 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -229,7 +229,10 @@ struct vhost_scsi_ctx {
 	struct iov_iter out_iter;
 };
 
-/* Global spinlock to protect vhost_scsi TPG list for vhost IOCTL access */
+/*
+ * Global mutex to protect vhost_scsi TPG list for vhost IOCTLs and LIO
+ * configfs management operations.
+ */
 static DEFINE_MUTEX(vhost_scsi_mutex);
 static LIST_HEAD(vhost_scsi_list);
 
@@ -1526,7 +1529,7 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_virtqueue *vq, int max_cmds)
  * vhost_scsi_tpg with an active struct vhost_scsi_nexus
  *
  *  The lock nesting rule is:
- *    vhost_scsi_mutex -> vs->dev.mutex -> tpg->tv_tpg_mutex -> vq->mutex
+ *    vs->dev.mutex -> vhost_scsi_mutex -> tpg->tv_tpg_mutex -> vq->mutex
  */
 static int
 vhost_scsi_set_endpoint(struct vhost_scsi *vs,
@@ -1540,7 +1543,6 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 	int index, ret, i, len;
 	bool match = false;
 
-	mutex_lock(&vhost_scsi_mutex);
 	mutex_lock(&vs->dev.mutex);
 
 	/* Verify that ring has been setup correctly. */
@@ -1561,6 +1563,7 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 	if (vs->vs_tpg)
 		memcpy(vs_tpg, vs->vs_tpg, len);
 
+	mutex_lock(&vhost_scsi_mutex);
 	list_for_each_entry(tpg, &vhost_scsi_list, tv_tpg_list) {
 		mutex_lock(&tpg->tv_tpg_mutex);
 		if (!tpg->tpg_nexus) {
@@ -1576,6 +1579,7 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
 			if (vs->vs_tpg && vs->vs_tpg[tpg->tport_tpgt]) {
 				mutex_unlock(&tpg->tv_tpg_mutex);
+				mutex_unlock(&vhost_scsi_mutex);
 				ret = -EEXIST;
 				goto undepend;
 			}
@@ -1590,6 +1594,7 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 			if (ret) {
 				pr_warn("target_depend_item() failed: %d\n", ret);
 				mutex_unlock(&tpg->tv_tpg_mutex);
+				mutex_unlock(&vhost_scsi_mutex);
 				goto undepend;
 			}
 			tpg->tv_tpg_vhost_count++;
@@ -1599,6 +1604,7 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 		}
 		mutex_unlock(&tpg->tv_tpg_mutex);
 	}
+	mutex_unlock(&vhost_scsi_mutex);
 
 	if (match) {
 		memcpy(vs->vs_vhost_wwpn, t->vhost_wwpn,
@@ -1654,7 +1660,6 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 	kfree(vs_tpg);
 out:
 	mutex_unlock(&vs->dev.mutex);
-	mutex_unlock(&vhost_scsi_mutex);
 	return ret;
 }
 
@@ -1670,7 +1675,6 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 	int index, ret, i;
 	u8 target;
 
-	mutex_lock(&vhost_scsi_mutex);
 	mutex_lock(&vs->dev.mutex);
 	/* Verify that ring has been setup correctly. */
 	for (index = 0; index < vs->dev.nvqs; ++index) {
@@ -1757,12 +1761,10 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 	vs->vs_tpg = NULL;
 	WARN_ON(vs->vs_events_nr);
 	mutex_unlock(&vs->dev.mutex);
-	mutex_unlock(&vhost_scsi_mutex);
 	return 0;
 
 err_dev:
 	mutex_unlock(&vs->dev.mutex);
-	mutex_unlock(&vhost_scsi_mutex);
 	return ret;
 }
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
