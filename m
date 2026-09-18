Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F737C0E6
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697547; cv=fail; b=Yx6bmwE732rKXkCNk7b7pah6k+baQMZ+052zWkfInqhX2ENo8F+j32o4GGtby+MERg34JwjtviWicWptUha/vDczVrdahPAwoTxvfW0rWh0W5WlSTiXR+nUtsXianF8nztETE8uMtNfhDbj/IhwwLQcMTdT1Exf4jL9yo6j5Qdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697547; c=relaxed/simple;
	bh=zKYuZVviuqfxLkvbYPyhbzS8bLGfhGs0YuxTkKlYhyk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uSwHGTF+R5Yuw6VERtWdVmTxY5Vb7U4ojcY4qRN9c44mNQQsWFBwxKtkhD8YwtfgZ/nvdh6PIOX8DSCdUxa86bdMPBb+paAWi6go3pggQuF/5sAdhQx3fhngot4wqjow0GLLj/sRgPC2Vm68WhMx9ufDA0zn5F0/5sqykrVWNy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H4RfuTw+; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H4RfuTw+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6sZ4+of7G4unoZ/K33IV7bi7aSSwaVhq9K6cbP9voXEDzwgBAGQqEkDjsJrJJkZcb+ThjJmXo5J9zIxgiUEAhif96cjoqkQVMbwIIcsp842Cs0j0cUhbnuZYhIcuVwlUEgmPLPTMUJX06XJKtw/GxLry1ZzBUXvdAr+y08dB3M1k2Y2lTt+i9gNZr2H9RHnHXxL2udeqtL7hXSXQslqBIsE02wr+9G230+HGvLsOY05J/pd4yBxbWpJWAK82aQPYwqSsQRK+6z2riH+BoILizwzWJgldj7shBqr5yRzWM4IKftw67LLsUZuoXuw0r5qOF0XrMnpZmUowGT+1XiA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=309NCdmcVAvP6vMSC8RCp62xDv5IylP/VmR1t27hoD8=;
 b=nqMcIo64odqAqeTo2B/ng6Q66ciAFg/TDQeRF65gnhBDf7PXidQqi0nrBEXvkplgpCLTimCTpL3nQG76ImHWH+qAfY3UIweeR/gqn2AXLg7QuBzUVk8hNfaDTm6ZwBFxfWqMhBLr3WGzvKs2xQJ0xPmZvMpZAU75ggW4n8SQqkbaPUtKleHdghe1h1JH4Sj2uJf3P4fG14IpWwDwJIHxFjF9H7XmCBA6zuDmn0SuFHs1Ij08WFzTdCqGrDwSGtNoi+WVCnUfETenOhtk8LoN2pxBoaHq82kiEq32zAFbTli4igoygex2LXPBXBCGxEZ/3SDsw35pI+Zxx8MEhtgrfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=309NCdmcVAvP6vMSC8RCp62xDv5IylP/VmR1t27hoD8=;
 b=H4RfuTw+FQ1gP9qYjkfME825NI7zV6LcAILHUAGpwovUdiBR4OyJ7XMv1I2nmBdSTXr2IKcpgjklmdOCNOIJCERkF8p+ejwUnvnPOSn/2vE8hq8AwCvb0umn9lwkaU06A5bNKBoTnBv1KaPdezWzm4L7pK2yghpO5RuqJwRdbJE=
Received: from PH1PEPF0001330A.namprd07.prod.outlook.com (2603:10b6:518:1::19)
 by DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 02:12:14 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH1PEPF0001330A.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 18
 Sep 2026 02:12:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Fri, 18 Sep 2026 02:12:13 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 21:12:10 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v7 0/4] virtio-gpu: Add userptr support for compute workloads
