Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013020.outbound.protection.outlook.com [40.93.196.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6B434E21
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725607; cv=fail; b=hAMqPu7qvn8gXj/lAcsEhv8zEHC3IphZQPjmqTqRnQknGQ8Xg3uI8uIKRgcfuQEtrTXU/Yg2gVF5f4M2P6NcaoFk/d4FxFcHTOECjJz74vZo2BnMiQ3Kd/1ZNmw8gscTR9kPw8oZu1gKlrbNO2dKcWN7Pto09sARCpnhuIFnTHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725607; c=relaxed/simple;
	bh=f3SbiqoEHJgeSC0XXd5nxTkjV9bdxNva9bI8ZJAv/yg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HrRucDzV/YlXQ+6+96T9wr9UkNOZxvSLJb8rBCTU6PG3/4SNEplUt9V2eCjTTc5FWHyxj4uUln5SDgK839yKyNEvJYed9RJOe9iDlgMVE5cpF4YjKdtpdfDHMa7e6XGb718j8nRg8ukEmQKaRuB4BLgKQDM278RJpDWrYidocI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JRfnYp6T; arc=fail smtp.client-ip=40.93.196.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JRfnYp6T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whg8lTHQMuFwjifXo3yDeZwEa3jADcYXonAgxTP3RSTwRI9LTX5TFcJfkRWj19UAuhkNAS+WuCJ1KIOKkX2sPFg66+97tMPRw2YbxMHU0BMtNzbxMOUvRn6W8bqZ4Im/7W/sOg3QZrWN+XyFaXh9psOc1NUGp+bixuf+CgitPCDSoR48L9zoObYpyQp6mptaCMWKgwzaXjgGZnSDM8X+KJ+yVZFp+Ih/yRykdHKfnN9U70+OnaE3MvxSiUJIHft7DHp0ZbRhZwQbcsuUkvzf9Hzihj5Ez3Tj1/E2bcw0IoGpwT91cmvLdK3EH4tBcLhY/MuIFVCAvc8jQb3wy9VhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x41LyXrH4JYVgFWP+2IYuK3KFfLdptTo58+8pef3ieE=;
 b=IaDhPvVslKevLqU/zIrXHpPPsyHe1uRFF89Z/n37sOama4MPd/egNVBuPE4XdZuaHDuyg/t0Dti/tydOz+dYmlgW4KFZNrF8YrUD5QObwOEQevMPfzZrNgK3Gi/J96zXxzGDNsD3lDyS/FUZmBlZIzwhI1FFU1NAv/YIv4OxtKNE8zOw4g6rSBfnAawJk9TopZvUJ7GTsyq/ZBG14PsGhS+/O2s9C5qFseBETUe5r7HvdilD/a9EhL5+xwXn2h8bNzTfZEKLDh4EriwFqV35uw8JYjgZ2pyWtjy4WRIImxxjaA/XAFlEjJIekvf1BsR9LbiDmG/UjyHofC6b59dzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x41LyXrH4JYVgFWP+2IYuK3KFfLdptTo58+8pef3ieE=;
 b=JRfnYp6TN04x0vn7TtA2d+NGNlIGEnDIGH5bHFqvPzzEB/uFYGpyWS7yiED7Xf2b9bfJ0WW8QbOwTn281D573tNSlFBlg1i2l6u1hSslG+nweHFW5YJGlcMMtuQagXLtnuYvNFRrwimOO/uUc6y9Pj+o1Kj6iGLtqObUddQjoow=
Received: from BY3PR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:39b::21)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 09:59:54 +0000
Received: from SJ1PEPF000037A6.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::52) by BY3PR05CA0046.outlook.office365.com
 (2603:10b6:a03:39b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.9 via Frontend Transport; Fri, 18
 Sep 2026 09:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A6.mail.protection.outlook.com (10.167.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 09:59:54 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 04:59:51 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 0/4] virtio-gpu: Add userptr support for compute workloads
Date: Fri, 18 Sep 2026 17:59:36 +0800
Message-ID: <20260918095940.2253018-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A6:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: c436533b-4efb-43fb-9c1e-08df156b96cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|13003099007|56012099006|6133799003|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	CuRMxgqRuoZ37/zX5/L5TPqEfGOwvZ0TheOmUNxF/tNbH2r20xRCcmjwRiy1meaLEBRnANeMe86VHbcfoWktukHUScxEy8EzgAwRcrPlT9FdAIOHoNPNFQxmLk9YQjuei++DM3xttrEBrq4XX773SF5ELqxNxrbSW7dY5qDnmqMlKw9ss9uVNGJlYaMWpOkZMtlyqHdsl1xaWTcK9Vyod9fl3oyvjfSrQmqV+Fu4iSZQY/Omc/uYwM+iOXtCz5CffCi/26FKBd9fV0MwDsa122qWc/ehaVXdbyO9d3bu32umsGcQdRpWpLLSiutTansdj1+JKwU3zpIcR2Hu4PKxw7ugdipOergpF5LufIN3nc+ANVCJ+DpJ/bokDiLqn8YUEH1TfX7X+B83LOZh0vSnpIV/hzvgEsSuNZFyM7NTCVw9hQUzb+M77iO4kuaHWWNuhaIvagzWo6te49HIV7gc9YCai+HqD3xqF8Zi0YL0lYSSAjXI2CtTw5V8f0TWxlZeWkohUEjdzCHbMH14QEcGIMH5IEiZu3L0SrxGonmuvTzZv9+ZQHEbw3xjldsBxUL1bqLAQdBSauBtRGOGRUgoKdDBXuGn305uTirPn3Fr/SeGDJUR9m0KmjaFvAm6APtDiTmFkIv7fbB1nONeuNvDEQhjB66Zkq5wbmIjTeZL4qa5C4zZTVTxSG90ovxS3qkHiG2F4b9Uz5g1VRDKdgF5AQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(13003099007)(56012099006)(6133799003)(11063799006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1LMQrfD3OekP5kOCUA7ViU+7/12z9CO0vEFz34YoPB5HTGIFJmplHezPz0ApxpwADiYO5Gu1pq36klaq3TM5Dt501Db8v6eClvgXJs7zxuNfs+/XE7xy9c5I5xumHs00ja/k4J9+i9LMWNfu7yjUcSp0Sg+s5uu+zSPnKmqjYVnho8cX6Ui+IRRkHAEts9poqenO9fB84HPkj/zqI5A8cxSJbC9dFPnGGuIhSn+QuBiOXfKCwpYKTsntaopzMQyL/xNTZV2Mqvuv6vh1v4xUyyELrHUJbKvdaG9cl0ztIeuycbmB/2fI2VUNojhjJbYFtdAiWEFsWfFedn4JFdMxFHkkIIpmVHTHRAXdZJ1M/b0F5dvKZ4e6npeuZ7YAOvmvk9crQEGtU3f7e5NKC/4KWIQsqIdPs7URQ7OpqbzeopuT78aFHkEO/pCi23vvYsEy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:59:54.4492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c436533b-4efb-43fb-9c1e-08df156b96cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033

Hello,

This series adds virtio-gpu userptr support for ROCm native compute
contexts. The guest kernel pins an existing userspace mapping with
FOLL_LONGTERM and exposes it to the host as ordinary CREATE_BLOB
backing entries, avoiding a second shmem allocation and memcpy.

A non-zero userptr field selects that path. Probe
VIRTGPU_PARAM_USERPTR before using the field so an older guest kernel
rejects the request instead of silently creating a shmem blob.

GPU-readonly backing is requested with the virtio CREATE_BLOB wire
flag VIRTIO_GPU_BLOB_FLAG_USE_READONLY (also
VIRTGPU_BLOB_FLAG_USE_READONLY). The device MUST NOT write such a
resource. The guest accepts that flag and pins without FOLL_WRITE
only when the device advertised VIRTIO_GPU_F_BLOB_READONLY
(VIRTGPU_PARAM_BLOB_READONLY). Otherwise CREATE_BLOB fails, matching
the CROSS_DEVICE host-capability check.

Patches overview:
1. Add VIRTIO_GPU_CAPSET_ROCM capability for compute workloads
2. Extend DRM/virtio UAPI with userptr, PARAM_USERPTR,
   USE_READONLY, and F_BLOB_READONLY
3. Implement core userptr functionality with page management
4. Wire blob ioctl creation to userptr objects and probe the
   readonly feature

Tests:
- Full OPENCL CTS tests passed on ROCm 5.7.0 in V2000 platform.
- Near 70% percentage of OPENCL CTS tests passed on ROCm 7.0 W7900 platform.
- most HIP catch tests passed on ROCm 7.0 W7900 platform.
- Some AI applications enabled on ROCm 7.0 W7900 platform.
- latest ROCm 7.14 and ROCm 10 testing is ongoing.

V8 changes:
- Drop guest-only USERPTR ioctl flags; a non-zero userptr field
  selects the path
- Add VIRTGPU_PARAM_USERPTR so older kernels do not silently
  ignore the new field
- Request GPU-readonly backing with virtio wire flag USE_READONLY
- Accept USE_READONLY and omit FOLL_WRITE only if the host
  advertised VIRTIO_GPU_F_BLOB_READONLY
- Restore userptr blobs after hibernation without the shmem path

V7 changes:
- Mask guest-only DRM flags out of CREATE_BLOB wire blob_flags
- Clear userptr->pages after pin failure to avoid double-free
- DMA-map userptr SG only when virtio_gpu_use_dma_api() is required
- Use DMA_TO_DEVICE for readonly blobs
- Sync userptr SG for the device on TRANSFER_TO_HOST
- Mark writable pages dirty when unpinning
- Reject USERPTR unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
- Disallow PRIME export of userptr objects
- Note that CAPSET_ROCM uses ID 8 because ID 7 is taken by VIRCL

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
https://lore.kernel.org/dri-devel/20260917102540.1312102-1-honghuan@amd.com/

Honglei Huang (4):
  drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
  drm/virtgpu api: add blob userptr resource
  drm/virtio: implement userptr support for zero-copy memory access
  drm/virtio: wire blob ioctl creation to userptr objects

 drivers/gpu/drm/virtio/Makefile          |   3 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |   1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  43 +++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |  35 ++-
 drivers/gpu/drm/virtio/virtgpu_kms.c     |   8 +-
 drivers/gpu/drm/virtio/virtgpu_object.c  |  22 ++
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 365 +++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c      |  33 +-
 include/uapi/drm/virtgpu_drm.h           |  13 +
 include/uapi/linux/virtio_gpu.h          |   7 +
 10 files changed, 513 insertions(+), 17 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c


base-commit: 766bfba0f3bae329f99b42dcabc3ef11fa368f0b
-- 
2.34.1
