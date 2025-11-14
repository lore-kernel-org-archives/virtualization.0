Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210DD2D9487
	for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146013; cv=fail; b=L9q1tajV4mprihjFX/trUP/O1LP9FNwPDhxL3kRjpyD4EchN8pObYmWiaC8NKquj9GRNXJHSDGJfdSooJdVagACdsNxvBbp8/EfkCjxoEuiKfIO4Cpjn4ah0sjzYsw3Q2eyf2/orvtBIP6ubQT0hxuRFB+TzvYP6Hh/0ziuCyzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146013; c=relaxed/simple;
	bh=xMqqX808TTSKtQMGr4Ie/9Y9SSTONXawAZPvrdxXMuI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LwOHp9+Flv5ZZUzkkWLdfztiVR29G2Lya3GaIV6EOg/Dy6doR7LVZOQllNAdJEFGbdmo+ik9Q6wCj8SnesbmVkHdkaDpjhjtF4OUrCW87vpXQifoWH5CyEAwSL6s4XufnrbORe53Nigz1sRb0CQRdNKgHo+dWdpVZUldfQhoGOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QCq+5ZYa; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QCq+5ZYa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRfNkF/I01afryy1WZjkHnmdXT//mNSEbu89Zt33nP75AJ/QGau+kOeAAGOWLDKJoOmFBx3nkZnA294q+Ysr/7LMe0rbeYCt6aoEmmMUooeQLOhbvmBzsnP4mpQN20w1QncGCYX9csh7rxGbLbB7zV43v7zNgYzbO+3yoyJ24ZC8QSZq364ap23Xr5Qmi5AqCMK3fjPox9aDswDSc6ZdHx0CmtAqww5GDyl9PLzy1ibjXlTVBko0lf7cQfvhZF7tjlyLhhbs7Ws78hBWJ8feVyitTOknjq/T22W46BRgmEG3ymaZf2tpHl3a2Pd420LUeN0Xjsj1ovs/eAUxza3gOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBZm5YAVL8U5qS/Fi5kyk+1GDYZZ9Tqf4giK+l+qVOk=;
 b=rEOmmaYx7RgRvubkJmY+MQrLO09o4mHOrC/vG7JZYDYkaJ7xQ1nU+JOyZJi0gxvbR0h/KBoTwAw/oGRmrdPcHXlk5zJzZcDL/Z3zwV23NU1oDyMeBjfhBxSgRs0ung8+jlTB43ZDtIZxSWQq5mGzEgGQByNFYBuFYb+mJeobP1ld3yMFht31nIy23AE5WDGpCdMTNUtfNtLKEbjGIqWRjkMXnCSnKeavVpvGCW4s65wrECqGuUtIk43bOkU3dB9YK5A4cUrmw7PVeMXdG6y4mFoxPk4L9sFV1kxKRakuH53wKd9dMOoZFf+VmuoXKC9BDPTq7us5hZhqWhVTUrglZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBZm5YAVL8U5qS/Fi5kyk+1GDYZZ9Tqf4giK+l+qVOk=;
 b=QCq+5ZYahPuXuhK1IYYBNfnUiDwJ3O5XhTf35/q8najL2BF5HSCa77UIVRKR7WYJjTjO1kvDwuNDoeW+8B4mjAAcRAoeBAW7gwUvSDP9SIUfr5OqKp05J8tbfYmyx4x8T0S6mcysmc37ssrqjQARQCtaOfrcNodxPcIFly1845o=
