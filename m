Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767D395D9F
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273826; cv=fail; b=nwZNn8hPxUaMkWzfDCE/3Q7ogcZm1Iay/SiF/eeXAlb1hsAoAZz6i1HEoejaWHqEWz8SRvdcQwZ8hqK/Rw1bBJ7lXW1Q5OqY4BQFD9NvJhmTRsb2UozQ8olI7lFIYGXHNiLCwZPy/Mzai3XtwnBhprUhEQ8FHuv4MAXYw2oxplw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273826; c=relaxed/simple;
	bh=pGnDrv6PYSwcENgy0rgxeo6hz92MTYa4awIj6wYbs4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vAycY2xcByjSWAZ151rLryAeBbbcza92XpOUYHf0BCC68amJdI/YyLwKWr+JeCQeOrW2fkZUB/RpMBh2uAF52BgA5b/SqB5Q/0b+qrILNdoP44SNh8AxxCTPVmHavdiih5UzqstfR0CB/tmW62j6v8yUuPSLs8q8JXHkgNFcLTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kOze/2Zz; arc=fail smtp.client-ip=40.93.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kOze/2Zz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjtTHsYxv5ILX0hYTgBuArPBnNLUqOiF00u3WBkOgiz1D/LKjSjYSItesX/GCk71ckNJExU6hxRESMM6yhb6BBTEnaMXiveOytfX4kd/AOmUtYZ97EO9HzGcNgmdgAxjZ5UdqBsjZ8it/pvejGzYS2Eqw+X3HpYiAYuKw4VSiHPrGu85t8MZs5Aftm9Wg0mccA3E6yQDUQ9M6ydv1Zx68TLG5NV1TS1ZgiDuNlj88g7N+9w9rZPnUhpOITHArt4t2VruSgQRU5V1EwRwJDTqybM65rOqpBjNtNxtfccdLaGZFB7kDzgVvHEqw7MjMJ7cWz6yX8tS2RUh7gIWUs8mrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RvZBUe6hcFQNMvPlFgqvWM1jbTfGtQAZ02YYrdGd/8=;
 b=Th9czgVoT8FSsZ6R2pYHUHedWZzQ7+FWPOqGOdcTXUe7cagCRQboMjbgc9cjaK90mp5zJNlfZE1nYENCAeBlQwBzxWFo+JWuCGL7F9mxesmrWjKlYHf9PZbbDzdEwLiQGAXHiP4Dbdopx59W/92GlUFmgyth44Lec3EBbFYWtMK551xnMS/YGa/TGyrFJF385AesEjgSxpTs/uox6vAe+PwV6JIyAXNGC3gInikRX4SYxDfhtm8vKlhoPNHvkjlcozpw5TnRWmQn7ipyiQKKwrJMNn0spwjiiv6ZIbXcy7WTZil/cAm8u5J2Fzgj3i9smwpwK9HcWYxLreAgfNudZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RvZBUe6hcFQNMvPlFgqvWM1jbTfGtQAZ02YYrdGd/8=;
 b=kOze/2ZzK+hgk4VOHu1AhGq0yrFQiiqJmcKjGn+abOxCSLxGk982nhg3ImXExPVwb9Q26oLBico2PkygV5kI+ObnrSxnfAUk2jgdM8WBPJN9x4EXisu+74fXX5j1xVX5iSxNtfKvKiSsXZueRWxmGk2rpHHpAvKeGsPpGbrVd+ZigtHoBSqOiJ+oVHowVqH63ZWscRNPYrs1bzIz74C+CTN5KvYqDG0sEMeDccpM2VBDK3cX35uSdt1oqg6zgeuXutvvmpbjxUiXcEnRprqwgtlqdRapSEKde3Ip1HriFqIHS59xYXvNE0qsW3rtyVDGFJytPYbLAwUsViDqYJhmaQ==
Received: from BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::11)
 by BN7PPFCEE68E7BF.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 17:23:41 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::e2) by BL1P223CA0006.outlook.office365.com
 (2603:10b6:208:2c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 17:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 17:23:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 10:23:19 -0700
Received: from [10.221.197.34] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 10:23:17 -0700
Message-ID: <e202ba24-b93c-48d3-bfbe-4fb1e538f4b7@nvidia.com>
Date: Wed, 15 Apr 2026 20:23:14 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] vfio/virtio: Fix list_lock type and modernize locking
To: Alex Williamson <alex.williamson@nvidia.com>
CC: <alex@shazbot.org>, <kvm@vger.kernel.org>, <guojinhui.liam@bytedance.com>,
	<linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>
