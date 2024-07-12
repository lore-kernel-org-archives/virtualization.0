Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449AB146D7A
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790346; cv=none; b=naYPhRzYyxZ0Cht0l+WIxI/B0YElmVx725QMfqGNCjaLoLDlE8KrpyISzgqU0sGC+hXL+HfTQsYQ1fZPuvlSdyJD9CT7qLUqda9VFbGnU7hfO4OpIZEp07R9c5rPxK4YBqT+SSE+u+DGforvKNKZCQie01GZXFmo59ISrNhGDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790346; c=relaxed/simple;
	bh=wCvW00aBdlJDx2fw9Sb9Aw6FcCB2yoyvOxsFnqJNtbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lUpNDLcaTjnkLvxhiokaC5cEPT+cfRpMcKo2elFiwBIkrHyL9syoLrB65/vVpgqNj2/EnHDhbTFJLL+NM8uG2DjcQopWS92Uuf2n5aHk7INPXdIzvwGOpKO5qw/FQ4UZqt5AY+AN136vNxpD0abXMxC9KunCsfKxHEPMfa+XtSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EZ4yXVxc; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EZ4yXVxc"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9940417E2
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.799
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q6JQKSwHvtfd for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Jul 2024 13:19:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CF2E7416ED
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF2E7416ED
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=EZ4yXVxc
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CF2E7416ED
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:19:03 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIK6e014260;
	Fri, 12 Jul 2024 13:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=kt586yo3yoOuzwKRIaw5fOFI+WJWJXsv6eQwBzv0uqo=; b=
	EZ4yXVxcbAlG+oOYkDzPlMfdFpEeXNcPvLXIkClf7Xjfj11Q1myltu6jjjTQH2zI
	fkLKmdteAu91vEzj4nTlA8igh7qc/qrJAQ3+of14iJzufjys61eYu45yL3uXt7j/
	VytOuciNTKweLW0TOa+xlzf0rCc0Eoo6pFENl2tu96CoIVquXmT6yJ4jc8o8tJZ6
	b80reSBjdBqcy71UYPI3pBXeB0jBEJhKzwp5V68ue6L2XhLbTpxokwDRTkX4hcE6
	CLqQ1jusGTXn2E0ZrrbuPxZdJBJ0pzV7c6hrGc4Urf2a29fiyTG88/77QxunF5Mv
	5/dnsK9VgcLvbFpxhr4/aw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybuyg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CCPDTo022608;
	Fri, 12 Jul 2024 13:18:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3sns3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:58 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CDIsDJ029886;
	Fri, 12 Jul 2024 13:18:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 409vv3snp2-7;
	Fri, 12 Jul 2024 13:18:57 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 6/7] vhost-vdpa: VHOST_BACKEND_F_IOTLB_REMAP
Date: Fri, 12 Jul 2024 06:18:52 -0700
Message-Id: <1720790333-456232-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: nVgFF2Y_xTo6E4M_Geqi21C8MZyyqQaI
X-Proofpoint-ORIG-GUID: nVgFF2Y_xTo6E4M_Geqi21C8MZyyqQaI
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Add the VHOST_BACKEND_F_IOTLB_REMAP backend capability, which indicates
that VHOST_IOTLB_REMAP is supported.

If VHOST_BACKEND_F_IOTLB_REMAP is advertised, then the user must call
VHOST_IOTLB_REMAP after ownership of a device is transferred to a new
process via VHOST_NEW_OWNER.  Disabling the feature during negotiation
does not negate this requirement.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c             | 8 +++++++-
 include/uapi/linux/vhost_types.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 51f71c45c4a9..1ec1f1382fd7 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -826,7 +826,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
 				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
 				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
-				 BIT_ULL(VHOST_BACKEND_F_NEW_OWNER)))
+				 BIT_ULL(VHOST_BACKEND_F_NEW_OWNER) |
+				 BIT_ULL(VHOST_BACKEND_F_IOTLB_REMAP)))
 			return -EOPNOTSUPP;
 		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
 		     !vhost_vdpa_can_suspend(v))
@@ -1267,11 +1268,16 @@ static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
 	u64 start = msg->iova;
 	u64 last = start + msg->size - 1;
 	struct vhost_iotlb_map *map;
+	u64 features;
 	int r = 0;
 
 	if (msg->perm || !msg->size)
 		return -EINVAL;
 
+	features = ops->get_backend_features(vdpa);
+	if (!(features & BIT_ULL(VHOST_BACKEND_F_IOTLB_REMAP)))
+		return -EOPNOTSUPP;
+
 	map = vhost_iotlb_itree_first(iotlb, start, last);
 	if (!map)
 		return -ENOENT;
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 35908315ff55..7e79e9bd0f7b 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -203,5 +203,7 @@ struct vhost_vdpa_iova_range {
 #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
 /* Supports VHOST_NEW_OWNER */
 #define VHOST_BACKEND_F_NEW_OWNER  0x9
+/* Supports VHOST_IOTLB_REMAP */
+#define VHOST_BACKEND_F_IOTLB_REMAP  0xa
 
 #endif
-- 
2.39.3

