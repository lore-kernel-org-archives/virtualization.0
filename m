Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E414AA572
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640863; cv=fail; b=QhTVBEYZgxbNxdKfvuG3Ryrzi8duCtmZ9h0xVIR070ECjGD84tdZ+fXiEoT/9RYSj5fZidx2tdjeb2HthCHMbRKoUMAmI//cOyk7qSvSpTP0tNCikZ2OyidjlYrqUBPcCeTrW+XEWOZAkgZkWi1BfEmMotciPuuL2SgQ/+6bJvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640863; c=relaxed/simple;
	bh=+z1Ork8smMvMLmlJlziUSFXqbZsuZRid1NSmHvxEujQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ger9/GiEMcHU/Lpognlo+A14I+5QRZDoeFgmjD+lTSC527sZWmb9cSr3hzCX7JcgXDjeTmJOlzCIdHD0fNAURs1rskLcfLaN4lmtAwAOE7wI8w5ZXvZtT4S1n5fgpLU/xIbpwsThn0azmtA4UqeKKPUpGA7cPlB4w6Y01JBhfjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=obtQ6Px5; arc=fail smtp.client-ip=52.101.56.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="obtQ6Px5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBPwtYgOEOnGVAdPFjReP6+Hse6XjfUNhI+k8tV2GsjBozEw/adolsRWAzo5+cJBxpXjG+BmmUxWDET/5NxoqXbT8VB9vqyizsy9w5bNXTcR/sNVlmq0bF30HjEU9FBGPWeHjD2jrkO2UOk/A+gSXC4MS41kLE1nic85yRwsnXy3aw3GJCCh+31D9wNNkgEL1W247FqSlBuii4mL0kH37gvFyHqO1qVmkjCyujw/Y7OMD4/AIsjDy5HR+Eew6zNCDnwcPSqi2KTgOVSTo+UyfxS9FvaO8c+ApfdDLR4wmfPoT8J1sffzEaNqsCqMMpKRLkdtZoI9h7s7QSwrAkRazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa/ptpJj0dV9Gk17chya58SmSPuZhC9/1udIjAXpi0s=;
 b=nD6UDe/QwYG/M7WZi66yj87ofPbriAHXOd5ZnXCwZvyEYTgtXXFA9pEn3uneKWRLGf/z+0onkn7dh/WYUijGBJDiNZ+rAb8JOcrKaen902AnLj7un3/VhE7o5+y1TmQtj/PakwfGd8pkSvkHXRIZg383R0/l2yh9mIPeltpdg5bt9pOT2VUQFJ/GUkDAB1ZviPE8KLR+kBalI+mMPVW1do5oiuEg4YqEeKFwbYgnLzvv9tueMiavmmk/pqf5swaL2FbUmJDleJIvgVlCWdm0a290j2opUBIUUY405NOMg0DQCSsTAyD5fOZsurJbLSKl0TSJ+4VLYo+PzYTtxZ6OqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa/ptpJj0dV9Gk17chya58SmSPuZhC9/1udIjAXpi0s=;
 b=obtQ6Px5+yASAD4a7rhrw8yyKiId5TCxQYYKK5OU4nRhAUvE+PI8tQbB433fjSvMpG4PJo72wAJM9O38Z/2vSMAdysDiP06qIs4PCxJlMVpIKE01gmlELx22pw73mkEmVh4TjKhHEl2zrsvZB7MvpiXjOvbqKqNi8mdax00Ja28=
