Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793953615;
	b=D0qdRj2Uo1Z8cTiIVm3zwncKZ2iY5CvHDGi4parkTcbnK8l2etTPimbe6W0B1h8rzLnX
	 ZubxwjoTr7SiWXUUFexw/7fzE/9cO1y32BLueZirL145J8+grtK24Z2FIS5xR/VVlxcAZ
	 R8tK1jfkUfNswD/8UhGa06rCp4ns41dVfQvXWTeR18/kMykbPnKW4vwtqQ2Lil/mIylGG
	 5Mj3KH+enDtuYj0w23ye8JtLe7BK27z8wUUZ83IhrAZRM11ra/rg+FUtqlWRq2DrBYrpX
	 Anyhgq6TyevG7MUkrnfWoSLU9QPJrV/8i322LU9i1RifIi0gYTbxuds6zH9MwXB7Xig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953615;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+g3CgOQBQja35SrCUO5OXATSxdIzw2YKVSKOVYj99pY=;
	b=YBY8Fq293JKErE9JxbICPE7L68mTl0yyAeQ1xLxoWKk8b7xCG8YAtop53/4hVyjHiTVe
	 YEL/Nj5duVvBhYbNARoVLuE/wzeGfU3SawcyVFcc+D0X1YyMg0ITTYXaYmfQUXf7OP/Gx
	 PsjXWVYjZ2NpkcIS3Esjpls/ctiN5j35TOOpXbwmCYCFYSoqUy+3NIhqEsYSz/clfdbMu
	 iMfuGjsjLOksI+IbJGRAZ8mlc7PgYTKWBx7ze+rIdPSLUaBFSmbi1oW/QRoGzAEScgwfg
	 D64DeNyJ9dwZMRG7dG0d9OwkDV21adI+gwzTTFzOnCap24EIZuOIzzzef7GuIq7KlzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TFp3y9MS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.36
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564D6606A336
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 564D6606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TFp3y9MS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRy0/w4YIQjxuKODz3sxLMdoDyLKsnWjHbg/lmea1NTO1sUNJkpRSHLkrYCZMSPKShZRjSzPdpeOraf2kpF44N6Ubw6DIamnDlCYfalmJCx80Dc7iUEaYCNiw/8a9vJR4oeqqiSAhYqNhpMGGhZac+YVZ3t8zOIHiIj9pal0nMbvh+N46Wg2ZxwjknKIcpm/cHmAQ622jT5u4Q7I3cz17H0qEKy4pee0uIJ0OtOVU5QacXgHBw5UCU1dupI5BJF2tAMNX0nS12An494StqD8e1Nn3j3q9a70e4YAWPQRqVDRQaO3oNxZFeHB0vEWm88dD1OXbu6BfFYnWYueOYMy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+g3CgOQBQja35SrCUO5OXATSxdIzw2YKVSKOVYj99pY=;
 b=qC8QvE/Q5vpbLIDeuVgP30067WVfiXsMf2R5o7AGtr2GXFo9LmWL3qNKPU3BnQYMXyngh0eyx5FOHEHt3d4hTUV9pJi97biKRP2o0afC2TE55P+ZITRQbIb/JQy3rGfIoas4i9yRJgNWOTWxXaOUOFxmDv7vXGljbPD2CqiRf/VxGdvuZD15biyqrgpRPauZHSjqIUeX7HgYu2npqW8FUaCG4Q0KxdiGEklYNhTHS2+yqWXqBZz/p3Vg64mR0uzEU/8h/VSZZTTEAvH+Y4/qL8Mn5wc1ZG2rNg20AnEDaOKomEphLL3vT7ibqMp95a+F2JNN5PDW3hbNoZeeV3iSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+g3CgOQBQja35SrCUO5OXATSxdIzw2YKVSKOVYj99pY=;
 b=TFp3y9MSe1JiWLpx8MRSaJrKGv+AFN2euaVQrooB8D9yZPMtBjTGUKSuGLeQ72ZjpIiz08Pv5JnH+ThOX61i6G1FS4RG1z2Lw4PZ+MAcL2GFEKJQfOStYin7QhGrCL3u/9nzQrHSp2vnTewCJCtHziurXXYsktOgbFn+m1sU9ns=
