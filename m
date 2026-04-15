Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36892F1FFC
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266005; cv=fail; b=ARFi05h+DgHL0ZSM3DeCKrQf2NnPzes+Uc/SdfuS13BTTvcdwSDsrQAoJBu33v2EE4ZOHcoiZAfbQZLMHYIh+CeTDk7Y9pKqzwY/LtjMoUmnLxLtxD2exCGDwBEithL9gJ1Wn08de8PExrXO0T7PSNgaYtHo1g8dn3el3bML4Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266005; c=relaxed/simple;
	bh=iAMxXWLK31O3U126ib3bBc+v6xptSrAIUYVP0tkimsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X39WFfjaR28JQAtoK7VK0t5BxvRC4/NA3fmwhowEp0oN3aAHbAITjB/3OJdEP7SiejSsMfUpd4+up4RxHwMHtCFb4iyB/ifZQYBCfoLhGN/tYlX0ZaOgvqB7bGVCWJVfeC82svD0bnUj1erCp+kYJdl2JyEP3UGWnupE2GMgLGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mPxVdHxJ; arc=fail smtp.client-ip=52.101.52.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mPxVdHxJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pa2mF2DcnSfbhQw4MTlvlfANpq93CIwHFSp8WcQzW5XZ0rUgRSxPVxb4q1bMv9Mv2ea7f3MVhWY9soNvPAwF06ppgI2lKhumKR7oIYcSU9CBXY2G8TZAnY/LDyTwrnU3dHlwqbG7Ujy6qFgsox/6auOGWtt/kzMZHd9PvFCUpagT34jbN21YyQiQuj6AcjMyg9IbEebyYtB7ElmHkuA+WRagOBK/EiM/SHpGvkVmXCj7Sii49omBmPrCy0+6nwZ2xuQ6At7OFBaFY+ySXeTHcUfVMxbLH77hTZ3SzGd+Jibw7v/GPeZhd4bDRPAKCHLXETeiH6S+AYqd87M0BowWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2omQnpceO11NVkXMO4/3hySIN/oY8LKcn0ESI643lbU=;
 b=Rm46F/4qy3Q3iSa68ULNaJ0pnjInPpnoX37gynz2rBHD/OTrnrBQI5h/JNaOyc62uHumOhzeVXdQSebOOZAwmzDxOG6gTL8q3GAsuk4qw7BXkvB47dozRA+N/mPm31stkmrcRVCXOWCjsJ9ozxfV/M1a7+qf57EaNuwLUCTgJHU7JtGHsf55DlGf1GC32nqFnZk+XejmDgM03MUM8zXUKltywGQxj0aebTVEOQ8AaVWeXYzTesEMpPb2CLNdBP1k2PqrPcsVF3f44iBTc4RYsFCZgctmBngwXbfmkfoSro4a93TynS6OhAQ5FEA5zEBI6cVc1g464VzgVTaG+e9ZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2omQnpceO11NVkXMO4/3hySIN/oY8LKcn0ESI643lbU=;
 b=mPxVdHxJCHhHn43F82AzHBuWYx/SQY4N3AHU8mfa8CP58ZT7mM4ppW4EdR3KQvdTk1UqsMDYe9V+T08EwRamQMU6vFEQG7oDf+B5NEm2pac3Kj94arnwGfWsD5fHaXuHDxakJI+OdSzHiAKwKGeiEKXcKr+6k0mmqc7DqxiIpyY9YT73qofYg7hQ5V7E1ZOrGjDh0ob8bjA4k1ggKiMEFtJKCz8a4UxJA/dJqZN3jHMWZ+ztL8IxUQIb7DEFSYYOU/DWtAW5Z9InoaOE58yTo3rtZDAkyiA50jcxEQWa1M7EqsBFN2Xo4CyhHzqhwQfMKX4KNcNEJTSWwVQQZieldg==
Received: from CH2PR10CA0014.namprd10.prod.outlook.com (2603:10b6:610:4c::24)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 15:13:18 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::5e) by CH2PR10CA0014.outlook.office365.com
 (2603:10b6:610:4c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 15:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 15:13:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 08:12:55 -0700
Received: from [10.221.197.34] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 08:12:53 -0700
Message-ID: <cb38037c-9fbe-4a10-9538-1dfbbb12f330@nvidia.com>
Date: Wed, 15 Apr 2026 18:12:50 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] vfio/virtio: Fix list_lock type and modernize locking
To: Alex Williamson <alex.williamson@nvidia.com>, <alex@shazbot.org>
CC: <kvm@vger.kernel.org>, <guojinhui.liam@bytedance.com>,
	<linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<yishaih@nvidia.com>
