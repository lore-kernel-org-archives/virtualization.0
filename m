Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E032536EABA
	for <virtualization@lists.linux.dev>; Tue, 24 Feb 2026 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926838; cv=none; b=QJwVy5x1kh8jJH8QvvPLIYtWFsiJoCblvxS1MF/lA42XDPT4jqwUy57+/gVSqTkzGOQqOWk0EB0kjbLCkFOdN6K5DbvkMYQljByVKENDzdRE7ZqxQuKXES50XfGshhWWDVzDZhXLEo2YYhN+cTiHil1eEGO4tRpuAWU9L+g3Mv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926838; c=relaxed/simple;
	bh=upPFwJGKGCxD1WBcT+EBWkQA383jKER81hlsysUwWlc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kn0O+toSJTSMnbztXCcCPS7+AeXaFjYZb/UZN32oPfp5TCwyFIVvegSKQDfXXrQEwbRwnQJSm4lBu/3ZTsVCvx9XM9+BlmJ8RXpv+YlsHccHGJZ2BqP9edHjeYXUkPlaeYTACjIV/l8HBzq/3/hSo/57/ooa2Om4GlO47rqIyGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PtyKLt91; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PtyKLt91"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O8kUPF2124077;
	Tue, 24 Feb 2026 01:53:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
	hRjdyx9tPRx3iudGSEYOaLlVSA5Mepbuevj8/N7MFc=; b=PtyKLt915cSvSrLjK
	Yel2/uwnNCVR/D63LkqY+7if/YO+hAnjpvzlyoYQYIQ97za0xYbfMSFUd7R1t8IC
	k0W+JIzM/L4zGoxBAraTa5gwLYN6qQQddl83pocKSK9Lwht0gjJVuEvduB/oKDnz
	dWQm3i2I/tliLDEXqj9DKbg4andH4v4EpLxWU7BTQEfuQW/UJD+EGqzlnTcXIXsg
	7Q0AHPDimt/YHa2SOnEjb74TqlC+WiOU3urYnvFj7HkU8UH3OC1yRI/5klT6xAdE
	Ja/z2N/KRt56MOuLfae41e50liFMTa0FAiWjbU/FVZi8Y9HvVojmkRuM7XnAvsi6
	BMmKQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cfd3gwk1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 01:53:47 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Feb 2026 01:52:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Feb 2026 01:52:34 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id BB50C3F70B6;
	Tue, 24 Feb 2026 01:52:31 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <virtualization@lists.linux.dev>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>, <linmq006@gmail.com>, <phasta@kernel.org>,
        <ndabilpuram@marvell.com>, <kshankar@marvell.com>,
        <vattunuru@marvell.com>, <schalla@marvell.com>
Subject: [PATCH 1/4] vdpa/octeon_ep: Fix PF->VF mailbox data address calculation
Date: Tue, 24 Feb 2026 15:22:23 +0530
Message-ID: <20260224095226.1001151-2-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260224095226.1001151-1-schalla@marvell.com>
References: <20260224095226.1001151-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yyNR2Co90Amw4TT8fyHY7rCleFYAOnPD
X-Proofpoint-GUID: yyNR2Co90Amw4TT8fyHY7rCleFYAOnPD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4MiBTYWx0ZWRfX+Oa7z3sJPXV3
 SJ+dxkZ/F5pwqMLbdCrEXLZDwwqnX6L8T8bZVS7nvAFbwsWunlZJG2t86hrlfwws4CWB1b8RSOQ
 NfjOsKtRixHooGLFMNeHHJAVZVOiA3KWaIE6K3m50+8qWo3BKbGrGrqEQKZCJ3gydTbsh66pyls
 SQxFAGvZTbbgN9+OYkCf0aB8wBFmhP17WfuQ11sqS+Hnb3z5ZWy0vzXXwZHoJ8pLXlM6MOZutzY
 9WxiTqbKaqAtYxOOQfas6naIXjzPjZ28O64ulssscYXmLmDku7LvzPDlMvdxlU2Uc58FP0RGHlz
 RMFaBHNWB84sP50RPOfMEs5s+4EmA6TXctMMSrb9W0wwZLDbGtStSivxGV4QRR9/Xa+zrZNQUoZ
 4fCbT5WzxDq9Lg3XNq6GduQQ56RXYqSYRKwNDrDGjZuUuoXk5RYsR8TVi70aK+F5zo0nsfyXOc/
 Fcz1inZbRvgdNYm3fgQ==
X-Authority-Analysis: v=2.4 cv=H5XWAuYi c=1 sm=1 tr=0 ts=699d752b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=XbkK2ErJkp5ICG_XLMEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01

The mailbox address was computed assuming 1 ring per VF. Read the
actual rings-per-VF from OCTEP_EPF_RINFO and use it when calculating
OCTEP_PF_MBOX_DATA offsets, fixing VF initialization when rings
per VF > 1.

Fixes: 8b6c724cdab8 ("virtio: vdpa: vDPA driver for Marvell OCTEON DPU devices")
Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 31a02e7fd7f2..9946480ee704 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2024 Marvell. */
 
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/module.h>
@@ -722,6 +723,8 @@ static int octep_sriov_enable(struct pci_dev *pdev, int num_vfs)
 	bool done = false;
 	int index = 0;
 	int ret, i;
+	u8 rpvf;
+	u64 val;
 
 	ret = pci_enable_sriov(pdev, num_vfs);
 	if (ret)
@@ -741,9 +744,11 @@ static int octep_sriov_enable(struct pci_dev *pdev, int num_vfs)
 		}
 	}
 
+	val = readq(addr + OCTEP_EPF_RINFO(0));
+	rpvf = FIELD_GET(GENMASK_ULL(35, 32), val);
 	if (done) {
 		for (i = 0; i < pf->enabled_vfs; i++)
-			writeq(OCTEP_DEV_READY_SIGNATURE, addr + OCTEP_PF_MBOX_DATA(i));
+			writeq(OCTEP_DEV_READY_SIGNATURE, addr + OCTEP_PF_MBOX_DATA(i * rpvf));
 	}
 
 	return num_vfs;
-- 
2.25.1