Date: Fri, 18 Sep 2026 10:11:50 +0800
Message-ID: <20260918021154.1432154-1-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c894a9e-bc43-4864-c046-08df152a4172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|13003099007|18002099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HvgSs3qZvurvDA8vxInipskm0xR9Of63yzZPW0cIVOhsXA4UJfJ7hpWxQ8xx6KaRTk9LQINAPOv9SwDjv5nDI0sH1/RVd7kkkQVUj+3Eu9S5EWxkRp0sdihM6Dqd/7hbfNIln4GeBlE+8tsRc7G71OUHnywODfNunnYDzdQoUE1ekXZ1RCLc+FpQ2vdykaejn8jyPqWmCk+mDIXH0NqwQ+YbwVS7qCjaSdnjRIXftgMxEWqF/+JEfL8ynnA/iVoLZwc1gZBVBysdx07+ynnQL1eio9I2Z6ZdYn9wcvyPvi6JBe7z4p9DXBELATfoAi1cY6OpyoHJZhsdB8uxkCkZpr0OgEwVJAj55f3kG2WwteM/wv+eUO42pfi2drrjfDCXtSK/tByeZcBb1zNITwJ6/gcyi+nLBVhQZlyx/sd2rxIq3KNkqrtOKF/HRcghUEiQ8szbLvuCyezQvzFsEexSZIz8hs9czPcqnVncaN5lPBSsTlsHakr7dZhVRyQXawuQ+fGDtG/OvCOoqMRxHtoTRBgE9kQ013AIzwPh0XExhoa/MBJrxvg4edC0Z+8+lVXbfN8ek23dKxUxjj5yvvUnvnYQDiLXUo6Rn5QyQ66CUHNjzsv035NJOTQypRok49nldNLEZkfp9SwtVuYGoX4zTD6JqozWbeN9NMDF+P6DJm2ffXRkoFGr+7hmxFvHPtpR6SRxjOq5CXinl9f6NO2fbw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(13003099007)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+ZSIhSJt7rMkkEBP32VBdMpmkG//5xDJUlSRCDswWEtdJP/eILfoE3B33WzFq3WeM3K9GE+pYT5aOcCoBQVpxXZCEfnkM6GqcPoJIU4Y2LsXHlHwXLXlwCP0jvphxHz0tHv3bbrTNlLiH6Sc0pdmIZO/do2vdoUFc4MVxlHW/5KogaOzRyY/UZ+DgBnKT8n8z15VeBAWem+Mq+O2A7GpI+arRwPUgG8yr3Uy25MTN4X50QnTTCIRlr6Q9IZhy7Ly0H/WRD7fnMpCHXzIHHtHkow8L+7wWlwGR0TSx4/uGcrxK9ohMiu8ekWEvhOKMIIwqffG98dyj6OVk/Et8ykpnZwfo59JwqhP+a2QFmfYvg6zRHYqurN+yTG+9mFbyZL/5eJZlRKoLC8gSLAod9qOJmZnSCj33EZWfvMf91ge6rQSARyVBdRYBSHd6SAvATc8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 02:12:13.9500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c894a9e-bc43-4864-c046-08df152a4172
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462

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
2. Extend DRM UAPI with guest-only userptr flags and strip them
   from the CREATE_BLOB wire command
3. Implement core userptr functionality with page management
4. Wire blob ioctl creation to userptr objects

Tests:
- Full OPENCL CTS tests passed on ROCm 5.7.0 in V2000 platform.
- Near 70% percentage of OPENCL CTS tests passed on ROCm 7.0 W7900 platform.
- most HIP catch tests passed on ROCm 7.0 W7900 platform.
- Some AI applications enabled on ROCm 7.0 W7900 platform.
- latest ROCm 7.14 and ROCm 10 testing is ongoing.

V7 changes:
- Mask guest-only DRM flags out of CREATE_BLOB wire blob_flags
- Clear userptr->pages after pin failure to avoid double-free
- DMA-map userptr SG only when virtio_gpu_use_dma_api() is required
- Use DMA_TO_DEVICE for USERPTR_RDONLY
- Reject USERPTR unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
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
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  37 +++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |  25 +-
 drivers/gpu/drm/virtio/virtgpu_object.c  |  10 +
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 335 +++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c      |   6 +-
 include/uapi/drm/virtgpu_drm.h           |   9 +
 include/uapi/linux/virtio_gpu.h          |   1 +
 8 files changed, 422 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c

base-commit: 766bfba0f3bae329f99b42dcabc3ef11fa368f0b
-- 
2.34.1
