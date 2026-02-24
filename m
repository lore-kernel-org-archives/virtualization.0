Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647AF36C0CF
	for <virtualization@lists.linux.dev>; Tue, 24 Feb 2026 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926760; cv=none; b=l0l7W1klW8lOd5H4knuDvQvLQGwRlwQdaGRJ7JfhiFO3drmzfWdIk+wQaZ1nf3JmW+iWureXUNd+T4yC7Z7Oj6ftalW3EROwimYytnjmoqDfg4fqSARuzIcZPKkLbWAk0dR8zSUZzb5ShUzCwA+ag2DdkgVTZgm3VA8AqEAmxSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926760; c=relaxed/simple;
	bh=pOzO62aItqWlf/OFSCarUIaRWtB3145pMAl41z8gHyc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qX49jT5/ykQSguDn8OZKbZrXtFPN4fmsHweArfObzoavzbZo2Lxokvd09Kvm7sE+BimuCaczI3Tq25x5ORoaSNrWD3KLTT/mzjxsVMccZvUMGOwoe3YxvpUwSycP0BUXYheG93e3HXVtlvFl+eBkO4d6Q6tfJRmRMejeF0l0fiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AvanhIQb; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AvanhIQb"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O8wTsb3270238;
	Tue, 24 Feb 2026 01:52:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=LqjuE58DdrxF5i8GTi4aMq+
	G5yJ/qw6gCp/r+h54kWY=; b=AvanhIQbjy+wRA/s4kK6RkVQOR7MGtFYAmS3O6W
	8Ri7t0PIXQEJdCLvyg6ZYZl3dh2nD3XwxMl4ZWryJ7cXIQab0Hw8Ny4qstX63uYt
	aGcEuFUmLIBT3BWrRBjeUolpDEBu79zdQWO612K/aiiPdVa0nzEjHsmbJUqGh1Ny
	LHkkE4y40Hz6kn2kFjCRQeD5jh6Q2QXJB+yJ7X/6QtO7qqDZSCmrWbSKSrYYPY9G
	agb+PyiEO5BXYNquNRPdeIxaN9MeO9TMK1izs6Pw0AUboexvAmeSwOLziUmJ6YTe
	TFKJSgxkon9/g9jijL8OXClb7iDUpMxZ5/TmidyHpf5f1cg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cgd2mkptf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 01:52:32 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Feb 2026 01:52:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Feb 2026 01:52:30 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 10EF43F70B6;
	Tue, 24 Feb 2026 01:52:27 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <virtualization@lists.linux.dev>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>, <linmq006@gmail.com>, <phasta@kernel.org>,
        <ndabilpuram@marvell.com>, <kshankar@marvell.com>,
        <vattunuru@marvell.com>, <schalla@marvell.com>
Subject: [PATCH 0/4] vdpa/octeon_ep: fixes and improvements for multi VF
Date: Tue, 24 Feb 2026 15:22:22 +0530
Message-ID: <20260224095226.1001151-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=AfW83nXG c=1 sm=1 tr=0 ts=699d74e0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=HQXk9ao4JWiLuBhhhIcA:9
X-Proofpoint-ORIG-GUID: xTnXE1jMbKur1iXO1a1H8WN5KKLCeZ1g
X-Proofpoint-GUID: xTnXE1jMbKur1iXO1a1H8WN5KKLCeZ1g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4MiBTYWx0ZWRfXwq1HGs/iyHZc
 OthL7t4Lvc22lLuVJok34sFakrWgEoVH28nmP8C5/86ZMXFrGFtFpDRVTTNj3qFhQiD6rYIreNp
 sj8fg3JN12r2bDRZ7fs2N2jUggITbrEuPnpqlbntN9TLeHuadANKFdpoXjvR73ny8Duw0wj15nA
 4ENT8MmTCzhyYjZhMsJ3sscGg8ol3xas1tO9Ajqwjgs11Q3bF5erbCkNko2/BvRIZQokFaxECPR
 qsk344JJG8QqAdBiEaicRad+2yOgoaS2iD8lUNTwjOqK9HTZkYDJDhRq9JzCQmUL7inXBZ3jjrs
 Q94eayU93wMOoyVdzt3cvvY8cOA4SKY/c8zmKriCMXRqLfx/MvvVxEFHcNMDVf6nepDnn507W7x
 6CSYpFFv+oyGniQuQMiBa6WDTe1hDo+YgXQ7IzjZOk8WaE/8+BlQLAFDggKN6WpFwIqHd6TWVRa
 n3wVGTgXChAvC47FFTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01

This series fixes several issues in the Marvell OCTEON DPU vDPA driver
and adds support for firmware-initiated device events.

Patch 1 fixes the PF->VF mailbox address calculation when multiple
rings per VF are configured. The driver previously assumed 1 ring per
VF; it now reads the actual rings-per-VF from OCTEP_EPF_RINFO.

Patch 2 switches mailbox signature access from 64-bit to 32-bit, since
the upper 4 bytes are reserved by firmware for metadata.

Patch 3 adds handling for vDPA device add and remove events from
Octeon firmware, using irq 0 for multiplexed event delivery.

Patch 4 fixes the IRQ-to-ring mapping in the interrupt handler. The
original logic assumed contiguous IRQs starting at irqs[0]; the driver
now looks up the IRQ index in oct_hw->irqs to support non-contiguous
IRQ numbers and avoid incorrect ring indexing.

Srujana Challa (2):
  vdpa/octeon_ep: Fix PF->VF mailbox data address calculation
  vdpa/octeon_ep: fix IRQ-to-ring mapping in interrupt handler

Vamsi Attunuru (2):
  vdpa/octeon_ep: Use 4 bytes for mailbox signature
  vdpa/octeon_ep: Add vDPA device event handling for firmware
    notifications

 drivers/vdpa/octeon_ep/octep_vdpa.h      |  22 +++-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 131 +++++++++++++++++++----
 2 files changed, 134 insertions(+), 19 deletions(-)

-- 
2.25.1

