Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6923D297
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640774; cv=fail; b=fKJpAE+/s4s/0sx7uglU70EtHG6LbUR0j6ForJvdH63ZJBV4okJKHE8yOXQh6xWW7nXU+n7dDl3gZom0TRchHe2D+GlUtNbu/Vz51jw6x3pZec74OMUieBCFgaZrVvxLDkLkmffGwjHt9p8NjvIvu5mGsTkbQJHy2t0LtOexgzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640774; c=relaxed/simple;
	bh=dQ8ezoOGcjLBmCEsjb2ROFVSLQq84RqLSYupMWX510I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sshtq7zYHFXsGZUBI4YV9PWcKkDvVC5M2jgptMjScsmzoYTTXWOoE2+Uv96+284RJgEqg2rp4okLFLi6NMBBb4RaWa2giM6CZ4tulfHxYIe74raDncIQfhPn8m5LvBcxwmYA7F42aNPsfVCDMGtdedWZNbfQv7ke1jdS6GM+yVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U5X98vPA; arc=fail smtp.client-ip=40.93.195.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U5X98vPA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTY3pBNPT9jV1tMmkTIZXgOQ6IpIndsK3UnkNCa/rk8gL7h/v7sF4C+YcTzTOusvnONLYhnPNBOmMplD5lraILHH1mmYT6h7XWVOt3Ws3l20Z1Yt5ost5xLmZZNbz6ITK6ucvOuTCszugjD3Qc2ByjGFHbRx8RPjlDgB6XXvP6BLTI+y+wNTFo2dK1cS8GfcbJnrCouTlt+lg8iaYGQ45PFfHaO3lRTQcQSiggazdBaBUuihdiohV+lPkTwZQ6Ouk2SIeqOHvukdxy2eWvwCq3CapF1K0a+g45MPykNVd46oN04Hq2Dsi4gqCQNoGVXUW1Mjxkv6OT/UFYfoXx/Dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk0vWSr6OIUpvKBVbdsZQRqX/zYPqlbIMQNclFq5GHI=;
 b=HHQ1kWqKa6dhoDb1BKK72Y8ZCT1OZCz/YXJbbRcGrF6REAc0ztV1bB9xFZGNzOAQfRjejugHJhyIogQw6CHf9d6DegVrQkh2eWvIjJ/Ndz/UgXq9HzvBs1xI4tWGqzWv7f/o08b7GukhC/yGgULAWDbQOSzns+2Pbqb5s68peCmQGfzdsIX1/jG0s2hxz4Y456TABIFi47gP1QvyLrz6+wL5vkPfDYcDuFVEHcUiI7tm9Lc7xGcKQYS+SU5a+c2i6vvH0+rRFDhmfadktO4T6Q7h1tVkrLtHsGGIXlhezP//5WLmfxYgjqqfLIpXL+cB69rq7YyuQXnVAR/SemjxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk0vWSr6OIUpvKBVbdsZQRqX/zYPqlbIMQNclFq5GHI=;
 b=U5X98vPAhyCnMlD5dLBoEyyq/nZlgmlLElnXitwYN29Iq+XH8v2jU2LNUdOjlvMGGlYMCWxUoNC9fT3UGSPMRlnVcj3sOtQizKnint9UKaVDrawIv53OLPIERHy9ftzI89aUJzAspe5tOHS+yxEiQXHg0bFxaU1Ou0JTrLUU8eY=
