Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C8638A71E
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347344; cv=none; b=hk/ZEM0BA0eXjjlYkVX57sdON8rYjMPxGKK+G9WnbH+wh1Kb68aw7gI430u9LZ6RAUfkAOJJIDT3Zo0Hkcxy9teUR9yHv+4UnWRnNnFJhlZmsS0DRmRVXfDzk9flWKy5kjveKkQ3oj/JevnxjGiVfPAJd6p4EJ/93Za1u2TZLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347344; c=relaxed/simple;
	bh=x3DfZwvQtEpDJ91vQQzVpSVpy/RsnoYE2gZaX5nti4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qam05Q+j1QHL0qxaA4iYx7xdEmIf+NtB77TsJUolp99Vt1xxAbY8ydB2y7Y5dto7NWzMgu0ecFWkB19yWLhEF2S1RtnjhTz6U/YsgB0UoQZy3MiQbskY7vTVsnrlCVk+r+a5exWhfnGCa71whAlc7DCyPu49mZBVkxSNucGkttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lo6LHIdn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lo6LHIdn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIFpY4094067;
	Mon, 6 Jul 2026 14:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kZ7dlYGGE/S9j2Wehb7yeZ3UHzHDH6WRhRxdNk9CP
	zw=; b=Lo6LHIdnt4OyYhusMFmL7Cnqqngve+0+Y6Ny4tdcPZ/mkHtT0ub6huHWy
	++CaejOknKE9wTkUd9TA6SseV/KYFtByOTBjcCfiaGsorTQ/YGkr+1cLnyvRYciK
	yxabO09nFNUrW4n4MPMtDU8i4uPE0Bzio5OZR3Jbp4JV0U5HezgkkAp52DdOIPiu
	YZ3wkVYXPVGo0tE2xxyffyBFApV4y18v6T8QqwkvpfUVU2DL/ADWojTByU7mdtvZ
	EQPmUIm0nJqNnwiTI+qyFrgaNHq+LVavjnwltYlv65F2foXNkC+8RhRklB/sZRVP
	urcn1MxuK2kNlaQSxbQsfSTvg1iZA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4hsrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4hX6001262;
	Mon, 6 Jul 2026 14:15:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvx2f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EFdeP51511634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:15:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2855420043;
	Mon,  6 Jul 2026 14:15:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AB9120040;
	Mon,  6 Jul 2026 14:15:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  6 Jul 2026 14:15:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
	id DEBF016167D; Mon, 06 Jul 2026 16:15:38 +0200 (CEST)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v3] vdpa/mlx5: Fix buffer length in create_direct_keys()
Date: Mon,  6 Jul 2026 16:15:37 +0200
Message-ID: <20260706141537.3510294-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 65sWXlVU3aB_yI2MyOMSWYW7nKHIXWgE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX9FMU7CRH7+Zp
 LTlPRVSNs8JaVpFxjQvf7itH5wuTDNkcy/3+0naYsVCE6Q1gDdCEIpn58IxLekLO92wI61/iC8x
 L9ERheFj7yDqc85dphKswui/tRbnt2y26ybs4Rs1XgTs6cs/DiR3+wLaNxA1i9QnBeXg1rm/QAJ
 lHsru8RpNLzql06kuMrRtt3y3TlIVDiJUMLfjr0oadt1LKezSDx1W9iVbiAopinEbnmu0qX4XRG
 kP7cAnsQ9H4u82C1OBrI7nAV7KAsvWg3DdPv/Zvo84dwDD49Zov6lPUeGfHx3Nr8d2+6NJvz1Tb
 euFzmadZusrFtUqvu8hZqA0gPEXs9YHB0Mr93WEKiF2lvF5wiHFydkki8kAzQ12DEuQJJMmvh5e
 jhjyV6vcoDwSKjlPVvL33dvOiHehMvuvBjx3/FnXuccXSQakgXtMi5wQBXIOFMdiqgtKo0CHPEM
 asYUvT9ePNP47/bSUIw==
X-Proofpoint-ORIG-GUID: 65sWXlVU3aB_yI2MyOMSWYW7nKHIXWgE
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4bb88e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=vvbv4Sm7C4kpW9qWDK8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX5EIPN+7Oh/Zw
 1f2JDNOjEnNOJZLZ5KBoMWmPpuL8rvJI1mtGi8R8Dr9T+hIAa2MB66iuklkc3hpmy3mbL3RpPew
 uObdA00D7VvnE21JbqVUzm9ENsrd+Vc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141

We have seen in our CI the following KASAN message:
BUG: KASAN: slab-out-of-bounds in cmd_exec+0x550/0xca0 [mlx5_core]
Read of size 272 at addr 0000000176795020 by task qemu-system-s39/82764
[...]
[<000011388ab3a7a0>] cmd_exec+0x550/0xca0 [mlx5_core]
[<000011388ab3b61c>] mlx5_cmd_exec_cb+0x25c/0x4f0 [mlx5_core]
[<000011388b21e82e>] mlx5_vdpa_exec_async_cmds+0x22e/0x5e0 [mlx5_vdpa]
[<000011388b21fd44>] create_direct_keys+0x954/0xef0 [mlx5_vdpa]
[...]
The buggy address is located 4128 bytes inside of
allocated 4384-byte region [0000000176794000, 0000000176795120)

So in essence we read 16 bytes beyond 4384-byte allocation.
create_direct_keys calculates the pointer and length for in and out
buffers.
The size calculation for in includes the entire structure
size (out + in + mtt[]) but the pointer passed to cmd_exec points only
to the 'in' field, skipping the 'out' field.

This causes mlx5_copy_to_msg() to read beyond the allocated buffer
by sizeof(out) bytes when copying command data.

Properly calculate the input size to match the pointer and allocation siz=
e.

Fixes: 0071b138d44a ("vdpa/mlx5: Create direct MKEYs in parallel")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
v2->v3:  use full size - offset to handle padding and alignment
RFC->v2: use flex_array_size
 drivers/vdpa/mlx5/core/mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 6d02ccf9eb91..d422f3faeb48 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -233,7 +233,8 @@ static int create_direct_keys(struct mlx5_vdpa_dev *m=
vdev, struct mlx5_vdpa_mr *
 		cmds[i].out =3D cmd_mem->out;
 		cmds[i].outlen =3D sizeof(cmd_mem->out);
 		cmds[i].in =3D cmd_mem->in;
-		cmds[i].inlen =3D struct_size(cmd_mem, mtt, mttcount);
+		cmds[i].inlen =3D struct_size(cmd_mem, mtt, mttcount) -
+				offsetof(struct mlx5_create_mkey_mem, in);
=20
 		fill_create_direct_mr(mvdev, dmr, cmd_mem);
=20
--=20
2.53.0

