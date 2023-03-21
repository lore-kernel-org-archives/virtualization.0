Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15D0C76195
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 02:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97AB5610A5;
	Tue, 21 Mar 2023 02:06:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 97AB5610A5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=x4uXVeon
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nRxBHbXkOQPI; Tue, 21 Mar 2023 02:06:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3E6EA6109E;
	Tue, 21 Mar 2023 02:06:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E6EA6109E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 119ECC0091;
	Tue, 21 Mar 2023 02:06:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B79DBC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86C4440AC9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 86C4440AC9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=x4uXVeon
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8et57HhD-dp3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D98B240AB9
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D98B240AB9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:36 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32KM4Rbv014753; Tue, 21 Mar 2023 02:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=kPNNQe0Jkx7j+gAbUS6oUeXbB7bLjs0FNjYR0kSxCp4=;
 b=x4uXVeonER6Cy7wEDDiwO+PUonbFi0mlieYrPjmXXle9k0KQa5jXgl9/nkkh9/1Y09HB
 4iMtJNDG8o6Dc3Gy7EDGmi/B9coOsQ6w2IKaHpK2Fq8fpiRfwcohpvpkELhnRm28Trex
 y9E99Lan1RNs3yauKLNmdAMCUhOdSuZVrIbQrEIsSjYTL1wBj19xvvbU2NcJQAt10nS5
 UfMpwp0LZOE2CGl0TJ//j15MedpKvj2jK1v2nWT0mE4S/ErHnnYVwCZWnYQJ6yQm7zkq
 gn/1G+UnpQlKlq2fgIXU/XMHmes1WcmreCBAUd2wWSVlt0OAr7dbC3kj1T44AxjCYxu1 tQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wt4yrp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 02:06:35 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32KNPAGZ010423; Tue, 21 Mar 2023 02:06:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3peqjn4c4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 02:06:35 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32L26T9Y007440;
 Tue, 21 Mar 2023 02:06:34 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-165-250.vpn.oracle.com
 [10.154.165.250])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3peqjn4c0v-5; Tue, 21 Mar 2023 02:06:34 +0000
From: Mike Christie <michael.christie@oracle.com>
To: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
 stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v2 4/7] vhost-scsi: Drop device mutex use in vhost_scsi_do_plug
Date: Mon, 20 Mar 2023 21:06:21 -0500
Message-Id: <20230321020624.13323-5-michael.christie@oracle.com>
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
X-Proofpoint-GUID: 6sdUmtzut9zu79SSTGG2flVR9jkN3BuT
X-Proofpoint-ORIG-GUID: 6sdUmtzut9zu79SSTGG2flVR9jkN3BuT
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

We don't need the device mutex in vhost_scsi_do_plug because:
1. we have the vhost_scsi_mutex so the tpg->vhost_scsi pointer will not
change on us and the vhost_scsi can't be freed from under us if it was
set.
2. vhost_scsi_clear_endpoint will stop the virtqueues and flush them while
holding the vhost_scsi_mutex so we know once vhost_scsi_clear_endpoint
has completed that vhost_scsi_do_plug can't send new events and any
queued ones have completed.

So this patch drops the device mutex use in vhost_scsi_do_plug.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 502d6803df0b..c945136ecf18 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2003,8 +2003,6 @@ vhost_scsi_do_plug(struct vhost_scsi_tpg *tpg,
 	if (!vs)
 		return;
 
-	mutex_lock(&vs->dev.mutex);
-
 	if (plug)
 		reason = VIRTIO_SCSI_EVT_RESET_RESCAN;
 	else
@@ -2016,7 +2014,6 @@ vhost_scsi_do_plug(struct vhost_scsi_tpg *tpg,
 		vhost_scsi_send_evt(vs, tpg, lun,
 				   VIRTIO_SCSI_T_TRANSPORT_RESET, reason);
 	mutex_unlock(&vq->mutex);
-	mutex_unlock(&vs->dev.mutex);
 }
 
 static void vhost_scsi_hotplug(struct vhost_scsi_tpg *tpg, struct se_lun *lun)
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
