Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C95221D89
	for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776197362; cv=fail; b=O7mOzyGjRsDhlDlw7joudT+6uHWWtMkCiKn9YUBp//o1EevglYeOw+34zukVX2CQ9E/p9dyPlZd9WfzaypXODzdN93EOlzDxRA2PXzjuq53s0Qudv9L4LNRVQk3Osfk8SzS87jtEEH0zqoWNFManEHSQElj13HoeWQACATq2COc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776197362; c=relaxed/simple;
	bh=yiLYjJGGx4Oh5m76WKb7kjtxBveXVp2AczxOGmxVm1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jU14Oc+aqTBuLdzU5C2H2gku61SUfKG1psUEh4dbgDiyxLVKOe2oUEK5zLeoGYOJs2qbFYu4TlVN5SyXB3MyaOkuFfb3xvIPtGY7A8FMr+GrF3xGJcPhbVT1xl/tlrJ/qC6JbUP8J6IutioLDVU6qz8XrDmBUI8hh2odwic6ec0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WbyfPXLx; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WbyfPXLx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujHZqJEOhMSz5YffrNrZaLirUTMzKx3wJNy/jj7G6ZG6MXENFj7UV3zD7jsQmiQwmHcD+fqT4bqr5ymEZdyttxc/tLDWzZEwGTWHP3V72voLrfNy0uZZ1AblWULzFhPfOpGoWhBATAbBL6IQro/7k45jBOQOks7Juub3LOv8euQ5h5z9xAf5yEIsdX7BUWkoFrSlE7EOKbfXW7vPladP+TCP7sE1TvTkyM+2mFc73Sv0Yh557IcHQN0uGJXeIibPgegGWE5HbWmAeUL1Vhosb6tL48/XgRX6vslImseP+n7iJNsvuDQ7rDvoXrzFZton6Rd63mHViTZVLRUhIpBAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dS2Vhkw1bzRC9x1t98suHYAd8cW7MkqF54W0wuDX+F0=;
 b=CEnjH8t+c7Y4Ulfj2M2QJJgE2rN4Ui21yiuuDenI89E7T4sNM6mnDubHfFV3I31iXhR1YBQ81qk5NTUNpnFRc6qRkmqg303tNyEJfS6I1LYzM9Id0trM6hMpVVoql3YkCzgZ8NE9mEvljRVwpDVCDxmVJ6vO1fOaDic3xvcaL+chUaEtMJBd1GV/75sB/sBSUrnE9YhyWt/t1a70/uaLMnoc4B6qUL7ySiJ4DMYRt5C+teagfJo2bjw/FaDPV2aXN7nbtVmAFN796cgX4VE4Qh9uAlzA/uslGBwKCadE2pymS03JJghX2zfGn+6oS1EQvMA0A8DZkCW/1v1VsF60Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS2Vhkw1bzRC9x1t98suHYAd8cW7MkqF54W0wuDX+F0=;
 b=WbyfPXLx6SRPW6HNkgvJIgnXyGyQz94VUi5k8Cf+P+dger1nFHUr5CB7sJGDgAvt0me1J2HyEoopjA4y270wZ3fkZvGVmYnRSJ1fpWtLEw/SU/LoP/Y3E+rus/S5hx3h3O1wh++Hr9tbZN7Ad4Wsr+jH9t3A6T5y8C6bFAlcBpgTp4sbGwsPsA1iok3vp+gJW/pE/8X5qj4u/dNkCTN6O6IeKN+o0fVEaFYbezAiFI+jkd4/v36G50s1ibSCYBNttL4Kmjoy/FbYFTeK3Oy8r4xgSxgOqog5PhrMIICvNabaKIZiNfMcvibeZ9ODWivcyFs35nzHiR6vFzjYXU1cMg==
