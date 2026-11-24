Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535683;
	b=kJ+q7ltFydzzh/t95yf5T4eRqLWevusAEWcobIeAwB4MBJ/3w7VjYBlP2GYBMapO9ia7
	 CwgLegtruKd6TrgzSXiSjKUCK4HZ1/KDnn8Slvm2vV+yK8W8eoPx+kySSoAFag82rTqsi
	 6HP+bnV+iBWJ7fhZfaTp+5hdTdv4lbVpWwP4YVPODwusROUeln2C3/Y7ANTryhnKexca1
	 SAaNodOR4y97e3UHRhOGA1sHdw+vKuBaES5z98QTK6YA9z7nR63xsmwExAuY206T8fUcF
	 fmFSQjAbWDsQd97Y5AIRK6Q8cmG+LM0WzVlyqaRXlR/74MNPSFQsWjrh7iswoSLBc2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535683;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=adknItwGQObvHP2c2EPgsz0aJ1yyOC89DeMibM5RVI8=;
	b=lKV+q9cpV6UIBqW+Hto7GCQtHPZ29lF6tDycoN0XZgzUGw4x9oWjkxDOombMq36ZP82U
	 mjEPr1mKlah7QJXcRHycpJhkpndK5eEd9Qrfl/EKGbwAtQTQ5f8Gu/cok2BfiUr9PQjj6
	 vRr+4t0Urpl7Dl0/t+oLf8iduSZ6ECuIeA/tYNI4khadGFvBLCUGVHVm650QUNhNn/hSU
	 aLAuRFrDdDFwp8Nk5xMlbVsPgB+6ySBRdllvkba4ZoT0IcdWt6YimIPlDyw3E4jN360S5
	 aV2rywMwSzWuKRBaq7yfWFkZof11SNEpG4LaPUICrfsx1e45qKrOZj7CysrtCr8cn3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OxDbBqFo;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915E4606A326;
	Tue, 24 Nov 2026 15:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 915E4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OxDbBqFo
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFYt5k2852212;
	Tue, 24 Nov 2026 15:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=adknItwGQObvHP2c2
	EPgsz0aJ1yyOC89DeMibM5RVI8=; b=OxDbBqFomHWZkH7Ish/p9axj/iNBlfj6U
	lpusffy001BneHpIVxC6U21GSpvtXv/ICn4/eAMDteriZesTlN+MeSIjR3F1FlOv
	af7VSvOeVtWZWx+Fn50zBx6WKIip+XMk2eEp0vBB3MzvRljnr9jljtwvOwMTMDHr
	eYTms5JVXtCDfApAGBopIuKWrMUEZPUAp37zLK/5OktxArqi2zyZ9jdQuiVYXo9Y
	4H2rKKRRIE0rD+dFDdTT7VSz2mOfu3cG2wZS/5lPAAzFf3YpnhWP7TnB9N0bGWfW
	J0zGjiCocLOusZ76Ya7kLsZCYXv3qTw4RS+3icFPjRWmNY5QgByHQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkgeqq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:54:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFJGNY2467739;
	Tue, 24 Nov 2026 15:54:14 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3quftwyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:54:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOFsCHu60686678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 15:54:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58FCB5805F;
	Tue, 24 Nov 2026 15:54:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEEF458051;
	Tue, 24 Nov 2026 15:54:11 +0000 (GMT)
