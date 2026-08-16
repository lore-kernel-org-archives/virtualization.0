Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF813DD846
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882899; cv=fail; b=Ecl9wEQxuribbsxqzjFtvpUign46foWVenD6xG97WLYTkcYac5TQUZnp6O625TRK60792HeSRy9xk5MUSUB66GTVa1imrDa7+yPMVpZvWzys1sHgQbbZfOmxQ2AxNqUlFAYamrr+6/roKDEshDfx/GDZ8BrRcuEbCkOH1KsOxzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882899; c=relaxed/simple;
	bh=J/LTOriD5lU0kjp96QUB6jSluZi+rJpKc/9DOfm4emw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W1blz5G+KIrx8cl8/uGX7KFB24xFKJjTinOM6/FmUEtj6XJ7OLRLn4Fp6aRK2NutZztiYjnhE+OMrqCdwMfZb5zouWWqe+IV+VwDG3PDZBrywjsqISiZhODTpZj1wLR1vy23chVZRsUww/IfQ/6VcMDErmB25hyccz30RmI4F6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ppet3lWZ; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ppet3lWZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jV1wTI3Fcohng9g7GDURyybW32SQ1FTWv8+4Sz9C6LuI01PyvLefjbEMCToEJoiB0PZPbtecynHQBIarnIB/81WnaYxDyJTuOxPjlWnbeZn1ySS5PPwIV+UMEDrckMeCzDnxKqDzT1ID79iESVEWbnhdGPsOOPtTFc0lsMdkSyS0WzBeaMTH7X5GUNKyDA9RrQKn/owiddK1CdkoPJ57U6AxkizFTtNruYzP9ncc2ozckPDKu2DR7rnzDtghMjZBmlxQYuGn74aXQM+DZHUpHPvcz7WIXwgfAFW+AriNt6fgVQFbUBh2XDDUBOEQOvebTeJBTrJ0a0IqHnd7kYx3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fodAzKRZFaM7RfhnhglNPbZTk3Z/HTTHNNQKMIpyClk=;
 b=nQN3udWLkQ1mH356J4HMNvU3ycTTm/ct/6ht7SxTBbFUY/oAafWtOrkQ+5Ieb+MYqhAcs+tBFNvJRgERu1JiQdKIM4nM7Qhy+iLCGmaxNW7lg6SOqbvXsKQ6SJ/YVmi48gnNzYnElOxAuW3SZhziUuy80MAeV2/6Zm0REwKQwOslRs9jCpFnBTVfzXRO4WgQM+JCpAW7+1rxHT3usWjXYAyMWX0+iEGORNRRLI/c08aWDofX9inmSNqGEz9PcWT+NCtS6FUQse2M4GAReUCqWS0Q+7qGnRz93eScWyzjNmRthsXoLrLqJ6O777wGc0es+DohCphoR+q0db/9xwhAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fodAzKRZFaM7RfhnhglNPbZTk3Z/HTTHNNQKMIpyClk=;
 b=ppet3lWZVpbQiIHW/wU4L7ZXAamyG9gkEOq6gEaOAM7Zj6DO6dEZAv0LJEfUyufIR0sTBdbkdNpozDT6l5XsEbmHyPdPGnOjIJSGRl54NdNy5KjeQknMm1p/3YdO97RSkMWUokHvu2tmG88sE09ovomMagaW/0FKMQnysb5fH7Zq+U2SAytu95MynqaAKoWeXhZJ6LK2yl2vheQ9nHbBgLdlAQwqyIaLEg7QUo6GYpXt5awMSLpB31fdc3Wlw5gjrsKnMHxYfAV8uOt+i30fSliGk/kUZXtG6/IuqAwTpEXRW0XfVb05DI+V7eSM7a6o60Dyf7i65hrFl3RnIfJ2Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:21:31 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:21:31 +0000
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
	danielj@nvidia.com,
	gal@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH net-next v22 02/14] virtio_pci: Fix sleeping under spinlock in admin command path
