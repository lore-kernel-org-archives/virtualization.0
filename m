Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3D36D50A
	for <virtualization@lists.linux.dev>; Tue, 24 Feb 2026 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926768; cv=none; b=P9MEnf0gpNiYSoNJupGp6cse4BuO1kDV9BQIsdO614ZpzbLe2brfAfQW/BDvRDrrkiWRl82ZmdUdi1cI2kLAOF8xvv1q1NTMezZNYgK/SIxBQf6orBG//N2/P5p/3VAq41IlxIU6wD7vEXKuLS/t9igj1CrsYmK1jCawMiIEjBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926768; c=relaxed/simple;
	bh=2a8WDBZR5KDNmM6X3pDrDNqYQs8Sy1pjTkGzxnM9bHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZ0et1jCsOvvPfYYDzMCNVFk2DlNEAuco/p4RPAHYjzEvlEx0haqeax+7D3lTSidLQ6NEKPhbPzGtUR2uQ8Uso20oQIWY15cQ0Gj3jtFKmm++jaGb51zH35DAT4qNg5L75CL6dvHK5e0SwslLz4yTpNCpvsOxVh97oWHmp0lsFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dEGZNJrI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dEGZNJrI"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O98bGK3271580;
	Tue, 24 Feb 2026 01:52:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
	bJSxVitp90T/7VGe3nNE/cdDaICjkqDD0oL8RNYCdc=; b=dEGZNJrIwuuCB9Mli
	4ex8gMACPX07U62vsYyYc/U8HSnHgnp25wfEDkbNc+uOhoyFMNbewnnH4s/6Ejc+
	XQOjd6LPsM8xJB9YpBxQZufR7A1CtHQPL6OlRCbAnM7otXwRXq/SBS7kJegFAGvJ
	lqlnuGczO/D587G2OfWYVorKa76FGDr3Ww0DOTn+ziaEM2o28P3mN6vxflET6Ed2
	4od8+q1/FZ9Hma8hyivdP3jvJ+yPSgvx4hHvQJ9CFv2zGRtUocjyDWTQQj2a7qwf
	QeRM7mBofForL8njEWysM2xJ6fK54YaKFEYdomM3eGQFrHXhgaERijYMJSVQxrOI
	MNNEQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cgd2mkptj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 01:52:39 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Feb 2026 01:52:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Feb 2026 01:52:38 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 64BCC3F70B6;
	Tue, 24 Feb 2026 01:52:35 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <virtualization@lists.linux.dev>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>, <linmq006@gmail.com>, <phasta@kernel.org>,
        <ndabilpuram@marvell.com>, <kshankar@marvell.com>,
        <vattunuru@marvell.com>, <schalla@marvell.com>
Subject: [PATCH 2/4] vdpa/octeon_ep: Use 4 bytes for mailbox signature
Date: Tue, 24 Feb 2026 15:22:24 +0530
Message-ID: <20260224095226.1001151-3-schalla@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=AfW83nXG c=1 sm=1 tr=0 ts=699d74e7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=APY_GE_lVc1rrekASW0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ueYujL2WCzq8JySuMxOnuXURNPXD5jWA
X-Proofpoint-GUID: ueYujL2WCzq8JySuMxOnuXURNPXD5jWA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4MiBTYWx0ZWRfX0Cvi72c/DiBP
 6/iVespWXOnNcGMdUafi5G22OwwodT1Uxc5120c91UQTq1JvauvGy3I5r1+RiseP+1fQb4RPVie
 RBTaaEluc3iCFLae47o3eiT+LuAxjBmOXckjJx0ONwapyP9FdPtOx8D3FTp9FARpNMaRQC2GTCQ
 /FFow1M949lqR3ydGfTf+f5k/V81eoOoXFOG8WHHsSAqC40WQfc5oBpvkVodowSYudCF2v9wANZ
 WkKFhFTTSzFYmh+LBekYZkq38PpIPocA26rxf18/tRY38wGmosrPjUTKYx8Q0qCYmUdiQCx2kNZ
 oQI+K4Qnr8fvRXxXvlvpOuq3ey76XM3AwU/Wgys9+F4inQcixSy5cRP22vWUn42aHNwNxJNNT75
 qVKtNxzA/XLD/Lox0kq2EmQjaHwssyNjnYjpxwiJ/kx0xuKzrLJJhrv1g32P/H3eY1JRcSG1t5s
 uNWG3hrgB1HsM2WQMGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01

From: Vamsi Attunuru <vattunuru@marvell.com>

The upper 4 bytes are reserved by the firmware for
storing meta data. Use only lower 4 bytes to update
the signature details.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 9946480ee704..deaa8dc7813e 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -573,10 +573,10 @@ static const struct vdpa_mgmtdev_ops octep_vdpa_mgmt_dev_ops = {
 
 static bool get_device_ready_status(u8 __iomem *addr)
 {
-	u64 signature = readq(addr + OCTEP_VF_MBOX_DATA(0));
+	u32 signature = readl(addr + OCTEP_VF_MBOX_DATA(0));
 
 	if (signature == OCTEP_DEV_READY_SIGNATURE) {
-		writeq(0, addr + OCTEP_VF_MBOX_DATA(0));
+		writel(0, addr + OCTEP_VF_MBOX_DATA(0));
 		return true;
 	}
 
@@ -748,7 +748,7 @@ static int octep_sriov_enable(struct pci_dev *pdev, int num_vfs)
 	rpvf = FIELD_GET(GENMASK_ULL(35, 32), val);
 	if (done) {
 		for (i = 0; i < pf->enabled_vfs; i++)
-			writeq(OCTEP_DEV_READY_SIGNATURE, addr + OCTEP_PF_MBOX_DATA(i * rpvf));
+			writel(OCTEP_DEV_READY_SIGNATURE, addr + OCTEP_PF_MBOX_DATA(i * rpvf));
 	}
 
 	return num_vfs;
-- 
2.25.1

