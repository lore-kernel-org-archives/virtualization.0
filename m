Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5E5024E
	for <virtualization@lists.linux.dev>; Wed,  1 May 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577949; cv=fail; b=tBA5d+D8JPTwLxR3RErmVGqEt0yHLpQs18OxhyLxZIFTI62M6a/abLHR2PNgNHryrX0YlVTgmkWSsyu+1A7l3XyCWAVJWTc31yQo2AluJmZu61sGfqKi18la8Aia08LWKTrP7cnSu85qLKT4RjisXWUydwnEIPSbkFPupcz77wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577949; c=relaxed/simple;
	bh=ZX//uzkxy1G0QoqUPyU+KQ1hBx/+TYNf/Te6CQ+3Yqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xt2NKDo9+1hQwvcg3WNLZEhG8C101VrgR8Jy0+CcCiBXPWG/8925lHrNVsEHCarkJXIUcBJUUj5oFyUit5CC3DWLaqthqKyiWctiOGEFRzQMuMwWWtQfsbOy3/DOprDul14wsoB7QtHF/S/2Q3ZHU5a4mpuLaKxIUKUypZboILo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R2OaR+DX; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R2OaR+DX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImV3YTCcLytc5+Yrq+1rGWQW4YpmJE24bGbTIc/ca/G4R6cU4yVsB5ldrfpVNGUbH0zICLC+BXhv3u1WpJy1ZxayRS+XB3CwfO3pEVTs76IgyPq+Tx/ij77xEfSNissH2I3XJWyxK2W4yMvdDatV8YcP9jNzgNftr7ddCY3688am3CjCxn9MNwW4rquyQ+bjgAOepBPoZnBazx8q2PPV0ggyZw7MM9ChzpqUxqlOOI5g1/vgqAEA8a0CjKOZK7AoyIBqFLZtwU1FNlZ5bBw+BLvRv5v+q08AZmEjzvPriM4NV8jM5YUKrkB+YuPXHTMmFZkk01Zm+RC0TUnZ2+5qxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjhlJ2KwjB1uSq5cuM/kqPW54d1Ph5xMubJmkwKYHoY=;
 b=HsS/Wpu4b0fzi5z+VsgETtlCfRES1gMx5tAGNC+6YGvmWMTDfR2jlYTR6pn9N6pVmzJuxeVvGGSCeXOGxegOZ0w6reosHKHOdGKoQvePA1kIhJJXd8f0UM20D9z9qfervb7JzN8F/fR3qsBZZwPPaIt4BoPatMcvV5DHHeSUSFXjOPHCYtjyxYiw54RdpU9X8UkmYsJ/EcnTLjM+WZlQBzA5vtBbmBrcpmu868QXoXhWtKzUAMskznbr/gms67sp5F5UtCXNNt5FHPZRKFbVrh178olFHEmgiFL8vJ9BYspqTmadzMDfU/Xc3rn5X5USl1HsbXDZGu55r3QmIaONwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjhlJ2KwjB1uSq5cuM/kqPW54d1Ph5xMubJmkwKYHoY=;
 b=R2OaR+DXLEHCW5UyVpyFtr05TkYORUVMqo9Jiiv54L6AYy9KyBfeTwdLifY414Q9Dt3yZYCzeUKNuRPqfUg8MGn7NnygNnyMBBybcPHYrISynQBxqRd5jzxIXlUkGDBPxoFLCI7vCmBaFM+6A5ykNZA2jyJvkazc1Dxz1Pj3j5tZNwfbGvELgn3mZmEkSlfsGmQtW6qmqhRBGXYfOdnYhj4xWOdFbDE0h5Nx/9IK+/n9Ngq0kt8vSVeBJ6B7qIQ4I+1Yu5MeqHdv8zdtuAvRlftQG79mCu8hJgWZueNMNCXc/Ns35Fkm96h3TsEcOuimTj1RXO3tIjeAxDSqYEzHfg==
