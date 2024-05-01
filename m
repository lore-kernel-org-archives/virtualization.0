Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4D12F59D
	for <virtualization@lists.linux.dev>; Wed,  1 May 2024 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577944; cv=fail; b=p3HGmUZSZQtG11DurErNztYKK/jRvsTAcAm+CkcTHhG0i/yJMf1TmkYwszmLVruZB1nkhh3AFXIB7G5OyFrVERUj7LL0qsujMbg5qI5tPxg31lZtr560klT7IapyZte8iaJ3wq6MvVhci7z/6nSokb23RLor6Kf93OYbnia5mlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577944; c=relaxed/simple;
	bh=1CgaeeW48V/Q+10QFEdZ2ho3/1V0E6kqtGsmSEL7DGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYHK2pCjm4HCkEUyKOEwCqAUxwMZ2XcaSfPlkkYzzyrw9JV4uMl+/KDQ9DEtG31cOZDTMDPUn20DbdyvzxU/0sFMls5+5obF2J1KZXPKzgrzzgYcbwRmz2OTfTh8Tmpj48KwlSZ8j/uteiXRrOdQS7FOHwTON6vT+hYhxy0Dges=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dTcZvv0f; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dTcZvv0f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgA+G/vYUEFyMdlUN3raFzcAd+RSgHXSq0dX19dfp1Xq4DZmTA5PQJMVR+po7cp39z4dxlwaHM2UgYyzqe+JXvD9YUV1gZyr9uOO13/B6k5m76yIsWkka5cgYYeZno8N8xIosAEWWAUijBeU7DQBE3+k7NIymwaqE2YEDdCesuN1+zeJaDiX4eODNpQI5HJ96Pw2kuNjAVFmx6tA9aFCfsatSO7IQivttaiNIuIt0X7DqXv6z44gGHmk1TPHVsKFBZutBOp3NfYePcAQimhtlsXhzcgbZt94dwHs8DHHlk1IAGGZNvi7AEXhyo1dVQq0R1sU+qHBYVCLvE5Kpy9nBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OigB+zNLOWQtdfVDhsSiCs6D2w6Rvh/OUkQwvF9T8g=;
 b=NyhyRamkbtcLwv4K7OWxI0dEP4V2Na5sx9PukM4slKrwQCO1BVYJ9138BUX7UvJBcXnrtK6CBl7KYYPuKkWpajxwsoiRS2n0xxwCbyd9ySFqm3eiGxBilZrgV2mEdtoQlrGYOuGW3PuSuEQBZ8CB2uT+HWotsm/kyNKzypYaS3LOVBaJ/tUZE0Dx0pxwEu3KetIYEn66N62xtVof1JVszopFLmEb6wiUlZ0puuKkQ2myRhkrLq8XC9riC5iPrRJNEzIm/Hwrr38Iq8V9PSvmLZosDIiiz3nTTr9XJhO3eZpGlB6yKk+vkXQhDzRDMl/xD3weRL71DOvv43BLZG8zXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OigB+zNLOWQtdfVDhsSiCs6D2w6Rvh/OUkQwvF9T8g=;
 b=dTcZvv0fu6HLDPVmtz/xwpaZbWJWF2VwQfaWOae/134tAHuB2vvT9/qLnYuBS4MeM94ns2bWG3D+I96ubDnlr13TBaw/s4rzo0TAHB8CypNeoJssHOQhTet5jvnQkP/ZfI9POCN3RJmHpDKw/Lb2tIRFECYpVr8WtEl0sWIngeixO0kqoUpjjbNsrjQ1Gv03f9k6ADJ4FynkOjj+hHi27Tk6Fyix3WUmXxT2tA0JNoaXekz1XUp2XsU5q8fGkQB2lRRVoJLkGlU3xk0irjtVVVl9KFM+bhABNb+en/UtEILi+KZ6x6AzI7oz/mGZHQsvXH/UJHz/pZJF7wWYNW44ag==
