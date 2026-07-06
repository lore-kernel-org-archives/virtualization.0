Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736DB414DE0
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344035; cv=none; b=Fn1/STBbffKobEklQ6Jitu+CF0qG/RUkaqOW3Vvlf/sIjhMLAyx0aFloJXCR/1slJdR7vqOUvFmrhqlw69sGmBCp+0EP3YzUPAFnqmwtQ9uozmn1AO3PEL992/yoRmbg5XfBK6wwYgGmcHxWQ5EGf/rmYIq9TrxArp9EHX24Ehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344035; c=relaxed/simple;
	bh=BgQE0kwcTMxMHlfjlJToaU0w3kJZdSh7ipZPN8UqU98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6Xufd7hDP18pzD9XG5evb2NcJ44pogK9GNpFRTsLfNQ6X+Om9RcJE00m4lgxxB2tGiqs8qyyp0gwL3/NI4nXFJobB5eOK2ortvPwZ7ipHa0KFGpu1VMcg1U7P63tAWvHDunilPE+4pKiiSEl3JG2Qoyv0xcYxPt9GY/zH6pQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sXfAsShR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sXfAsShR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIYe04094413;
	Mon, 6 Jul 2026 13:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=P3BW1uzmNZHClJH8ksUvkibtq5e7u1wk8VRBoMfG0
	g8=; b=sXfAsShRNadVH7qah/ZCfWm0ovvDZdFr/5go/T9bOKrbWt8O85gVeEID4
	Z0tKDGCAI1O11DIM8o+XmrDMAVbb2ioKggogNfRojc753pqFYUXr5MrTgaw2zefD
	kmNxlQ+wh5L8TccaghR6vpSN+JnuzGcllhCFh/OUDZTOSvdwvBGAtM5GgRCRBn+w
	LOhSMtsu4bF7c863DtQHFEugRn1wZEV6So/7uIsXB9meTNRNp3hfpTEo2V3JPaR3
	9hS9dUtSmjqjjNlwhXrovzkbYyZpnT67+Ywa+EpGH0xdYXWLDDmhxBCYvySLymrZ
	kNMQHs7sjJC8oVE7lQZwAkYUbrrbw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4hht8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 13:20:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666DJabL014732;
	Mon, 6 Jul 2026 13:20:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h5m7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 13:20:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666DKPjB29360410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 13:20:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF23520040;
	Mon,  6 Jul 2026 13:20:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B225620043;
	Mon,  6 Jul 2026 13:20:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  6 Jul 2026 13:20:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
	id 9C0FC1615B4; Mon, 06 Jul 2026 15:20:25 +0200 (CEST)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2] vdpa/mlx5: Fix buffer length in create_direct_keys()
Date: Mon,  6 Jul 2026 15:20:23 +0200
Message-ID: <20260706132024.2871057-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0tVDV7V5mYwdsiiuchGiqAPj8K109x16
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzNiBTYWx0ZWRfX3kFyHIqK1v8S
 /Yb40+3+Gl2MScm5Kbvr3TMvq/nxZPbbRBI9Xw6zoJUHXHuhYjhKrtLaunWXss/t03bP1B9uRzq
 kxYUyd2akt7TqlPc9vCO4PzOEcA0WR9HgmyviYd5xytiEbFpS+m93u2hTm6D1C7pyQhNdGY0Hzh
 54wFWyF/cPJu282s3Hxzwa9jVwg/kzswfDUHKi1SKQzPvkeQ+dkAkqYrOpaDtgJA+TgrEpbKt1G
 rZkM+ZoKIpgiQOF8NxVayhj49p44+8oSNPp+JCRY3dkbg6uqm5MiI7ufp5i1sJ7JsHm6oR733/f
 0oYgrKRFK0awZd6PhwIvVtqYa3UTmijJgSjsX/Akx6fqXM95pqxZ/YcQcCNfMRjYOpd/ZH/1Y5Y
 +9d5pF3D7lPMJD0If0gNF6vJFGtXP+b58vijLIVWx7UgS6S1eyrB/Iilg84waQv/rjDDCOO+feM
 /u08yqbenfl9+VkHKRw==
X-Proofpoint-ORIG-GUID: 0tVDV7V5mYwdsiiuchGiqAPj8K109x16
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4bab9d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=vvbv4Sm7C4kpW9qWDK8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzNiBTYWx0ZWRfX+Ws69Fv8iV2W
 fOgeO6rdxpVaAyJihBRef5PVM70EU3a+FMfsZ3s+vml8EfIvjQajBKVPmtdH3zeGKWRKngNlQ+/
 MECgGOoQSvWZxvHumMpzV4Y3PPOXJLk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060136

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

Calculates the input size as sizeof(in) + size of the flex array to
match the pointer and allocation size.

Fixes: 0071b138d44a ("vdpa/mlx5: Create direct MKEYs in parallel")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
RFC->v2: use flex_array_size
 drivers/vdpa/mlx5/core/mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 6d02ccf9eb91..a3183a0c69c9 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -233,7 +233,8 @@ static int create_direct_keys(struct mlx5_vdpa_dev *m=
vdev, struct mlx5_vdpa_mr *
 		cmds[i].out =3D cmd_mem->out;
 		cmds[i].outlen =3D sizeof(cmd_mem->out);
 		cmds[i].in =3D cmd_mem->in;
-		cmds[i].inlen =3D struct_size(cmd_mem, mtt, mttcount);
+		cmds[i].inlen =3D sizeof(cmd_mem->in) +
+				flex_array_size(cmd_mem, mtt, mttcount);
=20
 		fill_create_direct_mr(mvdev, dmr, cmd_mem);
=20
--=20
2.53.0

