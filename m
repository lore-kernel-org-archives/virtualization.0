Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC66270540
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737978; cv=none; b=GJrCdcSLoikxFwoSv0cpYENWjGkZPhHVhaS9+L//0aI5O4QgFbXkTv+lZp5C7iJND+QI583lyP78h3kJ0xi7SgSMg3DrsQFtl2e9QvShjoe2HOqSzM+pMMDHIJ8pzsJjT4Ry2H3IHF7gCY3Xlo+IoG8zjU7bs/lNHa7GZXOnk7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737978; c=relaxed/simple;
	bh=osjuNtKD8Ym3YQ+hCPBYdHOxHh9TwGZ5KltzBhchfZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lP48oVkVfsKshsEV1L8gk085iznQjvyLS6B1rpQz0D14ah+tGdl0knqa8asJq/0XQV/JI+butyniQ4fPTO7+F9YuBY10FScek0mrCQ1VQD0lwgQoovKemxgUVOC7xkuETzr175PcSmnUHBdYXxL2Ahrke2AkqLFh2SSb+ctOBmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LBo4Svbo; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LBo4Svbo"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606IqnTE1802704;
	Tue, 6 Jan 2026 14:19:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=zvci3aTmM6CQM7tp+0
	/6a+L0pSedUyDT4fKpD3qbqH0=; b=LBo4SvboYDENovBa6KD3tsHcb5Ptca/JAu
	Ui1uaLcfMErWVuh43Jc+DgN3CZrY0B7eVCx3rb7mjHBU4AnDhep1czXg0O+81crx
	DeAyG2IXNd3FxoyyyMDAXeo1qLGwmLLplLEc5mX0eTcRz/iU+GYeC3WCeRouEF4Q
	sd8HMl5MUsPy++NvAGwXIWd32MXXmYbnZj71KONd1mf8WQoKt0WGCMimmDpgzpCr
	wBuKm8cNgi10iSDW9UfOPLCArI1/NR4NP2aWSFiIKJZOhlLMwFfAEJhp9f2FVwYs
	Td+85mf4D7plEJ3CzSa+UBwdYb458GntmwZ6pxn060SjZPzUiaGw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bh14vd8cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 06 Jan 2026 14:19:28 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.29; Tue, 6 Jan
 2026 22:19:28 +0000
From: Vishwanath Seshagiri <vishs@meta.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei
	<dw@davidwei.uk>,
        <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] virtio_net: add page_pool support
Date: Tue, 6 Jan 2026 14:19:22 -0800
Message-ID: <20260106221924.123856-1-vishs@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=dtPWylg4 c=1 sm=1 tr=0 ts=695d8a70 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=hKZMIC-r0YC8lGmEUlcA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: ar30F3q-2ZBwa72H-2s-IeJFRSvG8rLF
X-Proofpoint-ORIG-GUID: ar30F3q-2ZBwa72H-2s-IeJFRSvG8rLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE5MyBTYWx0ZWRfXyIUw8ZWvCFMt
 pM+n97rixUaL2m2sAuWXZ2zzpDdFO9W6sGydvfz18hQX1Vkif+rciFdrMD/ZffYNUqyraPKGSNk
 PoINYvMyfyqqUXI6bBMQhKJl4CZi106wMf8UbAtiEWdEzOgrfb2wepZIkwyFsZZVeTVuI50dn8n
 s4/DUqn9DM8PZ/MGDUF3ogIMKz81UClRxNNnnvo1x6t38qSInwe3Ntp5+GJPKGufGyLuVlszrIk
 q81NyYLm6XApO86Bw1BQuO/r4K106n6r6e/3N8burEBB3tkunMTNIPSbFXP5/yX6lS4/po3zdUe
 nOVJKeDnj8kPe8U5QRwiEUT5Ki50C98f97oUpRvqD4+Vv1QrNwCZwQOhEuikxjjtOBbge3cmI3E
 iSD82RugyPTtLx/pnHebHsaixF+WpvISGCO39fBb03Q4WzNgqxgZMStcT+MmNujsZoj4ZmVTJdC
 x5eM2W/rTV5R/B3WlJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_02,2026-01-06_01,2025-10-01_01

Introduce page_pool support in virtio_net driver in order to recycle
pages in RX buffer allocation and avoid reallocating through the page
allocator. This applies to mergeable and small buffer modes.

The patch has been tested using the included selftests and additional
edge case scripts covering device unbind/bind cycles, rapid interface
open/close, traffic during close, ethtool stress with feature toggling,
close with pending refill work, and data integrity verification.

Vishwanath Seshagiri (2):
  virtio_net: add page pool support for buffer allocation
  selftests: virtio_net: add buffer circulation test

 drivers/net/virtio_net.c                      | 246 +++++++++++++++---
 .../drivers/net/virtio_net/basic_features.sh  |  70 +++++
 2 files changed, 275 insertions(+), 41 deletions(-)

-- 
2.47.3