Received: from PH7PR13CA0006.namprd13.prod.outlook.com (2603:10b6:510:174::19)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 15:39:04 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:510:174:cafe::97) by PH7PR13CA0006.outlook.office365.com
 (2603:10b6:510:174::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Wed, 1 May 2024 15:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 15:39:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 08:38:43 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 1 May 2024 08:38:43 -0700
Received: from localhost.localdomain (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 1 May 2024 08:38:39 -0700
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: <virtualization@lists.linux.dev>, <vgoyal@redhat.com>,
	<stefanha@redhat.com>, <miklos@szeredi.hu>
CC: <mst@redhat.com>, <dgilbert@redhat.com>, <yorayz@nvidia.comm>,
	<gurtovoy@nvidia.com>, Peter-Jan Gootzen <pgootzen@nvidia.com>, Yoray Zack
	<yorayz@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/2] virtio-fs: add multi-queue support
Date: Wed, 1 May 2024 17:38:17 +0200
Message-ID: <20240501153817.540855-3-pgootzen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: ae47ae38-46a7-4209-57ea-08dc69f4d461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400014|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?43k1fiNrBFQYJsRVxUNFOXstWHV+L/ec+2Yn9GjNHel/gUSIARURfIlGT9Iz?=
 =?us-ascii?Q?Hz1zXp9crcTvGr2fyMN3dRYunj1mfMp47tQZzsFSkSGCLt509OA7D8ILoXkL?=
 =?us-ascii?Q?xd7PiQbzT+1SImJgMFjWsxpmubuqaj2FAUGdJeG1xEnOB3RFqWbe8fIwH0v6?=
 =?us-ascii?Q?fzUkPvZm3MEf8c6I5nJXF4XMElmXHZbSXGmd9vD0e0hit7OiQGSjGSDLo43i?=
 =?us-ascii?Q?n9OYoiuhOxs4t8eZoirRbCVi2mFk3R7hNs63GorrzU/F3iY0CNvRduH+VIMT?=
 =?us-ascii?Q?TfA0Ueybd4CjRDKbhIb/5F08iFJTg/FToDne4x53LjDxnuN6T4XqayQxmsT9?=
 =?us-ascii?Q?AvPnVCighb58+qtuNQ6DnSoU3fCAvQY2ngJ3ZpRzdqNQP3slaSSNeVXDZYl4?=
 =?us-ascii?Q?VprORovaw09N+F1ncE5SmEfflZXeXA1Fhx6p/S2jJghqfShDX0S43Rrm7RHY?=
 =?us-ascii?Q?tI4eWK0HBTugQKLBS6xLZJF8CRX6T3CtapHQDmF7RBkYvG0FXIIjW1yd19pQ?=
 =?us-ascii?Q?ojcN15L95WTw8rLhd0e6SUhBfmnxfIYwB5ssTVlNUxSqCTB8azIRjagSLrzf?=
 =?us-ascii?Q?tzbAbKaJPgnNmoJQOudwjK/Q9ns0F/YXkU8yS7OZI4A1ZEhs8DAw+TbyAQxZ?=
 =?us-ascii?Q?lJek5nmiodh/VroL9JW7bzeDqhunpyyUcG3fQYjKtozNI9JFPIppnTYqzA3/?=
 =?us-ascii?Q?/iT+ck+/M+n0y6oIRXYI241/+8OksxAxRnIaFksSkAErU/TEIMbkdZEyXUfR?=
 =?us-ascii?Q?SydxMv3tRDQATtSVumBlzjxjob5FdZ6RSVXCtye9du7KF1MPHRZX7cxNBpWe?=
 =?us-ascii?Q?LN1DuIEQ9JA7HJ/T7bndKLzCEtq9PKh53fSclEDvV1qD1UYQgINVd5mjq/kc?=
 =?us-ascii?Q?Vx6EyfyRTUysV7NpTEUU2eHoNL+hl37NMi0ULiJU9QXJJhxiEFuzyQSpqtwg?=
 =?us-ascii?Q?sefOoy/lKrIYN93k6nUTVPGaJioqau/iThOZbJ4mlSkx0g52HY0ddqzjaVdn?=
 =?us-ascii?Q?WvhxKHAFrGZwOt4dPDZFMIEJiHWyWzw3i3WhjHsyVe0XS4E5JDJQvmM1uvhR?=
 =?us-ascii?Q?3ohJQy4YJVwXA/nn3mAM7OvzI0KBjURIDAmmAPBYBSzY6dsbe0PGeZJ5ZeDF?=
 =?us-ascii?Q?qXug7GikV1SQjSla48C75ml2ZVm/LFBZ7UKzCZ7f58xW39sgNDxmjH3btsIy?=
 =?us-ascii?Q?X1WmeRdak9copmM0I/S4EvCq5hrQL9womW+84Sfd3jc2wJAvmULBshEAWoGP?=
 =?us-ascii?Q?m3mFT67BiiAWDHEVAUk4mRS7KEUm7MnW+pAEdwVCcw9osxD4tzekw0jQ7vIr?=
 =?us-ascii?Q?f+ht/VII+u+6JGwAq64PE5J34ED57bVKCxDMmMlSheFdlDAnClFyVDQ1PMjb?=
 =?us-ascii?Q?W03JsZid8ljIm5NH3Szzi1ej7nXx?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 15:39:03.5072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae47ae38-46a7-4209-57ea-08dc69f4d461
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427

This commit creates a multi-queue mapping at device bring-up.
The driver first attempts to use the existing MSI-X interrupt
affinities (previously disabled), and if not present, will distribute
the request queues evenly over the CPUs.
If the latter fails as well, all CPUs are mapped to request queue zero.

When a request is handed from FUSE to the virtio-fs device driver, the
driver will use the current CPU to index into the multi-queue mapping
and determine the optimal request queue to use.

We measured the performance of this patch with the fio benchmarking
tool, increasing the number of queues results in a significant speedup
for both read and write operations, demonstrating the effectiveness
of multi-queue support.

Host:
  - Dell PowerEdge R760
  - CPU: Intel(R) Xeon(R) Gold 6438M, 128 cores
  - VM: KVM with 32 cores
Virtio-fs device:
  - BlueField-3 DPU
  - CPU: ARM Cortex-A78AE, 16 cores
  - One thread per queue, each busy polling on one request queue
  - Each queue is 1024 descriptors deep
Workload:
  - fio, sequential read or write, ioengine=libaio, numjobs=32,
    4GiB file per job, iodepth=8, bs=256KiB, runtime=30s
Performance Results:
+===========================+==========+===========+
|     Number of queues      | Fio read | Fio write |
+===========================+==========+===========+
| 1 request queue (GiB/s)   | 6.1     | 4.6        |
+---------------------------+----------+-----------+
| 8 request queues (GiB/s)  | 25.8    | 10.3       |
+---------------------------+----------+-----------+
| 16 request queues (GiB/s) | 30.9    | 19.5       |
+---------------------------+----------+-----------+
| 32 request queue (GiB/s)  | 33.2    | 22.6       |
+---------------------------+----------+-----------+
| Speedup                   | 5.5x    | 5x         |
+---------------=-----------+----------+-----------+

Signed-off-by: Peter-Jan Gootzen <pgootzen@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 fs/fuse/virtio_fs.c | 70 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 2745fa484dcb..ed50a5096e74 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -7,6 +7,8 @@
 #include <linux/fs.h>
 #include <linux/dax.h>
 #include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/group_cpus.h>
 #include <linux/pfn_t.h>
 #include <linux/memremap.h>
 #include <linux/module.h>
@@ -67,6 +69,8 @@ struct virtio_fs {
 	unsigned int num_request_queues; /* number of request queues */
 	struct dax_device *dax_dev;
 
+	unsigned int *mq_map; /* index = cpu id, value = request vq id */
+
 	/* DAX memory window where file contents are mapped */
 	void *window_kaddr;
 	phys_addr_t window_phys_addr;
@@ -185,6 +189,7 @@ static void virtio_fs_ktype_release(struct kobject *kobj)
 {
 	struct virtio_fs *vfs = container_of(kobj, struct virtio_fs, kobj);
 
+	kfree(vfs->mq_map);
 	kfree(vfs->vqs);
 	kfree(vfs);
 }
@@ -706,6 +711,44 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 	}
 }
 
