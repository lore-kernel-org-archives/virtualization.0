Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16B47D452
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192680; cv=fail; b=Gpks0JahwM6o57F477ilsE0Qpx5F5/mgAvMpZ2lALTQM+eLZ/YemQ0sEqddwf6brFMgJfXQffe1u0q1E2bO68vGJw5LsyQFiZz1/K9clDCz7quv2Jq+Khj6fEP84mjeeJdtCuRgl6JxWxZLJUctxm9iYfT6riafpIPHQuMGgSWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192680; c=relaxed/simple;
	bh=J/LTOriD5lU0kjp96QUB6jSluZi+rJpKc/9DOfm4emw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ts/xv6lEtX9X4y15mMYCwzk37y9Owl+syq+4jeAkLUGhq3LvhihI2L1L885UHtmWFc/vyUe+0MyX2HWAwxqsq70FIlrLitzEIXJAWFkPjjmnBVvwHcMielheLWYwzgl8NquAr2sRMW7qH7DLaXHccpLrfTrgqn5gXwI7oerHZes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UqjZzbPE; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UqjZzbPE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5rPkxJrIVnr2wsv2b/XPZ4b7MCKsSpzmVjW2aUkV6x6k5YMb/k1R7LdwxbcYQDvnKHkFPUWrqVTmD8J3236zuH6gcZEPFhVVrBQgF4QbRZrfhTKC61F2pe29Zi8c3MpZY21Tajn59bLWKQ+QvzXLU1xo5WtaTc6OONGE94oGvtvr1kvPAWByfDk+uFPIZFWLweO57JQZYv/gcf/CJCnMEnJG7vXNDJ8apQS+gQao2SX9Ja7Dwj0LRksoasRAABCUT35DnqdBi8WsCQ4u7W5BcVb182jhpxQO0EkgXSRLjvhTJiPXv6tUjkgPWV86wv1xV1qcFarVXajWtupZLzVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fodAzKRZFaM7RfhnhglNPbZTk3Z/HTTHNNQKMIpyClk=;
 b=CVHVvwFlWQ8B3VWQKmJqX2fteZQK0MyxC+7n/lokSlPRai7usjFHJv6jn8ydoKKALHsLCN2YUkOwiDodAPGmnx4pnLzm7MiLdqYGyyV9jQTAN09xHrkweqJuOukN5CKvY9Ddbe8tIxE+fzyOhFibBshKYojfKw5uzKoAn0VCeD2TeZzbNZFcq6LRb0mVpMGUXMtFONvBQ9+DARX6aEvetRXjsviUIAcIchrT2Vkq9pZOsc7bJdXA73wfSHIupMTqg2Ihhjllqj8unmEq0Ez1Nxhh7ipdQFwUWBarQcG+7sKunV0t6Q748i9qyxv17hGtTrYBBNlIMIws/MCxgzYwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fodAzKRZFaM7RfhnhglNPbZTk3Z/HTTHNNQKMIpyClk=;
 b=UqjZzbPEZFsJk5ZaZI3C18nciAELnI7ijkheQtMZo6PdzHPVNLYFWvLlO371YpEk5KDfNk4paOpXyrMteJV+P3HoK5JLDWxeXsfCKzu6MfkHFBiE6B6uiOq+hIMn14zBjBMw3XCa+AaPgf5+YuMdZlX96G7qdhqdgwS8NjFjfEzCQHTMysLQdW8ihjat/GWTPxUF7kP34fgn7ocDHGhYxTSdtcdyjlZ5DzjwyWaoVwIp8vdxpDd9MEIl2rhmbhQLPqtHUcIy9YuA5FHPt5c4LwRO7Q6nsuHluMhYm8twZB0roq8Jxu5YWPuvO44m0xZ2dn1bb4JjKTMosWPwhX5IPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:11:10 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 16:11:10 +0000
From: Shahar Shitrit <shshitrit@nvidia.com>
To: netdev@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	parav@nvidia.com,
	shshitrit@nvidia.com,
	yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	danielj@nvidia.com