Received: from MW4PR04CA0319.namprd04.prod.outlook.com (2603:10b6:303:82::24)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 08:26:51 +0000
Received: from CO1PEPF0001885D.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::16) by MW4PR04CA0319.outlook.office365.com
 (2603:10b6:303:82::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 08:26:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885D.mail.protection.outlook.com (10.167.249.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:26:50 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:26:38 -0600
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [RFC PATCH v10 0/4] drm/virtio: userptr blobs for native-context compute
Date: Fri, 6 Nov 2026 16:26:21 +0800
Message-ID: <20261106082625.812860-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885D:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 99eb9952-f165-43d9-fb06-08df3bdfb492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261021121427099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261102130727099003|261102123227099003|261026135527099003|261026121527099003|261026140227099003|261026130827099003|261028144727099003|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	+a//8waCvtQdZ1o5mJiJKDm29r53LVlI6XdSD7DHPEDR5GqUgmMgiM+3o+jOfdcf2B73m0hJGQg6B/xABqHlZ19AgrdxI1lUIICFhNgsvtfbSD72pBDC6lV9jPltrSJ1RpCENOa18AlUoh0MikRwfs6otQ8qsAxpZ8UzYhvQoA3hLkAZKOlfWbdLZULLEK0zmom+hh1OBDIuT9pR6iK0thndoacEfHwoF0laG4Hj2hnUPtc0rigOVW3981cpOiyZMptDibdwu8Z7kDGm6hAsRrbhZLiS5guf4CHfiZkY2PxG+gVsED3yu8XmtSERz8taRK+Vwk/7Ik8I1m0ma0HMsZk7/oNvTHXMug7+Gj9TIqIl4UF9n702nLEhZvIJCFKkmEMPeDIkh/M7pMYmuzK3Pj9miBOzhm5SXj2tDoQeCwQPDVtHQ6VrhoYNr3lmkIC/V19vSjYKUo43cPIotSgun1oJ1WWH/AKbaXEzKpNAuMCVSb1ebKwaaX2T46yw5cwiUWTg6Zu5n09x3c/HCqpIXsaDzAHE7AYkSBNT8zEASfNl9V9rUkdo1uG/fmwIZxdX0LMth6Y3Pegd1F68fPB+AMLnFdqsJbJ+NgsPARiGyGrgFekM1AiprQ+FRue2LX53mVQSBU0Ez7mok5sUK3ZuCQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021121427099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261102130727099003)(261102123227099003)(261026135527099003)(261026121527099003)(261026140227099003)(261026130827099003)(261028144727099003)(10067099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sgi4Jf/T7RexU7+PdqMX1yUaltmSad+sQhtZtHPOVM6L4TtsDnLhfjYDXyjY3yrcPWzzsGS+QYFqzXMC1mWruORkCNUJOJ+Oorf+1+qMGTyvwCG5nbq/NHfMJI5KRTUZUAQ2nDgXwv/xxGjmfQbCloX4lzONkIsYXVt6PXcGUk5G0MZS30B7xW/alxG2/gj3FbluiwjpSZabLBm3PBV5D0oXTEAhMwr9kUHKRNURz0h8e4RxkoN1Dk89WHKZnbZ0Nsuij8wUWY2W88Xp2I/h/eKeTZuvma3cfYFqdowm2qRz/qb+ktdvrKCSOIbvFqUcd7GoGStHijYr40K7hfauN3e15Fd6djOOHYslNnk4KXP80tSj2d8y+ZUmg2sGPevfhzwXlsiJtT1Xkmc6AD0Pcog+VsdQFxIPXCKYDJ4A+KydKKAqoMBl+HJAvU5PKn28
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:26:50.2351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99eb9952-f165-43d9-fb06-08df3bdfb492
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186

This series adds virtio-gpu userptr support for ROCm native compute
contexts. The guest kernel pins an existing userspace mapping with
FOLL_LONGTERM and exposes it to the host as ordinary CREATE_BLOB
backing entries, avoiding a second shmem allocation and memcpy.

A non-zero userptr field selects that path. Probe
VIRTGPU_PARAM_USERPTR before using the field so an older guest kernel
rejects the request instead of silently creating a shmem blob.

See overall detail in virglrenderer pr [1]

Patches overview:
1. Add VIRTIO_GPU_CAPSET_ROCM capability for compute workloads
2. Extend DRM/virtio UAPI with userptr, PARAM_USERPTR,
   USE_READONLY, and F_BLOB_READONLY
3. Implement core userptr functionality with page management
4. Wire blob ioctl creation to userptr objects and probe the
   readonly feature

V10 changes:
- Require DMA_ATTR_REQUIRE_COHERENT on create and restore mappings.
- Use drm_gem_object_put() after UUID assignment or handle creation
  failure.
- Drop the new_pinned < 0 check.
- Validate the userptr address against the host's blob_alignment in
  verify_blob().

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
    - Included VIRTIO_GPU_BLOB_FLAG_USERPTR_RDONLY in 
      VIRTGPU_BLOB_FLAG_USE_MASK in patch 5
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
    - Removed MMU notifier dependencies for simplicity
    - Fixed resource lifecycle management issues

V2: - Split add HSAKMT context and blob userptr resource to two patches.
    - Remove MMU notifier related patches, cause use not moveable user space
      memory with MMU notifier is not a good idea.
    - Remove HSAKMT context check when create context, let all the context
      support the userptr feature.
    - Remove MMU notifier related content in cover letter.
    - Add more comments  for patch 6 in cover letter.

[1]: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1708

Honglei Huang (4):
  drm/virtio: add VIRTIO_GPU_CAPSET_ROCM capability
  drm/virtio: add userptr blob resource to the UAPI
  drm/virtio: implement userptr resource support
  drm/virtio: wire blob ioctl creation to userptr objects

 drivers/gpu/drm/virtio/Makefile          |   3 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |   1 +
 drivers/gpu/drm/virtio/virtgpu_drv.c     |   1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  42 +++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |  49 +++-
 drivers/gpu/drm/virtio/virtgpu_kms.c     |   8 +-
 drivers/gpu/drm/virtio/virtgpu_object.c  |  22 ++
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 350 +++++++++++++++++++++++
 include/uapi/drm/virtgpu_drm.h           |  11 +
 include/uapi/linux/virtio_gpu.h          |   6 +
 10 files changed, 480 insertions(+), 13 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c


base-commit: 1ecab8b0bad393750c60cc3819ce9c256595463c
-- 
2.34.1

