Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2115F301
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790346; cv=none; b=dv13wSe4a0eLhs0EuRknmPzMvPYsK6MoVfK5VTOPguoMDpS/GLkTE44s4kRkQ1StarAb6rPZ/0cIZbzWkOucQaxQvK2k/xVkYAWLNmk4MaI/mxH38NoyzPDY3/l54m100EOf3/gSSAuB6+FchbzWi7RN+bdjAwA8LvxOg0gLPGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790346; c=relaxed/simple;
	bh=9pwK6KrwmEJnnyWxiHLvu2P+MPBI7Vx0jWETI5yoDzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QpjgwfYeq0GlPvKqMirSwz7BGS/IpOfzYMuZ/oKiTwimSJZIL8GVdJAqkIFK8Wd/UKXHXW4y1L+tnyPS8N8itPI8VsXmDAlwJXMJl8qJHIIB9+UFDOziOd8kc2VtRjx1iHQfVJUoh8yz7TDEFvwbbLpc617opQzJpOGsAJp6nTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KvGfkySM; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KvGfkySM"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D868980DF3
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.799
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dBASVeRgn8xo for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Jul 2024 13:19:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F00A480DE8
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F00A480DE8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=KvGfkySM
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F00A480DE8
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:19:03 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIMWI025593;
	Fri, 12 Jul 2024 13:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=nJg4BRPsRkeaHY4ExSNlZDmpNt3E+wvWdny45AqoH2w=; b=
	KvGfkySMAtB5Kx9FE7vt503C3TF2pLSViEKCy0alJLqrEyCqmFDo/RTFQ9B0YY4y
	YLSRQ0sADAOgAQDqgG/eQlEhvwDNpdmuHmTZYT+kGVsWzYkx+mvoko1nJACesozB
	M/5N0DezIMTw0Nf6+23gjp0ObMZie3oYnjKS/KS9CvqPmZsMvtkHc03ugpwL6B2M
	tXmgwRW2rJloNrGssXlAy1g3DebBP1uR+pxrTE8s2vouwh6ZGqiQ7KCaVgCXIAmI
	ZRANV/tJ8kUrbR29QeUbUd4Xe6KjnkIFri/3Akta0axk5W1OnRTgJraRNlglPrLm
	mIT2rTSv9RX2uZHc4mrzZg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknuv05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CBMAAP022638;
	Fri, 12 Jul 2024 13:18:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3snrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:57 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CDIsDH029886;
	Fri, 12 Jul 2024 13:18:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 409vv3snp2-6;
	Fri, 12 Jul 2024 13:18:57 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 5/7] vhost-vdpa: VHOST_IOTLB_REMAP
Date: Fri, 12 Jul 2024 06:18:51 -0700
Message-Id: <1720790333-456232-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120089
X-Proofpoint-GUID: oioFsCUpcQ48RdZWJWfGTBMl75UlGpS6
X-Proofpoint-ORIG-GUID: oioFsCUpcQ48RdZWJWfGTBMl75UlGpS6
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

When device ownership is passed to a new process via VHOST_NEW_OWNER,
some devices need to know the new userland addresses of the dma mappings.
Define the new iotlb message type VHOST_IOTLB_REMAP to update the uaddr
of a mapping.  The new uaddr must address the same memory object as
originally mapped.

The user must suspend the device before the old address is invalidated,
and cannot resume it until after VHOST_IOTLB_REMAP is called, but this
requirement is not enforced by the API.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c             | 58 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost_types.h | 11 +++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 4396fe1a90c4..51f71c45c4a9 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1257,6 +1257,61 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 }
 
+static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
+					  struct vhost_iotlb *iotlb,
+					  struct vhost_iotlb_msg *msg)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+	u32 asid = iotlb_to_asid(iotlb);
+	u64 start = msg->iova;
+	u64 last = start + msg->size - 1;
+	struct vhost_iotlb_map *map;
+	int r = 0;
+
+	if (msg->perm || !msg->size)
+		return -EINVAL;
+
+	map = vhost_iotlb_itree_first(iotlb, start, last);
+	if (!map)
+		return -ENOENT;
+
+	if (map->start != start || map->last != last)
+		return -EINVAL;
+
+	/*
+	 * The current implementation does not support the platform iommu
+	 * with use_va.  And if !use_va, remap is not necessary.
+	 */
+	if (!ops->set_map && !ops->dma_map)
+		return -EINVAL;
+
+	/*
+	 * The current implementation supports set_map but not dma_map.
+	 */
+	if (!ops->set_map)
+		return -EINVAL;
+
+	/*
+	 * Do not verify that the new size@uaddr points to the same physical
+	 * pages as the old size@uaddr, because that would take time O(npages),
+	 * and would increase guest down time during live update.  If the app
+	 * is buggy and they differ, then the app may corrupt its own memory,
+	 * but no one else's.
+	 */
+
+	/*
+	 * Batch will finish later in BATCH_END by calling set_map for the new
+	 * addresses collected here.  Non-batch must do it now.
+	 */
+	if (!v->in_batch)
+		r = ops->set_map(vdpa, asid, iotlb);
+	if (!r)
+		map->addr = msg->uaddr;
+
+	return r;
+}
+
 static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 					   struct vhost_iotlb *iotlb,
 					   struct vhost_iotlb_msg *msg)
@@ -1336,6 +1391,9 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
 			ops->set_map(vdpa, asid, iotlb);
 		v->in_batch = false;
 		break;
+	case VHOST_IOTLB_REMAP:
+		r = vhost_vdpa_process_iotlb_remap(v, iotlb, msg);
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 9177843951e9..35908315ff55 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -79,7 +79,7 @@ struct vhost_iotlb_msg {
 /*
  * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
  * multiple mappings in one go: beginning with
- * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
+ * VHOST_IOTLB_BATCH_BEGIN, followed by any number of VHOST_IOTLB_REMAP or
  * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END.
  * When one of these two values is used as the message type, the rest
  * of the fields in the message are ignored. There's no guarantee that
@@ -87,6 +87,15 @@ struct vhost_iotlb_msg {
  */
 #define VHOST_IOTLB_BATCH_BEGIN    5
 #define VHOST_IOTLB_BATCH_END      6
+
+/*
+ * VHOST_IOTLB_REMAP registers a new uaddr for the existing mapping at iova.
+ * The new uaddr must address the same memory object as originally mapped.
+ * Failure to do so will result in user memory corruption and/or device
+ * misbehavior.  iova and size must match the arguments used to create the
+ * an existing mapping.  Protection is not changed, and perm must be 0.
+ */
+#define VHOST_IOTLB_REMAP          7
 	__u8 type;
 };
 
-- 
2.39.3

