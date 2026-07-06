Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787BD44210D
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332103; cv=none; b=UPIDzoVsa/CInB0KoEZNm0BUzJDYohLtUD9tRId+9GAECIeWLrPshNZjTcr5hzr3oSlDXF5ER39EOxr7chDHV8IokzW0/akeMC65oB14l4abCyLWgZJKQ9Ows7Bc9vfJrvuU47j0wErh6+Q5Er5DGYDoxZg2lSltTnDZAzBhQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332103; c=relaxed/simple;
	bh=ObY6yOms71ZlkRn+ylI2RVn47u9UwLHUOqFl+yyi3jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=soD0cHK5UJ2SbhluN9JXtJpa2ER1Y1F18GWt3cctEIeUKy0gQUh78BTvFgyR2Rq2WqgpEUrFSKpkJSKPdGCoLzeI8C0RdGTeJaSsjoisWZFtYE2r4ctOBCFvOVea/t0rm5cGfQZPl75nYjsOBFMXGF02dE0AVnNjimnzJFWzR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qG7unpzP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qG7unpzP"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669IpuT3134820;
	Mon, 6 Jul 2026 10:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZwAA/040v89qhpvXHpR+OKwyYNU0Pk6VVdAAVHU+6
	L0=; b=qG7unpzP5xndZI2zlfNM3EBIgNYjxPIc5hGLvY1fFIqSWcmPLIw/f5h9d
	ToiFdL7rtQQEeLtBtAPTtrrnzOneSRv1ZUmBlrS3VYEYIp0NLMqIqjMyzEs36iwm
	eyaj1TfeMmGpNnTwv+dc+REnkCb95QHnflFz2OsrC6LaPccjM+sORAQ8Nt0SdMvv
	xpsLlHYeESHcIYiZVEOjxe93Oe5sX8sDapz7O1sqCvEZEbpJbL4JZLvTvnHZ8xl3
	yAwZHLZOI1XlrOmenLGEgGnUwycut6KUEPtSD8uB0gEDs2VMGk2/RIRyPhdSnjyq
	zqo15OsZ4jn0P9R0GVOJKmWNDhCWQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stshbbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 10:01:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669nbod022058;
	Mon, 6 Jul 2026 10:01:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvw7dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 10:01:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666A1cO951773886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 10:01:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A0FA2005A;
	Mon,  6 Jul 2026 10:01:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 301F22004F;
	Mon,  6 Jul 2026 10:01:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  6 Jul 2026 10:01:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
	id 1BEA416038D; Mon, 06 Jul 2026 12:01:38 +0200 (CEST)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [RFC/PATCH] vdpa/mlx5: Fix buffer length in create_direct_keys()
Date: Mon,  6 Jul 2026 12:01:29 +0200
Message-ID: <20260706100129.1541140-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: euJvDSXBcE2dcWj8LWJE1K8uxKRM1ZVd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5OSBTYWx0ZWRfX362rWXy84Kxl
 XBTXt3g7eI0H6mpzwv5ZrQ+LGGHqdpB7oWX+5vCzu5ltjNUs+PRUl9ha40mdxl3f90I/N3nYOuT
 RaXLwcTWcHbvnRmdXLm7FN92aPzxxl4=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4b7d05 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=vvbv4Sm7C4kpW9qWDK8A:9
X-Proofpoint-GUID: euJvDSXBcE2dcWj8LWJE1K8uxKRM1ZVd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5OSBTYWx0ZWRfX8SG5i/AwDgTE
 uYSscA1AtzAB7JMf2O2qus9l+nTnG/bhiDwC2lYdO8s3NJGBpxTO3SmwImDg7WpJtK5T5UU4jsn
 KHBnoKy1AvfSR7JNA3LD0KkzGga30IClxPuLpC/jDmgErtkfyIt7jTPjYsd4YL226Ssm3KufkJc
 TFlvDwT/tukIQyryn3Jd3scdQ53JniPidw7+HUIv0MwtxY1+OAEL1J1+xZtyJWachhjITRW/EdD
 +doPirLqob1nMQVpDH+4BWdLSuIry7JE3qwbYhtWQj9r3kXtU4En68hNGxyB4ZI2dS7ruO+uIfo
 vs9ymDFLD5+lw/nKAeeBS1MQWvZ7XnC+qq462n76cIh35ZLqhOHWJE/qc+2v4zvvemdLwAG4e74
 mofARQDD2IYEPqaR/cUc8J0Ay74bZG6kIRfMXU6R47vdfDjC8y7fWNTYkUnnelHCnKYL9wJ70Pw
 X6vDSDLyrsDebgM7Rgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060099

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

Calculates the input size as sizeof(in) + mtt_array_size to match the
pointer and allocation size.

Fixes: 0071b138d44a ("vdpa/mlx5: Create direct MKEYs in parallel")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 drivers/vdpa/mlx5/core/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 6d02ccf9eb91..03fe7f5ca412 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -233,7 +233,7 @@ static int create_direct_keys(struct mlx5_vdpa_dev *m=
vdev, struct mlx5_vdpa_mr *
 		cmds[i].out =3D cmd_mem->out;
 		cmds[i].outlen =3D sizeof(cmd_mem->out);
 		cmds[i].in =3D cmd_mem->in;
-		cmds[i].inlen =3D struct_size(cmd_mem, mtt, mttcount);
+		cmds[i].inlen =3D sizeof(cmd_mem->in) + (mttcount * sizeof(cmd_mem->mt=
t[0]));
=20
 		fill_create_direct_mr(mvdev, dmr, cmd_mem);
=20
--=20
2.53.0

