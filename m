Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F663C465
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163098; cv=fail; b=fTycC2mI92z9vN+TZPj9PKXQ3yvLh/B4qMCL7aDGATnK9itM02ZrmK7X4GlIof3yIqrm2HCs15+nQ/9wZOYf4nIpyudbh22wRHVQmcB3I7NHWiAjTfu0PSKGKxeHQXqexKZNfglrQHifnoSHmD2diI/UxGN1+EknKa8AACmxRjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163098; c=relaxed/simple;
	bh=J/LTOriD5lU0kjp96QUB6jSluZi+rJpKc/9DOfm4emw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BEacwkrsUEPNu01taNU/d4b+Vlw9hhAVOtwp/HHDHYQX+GiRXb2aJFrTp1hQgwrHYk2HcL74QDPoGqTMAanidjsszkxvLe4+Vu9NCwrdRwPQTHNq5CYQQKAYW0ef72T6IDVz3sw23LGuOSZjamlHEDE52uXfLQ13wN707hZBYbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZVGgpbvS; arc=fail smtp.client-ip=40.107.208.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZVGgpbvS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8/luKPKvGhqs0tLuQRlf1HHYfc0rdty42PgpEo88/PHlXWfNjiCv+o5uo/f3dbq3tbICyhl5g+UMV5fiCm0Yp0ym7xsi3AydHheo6bfP7VlH9F4jggqCE6CVs1DkqeFKs39CnRIQUgc8y/Q86h4+TcsDDpixbaTKL0k6Lts7ijQOQreY7xZTVABiq/7ESZDz45dkVv2RRnoyOgkz/D/cohDt0xmJiS7NR0tohsfVJy8KLrCQgHsY+F7/J2vNIl2v4gMEDplkt1rfeQADznZ/mGjsDw6kdgChO87LDsG6PuW0N6tDd8e9MzjCM4RDiNdMkV8uZJC44s1ZAK0/q7Csw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fodAzKRZFaM7RfhnhglNPbZTk3Z/HTTHNNQKMIpyClk=;
 b=xX8dpabLDjHhjtODk1vFemRn+CeIasxEwsKzzPYqxrsAN3loZP+UjZvYQOvDWIY3Ebq9ic0c275ouhcFw2kzkAoQ4meDcYXhIrMo064U5qf6Uk7z6equcUpGu8OAvkoRMl/tedHpK3D/hKIHnfRg/GwzJ0t5U+Lo59z8RBChwHQY5BrDLQWtF1IiJKRnLQLpqU4Vznx4c2rv6eN2+SkL81wX6KlC2OgbF/VsUqUHiL8C/SlyQJEbHxyx0Ep6RcZkW+vjHpSxWDv3UjTtQzUjG01Uj6RUcC4cs8vu8eWqbfKRo548+V1pds8mOeGUj+FDuTPCSgCd/RPOJf45x2bfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fodAzKRZFaM7RfhnhglNPbZTk3Z/HTTHNNQKMIpyClk=;
 b=ZVGgpbvS+nocWYVs+l9betxJStIaT3G0/Eg5q+BbtwZqEjhgwmc3cyCF0OhgTl12sVmu47A5yhOj1t/MSD6/1hNSMj8c/uSQeZEfTBhMFEB3LzyZgvvikFfC/iskCN5zoiB54/u2LYu//L3FmGFTQsT5s2jktHXSqpXHVYMbIZyk6Qa1HX1GEx0YAp7WetaYxj1KnT5iEIaZHpBQxNa6yW61skiYMACYKknvDjIKpRxFubGsSj3j5D5gtxE2IZbQhM9T7dXHWv0kIopYRRJ4eypdP3lCySJ3l5tlA7Wh4SFlcJnnFN9R21HpcSh119HJGiEvudsUtlT/VrAB2bvZQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:14 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:14 +0000
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
Subject: [PATCH net-next v22 02/14] virtio_pci: Fix sleeping under spinlock in admin command path
Date: Mon, 31 Aug 2026 10:57:55 +0300
Message-ID: <20260831075807.2891426-3-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831075807.2891426-1-shshitrit@nvidia.com>
References: <20260831075807.2891426-1-shshitrit@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::12) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: eb25cefc-c6b2-44e1-c350-08df07359bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	+UcQ1LlAkRMckLozvIubSi7KEmKCxnZffWVy9EewVH6myN80vf6kFtJIWw5dT+ooKJmyWXuii9zhbR6AMnA2mMehI6MMa8aPCeh7iZXZ6aJj1ud7mLG4296TGaYSmh+LMsk03pzL7el2dwWIA7l6Z7DPOR9SzweboArz1y/zrEPgVbqN2QP0EPp5+8P5qEn5vZyAtTILaEvLyAJVJcZ9Oy0xMjF4f7yFaPQRk7MkjjF8irVNJzWZWJ2YmDismFJuWFL9YoaK/HbRWS6NUKiZcSR8rnsGXZiO8NMNvS5lwyPe4PSaFOcb5Rh5tcouqpPFUzxSU5gx7TUQ/HE55h/Lhv1hEsx+4JnTHl9rrLKkcEleVWj/0kXqwl0H1tkS6NZQBeNTaa0JUk1hzpCy4b3glPQp7eSHtWuWbK/cGjBzBx8yr2Pz0d9Nvrb7qrA/N1mRcQ2xITF7/tK6bC2GsCR3j0Xi+88SEY3SjC5Y+erbn6OUrid71aZVFud9tQmvHvjlcZFJM9HK+tpLvWKO0SL2an4wp+S+e5q6mNzeJznTufStcUeO1YzqI9Gghh5htD0Xkw7ra/nUe0DKZ9HkflvJcNFWjhdIvY5QF3KFgl78E3TSfkJjW5h05kDt+zofGYi8RZy83PiRjWEu0ZDTWPVSP9cF9ebbwK0sWbXUO7D5Jt8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h+o6VrZ3Y/vBezPHMMr/13pg5q98UiDUqNrnZytVCkDkrWXuPnlRrrutoT5O?=
 =?us-ascii?Q?4cXi6QzX9Kj17/Wqvj3QrNwtaeyMQPIfH6rSfEzXAUQt2WGa/EqG6J8+PnXL?=
 =?us-ascii?Q?u/qoUoL88daMQPEusYQ5vCbmAuJwKs99w0lSKy9psuj5Io9yxgXPN7nWFO9N?=
 =?us-ascii?Q?cRnyEzA58VMfCgal2bDFTvZ1FFbhexQ/DRmssnaoQ04++a5HIKBV+6Ygmpwp?=
 =?us-ascii?Q?xoosWCvPtbdGUxu8FgR04x+16hlg+R8XFzmGhG0yP0SWCdEIjQAENcRyZ0l1?=
 =?us-ascii?Q?UngS9UEoSoA0hOKQZidFejvdozvMcpC9ruRoXWFNbqs8PZtqxOXwf72ICSg4?=
 =?us-ascii?Q?ALujfBlut/LElwJZ42sDk3UzWdssuskXM981YfJEWwGmAhe/qs8GOTxddgrH?=
 =?us-ascii?Q?2mUnRT/EAKnL57w+yQdDXlZSFx7eg/BFeRdGFYxvB4dMnyj3EDoINmZF7UOi?=
 =?us-ascii?Q?CIYYhuIHolb/Z5Q33s7ywDRq1x+JsIZT0hMVFo4/H3nZUM5qg6efB2c0aNgf?=
 =?us-ascii?Q?fXWgWjCfIvnIh6t+WNPpGKkkHwHoZ0i4L1u6JSRm08LNfRsXmQluX3nQ4ahw?=
 =?us-ascii?Q?HTWWkfbNTOCnEoJWE2C9sThlcG+XgM/Mt8lmLq9cc2qMnCAmN23HSiZm/jBV?=
 =?us-ascii?Q?ImodjuDZZzOVBzwfIDJRL1YASEZugOMUL/DH6WFxHd+hKpsRg9diBuquY4ds?=
 =?us-ascii?Q?W8UB65VKQesTpt5gYIA8EfC+Ydq6qAbK1VOH7ghfZqQ3SFjAUWxPzIaSCHmk?=
 =?us-ascii?Q?D1bS8WZwM+FhCNN4gjV/6V+6GMtx/Mu/J8r2dIbsJ4v0NgtXHoUYUSbAOzgy?=
 =?us-ascii?Q?kfqHJak3glKR2Ec4V9s+k1FT7fIUM5n4Sh0P2KFMNQfiBxdSlgJ1nxJTxY9F?=
 =?us-ascii?Q?lARX01u9wtJm7MbMM4yokS30V9g860PHsZHlZJ7KjCjUMV3SLonfHN08e1/O?=
 =?us-ascii?Q?8A58bcya39HqAcEU9gieEoEOciOWgXT+OpeVGBk06/lXqMNJC2e66mFIjG5B?=
 =?us-ascii?Q?BmVH9ZcWBDKQnRioARI884cKQ1uq3ntbm4v0KuSF9/1fmJGO7WWPlfwho2oG?=
 =?us-ascii?Q?ZXGVZXqezb+TFUinMlYw0A1mGrFJQcvzuvKjf5ViZPZlekuzXEZMauujYvc8?=
 =?us-ascii?Q?bhtJxQ2tv02gYh6cdbYVHHEQcro2mfgfc35n0t1o6v7SAzWl9P5KI+8k3Onr?=
 =?us-ascii?Q?NutzR/fKA47fnFjgYc1oQXjvuVD4bo4ri0kNgxac3l2Gz3/lNW+gKuxItc6T?=
 =?us-ascii?Q?Jq3HsujG420tAfa3BX3kv8Wq2SNVWdF608d8lFfX5+jW0OxyBVhBSQeCb0Wy?=
 =?us-ascii?Q?xS0ZEq47OJieZJrLBAJQoJV10/sC6Zcfhx06YFkOOgv7ZkCkY+MR2u0dBWli?=
 =?us-ascii?Q?WM/W+nlD6rbKtBdqh1rLWOvdwRawqofC3a7k2bTqo9HStyoYCX3zezwIVxU9?=
 =?us-ascii?Q?MOhw3PnYLafEFAMwqKs48iViGHieSSRztBRK5v2HowywejPZN0ChAbbWLGe9?=
 =?us-ascii?Q?BYnOMxkudRKdnokoQttK6QGcGTHFuC8EAZWCJ+fW0fS+8Fl5QU3y1Bd9seD5?=
 =?us-ascii?Q?YBVzEQBpOQJ0a5n1/a1CNOn7okqPXp59WOC56tgpP4GcNt0criji5+zjSdiQ?=
 =?us-ascii?Q?HFyVkSy6ht5BEDTM1eJq3/h7R0cEAyBKX9YCiROk3Sj1h1yD1PJpGIgKNvK8?=
 =?us-ascii?Q?xKAsD41BZoUtiSraXliRpaHcbACwMwf2Zbr0M1zTETakShQPDgKH495P5IBg?=
 =?us-ascii?Q?cBMa2eoIZA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb25cefc-c6b2-44e1-c350-08df07359bee
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:14.1972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yz/WDJrnOx6XnvGODcn2tAEun58Q2mMZ0MTnNZq6oQYBHuUuslLbytS4Rw7AlWOoJir3K6mP6aHQFOyiNazjVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

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

