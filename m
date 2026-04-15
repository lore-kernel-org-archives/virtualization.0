Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58933DEF9
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267622; cv=fail; b=iUw4OZpBOkZOV/rIMqEmYdeTL8yJg5JOb8udXdNd5KF5eshojek5hh5XXT/dDvYM38q8a11ND+zl2gM1iaHGbdc/EChF7vkBByZw1d69a/nGge9xc0TiwCPvk5Qih2sTWnOqg+Es3nKV5uypttJIm09XudGUkzw5994ETd8Q1LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267622; c=relaxed/simple;
	bh=QGe39Jf4Ozy3fzPyeWVW31vQ4T4g5XgOgN0zYWJXZRc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAr260Nk2zPSy+p6HDrwlQmGEaLBb+cFS50OlfTcJErQyei520Gh4kjiTPENbz62IsVKQvJTIdX+WwQ5N2LTHkVJ6b5CPmH3Paosmq1JriF8zRAv8Is48/01vEwJrEE2AdKFu4Ch91GmzGSLG9h06sdlpOkfIaFevay2JHhyZII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SQNoLj5g; arc=fail smtp.client-ip=40.107.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SQNoLj5g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSxH0/XN9demSdnVSkkqw77g7KirPyEv4T8xiS7OLmS3v7zdLOMHoMhM/RBuNGpxgqm6RD3OiSYVhQZHnj7dcmPRdM13ekA6y2+ysaV6XWqzXxArsUV1vKtsfiYdkwrELFQfLSYEyOcbmY2LyunprSgG5T3XLVv0zDtVTr2O6EhFbI9ifCUbVorKxXVfaVgJ5OgWqhD1HQDDb9t7EH58v4UM8TtD3TkMS//i6bMj/+4KBa101xG4Pi8+3NUFT6KjHu/qvW0f44iBt1Pp5FAzsRVXu20cK6yoydqtl/5pN/gTZ82m5w/sSImN5isryLRMEx4FX8cp06DsG5tuccIO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgVEiqRSSVAcGniLzurO3gPSXO6kl1XwCEDTBqn3oYw=;
 b=mfCzqw/g8w4a8f9puHM2/KyKvj1MSpbOtqwYlMP7bH7iP3kikZ0m7wu++cgLonHt91QTOrH9yP8faDQegEThbaMvatjazLm0krEGEOA9WTmMSsmPL3DpZ6Jqda6/nGyeSWI2hidtyjjItCZWujc7YGNothFsbso1dv+dPD5yhK04eS8Ao0/miztjmtRdYgdO44KKhVbfqmwb/jWzIQyouRXz4pL3jzZhX7tPcIRhHyIZkGjJ2+alUfBH8v9gyRX8D3WFBfqpKfmVD8H6huSzUwMCy7bdp9PUJVKYG3QXcQaf45Z/e4SUaSU+EtBrhdMjx3PrDvjwQ+aMU2Sidipsyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgVEiqRSSVAcGniLzurO3gPSXO6kl1XwCEDTBqn3oYw=;
 b=SQNoLj5gAZLKLCKCRuAxABDOdJhO4ZzBCviHHRmiLAb2AAZb8gR25p/7aT5ui9UCTB8VOSGhwneuI9wso5xn2TOEwqxI9aj8eOJ235lw2K1UvCN8TViGqgelcwhd9xx5+BszDCz2LmcR65WR9kd8XrJjKnKWT8R1/sYjw2fgYJE8zM/wefVWDSHvZE5jOLwYmDEU6TR/0xkp/hcWta4mdzc2vE453zikw/3UBHxBkdK4di89/UQbJN4pio2jdIlbc1zcP2OZd3nhM2z4Z11cd5vu3U4Hz5LFyC4e4YIGOS0zsli1HQDqFPXXX/nKN+tlVdee9B0NjFrXRqrf4ixo5A==
