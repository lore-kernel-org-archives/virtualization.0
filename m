Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2D0184
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785691695; cv=none; b=c0ablcvXds3vbM+dN5QPxST1VLCzRK9DhW9y+dCUA5L/ezQetAysKpDfsKqVBAn911gTvdWClWZluvoVBXaoYV31bTKlRs6Fmn8A23SvoR4cC2DazCuIfDp2dg4BFhX2bUBbNIrJxWPIQH1NJfNRE2VnQQpaQ1K7HQouGWeLHrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785691695; c=relaxed/simple;
	bh=+HiQhT47ZMOqVgmEnA+WqPwCj1BNDoqtSphAip/m3BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPJdZLjTieIjlrzu+7E6kDaag7VW6HS5VYS2udhYz/djQiYKGqEgI7cbcVByAtwdnEHSGAKTVNX9cpNxTjoXQHVzD2q87jVan9LrS4CyvJZ/XgOkBENMd7mXD2/C9hOobh9thgNH1tO+lC7/scK8fqlhmN8ZJBn+uPPICe1EJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SKtdmEeA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SKtdmEeA"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672GjVhO789840;
	Sun, 2 Aug 2026 17:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=uN1bD
	Lqd+HScH5QnQLhTxJvNWIG09vu3n0FNQ1Ow9yw=; b=SKtdmEeAmw9TOTQ4lZjAm
	30Ed53o7Ntet2R2w2YF1JGjk0Tq8SUuTE9HgzNYf0tZemv5XIGTDeR3MYSP9QBVA
	4gzl318UnYIWjpjWYIZ6JroaGaMo2jhuMJhpXDn1g0bh1jOua6h9mnnvOaTlpgUz
	E9wDLxEX30SKZuw8el9sX5KuBTrQQYyf8BBAas997ti3/4hHn4ITBdxTgNliWS97
	xomO+0BPtobT8tnlZBcOdb70iQ2/ereW6m3uSs3wyGEx4npvKFIWAUnyJTMFcl09
	GotBUskkOLW4V53ZTtKYbHV4Nk3gHr4M/3gfGzihmtadXqokapgM+EBcw9n6kPk8
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7cy330u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Aug 2026 17:28:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 672HPphD027820;
	Sun, 2 Aug 2026 17:28:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78r0h79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Aug 2026 17:28:11 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 672HS8PG032953;
	Sun, 2 Aug 2026 17:28:10 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fs78r0h6r-3;
	Sun, 02 Aug 2026 17:28:10 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowangio@gmail.com, michael.christie@oracle.com,
        pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
        kvm@vger.kernel.org, joe.jin@oracle.com
Subject: [PATCH v2 2/2] vhost-scsi: clamp max_io_vqs module parameter
Date: Sun,  2 Aug 2026 10:24:56 -0700
Message-ID: <20260802172534.260047-3-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260802172534.260047-1-dongli.zhang@oracle.com>
References: <20260802172534.260047-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608020159
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1OSBTYWx0ZWRfX5PNtWJacEs1j
 CCnR8hqFR+zvCOHguZkPLrjxGw484VcgKCqoJ9yLyiTz7QjrPsy+xZj5nv8gpOSMUpObxtbOSFU
 sDsiR5Fm74jSokfBgtOQUxNvE55KA9DyKYJBaN3EMCSGhCJj13G/
X-Proofpoint-ORIG-GUID: 6AMEKKMxW3dFKw9c1UVNGPsHSjlibQwa
X-Proofpoint-GUID: 6AMEKKMxW3dFKw9c1UVNGPsHSjlibQwa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1OSBTYWx0ZWRfXzCwwLevkVApg
 qVBaZjBhaKyMsTgRkkfR/xW9V21S/eCI5Q490Z/hXRBB880ZCzrvp2uZv4YRhMPQi1EgXfd9OUw
 NBiJNjdNylFAXZiSq0wAAziPRtXb2Ug733AYMby4AnlpkMJIyZsgVaTXl7op9Kx16EKyrUwWwdp
 O7QfsBTJVl033Oh/4zJfcszFze438TGz17gg83bCGBbSk0lOaMDMkF0C34hauAHhp9qkIrulIv+
 GI7Wk99qfTetZuVSPXmc41WIPncWPIlzEnBXNEkiyN7krVy/5Ur6kfnAAy1rXXd0E+1uNZ0epg7
 R8wYjQcZ4o4ntj8KHwj7vZb231s4AaP2kjt5swhh8r67AqVVSe3omrX9cqKQbdpnkIA5fc9liwx
 jphh5IZnzG6l2J2fMeJ4zlmncdopSWQC6k5GUI0YEu83H/IyDaCRayAUEcfr/c3EiAP16BH7rmL
 CX7Q9tVxzistPjypxRNfDqXgZT2Z2+q0jHNsMcuw=
X-Authority-Analysis: v=2.4 cv=TsPWQjXh c=1 sm=1 tr=0 ts=6a6f7e2c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=Xp5TNOvvSn1DBsKdsM8A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13517

max_io_vqs is currently validated only when a vhost-scsi device is opened.
This allows sysfs to show values larger than the driver will actually use,
e.g. writing 2048 succeeds even though vhost_scsi_open() later clamps it to
VHOST_SCSI_MAX_IO_VQ. This makes the sysfs value differ from the value that
will actually be used.

hv# echo 2048 > /sys/module/vhost_scsi/parameters/max_io_vqs

hv# cat /sys/module/vhost_scsi/parameters/max_io_vqs
2048

[  315.630495] Invalid max_io_vqs of 2048. Using 1024.

Keep accepting out-of-range values for compatibility, but clamp them in the
module parameter setter and store the effective value. This preserves the
existing behavior that invalid values do not make module loading or sysfs
writes fail. It also makes reads report the value that will actually be
used.

With the parameter value kept in range, remove the duplicate validation
from vhost_scsi_open().

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
v1->v2:
  - Access vhost_scsi_max_io_vqs with READ_ONCE().
  - Clamp out-of-range max_io_vqs values instead of rejecting them.

 drivers/vhost/scsi.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 0c0634eea144..fb262cf9a34d 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -210,7 +210,37 @@ static const int vhost_scsi_bits[] = {
 #define VHOST_SCSI_MAX_EVENT	128
 
 static unsigned vhost_scsi_max_io_vqs = 128;
-module_param_named(max_io_vqs, vhost_scsi_max_io_vqs, uint, 0644);
+
+static int vhost_scsi_set_max_io_vqs(const char *val,
+				     const struct kernel_param *kp)
+{
+	unsigned int max_io_vqs;
+	int ret;
+
+	ret = kstrtouint(val, 0, &max_io_vqs);
+	if (ret)
+		return ret;
+
+	if (max_io_vqs > VHOST_SCSI_MAX_IO_VQ) {
+		pr_err("Invalid max_io_vqs of %u. Using %u.\n",
+		       max_io_vqs, VHOST_SCSI_MAX_IO_VQ);
+		max_io_vqs = VHOST_SCSI_MAX_IO_VQ;
+	} else if (!max_io_vqs) {
+		pr_err("Invalid max_io_vqs of 0. Using 1.\n");
+		max_io_vqs = 1;
+	}
+
+	WRITE_ONCE(vhost_scsi_max_io_vqs, max_io_vqs);
+	return 0;
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
@@ -2273,21 +2303,14 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
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
+	nvqs = READ_ONCE(vhost_scsi_max_io_vqs);
 	nvqs += VHOST_SCSI_VQ_IO;
 
 	vs->old_inflight = kmalloc_objs(*vs->old_inflight, nvqs,
-- 
2.43.5

