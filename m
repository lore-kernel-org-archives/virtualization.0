Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA5E37106A
	for <virtualization@lists.linux.dev>; Tue, 24 Feb 2026 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926804; cv=none; b=dAuGv9zOXlUbG9cm5PFHXa72ZGCp6CFiIXjT2nJNyEoPTWQb/yjNg2POF6ngjYGaeTxsvkDkJNAnMIdzMMedBfK3NkNlCWl7fBVSWd+cJulFR7sl0pMpdQE70K2/0+eGfH2IicV/nD981DQtanA9scDA/1LpPDR/QHIol6iv/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926804; c=relaxed/simple;
	bh=5iKn2Hz+faTEhE1s/UcpblXOrzoNUNl1ZX9P5OUPF+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDnrAyX14ZQjJJtsZLsQlrecBxpjJZh9S01R89yMCCtv0KUnV2/ulrJcl62yntu8Lunh5qB5h9pxv+LrLmrbc0j+zSx+M/+1DMVUuE+vxrY9skRoghoGSx+g1uB61O+sSQDfo4KhXdeYvurnwtX6tsMzK3TYS+8dqP7LyVLqePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hbMMZatv; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hbMMZatv"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O8gcw73270534;
	Tue, 24 Feb 2026 01:53:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
	Dk8Q1+khSqGPlaNPwAVzBzeOO7w8f6h+l5NvGMx6rs=; b=hbMMZatvNFhQCT28m
	+dV3isZ/1oWwzA5TFlaM3pRL1X9R4tjgFQqTNPsyhnOv9yYAJ2KDLRFHlBIU/zLV
	Z4IQqKI6lxpO8w88rcJbRpwpiSIiRkEr8avg3c2lc1tzlM5GWbg7RAWa4pj1MwTx
	1PyOF03YasinWb+W+q3ckC3ydov63mau0PdJtYo1joyYZxSmR59PZBaWyMRscB5J
	81p++mvCSQO2TXySqQAHUXNRU8djLS0088q02cmCFKNRsHSUJKd2kq1yBcFn6cQ4
	gvjFIN1lPNCnv8+MiYl+JARdMjtMpEvISycetNDSE5Kv8lDSoYFFBFPTtmQ5Dt6I
	E2qvw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cgd2mkpua-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 01:53:16 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Feb 2026 01:52:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Feb 2026 01:52:45 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id B8D573F70B6;
	Tue, 24 Feb 2026 01:52:42 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <virtualization@lists.linux.dev>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>, <linmq006@gmail.com>, <phasta@kernel.org>,
        <ndabilpuram@marvell.com>, <kshankar@marvell.com>,
        <vattunuru@marvell.com>, <schalla@marvell.com>
Subject: [PATCH 4/4] vdpa/octeon_ep: fix IRQ-to-ring mapping in interrupt handler
Date: Tue, 24 Feb 2026 15:22:26 +0530
Message-ID: <20260224095226.1001151-5-schalla@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=AfW83nXG c=1 sm=1 tr=0 ts=699d750c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=rU5BXW-GjRrihY5IRGgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 9OD3K8JRahs6GEdD92n5w11spuYnc3Qi
X-Proofpoint-GUID: 9OD3K8JRahs6GEdD92n5w11spuYnc3Qi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4MiBTYWx0ZWRfXymQAJF7+r3Vo
 JSnnM4TNEQD204ag5yERP1Bb2VD0On2eVWM/En4TthTrhlXd2h8J119vL9iG97yi7mZdHLMpYnD
 c9N7BE+yN/HACAS3DGh24UXAB4ZliPX/WvYSi2RIQxmPSd2KOx1whUKTCveCKf/hQb0sJqaL9xE
 zURfoi61Z8fKqJc7u9cybWHlf+0I3nSSfSz4dOrsgnvTzDTuEb8dY5IFKoW5bdZsNspTyN8BDXN
 ZpIb8+6s2xDTP5XZOk6jF3kgIoqGBxypIPzQV9QNYdGY718yhrshksGaFOGqaFXqMK7i+E5ygmu
 YVO5qlx50lXzSWsAlEJYqc0bC9yxeLDs7Bs+vnPytKWmQxqVTBFpAYEkrAclaoDWJcGfN4L8dJ+
 Rt/8lAQS3P9MJZpcU88qYS1ITfE5E3KqutJvcVICRlkCgT/B4sgK2yvIR1B5XiLwPZ/jtYCCT0p
 dsogwIwNbwM9eDJadKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01

Look up the IRQ index in oct_hw->irqs instead of assuming
irq - irqs[0]. This supports non-contiguous IRQ numbers and
avoids incorrect ring indexing when irqs[0] is not the base.

Fixes: 26f8ce06af64 ("vdpa/octeon_ep: enable support for multiple interrupts per device")
Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 5b9d76632376..5b35993750f5 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -77,7 +77,7 @@ static irqreturn_t octep_vdpa_dev_event_handler(int irq, void *data)
 static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
 {
 	struct octep_hw *oct_hw = data;
-	int i;
+	int i, start_ring_idx = -1;
 
 	/* Each device has multiple interrupts (nb_irqs) shared among rings
 	 * (nr_vring). Device interrupts are mapped to the rings in a
@@ -90,7 +90,16 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
 	 * 7 -> 7, 15, 23, 31, 39, 47, 55, 63;
 	 */
 
-	for (i = irq - oct_hw->irqs[0]; i < oct_hw->nr_vring; i += oct_hw->nb_irqs) {
+	for (i = 0; i < oct_hw->nb_irqs; i++) {
+		if (oct_hw->irqs[i] == irq) {
+			start_ring_idx = i;
+			break;
+		}
+	}
+	if (start_ring_idx == -1)
+		return IRQ_NONE;
+
+	for (i = start_ring_idx; i < oct_hw->nr_vring; i += oct_hw->nb_irqs) {
 		if (ioread8(oct_hw->vqs[i].cb_notify_addr)) {
 			/* Acknowledge the per ring notification to the device */
 			iowrite8(0, oct_hw->vqs[i].cb_notify_addr);
-- 
2.25.1

