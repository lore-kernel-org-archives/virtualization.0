Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535682;
	b=1A3rkLOzOyaVBHFUfv8+iR6W1Wwd2DcSlZCn/lWZD4eweyqLAsbn8ed+7EsKGoEVS8HB
	 vATzXSezpnRbvEyDRb8wbWes96x3s1wog8h9wvMUtm9lZrhQiGCDfVarG3c5tVKGMqZam
	 pUVp4dYeoFOzoplyvGj6mR7HfUiYnG2AKfwuciZ/yMg9Ip5T/I/w2o0KIZEUDaUz3TWqw
	 00uqeQWrPM+SpWz/d0kZhC2pHn/S4beG5sfB28LpKeLWdQe/9UONKWZ6FdCVliYkmH3Pr
	 NEbaMjoE+z/N6AZAeRbAbQ6ryVH04AAsvWB1PAZPduqhOBzTt0DP5lxSVVMsuV3iGGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535682;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rvCNVroBe45nReiXZTtlC74wEuZ8rCsFlaFAoUyYogU=;
	b=Jn4T6DzFaEbirPLUuvp+uFrGyLAjnWtyx8EJ1/32rmy/8yBwy+EUjJ+djdkG/wXpx6D4
	 +qD/gBUgAnk2PJDOheySQkJRrJ8LG+AjlLqaLtC/SIKBcRqy0/U3fTtYfJ3KmeqvPypiz
	 ruAK+LSMZl53vUwH9UbXwu1NXcADEG5nAtVV2DDjZ8WiG5pfp16QaC2DjkhqnR7/Z5Bml
	 iS66pjSIg14KhhoGBS73uVcTpLEfz9VlVky93u7o+D2QMp9cstmTNeK/O10672Q1qkHo4
	 HeITQaVGzP2+CVzQKSPGgO0bC9/dYlolH+KKidywvEVercMp0cXiorfEKoBsKUP4Wbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jkhw3aBZ;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E4606A32A;
	Tue, 24 Nov 2026 15:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E8E4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jkhw3aBZ
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFZ2eR2806137;
	Tue, 24 Nov 2026 15:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rvCNVroBe45nReiXZ
	TtlC74wEuZ8rCsFlaFAoUyYogU=; b=jkhw3aBZQTAaGwTSSy+Dv3aD5BYTZ2DYA
	hoMSZXPpcWLod3D9GgiIM7I30uB9B5f0+k+K5B6//bCJUTdBq6XLuFkQ8zCTcRjg
	WL+W06Mwc92jZy0JSX/3QYrSWn5wuVM3ULDcXANZNDTr1oCIrZJ71TApbOjCILmw
	jOkW3Y2X8z5jQdX/f7A4A1YUXm/IUhIb2eKN6cLw2+AD01RociYhZtfnaJOS5njz
	lt4OqaKftWTQifJJMfN1lFYV6VirCxd6QEgaKjWDXXvWGv2IDRyqAG/VaB9lh1Et
	cCBzYf0EYHwgPYH7s2rEGbL+Ty+c37MJmWafhab+guElzRoE6Htlw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv82p2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:54:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFJXRC2883604;
	Tue, 24 Nov 2026 15:54:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vk8d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:54:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOFsDx819268234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 15:54:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13AC458060;
	Tue, 24 Nov 2026 15:54:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70D5558051;
	Tue, 24 Nov 2026 15:54:12 +0000 (GMT)
Received: from li-505aefcc-3230-11b2-a85c-f1e8e6da9e06.pok.ibm.com (unknown [9.105.76.126])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 15:54:12 +0000 (GMT)
From: Cam Miller <cam@linux.ibm.com>
To: jpb@kernel.org, joro@8bytes.org, will@kernel.org
Cc: robin.murphy@arm.com, iommu@lists.linux.dev,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [RFC linux v1 2/3] iommu/virtio: Prevent driver unbind via sysfs
Date: Tue, 24 Nov 2026 10:54:09 -0500
Message-ID: <20261124155410.768743-3-cam@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b05b327 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=6WNED9Rxp78MK61v1xYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2MSBTYWx0ZWRfXwesCZw/RaSsH
 S04bGEEIHrszPxBwsFRaRBo549lMYGLmWQHthIGQJ4ZKpxONUNsAeQ1JrkJDZ5vfftIYhdU028s
 Ap5X2DddomcPgW0GsQMb4nfh1vh+bWI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2MSBTYWx0ZWRfX9dkRBgIPHn77
 2cR/tNnHZqv2PsBe8DCgwA26Z+By79wWVdUP8MFSrQ849RqIpdjOji/a0nzQmScbxO5ctgY9gW4
 20JiP7Ohse4pTOZbJmdtSttLFd9wuIZRoegSP31I/PhCbh6WcDJ4Dx6vLGCcl0bBisHeBg4uFuY
 r1I4KMP36ht99ABQ+VGCHdeoD9o7Ryje17u+yw2etBGI2iWnvxP3JIOm5NGSBxfDpBwdTUf8azY
 blcCvApMoH/GBOZPwnCr0pSGB5CnheCWtk6KPnNedUbyPbBAjusrpROfDqEgeFWX0QLY6Af/3mm
 kOhdjMS8/JXX3YjkFGNWcWxm6v3qUgcR4xqeDbdxSvpwmhyoC80fm7c3tVmfH+QORxYXUvsLfWZ
 e+G7pIooV3gyggEUrC7+DP3IvGyYtyM4UHBKzgLwqxlTYeCgMM6DVVuCPfJ92ddzaDlNA6bczkG
 DEOZIUA/Ta3qYyV0wmw==
X-Proofpoint-ORIG-GUID: ostNga8bdfFg5uPx6H80cvPkN_hsdrwQ
X-Proofpoint-GUID: ostNga8bdfFg5uPx6H80cvPkN_hsdrwQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240061

Set suppress_bind_attrs on the virtio-iommu driver to prevent userspace
from triggering driver unbind via sysfs.

Unbinding the IOMMU driver from beneath live endpoint devices would
leave those devices with dangling domain pointers. This would not be a
recoverable operation.

Note that suppress_bind_attrs covers only the driver bind/unbind path,
not PCI-level device removal triggered via the sysfs remove file.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Signed-off-by: Cam Miller <cam@linux.ibm.com>
---
 drivers/iommu/virtio-iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index a08474eeed58..dd10c3e98a3d 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1285,7 +1285,10 @@ static struct virtio_device_id id_table[] = {
 MODULE_DEVICE_TABLE(virtio, id_table);
 
 static struct virtio_driver virtio_iommu_drv = {
-	.driver.name		= KBUILD_MODNAME,
+	.driver		= {
+		.name		= KBUILD_MODNAME,
+		.suppress_bind_attrs     = true,
+	},
 	.id_table		= id_table,
 	.feature_table		= features,
 	.feature_table_size	= ARRAY_SIZE(features),
-- 
2.54.0

