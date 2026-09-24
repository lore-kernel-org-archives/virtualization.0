Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53C5457E54
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243790; cv=fail; b=EOXsnYh9eBm7wuMN0n1rhhr2aCIm47hBc/AZSjlEajExfWFFhm3MlETKOOYW86hG86fNyblz3hFNarb0sgIHOEql1VGDOugDhG7dr/ZdHeCxsRIC+lQJZ5Z6xHkLRxVs6EgLQ64zk/KsA9TpB/FFZjW8oHzsqFuhy/tqTANatiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243790; c=relaxed/simple;
	bh=tdjebjSJPg2uziQr8emush2sTXIQnu1nTag/LmXhz08=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ahd0xc5VvsJUIWQgUR0rW/PkqPv79rMEe1bC5nbmmwj2uJeJQ6dBaC/Oo+k18ALiWppqZ/uaWh5/snzpIPapK776uwlEIipDlGjiLgDxzMRcQuMdAYWavIdei+sEAvNWd+UpnLNSTMjOARKggP2JdbdDjCR/ZBUWeZ9E8qWzsss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rggyoZiV; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rggyoZiV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrZx2V6mP7gbv4dVV7Em826Uj5B0fX2sDhH0Bi7Uxo6AuCr294e8RtPw0JWNff4YN2XnR/shH0xCb7Hp+C5TKbiHrED9VFm0ZQfGE5wwU/ME5X+0rto3UH4FEHmv4Wr3udVGNqKCrv0mVBkNjFFLQhFw7K3KojLScL792QcvIwRej+0BOIMr4mWzoAHNENIJSGGPF8O+vcDR+39zQi6aYEsK2hdqzPkWpbW+V+8hz/xfBgVRFtsXLe19/EdVJ+B3WuUujX391R6DJ7wlcq3v6WRV7KDa+bFx5XpGPEdl8GZdYKbidXISSCrkJQTcVE2QR72ZyzPbIRCdJR9sVJeHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QLGUCocSjRUWMwNOQSk9YO2R+5r4WxYdTam/I695CA=;
 b=ZJqWmJFc55H2VeC+HtxzJ2pXmTNiedeF/zseqhnCmBvUbjSHygiYUIoNQ0RkFJ7ReYvgI2TkyKoO9RSxUUh5N6Rs1xJaLApWe0s+eqqHB9PR1pdIAul9HC/RKCX8DVH+0sOWg781HBKZ0o70yPaYBIM7IfzDtEGX1t6xfuxP4iaFm/9oEKqH27t1nPAN+00y8IKQd1yZxbSI2zPRY0rIJohVEFezYxx6LFR8/GnW6zd3Zhrh1Q1jURSbRz9ykZkmP6rRckYHw1y0sngy1OEo+Fq99M5LHOiyAzkpt9NuJHFugSmyergAtyaSQQnm2+wJSJD/kvgVlWUhpJDnsfuNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QLGUCocSjRUWMwNOQSk9YO2R+5r4WxYdTam/I695CA=;
 b=rggyoZiVX2R+zP1W9SjMBDAokNeYtm/BZwKME5NYX3GXjgh2iVZOj3/ofBV87YNTCs11jveCt3QSjth1D5cRlR/pkPaJ9BTQ34toa3Zw51lCogDk2OiMlAwp4UW99P0PTUe5aJ1J+15zkRey7beFMVJ1mx4y/XUB2j7YFM4oX9M=