Received: from BN9PR03CA0437.namprd03.prod.outlook.com (2603:10b6:408:113::22)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 10:26:05 +0000
Received: from BN7PEPF000000A9.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::92) by BN9PR03CA0437.outlook.office365.com
 (2603:10b6:408:113::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 10:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A9.mail.protection.outlook.com (10.167.245.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 10:26:05 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 05:26:02 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/4] drm/virtio: wire blob ioctl creation to userptr objects
Date: Thu, 17 Sep 2026 18:25:40 +0800
Message-ID: <20260917102540.1312102-5-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A9:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 875798e6-eefa-4568-ef28-08df14a614b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Rm1VaoMRMMUm8ganoM43p0d3hBqOdMh7IjZdHcmTNDnQZDQ3lsJgbS88kQGcF9/aHM9Rf9288b9qlKdjOL51bpyUKlBrjXrpzM6cnlnMLNVs/hWuMjJtDYHT4lneoEAxGUtnS8O6jcoHOFYRppKCLZIYykQMDThBij+mLx+458zD+W4vvmbyDISu4gdPt6PfXpHApT/UkPgPWfxNdAeC5cVKjmziYUYD4eI88vKUBa8vifR7+DFiyx7jtSZmE6bxcgIJgJAE4N/nHYqoTaWCB6697Mi8yAIGESHt5OewgwdDvvL5hpIIvJ37WYwT+DUUAGmMuBoJb6TVbRbx8gq1OOiir7+gjdzJreu9OT+CgPuSHZDh8zUm1LwjQviMvcN+hAH92TggJvt64jwvIg+EWZO4qri89aYNK6yLilGZ044SBH8YuQsoN/C0pG6oS8sWEICqhZYA4nFOiTIbD5l0iMdh/mtO38vmLp7QWuLJ1yniAcrrt4dwO3aj/vmmm4khc6T/B75tnzz51YGuICKofsMofQm4K3oHhN4zQqQ9OxkLpAdoqFv/gV1AqpbHmBFoevPdCS/krPSMpThsvtiBKnVqV2FoVKVCNXZTSVYCkZTtOcoSkymuDnIviHkkKURTTP24l1TWKiFj1uDRgGaB7a6Uef/PO6OUqSKmg6VwUHdUyFmJiwVL6t2vN14V3EsT3uJ6K3nVX/kFeX1e92K0Yw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UJSwhuavdMGfiXc6smNzwnt0ei5SWoWFKOiOg+9xOb7JIRe6Q4gwau7o+dPfcqZM3uBkZZbzcK0QIvPF5izMnMTmBwbI0ExpLeEt/FL4EZwIZI4sEUM8ntQUg6s/BgwaQBoQ0NU0d+g+du2pUeDjbpBzBE0OT7jmTFimJNgtS2dqwecAq7Q5rWXjo1D0XPeoA1eKUNkmVTMbABbiIL+T6E/IYz/w44irZWarMccNSkqYnBYl1KqaTnT88kvyZGc0SYwmN5C3NtyQ1m8tDYMTzR1lUpV+0J29HnBLYOSSAOPq13/CrnWV6SMVzdwnRQlPswV3pfILZ2VYa1oNgN6OLrXMPHlK9FeoirpLhiKXqtRI1vS1JloGyEUEbDa4tDuFLUFuUHTTQz6VtzdOUhQf23eyS0Gbfj/xde5Ew+LogcTQLlgiqyq+MNo7SjONJ8J5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:26:05.4311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875798e6-eefa-4568-ef28-08df14a614b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053

From: Honglei Huang <Honglei1.Huang@amd.com>

Integrate userptr into the blob resource creation ioctl.

- Include VIRTGPU_BLOB_FLAG_USE_USERPTR and
  VIRTGPU_BLOB_FLAG_USERPTR_RDONLY in VIRTGPU_BLOB_FLAG_USE_MASK
- Require userptr if and only if USE_USERPTR is set
- Pass the userspace address into the internal create params
- Call virtio_gpu_userptr_create() for userptr blob requests

Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3d8e4ccdb7..616d248b3d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -36,7 +36,9 @@
 
 #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
 				    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
-				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
+				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
+				    VIRTGPU_BLOB_FLAG_USE_USERPTR | \
+				    VIRTGPU_BLOB_FLAG_USERPTR_RDONLY)
 
 /* Must be called with &virtio_gpu_fpriv.struct_mutex held. */
 static void virtio_gpu_create_context_locked(struct virtio_gpu_device *vgdev,
@@ -458,6 +460,17 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 			return -EINVAL;
 	}
 
+	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_USERPTR) {
+		if (!rc_blob->userptr)
+			return -EINVAL;
+	} else {
+		if (rc_blob->userptr)
+			return -EINVAL;
+
+		if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USERPTR_RDONLY)
+			return -EINVAL;
+	}
+
 	switch (rc_blob->blob_mem) {
 	case VIRTGPU_BLOB_MEM_GUEST:
 		*guest_blob = true;
@@ -495,6 +508,7 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->blob = true;
 	params->blob_flags = rc_blob->blob_flags;
 	params->blob_hints = rc_blob->blob_hints;
+	params->userptr = rc_blob->userptr;
 
 	if (vgdev->has_blob_alignment &&
 	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
@@ -538,8 +552,10 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 				      vfpriv->ctx_id, NULL, NULL);
 	}
 
-	if (guest_blob)
+	if (guest_blob && !params.userptr)
 		ret = virtio_gpu_object_create(vgdev, &params, &bo, NULL);
+	else if (guest_blob && params.userptr)
+		ret = virtio_gpu_userptr_create(vgdev, file, &params, &bo);
 	else if (!guest_blob && host3d_blob)
 		ret = virtio_gpu_vram_create(vgdev, &params, &bo);
 	else
-- 
2.34.1