Received: from PH7PR13CA0001.namprd13.prod.outlook.com (2603:10b6:510:174::7)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 15:38:59 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:510:174:cafe::c4) by PH7PR13CA0001.outlook.office365.com
 (2603:10b6:510:174::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 15:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 15:38:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 08:38:39 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 1 May 2024 08:38:39 -0700
Received: from localhost.localdomain (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 1 May 2024 08:38:35 -0700
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: <virtualization@lists.linux.dev>, <vgoyal@redhat.com>,
	<stefanha@redhat.com>, <miklos@szeredi.hu>
CC: <mst@redhat.com>, <dgilbert@redhat.com>, <yorayz@nvidia.comm>,
	<gurtovoy@nvidia.com>, Peter-Jan Gootzen <pgootzen@nvidia.com>, Yoray Zack
	<yorayz@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/2] virtio-fs: limit number of request queues
Date: Wed, 1 May 2024 17:38:16 +0200
Message-ID: <20240501153817.540855-2-pgootzen@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501153817.540855-1-pgootzen@nvidia.com>
References: <20240501153817.540855-1-pgootzen@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 641794bd-62cd-40cd-3d4f-08dc69f4d19d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400014|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?coJGNmShaudQRjHvotfVqLA4YzFYvDN1ifTEprtjKsf2lLEr/9jEqhH20urt?=
 =?us-ascii?Q?wHmkcg4cCKcTk8HCQTQlj2/Ukl0lqjoZUhlqwRE8tBD6Lifg4cLxZzBi5VsC?=
 =?us-ascii?Q?VtMfoLsGI/f5pLx0FAubFBRwBD80Vdupu6BJTRzwV713kK/GMnKOTRFI5flv?=
 =?us-ascii?Q?VwE2+OGP4ayALCyrJmkI7e0HxqC3EgTDZvtKMPtoOD2dMyBdYfpFHRNsyKbr?=
 =?us-ascii?Q?BlBt8FndZnPIwaZu6qsL3ELsjeYLJWPFAQKhEEY+NSLueP/B2g/wlLf6rQDt?=
 =?us-ascii?Q?wL3J1k7ank2kGvObfc+hIMtYgAHvZZxT+8HC297IQL7+NvrUUIb4NyM+rVqi?=
 =?us-ascii?Q?2D6apTKLyxcqu3p2HIJ8xi2XAFd/cCKOu++bcMTDsSvOtj7QwsQ+c0Slsh5x?=
 =?us-ascii?Q?LR4t4uvBFyOyHjbFSIGooiiRWJZvBl1kjkxq1oX2HMZ9qM1ItUc0wskvx1Lq?=
 =?us-ascii?Q?7guJuwlwWCLY6gVnKQbDReXBEhI9xd9+OWgSj4Hig56ForbJ1aHtoiuhMAaX?=
 =?us-ascii?Q?AfeRyTOOnCIHY6sRXUV5YBinjfu6sGBt0dff3CtlVqlsYwOpiEBnsKQ2Icla?=
 =?us-ascii?Q?uV3rOU+u7ZJTR9+OcO82hX7Zfv9ErD3aSt0XChs2oad9P7rPVti0W6HWHORZ?=
 =?us-ascii?Q?faT7/XJMMWUQPX/0wFA29Iqgok1rNQZcxouCUKKvNlcQK0Aie3OIVO1pBBF0?=
 =?us-ascii?Q?ic49fwaAzgKn5HGbqAjfcsQmJYtfS9UNjjDGUDlED5UezT9S789jMQ44c0q3?=
 =?us-ascii?Q?5pkE+oR2AQCjiY8IErQbRRlVOqqi/42184C51Ffa5UXrOMcOpWErW5WGu5oV?=
 =?us-ascii?Q?6HkODO7/A4Otu9ZD0/eZc/SoAqme8yAGFGXUWl/az9/Ous0TZuF7rog/+W30?=
 =?us-ascii?Q?zcFIxo+X+g1EwzhmFU5bQijQesrdEAWuyYcewecqv1WhINVyjnn+D+B6IYAD?=
 =?us-ascii?Q?LiN8chfEUSA/TPDqTBM8h8ajX3/4ZAhF+jsfHvIN8qk6a550dCetcbOqGaqi?=
 =?us-ascii?Q?4x1OJqMDLXTkHjQdIs0CaU7Vn8Lc+qDIrv5pIxOthQoaGYUR64IOoKfYEn/3?=
 =?us-ascii?Q?7I89302pZYP4hQgwbmWil/LHHrZQ6yMmGQDolGFZWPVA5VB6ZjbatmUfsWBL?=
 =?us-ascii?Q?2zSOrIEwaazuCnCfpDwMhjIq5yQPATKuG1ELoP3H0taHFfDMIAOysfdSZImY?=
 =?us-ascii?Q?E7FqunhPmochwefukK9d+MDPvro5aiOGhFleoUTRo6B7dpq3AfuvwbbUhoRH?=
 =?us-ascii?Q?v8mAFdYXRTyeVAOIMPkvItTa97NDWwUkOLlFaSZ6lZ4YRYvvJmOKr7hib9/L?=
 =?us-ascii?Q?LeKUALYNNtnulvHmBE49HX6SBIaqW5soOGMiIdjoWTaIWgQ0yr7sVDi4aF8j?=
 =?us-ascii?Q?dSy8p4N9MwqVP+Gcou11s68/cv/y?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 15:38:58.8666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 641794bd-62cd-40cd-3d4f-08dc69f4d19d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448

Virtio-fs devices might allocate significant resources to virtio queues
such as CPU cores that busy poll on the queue. The device indicates how
many request queues it can support and the driver should initialize the
number of queues that they want to utilize.

In this patch we limit the number of initialized request queues to the
number of CPUs, to limit the resource consumption on the device-side
and to prepare for the upcoming multi-queue patch.

Signed-off-by: Peter-Jan Gootzen <pgootzen@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Suggested-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 fs/fuse/virtio_fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 322af827a232..2745fa484dcb 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -751,6 +751,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	if (fs->num_request_queues == 0)
 		return -EINVAL;
 
+	/* Truncate nr of request queues to nr_cpu_id */
+	fs->num_request_queues = min_t(unsigned int, fs->num_request_queues,
+					nr_cpu_ids);
 	fs->nvqs = VQ_REQUEST + fs->num_request_queues;
 	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 	if (!fs->vqs)
-- 
2.34.1

