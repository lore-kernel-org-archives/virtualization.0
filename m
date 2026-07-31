Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B02E5B21
	for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536020; cv=none; b=RxUx37ZCRrVeAWhyKbSfKa4UnayFWJTDdrlCuGtroVTuFNWZ6vOqfSIQXnPMTfiVTQlCJjnIp5YjJiwtNeLvn8ne78VB2qV0AVIk5pzgoR2RamBFCuE8SbN4GXRHaPeF+q+IHcNEM4OhwMjCALMpp6qijGna/vQMrz4p3g0Fq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536020; c=relaxed/simple;
	bh=LZr6Rq3+sRw/jpg5qBUv5dtZv1XugAnfzq1Sapd+fkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQQxj17LubfsLxdrqsu6mTgIdTJPqz4CruPWQdRXjwPvsns0nuxyWcn48Og/K0xj6m/i2ZsUO/JaQqAwyxqMVxTd3zVkWDGIWk70X4kAlr86/DVw7YJodNdJkC6zGADdSIA2XJdv5IRirApnyZoYWPkmnrpuP/vBFOLXUWPSRRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vn89MTic; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vn89MTic"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VJtXZs333101;
	Fri, 31 Jul 2026 22:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=v9cJp
	qb9T3ZRbaEmCERPAxNMMXVZGWcvB56I78v/cCw=; b=Vn89MTicf1rkpDEf03xhN
	NCb5eCs1fCkFeKJav5WGKTxQRIdnYy1xOHrzHNkAKJHs8skT6ddN0wOHeU4Fqq2Q
	hRAjd2+Q+QC75RfQLyyam/wGEhdEdXRWRekQXgciGV6ceUxgC1e3kGeNEQBkDEQt
	m/QcpaECP2X6kS+t+3zlF6wXhkjQnnPv2unhWIAWr1kumunTJV7hMWWLNTrq2yNG
	VLROO65BGQBku/0Mw46ehotnVfbaV6B6ZXETfhMLleIHRR1YAGzz2Yio+XX+IGKv
	7RmI/+V687nmDNPTK6NH5uh95m6ckqejfi3HxsHupWxSN2oBooAzkLcvryNcKIEf
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr1dm77u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 22:13:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66VMA5Wo007514;
	Fri, 31 Jul 2026 22:13:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fnheq8a9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 22:13:37 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66VMDZB9018145;
	Fri, 31 Jul 2026 22:13:36 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4fnheq8a8s-3;
	Fri, 31 Jul 2026 22:13:36 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowangio@gmail.com, michael.christie@oracle.com,
        pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
        kvm@vger.kernel.org, joe.jin@oracle.com
Subject: [PATCH 2/2] vhost-scsi: reject invalid max_io_vqs module parameter
Date: Fri, 31 Jul 2026 15:10:24 -0700
Message-ID: <20260731221116.236791-3-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260731221116.236791-1-dongli.zhang@oracle.com>
References: <20260731221116.236791-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607310167
X-Proofpoint-GUID: YmREneOD-9A2ohACfUON62VFTAUFpQ2C
X-Authority-Analysis: v=2.4 cv=Y8fIdBeN c=1 sm=1 tr=0 ts=6a6d1e12 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=maETerZRP1bNTAtRvowA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE2NyBTYWx0ZWRfX+wfR6YdvlMxj
 JFg4qMOdR4JsgcVJTHpTrc5EO/wtHoXCtMGoiQhKfrQgVjYslAB3DxUg6U6p8PN25I06RSAeMWX
 RBLIbX3QFRmCvW6B1BwWRdH63X6T11uOd5kBnLaz/mLeSJBij0uy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE2NyBTYWx0ZWRfX+bY35HgDZRl9
 k440yrBwbfb1dKs7i1URiimidTbALHJFSUfo1PHbmB2reMVzZ46/7OHvflbTAAuDy/VwU3yuuw5
 lIC8LUc75jGPaviyFVhcZ5jRZ14YNyLuyhuZWvgRrdGvw2wRJ2UYJPt1RwOwBIOQUwN9c0zExnN
 GSHD4ocGlmmkpf8FVOg5PwL55WspNPZR2HuYz31HLR5MuvCGERpM1sygFzUwA6ywCYQY+JqtA5u
 WoC88gxpOXNbe/aI7NruFHE3T5B6kh/kIClNg0fDU05TePllYxjpI5w+NvD0rr+QykXB7bAvQEm
 FDa8UYoqRHmJ7ZNzJtACnnrCR+wz84rXgUHfGcX3PDiXTpIRqiCXGoV6eud8uUohXDOXDddlAph
 /mtCpPobdGTXSiooblk4to7ssAD+yzhutr2mgnMNRjvvWWI220ZuUFjDns8uK1fANHnxCw5kMZ2
 M30wgra48sC9aFpT5Ag==
