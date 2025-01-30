Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04301EF091
	for <virtualization@lists.linux.dev>; Thu, 30 Jan 2025 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738273466; cv=none; b=FRYIZ5rN9VrJzARGhrEwyiQFf1W7Rqp8Z7cdEuyXz410fuZIM+r7NVKQDgEgmcHFCaMGCDE8G+85VfGymuKRgB5EYdrdGSTcL1GxuhgZHxzu302H0+HiW8qDFFaXCyrZXw4v1RALW3r89J9dAGRWPMGgOPErkEJ/FR2PiNXOxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738273466; c=relaxed/simple;
	bh=p7LVtx70b52Gk2ld6T5cT4CgfJxFt1szyizklJV6Y/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i4C/TjnoHjLTl+ABTx3PT/FTPLTdtkuTR0XdBLUhbXZDZ5M6IBCy4QScc2J9G2qgqULqZp8KzAFd1OKLT77/szcV5XX4Ylq1aki2vFl64MweZVuDdYnHEG6uJTymoiMSDHcqNMAhblElnyPHNI+elhThHscP+/6NVLbEz5T8d1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mqFq+Bid; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mqFq+Bid"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJUBRG004670;
	Thu, 30 Jan 2025 21:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=u+NFbd6V2YHxhuxrINX3CY72ZMFH
	a677zYoqMWhKlsQ=; b=mqFq+Bid/GwqDT8f3deBMFIyfpXOD/lYbJryyrPJkivt
	t3amUjux3966QNXYtbuUXqzxkuoo2b/J9GHKs48Ilj8ztVGnwtO4DsoSUVUUpTDU
	Y5Ok822yRhYBi1Zr1DEMrznrcoRqzz5t/zCKHujueU0Lgxm6yQ21h5YE69SP8ycW
	rKSVXCKOCFZl/q9DmMMl4iSCA4GIWRLwDlMZvY08jYvPDbOtOwDmYp5zLnAcX4B1
	14nVk37d9GEHBj+TaPywW/VM9X6Kl1Bf09Ls8EHyutTUfzkd8ktRuIii6oiGo10G
	l+mw0+4h5F29a395fBb6ynd2UkB4VDBK7KD7n4+JFg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gfn00j2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 21:44:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ8kLL017121;
	Thu, 30 Jan 2025 21:44:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44gfax8k3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 21:44:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50ULiLNb27329042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 21:44:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF5E558056;
	Thu, 30 Jan 2025 21:44:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A5A95803F;
	Thu, 30 Jan 2025 21:44:21 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.254.72])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jan 2025 21:44:21 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: dtatulea@nvidia.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        mjrosato@linux.ibm.com, mst@redhat.com, jasowang@redhat.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH] vdpa/mlx5: Fix mlx5_vdpa_get_config() endianness on big-endian machines.
Date: Thu, 30 Jan 2025 15:43:37 -0600
Message-Id: <20250130214337.12881-1-kshk@linux.ibm.com>
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
X-Proofpoint-GUID: srThhG5WYnmZ45ItYQ4qbXxywXa7ezv0
X-Proofpoint-ORIG-GUID: srThhG5WYnmZ45ItYQ4qbXxywXa7ezv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501300165

mlx5_vdpa_dev_add() doesn’t initialize mvdev->actual_features. It’s
initialized later by mlx5_vdpa_set_driver_features(). However,
mlx5_vdpa_get_config() depends on the VIRTIO_F_VERSION_1 flag in
actual_features to return data with correct endianness. When it’s called
before mlx5_vdpa_set_driver_features(), the flag is clear, and the data are
returned as big-endian on big-endian machines, while QEMU interprets them
as little-endian.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 36099047560d..f9ea240b8145 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3884,6 +3884,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	ndev->mvdev.max_vqs = max_vqs;
 	mvdev = &ndev->mvdev;
 	mvdev->mdev = mdev;
+	mvdev->actual_features = device_features;
 
 	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
 	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
-- 
2.34.1

