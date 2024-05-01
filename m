Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ACF12F59D
	for <virtualization@lists.linux.dev>; Wed,  1 May 2024 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577941; cv=fail; b=AVTPvy047/Z5WM0Fs3UfXuEQ4s4G3aVf5+xnKGLGcFFemNXtQ+KX0JoRfP1pWTRG2FKcP3AzAGGy9eGfukMEtwEkbkcZTGId+810FKcH+514hm0z5qaykgoMXdjy3+ntmkuboqEeD3/uMOWH8ZDNZe44Npvha12QI2bzuLUAcpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577941; c=relaxed/simple;
	bh=+ZuVQRzxCArDPxAMYwX7+UgRXXrr9YqLdRwpm/MbQzY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lsdAF/mGunYNYiuUrUW7CRQqjBh5G6eFEHS4N2tAUo8JLNRWepa+c+8vmc7/OdUX+8XfijunZ3qDtFFFau5/B7W2VbkwZdSXY8HuUVlJmPg9hXN42LWeJ8FJTcdqOoAlv/nmM8GjwkGaMUOVfrD+zv9uMNHMfO/W1Tq0UbEQgvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o5ApzmJh; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o5ApzmJh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VM86ORAHY4YxVMznteyntgXTs/yLJSVge9ISODF9FQAvh9DcplRLsu3p+MiH7uXHBQgLZ/pTcgyF0/yTn0yiL4USotYDZpCu6jc8g3cfdCsnWrgfC0UxSkkHaH6uMe7724Lf/nUDd60B6GeZpygLSIxxHK3fZWL905yH+g7AsqowiDhaKbAw/n7jPV/UaVvPPPuQrJRjURv6bZxgFKtYf3QVBI8qmcPg8vbvpyE5POUvr8KgWGcG5ugW1XfB7nfEXWb5TcksbhjEoXq0hQn2hMJVFp0b5nNaHo3DBENqcExjanX9ex4dMOVjwB3l7IooWndRZFxoe9YoojFgYVxd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1mA1n0L40Lg++Tb5RGwcCAh45QZ+sCf4JK9134WRVE=;
 b=RkUWi+DEoxMSZ6YrKmdjijTuhlSYsj4A82mOAwnzicFsEW9a7oLO6pcN9KWVr3uysWeTd24KnQKv2LZwi/E9mCNLu/xXic7eT8Sw+65ni60omuoX+QrATIIcFHIPlCzbsnl2nEwykskwcs4rvb0KI8z5gqSAPVqQusjy+6S0J/pxJo5L6bg0FG+NBnYHNJSp4uFFc0TQNhSX2E03lxPC1ShZPzTR20UzzyB829XxyZsGDwMpbnDoayQIoAN3YzIF2F267jbfHbXv5fQfGMX5R99rATWP293RgOMnXwRed6rIQsnscvSSRf4ZYHC6NK7/PiD6aPbgMoP5JLt1wQ1C7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1mA1n0L40Lg++Tb5RGwcCAh45QZ+sCf4JK9134WRVE=;
 b=o5ApzmJhdKC27DywX0k6LLvMVwrPjREnaRYUOWqYq+oOrFGPbaHyoqJsJ/OArD9PBeh/ChLaj9ssrcEiuE7dnc8Cei22myspbA4YSk2229AgDUQiwTto9nslWhYKPZvKpi37Y2Nxt+megU2YE8gjhkdgTG19h9u2wsqplpY1u8BcEI7SV5s0qrLnThPKWyuZ6SVmO+1dWK9Y6WizbClwYEqn0NDENRnOnkXmwKVW7jqqILyoqioMbr/cEGxwlWwe2oV1K6N6l0xNzdxBxr55FYVEkLoZCXeXbMCtha9KqamdJ02knOng9AfualHSjqLG/g/jE+oLj7iPPjtQ9XR/rQ==