+static void virtio_fs_map_queues(struct virtio_device *vdev, struct virtio_fs *fs)
+{
+	const struct cpumask *mask, *masks;
+	unsigned int q, cpu;
+
+	/* First attempt to map using existing transport layer affinities
+	 * e.g. PCIe MSI-X
+	 */
+	if (!vdev->config->get_vq_affinity)
+		goto fallback;
+
+	for (q = 0; q < fs->num_request_queues; q++) {
+		mask = vdev->config->get_vq_affinity(vdev, VQ_REQUEST + q);
+		if (!mask)
+			goto fallback;
+
+		for_each_cpu(cpu, mask)
+			fs->mq_map[cpu] = q;
+	}
+
+	return;
+fallback:
+	/* Attempt to map evenly in groups over the CPUs */
+	masks = group_cpus_evenly(fs->num_request_queues);
+	/* If even this fails we default to all CPUs use queue zero */
+	if (!masks) {
+		for_each_possible_cpu(cpu)
+			fs->mq_map[cpu] = 0;
+		return;
+	}
+
+	for (q = 0; q < fs->num_request_queues; q++) {
+		for_each_cpu(cpu, &masks[q])
+			fs->mq_map[cpu] = q;
+	}
+	kfree(masks);
+}
+
 /* Virtqueue interrupt handler */
 static void virtio_fs_vq_done(struct virtqueue *vq)
 {
@@ -742,6 +785,11 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 {
 	struct virtqueue **vqs;
 	vq_callback_t **callbacks;
+	/* Specify pre_vectors to ensure that the queues before the
+	 * request queues (e.g. hiprio) don't claim any of the CPUs in
+	 * the multi-queue mapping and interrupt affinities
+	 */
+	struct irq_affinity desc = { .pre_vectors = VQ_REQUEST };
 	const char **names;
 	unsigned int i;
 	int ret = 0;
@@ -763,7 +811,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	callbacks = kmalloc_array(fs->nvqs, sizeof(callbacks[VQ_HIPRIO]),
 					GFP_KERNEL);
 	names = kmalloc_array(fs->nvqs, sizeof(names[VQ_HIPRIO]), GFP_KERNEL);
-	if (!vqs || !callbacks || !names) {
+	fs->mq_map = kcalloc_node(nr_cpu_ids, sizeof(*fs->mq_map), GFP_KERNEL,
+					dev_to_node(&vdev->dev));
+	if (!vqs || !callbacks || !names || !fs->mq_map) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -783,7 +833,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 		names[i] = fs->vqs[i].name;
 	}
 
-	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, NULL);
+	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, &desc);
 	if (ret < 0)
 		goto out;
 
