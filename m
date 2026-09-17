Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013004.outbound.protection.outlook.com [40.93.196.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5883F4C0409
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640765; cv=fail; b=Ge/nvJWVi9I7+PCV8aJ/p1OOGON1CW8L+FV5oCSHqUcmMbzTLBw2Rn5oPLzyEZrknOWuuN7YvcbrJHb0O3XyB1nBob+uNT3h15pzjLZuJ04+daWQdMP5l3o3dSThcrCqrrvjjoL16F9BCDVeGIeFk1OF3An8smjOeBqLtxcSIOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640765; c=relaxed/simple;
	bh=6OqBCrNlCbKfUHg1aYmgplLZCbA68IamPMGGqzoe4R4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPR11b2X5cO3VxOe2sCQ/hAuMUtJU/qG1vr9s72nPlHW6QOgNux/wY0eCwXKK7bbTJTPJoQA0DQyUxNO6fG4sB1E3ZL3LQqdyrD7eIBgTDrMH0YR4QHYBnpOaHSXYTV6GBxD022wHhCQek8BIZMcj0k0Q1Zae6HV9ppaJNnPHEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H//BA/rY; arc=fail smtp.client-ip=40.93.196.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H//BA/rY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkyJCNu/NxGv4pXmO+A+dq9IySPIxEufwfPGsePBcqUCKFfCJIC8iJI150S/ajA+edDTTUiHQBZ6IEBFyYzajMT62bx/g6i8OTgGLwGCcACFGPOpZL5L6BfcfL6XZm4Vi8lUqTdHZvCkmP0LHZGfRACjXnh2NVKhb5hMQ0cJqa5iyzL0zW/Ff/phYF/aUTaRxwyD6EcQkiJy5+rNbMGcZPO7uvsav96Gv/shoKPHDbedjUZHAYy9pRSr6GA737q1RD3iwI9eJS0z/4S+err5Yw6KU02pbRlPMFFNpNP5gx77W72MOf+LlQXGl+zXze1+MKcaMEL1K6QVyCpjoQbkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C13yGlR6QUVJddasY+qp6vrkTamK1OJUKcO7UnvXMI=;
 b=gyRPxho2bdS3ALhoWNmspqFFnpxYhLgoxbEd7gUsTFCzgLD7yq940grg20TUR8ck/I4DMDfx0GCc6n02du4eIRIQx9buJeyY6QHpk4wJfpJszqv23h8JEdToeRNCTDvphsHZXkLzidEbbg47z2HRzdJ4XSpi9y5DqZUVppoa3l2IsoaFuYwkDimlCkAmYeTq3fgCBQOpvOpSpW9WyUry4rAkO8Krw4NhxtPnWL6pLT65KzdCdcKlYIeEmdeYKOeRhd8SIeHnNCj6g3V4Iq8fF311OQnXGPvvUpbMfDFkzQxxgiClIL1QAKNlreBUpC66LmBnfobEaOtK+cF8qXgTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C13yGlR6QUVJddasY+qp6vrkTamK1OJUKcO7UnvXMI=;
 b=H//BA/rY3Ax7DbTQ2adzD7KzbuSszdszuYB97lhyy7oKHPfY0co1jxk5b1mShl26E3DVIP7xlId4AvfaDjNIcfqLvUaNLxfct1HYjRHirCLku+Shh7r9ha5kiu4NVxA4JODTNDKY5/6Sn4/GmjAdNbLVbC2tYhv37tHshssmf/E=
Received: from CP5P284CA0238.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:22e::8)
 by MN7PR12MB148230.namprd12.prod.outlook.com (2603:10b6:208:630::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 10:25:59 +0000
Received: from BN7PEPF000000AA.namprd05.prod.outlook.com
 (2603:10d6:103:22e:cafe::34) by CP5P284CA0238.outlook.office365.com
 (2603:10d6:103:22e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 10:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000AA.mail.protection.outlook.com (10.167.245.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 10:25:57 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 05:25:54 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
Date: Thu, 17 Sep 2026 18:25:37 +0800
Message-ID: <20260917102540.1312102-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917102540.1312102-1-honghuan@amd.com>
References: <20260917102540.1312102-1-honghuan@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AA:EE_|MN7PR12MB148230:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b5f885-3de4-4958-7b0c-08df14a61028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4wV70ls9gmKL1bUH/jo2Q7mqHM+o2XgZn8tF9zeNsDW71+KV83uIc9xYUxdVH6+kpI7piBRSbyc7Q0SK/s51AYABCdXV/kUrrRTp0ZNzp6svMuWCzMpo3RfLeAuP2FDq+lkuoSo30OdRaYi94iUZ6APqUUL56f/n37LTDDgw9wRAg2vHQVMXJDAStSEKs1RvubsRn5SSZFfNpIbaeZnT9eYJYv3jubGOSTxFQ3sDVUsuqgSNgT82Ul9hSj4WljHtDHHuhQp099WPhT+ATCfwqUYGbVFzBlRHlbYQ90JGc38zC7P7m6l26S2e2ZfDvMoAgSaP3JcUgCq3lEj/vv/+0ZHS+hmO05Kghgtf625EBoopds7mGEEvkXT1qpsJ4UXrxphXH8fxvVegnrUxDhRBaEgUC8V4yxyo3poLrW4MNqyuwCqvfUDpFGiAvTwulrVYJKkdknw8e2Z69nsBv+sdxwPaBrzOIlGym4Rh+k3/aoQ8UBOFmay8GBaQlxXQTN6PSrrZDaD40c1cPJ5oyxm1RfHZiisMqhO8VLkGS4M6kjNzPs/8rP/s4wc7QC3ZHpK72uzAOhJX6XjyW7pN5gk66mOYxr6CY6qjH5SGf5GUVXr5xHpzDnJhU2QUadd5X2JnS+iZv0/LFy0vPEPfyfqr5837RghIQ2ljTwj6xuxNsT9O75FI1UW7RznnF+duNYr0FfZ1sqi7uBc/KH7oqN6Opw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d8ar1+u+DziY4t5g0lY7CprkXWAuH4aoKNsWhKqDR0vqtG4xaHULjrC74jZVKTwZixwxlZ/2r9WogWsdOCa03wPFvQXOaMPJvN9KZHHtn1P8sMfdqJw4r9mO7UQUWVc2mtR1Jj7/kTslA6Yr8NgQWl50GyPb77ztDwmfgIyOVBy5+QnkjCywB1z1u/bwqDaN42R3JrLkRuc1ZvTYBpsaRnAcN8tKKEg/8+NTrVCAOvDcfu93orfwDitpCidHiqDzbHlRRqftWUTeNECcUeXu6aS9pKs7vHfktFDrLD+Epysoo/FhCpX6QK9IXrbbbW10EtumjD5oMN8XW1iCjXcMQVh1KF79ghGl+xxTByTsuvfxtVrV54qn6yy3OwCqLbIrUCIb7nUIUr6jttxDdH4d7GzOtdhajq2Gi92UOKnL9lux+RjmHQg6phuli7JgpnNt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:25:57.7681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b5f885-3de4-4958-7b0c-08df14a61028
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000AA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR12MB148230

Add a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support
ROCm compute workloads in virtualized environments.

ROCm (Radeon Open Compute) is AMD's open-source software platform
for GPU compute and HPC workloads.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/linux/virtio_gpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 4f530d9005..3d4dfadc9d 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_ROCM 8
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
-- 
2.34.1