Received: from MN2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:208:23b::33)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 20:07:16 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::4) by MN2PR11CA0028.outlook.office365.com
 (2603:10b6:208:23b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 20:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 20:07:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Apr
 2026 13:06:53 -0700
Received: from meforce.lab.shazbot.org (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Apr 2026 13:06:52 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>
CC: Alex Williamson <alex.williamson@nvidia.com>, <yishaih@nvidia.com>,
	<kvm@vger.kernel.org>, <guojinhui.liam@bytedance.com>,
	<linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>
Subject: [PATCH 4/4] vfio/virtio: Use guard() for bar_mutex in legacy I/O
Date: Tue, 14 Apr 2026 14:06:22 -0600
Message-ID: <20260414200625.3601509-5-alex.williamson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 70865582-ef87-4f95-9b91-08de9a616d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+asB8Ma3M4tIkB5z01mkERlDgi00dDkP+ieQn01yy2Dd4cqzCEbFOLjDIn2mH9cAtZTVLeAZSPa4A34XBHafL298Q0QbPYNl3J5XVoCixkRFmOYJZU3MBAnJuvdvdwp1/cM8Tl31eNfOAp0ReFm816EtnSGSW+lmy4qWB0YKoeZotkIRLjrRGITCiGhVIEsHfqOZoNyOKVd/nKYI/aS8JeqnHRCp3eCWJfnHI95Y0AR9N2Yg3Yqilr8oBxW55jRf91M29QcecJiP7M2O8aIrbfuHR+ROt4Vpj1DoMNYMbKnwd4CGTMgYHQjlfEREnYikBMWAXms88zYOPS61cn/Y4fLFZ6XQWmrI0X3e30OBbNoePVCnTWEVuTW5tpClugeMW19uzdUdRddmBTq6ISdmRAdrEPKTtalrlHq5NIE3+ZTDsIV+0dz5Jpel7VHdODtxJeDp6WKZ4kUON8oqkIuWd8X5opecWb2W5eA62k/uc5TU4YtHqwBuh68sit3qnLg/KMV2JYhJI7K41vIOP5D8aX1afb5wzcstflxacwCNeEyiW7aYrcR5/y3v/PtX5oS/4b5/lyEtxDu+9b5gLY9JKt/zW5zpH6VC3AwGdE7Pb7R9w4b7e4e/hnGDf6XacnQKiEcs8A9V0BJ1K4wT9LbxO1OlE9PYEfvId0pykEoJD5yuv5vsieuZudl2kNzAQbxthRP/Z3l2nC2axffGZVwQtbs4WWmQTL5QfYuf61dbns8Ca78BrrQfcJwQ39ucPToVt495xffEILE6IMIJMpcYpA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xhyL6soeXUxJf5gFS6/I/lGHPuTFhpcEJnvkFh3GQynE9OPFzZkGP/tiFvlswthFYHS6Uj3CLeuXbJQlyfr7TLS4nICdAb6bix3iLOnen2aTIReVvoVQWjoqTbXHrkmKRxAPZRDtvMX4YjgWDZwyswLpxztbJx1cUVVIYb69nPJergRmkXZqQSTp6uC53pOqoiP/6OsEubFOaEPZ4LxhNIrVaA1IhYz4cpiqJuEd8CZ3NPk4ezJQjg2Kex7F59ZeCRHuGmdU95Y1KBFs+xQ6dv1GtRT1iOXBG+dmmK1UdKBoTWrceG+8x45ZqdiJT0i9TR0g6jZmpreJvFg6fYrvfH/NW3R+nJFCV409sI/k2ZeUuexTseEBwmhn8Iwecbf4BDoJHHhRBa3X6JezgFqbyxvqnnskHsbAix/qplkVW+7mS9HK8TOSbrk0rhyJmhxa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 20:07:16.6133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70865582-ef87-4f95-9b91-08de9a616d36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794

Convert the bar_mutex acquisition in virtiovf_issue_legacy_rw_cmd()
to use guard(), eliminating the out label and goto-based error paths
in favor of direct returns.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/virtio/legacy_io.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/virtio/legacy_io.c b/drivers/vfio/pci/virtio/legacy_io.c
index 1ed349a55629..f022301e60d6 100644
--- a/drivers/vfio/pci/virtio/legacy_io.c
+++ b/drivers/vfio/pci/virtio/legacy_io.c
@@ -34,7 +34,9 @@ virtiovf_issue_legacy_rw_cmd(struct virtiovf_pci_core_device *virtvdev,
 	common = pos < VIRTIO_PCI_CONFIG_OFF(msix_enabled);
 	/* offset within the relevant configuration area */
 	offset = common ? pos : pos - VIRTIO_PCI_CONFIG_OFF(msix_enabled);
-	mutex_lock(&virtvdev->bar_mutex);
+
+	guard(mutex)(&virtvdev->bar_mutex);
+
 	if (read) {
 		if (common)
 			ret = virtio_pci_admin_legacy_common_io_read(pdev, offset,
@@ -43,14 +45,12 @@ virtiovf_issue_legacy_rw_cmd(struct virtiovf_pci_core_device *virtvdev,
 			ret = virtio_pci_admin_legacy_device_io_read(pdev, offset,
 					count, bar0_buf + pos);
 		if (ret)
-			goto out;
+			return ret;
 		if (copy_to_user(buf, bar0_buf + pos, count))
-			ret = -EFAULT;
+			return -EFAULT;
 	} else {
-		if (copy_from_user(bar0_buf + pos, buf, count)) {
-			ret = -EFAULT;
-			goto out;
-		}
+		if (copy_from_user(bar0_buf + pos, buf, count))
+			return -EFAULT;
 
 		if (common)
 			ret = virtio_pci_admin_legacy_common_io_write(pdev, offset,
@@ -59,8 +59,7 @@ virtiovf_issue_legacy_rw_cmd(struct virtiovf_pci_core_device *virtvdev,
 			ret = virtio_pci_admin_legacy_device_io_write(pdev, offset,
 					count, bar0_buf + pos);
 	}
-out:
-	mutex_unlock(&virtvdev->bar_mutex);
+
 	return ret;
 }
 
-- 
2.51.0

