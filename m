Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529619CD0A
	for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776197236; cv=fail; b=Lh3Z//7zqzwuGtFKcakHKeoaXcWN5RH1vlEMwgwMQu/ZkVgFqLA25G23S9Tm6vt3QD0z+BOhHXl48HzSdPuqxRNDPtmzlPV3xo/8CRkI50qoz/wzUPyQCNrSilvmCamM+XKOFwMP93Tyb31x0Se76VgUqS4RV/Kf0x4Z05hiMSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776197236; c=relaxed/simple;
	bh=QsmL/NS425Bn95XnG/4TIgJeLWHjCBoCpelsPEIDnqk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DMGwbWLHaac29vIEaDBU9Y27dFUuXC4fJs7VN+JspwOIE7YQA48xEM+1087Vn1pI2ctLQG22gPHAmBJFeRhlJw4IeBRpQ5rG/Pa+xsowhV34yi+19imLTqs18b8AZ+8yTD+JRY8ir97Kr50sp2ldHe3j/MdpwvvuobS3oRWgQLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K/He9t5d; arc=fail smtp.client-ip=52.101.46.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K/He9t5d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgG88aCgChFvJBHYbeRdiS4DDLlGHCI/ntlN6TEBzdtoWU/fh/nMCTM+HKW2DR1Y5fq3plBBUfyhDYHUBNDUvhxGGHQOjh85KKeEeMMckh1Z4pQgiCOi0QQ/bsCn+fCLh9Owu2685/kHS4D3/zyGzT0+LE6MItEWl5R7CZkrRjbgH7Qph36yJSk8Grywn0uyFV8wcbHgZin+9r1CyfrSsyT7c7sTm/jxWVVzIQ/hjg4JYemFAJaeSb/bbxDc7t1iqSDiDKwTEm1H4CopCY2UI6kS9+1/tyDFoLWrXIDmNn3VI5txyLws8dR3g7szrqbYFnBaDRoJoRmDjrIF8/cLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc1MgaJQ/SMKYqWK1jJmUbvE0oYnthmdYFE2xzCFzOM=;
 b=so3eXwA4nRPvMrDSbau1aF5pkjUT3vHa83PQXt13/76UnBVS0Jzf1EN7SgaatLB6VhPzENa2v6LOQs+7IR68e20W9GvRdhzl9to9QlA262v+bBOJ9X+xwneFMQwMCaSwOHqMUMhsq/ZOE9EEBTjyiFvCSuKAmmDJPAHipGk93sADzQVem4uDvbkzfIAcK3RT5iUoPbGZ3tv3L0Z1ptT5C776l3WNdXgRfT/QyCkKTDxi4woblgozeO/It9PcUpVa+6L5ynRJUwpWyEZGpvevyRPtGNkeWmDy78NMsi4KHHBoT8U+tByi/ywgLWl35oKCh8EQzvovr+4twPgvSfFruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc1MgaJQ/SMKYqWK1jJmUbvE0oYnthmdYFE2xzCFzOM=;
 b=K/He9t5dZbc+qNBlHYoWU7r3JYQ57II9QLPtCuXWBUj/rb4R4l2/f1Tm+bpTrGXnGCV4WJYkkM1cmFLEnTfTJm8GfEnz70HjQ2qnl5HIP2vLvJptBag4CHnpgeqza3zKzzqE3c5niiB3TIMEikd8uAFkcxhkobjPQjU/d8rovcVWqItvcm1W5ZgHzN6v5Hl/cX5quOJj++EKba3Djgapfp668Fu3CxarICLJWuME+PJ06zMOkkH1kHGPSy7HlydMy+L2ksYMxuA7otO6ClZJDx130oQ/iVOqT9r4RC5bojKBKETsPOskHWeqmGSXAByMxDAB5REIdO/Z3H8yeFAkMw==