Subject: [PATCH net-next v23 02/14] virtio_pci: Fix sleeping under spinlock in admin command path
Date: Mon, 31 Aug 2026 19:10:57 +0300
Message-ID: <20260831161109.2999926-3-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831161109.2999926-1-shshitrit@nvidia.com>
References: <20260831161109.2999926-1-shshitrit@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 620672e8-6d33-494a-acaa-08df077a7901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Yeoxghlj+o35jwT00fjoyOfFMoA9jlcAbyfxNT9KTjxHTAwc3ygEhkRXr11nxag5W7NCJ7N60lx6SAgwlsI1IPMWmcBnfHz/yhevDTTYPUBxHkKpeZWrW0PA0NQ/uRHelcor2NJwU9NqHqFdbla7WVfAljMvfGMz4kBz2+M5RAMqCH8bvw13QfWFE3ZyGcJ3Wmevik5inNqUPN1nN/cJE7bcnk2ahxkA08ptDdJEKBshjbrDEoKMc40zKCakRmEsBFXJpEdnN5k9uTTXpQwnd/3stLWoW+tx5FhMoSFoCoTzEvWx2CQ9G2SKkj9Cbhu4iX7JrOyoGhaSyavHMyi9BzmgUiVw5pkMkgw0enFRxPNetMj4pmgyeGgH1uF6CBnoSQc31GKoodBSbC0afEYt4C0SR3sLd+VjrQ8z75Lvcn2MDH84fN9dU0H91i2Pisfe3yeqkSeNZ2yDzy+xPxbuzP+FOWYKebciyxwQMFKgsO+teLJNQtlxC4yIs6evJUWSzEsUt5grurii/3/hcmqyq7z3EhHl0GMquomLvDdkZ97aw49m7EwpybXfQi78APcwqSlrOrXiKGagSrRuO7OXkYz+AzGuuJt+2V8c3rvakcdl4VBQTeAU0/3KNdnSsrQCrtC3h6H5dxoPyHZ6KhF7XnwDpo7T+0bVoPYLMG8mWNc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nRE6VV5HkyZe5hmRrXaaufpx1hcScmCN4DynHJ+YY+0aN5HDUho3Az2VgoIN?=
 =?us-ascii?Q?J5BFymLK5Lv1WIVt4PHufOGbs5opUtuAwHkZ1oghVXaPsGBkBJZ9clYodHNY?=
 =?us-ascii?Q?5a0sI3XM6MbaUkuJ7TkRlp41Y255XFbaqWt4KUucXVDoyzAVmJF2evELkqpJ?=
 =?us-ascii?Q?7soo5e8Y82LxeL9b3wLGMdY4kpJD3+gclL0BBiuPvXBcsyDemiF7wphbawhu?=
 =?us-ascii?Q?Z/eE8z4pGn2CTeP3d8uFYeIuPTQEundnbzOptz7WCyovmqiXqi0BkebRJxzn?=
 =?us-ascii?Q?OUomSqWMnTNJQSwIMk2v9GSbP7HYCsOqKJsALezNcjiQ8EDfn/kLY3opZd5P?=
 =?us-ascii?Q?ZDUkras05AEo3P4DWRuqGF3PXr1Im4IQVJ+LYZfrrAAZVDBTTujpMGs6d12l?=
 =?us-ascii?Q?BRfiXP83wztiHJFM/+hEu8524ijU8Hp4hMRK9ANMd8S8s8gNxmL2b82TzBX8?=
 =?us-ascii?Q?Ltfz8sRIhGrsqLYW7BUP4lRz7J5pJtXO7OAZhSSH4wNDEag8+GNPpkaCLUoR?=
 =?us-ascii?Q?hEza4eoBhlzSSAArnnQ4JHoVp4HhzVumRD9+lbwDotLW2UFQbtaSLl9d2vJm?=
 =?us-ascii?Q?YzRpkFEEf2gL0r8j8N5JLSxOj5PJwWHKNQd4Spxv73FsRHGI6OModVntqYix?=
 =?us-ascii?Q?8TPtDy0smc1Ir7qOZVqrCB39AMZuotzEDBH0q5pbYrLg7Si8kVP8+j7Bdryn?=
 =?us-ascii?Q?UEayC0gCaqwDMS5JkiELS7xr12ENXp5sYHnBL0EwwIEljNFinqzLT8eBlQLT?=
 =?us-ascii?Q?f/NCvfWgAtn2CaHwjYOQkeN4bbknGeA5UFZs4NlF7C801OaBtI92utvhURRu?=
 =?us-ascii?Q?PzKnLFnUW1U6xi7ahp1dXIt5czYe9qAYYXGdV+O+b894OZGzWfmB6TDT1Z8b?=
 =?us-ascii?Q?5Pu5FbxWdAkrO7VLBUAb3AW3P2FHsAjgTLb39rvnMN22nLu9sDVLUCr5dypS?=
 =?us-ascii?Q?6w1stgH7tAbHteDbgWu0B5W7JmoZm3R9r2OyyxR0taxEhEYPgLqiDiw2Lt+z?=
 =?us-ascii?Q?ZITXsGYHWlV0jJID+0Ikbis9xU4cJCIQk/cs5afOn25wSNm8PuZ8I3W6yEnl?=
 =?us-ascii?Q?KNTI3gp+i7Y6q6ArmyEeteftWapv2wWbXiSn82Z/Cqq26bpXBZrSqRLA4QH0?=
 =?us-ascii?Q?WHe+QLPLy30Ox5lQtTSVPcjjtukjcn0rE4iYWKapm0bVYsKgYQ1jB2KpUtDC?=
 =?us-ascii?Q?RnBElv9TVacpqs458hueMlzMOjnxtska37HYftEegqvkWOBT7AjOti/kAEsn?=
 =?us-ascii?Q?jVf0k6OBSIuZItDnCiwft7EaAmGlxnIr/Y8p82YrO7WS7Nekpt4396fZWZ/B?=
 =?us-ascii?Q?hsgs8AFu3yTYQz/uh9cAWYbLmjX1TqLKN0bT4S+YvlOQhcz0ofbORwGYC4if?=
 =?us-ascii?Q?06W1mdsXKFIhSzUfVe1OOd9vpnwLbKSzz+KBhvOJmLrZG7x5EQD+RqXYC+on?=
 =?us-ascii?Q?0tIF9gFmd/n5iIOHqP76I+CWrEZ6/VnnOzhwzB95DKJbTp0NnYmO1xXp880L?=
 =?us-ascii?Q?CNmzGWpUbwfkfKPruQ7yCO8FNIdrOc+ritgIlDlMzj7BD/UXxoV0kTvmisex?=
 =?us-ascii?Q?f7bYWtYRTPxZkmmvoeqH6Ib+SemkkqZCR6UO+q/jahBqiGLzQAxXQAEWegdx?=
 =?us-ascii?Q?ua2lf6ojq7iSeqHrUZRChG3oFD1KlnLaapsDrlorTW6SUPUS5RDgZm//EnH4?=
 =?us-ascii?Q?+o+u2N3ca0V+I59JgMZ2jwpoWMxNPn+2dRR7gqqvNfS2AvIS3eyTVQtyc8qm?=
 =?us-ascii?Q?Slfci0LUMQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620672e8-6d33-494a-acaa-08df077a7901
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:10.8467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFF7Dr1YHBxDKGOjjmBra3Pssyhvt3gLqhK7SDJmoCpJl35uoJ/7vJ0rEP0izNxQXZxMl4ziDvlkCrUXoctlFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