Received: from li-505aefcc-3230-11b2-a85c-f1e8e6da9e06.pok.ibm.com (unknown [9.105.76.126])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 15:54:11 +0000 (GMT)
From: Cam Miller <cam@linux.ibm.com>
To: jpb@kernel.org, joro@8bytes.org, will@kernel.org
Cc: robin.murphy@arm.com, iommu@lists.linux.dev,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [RFC linux v1 1/3] iommu/virtio: Fix out-of-order teardown in viommu_remove()
Date: Tue, 24 Nov 2026 10:54:08 -0500
Message-ID: <20261124155410.768743-2-cam@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124155410.768743-1-cam@linux.ibm.com>
References: <20261124155410.768743-1-cam@linux.ibm.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2MSBTYWx0ZWRfX4MOqpcEoggMW
 ML1juhQ5CBz6CCBqSjJBAHYHctJzyhj0MMOEg31PSJf4LHQNx2rNG1NKhJ/7Y+4xn5RCX/B58ZJ
 d6tqXWfNhL26USbTnmpJFUkLIVW60Zb3dwc0eRa0qutE7G0WKIy3r0e2kvWiXLml/e618Ur6aTr
 u1JUMkGxXYnM3qT744JkIQD/ESil3zcKNSwwLp0cPesBzmZD0nVQWr6z6jjd2JONvG5esWrdf4M
 D4e+G3AbZi+AHJBu2HgUISI1mP80R9zvmQJVULXvgnrPZmn4pRRxG/X4ftld3LsUa8DDgObeLha
 rg65RDvunbX7tSj85kEC+ib6tgciPNimuEY5WtYhLgcJzp2F4ew6LbWU8WXBkz3Zoz1RAuNUk0t
 DZ5aVCzv8aByMprja/WUuclKPcqD2jUAHJhHy66dSUJdcaAJYcRVW/v+jnWo24xC64HOKtKEYSV
 q8j3DqjGcVCVXWCserw==
X-Proofpoint-ORIG-GUID: _84AQoDYtbHeNELDPsWDIPszgr6vKg7R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2MSBTYWx0ZWRfXx3Dr6Bbwedwr
 dKw9Y9o3KTYo+qgSeHrqpnTWFrd+x8LgnWpzl6CwL9Jbv5EJmKkzTCbyZnGl2xRl3g6YRZXr+K1
 yt6KBrpbavRMKf2FDqd/LEQczAjw/zo=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b05b327 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=LnuibQuAgLjWrwTcLYkA:9
X-Proofpoint-GUID: _84AQoDYtbHeNELDPsWDIPszgr6vKg7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240061

Fix bug in viommu_remove() by swapping out-of-order IOMMU unregistration
and sysfs removal steps.

Other IOMMU drivers all call iommu_device_unregister() before
iommu_device_sysfs_remove(). Before this change, viommu_remove() had
incorrectly reversed this ordering, leading to the following kernel
oops.

  BUG: kernel NULL pointer dereference, address: 0000000000000030
  ...snip...
  RIP: 0010:sysfs_remove_link_from_group+0x10/0x40
  ...snip..
  Call Trace:
   <TASK>
  ...snip...
   ? sysfs_remove_link_from_group+0x10/0x40
   iommu_deinit_device+0x2a/0xe0
   __iommu_group_remove_device+0xb0/0xe0
   ? __pfx_remove_iommu_group+0x10/0x10
   remove_iommu_group+0x35/0x60
   bus_for_each_dev+0x83/0xd0
   iommu_device_unregister+0x3d/0xb0
   viommu_remove+0x25/0x60
   virtio_dev_remove+0x3c/0x90
  ...snip...

iommu_device_sysfs_remove() will set iommu->dev = NULL after tearing
down the corresponding sysfs entry. Then iommu_device_unregister() will
iterate over every endpoint device attached to the IOMMU and reference
the null iommu->dev pointer, specifically via call
sysfs_remove_link_from_group(&iommu->dev->kobj, ...).

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Signed-off-by: Cam Miller <cam@linux.ibm.com>
---
 drivers/iommu/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f1..a08474eeed58 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1254,8 +1254,8 @@ static void viommu_remove(struct virtio_device *vdev)
 {
 	struct viommu_dev *viommu = vdev->priv;
 
-	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
+	iommu_device_sysfs_remove(&viommu->iommu);
 
 	/* Stop all virtqueues */
 	virtio_reset_device(vdev);
-- 
2.54.0