Received: from CH0P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::30)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 09:56:12 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::1a) by CH0P223CA0013.outlook.office365.com
 (2603:10b6:610:116::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 09:56:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 09:56:11 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 04:56:08 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dmitry.osipenko@collabora.com>, <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	<airlied@redhat.com>, <kraxel@redhat.com>
CC: <gurchetansingh@chromium.org>, <olvaffe@gmail.com>, <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [RFC PATCH v9 0/4] virtio-gpu: Add userptr support for compute workloads
Date: Thu, 24 Sep 2026 17:55:52 +0800
Message-ID: <20260924095556.1326164-1-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbdb4ed-67b7-4acc-4588-08df1a221082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	qczp8pmBirIHQoNeu7PpcvueJDMTy7g+gVs4XgDF4vj7NabZ+fYZuSUf5zPtn+ndUlvcG1lujBWWs61D40xBwqTxnwplig/Pupyxu1FW+RFfcVFUk8WExjCMhzwD+Ybxbz5+W7V4HJbKangRNC4o0OcTrkC3fZd7b9a16NSLIhG7rTKApn/anM/ri7ANH1WBEGccCxAb3LeGuKO6pU379YdlpyeV9a8HcFdLbEm5nZFieKfxpEtMsDoQUSe/2OKt2MT8LdFAR38rv1+/6BQMLTPCOxCa5iWFYAZym0K5maPxSWMddEdUXGEHmpK2+pmiNY+sEdPt3UV5anqAjwj8EmpZFwqO+E396jShpNXBXafeD8NLjrZjo1fiKvsohgGWqTooOXlOG2j65fYab2Aryu+/f21xPt7GdEHSfsZgWVXOTLqKoa2GITnF/ON7fd/RLmyXlnLAFazGCMEc2BN/ELpV9hTcoNUZS4MPKDF9V4Tykqanu8Qhs1XLBbGrBSzmGGoi50YQpxQ6uNKAmtBYVt6qFhM2fndt1y29NDiN/V2I9X0TCMRRCppG1Gd+PtGaYjCi6JuFHogDNyHLB4LnJvHfJfQn9YkxH9hZCv/2fgt8a9gCXFO36d5oO94wvttgupQuVQZwkGuB2/btfMr6J3dNTBp1JXDhO9gvcEZBuXJdLDVWKpH79nrGjyM2x0A9YfuKc6Olt0vl6oprsg0jKA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ei9GDqx9d3SOAbJ1Hf9eBA9pLV6qnWVUWD4X1lG5Vjc2c1ysRhL2NXYLb0RQEUo10IAsVRXFmKHwtLduIXgY37+T/gwRNXOIIG0MWB9RtuZ8TOqwOCjPZZ8GV8aeHreWxPlZZ5H3zVG8IUcWjAzggTkqtiHc+QX6XUq5e9lWENF3Qaiu4XuE0RXp3WKwKbtJImDmKNBIfzHHxLKMm0bFoZrhH6yXOWjYZPmopqW/Mf5Jh3RZjurqRPMnD8A5nrEsqdvhP5zUbQ1nExns1FXBwzXWddvEoWX5bte3XmF9pwM8CmQIgpOXgOGdjilrpTJQlm+UM9rjAlN6eznmAyN9SOZ93de5zAND0dzeMwbgFY5949CpSMZENIBmYqlktk4BCQelvTUti8S68Op0uc5Eza0//lofOIdIR88YVwVpMnnVnUBOKGjtvVbEx8faYbjj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:56:11.7530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbdb4ed-67b7-4acc-4588-08df1a221082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478

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

V9 changes:
- Marked series RFC pending a virtio-gpu spec update for
  F_BLOB_READONLY / BLOB_FLAG_USE_READONLY (Odaki)
- Moved VIRTIO_GPU_CAPSET_ROCM/VIRTGPU_DRM_CAPSET_ROCM from ID 8 to
  10 to avoid the gfxstream/rutabaga_gfx 7-9 collision (Odaki)
- Added the missing VIRTGPU_DRM_CAPSET_ROCM alias (Odaki, sashiko-bot)
- Dropped the kernel/guest-internal wire-flag comment from the UAPI
  header and reworded "Guest VA" to "address" in the userptr field
  comment (Odaki)
- Fixed a BUG() on every virtio-gpu probe: VIRTIO_GPU_F_BLOB_READONLY
  was queried with virtio_has_feature() but never added to the
  driver's features[] array (Odaki)
- Removed the dead TRANSFER_TO_HOST userptr DMA-sync branches added
  to virtgpu_vq.c; verify_blob() already rejects VIRTGPU_BLOB_MEM_GUEST
  for that ioctl, so the branches were unreachable (Odaki)
- Documented the DMA mapping and bounce buffer behavior of
  virtio_gpu_userptr_restore() and dropped the zero-copy claim from
  the commit title and message (Odaki)

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
https://lore.kernel.org/lkml/20260918095940.2253018-2-honghuan@amd.com/

Honglei Huang (4):
  drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
  drm/virtgpu api: add blob userptr resource
  drm/virtio: implement userptr resource support
  drm/virtio: wire blob ioctl creation to userptr objects

 drivers/gpu/drm/virtio/Makefile          |   3 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |   1 +
 drivers/gpu/drm/virtio/virtgpu_drv.c     |   1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  41 ++++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |  35 +++-
 drivers/gpu/drm/virtio/virtgpu_kms.c     |   8 +-
 drivers/gpu/drm/virtio/virtgpu_object.c  |  22 ++
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 348 +++++++++++++++++++++++++++++++
 include/uapi/drm/virtgpu_drm.h           |  11 +
 include/uapi/linux/virtio_gpu.h          |   6 +
 10 files changed, 468 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c


base-commit: 766bfba0f3bae329f99b42dcabc3ef11fa368f0b
-- 
2.34.1

