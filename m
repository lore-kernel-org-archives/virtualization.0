Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029D3C4332F
	for <virtualization@archiver.kernel.org>; Sat, 15 Oct 2022 01:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A523812CF;
	Sat, 15 Oct 2022 01:33:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A523812CF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=2BQNpXYn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l8t71uIJzfjh; Sat, 15 Oct 2022 01:33:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BE27F812EC;
	Sat, 15 Oct 2022 01:33:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE27F812EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E002C0033;
	Sat, 15 Oct 2022 01:33:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C380AC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Oct 2022 01:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9864860A98
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Oct 2022 01:33:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9864860A98
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=2BQNpXYn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id diu-j-EcJYoF
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Oct 2022 01:33:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58C22607F0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58C22607F0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Oct 2022 01:33:50 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29F1WggE026634;
 Sat, 15 Oct 2022 01:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=Vceponq7eAFUqTu6CGWdqDZyJ21Mh5Eod4o60p5T6SU=;
 b=2BQNpXYndeJ0JkprQuWZHzEEJbyZYTL/jKtU9cLLag6ZQhP6TZqSJuVVGQ0DXFYTQNAj
 +doENKXWAqOVgrdiiN4Btinl3jnfcifivqOnwh4/Hr03AjuORxh69kl0XSiIpQ8/4gL4
 gqjVWulhCwSOCdGygepFDvYPl7FKiQzPyEjkSJCt3klcfUYZuBWMmkiUcysRgHvJ9WQb
 +GAKzLrQZY/3+3X6THDgcvYAykfIwBFDSleKLidZsF5hNqbQePJqZypB1s+hQBOAg6DI
 IIgRodN/99faYNircg39lN0Qzd3LlbgJZB4Mw0WP4BsXPmRxXHGEdOU0teLnhAO9WaOG 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7k9d001c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Oct 2022 01:33:49 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29F1X477008564; Sat, 15 Oct 2022 01:33:48 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3k7ka180am-2; Sat, 15 Oct 2022 01:33:48 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com
Subject: [PATCH 1/4] vdpa: save vdpa_dev_set_config in struct vdpa_device
Date: Fri, 14 Oct 2022 17:28:07 -0700
Message-Id: <1665793690-28120-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
References: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_13,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210150007
X-Proofpoint-GUID: poIVo5XTPAmVzwdroxI1W7Zi2p-wHL1F
X-Proofpoint-ORIG-GUID: poIVo5XTPAmVzwdroxI1W7Zi2p-wHL1F
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
