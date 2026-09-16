Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD8244AB83
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544302; cv=fail; b=UHuPYWfHfYpMsBewJqJVJeV0QiljkKB/oDC2Oenx79wGrCje6e6/nGpRLoJSmiBBnZmDwQBx0qzc1xWkMNAtG7FQ0brdKSItTufxwBWn6d7iUciXmjWQr13KeD0/ETjpgaRISaQR/AEkJEpUR/Lvy0x4z91Z0ObbM+nNAmX8/Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544302; c=relaxed/simple;
	bh=g+7+mVGC3HN+hh/BvP57E2+HvqgHyV/HsVo9xPTRaOo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PJfZMZ311UcYo9/1yLcidbihiXaTEaX4/78P0mTuj2peyhR0wapjpXV8RVa3N5pMSi6QBG+fOssfB9t86ZmzVD4Yx584Aod+nPBPGiWEFoegOoXYx4s/Nvp3bhmyIGTJZKnR2SO77ncpCDFTyqNAr2ZRj9uk1LxXhtKffDdJ1g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pxPzWz+O; arc=fail smtp.client-ip=52.101.53.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pxPzWz+O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmg4AYV9lno20k+bptO98eqYLS3GNOho/nnTIP/5GM31mU99zZvzdYQR5LH4lA9UCvUc+UsGUIkvzl63IfV3iNgx0D6PXGDUzAiSsdKZ0L6C8WTyOmmFN5lUmrChfPVh7Impq5xN7MaAgIW/ZmtkntUxJXEIgZc/bujGOvq37DSVkI7xkMegNaAmPRdhenj4XOLlqwcjjXQNO1kwdWQUIT4KiWhrLu6Q0FhZ8iFxX43wgH9+3k5MRFb3njA2/gIeX5CPjuzuvAS+8Pemn/pcX4i9SOb6s1umB2pG9o7Yblm9FNZvcJdHDbkfUUoP6mbjuBfYoILz7PW5lrA0FUMNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j9K8SSzIhTfGyYpe9lfcbr5Nmyl70U43TPRsBLHMRI=;
 b=HZEKndMHb2kvMdtgnrq4plFE9ORBmA3ffTj90nV/tDFdRsubCjzjyJxMpsOD8MBlG1p65eF/XfAowcLNB8Ti8KAtjFYKhnmattzzp1H/lcKCFwwPBWLeuNpAwTvJm3JmQovXYTCTCXaqK8UH9M0shAQHW9/M/KIAavmnKhQbuZGKecNiiVD6szJBFdW7+wbXxatV2gPHt4pqgt6s2JaRFIlX3XVGzbpLOq4W1BYrSwIKHqY0fqH/ngSgRidPu+oDOg4bA/4G9ZHai4tr6VdYzWlL30/JlaEv5vai5XxKpN2xIqZrFu+fvi0oypi68KeHJWQI6RlJGRKoGljGl2lirg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j9K8SSzIhTfGyYpe9lfcbr5Nmyl70U43TPRsBLHMRI=;
 b=pxPzWz+OFu9D2w8DrSXGGP4HK0sP/JRhmNdxOg9cHzfcGPmXTPcZZds+imhywOkTqlC6rV9R/WY9A0BwwYLsD1/GhefMggdAyGOoZR9bcflYsqdgCJBaZDHMFwfiraWew4bgxrXNPqtS3VnnMeITeCuya0MYdVYny5YqdMgkj/I=
