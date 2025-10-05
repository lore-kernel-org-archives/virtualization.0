Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BF26ACB
	for <virtualization@lists.linux.dev>; Sun,  5 Oct 2025 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759687970; cv=none; b=r3bTKrb6cEsf+5sxNgy09P7bpl0d4LgG2MZPj0qB7pkrcFXDnVfBXee9GycMlN5a5H3mq6wbY5EstnI3i2yC4blFlgN8wmGFZv58tmCXpNghVupoHkMVe6RIUszf64y6P45JXFWhsHTLF82Dfx3L9G2N3wnGjdcqXlYuGwG4848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759687970; c=relaxed/simple;
	bh=N3KEX9yMfDskK1jzwp3R8XS991ozbyb1KWcGozNRcQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEACQ5qOm2wZfgTGVaamQLajTNZXqdEQktju7RGx2hOj/BUwqktdYFfeU9e9+oUQzlKj7/zJVkp2rUhEtP5sMMv6BROUUl+gMmCXSG3jK1MJUfHhVrvp1HQhSd6elVLaHXRYk9v8JyJJMMIWFyEemrWY48JDC0LauSe4KM/ABa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=coy51G+6; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="coy51G+6"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595HOS9O029328;
	Sun, 5 Oct 2025 18:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=VAryTyAJu9KZaSYEcp5AUrvC36hG8
	7ym/EbK85YtUck=; b=coy51G+6/D0iGPmOLkETZQIXnTLU0iu3Qk+qXOvWQ7wZt
	5m4sWwU6p1DnBvl2ONzI67O+oK+I5TjGY9nbKQxLapj2ZYDuUt49crY+G41PDxGU
	9U1GQ3LdpCwn+g0zo8H7QpKZbzVlm7TNdr5L2ba4BIbUi5TuCW+ra4l7y682MYSY
	HhYPMPk3m765Em+htWqp6VJg2g3CVzQB7KI98SleyrCdEifi9JzP3Is2AlpcZ85+
	duHlIXE2+zdw5/+nx8THgWo0E6jDvIrA9dIUOrLXITDYjuS4a4WrWNJEI/WzFQdc
	D8NPTXkoBMohddeBYXZBotHb3imHpUyTUEnpq8dDA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49kvtwr0tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 Oct 2025 18:12:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 595H01JI035081;
	Sun, 5 Oct 2025 18:12:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49kdp2q6f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 Oct 2025 18:12:36 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 595ICZ3W020065;
	Sun, 5 Oct 2025 18:12:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49kdp2q6ex-1;
	Sun, 05 Oct 2025 18:12:35 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: eperezma@redhat.com, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio_vdpa: fix misleading return in void function
Date: Sun,  5 Oct 2025 11:12:29 -0700
Message-ID: <20251005181232.3320977-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510050156
X-Proofpoint-ORIG-GUID: OkDpaI_kCMkJMe5z2KVg-QCHDlRmuvUi
X-Authority-Analysis: v=2.4 cv=dprWylg4 c=1 sm=1 tr=0 ts=68e2b515 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=Cu5L_QzEE98FA8FmBg8A:9 cc=ntf
 awl=host:12092
X-Proofpoint-GUID: OkDpaI_kCMkJMe5z2KVg-QCHDlRmuvUi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA1MDE0NyBTYWx0ZWRfX5+r1vcXv7fiB
 LYr7Uq2Eu1sqyDFJURQoL8d25SGwts4laqJ6sBibKD684vmYpATfo5S0KxEAZYkY6KzyedzCuKp
 IKAAMIBHugs7073BSH5kL9Im1CE4d+0D14NHgnvuXKbxoZfWrd9Ce425EFOuuAy12Naa9RwX96q
 TAJc+ze2VGRKt4n9PSV+r6vUmCvMjCMX0YOglgrhQcJWBFGMmompEu4SzxSJqrZq59iyFR8d9i6
 En0ZlFdXwP6n/H7m5JyoaR4nrX6/4Oc8LczcjlrA7j0CLmclBfAjZyrro1rPMmj2uCYGSysyVRN
 6tEdrJm4w01lbJnK/UFtSEzbHiB2iPw5EIfNnshXegpN52HWZtMTU8Sg4Gvo+OFdnFGYG/OGmhA
 jbFAfP1OnwfKREQOJTfvQXShfUjIsJMedGTVisgEh/FScD+UP6I=

virtio_vdpa_set_status() is declared as returning void, but it used
"return vdpa_set_status()" Since vdpa_set_status() also returns
void, the return statement is unnecessary and misleading.
Remove it.

Fixes: c043b4a8cf3b ("virtio: introduce a vDPA based transport")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 -> v2
added fixes tag
---
 drivers/virtio/virtio_vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 657b07a60788..1abecaf76465 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -80,7 +80,7 @@ static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 
-	return vdpa_set_status(vdpa, status);
+	vdpa_set_status(vdpa, status);
 }
 
 static void virtio_vdpa_reset(struct virtio_device *vdev)
-- 
2.50.1

