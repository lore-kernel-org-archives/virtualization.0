Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC023246F4
	for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776197241; cv=fail; b=D+tT2f82HFkD9WyCel2FUG2iZTNSz9Iv5I9xYH0Xkc9YtFak9rYd/7Q+bg8Rn5Vsfg6RRuei2v2FgbG4s+llqy3dfg/tjxg4oTyUaXHTSwckePxti7+HJWXJnQTK2+ikVkC2/aF1OgtEadAzg9I0iv6WJ6vMUYGAomfmPEtpaUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776197241; c=relaxed/simple;
	bh=wnS9zkibxFXdPQZ4EXhXd9Kd4dYryCn1VpwuK5NltP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=so6woxYQVYg0rKVbEA3yyA2zlBXqflz/PiodLvIpUrSKZw5JzIc0hSqIYVbX389Cl7pgO20MpWE8EjZLd0gsKgo1NnKf2+tO+HhetxuVUUQpmK1OmyZ9hTE5QAw3NF4Rp8WD+msk5LZKBy2Ximq/AAPLb21j8IF/avZqDp3htTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Opl2503B; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Opl2503B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctuNB3n987gIpnKK4Khl91tI0+kpvpf2Pkj/a2lF6GFWOdKh5wmbEwkHjpAAKCjz/mUHTInRV8Y/wgO/gUHQbdhgSPrtAz1nZxVFYOsTbRE7D5sHpYcQb0RIeCjR+RUFhglvh7rVcBAyEjnaPoJIZoqafAEhnYtPGS7EGQfCM7x21yq6DeOBEfNUWRT0GSQEzK1Fwz6NbKQk1weSlQMmRahHUC0sbFKz1KpP+BWChL3VI4Ic2nGhu34LRSexwlDke6V38wrskQBNR0I/d6CESuPlenp899117TddOVRTbhxeg48U0+gUKqRk6wGw04KYiEDTRqmiZjNd6uwJc8m6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xp/OXiZS6acLWIwhxMq7w8ztwgfy+DD+rF8EdXrCjX4=;
 b=UZVu8+8gymwR0UrIsVeDqAPw4/0TrhvPkCbFcb92RrvzctGLkrcWEeiaJlXaBs/TS5jKxbw0LAbv1974I5/WE1GldYiqVTdKWd7LhKrM+TPRDuNy3/S+ViE/vKvcFR5x9H+vm51cjuAVSfXpPYa6tpovcmiWxSHopGoRECDMswvrIGo0T9/fBVrzI0H8uC0tRYlxILMGPNF23TRUziC3HNUeG11rgpilqMGXtYuN+OTczJ0q/NLo1nd3WryHtL65Kcv5WtRly3PKkBlQVUZB/WCPlImAZQenTMKGV63tTWNgE/LszJ642yI5F0NiPv36ijiayXnVsUUUrHq0UzSRSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xp/OXiZS6acLWIwhxMq7w8ztwgfy+DD+rF8EdXrCjX4=;
 b=Opl2503B6X2d8/8F355NbU8CrmhbSOx+hP0V6DE5KmDfmszXlOrxc5kpkio+BOXLeb5Jyh1Zxu0/l8ie6DKhu7ZtLec77SRt6nUAWN0+ydJiNG0LFjCXUG9V+mSxFU6Eluj3RIl71zhbnEHtt86rhEdpezAPwfVKUi0ngxm1a7p/IqO4+Q+ygBp3+LBdTqFbV2zXHk+1T0DH3Rpu5TR32vqPbs+YFC4XbSScAZ49fcW63082oXtIT+lpvJtEkv+m/gbXdyBUgVH2v8jJAx035J+0IDf7RDIsWmEsPgNnqPkKwaRTUrKjszg9C8spmKcYvystfnCdKbmLtDtF49+bng==