X-Proofpoint-ORIG-GUID: YmREneOD-9A2ohACfUON62VFTAUFpQ2C

max_io_vqs is currently validated only when a vhost-scsi device is opened.
This allows sysfs to show values larger than the driver will actually use,
e.g. writing 2048 succeeds even though vhost_scsi_open() later clamps it to
VHOST_SCSI_MAX_IO_VQ. This makes the sysfs value differ from the value that
will actually be used.

hv# echo 2048 > /sys/module/vhost_scsi/parameters/max_io_vqs

hv# cat /sys/module/vhost_scsi/parameters/max_io_vqs
2048

[  315.630495] Invalid max_io_vqs of 2048. Using 1024.

Use a module parameter callback to reject out-of-range updates when the
parameter is written. This keeps the visible parameter value consistent
with the effective queue limit.

With the parameter value kept in range, remove the duplicate validation
from vhost_scsi_open().

Invalid values now fail with -EINVAL at write/load time instead of being
accepted and silently adjusted later when the device is opened.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/vhost/scsi.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 0c0634eea144..c138c29ce3dd 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -210,7 +210,20 @@ static const int vhost_scsi_bits[] = {
 #define VHOST_SCSI_MAX_EVENT	128
 
 static unsigned vhost_scsi_max_io_vqs = 128;
-module_param_named(max_io_vqs, vhost_scsi_max_io_vqs, uint, 0644);
+
+static int vhost_scsi_set_max_io_vqs(const char *val,
+				     const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 1, VHOST_SCSI_MAX_IO_VQ);
+}
+
+static const struct kernel_param_ops vhost_scsi_max_io_vqs_op = {
+	.set = vhost_scsi_set_max_io_vqs,
+	.get = param_get_uint,
+};
+
+module_param_cb(max_io_vqs, &vhost_scsi_max_io_vqs_op,
+		&vhost_scsi_max_io_vqs, 0644);
 MODULE_PARM_DESC(max_io_vqs, "Set the max number of IO virtqueues a vhost scsi device can support. The default is 128. The max is 1024.");
 
 struct vhost_scsi_virtqueue {
@@ -2273,22 +2286,14 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	struct vhost_scsi_virtqueue *svq;
 	struct vhost_scsi *vs;
 	struct vhost_virtqueue **vqs;
-	int r = -ENOMEM, i, nvqs = vhost_scsi_max_io_vqs;
+	int r = -ENOMEM, i, nvqs;
 
 	vs = kvzalloc_obj(*vs);
 	if (!vs)
 		goto err_vs;
 	vs->inline_sg_cnt = vhost_scsi_inline_sg_cnt;
 
-	if (nvqs > VHOST_SCSI_MAX_IO_VQ) {
-		pr_err("Invalid max_io_vqs of %d. Using %d.\n", nvqs,
-		       VHOST_SCSI_MAX_IO_VQ);
-		nvqs = VHOST_SCSI_MAX_IO_VQ;
-	} else if (nvqs == 0) {
-		pr_err("Invalid max_io_vqs of %d. Using 1.\n", nvqs);
-		nvqs = 1;
-	}
-	nvqs += VHOST_SCSI_VQ_IO;
+	nvqs = vhost_scsi_max_io_vqs + VHOST_SCSI_VQ_IO;
 
 	vs->old_inflight = kmalloc_objs(*vs->old_inflight, nvqs,
 					GFP_KERNEL | __GFP_ZERO);
-- 
2.43.5

