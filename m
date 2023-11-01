Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39E4C4332F
	for <virtualization@archiver.kernel.org>; Wed,  1 Nov 2023 15:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CE0B402EB;
	Wed,  1 Nov 2023 15:54:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6CE0B402EB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=v42C6xdi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2YnnVYgrr3F0; Wed,  1 Nov 2023 15:54:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CBC2A40221;
	Wed,  1 Nov 2023 15:54:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CBC2A40221
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9602FC0072;
	Wed,  1 Nov 2023 15:54:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C6CCC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 15:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DECCB80FB0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 15:54:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DECCB80FB0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=v42C6xdi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YSJ6lRgLtHqW
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 15:54:53 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18CCB80F6B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 15:54:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18CCB80F6B
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A1BEoIT031295; Wed, 1 Nov 2023 15:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=z7qKIxreV79Esql4YvSQ+NOWDmEVG9Uboz28sx478vU=;
 b=v42C6xdic86zusqwEsNQaJ1K8otNUqquJ/WsiP4GJuGjJcI+AspbD8n6/OTtShigGXKw
 ToE9XXKa0zm8c31ODsFO3s1mBPueEeY18rZ4ISg4d7W2NWwv1Au7J+2472zQLGmQXa5+
 DD7sDPeTfaa6GbyigFQTU2IZtzlfr23XwBEO/NremOAfrPv1BynArR58Ky/RAjiEnRZU
 +6DmE9Frw78MnRVc8syzqCVYyEn49RxAAUlB94wC8rCJdRzm7EvXbYBzRdHUKSZLfoaX
 D9Qk6aI/pkHF488+yjgiJPpzTGFpHodZ8qp+um+7gzDhH+OmLNY7PWxqumu40tHhp6KE wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tuufnfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Nov 2023 15:54:47 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A1FQbfE020087; Wed, 1 Nov 2023 15:54:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rrdf588-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Nov 2023 15:54:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A1FqKK2005458;
 Wed, 1 Nov 2023 15:54:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3u0rrdf572-1; Wed, 01 Nov 2023 15:54:45 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] vdpa/mlx5: preserve CVQ vringh index
Date: Wed,  1 Nov 2023 08:54:43 -0700
Message-Id: <1698854083-136016-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_14,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010129
X-Proofpoint-GUID: mROIvOzsCUPbploxXbyOlKZPFIl9ndc6
X-Proofpoint-ORIG-GUID: mROIvOzsCUPbploxXbyOlKZPFIl9ndc6
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, Eli Cohen <elic@nvidia.com>
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

mlx5_vdpa does not preserve userland's view of vring base for the control
queue in the following sequence:

ioctl VHOST_SET_VRING_BASE
ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
  mlx5_vdpa_set_status()
    setup_cvq_vring()
      vringh_init_iotlb()
        vringh_init_kern()
          vrh->last_avail_idx = 0;
ioctl VHOST_GET_VRING_BASE

To fix, restore the value of cvq->vring.last_avail_idx after calling
vringh_init_iotlb.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 946488b8989f..ca972af3c89a 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
 	struct mlx5_control_vq *cvq = &mvdev->cvq;
 	int err = 0;
 
-	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
+	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
+		u16 idx = cvq->vring.last_avail_idx;
+
 		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
 					MLX5_CVQ_MAX_ENT, false,
 					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
 					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
 					(struct vring_used *)(uintptr_t)cvq->device_addr);
 
+		if (!err)
+			cvq->vring.last_avail_idx = cvq->vring.last_used_idx = idx;
+	}
 	return err;
 }
 
-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