@@ -795,8 +845,10 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	kfree(names);
 	kfree(callbacks);
 	kfree(vqs);
-	if (ret)
+	if (ret) {
 		kfree(fs->vqs);
+		kfree(fs->mq_map);
+	}
 	return ret;
 }
 
@@ -942,7 +994,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	if (ret < 0)
 		goto out;
 
-	/* TODO vq affinity */
+	virtio_fs_map_queues(vdev, fs);
 
 	ret = virtio_fs_setup_dax(vdev, fs);
 	if (ret < 0)
@@ -1291,7 +1343,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
 __releases(fiq->lock)
 {
-	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
+	unsigned int queue_id;
 	struct virtio_fs *fs;
 	struct fuse_req *req;
 	struct virtio_fs_vq *fsvq;
@@ -1305,11 +1357,13 @@ __releases(fiq->lock)
 	spin_unlock(&fiq->lock);
 
 	fs = fiq->priv;
+	queue_id = VQ_REQUEST + fs->mq_map[raw_smp_processor_id()];
 
-	pr_debug("%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u\n",
-		  __func__, req->in.h.opcode, req->in.h.unique,
+	pr_debug("%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u queue_id %u\n",
+		 __func__, req->in.h.opcode, req->in.h.unique,
 		 req->in.h.nodeid, req->in.h.len,
-		 fuse_len_args(req->args->out_numargs, req->args->out_args));
+		 fuse_len_args(req->args->out_numargs, req->args->out_args),
+		 queue_id);
 
 	fsvq = &fs->vqs[queue_id];
 	ret = virtio_fs_enqueue_req(fsvq, req, false);
-- 
2.34.1

