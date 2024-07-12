Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42D15F301
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790348; cv=none; b=g1m1TeBfjXPs0651+Y/E8/pvFnF+9fBgXOU9MY9Rx3DwB1EGKV5wmV8wJipEKWnn2WGv3zFdyZ2twlcMDAmRurwYvUMoRTnruMMWwUutQXT9KiNk+oHWwWpacbQ58HrhQfh6QvoEHPiqcodW0YQwUT6KPiNvHTnecYu++wKOkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790348; c=relaxed/simple;
	bh=dN4nSJyVUk1dN2K4WL25CJ+DanbiyhmkRdutX8DGPEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UCueZKk8l26SYAalPkvk2+qTJQMWldvWsvs/D/ky5DyOtyaO3oOzT81mqb9l2ZeZsuoNReSQKhHtR8L8oISDRsrjEoXIDAqUBdquzfVCbKSFQ2gf1wnmlKNb9dlCHe2RFRDm38sChxJotf3eLq8Phg+g12arsO5NlmMo5h/Q/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ek3m3TW4; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ek3m3TW4"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF4124064E
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.799
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 98RtgRQPHEEe for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Jul 2024 13:19:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C02DC417DE
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C02DC417DE
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=ek3m3TW4
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C02DC417DE
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 13:19:04 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDILeT025537;
	Fri, 12 Jul 2024 13:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=7twIdosg+tLq6GhSfBDMiJ/UOzlk+u2dnfv1CdH0B4A=; b=
	ek3m3TW4f7X33wlg8gpBSSSeib5FDuy76Pr0vnreLbotWO/iFthKK5bK6rJMHV0p
	uTSwTbv9GHUSRG0rsBY8JuMbCjD2zVsd4pG2khdhu9kqhAU7MzEKhxPyNcOqpluf
	CfFD8gua7/RiQNFspP8vudnePjLwmljRjIjDXdjwCBAempH6tSCpVQHcxRLTROZF
	hoY4I4dAnYAuGh7BFLiqZtI8QrkXBmPP5RI5FrKeWDVtPxYml+qfYdoDw3GIRtQH
	jQyw2/PR1aJ2pH4gpwxoXhImrpppe35TXO+YovTcCLy69UYSaHTaAvp6ZTPgIrvK
	iY9xW+BbqsfnMtjSG5hwnQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknuv06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CDGAop022665;
	Fri, 12 Jul 2024 13:18:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3snsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:58 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CDIsDL029886;
	Fri, 12 Jul 2024 13:18:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 409vv3snp2-8;
	Fri, 12 Jul 2024 13:18:58 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 7/7] vdpa/mlx5: new owner capability
Date: Fri, 12 Jul 2024 06:18:53 -0700
Message-Id: <1720790333-456232-8-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: HTQ-eJL4yOmSDO90ENaV7xnBeb0JrbnM
X-Proofpoint-ORIG-GUID: HTQ-eJL4yOmSDO90ENaV7xnBeb0JrbnM
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
index ecfc16151d61..b8b16dc499da 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2698,7 +2698,8 @@ static void unregister_link_notifier(struct mlx5_vdpa_net *ndev)
 
 static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa)
 {
-	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
+	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
+	       BIT_ULL(VHOST_BACKEND_F_NEW_OWNER);
 }
 
 static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
-- 
2.39.3

