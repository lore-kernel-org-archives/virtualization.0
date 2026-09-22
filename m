Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F34519E06
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067761; cv=fail; b=Q/610W7ZQyGg52Yt3v3GA7cbT7JcxEch+iFGLwkWE+tPQHuISkbvOaj3MilcadhYIWgccflqkyDcJSniSDXWg0cDRw4kZVRe41e9R/JfJ03gxJ1Sx2fl5vYgSSb4xBrR1SNd7OLepsxbMmlmc2X0GdoPB5SipTVfzIpaGNG8rls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067761; c=relaxed/simple;
	bh=LQ+ob069geL1G72Muln7i2qOu1RuA1PRvsQ+PsW8l4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bgjui3dLVshdFkQ+HfP9kCZ+9EBqOAMEvXAF6VTYx99xlZJYhYMkiHTeNEE39YmkCxxEtS+KuiN02qlIyVEj4gVQblalnWE2Ieh5A/IyYLgSaLpA8kuWsv7awGWDHPeTYPv4UqIUKbK7R9n1dTRO2stQZqXaVTM3ak9quERbU6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dS0BgweX; arc=fail smtp.client-ip=40.107.209.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dS0BgweX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5uVtIdJb30p8dnMl7H2sPBLikWh5mvygmw+TowCKu7PRCwzL31P/SA23C2GW7GmaWC2yV1Kjp675KdTir9ZOVF+pvyCXvxlGBRws4LlHjMdcENSTdvsBUO+yIXrMD5IsAuhuKUoaiWjITbJ5psJKQt3Fq4YmPqTcrVjCtpDkZSzaKnFt/lJjGz9wDZjwcjFzMQPhkzFQI/gVezMExLjV3a59kT6k5726xzvK4uAX6Z6rx6cqNdY/MLB6rMcasNjAnxaJZXVHaB0/5l01uW58WUVxXYcd1hjyDylPt3xKl5S+c1IIgiqr0UQfhGvxe+XB11E6CfzXPnGGI5MXo96Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFKPzNjpYCrCHJeD5d9DCS2wpyHIhrr7+UleIhUJB6c=;
 b=b74uq/tanGMz4GoTk4cVmENEgb/cRsSV+W6Obkc+ZuUlsu1qBPQ59tXXGlJxFbxFt7NrxWAtIvyAYWrTgUitf/K2iyMpLo+x0E54mUh+zHYbOcX8/t2g3SmfNWGmM8PFmModJPsrf8OHM9kr5xoxRfZTHCpKJcPv3wktrjVbD6iQq25YfzCsz3UFdK5MYIH/D3za/AfE7s+aG5gobIQ/DCQW/M5pLVInHLT4WKyBBtcXVkWFLa2Ea3jlNBsN08AIBAirXnuJ7YpJKVBfqqfWT7pPLtpT1X6/Wz8gz7uMcgCqrfTSlCEnzCsuxmhlGKE8JyJV1LSuLLHZ4hSkoFQivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFKPzNjpYCrCHJeD5d9DCS2wpyHIhrr7+UleIhUJB6c=;
 b=dS0BgweXGSqXYeL8VYEYGJ3yJGB7KKv2RaMbdpCdhuZKkK33dW0ijHYebZtIzR7YeQm8hqupo012nE+iR0IghDtDCgQYugh5jdh6Gpxp/CylygFgOy1u15rMuN9v/eOQUYseoZlAYWluasmWGPeZMjBj/iwboQghCrLOrzbQAvE=
