Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B653DC6FD1C
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 02:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F27C56109D;
	Tue, 21 Mar 2023 02:06:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F27C56109D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=zwAtqapJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u9WukVbYFb9y; Tue, 21 Mar 2023 02:06:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 795F36108A;
	Tue, 21 Mar 2023 02:06:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 795F36108A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49A17C0071;
	Tue, 21 Mar 2023 02:06:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3144C0071
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C686881EB0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C686881EB0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=zwAtqapJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aHr_X3JhAsT8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A824381EAF
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A824381EAF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:31 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32KM4RGV014750; Tue, 21 Mar 2023 02:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=mPrQHdQOaZkxh1Qbo5znE9BUO57yBo10h6YULnR6O6U=;
 b=zwAtqapJBwB7C6k+3d0iHV2zXLFR5pgt+1R5FGGQGIIGpq68fz5FvZEsOeTCM7RYVdHu
 2ivinXjo7PiG1FyN1iqzqp2NHi1sWhvmsdPOv0CUf+eBJ5Dv/PhrilO4uwA4WnO1JWWw
 LLttVyrnu7nucludSh9S2o/ZR3+OFQVS72cqw0KwuOHdlVAsCDD2vgEbZt9TyNrUeDa/
 3HZgT4cNuirlazu5MOpZm5Wp3SCpWE3rOqBFV3E/ic/jlJmZytvPn0ElnTXvNWPBJxv6
 s6VQUX/tQDbe1J/zeiwrCvDOxZjZQKYtsoJ5FMSO+CK665UnN+frUgkejcvfX8hEdVwT 8Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wt4yrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 02:06:30 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32KNRDJI010339; Tue, 21 Mar 2023 02:06:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3peqjn4c2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 02:06:29 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32L26T9S007440;
 Tue, 21 Mar 2023 02:06:29 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-165-250.vpn.oracle.com
 [10.154.165.250])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3peqjn4c0v-2; Tue, 21 Mar 2023 02:06:29 +0000
From: Mike Christie <michael.christie@oracle.com>
To: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
 stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/7] vhost-scsi: Fix vhost_scsi struct use after free
Date: Mon, 20 Mar 2023 21:06:18 -0500
Message-Id: <20230321020624.13323-2-michael.christie@oracle.com>
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
X-Proofpoint-GUID: v6_BLPy3Y6golBYeEqYuoEtDWuHmh-zT
X-Proofpoint-ORIG-GUID: v6_BLPy3Y6golBYeEqYuoEtDWuHmh-zT
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

If vhost_scsi_setup_vq_cmds fails we leave the tpg->vhost_scsi pointer
set. If the device is freed and then the user unmaps the LUN, the call to
vhost_scsi_port_unlink -> vhost_scsi_hotunplug will see the that
tpg->vhost_scsi is still set and try to use it.

This has us clear the vhost_scsi pointer in the failure path. It also
has us take tv_tpg_mutex in this failure path, because tv_tpg_vhost_count
is accessed under this mutex in vhost_scsi_drop_nexus and in the future
we will want to serialize access to tpg->vhost_scsi with that mutex
instead of the vhost_scsi_mutex.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index b244e7c0f514..5875241e1654 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1658,7 +1658,10 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 	for (i = 0; i < VHOST_SCSI_MAX_TARGET; i++) {
 		tpg = vs_tpg[i];
 		if (tpg) {
+			mutex_lock(&tpg->tv_tpg_mutex);
+			tpg->vhost_scsi = NULL;
 			tpg->tv_tpg_vhost_count--;
+			mutex_unlock(&tpg->tv_tpg_mutex);
 			target_undepend_item(&tpg->se_tpg.tpg_group.cg_item);
 		}
 	}
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
