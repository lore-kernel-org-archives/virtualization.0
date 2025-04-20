Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820EF155A25
	for <virtualization@lists.linux.dev>; Sun, 20 Apr 2025 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745147967; cv=fail; b=r7ydvKWl2fHkkmSAx2FEOERMSfP+bqA+oqVTjnIzJKY6BsCMKQFex7+1B17KKiys1/ubbOwGk4qH0IumikZrbgN4noBMY82zBagGt6B26POCLUY5IQECu8FcG7ZTph1/0v2JNq8dvAGMds+admbwiVIxd7S6chiZKMdE4VXzUjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745147967; c=relaxed/simple;
	bh=9drNYT9pFuivDINJHn9XqO5QcBROvLJtllu5/3pwcbw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rx7aCbGGcgDS08A6dmJl+9ICUuDanlXMvtDph3FKWu7UHnndhdCT+4unjKSkn8Z27OD3gyiGdbpE/iZ783CJZvkRqmHa45BEiRVI38eVdqbO0zWYNwtQVtCkuR5LE6rYaZ92+GED0TOOoIxf0nfJ510UOsWqd7d6odqXwanjJgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FfaVpjpG; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FfaVpjpG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMUebAboZCSzQosofNDFLw/3V9NKhkZEcdqBDxI/J8ntWTptiIy4dFYKUErTdoeC1w0wKxzU9QbhNzk5YNTccoKbXbTQZEgD7B7ZCcmIBayeWtCPxYN4krbLY58ClH6zAQ59l+EalcXsOUPqGtUJpdxva8X2Fo9Es6YBadHn1efUgxA2HFn9EekIKVK3h6jZEEIfrE2U3q4R144Ph0UnCbHx0+5NkaloYM8UHIcy9PX43c7egyh9iypFh+vLPnxA8MMxgb+kSV2fL5Q4IieAYAKk0U7IT5Y6Jia7Ytw3Iy2CccudBxWobRXxWjGhZEzQu43wNMGTUQ45k1CE7cdsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPJSrLtLfaypVosWhILVWoOltvYsqjppUv5W4qq0hqc=;
 b=YHSKElUrfAQq/UnVguQ3MPqrxclgiiJExAn6n5s5I9pKcK8LXWufrBKdJX2kA+5CP/4eXUXMh6Amxh8mkRkgoGoawbMxEqEgFp3I1SRsNB8yzP6DAVs4NAy3ijFU5Uy3UNCtSKKOXQWrMr+XYNPBZ83lLv2KctxI5C4PADIBjcysDPs6rkp2sqv5kmInFldtb8iFKCR12tDHD5VcR2bSN94szhUNqMBZFdzY8jwMAkGO549m+lavZXOPDMVeTv0GRfFV0aT6fGYZau30lUsS9i8s2ihk1unWu8c0eR36E22VFQc8Kf+EEbD5z4s/as1qcN6TsDvS1dHMTb5PpZuGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPJSrLtLfaypVosWhILVWoOltvYsqjppUv5W4qq0hqc=;
 b=FfaVpjpGvm6GFwCu9mCFQ2/R1RMIpVYnBkj5h0tYOEablUdDJddxq+sAHpoeaUhLbuVIQymFiXTZvMEJ4ghxrQIrpmpGSgAtBqy42k0B9L08hohTibWQOHHwQZLKjGKb6W8lT4NHN5rOK6qJl0ciYKpAMqun2vVSPQWa+0xvyQgvD+xyJggj3d3d04h2DTRFFsjH2DjVxWs4GDj5bwLo4eRG2bn0FQaubBMeAQpx6mEplAN1flXX1KMHO50uJ62dcHCiJv3G2Zj5GzlW8SIR4mqQ2j2FMYcN7Tqzr+gY190uPZwGi7LDrd/M3W+3DR5/IUyYFmPnRATiZIquRFd5Pw==