Received: from CH0P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::10)
 by MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 09:02:36 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::4) by CH0P221CA0002.outlook.office365.com
 (2603:10b6:610:11c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.14 via Frontend Transport; Tue,
 22 Sep 2026 09:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:02:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 04:02:35 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 04:02:33 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <linux-pm@vger.kernel.org>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saravanak@kernel.org>,
	<mst@redhat.com>, <jasowangio@gmail.com>, <eperezma@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <virtualization@lists.linux.dev>, Baorui.Liu
	<baorliu@amd.com>
Subject: [RFC PATCH v2 0/1] cpufreq: virtio frontend to report host CPU frequency
Date: Tue, 22 Sep 2026 17:02:23 +0800
Message-ID: <20260922090224.430-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916073735.541-1-baorliu@amd.com>
References: <20260916073735.541-1-baorliu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|MN6PR12MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: f070666b-1e15-4e34-b911-08df18883edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Jo/3f/i6q7X9CbmJXVCwXpHFc4yXTAYzw6WsW4tw/tGA/nBTSyAFb5+SapRVT777/KjiYAfC8W9RnteUAXNmmrVphjX8FxW16Qz7J8M/UnLsJitLV5L/MeAdAGKCuy4x/9wj5Tx16j0nQu3yfkeT7PlyDpf64+4ir/8mefe0ZcO/C8nv9ZHTHFDM3xGukSmOgwkeZJFOkPdQcP6YMrGOMr9tq95H5SSB/ta45GyXOE+8jFr9zMXUGaXrjlCFzJb0kSCfX61MT3NGgF16PECatSeSho0ENXg3bUnR/jgSIc1r7c2avuejKVLmJBxICSsOt146ONxwLPTzqpCVn1hobnI7ArPOsSN+1cjWdXwX92gQ/yJKUMFcdfECqN00torFyCJaaz31DxO9gHEt/XeLQNBifHwmbFP8l5l4zEYSQooL3ayQldV3BgR6rIpAtiGhMym9Ms4xyjCXaTto/MaiVwlWmWsmVZeyPD0nRlrImdWPOnL/CsrH42AMxYFbf3DrcjnH3rqjUunWZ+Hq55/SOAJgdM5IoTHu2ibtZLtJVljM4MPxjWWoBk8h/fOUydtU4EP+AJhpsoibIy3yCOHDtHv0PYInkfaw15O/KU4PRAP7+JOG4pzc/m4WsuoW2KrcfuH8l/NJyRwYIXeNeunNiskte6fDd0ofXugMu0gZK6oMNpwj2gYDindT6e6NMozYXL91zXQxCU6QMAfOuPj+zw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BRmd+XpC6jk2ROS8cxsL/9yeTjZU0EVWySQ79tiB/wBxNKMnwN+D0AZzEZoVC3OHqjXcDrt4HOqd7YlWC71eCjJFvwQcYZiGNbTgfvxKeosI6VkCni8/9vULcg9o0NdY/dT/VPhLEQoaPYMFgFpOB1lLe7yZ/f/zIemOfybSe32hd8yn5iBBF8QIyrBbt1FxC0CoagMtqhnWNJP6Ce8uEbV3qit7N4TeVpVKC5Y+NKDnvffcLGq4qHpAjbwr2MlFv5EVXXkHSSuA3FfeviTgz0Zjvmlied7TpVxjDdVkfBIlCAtD8jGUCpGWb49Gb9Ld9AnVUY+czbr15tptpNuJiLR+OBa3ng/md2hqGOfWb4t39AKrXW6IH5tEaZuFVkQrCEoXXN6aE2PbFgE0+uCygKdSwGNrFsVylYegg441E9UYsbKmdcXVezAaHBFsg23K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:02:35.8554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f070666b-1e15-4e34-b911-08df18883edb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491

This is RFC v2 of the guest virtio-cpufreq frontend.

Changes since RFC v1
====================
- Fix 0-day kbuild error: cpufreq_generic_attr is gone on current
  linux-pm; use cpufreq_freq_attr_scaling_available_freqs.
  Reported-by: kernel test robot <lkp@intel.com>
  Closes: https://lore.kernel.org/oe-kbuild-all/202609191437.OaXd0Blz-lkp@intel.com/

RFC notes unchanged: experimental virtio ID 42, hardcoded OPPs,
sleeping .get(), QEMU backend is a separate series.

v1: https://lore.kernel.org/r/20260916073735.541-1-baorliu@amd.com

Baorui.Liu (1):
  cpufreq: virtio: add driver to report host frequency to guests

 drivers/cpufreq/Kconfig          |  14 ++
 drivers/cpufreq/Makefile         |   1 +
 drivers/cpufreq/virtio-cpufreq.c | 240 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_ids.h  |   1 +
 4 files changed, 256 insertions(+)
 create mode 100644 drivers/cpufreq/virtio-cpufreq.c

-- 
2.34.1

