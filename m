Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA41C3029
	for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721051; cv=fail; b=Yglxpi6aQEmM2Dfc8G/xG4GQNMZYnSlD5Bh1PY6tJee1+3vv0ZqNPI6GP3Ygob2vVPnbhp9NRhzVUWBHoQSGm5XGAu/5EUD8qMFaTYD5aC0L/94Luv7hxXEeBRpYnf+IsTrsFWCHa9Hz14D+PXPS5umONY59qxAE2CcFK8g8vgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721051; c=relaxed/simple;
	bh=+yoPK2GkB/2ho7lULS3bDY7XJrpCA5Uhcdn12QF1Eos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4gEf8jK2U9Yy2QjFNSeKKsLN5vu8B2lrmxrE0NRW7X0P+I97dU0L9TRMoTD4msDVrNy7eQ3cgB1d8KL5dKR8HpEzdEJeF4qoX18hzUtwqtvvoVDLtMUcneJzCAa1sAb1d5Lwtutyl4djC1ONEyNEZoApl1YUZBOEE1yYd/TSGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r1cJXlhF; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r1cJXlhF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEu4LhcPDWob3Q4tHJMMos0FGZeKj4VImQ72SQxfo33vhJsKX/sReRK93VnC/BbynrR9T81ky1wH4Q9+DYDKepdHrkCe6DN/aqlckAwEEJA//gFR48aaThIVMrFFfqNSsiwGh9OTRNrKvFpyg+axDl6saMT0s6+P7W6AWl3BwF6Q8u/6lQJUqmLe2xOX8V0FSUInMrkJXLQwJWhU/rV4zHYKx0Jnm7NcAygVyRpbDQfpWa63Ho3PEoVj0tvxaK6bnAQ0MWZsTVwkeZw98VJJLwTuBrQz7P+9Qdik15Ub1ycW+jZgvXn3+ucO6ihzAXKqGa/hQPj1PRWK259sUblQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtnNMx+vUKghdlfJoF1WVzFQstzpC4C5t/ZIjEViIMg=;
 b=dcSlIJ2K7uri5sTvgNHkMiGnZz8+1VR7gg90O+iRP3OTq9aBJOi7Yt+WYLYbFERVcfz9TIkCn2v0pKyWz+gAI891OB+304uGxF48wybyE7fCtaHgC7slkz8SBA8yup9FBIvh9QU6dozYZeDp7CHhqnRM980OTEdHW04lZC5hZBEg4/z8/Een01qs4xgpTgQInYhtgM9hVTBiol6pEDKxOdIVLEBhE/YX5Bq0IjJfj1cLDJoncvTPhPM8YenTcUZd0fl1Iz8cecVtQIgYqMx534Xf0jX59aEbzl6xT3C1Pw7r9ulXMmZ1yLNZsErsvUbqOkDcZaEM2gicigPNNqdPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtnNMx+vUKghdlfJoF1WVzFQstzpC4C5t/ZIjEViIMg=;
 b=r1cJXlhFuNIeOKo0oyNOUvTXJ94aWPhbJIaU5WlAl/lS28crty7jfFfE9a8/+xsH3lsb3oHxastmdw+1dx4Iar2KssxhWB+z/r8oIgbYZ7vMWkAt0NuDYhR5c5kGRkiQiwfZKigD5ZFkjXtMHaBE+BeieXpEHzZx/c1QhpcqbiE=
