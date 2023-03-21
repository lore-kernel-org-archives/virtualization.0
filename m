Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7ABC77B6C
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 02:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B035E4182B;
	Tue, 21 Mar 2023 02:06:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B035E4182B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=qc6Ze/en
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ExbNgBDUmuow; Tue, 21 Mar 2023 02:06:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A662B41823;
	Tue, 21 Mar 2023 02:06:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A662B41823
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3F98C008B;
	Tue, 21 Mar 2023 02:06:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36C4BC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CAFE81EAF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CAFE81EAF
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=qc6Ze/en
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R5Ibj5FwvnEH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B98081EBA
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B98081EBA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:36 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32KM4NRS014691; Tue, 21 Mar 2023 02:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=/mEf86uLL/KEFQJyN9JttHSrW4cGrsihIK7v9mbKOsA=;
 b=qc6Ze/en87tIgq7jv7OxS+L/U4JsZahLPGecdJE9SBXFxDle9uKgragvLynDHRSt8j4/
 Htd03G6Y+rIsgMoe+jxPPRlNfjFRgSTdYpME2C8v02u1W46lAwpJ8Kln/71sWvo5Rzz4
 oTpW0KXK7DtH3l/gpCcrSSNpLELxdlKsvvMDJ/iNP31lAwf8wrKLQJdv779fTkGR/CKB
 B8Vrj4x5mTTp+RwPvmos1O5eI9gSbhXzXSpCzB3jJV109YVyPoNzkPGSL+Jz/Va8FISj
 WG218V2iSH+24VMjxxawjbjIW9b4Ca/6S6szeOEEiIAV/tN5QSfSGif0v7Scj4aYrVNY cg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wt4yrn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 02:06:34 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32KNGH2k010444; Tue, 21 Mar 2023 02:06:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3peqjn4c40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 02:06:33 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32L26T9W007440;
 Tue, 21 Mar 2023 02:06:33 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-165-250.vpn.oracle.com
 [10.154.165.250])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3peqjn4c0v-4; Tue, 21 Mar 2023 02:06:32 +0000
From: Mike Christie <michael.christie@oracle.com>
To: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
 stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v2 3/7] vhost-scsi: Delay releasing our refcount on the tpg
Date: Mon, 20 Mar 2023 21:06:20 -0500
Message-Id: <20230321020624.13323-4-michael.christie@oracle.com>
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
X-Proofpoint-GUID: XcYzGs1b0u3yP989LtLsIX9uu8v-blXV
X-Proofpoint-ORIG-GUID: XcYzGs1b0u3yP989LtLsIX9uu8v-blXV
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

We currently hold the vhost_scsi_mutex the entire time we are running
vhost_scsi_clear_endpoint. One of the reasons for this is that it prevents
userspace from being able to free the se_tpg from under us after we have
called target_undepend_item. However, it forces management operations for
for other devices to have to wait on a flakey device's:

vhost_scsi_clear_endpoint -> vhost_scsi_flush()

call which can which can take a long time.

This moves the target_undepend_item call and the tpg unsetup code to after
we have stopped new IO from starting up and after we have waited on
running IO. We can then release our refcount on the tpg and session
knowing our device is no longer accessing them. We can then drop the
vhost_scsi_mutex use during thee flush call in later patches in this set,
when we have removed other reasons for holding it.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 61 +++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 32d0be968103..502d6803df0b 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1691,11 +1691,10 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 		if (!tpg)
 			continue;
 
-		mutex_lock(&tpg->tv_tpg_mutex);
 		tv_tport = tpg->tport;
 		if (!tv_tport) {
 			ret = -ENODEV;
-			goto err_tpg;
+			goto err_dev;
 		}
 
 		if (strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
@@ -1704,35 +1703,51 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 				tv_tport->tport_name, tpg->tport_tpgt,
 				t->vhost_wwpn, t->vhost_tpgt);
 			ret = -EINVAL;
-			goto err_tpg;
+			goto err_dev;
 		}
+		match = true;
+	}
+	if (!match)
+		goto free_vs_tpg;
+
+	/* Prevent new cmds from starting and accessing the tpgs/sessions */
+	for (i = 0; i < vs->dev.nvqs; i++) {
+		vq = &vs->vqs[i].vq;
+		mutex_lock(&vq->mutex);
+		vhost_vq_set_backend(vq, NULL);
+		mutex_unlock(&vq->mutex);
+	}
+	/* Make sure cmds are not running before tearing them down. */
+	vhost_scsi_flush(vs);
+
+	for (i = 0; i < vs->dev.nvqs; i++) {
+		vq = &vs->vqs[i].vq;
+		vhost_scsi_destroy_vq_cmds(vq);
+	}
+
+	/*
+	 * We can now release our hold on the tpg and sessions and userspace
+	 * can free them after this point.
+	 */
+	for (i = 0; i < VHOST_SCSI_MAX_TARGET; i++) {
+		target = i;
+		tpg = vs->vs_tpg[target];
+		if (!tpg)
+			continue;
+
+		mutex_lock(&tpg->tv_tpg_mutex);
+
 		tpg->tv_tpg_vhost_count--;
 		tpg->vhost_scsi = NULL;
 		vs->vs_tpg[target] = NULL;
-		match = true;
+
 		mutex_unlock(&tpg->tv_tpg_mutex);
-		/*
-		 * Release se_tpg->tpg_group.cg_item configfs dependency now
-		 * to allow vhost-scsi WWPN se_tpg->tpg_group shutdown to occur.
-		 */
+
 		se_tpg = &tpg->se_tpg;
 		target_undepend_item(&se_tpg->tpg_group.cg_item);
 	}
-	if (match) {
-		for (i = 0; i < vs->dev.nvqs; i++) {
-			vq = &vs->vqs[i].vq;
-			mutex_lock(&vq->mutex);
-			vhost_vq_set_backend(vq, NULL);
-			mutex_unlock(&vq->mutex);
-		}
-		/* Make sure cmds are not running before tearing them down. */
-		vhost_scsi_flush(vs);
 
-		for (i = 0; i < vs->dev.nvqs; i++) {
-			vq = &vs->vqs[i].vq;
-			vhost_scsi_destroy_vq_cmds(vq);
-		}
-	}
+free_vs_tpg:
 	/*
 	 * Act as synchronize_rcu to make sure access to
 	 * old vs->vs_tpg is finished.
@@ -1745,8 +1760,6 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 	mutex_unlock(&vhost_scsi_mutex);
 	return 0;
 
-err_tpg:
-	mutex_unlock(&tpg->tv_tpg_mutex);
 err_dev:
 	mutex_unlock(&vs->dev.mutex);
 	mutex_unlock(&vhost_scsi_mutex);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