Received: from CP5P284CA0237.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:22e::11)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 10:25:57 +0000
Received: from BN7PEPF000000AA.namprd05.prod.outlook.com
 (2603:10d6:103:22e:cafe::a9) by CP5P284CA0237.outlook.office365.com
 (2603:10d6:103:22e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 10:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000AA.mail.protection.outlook.com (10.167.245.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 10:25:55 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 05:25:51 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/4] virtio-gpu: Add userptr support for compute workloads
Date: Thu, 17 Sep 2026 18:25:36 +0800
Message-ID: <20260917102540.1312102-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AA:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3269f7-d609-4caa-7a43-08df14a60e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	JokLLuK9sBqgfjufI+Q8c9oxwYjyGzmyiYrYF/fyx3T+7mywKT31G83HP/CGd9cARMEfJTnnSRjLzjQrfj3N74ovSNJ1A7ekwUjJQNqm07mRH39Sqq+9Ho82Us7cECNOhjS/g1DRZIzWsFey+e9ArtVTSD7ocx4ckWP1bSR4xKv8DZV241O6NNME0jrdZEpSE2TvRCeSIWLjoTmI2/3tpvo6dPIRPpQYPRsaK4dPz8gSm4fqR/zYGSpRdiY3YXPzd+BQxHZrPg/HV7Fj3R17HBCb1DQ4Uh5CJWsm88I6L/+EGtxfSHOhhlXbgiXY0M8gyXD1uIhuZmXMmrFog4bmFyU/166MUIG1mFI1KrsyzPXbfY7bNokcoTp+ArE3AdljlavTEkslWAyTYNM0l6Soz0sQ2yTwqcoB72CGvFFiDwcrIidOiUE5iy0Eqirz8jO8U7e9gnQffAGvl6xyw3mNdowLhU5yalGFfGCNA++Vx6LVVQgTIf2/IF9kUPsprwCCHtjd9SxS7ifek3eV9YtOnrm0+jOWn57rOXeQ5iqOURMcpIDbXRytAHH+tZz5oE76hlYBKPCPjjLNvAUWcVk7DV0fFECxSGU4ysTMxMeKUsX/T2JbvzWcMyLxOqtSh9LmQuROJDNjGqJDDlVcVzARHlwgVyiElWrF4/bewPis2Y9ejcIacgNO8x9T/4kCkQfr2G2vKO1kCSTVyk+CjmVjUA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8XwqgpOPeJX8PqsY67RTGJ0F5edLHJI3nwoTTO7U1E7qECts+a1KFEoEiyIZ5Rrc+meGCMqq/Bza47gGQdHVDEiQbvcZyiXjame8cFZ8H8bQ9IFFYvcxewtRL+kzP9cOVohGl/IVGsQN8XmrO8fUK5jWGfcZbBxs7rdDizv2/EOAEwu5NyCr+vrtY1+Lg7x8O86YOhe+UuRF07iVkaKgg2h/XeDRUfcmiXK+9Rjn4Od0XFQf8hbhw4rjzLoVWVB15bHd8sKkdvakjGdBtRrg8e0OqYwqaeqqGZZK61mfGkcrBEDvjw/yT81754bO0NMUIP9p5x1Xl91DnlXN3si9vSPhoXGBNuu5nZFK2/b3qkrVFGNNzLb351jvlRR0KbK7UXNNqjC0uTJ6qqh6wsA6fKzFASj1h/uhQcJAmjGRwx6m/W+njYldHuf2J/187nxT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:25:55.1148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3269f7-d609-4caa-7a43-08df14a60e93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000AA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658

Hello,

This series adds virtio-gpu userptr support for ROCm native compute
contexts. The guest kernel pins an existing userspace mapping with
FOLL_LONGTERM and exposes it to the host as ordinary CREATE_BLOB
backing entries, avoiding a second shmem allocation and memcpy.

USE_USERPTR and USERPTR_RDONLY are guest-only DRM ioctl selectors.
They are not added to virtio_gpu.h; the device does not need a new
wire flag.

Patches overview:
1. Add VIRTIO_GPU_CAPSET_ROCM capability for compute workloads
2. Extend DRM UAPI with guest-only userptr flags and userptr field
3. Implement core userptr functionality with page management
4. Wire blob ioctl creation to userptr objects

Tests:
- Full OPENCL CTS tests passed on ROCm 5.7.0 in V2000 platform.
- Near 70% percentage of OPENCL CTS tests passed on ROCm 7.0 W7900 platform.
- most HIP catch tests passed on ROCm 7.0 W7900 platform.
- Some AI applications enabled on ROCm 7.0 W7900 platform.
- latest ROCm 7.14 and ROCm 10 testing is ongoing.

V6 changes:
- Rebase onto drm-misc-next
- Keep USE_USERPTR / USERPTR_RDONLY as guest-only DRM flags; drop the
  virtio wire-header patch (5 patches down to 4)
- Fix userptr lifetime, DMA mapping, memlock accounting, alignment
  checks, and PRIME SG export
- Updated corresponding cover letter and commit messages

V5 changes:
    - Add VIRTIO_GPU_BLOB_FLAG_USERPTR_RDONLY definition to patch 2
    - Dropped unused VIRTIO_GPU_F_RESOURCE_USERPTR feature bit in patch 2
    - Included VIRTIO_GPU_BLOB_FLAG_USERPTR_RDONLY in VIRTGPU_BLOB_FLAG_USE_MASK in patch 5
    - Add check for userptr feature in patch 5 before creating userptr blob resource
    - Updated corresponding cover letter and commit messages

V4 changes:
    - Renamed VIRTIO_GPU_CAPSET_HSAKMT to VIRTIO_GPU_CAPSET_ROCM
    - Remove userptr feature probing cause it can reuse the guest
      blob resource code path, reduce patch count from 6 to 5
    - Updated corresponding commit messages
    - Consolidated userptr feature detection in final patch
    - Update corresponding cover letter content

V3 changes:
    - Split into focused patches for easier review
    - Removed complex interval tree userptr management
    - Simplified resource creation without deduplication
    - Added VIRTGPU_PARAM_RESOURCE_USERPTR for feature detection
    - Improved UAPI documentation and error handling
    - Enhanced code quality with proper cleanup paths
    - Removed MMU notifier dependencies for simplicity
    - Fixed resource lifecycle management issues

V2: - Split add HSAKMT context and blob userptr resource to two patches.
    - Remove MMU notifier related patches, cause use not moveable user space
      memory with MMU notifier is not a good idea.
    - Remove HSAKMT context check when create context, let all the context
      support the userptr feature.
    - Remove MMU notifier related content in cover letter.
    - Add more comments  for patch 6 in cover letter.

Previous version:
https://lore.kernel.org/dri-devel/20260116083808.325180-1-honglei1.huang@amd.com/

Honglei Huang (4):
  drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
  drm/virtgpu api: add blob userptr resource
  drm/virtio: implement userptr support for zero-copy memory access
  drm/virtio: wire blob ioctl creation to userptr objects

 drivers/gpu/drm/virtio/Makefile          |   3 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  36 +++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |  20 +-
 drivers/gpu/drm/virtio/virtgpu_object.c  |  10 +
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 323 +++++++++++++++++++++++
 include/uapi/drm/virtgpu_drm.h           |  10 +
 include/uapi/linux/virtio_gpu.h          |   1 +
 7 files changed, 400 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c

base-commit: 766bfba0f3bae329f99b42dcabc3ef11fa368f0b
-- 
2.34.1
