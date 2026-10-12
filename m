Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED62F4252D1
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835112; cv=none; b=TKRT1bS7Z7GfVIBb2shEe1uv51yXq0RA1gsd0tOMnPtOIfdXbfX5c6NVt6d9nLf3BxskxsoABVfhZr/i2LThnbyxOihe4Z/7nEPe06xWce2zYwmgbaMreKLy2J8jBzFGsmMCfjy9K+6V16Ma2nF3x3Pg68KW10OPIJioF0tHwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835112; c=relaxed/simple;
	bh=LHDpUqoIUY73agKLC0JPTYyrCYH/uP7gZDbQ0lKiftQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=GvbDZz6IDunUNTbZC3U9hU0cMzvtvGIHKuwpFIUw96tCfuKGrvwyWSx75suLFTKg/OavBjJnzYdbcwe6T/3x+kutfk5ufq39x1Dm1hZojSm/WF6nRmzZx1ImmrjmyGKMWqMdH2d+OvYbIqoFWLrpj4xm/yxLA9/0NlxvAEafVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NkIVWrnF; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NkIVWrnF"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJO5Ms1953201;
	Mon, 12 Oct 2026 12:58:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=aySQG+wpA
	fhuaLrRAC0TXgBqWFy64W/qu6r3MZnQmOs=; b=NkIVWrnF9Mo0Ah2iHKueG4WqA
	ANIMpNOtxzQLT1j7FxRmsjh+SyePN/OigIKb9u8B33p/Q/LHDQeDhT1VyZ6VSbTh
	9gzDnRovggCx8636rYKqXQ+6eKUBd//9wi9gMMPSFsSoGIv2wt7giTinkUcVvUJN
	tNSu9mzPiSxG22soSp2kQmG5JXhbfQSFO7BkaplLt5l8km48yl+nyh8zwzipqxBc
	X7QNhTHpf+62plkFXlCPRpPoQXMbo4XLrrMVMzywVjnuJdwzFgtVjjU3KzISdQut
	GABUr/iBOOnoAgG2JR9KlJSGFSLAy/UNoRvf6bnThjsEaelkVII7G4pFdqyJg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h89yjsmk0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Oct 2026 12:58:27 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Mon, 12 Oct
 2026 19:58:27 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Date: Mon, 12 Oct 2026 12:58:08 -0700
Subject: [PATCH net] MAINTAINERS: add Bobby Eshleman as vsock reviewer
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
X-B4-Tracking: v=1; b=H4sIANA7zWoC/x3MwQmAMAwF0FXCP1uwPRTpKuIh2qg5GKUVEcTdB
 d8A70GVolKR6EGRS6vuhkS+IUwr2yJOMxIhtCH61gfHObuN1U5Wk1LdOEXpOM4cuxEN4Sgy6/2
 PPUxODO/7AaLHUMtmAAAA
X-Change-ID: 20261012-add-maintainers-bc6e8a6fa68b
To: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <kvm@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet
	<edumazet@kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael
 S. Tsirkin" <mst@redhat.com>, <linux-kernel@vger.kernel.org>,
        Bobby Eshleman
	<bobbyeshleman@gmail.com>
CC: Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 30UUzFJCRlRT9JyEHzj6nT4uM6MJ5sDW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA3OSBTYWx0ZWRfX1xOF1rEgGnxV
 Rg50UoHUwXKcQwh9pig03bdolJX6KqA3wCXyaCbzREHr1mqpL6d7mZee+8AMXjMc+zrFwz5+/ON
 TujjMjOMFoax8UiCDEgkQ0N0W7hJvu0=
X-Authority-Analysis: v=2.4 cv=YaUodARf c=1 sm=1 tr=0 ts=6acd3be3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=YPFdDlkatZT_ntEAilkA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA3OSBTYWx0ZWRfXy7ZpZF9Ocwzf
 FePX7xoY9jPRXtsanQ0ZHyAcnidYMUBQSiIAY9lz5DiBHklWo2noNfUNvBcILravUK2QmmR4S1q
 TbvgWp728ApKuhuWEpffX8gWxKWU/ILejvR79Euc+U7KNBWtLVJTWPVcRzHazNTS0bEDUaYNrcd
 UZvr/rWEIO7nAWIrsj8XXVJq1dyma6lqa6USIn2cihoiHn6gkzrb1ILkOiMpLHz34/TzOGd2BrX
 SqDWkVwPg4LTViJw7JEXtOBvm6ygEtNL73ak3XI87K43ejRcG6geARxhBdLbGZotykXjZtaLNjg
 DJRyhogVeMCldDW+NnQ6IyDxD8X1WzDWe8aubro461yc5xsZGsG1KJuBy3E83t4fOpDNNgTnuMt
 zcrNpCVuvTTNm4lzR1xG+uBW2p0PwG+ffaU8czJ3zsvmjZvGsxafYsXflEaeGiUbnCGCPrTaQrR
 Af6ixAlCcEptHzrhN2Q==
X-Proofpoint-ORIG-GUID: 30UUzFJCRlRT9JyEHzj6nT4uM6MJ5sDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01

I've been reviewing vsock via lore+lei for a while now.

Finally adding myself as a formal reviewer, since vsock will continue
being stuck with me for the foreseeable future.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8d3c..cc1341f6e15c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28840,6 +28840,7 @@ F:	virt/lib/
 VIRTIO AND VHOST VSOCK DRIVER
 M:	Stefan Hajnoczi <stefanha@redhat.com>
 M:	Stefano Garzarella <sgarzare@redhat.com>
+R:	Bobby Eshleman <bobbyeshleman@meta.com>
 L:	kvm@vger.kernel.org
 L:	virtualization@lists.linux.dev
 L:	netdev@vger.kernel.org
@@ -29145,6 +29146,7 @@ F:	drivers/media/test-drivers/vivid/*
 
 VM SOCKETS (AF_VSOCK)
 M:	Stefano Garzarella <sgarzare@redhat.com>
+R:	Bobby Eshleman <bobbyeshleman@meta.com>
 L:	virtualization@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained

---
base-commit: 8e2fbe0e75d38690d551456658194c632933cb57
change-id: 20261012-add-maintainers-bc6e8a6fa68b

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