References: <20260414200625.3601509-1-alex.williamson@nvidia.com>
 <cb38037c-9fbe-4a10-9538-1dfbbb12f330@nvidia.com>
 <20260415093945.36d01312@nvidia.com>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20260415093945.36d01312@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|BN7PPFCEE68E7BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 226a3d9d-62a5-463d-3185-08de9b13bd60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mzY1VDfl5uoHwSV90PNjvC8jIER+8F+tbPtv7ggXHjfvFqGvFUUZCwurpVWEbppJ33EqgrkSnetCZ1By5bv12ugQ9d/Nx3xAKKMkLil8uT8gOdYmcBJq6Htsq9cb7eoRixQSqn3G/4XfhySk06miHxMGRIAFwVxO7XXLn09Blsgq36mVCAQ2CA8fmnEGsfKZ2gl5gPUC90TSdum/NkCh3UZLWqt2cG7K1LyKKSLkCs3UPhfr72AxU7pHZ6JWMa0vt8jauBRNdpuddXvrLuIJAoy3jR19LsJI837svhAgAkquMl0We6GC/pM35M9XQDwfu9TaslEq6DXrb2CcHZo6cKJ17Youq/9nV+1bkfID4ItQqu7H/CAVkNBJfCgvHd/MUvzdgCHrXA60iJg9s1PA2pTrXhkGROruIlJDpjzg6x8AoDabScaxOuCfzU6CTVcVyRlHvYBFA7/rU4ed1vMYS3k8Ocgtfpjp2OjzO55mqx+XJJs8JDytA4a6v+jV8wcyUYw36sq0qXmAx44fAQD1O1q01IXi1VsEONjRjg+xVW3ynLgAY5jn9SXsIs7YFNeEpxOafjcABrDdiavUzJTgpRueJDwTgSbH+EtRG3ieQdVz0lTKi9jQ13oNoNSOLcX+rP2xv3zfCxj4ixQ0Z2ujXwLIpSZu25VjK8U69NxInkG75hvvtgFGMAcgbIyG6A1KFK9L4yMisJz64V2tqR+Ii1skbAMkOn1r2AKJgHmHnMd7yWTuVC0m3Yhgcz23DlkZl6+/5BW9YTAqfLLp8jlVwg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p1hYgWy3BP1HCtJO2TkGc82lVkffQIPe/eTo90J7qYgmcsOHQMhF1goNPcNrORJmqr4iOQPgUJz1NPRkQ4PErtq5ZMaFlg70CuXpYsXUX2jAfcUh7+z9erD4qSx5tKU5JsAvkGr+pHnuKLIlfAIlWwMECQNfHKdozOct4BrFtNwsy36YW2ecpjLYGy2yD+s6ETGZlcyRJSWWhLsnppizEEzJyQ1QzU2+QYmnN/89FcEUleLgoPj8h//0AhgnsmTfAhqpAgZ9m/FUZ67+icn/lX5j2qXz6fzDGEcDMrFidQIEKnvOmeJn4itai/NYUIb0Py0r11KrDb365sKJpXJzpJjA+MsZXO6eLItnw3OkZpfiUZBPadvSU7K/1lYgbha/F5h7kHQUVAZi7o+9dWuSDrlYhwaDnzjh2oDnwGQIKzkARIsUG6KLsySQJFv135Z2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 17:23:41.5236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 226a3d9d-62a5-463d-3185-08de9b13bd60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCEE68E7BF

On 15/04/2026 18:39, Alex Williamson wrote:
> On Wed, 15 Apr 2026 18:12:50 +0300
> Yishai Hadas <yishaih@nvidia.com> wrote:
> 
>> On 14/04/2026 23:06, Alex Williamson wrote:
>>> Jinhui Guo reported a mismatched spin_lock()/spin_unlock_irq() pair
>>> in virtiovf_read_device_context_chunk() where spin_unlock_irq() would
>>> unconditionally enable interrupts despite spin_lock() never having
>>> disabled them.  On closer inspection, the list_lock spinlock with IRQ
>>> disabling was copied from the mlx5 variant driver where a hardirq
>>> completion callback justifies it, but the virtio driver has no
>>> interrupt context usage of list_lock.  Patch 1 converts list_lock to
>>> a mutex, fixing the mismatch and aligning with peer vfio-pci variant
>>> drivers.
>>
>> Alex,
>> How about staying with spin_lock but without the 'irq' variant, instead
>> of replacing to mutex ?
>>
>> The scope of the lock is very small which can fit spin.
>> We may potentially get a performance degradation compared to mutex as
>> part of the hot path of STOP_COPY where this lock is used.
>>
>> Note:
>> I don't see that other peer vfio-pci variant drivers maintain a list of
>> buffers as of this driver, unless I missed that.
> 
> The argument doesn't make sense to me, we use a spinlock if we have an
> operation that cannot be preempted and a spinlock-irq if we need to
> manage that from a hardirq context.  I think we just need mutual
> exclusion here.  Stealing the CPU because you want the absolute best
> performance for a little bit of list manipulation is not valid
> justification.
> 
> Documentation/locking/mutex-design.rst:
> 
>    When to use mutexes
>    -------------------
> 
>    Unless the strict semantics of mutexes are unsuitable and/or the critical
>    region prevents the lock from being shared, always prefer them to any other
>    locking primitive.
> 
> Can you cite specific requirements for a spinlock in the critical
> section here?  Thanks,
> 

I see

In our use case, we mostly expect a single task handling the migration, 
so real contention is unlikely and we don’t anticipate the overhead of 
sleeping and waking to be triggered.

That said, I’m fine with using a mutex here as of your patch.

So,
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>

For the full series.

Yishai

>   
>>> Patch 2 converts the list_lock acquisitions to guard()/scoped_guard()
>>> where the lock scope aligns naturally with function or block scope.
>>>    
>>
>> This patch might not be applicable if we'll stay with spin_lock.
>>
>>> Patches 3 and 4 extend the same guard() conversion to the remaining
>>> two mutexes in the driver (migf->lock and bar_mutex).  These are
>>> relatively independent of the list_lock fix but complete the
>>> conversion across the driver.  Thanks,
>>>    
>>
>> Those 2 patches seem fine to me.
>> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
>>
>> Yishai
>>
>>> Alex
>>>
>>> Alex Williamson (4):
>>>     vfio/virtio: Convert list_lock from spinlock to mutex
>>>     vfio/virtio: Use guard() for list_lock where applicable
>>>     vfio/virtio: Use guard() for migf->lock where applicable
>>>     vfio/virtio: Use guard() for bar_mutex in legacy I/O
>>>
>>>    drivers/vfio/pci/virtio/common.h    |  2 +-
>>>    drivers/vfio/pci/virtio/legacy_io.c | 17 +++---
>>>    drivers/vfio/pci/virtio/migrate.c   | 90 ++++++++++++-----------------
>>>    3 files changed, 46 insertions(+), 63 deletions(-)
>>>    
>>
> 