Received: from PH7P220CA0070.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::10)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 15:40:09 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::a3) by PH7P220CA0070.outlook.office365.com
 (2603:10b6:510:32c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 15:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 15:40:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 08:39:48 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 08:39:47 -0700
Date: Wed, 15 Apr 2026 09:39:45 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: Yishai Hadas <yishaih@nvidia.com>
CC: <alex@shazbot.org>, <kvm@vger.kernel.org>, <guojinhui.liam@bytedance.com>,
	<linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>
Subject: Re: [PATCH 0/4] vfio/virtio: Fix list_lock type and modernize
 locking
Message-ID: <20260415093945.36d01312@nvidia.com>
In-Reply-To: <cb38037c-9fbe-4a10-9538-1dfbbb12f330@nvidia.com>
References: <20260414200625.3601509-1-alex.williamson@nvidia.com>
	<cb38037c-9fbe-4a10-9538-1dfbbb12f330@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 6410aaef-37b9-471c-929f-08de9b054688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iwGftislKP511BwDmDRKjp1HUb+kZkzfh4D560JHdx7bqFfY7KDHW2ry+2XOrjVz1YSAFF0IFLWKeZfv/G7QvU5ElhZUdNTk3eDlfJZaot88hSUUg+g6yjVq1Pr5/LpkOn2y+zcnhPAeLKfm7pXFxT/7VcBGZ89Vk1MvGM0+43jrEXr+fC98DXd+57BZOAONk0s0uKxVgpYGLt/FkS0Qw7YpjC4TLj7w+jNni29JtzV4fjaWkzotSter9xN2uwC51pWyfvg4e19Ews3qdGksIYWLYG3p0hkh6tW87hsH17XjtgQSCjZ5rwLI6PPmIwES3305BUAlxtS40Eig0NKWVczuYbjpz0d4YYA6dumNuFhBzLgi2HSXbRiYZnJaZzXvYALlbh+OpIOxnwztzZdbcEmn0SxEh8R8J1hYMIS+RoIUX+T2X6oW2VM1yJnWAL12bYh8rhI4uDP0X66tsoSmgvSHjThSG719nGintFRnylHUIY7Lz/X1rPRtcryjAFwi/Nliqprkr7vYDnakhTfgMIKhZyBJosskiDS/6PuvHjlpE7FXGpL97qnCfUxrnw3dqbtN4JHMY1fvACjdJZumszsJ4bwLUzxOf8zTarSxq/kTuZsf4bvClQ+3Ct9F2nj8S4axakNTkZoI5Z2fYQjwkjh+ntKpQK2jrMfyGaiZFBgSmuMxOuiBnVu0X2C9yOTagzGrEuElJZBuciUmp5ndcD4GjxOmvLcchkdDb1dFl4+3yKqVXv+czmwpK0f8/T24ladp71LXViM2zo4zgVD4iQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WDoSXKyzPH2KQrr8FKBSNREd4zu5aIrV7g1eNKHCYX2x/BPheoIvsOX12fZyxtThXixQuASiwbzsm5FXBN0BisOtzTaBNA+nc025n9/brIuK4xfFVi/ybVs0Kpy3iMMbGGazbBwShg0aN57u0lLw0sMtVTZOEwiSx9irnopWR5Ci2TyOqXAJton3KerwEjb0Kh96JdH7QHQStojSgegd/wvAKNcQm9YOasE1Ku/g62bCqH9L4B+z5DRqmKorqQWeNOIr/dN7A9CV0MzJivV7KxaAzAtpWDgwzdOxjvk63p4Mf3+aIQmeAwVohScBRGF9UPXLfLjgkp4u3Gb6Xo6/WPutZHabN1fQxKmPA1xNNcZCG9Y8M34d7JDFNGPVAuU1EkTsRfWOg0FnlmqlO2+P4tGUOWlBTQKkkKaOW16Wy5NH44A2sWX1D5c1jEUKhUyT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 15:40:09.2274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6410aaef-37b9-471c-929f-08de9b054688
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055

On Wed, 15 Apr 2026 18:12:50 +0300
Yishai Hadas <yishaih@nvidia.com> wrote:

> On 14/04/2026 23:06, Alex Williamson wrote:
> > Jinhui Guo reported a mismatched spin_lock()/spin_unlock_irq() pair
> > in virtiovf_read_device_context_chunk() where spin_unlock_irq() would
> > unconditionally enable interrupts despite spin_lock() never having
> > disabled them.  On closer inspection, the list_lock spinlock with IRQ
> > disabling was copied from the mlx5 variant driver where a hardirq
> > completion callback justifies it, but the virtio driver has no
> > interrupt context usage of list_lock.  Patch 1 converts list_lock to
> > a mutex, fixing the mismatch and aligning with peer vfio-pci variant
> > drivers.  
> 
> Alex,
> How about staying with spin_lock but without the 'irq' variant, instead 
> of replacing to mutex ?
> 
> The scope of the lock is very small which can fit spin.
> We may potentially get a performance degradation compared to mutex as 
> part of the hot path of STOP_COPY where this lock is used.
> 
> Note:
> I don't see that other peer vfio-pci variant drivers maintain a list of 
> buffers as of this driver, unless I missed that.

The argument doesn't make sense to me, we use a spinlock if we have an
operation that cannot be preempted and a spinlock-irq if we need to
manage that from a hardirq context.  I think we just need mutual
exclusion here.  Stealing the CPU because you want the absolute best
performance for a little bit of list manipulation is not valid
justification.

Documentation/locking/mutex-design.rst:

  When to use mutexes
  -------------------

  Unless the strict semantics of mutexes are unsuitable and/or the critical
  region prevents the lock from being shared, always prefer them to any other
  locking primitive.

Can you cite specific requirements for a spinlock in the critical
section here?  Thanks,

Alex
 
> > Patch 2 converts the list_lock acquisitions to guard()/scoped_guard()
> > where the lock scope aligns naturally with function or block scope.
> >   
> 
> This patch might not be applicable if we'll stay with spin_lock.
> 
> > Patches 3 and 4 extend the same guard() conversion to the remaining
> > two mutexes in the driver (migf->lock and bar_mutex).  These are
> > relatively independent of the list_lock fix but complete the
> > conversion across the driver.  Thanks,
> >   
> 
> Those 2 patches seem fine to me.
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> 
> Yishai
> 
> > Alex
> > 
> > Alex Williamson (4):
> >    vfio/virtio: Convert list_lock from spinlock to mutex
> >    vfio/virtio: Use guard() for list_lock where applicable
> >    vfio/virtio: Use guard() for migf->lock where applicable
> >    vfio/virtio: Use guard() for bar_mutex in legacy I/O
> > 
> >   drivers/vfio/pci/virtio/common.h    |  2 +-
> >   drivers/vfio/pci/virtio/legacy_io.c | 17 +++---
> >   drivers/vfio/pci/virtio/migrate.c   | 90 ++++++++++++-----------------
> >   3 files changed, 46 insertions(+), 63 deletions(-)
> >   
> 