virtqueue_exec_admin_cmd() calls virtqueue_add_sgs() with GFP_KERNEL
while holding a spinlock. GFP_KERNEL allocations can sleep, which is
illegal in atomic context.

The issue becomes more significant with the next commit, which exposes
vp_modern_admin_cmd_exec() through virtio_config_ops. This makes the
admin command path available to device drivers and potentially reachable
from userspace, increasing the likelihood of hitting the invalid sleep
under memory pressure.

Fix this by replacing the spinlock with a mutex, which allows GFP_KERNEL
to sleep as needed. Since the virtqueue done callback runs in interrupt
context and cannot take a mutex, defer its work to a work item that runs
in process context.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/virtio/virtio_pci_common.c |  5 ++++
 drivers/virtio/virtio_pci_common.h |  5 +++-
 drivers/virtio/virtio_pci_modern.c | 37 +++++++++++++++++++-----------
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 164f480b18a6..ec0c92c782d6 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -256,6 +256,11 @@ static void vp_del_vq(struct virtqueue *vq, struct virtio_pci_vq_info *info)
 		spin_unlock_irqrestore(&vp_dev->lock, flags);
 	}
 
+	if (vp_is_avq(vq->vdev, vq->index)) {
+		cancel_work_sync(&vp_dev->admin_vq.work);
+		vp_dev->admin_vq.info = NULL;
+	}
+
 	vp_dev->del_vq(info);
 	kfree(info);
 }
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index fc26e035e7a6..8b0178295342 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -30,6 +30,7 @@
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 
 struct virtio_pci_vq_info {
 	/* the actual virtqueue */
@@ -46,7 +47,9 @@ struct virtio_pci_admin_vq {
 	/* Virtqueue info associated with this admin queue. */
 	struct virtio_pci_vq_info *info;
 	/* Protects virtqueue access. */
-	spinlock_t lock;
+	struct mutex lock;
+	/* Admin command completion work. */
+	struct work_struct work;
 	u64 supported_cmds;
 	u8 max_dev_parts_objects;
 	struct ida dev_parts_ida;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index ef4a64eb9982..dab63b044a31 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -47,13 +47,20 @@ static int vp_avq_index(struct virtio_device *vdev, u16 *index, u16 *num)
 void vp_modern_avq_done(struct virtqueue *vq)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
-	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
+
+	schedule_work(&vp_dev->admin_vq.work);
+}
+
+static void vp_modern_avq_work(struct work_struct *work)
+{
 	unsigned int status_size = sizeof(struct virtio_admin_cmd_status);
+	struct virtio_pci_admin_vq *admin_vq =
+		container_of(work, struct virtio_pci_admin_vq, work);
+	struct virtqueue *vq = admin_vq->info->vq;
 	struct virtio_admin_cmd *cmd;
-	unsigned long flags;
 	unsigned int len;
 
-	spin_lock_irqsave(&admin_vq->lock, flags);
+	mutex_lock(&admin_vq->lock);
 	do {
 		virtqueue_disable_cb(vq);
 		while ((cmd = virtqueue_get_buf(vq, &len))) {
@@ -71,7 +78,7 @@ void vp_modern_avq_done(struct virtqueue *vq)
 			complete(&cmd->completion);
 		}
 	} while (!virtqueue_enable_cb(vq));
-	spin_unlock_irqrestore(&admin_vq->lock, flags);
+	mutex_unlock(&admin_vq->lock);
 }
 
 static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
@@ -82,7 +89,6 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
 				    struct virtio_admin_cmd *cmd)
 {
 	struct virtqueue *vq;
-	unsigned long flags;
 	int ret;
 
 	vq = admin_vq->info->vq;
@@ -100,11 +106,11 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
 	if (virtqueue_is_broken(vq))
 		return -EIO;
 
-	spin_lock_irqsave(&admin_vq->lock, flags);
+	mutex_lock(&admin_vq->lock);
 	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
 	if (ret < 0) {
 		if (ret == -ENOSPC) {
-			spin_unlock_irqrestore(&admin_vq->lock, flags);
+			mutex_unlock(&admin_vq->lock);
 			cpu_relax();
 			goto again;
 		}
@@ -112,14 +118,14 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
 	}
 	if (!virtqueue_kick(vq))
 		goto unlock_err;
-	spin_unlock_irqrestore(&admin_vq->lock, flags);
+	mutex_unlock(&admin_vq->lock);
 
 	wait_for_completion(&cmd->completion);
 
 	return cmd->ret;
 
 unlock_err:
-	spin_unlock_irqrestore(&admin_vq->lock, flags);
+	mutex_unlock(&admin_vq->lock);
 	return -EIO;
 }
 