Received: from MN0P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::26)
 by SA1PR12MB999253.namprd12.prod.outlook.com (2603:10b6:806:4dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 20:07:11 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::12) by MN0P222CA0024.outlook.office365.com
 (2603:10b6:208:531::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 20:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 20:07:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Apr
 2026 13:06:48 -0700
Received: from meforce.lab.shazbot.org (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Apr 2026 13:06:47 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>
CC: Alex Williamson <alex.williamson@nvidia.com>, <yishaih@nvidia.com>,
	<kvm@vger.kernel.org>, <guojinhui.liam@bytedance.com>,
	<linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>
Subject: [PATCH 0/4] vfio/virtio: Fix list_lock type and modernize locking
Date: Tue, 14 Apr 2026 14:06:18 -0600
Message-ID: <20260414200625.3601509-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|SA1PR12MB999253:EE_
X-MS-Office365-Filtering-Correlation-Id: 697f43d5-b2b7-40c9-15cd-08de9a6169a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hfqIZcuowVsnyVQcp/9FgGzgu9DNNHirwc7vBm/qHssSzeI6DmdboZlaOJ7QTRWmkDnHow939EFbMTF+OtVw9wpIpbqdVlPkhLKYiBJ/NDJIbCmYgc7pCtniiC9n9AZo+ORWjkSuKSL/+H8Rhw0wz3eIl4CbxhAVxUcr1cRYBzOY/FClILZWotBvoweQNfME/Qhhq5R5KaxM4nuq93ptbXrSGL1a4PsNwo5LynPbu7Yiroo2jaatpghmHzljC6zZQnrr0aXz2ddoYcxqq/lBkQCm6RUcOedFt++2YaI2+narkQgR5JejI40lcNbnjgP1ntZzTlwValldAzDLlv9BtJ6qT8x+9sCji+1r3+OgZtghDMca70IWh2WHVBhl3BhUf2yn8037GPqKM92jrK37NmEj5C543pH/NIUpzLaxpwXQk/18Vx4kXi4qKb+TjltTygUQI/aKe6nOXt2Auzd0zWZwcwJja1AIshDFFHaAZJKF7AfrBCCHpc4rSodFgGBSbbGT6hnRM+/XAHIYQIBd/HGVH9NhyUk2mnxELx61Cx7Ej4IOytgiaJFNIpW7WVs57WcHKvkKS+XDXwwA6suw4VjHYoIrANCXvfYgql1Hi0u9uENpReU2xCFPraTuyUHuCmpJiW5nTHaDueDbo/BkM2sxtg+fyuXUZsXXRqvrnOU7w2luIuFWJJDqGCKacTm0vu/RaNcdxx1E9IFBvUHHduUx5Yn5UdbKUp2W92nsaFPiAvrntWs+Y4hGn+uOOu8KpQedA8aSjDe7qm7B5DdFsw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sTZT7Wro4yE+tZ72rw8a8yNuLs/cSpVzthg1qkP/+1qQgIofl9ZVRnQyzCjIEaRizpC26WZYkJyZEGa6mU51CVlQLUJYWteq/wOcCols3ehecpP5XqgmMHh3BVtXrDbE3licFNIQrtEhVA2GsdcijiWnuZyYNrAJbblixc32RI1aI51u1CwzklnzRNDmxrfICWMjv/D0IcWuCtkn8qx4PuIl+qZxle79u8Jem0a0qxm9vCHkPrmzjFofqyh/YX5HqkN2scQFVRLBIkFNiFxPFH7rKMrvv5FlD055yspIglbxX0gkjlkexBVSjrv2rGAxx2b8h47Lq5VWTktG2Y5X/8CFXrE7TJBrwvzs3OI5OqjWeSnxEMegbA8tSDYsoIimjaJe2lAVqwwaM6FxYnfxLljjdAkon9RNwcSK5E9H86xrPQRN4KLGQbdTsF6BazuL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 20:07:10.6343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697f43d5-b2b7-40c9-15cd-08de9a6169a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999253

Jinhui Guo reported a mismatched spin_lock()/spin_unlock_irq() pair
in virtiovf_read_device_context_chunk() where spin_unlock_irq() would
unconditionally enable interrupts despite spin_lock() never having
disabled them.  On closer inspection, the list_lock spinlock with IRQ
disabling was copied from the mlx5 variant driver where a hardirq
completion callback justifies it, but the virtio driver has no
interrupt context usage of list_lock.  Patch 1 converts list_lock to
a mutex, fixing the mismatch and aligning with peer vfio-pci variant
drivers.                                                                                                                                                    
Patch 2 converts the list_lock acquisitions to guard()/scoped_guard()
where the lock scope aligns naturally with function or block scope.

Patches 3 and 4 extend the same guard() conversion to the remaining
two mutexes in the driver (migf->lock and bar_mutex).  These are
relatively independent of the list_lock fix but complete the
conversion across the driver.  Thanks,

Alex

Alex Williamson (4):
  vfio/virtio: Convert list_lock from spinlock to mutex
  vfio/virtio: Use guard() for list_lock where applicable
  vfio/virtio: Use guard() for migf->lock where applicable
  vfio/virtio: Use guard() for bar_mutex in legacy I/O

 drivers/vfio/pci/virtio/common.h    |  2 +-
 drivers/vfio/pci/virtio/legacy_io.c | 17 +++---
 drivers/vfio/pci/virtio/migrate.c   | 90 ++++++++++++-----------------
 3 files changed, 46 insertions(+), 63 deletions(-)

-- 
2.51.0