Received: from BN9PR03CA0208.namprd03.prod.outlook.com (2603:10b6:408:f9::33)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 05:37:25 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::a5) by BN9PR03CA0208.outlook.office365.com
 (2603:10b6:408:f9::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Fri,
 28 Feb 2025 05:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 05:37:25 +0000
Received: from jenkins-honglei.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 23:37:21 -0600
From: Honglei Huang <honglei1.huang@amd.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter
	<simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, Huang Rui
	<ray.huang@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Demi Marie Obenour <demiobenour@gmail.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Honglei Huang
	<Honglei1.Huang@amd.com>
Subject: [PATCH v1 2/7] drm/virtgpu api: add blob userptr resource
Date: Fri, 28 Feb 2025 13:36:45 +0800
Message-ID: <20250228053650.393646-3-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228053650.393646-1-honglei1.huang@amd.com>
References: <20250228053650.393646-1-honglei1.huang@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b04740-c768-46ba-7c59-08dd57b9fb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yn7MoHz7T9XGB7QPt/NoSDxzeTEV0zNmhcWwVYxThm8npvLk3UaCm1pceHW0?=
 =?us-ascii?Q?QIApbZ9ZZ6Q8UqtVctLIuEom2TJgDC7JXAsmJxTNDbwOhe0wWXr4XoZwLoDL?=
 =?us-ascii?Q?6ZR3I9m/pEE2olZX9N2mjo6y1XrPM8k/5raM8fx+tPEIgPx5vK8UY3PBgcKN?=
 =?us-ascii?Q?b8Ai7MKee/cLHmi5IaAZDFakDimmK7PaudMYjzHk8BH4JtTs9I1Z+eemqC29?=
 =?us-ascii?Q?csS+uuDK//vIdGl3tXBo0RBb96JOBuuwfSOv9uMX3WKTRwBlEzjrgpDHwDFy?=
 =?us-ascii?Q?zPE6keXnMbiwooCPqzL7z979LdRXIP1FXJooqlX3krPdylZwP/fe6cIB3kYf?=
 =?us-ascii?Q?+XmUfBr5Cy5Qeglj5zcC00sjJoO5E+JjWt6xtnfiwWTrb1dLhHBIAQJHqGa6?=
 =?us-ascii?Q?ScMq9uHZ7mc2GmlLUOVExHRevLN7ST23BbZ5k97cNIu92NoKWiLl89K8lbLk?=
 =?us-ascii?Q?4avaVlQ6nlUhbV/9a8J2WPVLU2XyolhfkwV2mRdkNxZhJblLzWwtoGrVJVhZ?=
 =?us-ascii?Q?EVAf3bwV56E3f0GvEiRaNmNj0PLE+nFEZg33bIcpLNnNjxXOZqc5k0TB02DG?=
 =?us-ascii?Q?X5RGXh/EWv74lSClp47Y6b4KP1hDux3JDj67qekMAtD4OkWkhQJOr9LkPwDu?=
 =?us-ascii?Q?b+hI1MyJblPqEmy8PK10eWSufC6ttdzqxquW8906kAZmZ7WKsI0/6nm3jF0X?=
 =?us-ascii?Q?O2jYvr7wC4kbFLaaVdDAUBde3P2twPBWz4h4JAxdGOt22B8aXvSSZaVYHsF8?=
 =?us-ascii?Q?iCY8e37zW0V5pEBMZmPlZW8fZXMPaeg5r6VE70MQQhrPXFjhba/jfEMDWyMx?=
 =?us-ascii?Q?zbPcCJSQOdp0xeq+elk5COeOuLZgAsdMUXJqKXJiQ6E6yuA5x6UJjEMqdKgd?=
 =?us-ascii?Q?Nc+GcwVZidE312ao9cJAgiYIxwT7pD7z51j6uApqduJ0fpNvXKpqrdLxXuAD?=
 =?us-ascii?Q?TadsLR3UUfzCvWcGaI0v67J+kA22t10kuIlkh3l25PvA4snfpd3ooOT+bKKT?=
 =?us-ascii?Q?6GJu+88Sgkp+zEaeFFRenSZ+R/DUfNZYKynVUTYcVVxHDeCmkMtxeibGIkxI?=
 =?us-ascii?Q?bmaYdn/oRVO4mLhCHZ9LH9lY8n/iAcuhvRpNEuqdWFYh8hnCxxKoBV1htvCP?=
 =?us-ascii?Q?vApoOOS8aYiH9XoRSfYxpPF89YUrHkbPOwNdGnr+Gu9QV5o08rxalJxejQA3?=
 =?us-ascii?Q?hi6/0eOSg7t7C4qTAOO5J0RznXDyDNBjcU8KIUjwgvaW97oySUNomsIleQva?=
 =?us-ascii?Q?NDoNyc5abNLc1HDIiNmv4huiz+GW25cOhW3H6p3Cs0mhpy/mJZgsGvPPx9zk?=
 =?us-ascii?Q?y7RyiIMkIXSJ2rPB0BCXsBQI7B/EJLUx/absQa2NAYAULWtr0P76h8Y92b/I?=
 =?us-ascii?Q?AMQvwR7kkMMCFnXDTO/Q6dJ2IfY1UPghmzcWsnNhyPFQzti/5wc54yPgFZWw?=
 =?us-ascii?Q?8AFdjmI350NGmeo92xVo0qYOOxZv4U9NJ5TNCLM7/Z1CCsA6qyYA7w33fk+j?=
 =?us-ascii?Q?dsI3CvRuPhyTDxwmxqBZjC61C/gny1oKoKrS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:37:25.5684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b04740-c768-46ba-7c59-08dd57b9fb7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740

From: Honglei Huang <Honglei1.Huang@amd.com>

This makes blob userptr resource available to guest userspace.

- Flag VIRTGPU_BLOB_FLAG_USE_USERPTR for guest userspace blob create,
enable this flag to indicate blob userptr resource create.
- Flag VIRTGPU_BLOB_FLAG_USERPTR_RDONLY used for read only userptr,
if not set then the userptr will be writeable.
- New parameter blob_userptr for bypass userspace memory address to
virtio GPU, like other userptr design, virtio GPU needs a userspace
memory for device access.

Used for userptr feature, in compute side, this feature is basic and
essential. Let device to access userspace memory directly instead of
copying.

Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
---
 include/uapi/drm/virtgpu_drm.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index c2ce71987e9b..071f31752721 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -179,13 +179,14 @@ struct drm_virtgpu_resource_create_blob {
 #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTGPU_BLOB_FLAG_USE_USERPTR      0x0008
+#define VIRTGPU_BLOB_FLAG_USERPTR_RDONLY   0x0010
 	/* zero is invalid blob_mem */
 	__u32 blob_mem;
 	__u32 blob_flags;
 	__u32 bo_handle;
 	__u32 res_handle;
 	__u64 size;
-
 	/*
 	 * for 3D contexts with VIRTGPU_BLOB_MEM_HOST3D_GUEST and
 	 * VIRTGPU_BLOB_MEM_HOST3D otherwise, must be zero.
@@ -194,6 +195,7 @@ struct drm_virtgpu_resource_create_blob {
 	__u32 cmd_size;
 	__u64 cmd;
 	__u64 blob_id;
+	__u64 userptr;
 };
 
 #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
-- 
2.34.1