Received: from BY5PR16CA0027.namprd16.prod.outlook.com (2603:10b6:a03:1a0::40)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 18:46:48 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::81) by BY5PR16CA0027.outlook.office365.com
 (2603:10b6:a03:1a0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 18:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 18:46:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 10:46:46 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 10:46:46 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 14 Nov 2025 10:46:45 -0800
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <mst@redhat.com>,
	<jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <xiaoxiang@xiaomi.com>, Tanmay Shah
	<tanmay.shah@amd.com>
Subject: [RFC PATCH 0/2] Enhance RPMsg buffer management
Date: Fri, 14 Nov 2025 10:46:38 -0800
Message-ID: <20251114184640.3020427-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: cc89b804-6aed-4b4a-7ca5-08de23ae2ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F14zz3tXcKp/weOFx0MBmgfdk3iVuSucxuNQgKsp1mmDYq1QqtQVDMP1tIRL?=
 =?us-ascii?Q?WSjjF/t5wpor92E23RX321nQCfM5qXrkH9PJiQGHXqBJ8mDxJyK0bgZQrwM9?=
 =?us-ascii?Q?iE3uQp/Ckcxn9+tTtdxhRD75iTJ/7j4ILPhOXzmJrhX3acPIxTQcce8vvdjZ?=
 =?us-ascii?Q?+rUlu4GIfvOAWqQWG8UFwQM/VQMXG5/3tOzt4jNrmfswOUl552kUIi8574zG?=
 =?us-ascii?Q?ozcdXtjYWiXh/BFuICcuCtKFg38TtdBB4zfrRQS+fujPQk9hl9uc4FPRYaCu?=
 =?us-ascii?Q?R+E8L95Mtqz7Ec28NamzgmXTb2QS1MMDEqn8PNVbJp38wZehEWVgSVH6AVrj?=
 =?us-ascii?Q?idM94acnPTQ0CSkP0XlXwxLiuCuYiH+bjgZI0YDuNFjUw9DiYiNLw4xyhjDz?=
 =?us-ascii?Q?IWowjQI77uTAc30r/1C/fx0ls6UhNuOD3Gxu6VYUgRO4jOpx7IAtXGB9n+wr?=
 =?us-ascii?Q?UWEG5u9KYyl7UcP2kHY2CGQ75moyePV7jvN7GspAmnCPW5vSvh5LBwMf1+KA?=
 =?us-ascii?Q?DQhhnMHh1oVUl0ucMKrweDOkZyc9CosLGra5FYDjs0Px0p3vs2c0M1B2z5NA?=
 =?us-ascii?Q?EXeddiCBWNQE/Kth2pzdgbou9iGXubHUMVG5J/PKjxtzidwtYsaBu+F471Ww?=
 =?us-ascii?Q?ae4caumpfTdKvwsKkT1PxM6mX3H+kqO8QRNmNMmEXZqjX+izPoBrKIUlRh+5?=
 =?us-ascii?Q?mMromVWQ+7dZxY0TvRXgl6NhWwGIxF31GOXxXhbw6nMbrWGsS1rFgOWGC/ZQ?=
 =?us-ascii?Q?e8+XQ2t0Cfthu2kWE6ozM/vUiqebYZIiba1srY1Vu5NF8e6gIJ+BZbuul1JY?=
 =?us-ascii?Q?vrRH+Wv7HyE/QjiIN1TIOxzWnr8qGUCoFaeGSqyCqZifM1eRNRQXxbRDQRTy?=
 =?us-ascii?Q?jbqEGEJD+SS5VGQkQ/ZSW1vj1XWXg2mYLIjITYwCwxCQdErJRsjGOpBXm+3+?=
 =?us-ascii?Q?OG+V03ylhZIqGvDRW0Sg0mgu+fZl+ivejq0dQCU20A9++0dyGmqmQm5yNDSy?=
 =?us-ascii?Q?gJE5+rhGFXvyVPDlfvU6myGeSzdTkzdzmiwJ/B8/ByLwGdwiggIJqd0v203M?=
 =?us-ascii?Q?H1Y75kdY05YOghfNb5VgNCf1h0hv9N0w8fJ50Y312fCQ18xZhowXIBzEHQah?=
 =?us-ascii?Q?PW5EzqRZdTpf7WeK/Q2O8YD2FNvJtTtetVRqXfJAifA8Aid/Fn2waJwZEMuv?=
 =?us-ascii?Q?06j3CW3K5LiLTe+LOKC19jen8l4AKKzWJL6VNKoF+TPU8ntSD/1DKDQ9GIwq?=
 =?us-ascii?Q?0MkoT1VXaMPByCi03tEMrjt4nUTmb9JQ4dHHbg0WnYwY0CAO+xwW0i3yA613?=
 =?us-ascii?Q?DbUpQr9RsNHP0Sm5B6B3BDz80S4V80IEttVfV1JcE+8HEFz1x0WPtAWUfzWK?=
 =?us-ascii?Q?eT35tTuJGz0LiGPS0uxNAq9Bjbmpmw3ArP3KlElKiIWaMvG6X7FVCvjx15IT?=
 =?us-ascii?Q?sSJrATvW5fvZrB/eCCE1+obFrH4yPQak6dpL93/jZztrlZUJdNlA3Rbrm/Ks?=
 =?us-ascii?Q?kOWKjcKEXQ6zC4GZjrxLVnGN5wWHBvNIGKKyW/t07Eu3nGM9cdvC0AqwJdJ8?=
 =?us-ascii?Q?TAoc3NPiyoesp6BDKMk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 18:46:48.0643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc89b804-6aed-4b4a-7ca5-08de23ae2ac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662

Take rx and tx buffer size from virtio device config space in the
resource table. This allows each firmware to configure RPMsg buffer size
as needed in each direction.

Original seris:
https://lore.kernel.org/all/1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com/

Following modificaitons are done to the original series:
  - Separate dma allocation is not done for tx and rx buffers. Instead
    allocated chunk of memory is split between tx and rx buffers.
  - If vdev doesn't support VIRTIO_RPMSG_F_BUFSZ feature then use the 
    default size of 512 bytes for buffers
  - Change MAX_RPMSG_BUF_SIZE to DEFAULT_RPMSG_BUF_SIZE
  - move virtio_rpmsg.h from uapi to linux dir
  - RPMsg buffer size must be set to hold rpmsg header at minimum in the
    vdev config space of the firmware.
  - align total buf size to page size when allocating and deallocating
    memory

Xiang Xiao (2):
  rpmsg: virtio_rpmsg_bus: allow the different vring size for send/recv
  rpmsg: virtio_rpmsg_bus: get buffer size from config space

 drivers/rpmsg/virtio_rpmsg_bus.c | 105 ++++++++++++++++++++-----------
 include/linux/virtio_rpmsg.h     |  24 +++++++
 2 files changed, 93 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/virtio_rpmsg.h


base-commit: f982fbb1a6ca3553c15763ad9eb2beeae78d3684
-- 
2.34.1

