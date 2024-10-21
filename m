Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA121DC19E
	for <virtualization@lists.linux.dev>; Mon, 21 Oct 2024 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512530; cv=none; b=Betw8Ej9Y/dc+/3gCInxSw4/p4qpcsMS/qY+m2BaA8OPWmXLHq40Iq36WCBz4E/iUrpGeagOI3qPHW9CocD+4nGb3vXdCu5bpkT81Vtqu6TtQM3dTLVl1u+Y7Y7Pt98xrmjxEzzyR8T0PmC+mRY03vhLJ9L7r17fGlYkOOL6vlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512530; c=relaxed/simple;
	bh=3bSMN63SS0O1JqxMVL2Km5ADBcS94qUikfjIm2ZiteY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X/tTGf0Gi7PwV9e1LyF9lNZx7O8Q7c39YcoZMCKaDGv0U+Zx1S5FZTruEim+p2rvGfNWfxfmAPV2TlupNRiIu1mwIGEkHUkl96ldlgmFMFBcgeXmNSZVN8Bsbyv+6IboW2cLHfUDJaalM0YAmVMvdIpsomWSp1Hdw6PPYbFC3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TIPSoaVi; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TIPSoaVi"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L8P3dr001682;
	Mon, 21 Oct 2024 05:08:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=5NaK/CokaNbKYqs5HlYd8Jt
	Q1ROW7axkdLFpvxIYc08=; b=TIPSoaVif1Y+kjXiMyuZ4zobfe6RilXsYuMEUMM
	5wPeutaSBoLtrfaOwHjK+9TAKJWnUHr0vZLFfm/eKi1Zv0INAhteKkxelRPUpExK
	GT2CDOyggBbspOUK4XV2o5osx/Sy9g6EJ8Gw4+w0OqNtLaEndvi73ssHDOp5V+2c
	ZmeFw3PA6q+Ubqv2fYhgIrTjcql0DlHrLkFRblqNao6ddUjCE4NN90jnwXXrYOed
	F48wZTpP+DzVsF2fGl75XY2SQaFV4l9ABuW++a7h0Bk6h7VvR7yx3+FU8e4FZssf
	z7ANZVqCph6dLLK8aliFnFHY5dGWcPXZ4VW22ZzAjJI8hFQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42dke60dby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 05:08:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 21 Oct 2024 05:08:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 05:08:40 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 4B1843F7052;
	Mon, 21 Oct 2024 05:08:38 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <virtualization@lists.linux.dev>, <kvm@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <eperezma@redhat.com>,
        <ndabilpuram@marvell.com>, <jerinj@marvell.com>
Subject: [PATCH v3 0/2] vhost-vdpa: Add support for NO-IOMMU mode
Date: Mon, 21 Oct 2024 17:38:35 +0530
Message-ID: <20241021120837.1438628-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Qo4ARWR9KKoUMu5Lyqf9LpcM4rmK9peE
X-Proofpoint-ORIG-GUID: Qo4ARWR9KKoUMu5Lyqf9LpcM4rmK9peE
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
v1->v3:
- Resolved the sparse error reported by kernel test robot.

Srujana Challa (2):
  vhost-vdpa: introduce module parameter for no-IOMMU mode
  vhost-vdpa: introduce NO-IOMMU backend feature bit

 drivers/vhost/vdpa.c             | 39 +++++++++++++++++++++++++++++++-
 include/uapi/linux/vhost_types.h |  2 ++
 2 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.25.1

