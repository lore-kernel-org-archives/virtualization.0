Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535684;
	b=gy7H9b4JbgiIbhGjCT6IITSwrC85pLZcrmDBfyzo7332/ICTjlcw5aCCd/KE9xtLftST
	 fdOn+KraO23cXe1xd5hciTyjeBjd089DqteIKuZCozXxrBXjwzDvs0Xgvt2wX5eazSlpa
	 BD/H7pPkj71WjnBQjU2p9WRBwEXDbEherd8Kro/g/M0dx3Rf/H7u2S0NPaylQ8l/OSisn
	 zwvzp5SNzjOOdC4dK0vUHWPnjvP/LLt+7CUsQH9eobEhuun7bGkD3JsIgNljXWVppmduX
	 zxvPkEGdSUUxjGb8CP0AVtSCKTXXVSnZ2Wz2zSwxEip7oGoKo5e7MONQGlLi4u4heoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535684;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IchOjVdYa1fDISQIC3H7DTl7BgoC0ZxrvVLIntVYFiA=;
	b=JfkAzilxlxZarLEnobIEoSTPGMvePXM2XfLEqNZT3DIVXrRsl17CjJtqs7wb4BGPjvHV
	 uWKNRhNu2Lnztr7V3ds9ChSrLHv4XWGCb1jN31brq2rhNmu4fYrw9M7pBEV+q+QzQNBqA
	 2FKbreCRHnzwhT+Yi+kJpeh40CxVvG4BeXGQsOBnKN7TxRYnoKJo6P1Y+i1ODPV52nvQt
	 m4ggTnjVpdvppIj3fM2I/eiOGnO2hIMuCYuqLGyO639o7Pmz5LpK2KLzyEGX41JevSLMj
	 OBAugHzT5kgYk49Wnm8QJYYGM4ptkF1RBlTioF6KL57kWpaASiACTFltvoJmMJMrIEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rCeK4cUn;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEEF606A6B4;
	Tue, 24 Nov 2026 15:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFEEF606A6B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rCeK4cUn
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFYfVR2851796;
	Tue, 24 Nov 2026 15:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IchOjVdYa1fDISQIC
	3H7DTl7BgoC0ZxrvVLIntVYFiA=; b=rCeK4cUnuy/4QzBAY70TazhxqaRO5dLHz
	hY0ON7tTmhmvZCzMwErx8Gu6EE8ELvpZhL7JuyIitwln0E9ayyfyqa1Y9hmqG/RF
	ni0ZrZJxejQ2sMNUl6nMhE9mP7RbcPlyyLs0DNZivY/hxFOhmKplyIZQOf6ekPt2
	obAJHBCDl8EmnbNHhfu1sbaWHcmFKQo5oz5qnwUfFQHa8fiuhHmZ6AeIPvs2szAY
	gMazkCPT1AyNKvIn4+E+h2ArMpaeLHG6I+SvG7T725ltRGLeUb9XdF9HbX7dqjgm
	Mx8WNUzYlHiuJrelh8Cv1jMwD1A83CZjAVvuCKSyqXj6LluHW2QRA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkgeqs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:54:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFJGID2467736;
	Tue, 24 Nov 2026 15:54:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3quftx00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:54:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOFsDaU14418568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 15:54:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA7A85805F;
	Tue, 24 Nov 2026 15:54:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BFA35805C;
	Tue, 24 Nov 2026 15:54:13 +0000 (GMT)
Received: from li-505aefcc-3230-11b2-a85c-f1e8e6da9e06.pok.ibm.com (unknown [9.105.76.126])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 15:54:13 +0000 (GMT)
From: Cam Miller <cam@linux.ibm.com>
To: jpb@kernel.org, joro@8bytes.org, will@kernel.org
Cc: robin.murphy@arm.com, iommu@lists.linux.dev,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [RFC linux v1 3/3] iommu/virtio: Add device links for endpoints
Date: Tue, 24 Nov 2026 10:54:10 -0500
Message-ID: <20261124155410.768743-4-cam@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2MSBTYWx0ZWRfXz+4r2QuhKVQB
 3adKd8H97F6dI1YUIRlSLyO/9TpUWev7tgFBkj/5H00WYZEWDFqJU3OHaXikZq+EjwlbbBZAHcv
 cuTP3mtUzOjbIE8+J83CCoIQ2KoTTcgdYRv9CH21YOyngArMHSsXTVs0++C/IClHvxOQykNneJZ
 66owqvobtkYNV7J6auOzTUh+WQt57TbGEDrwbZAte3augoPyTxhD/BEuz26bWnbE8fbLzgous6v
 qWD0fXbzABYBWMc3o9EM0SzlGXcZ4oIB2Ng5RsqXEuEuu51oUn89x1rM3FMthfY5tctU9bY+BVa
 xFesFgMasG6f1nNWvDQnJKcl8yvQ4R1XmByGj4nDW8n55TySG4lJkRUY2iyrv79w76j3WUbfYbW
 eksEzquz7TpqV3VkGkzefpCakJ4mzNmsjXIjSbjpDbDJ07eDPLQJMqCpuzHYyKWyvs6/tzQ9Bdd
 JiyTK07ofnlDx7I18wg==
X-Proofpoint-ORIG-GUID: q2EMZpFej54bNnwBDcRmVd_8YI99nY9O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2MSBTYWx0ZWRfXxGItENaIbK7p
 rS8uxKr7crVaDwQIvMByjjdySfNz1VmYT9uZ1GJzWyieHjhyJa1tiZQRrOcvBUgwrqfRz4xbEK/
 tUTD2fEUbS9DTB0HPEmmNJnZxkYm7Ss=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b05b328 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Grr11ITIlXNgMPy9vfoA:9
X-Proofpoint-GUID: q2EMZpFej54bNnwBDcRmVd_8YI99nY9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240061

Make each endpoint a consumer of the virtio-iommu device, so that the
driver core unbinds each endpoint driver before viommu_remove() runs.

Before this change, removing a virtio-iommu (for example via "echo 1 >
/sys/bus/pci/devices/<dev>/remove") tears down the IOMMU groups of all
its endpoints while their drivers are still bound. The endpoints keep
stale IOVAs and their later dma_free_contiguous() leads to WARNs in
__iommu_group_free_device(), endpoint IO hanging, and crash at shutdown.

Make each endpoint a consumer of the viommu with device_link_add(), as
arm-smmu and other IOMMU drivers do. The driver core then unbinds the
endpoint drivers before viommu_remove() runs, so that their DMA teardown
will still see an intact domain.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Suggested-by: Jean-Philippe Brucker <jpb@kernel.org>
Signed-off-by: Cam Miller <cam@linux.ibm.com>
---
 drivers/iommu/virtio-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index dd10c3e98a3d..a84a653f269e 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1044,6 +1044,9 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 			goto err_free_dev;
 	}
 
+	if (!device_link_add(dev, viommu->dev, DL_FLAG_AUTOREMOVE_SUPPLIER))
+		dev_dbg(dev, "could not add device link\n");
+
 	return &viommu->iommu;
 
 err_free_dev:
-- 
2.54.0

