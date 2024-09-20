Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DACA2D638
	for <virtualization@lists.linux.dev>; Fri, 20 Sep 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841146; cv=none; b=k8G6zimd58WLSgEiQE0WmdHj8caqJ4Heu4/vLSyHL9lbdCC2E0lX4hs6/2mMeTubiofrAa1+U7is0bdGXnN41JuilkJzIzKO+FEnnFaHSrqNLA1rnds90d3MpMC7+dqGpKASkIeR6emN77R/iPbSDQzMDKZTINopnm3CA7hD6o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841146; c=relaxed/simple;
	bh=Qsl/7lJWAHLtUaQwY6w41lw5dh24RUexk8CjIz3Y6yo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EK0Oa7gYHF1ouqL6VuuB1FatXb0wrDeRbrlfhyPG0mvBYvSZgj7XAzkn/mJW2enC7zZCTNoQl0EFlFPCag90CMT/zz5Tzk484PWPzAgSPz6brFU9eSHuucu3joWr4ghRz107/le49oLUVRfXrmM5OHcpq8R9h48huE5cLAlkl/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=e31/INE+; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="e31/INE+"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KANWRd015710;
	Fri, 20 Sep 2024 07:05:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=0bxiR4fnNWh35DiS7jRskKB
	HJnWWpsoExoc0Hi3+cdo=; b=e31/INE+wArRPMs0+0Qbv2VAHurcUUvTWn2BXce
	1PIyhWK6q1yU3WCKR50MG7yQXbt5i7aILEbXXT2JahXi5UFEGzzSVo4UWVcP8TUo
	20gyiTXBOIA5c4Sinsl+sJjVE6aSW6pvL2P29udnac+7x9pI1a45yHrnYe/Dqatc
	oEJIa8jYcCgBLGKgjxI48lmrOsL8aVOx9JiUgHNo5uOpF0ghKWCWoEo3vGWdVf+v
	OS0rMYEULX3fRImRBiQBVPnYR7YAKKUtAn3NZB9p571lxw6cx0/ElRG8QI9FKwDk
	/U03VKgo9Pr4dzm4c5WGBc5E8pknF3WafWWfGxCDwoU7bFg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41s78rgtgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 07:05:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Sep 2024 07:05:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Sep 2024 07:05:34 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id DBEE05B6923;
	Fri, 20 Sep 2024 07:05:31 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <virtualization@lists.linux.dev>, <kvm@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <eperezma@redhat.com>,
        <ndabilpuram@marvell.com>, <jerinj@marvell.com>
Subject: [PATCH v2 0/2] vhost-vdpa: Add support for NO-IOMMU mode
Date: Fri, 20 Sep 2024 19:35:28 +0530
Message-ID: <20240920140530.775307-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: V94DQnsWVu1Q5dQcQH5YGxuXsSKLjJcT
X-Proofpoint-GUID: V94DQnsWVu1Q5dQcQH5YGxuXsSKLjJcT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

This patchset introduces support for an UNSAFE, no-IOMMU mode in the
vhost-vdpa driver. When enabled, this mode provides no device isolation,
no DMA translation, no host kernel protection, and cannot be used for
device assignment to virtual machines. It requires RAWIO permissions
and will taint the kernel.

This mode requires enabling the "enable_vhost_vdpa_unsafe_noiommu_mode"
option on the vhost-vdpa driver and also negotiate the feature flag
VHOST_BACKEND_F_NOIOMMU. This mode would be useful to get
better performance on specifice low end machines and can be leveraged
by embedded platforms where applications run in controlled environment.

First patch introduces a module parameter
"enable_vhost_vdpa_unsafe_noiommu_mode", while the second patch
introduces a feature flag VHOST_BACKEND_F_NOIOMMU to the vhost vdpa
driver to support NO-IOMMU mode.

This feature flag indicates to userspace that the driver can safely
operate in NO-IOMMU mode. If the flag is not present, userspace should
assume NO-IOMMU mode is unsupported and must not proceed.

v1->v2:
- Introduced new feature flag to vhost backend features for negotiating
  NO-IOMMU feature.

Srujana Challa (2):
  vhost-vdpa: introduce module parameter for no-IOMMU mode
  vhost-vdpa: introduce NO-IOMMU backend feature bit

 drivers/vhost/vdpa.c             | 39 +++++++++++++++++++++++++++++++-
 include/uapi/linux/vhost_types.h |  2 ++
 2 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.25.1

