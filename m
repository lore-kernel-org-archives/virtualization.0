Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC44F5E8
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DHSE3yQK"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A3B242214
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 20:40:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A3B242214
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=DHSE3yQK
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LapCGTaQkv4O
	for <virtualization@lists.linux-foundation.org>;
	Wed, 10 Jan 2024 20:40:36 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 93558421F9
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 20:40:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93558421F9
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AJfjWG028143;
	Wed, 10 Jan 2024 20:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=hhvQOBFamiyiEmHuupz5eDq1YRqBcTmmT3w2YGrrD10=;
 b=DHSE3yQK/9Ol1yXpkKhUrTD9n7+DqGMPNsRbhSRvzLSx+yCGCwkmc19UoFXFNpDAONU5
 qYTSVX/3tqhOVUfu0lyDm0KTHx9VhQ6639pG8QAokUSJkyYk415uSo/wji2qGXIXkiKe
 K96+ihbtESCeHPwOZeNmmLJjySnN2xw572lmeABrD/mvCMN+8IeRG5jcHrEzQAdFol90
 KrActpbdXASCsew+2eyLiNrSpMtxFGWePKz72r/rWrRtzEt1YqQCNC2PqK180Z8dPkST
 KHXkq6x184vrozJJ/XAK7eDTzQpn4YPrw+Zpw0Xnr/FcqTcS6pG/g2Q8C7Fzl+NXVRTj Cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vj1m404ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AJJe28030160;
	Wed, 10 Jan 2024 20:40:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutp5xcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 20:40:26 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AKeGrl005067;
	Wed, 10 Jan 2024 20:40:25 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vfutp5x5e-12;
	Wed, 10 Jan 2024 20:40:25 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 11/13] vdpa/mlx5: new owner capability
Date: Wed, 10 Jan 2024 12:40:13 -0800
Message-Id: <1704919215-91319-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_10,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100163
X-Proofpoint-ORIG-GUID: CLFuHUGjgvH2x-cylsNPOygAE-HFhxhe
X-Proofpoint-GUID: CLFuHUGjgvH2x-cylsNPOygAE-HFhxhe
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

The mlx5 vdpa device supports ownership transfer to a new process, so
advertise VHOST_BACKEND_F_NEW_OWNER.  User virtual addresses are not
used after they are initially translated to physical, so VHOST_IOTLB_REMAP
is not required, hence VHOST_BACKEND_F_IOTLB_REMAP is not advertised.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 26ba7da6b410..26f24fb0e160 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2562,7 +2562,8 @@ static void unregister_link_notifier(struct mlx5_vdpa_net *ndev)
 
 static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa)
 {
-	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
+	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
+	       BIT_ULL(VHOST_BACKEND_F_NEW_OWNER);
 }
 
 static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
-- 
2.39.3