@@ -350,6 +356,8 @@ static void vp_modern_avq_cleanup(struct virtio_device *vdev)
 	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
 		return;
 
+	cancel_work_sync(&vp_dev->admin_vq.work);
+
 	vq = vp_dev->admin_vq.info->vq;
 	if (!vq)
 		return;
@@ -554,10 +562,12 @@ static void vp_reset(struct virtio_device *vdev)
 	while (vp_modern_get_status(mdev))
 		msleep(1);
 
-	vp_modern_avq_cleanup(vdev);
-
-	/* Flush pending VQ/configuration callbacks. */
+	/* Flush pending VQ/configuration callbacks before cleanup, so that
+	 * vp_modern_avq_done() can no longer schedule admin_vq.work.
+	 */
 	vp_synchronize_vectors(vdev);
+
+	vp_modern_avq_cleanup(vdev);
 }
 
 static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
@@ -1284,8 +1294,9 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	vp_dev->avq_index = vp_avq_index;
 	vp_dev->isr = mdev->isr;
 	vp_dev->vdev.id = mdev->id;
+	mutex_init(&vp_dev->admin_vq.lock);
+	INIT_WORK(&vp_dev->admin_vq.work, vp_modern_avq_work);
 
-	spin_lock_init(&vp_dev->admin_vq.lock);
 	return 0;
 }
 
-- 
2.49.0