Received: from SA1P222CA0166.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::10)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Sun, 20 Apr
 2025 11:19:21 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::58) by SA1P222CA0166.outlook.office365.com
 (2603:10b6:806:3c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Sun,
 20 Apr 2025 11:19:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sun, 20 Apr 2025 11:19:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 20 Apr
 2025 04:19:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 20 Apr 2025 04:19:15 -0700
Received: from rsws30.mtr.labs.mlnx (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 20 Apr 2025 04:19:12 -0700
From: Israel Rukshin <israelr@nvidia.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Israel Rukshin
	<israelr@nvidia.com>
Subject: [PATCH 0/2] Improve admin command handling and result
Date: Sun, 20 Apr 2025 14:19:03 +0300
Message-ID: <1745147945-194225-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: ce55f38a-7c55-47c7-d8f6-08dd7ffd32ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Iho8w+DRKvJdimUCLsymR2FgVgiPWHGTuK8aLzVF4YhNoeShStyHUvxfzYR?=
 =?us-ascii?Q?1/+/rCkBdeMKzz0fhx1tCyphl4eZsFvKJhrc/QWPXts2Y2zGSRi5ndmKY/vi?=
 =?us-ascii?Q?U3mPKuVnhBuihvdXvyzDhqWrdKMApJqRYQI1tO3IA74tgFsOGYp2gmAJNk1/?=
 =?us-ascii?Q?1entBTYkfYP7AYTOosa2ECdVN/riYqQLCctcp41GsD3CKbmiAZw1b7KpzXbG?=
 =?us-ascii?Q?oZg3rLuSWkKhSpRKtwgB9sRMcpK7UwbRYMio8tq0ynas8AVf43YfV1feRWn1?=
 =?us-ascii?Q?x14+ajOCz0oR00tuhjvoMyFSzERYIUibGYWlx+2dikpYsxAZBZBHAHVKp1YL?=
 =?us-ascii?Q?WVKtiqtKq/gyz/lselLsr4oLx5in3GsGbUORo/WBiziTVPQYiiDJlP5+PHJu?=
 =?us-ascii?Q?U0QSxdUoJqmQyHNh1JLq50kzEhIVG36fNtIUnc1uqs7OP0zt1zfwvkCx1Q/5?=
 =?us-ascii?Q?jrpEUq/hk2SRE/MTeafLf5tUK54L6r+3oBRHYeASuMmuc/vnQzPUL7pkVgNi?=
 =?us-ascii?Q?EEDdWGOA04bMivp3DNLkVM6LNXcYq3O+ilXKfzZ69ukjCIfExKEmbsPJ4Hg9?=
 =?us-ascii?Q?eIn9V73WPnc0r0rev0BjgMf06fzR6f2SA+kY/yNVocmooBnF1NUUAb5wm1Pd?=
 =?us-ascii?Q?KVhZI7ttL8RQPX3jKf+KyjMNhBJ96ah9hnjvzDQ+T+pfAFQw2UNlT2aecl+L?=
 =?us-ascii?Q?jFYdxuDLrk2Yl6K1zQ/2zmRpwF2gNDfAhG0GrfFi7pNIPyJGG/iS6DwBC6S9?=
 =?us-ascii?Q?/zwKDkJCoEXQ7T3/3RGdCZbSiku5pe0kmYwQMFp9W9F3a6EV/ADc+VRc285L?=
 =?us-ascii?Q?jOH2rr+xdfBquumsWuxpj7RPqZAL8Kc3sfzeO1MJqVxHXHPWsU9PnGjoYRGA?=
 =?us-ascii?Q?v6cFYZNnRPpTAVdsTdCJ6cnVXTBqi1L18PfJehzH6J9oM4BbOfL0sfskjIIA?=
 =?us-ascii?Q?n2r80TacMzng/OJlRr62alA9iIlzLLa9XEV9UCojoc5t0U2mYqGus7m4a6m/?=
 =?us-ascii?Q?4IqSOnO7mIf+9IqHleDcvwrvT6VpKZ5L/uucrsrFYc9uL76FOMng9HsxdNve?=
 =?us-ascii?Q?kwqFFmAoxiXzCrTSyZ5uhB7muaDWmRYxnL2ADowU01czynH5/lv6iB4jtMCx?=
 =?us-ascii?Q?aN0nCgky6vUgUzTnq4gqWgRtpHSZefoSkEdAhABZ0ns7LluYFsrqBEb6Dp3J?=
 =?us-ascii?Q?XD/I3vTyW0F/AKYbCKEv+MW6+SxYzOh1AKlov4hW4PspfASAUDSostjstfmP?=
 =?us-ascii?Q?QIXM+kUvjuH55jSNAItPV+rgT8T/VfwZgq2050MDiVeWobYDTK7fTsyVskzb?=
 =?us-ascii?Q?wpFCuDQzSwKIF6mdTDKnb8A1QnOHf9b3PA0K5uK/XhZcpBi9aYm59Ugl4XvV?=
 =?us-ascii?Q?drkOBtEHpe/y024iCSb3iPwgyAy3mx29oWiQDiXDs5rqmLCCIyl2P0sIssrL?=
 =?us-ascii?Q?KHRtUUEcMe4v08JsTz3qXfGaS/WegoK4hk3BBwaGMXpOnscPUsj4cVkEgUF9?=
 =?us-ascii?Q?pr57hTTbUXC8ZpEPXcy7hysWERvDiTbwuTds?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2025 11:19:20.9944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce55f38a-7c55-47c7-d8f6-08dd7ffd32ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946

This small series addresses two issues in the virtio-pci driver related
to admin command handling:

1. Fix an incorrect result size in admin command completion, which
   was causing issues with state transfer and buffer allocation.

2. Add a safety check for the length of device-writable portions in
   admin commands, ensuring compliance with the virtio specification.

Israel Rukshin (2):
  virtio-pci: Fix result size returned for the admin command completion
  virtio-pci: Add admin command length check for device writable
    portions

 drivers/virtio/virtio_pci_modern.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.34.1

