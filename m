Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E5153828
	for <virtualization@lists.linux.dev>; Tue,  4 Feb 2025 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690317; cv=none; b=C+bdZe4jzFDD157iJ2sX7QmeneWuKIUykmUW8hOA2JlEf1NwLRP/VGAFbx3vyC+bsdYnVKyEVbZ+pTt2VS8QgyjkbTO6xROM4Nhw8Nx1aRJ2A3jkaHk7+nnAQ4A56XcWha7twZVaVZ1oFdvr3t2SN1dMk+zY0x9yZY64CS8tqcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690317; c=relaxed/simple;
	bh=7qVnBtxjsZMzMsEmWRXGuoo3KvfHyvEgwQTbxiZdnh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Zv/Yjh4kAVELzr+5PwJq5yG3vc/dVpiAqXWTdciqcRm7IVQnqNIWb1tWxT3Np3fHSFUDlstXkDDnTjf6gW8GRNS0iN9tpCK6iihH6kQ/s3DYesZ8rb0k+fRb0No3leAENgHbENGgKbVKBMs89QTxfxlunnSrS4kPjNKplY19RG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LVNjwtlW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LVNjwtlW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEo4k029285;
	Tue, 4 Feb 2025 17:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=pfdl47RvHYQMPD95LEWKrraCml54
	kn2YD3eusKkhaSk=; b=LVNjwtlW5hOCzWkM3pgr+nfxpxZ7I4MU4TuKEnpC7RlX
	2cPfkaowjNoTN7p6BCnaFLBfe+rb78OXgzkC2UEDJ5D5sm+YLWDS08MA2iX5VXw+
	d7oG5Zg8r6ovC5/mtToR4Z+4U5LcIVE8qns/6O/rxWQc5Vq07AnPce2Zb5dA7DZU
	uf+3UnSrG/FULta8IIcKXNnBUrGNb5kloUd8RaaD96VasfFQi21y/yauyInlehVE
	CDcEGANo67Dh3jNa4HVmqjy343RxlvR6AVy3sSIDJm49A0V4YAVk/bEmrw2MxP+i
	CxM/xAzziSzrlc6ipf1bozw3wK+DLVTWtG7F7eHMsA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44k8y9mdmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 17:31:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514FUKkj007158;
	Tue, 4 Feb 2025 17:31:53 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxaymqyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 17:31:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514HVq2o30409446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 17:31:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB2D55805A;
	Tue,  4 Feb 2025 17:31:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1C865803F;
	Tue,  4 Feb 2025 17:31:51 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.104.243])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 17:31:51 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: dtatulea@nvidia.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        mjrosato@linux.ibm.com, mst@redhat.com, jasowang@redhat.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v2] vdpa/mlx5: Fix mlx5_vdpa_get_config() endianness on big-endian machines
Date: Tue,  4 Feb 2025 11:31:27 -0600
Message-Id: <20250204173127.166673-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UqNe2G9ozFtQIFTIzWnbE6JsXN1kEDOC
X-Proofpoint-ORIG-GUID: UqNe2G9ozFtQIFTIzWnbE6JsXN1kEDOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=916 suspectscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040135

mlx5_vdpa_dev_add() doesn’t initialize mvdev->actual_features. It’s
initialized later by mlx5_vdpa_set_driver_features(). However,
mlx5_vdpa_get_config() depends on the VIRTIO_F_VERSION_1 flag in
actual_features, to return data with correct endianness. When it’s called
before mlx5_vdpa_set_driver_features(), the data are incorrectly returned
as big-endian on big-endian machines, while QEMU then interprets them as
little-endian.

The fix is to initialize this VIRTIO_F_VERSION_1 as early as possible,
especially considering that mlx5_vdpa_dev_add() insists on this flag to
always be set anyway.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
Changes in V2: Initialize only VIRTIO_F_VERSION_1 in actual_features,
rather than all flags.

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 36099047560d..cccc49a08a1a 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3884,6 +3884,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	ndev->mvdev.max_vqs = max_vqs;
 	mvdev = &ndev->mvdev;
 	mvdev->mdev = mdev;
+	/* cpu_to_mlx5vdpa16() below depends on this flag */
+	mvdev->actual_features =
+			(device_features & BIT_ULL(VIRTIO_F_VERSION_1));
 
 	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
 	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
-- 
2.34.1