References: <20260414200625.3601509-1-alex.williamson@nvidia.com>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20260414200625.3601509-1-alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 8083f892-e7d9-4c2e-0433-08de9b018641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RGCfkWVJegmgTrxOOD/e1g1Nna9iaSt1bzgdXhU1umTkpfKWMCFr3/V9DHfLi5MvPME7cXStfMekSrB7E4KXNvCckCdBSR+5xuZUTcPuPgObBLHkfZFLkQIQPxKkbloLliXU4O7tgAMGXWOjDyzzO8ouCpH7isEHr+Ly+r1lg7KIG0lmP8K5JFLKgvAwQBEy+OOl6nW/vW4HtB0JtJQ2V0/3hfBQfxJ/MYIKrpY0cFNQ6NTYxt9OcAWqPfDMY61l0XoIg4ede/M+P4qo9Cao4sj/unVwmrQ0iwE50z0dSvvQ1TEwZtARnGUOPnvhrYgY7rLpY0Jw1nGS/v73mhQ9uHcmFJjD6YlznFqqaHtYhJtbCoMbopLqM04tnSTuIMSjEwZGCi+e2wAiib4mp4xaUGoNUWxWYlieF1ZsjviNwupKACqD3sUMX0eArzXgK+VTDSvAP8rpAVb87BkTIsgnfNl8vQt3g5Abxz7w10kI45wPCi3gGfFtCJMePVviNBl/5qDfgpWt+4AhJWLcv9h+tqNInzCkepslTSTxgtdOmBgzcNIZ+RZoyoT3bvOv/pe6Lgr51capHixyefRUd7d+XyFKuj2NaCFf3gWxdTA0j91AtcTds69CAmWP07oUs8aUcOFnTgoUSlicRGR/eYOKCNcGpvghh0E3ZiiGRaBWGiRPbcH89ImqzPZP/Lpdrqjngz8IoU8aYjM4sWYlfZY+jA2rDZvom3tgavbT+bFn7qbtWEsYCBtWmHKdHsypSH/4jEdACDiL5regcWY3q94q9Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dBzYmG/CGJaEFUfYqRIWHJ0Enhh1aIU/T3V2l3A9didoz+WoNg79bj8mO5hkhSFNFI/W/zDYyn7yOQ/40Al+7Hm1tHQG3iY7sW4QIE1YZsxV2CNJT8XUKukSoyLcaQrNm2nizVshPgq0SNYJ4E2SYDdLjub20cO7+nbNH7bkYZY42euDOkrfXVsbRiFo0VgjaDaPcsv7qia7U8YBGKvtLJa8XqmLleQtBOjG0Fy3GW7Dh59TY6Z5dxwLETmnl4tfdVWGJufWvz1D1gl9Pzz4eZPON4y/seENUwfbsrWjcYWOuy+6M6Hq7Q7mkyrAD0HAgJJws7Ips0uZbsYRT/P9Ndoabo5VGH7yNT11sZKbySTbZZ/KqBtfpKL6ZY4jHPZmxWNS/4a1A2b5R5OSZLjpmk4I9UUiMTjzKAqcVXtJVhY/CVf4fWnNdirY/9wa5dTN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 15:13:18.1139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8083f892-e7d9-4c2e-0433-08de9b018641
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185

On 14/04/2026 23:06, Alex Williamson wrote:
> Jinhui Guo reported a mismatched spin_lock()/spin_unlock_irq() pair
> in virtiovf_read_device_context_chunk() where spin_unlock_irq() would
> unconditionally enable interrupts despite spin_lock() never having
> disabled them.  On closer inspection, the list_lock spinlock with IRQ
> disabling was copied from the mlx5 variant driver where a hardirq
> completion callback justifies it, but the virtio driver has no
> interrupt context usage of list_lock.  Patch 1 converts list_lock to
> a mutex, fixing the mismatch and aligning with peer vfio-pci variant
> drivers.

Alex,
How about staying with spin_lock but without the 'irq' variant, instead 
of replacing to mutex ?

The scope of the lock is very small which can fit spin.
We may potentially get a performance degradation compared to mutex as 
part of the hot path of STOP_COPY where this lock is used.

Note:
I don't see that other peer vfio-pci variant drivers maintain a list of 
buffers as of this driver, unless I missed that.

> Patch 2 converts the list_lock acquisitions to guard()/scoped_guard()
> where the lock scope aligns naturally with function or block scope.
> 

This patch might not be applicable if we'll stay with spin_lock.

> Patches 3 and 4 extend the same guard() conversion to the remaining
> two mutexes in the driver (migf->lock and bar_mutex).  These are
> relatively independent of the list_lock fix but complete the
> conversion across the driver.  Thanks,
> 

Those 2 patches seem fine to me.
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>

Yishai

> Alex
> 
> Alex Williamson (4):
>    vfio/virtio: Convert list_lock from spinlock to mutex
>    vfio/virtio: Use guard() for list_lock where applicable
>    vfio/virtio: Use guard() for migf->lock where applicable
>    vfio/virtio: Use guard() for bar_mutex in legacy I/O
> 
>   drivers/vfio/pci/virtio/common.h    |  2 +-
>   drivers/vfio/pci/virtio/legacy_io.c | 17 +++---
>   drivers/vfio/pci/virtio/migrate.c   | 90 ++++++++++++-----------------
>   3 files changed, 46 insertions(+), 63 deletions(-)
> 