Received: from BN9PR03CA0481.namprd03.prod.outlook.com (2603:10b6:408:130::6)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 16 Sep
 2026 07:38:04 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::77) by BN9PR03CA0481.outlook.office365.com
 (2603:10b6:408:130::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Wed,
 16 Sep 2026 07:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 07:38:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 02:38:01 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 16 Sep 2026 02:37:59 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <linux-pm@vger.kernel.org>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saravanak@kernel.org>,
	<mst@redhat.com>, <jasowangio@gmail.com>, <eperezma@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <virtualization@lists.linux.dev>, Baorui.Liu
	<baorliu@amd.com>
Subject: [RFC PATCH 0/1] cpufreq: virtio frontend to report host CPU frequency
Date: Wed, 16 Sep 2026 15:37:34 +0800
Message-ID: <20260916073735.541-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: c52856dd-2826-4bf4-bb0d-08df13c5718d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	hAclxjzJyn/XTM1PlDixBN6OsiHELGjc903zv9+/XC9aJTTw2EOaoUp5DkJxMjZJEvK5Mj8lIDN65WleVTW16I5hgcbAsH2Z4u6DQpnPABSlFpsp7cztHx/g6O2x1Ohtyo6FzHCKEFFaiiBwoaB0gaSwOk3Gs5MJkjKGOzneO0CVbjiL7x8rYsUx5Hh1xU2MdaGqjYpccnw7puFHh3bdsavNP+9l7tPddlM4FhWlH7qjACzwMnihxyupNRUEIhp44sE97YTqVAbYeRvwH4moP+zvbKTa4abUb7B2xvmWiDMP/SLLWscjImMl+28zD5gO4fM5ppd22nnCOvb+5SMwbeDODumr94AF7Vubw4h9IZscqi5FFsyzAURc/A/md7FyKSw+AUnT9ZZBPHlI7qLOFEUv40YBWo6UXZwv1KvDLCYbFermn/f9XX1WGzL5o8ohfx+lwwefip7MjMQWGcBDYnvxEmyuZHimKpQEfDECcRzEvC+DQtrhfTuAg2zr9gUUBTccl/v54ZlStjdzWSx7CCSrJIB8THfSGExhEUbVW5aapxae1D2c6h1sJkZ/z7Z52jf3IyMIxkqdJT9XhhZ809EOiY9u0oFMxDi085YFePZTKZuENmirSkdEMzJnddc0cxeQyAuWl5bPtO3FPUiTGDukVqdBa3A9T0Iz+/wByNDy9XL5Lrrn1a4h6IQvCocQUdiGKVbzkdbCjqyjdWthvQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UUcSEaeUd/X5NZbcGSJb/kvVNL2lxHB8K+oGvD9oZKVWPRz8Vz09fBwb/re2SYd2PFS9g4Bj313W3zhBlzFIWtHkNLiQ+d81sjdeJCyr6/Q/G7kVi7USk7H8bLAUJ5WgjSSTxvUWOw9akqY5qyc0r+uEb4/Cicwve/eoXjzxxo5opa4Js4d0FuOnevOvHTlctwz0CcDsjcMO4VY416iCgXMWSRJecayUAaDHtB0q5X8wqQchdaZnbHm4WPwv3ARlRJEVBGiQBs/nFhz8M3eu2FrCOIkwN4cbI2fzAgZf3oH6vrKUUsPceu8N9YzeZVaAGfQd9AKYC44uA/0mZY/A5kWsn5tGdtUd/eDeu+sWVgHus1ZKRcYpZhoqi4eATKPzxAdzVebrud5pLPEqHYHAGQChjoXnlEyaZj23TMtLmE0YA0bbpSE87rJTWTOE2nJi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 07:38:04.4113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c52856dd-2826-4bf4-bb0d-08df13c5718d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596

This RFC adds a guest virtio-cpufreq frontend so a VM can read the
host frequency of the pCPU that currently runs a given vCPU.

Context
=======
Android batterystats needs cpufreq together with power_profile.xml.
A Xen Android guest cannot read host sysfs, so QEMU already has a
backend (virtio device id 42) that returns xc_get_cpufreq_avgfreq()
for the pinned pCPU. This patch is the Linux frontend.

Why not virtual-cpufreq.c
=========================
drivers/cpufreq/virtual-cpufreq.c is an MMIO guest driver. This
stack is virtio + Xen/QEMU, so a separate frontend is used. Feedback
on folding into or sharing infrastructure with virtual-cpufreq is
welcome.

Known RFC issues
================
- Virtio device id 42 is not allocated by the OASIS virtio spec.
- The OPP table is hardcoded (1400/1700/3000 kHz) for bring-up.
- The QEMU backend is a separate series (not this patch).
- .get() waits on a virtqueue and may sleep.

Please comment on the id allocation, protocol, and whether this
belongs in linux-pm as RFC before a formal PATCH.

Baorui.Liu (1):
  cpufreq: virtio: add driver to report host frequency to guests

 drivers/cpufreq/Kconfig          |  14 ++
 drivers/cpufreq/Makefile         |   1 +
 drivers/cpufreq/virtio-cpufreq.c | 235 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_ids.h  |   1 +
 4 files changed, 251 insertions(+)
 create mode 100644 drivers/cpufreq/virtio-cpufreq.c

-- 
2.34.1