Received: from MN2PR11CA0012.namprd11.prod.outlook.com (2603:10b6:208:23b::17)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.35; Tue, 14 Apr
 2026 20:07:15 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::99) by MN2PR11CA0012.outlook.office365.com
 (2603:10b6:208:23b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 20:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 20:07:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Apr
 2026 13:06:52 -0700
Received: from meforce.lab.shazbot.org (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Apr 2026 13:06:50 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>
CC: Alex Williamson <alex.williamson@nvidia.com>, <yishaih@nvidia.com>,
	<kvm@vger.kernel.org>, <guojinhui.liam@bytedance.com>,
	<linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>
Subject: [PATCH 3/4] vfio/virtio: Use guard() for migf->lock where applicable
Date: Tue, 14 Apr 2026 14:06:21 -0600
Message-ID: <20260414200625.3601509-4-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260414200625.3601509-1-alex.williamson@nvidia.com>
References: <20260414200625.3601509-1-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ae34b0-1532-4eec-2e90-08de9a616c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mOATR5k9dYlKGgal9ucPAb2ft0yjRXARVDZ/5gjHlYCU0YFkmFMzVprpuUXDWwclXhYo/234m321LX9HSQzsq0hmSfOkNwyrw87qDKu0YFQlFwft7UcnR0YqxRsm+8wz3m+r605fEuqr1yPX3ddUdOEpZb0HrdUI0bpN2L6a0O/DIKSgA3fmE79Wffv26uAcuTQEYXrKf2FJCpGDwdyaoP6ZzDJtxEeSRKApbBoSQ/kCU1qVa8ju7lBuXdjrkx5SPKn6bM2utLXAW3Nvredm3K/VG0UDvLo8zJUTJoxb5hNJWnWifmW4nFcL+6sfX+zW+v09M+6OlUfNcSFQQQEMsIIs3KAdpsvAoE1kOUdaycokXxBbzNXA9y3pkmuV999BKpWdVSRQ0L2WwkwwtHHmV/MS7Ea6+FZAZ6PdmZGGYKq/Ze+Bbo4BWTmRSGQ4ad0zJp0xo9+EK7taCVGUEx1zqffqa2uxH2j1JxzNcgrrCKNtFRyz6eMO3bkJwLYwPfWnL1X6/92tm/lTouO7g8wQvwV3IJBJEPaX3VmHkU8POkBHWiehbdXp1kfxg19R6SqtAoFUL5Wdw6bL1B96ds8grhE4KK7zpj/D85rvL9skvLLbROgr4erYN/FDKR5J0GcoFVruXzGoae9iSRawYBOWSsABouaitPo18kU0MKQigCxTw5emrd2mq2myKNZYLmYPzB5pRt9cNI7fu/23XVLv2rhhJfXwwxJX10/UfeQePRBqzqsG5OAs96HnWW2iZXSnTWjBboVM/DHkliiuoSKU3Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HATuTWSKvNtf3HT/u2CzDLSBlP+Ci+4vJgokdKXE+46rTHHCQKITyX7F6y51O8sPzxAxgqXMvtis7RjPoUI3vYPIVEIuqbFlWRM5E1QYJVTt3fIbMH8dS83PflaJz6qtqAi5lpibLclgK81jsT3uzSqsRxGhlzhzjnYXsuauOWhFSeLXdBWluq8yn3mrbgdAwstJqOqhTXhTJG//T5tQPuF3odVtcgvk+hL8BO4N6yKuQtNKKjWja5RClcZbJHgKgadvvMUpyJywFuO4RccQDeTDjdpeom6Lh/7ekRujKoklKAcrFPIloO0ZTz6+KU/3VIlbI0LoaqdxsU5hNHiX97Dv1DvxYjwwX1eiSAFXwyedhJHO6XL0CG+iBSrz9gghCy/zGHRKWmkv8g9WR2HeeRfm6EipGI5guYL0mUei2pLPWjIPqfaNL3EX9xgrXpOZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 20:07:15.2312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ae34b0-1532-4eec-2e90-08de9a616c64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273

Convert migf->lock acquisitions in virtiovf_disable_fd() and
virtiovf_save_read() to use guard().  In virtiovf_save_read() this
eliminates the out_unlock label and multiple goto paths by allowing
direct returns, and removes the need for the done variable to double
as an error carrier.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/virtio/migrate.c | 40 +++++++++++--------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index 058d359c9b5a..80ca8a1b625a 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -224,10 +224,9 @@ static void virtiovf_clean_migf_resources(struct virtiovf_migration_file *migf)
 
 static void virtiovf_disable_fd(struct virtiovf_migration_file *migf)
 {
-	mutex_lock(&migf->lock);
+	guard(mutex)(&migf->lock);
 	migf->state = VIRTIOVF_MIGF_STATE_ERROR;
 	migf->filp->f_pos = 0;
-	mutex_unlock(&migf->lock);
 }
 
 static void virtiovf_disable_fds(struct virtiovf_pci_core_device *virtvdev)
@@ -385,11 +384,10 @@ static ssize_t virtiovf_save_read(struct file *filp, char __user *buf, size_t le
 		return -ESPIPE;
 	pos = &filp->f_pos;
 
-	mutex_lock(&migf->lock);
-	if (migf->state == VIRTIOVF_MIGF_STATE_ERROR) {
-		done = -ENODEV;
-		goto out_unlock;
-	}
+	guard(mutex)(&migf->lock);
+
+	if (migf->state == VIRTIOVF_MIGF_STATE_ERROR)
+		return -ENODEV;
 
 	while (len) {
 		ssize_t count;
@@ -398,34 +396,24 @@ static ssize_t virtiovf_save_read(struct file *filp, char __user *buf, size_t le
 		if (first_loop_call) {
 			first_loop_call = false;
 			/* Temporary end of file as part of PRE_COPY */
-			if (end_of_data && migf->state == VIRTIOVF_MIGF_STATE_PRECOPY) {
-				done = -ENOMSG;
-				goto out_unlock;
-			}
-			if (end_of_data && migf->state != VIRTIOVF_MIGF_STATE_COMPLETE) {
-				done = -EINVAL;
-				goto out_unlock;
-			}
+			if (end_of_data && migf->state == VIRTIOVF_MIGF_STATE_PRECOPY)
+				return -ENOMSG;
+			if (end_of_data && migf->state != VIRTIOVF_MIGF_STATE_COMPLETE)
+				return -EINVAL;
 		}
 
 		if (end_of_data)
-			goto out_unlock;
+			return done;
 
-		if (!vhca_buf) {
-			done = -EINVAL;
-			goto out_unlock;
-		}
+		if (!vhca_buf)
+			return -EINVAL;
 
 		count = virtiovf_buf_read(vhca_buf, &buf, &len, pos);
-		if (count < 0) {
-			done = count;
-			goto out_unlock;
-		}
+		if (count < 0)
+			return count;
 		done += count;
 	}
 
-out_unlock:
-	mutex_unlock(&migf->lock);
 	return done;
 }
 
-- 
2.51.0

