Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D9915FCE5
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790348; cv=none; b=R3YYaOl1BzHHCEirkTCg1dU3TptmOuxXyRF7fhXBGi0+bXX0MvxTokhG33djp2iohYqS2XWWlvh+njbdcFu8J8jpf+wO6CwR0tebha29w9eoogT+gBbiMUrtmWOt2c8+BRSo8HKbTMcSgrFa+xuJUTjfNXa5INwMdBgyCW/jWqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790348; c=relaxed/simple;
	bh=mpPEqNHUboHg5X4DuAYbZYtk5ez8+vBp8ZUbNSPbIkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ubwjfNubikuqfKdKFydeeC0jlfsh+idb/WjBNDAkmi4AHCnHpD640VHDxUsC8oUZNKlIvJyY6VIUdX/gm8FADFTq2UWigKOaSJt9XtpYEXpoUU7kWqBWaUi971gd3QjmKXEDCuR2EWp4bxdOpnxe9H+ayHL+8+Vl3o1l5LwqT+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oMAGvgJ1; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oMAGvgJ1"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3BAB402C7
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.799
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QK_B9M2cH0xl for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Jul 2024 13:19:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CFB7040240
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFB7040240
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=oMAGvgJ1
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CFB7040240
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:19:01 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDILjo023659;
	Fri, 12 Jul 2024 13:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=UoIL+vCtOh0fhA5lR3F1t22mJvNzXPZjXUGWRT0A8lY=; b=
	oMAGvgJ1av1S92KxLZpNDpMZ441JMOeBFZ5STUhmTN36ehXhmayNIRRrgnQH+F9r
	CSt/ihMS46oaumteLnb4bQkW43lKFTwc41pqKnZKHCSSAbUa/hwB08yyX5Tf+pPU
	vDkgsd+v4hNGhG2kv5OdJcvbRYx0o+gna+Ay8aXKbBM8RtpUZfqr98JwSa00SnjO
	0+DQBddO/SpznMe2pJVAr3LRh0b0SgkAwy4FFr3fCyDuzbBgq8OYPP0flPhQ31QP
	oRoctodnPVzcvb77kH64h8PT2TwklcUoCtsZZWNEsknywLDQSpZE3qaoHqjt6to9
	ewF1RPFV9NnNE/n5is05Bg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emt34yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CCVnUM022018;
	Fri, 12 Jul 2024 13:18:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3snpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:55 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CDIsD9029886;
	Fri, 12 Jul 2024 13:18:54 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 409vv3snp2-2;
	Fri, 12 Jul 2024 13:18:54 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 1/7] vhost-vdpa: count pinned memory
Date: Fri, 12 Jul 2024 06:18:47 -0700
Message-Id: <1720790333-456232-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: bbr0eCVG20NSa_bbxeF3aQ5F1lkneOWZ
X-Proofpoint-ORIG-GUID: bbr0eCVG20NSa_bbxeF3aQ5F1lkneOWZ
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Remember the count of pinned memory for the device.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 63a53680a85c..963f3704bc39 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -60,6 +60,7 @@ struct vhost_vdpa {
 	struct vdpa_iova_range range;
 	u32 batch_asid;
 	bool suspended;
+	long pinned_vm;
 };
 
 static DEFINE_IDA(vhost_vdpa_ida);
@@ -926,6 +927,7 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 			unpin_user_page(page);
 		}
 		atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
+		v->pinned_vm -= PFN_DOWN(map->size);
 		vhost_vdpa_general_unmap(v, map, asid);
 		vhost_iotlb_map_free(iotlb, map);
 	}
@@ -1009,9 +1011,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 		return r;
 	}
 
-	if (!vdpa->use_va)
+	if (!vdpa->use_va) {
 		atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
-
+		v->pinned_vm += PFN_DOWN(size);
+	}
 	return 0;
 }
 
-- 
2.39.3