Received: from BL1PR13CA0122.namprd13.prod.outlook.com (2603:10b6:208:2bb::7)
 by SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 15:38:55 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::8c) by BL1PR13CA0122.outlook.office365.com
 (2603:10b6:208:2bb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24 via Frontend
 Transport; Wed, 1 May 2024 15:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 15:38:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 08:38:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 1 May 2024 08:38:34 -0700
Received: from localhost.localdomain (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 1 May 2024 08:38:31 -0700
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: <virtualization@lists.linux.dev>, <vgoyal@redhat.com>,
	<stefanha@redhat.com>, <miklos@szeredi.hu>
CC: <mst@redhat.com>, <dgilbert@redhat.com>, <yorayz@nvidia.comm>,
	<gurtovoy@nvidia.com>, Peter-Jan Gootzen <pgootzen@nvidia.com>
Subject: [PATCH 0/2] virtio-fs: introduce multi-queue support
Date: Wed, 1 May 2024 17:38:15 +0200
Message-ID: <20240501153817.540855-1-pgootzen@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SJ2PR12MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c1328d-3435-4ccc-ed98-08dc69f4cf25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ENwLdCmw0i7iMQRsJPl9/Cw++lkaKR/rhLUX827RjfhW+TCDuoIPiUdldKzG?=
 =?us-ascii?Q?d7jwo8gl8RujkvSz+AZLEw6Fn1PBRYQ0pmJxfTeMLd8uk7ZHwffp8FPpQJbI?=
 =?us-ascii?Q?7C0RlAc4+lwWwxM+WDcsido2WqTNipJWy96ssmehcsgnT+rcbTukMpMRDun4?=
 =?us-ascii?Q?ekVafiH0AVLk5sEnezdGwmnZl08mV3slulXYyBVuKSI7PWEvddzXNo4lSaTU?=
 =?us-ascii?Q?sFF/xmCWbdcJXpTcqG2w7o64iWXCGy3sH0eLxwQftysANAfMGpqeibcEOePd?=
 =?us-ascii?Q?eS5Uk7p94Y+8EGyp5Lt7FCrcjDNNuutRNmMXwMZuxyRfp9TXdgteyMnOcsFk?=
 =?us-ascii?Q?huDP3GR1+2m3neN8MWCg7czW2cPouU4Fl0XRyJz9ArSDWJt9vg8gpHUXckuq?=
 =?us-ascii?Q?wyQEBz4ytTzCLFFQX0NK2amap6qzg6DX5gFCt1myQCmI3G01gMh5VD663vgH?=
 =?us-ascii?Q?aQupK/pd6OldfBc/f5nJuQMx3t+PF2/46oBlSa5tFGIM7cvCps5goUxKFVpd?=
 =?us-ascii?Q?pScHRJzOCCgHjFin6l8V6JFn8LhAOWL15gsUxcuz7LtS3f3Q226OT3UopFwR?=
 =?us-ascii?Q?8ynvrEEbnAQI/XdWDxK3eAO9eOWvR/5AneuG8b10cE/DNYaJ5VnGSkMC208J?=
 =?us-ascii?Q?Pe7wgihfDb/EwbcwYTrzqywi3n+u0EMX6sWCk5kn4bvrScsXuLBaCWH7kXTV?=
 =?us-ascii?Q?oR1dBXnl+MWAqc4zySMA0NbEMjPdoFXR68T3SweD9b8GBDZ3pURwjkBBxQia?=
 =?us-ascii?Q?VMEsZPafdNK5QJcK++FjUMxYv9Ylwrm9YYxbarg6DJ3EEaWAOkYq0/canAp3?=
 =?us-ascii?Q?sNtCzW3AMf/0AE6XSAy8nwNLLunKPZ7LYcOepu21C8smapAvDq53HOBpX0ei?=
 =?us-ascii?Q?x2N7r4r4z6y/kzbRLYK+vgWSHmMAPfAIqtGsyYBRO0YIjd95XJQRCoHI4OrK?=
 =?us-ascii?Q?5flNizqR0e/PaXcmahXwCuL7fjsBTAwLjopSxeSFDNdEouP/bKz2zMHglHeS?=
 =?us-ascii?Q?6yEEm0sgBwNd+KcpAYtPtgNH7JQ8G9umE+cKQf9N4LtUBvjbX+4xompqC9Xg?=
 =?us-ascii?Q?wzplCdsDpRKbQEevmgFPZZvUcicP8qbNJbBEqGKfe4Z/xdjg1KJUK3gRTiOt?=
 =?us-ascii?Q?P6ftx7uXwwV6FeI+r4XlFw8bMZPcrTMHAkbRf8JK7cyvdht31X2w2JUIHizp?=
 =?us-ascii?Q?uvdNLsZzVWmKB1H8Yw1mXktfrwD2R6fA/7ssIPCr2U6EY48OrdP5ceL1++wx?=
 =?us-ascii?Q?qQvOSHnrhQZgazlbNPmNBfLczo0H8+1bMt5kdvubkQUTuV2GbxOouq97u9lA?=
 =?us-ascii?Q?MgLLcR8Tx0ZF5uZ2+2CFerb7jsuBAv/nv/1G4WcnXsclQS1bKvpv1j75lE6P?=
 =?us-ascii?Q?WApmY4zfsUwFRvk2IpZsIzY6gkr9?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 15:38:54.6198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c1328d-3435-4ccc-ed98-08dc69f4cf25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8109

In this patch set we are adding multi-queue support in the virtio-fs
driver to enhance performance.
While multi-queue functionality has been in the virtio-fs specification
since its inception, the current implementation in the Linux kernel
creates multiple queues, but only enqueues requests on the first request
queue.

The first commit in this patch set limits the number of request queues
to the number of CPUs in the system, to reduce unnecessary resource
consumption on the device-side.
The second commit adds a multi queue mapping to the virtio-fs device
driver that is created using MSI-X affinity mappings or, in case of no
existing mappings, by evenly grouping the CPUs and dividing the queues
over these groups.

Future work in this direction could include:
- CPU hotplug support
- In case of no MSI-X, using the created multi-queue mapping to set
  interrupt affinities

See the commit message of the second patch for performance results.

Peter-Jan Gootzen (2):
  virtio-fs: limit number of request queues
  virtio-fs: add multi-queue support

 fs/fuse/virtio_fs.c | 73 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 8 deletions(-)

-- 
2.34.1