Date: Sun, 16 Aug 2026 15:20:59 +0300
Message-ID: <20260816122111.2495240-3-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260816122111.2495240-1-shshitrit@nvidia.com>
References: <20260816122111.2495240-1-shshitrit@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::20) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f048ca9-aa60-4289-95d4-08defb90e79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	St0LL742pIOE17lcn63jhI1nspooT2kJELWZ4sBMWLsRvSv/SX5/Kldth4LjwROsFxEndHn//qcYSNh5XTQtg5HjWLg+qWxzx6v7oIKdXM880CESLwi3M9M4bIMYsWhmKhM9ZK2zgstRb/LVVoVIIWiP1Tcd5tTEcz78hWU3fQ2aQvyCng2JnO2zQ8Z9acPrwVAhP/48UfYmg0LtVHiOAyxNsclcnbfS08SHTsBiUi+OrqeA3BzTcpuvdAif0HKlQkLX6k/El2Z/Uv5slX2IkjMNz8thAinEbljIvka+9quiwiyYyZH2xfSMlx+brbVDnTjAOgOjrUmtVroxa7YADG48mR2EdjZjQqM7hjHLY+xP2K4zEdHs36/qRXVF1QyGeHLciWaWzIew4VuDZ0FoyAjbhv7xM/8Icf99g9i7XrKPsU5tuudWvorIQXOPecr0mmvylYIJvG3rkjj5NXukj4S1kqtIAftduULI71Ni/ZtR/Pp5T856gPLlFSTwEgg1xglF1rgt6Xgd8q+6g/ZNg0SEaOOxKXgPjeGABFj506METgAabzjOIsRPc1SDRCvJedEIWUcqrH1alB7auxTcc9Q6Y840C1vM/rr/UtqnluDv3+mVgyKMin8DtpDXLYKm5ui7GZhjevcKyAN57nEsg7BWlOk+wWofBeQViGvhvS4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wAFc6VdblXLdDP9XhiujJBp9SF3Ifg0SXWFZZ4Ut1CvHF19zPfLLrOSRT4qd?=
 =?us-ascii?Q?deTSQcvqzhg4xcG9A1TkAgd9P2OijZFqFDR7hZYfOcyGVA47xm4fFKg/TusG?=
 =?us-ascii?Q?quI136xEs27Oqy/3vksYKEBxBXEC7YVWNo+en8VRJLEhx60o2R7fR+ZmA4ph?=
 =?us-ascii?Q?OSQRBT7ZD7CJZB4qoJdmP6Hbxlkg8wEKPh8DqwO88boW+tJRO9xKhDJXcGB0?=
 =?us-ascii?Q?ma/0a/WF2yEdOPHkOrlGcsyIjnDO91QR8y/SJl8FF8Q+C/W5CzVBa9MAWAF5?=
 =?us-ascii?Q?9wSSinbWeWn2EV90QVqV68Ni1iSNYpKhIpRjeCr1q/Uf1TUoF1mELakL9Xnq?=
 =?us-ascii?Q?s/7oN6MxGVWS3RhAan3+FqfMJcf6rx2Uq8TNHZkXdl3Fs8Xkp9dR1paZsUeR?=
 =?us-ascii?Q?rlyr6XJGkOBba5l8btIJk7sEvQHWI4HkIwBjRmeQR04CCOmN3bPbQdofwq/o?=
 =?us-ascii?Q?JiAV3E87D2VgZfwgf/fp281EeW8x1sQU41UrMIvnXbBUS53h2dDmWJ8b+UwY?=
 =?us-ascii?Q?Bbp2YyZu5U6tNmxLMWDHoK8bIxvMBJexfdoCbeR224HL/O+HMl/VGB1/qUd5?=
 =?us-ascii?Q?iKGa1SJU0w852aLFJDXZmGYZ7AQMrOIlDIC/femnkkySNQapKGuK3IWHP0kf?=
 =?us-ascii?Q?DbjrG2eWHR4lctfFWT6ABdPS8FVMBn4VFRXLyYww/yQsnAvFJCCHNHgP98u7?=
 =?us-ascii?Q?WSB5sVymY1DDaiZwlGeXGrQDKN8kpnZNsc+i6UXw2mUuoPR8tFss6QvnQiv0?=
 =?us-ascii?Q?yeyBIbxhlR6fcsTUUPibLZOte/8kEwA/k4STigxLW6SfL7ENLN6+bzmXTZZf?=
 =?us-ascii?Q?F+zsoIHHZsTMN/VvKBnaZ6NKxiPNhnZW2tSMYs8rGzKXoUBa97+3mN4n4Tld?=
 =?us-ascii?Q?dFRIvQxM9oD7vpeSSISEJ2+YiYoDQho3xOUasOgeCYTD2/MaYsuszWa+WNyD?=
 =?us-ascii?Q?S4RbR4N9IELnz3oM1VIjYM84VSNF69OpdIzJLwbKGrudftDmz6PAeGwkSXqi?=
 =?us-ascii?Q?CTInLM+a0Wy5QgK21York4yOAr8iPqGqDbNMt/Q+5wF//nV3frnRM42ILusV?=
 =?us-ascii?Q?OalQQ/7tOnJJWwbdO5Wy9Tu9ahNtXrZoRY/kotxFJJed9y9zHt3HdSKlzLmK?=
 =?us-ascii?Q?ABhPizGdEvY89ZCakI2U2c5KiC8euVCNEccDRYl5HeB5qIuJb9UbCqgC4VMw?=
 =?us-ascii?Q?JY4OBb9dWktAChSYts3rM3xMYsl7AmS+N4OJ+mNYLAYftxBoRvyX5Gvpn2rY?=
 =?us-ascii?Q?MB0ZLM5z3a+lvTMvSH/S6rPPsVnczlDgIbicUnhbKL/u8pDiy1cALvYM4QkH?=
 =?us-ascii?Q?pIOW2INmDqU4QNEl/mW6PQQ+5G98DJLRY1jf6BOuePZAyK/Spfpk25CxYkH5?=
 =?us-ascii?Q?7PqXfIEJSc6r6xKD6Nwnzak5sGewizvLUf9Xh0sfZlBycxdN4C5SHf+rwdEV?=
 =?us-ascii?Q?/yXDunnlQMGZHCCEm5yD/dQWjYZ4YlZj5LWd6lgZQnBYKisgmHvuTz7vR9CU?=
 =?us-ascii?Q?lGBcKRD82mUmrRjPY5CkOxQGF3MudQ5xCgu0HRRk2Hm+A1Xo4VTi3xsxpdQp?=
 =?us-ascii?Q?cBnuGTqN3sAScCkjF1ahA/h0wH3Ib2BSTJfj4hMraGJb6hiCTfxDKScxFIhS?=
 =?us-ascii?Q?MhAkEHds+lqt7EQ3BfYD0lNu25uihO1R94BWdpLAkW4xeyrotpepk4OhwMjb?=
 =?us-ascii?Q?votxaN5L3ylwWG4yQCuI276rpxjRI/t8oArbJcZ9CwP5HpF0+AxUDDQ7ZG5h?=
 =?us-ascii?Q?/G5fZVI55g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f048ca9-aa60-4289-95d4-08defb90e79f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:21:31.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2u8RB773XRRbYVUozPTlMFOYvKY8/O9hBSGUsM9Tgfhbyd4ICI8BKMQkpSDmGW1vsz8lV+9HkyVvlj6MVwJNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

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

