Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F02C433FE
	for <virtualization@archiver.kernel.org>; Wed, 19 Oct 2022 00:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F04861159;
	Wed, 19 Oct 2022 00:56:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F04861159
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=eUxo+IE8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eupYHH5HnbR5; Wed, 19 Oct 2022 00:56:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A915661145;
	Wed, 19 Oct 2022 00:56:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A915661145
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8FB5C007F;
	Wed, 19 Oct 2022 00:56:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0954BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 00:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6B9F40B38
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 00:56:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6B9F40B38
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=eUxo+IE8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 38hE6RCIkNzB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 00:56:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 859F3404B0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 859F3404B0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 00:56:13 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29INi8vU005567;
 Wed, 19 Oct 2022 00:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=Vceponq7eAFUqTu6CGWdqDZyJ21Mh5Eod4o60p5T6SU=;
 b=eUxo+IE8H9VexyDBEWzD3uKw939uGXWeg+9S6CL3G/e5ypgEpMJP3CME+Ck6echR7xx9
 nB6yl++raR8m7qfYgxSoDt6uCI+QsDZSrumF4+KjueyeNYz3lQTQWTVRIhRme4j4r9l6
 0IWFYipweABlxyWyeKZbiQtShJ6glPxTsTUFdXU11/YXSFVS/IiPrU2skZ+9cOoIC+V3
 iz7bIts5NZAR5rYYTFwsSQL/xZnfR6RAAcDb+KLZLAFHtocvUJ7a7zM11hAG45EXOQNt
 89ONmtKHivP90JL1GIA3Bxj03PiU/droXcwV4n/5MooLVwc/58k6U0Joa/HLCzNa+sLg Yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mu00ka4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Oct 2022 00:56:12 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29ILnUhH016678; Wed, 19 Oct 2022 00:56:11 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3k8htgrhfm-2; Wed, 19 Oct 2022 00:56:11 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com
Subject: [PATCH v2 1/4] vdpa: save vdpa_dev_set_config in struct vdpa_device
Date: Tue, 18 Oct 2022 16:50:29 -0700
Message-Id: <1666137032-28192-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_10,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190003
X-Proofpoint-ORIG-GUID: lrfdVwc3WsuiaWtj3PwmOzSJ3D1pqDll
X-Proofpoint-GUID: lrfdVwc3WsuiaWtj3PwmOzSJ3D1pqDll
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

In order to allow live migration orchestration software to export the
initial set of vdpa attributes with which the device was created, it
will be useful if the vdpa tool can report the config on demand with
simple query. This will ease the orchestration software implementation
so that it doesn't have to keep track of vdpa config change, or have
to persist vdpa attributes across failure and recovery, in fear of
being killed due to accidental software error.

This commit attempts to make struct vdpa_device contain the struct
vdpa_dev_set_config, where all config attributes upon vdpa creation
are carried over. Which will be used in subsequent commits.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 include/linux/vdpa.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6d0f5e4..f1838f5 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -58,6 +58,16 @@ struct vdpa_vq_state {
 	};
 };
 
+struct vdpa_dev_set_config {
+	u64 device_features;
+	struct {
+		u8 mac[ETH_ALEN];
+		u16 mtu;
+		u16 max_vq_pairs;
+	} net;
+	u64 mask;
+};
+
 struct vdpa_mgmt_dev;
 
 /**
@@ -77,6 +87,8 @@ struct vdpa_vq_state {
  * @nvqs: maximum number of supported virtqueues
  * @mdev: management device pointer; caller must setup when registering device as part
  *	  of dev_add() mgmtdev ops callback before invoking _vdpa_register_device().
+ * @vdev_cfg: initial device config on vdpa creation; useful when instantiate with
+ *            the exact same config is needed.
  */
 struct vdpa_device {
 	struct device dev;
@@ -91,6 +103,7 @@ struct vdpa_device {
 	struct vdpa_mgmt_dev *mdev;
 	unsigned int ngroups;
 	unsigned int nas;
+	struct vdpa_dev_set_config vdev_cfg;
 };
 
 /**
@@ -103,16 +116,6 @@ struct vdpa_iova_range {
 	u64 last;
 };
 
-struct vdpa_dev_set_config {
-	u64 device_features;
-	struct {
-		u8 mac[ETH_ALEN];
-		u16 mtu;
-		u16 max_vq_pairs;
-	} net;
-	u64 mask;
-};
-
 /**
  * Corresponding file area for device memory mapping
  * @file: vma->vm_file for the mapping
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
