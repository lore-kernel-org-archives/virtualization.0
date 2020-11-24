Return-Path: <SRS0=jeLh=E6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98EFC2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 11:38:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6CA206D8
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 11:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6CA206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C39AA21503;
	Tue, 24 Nov 2020 11:38:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BCUNZBF8wCce; Tue, 24 Nov 2020 11:38:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1E0BD214EC;
	Tue, 24 Nov 2020 11:38:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E87E0C1836;
	Tue, 24 Nov 2020 11:38:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AA16C0052
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8964685579
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p6_ukVDXV7xv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 129F085572
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:29 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 00416AC2D;
 Tue, 24 Nov 2020 11:38:26 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH 00/15] drm: Move struct drm_device.pdev to legacy
Date: Tue, 24 Nov 2020 12:38:09 +0100
Message-Id: <20201124113824.19994-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Cc: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 spice-devel@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The pdev field in struct drm_device points to a PCI device structure and
goes back to UMS-only days when all DRM drivers where for PCI devices.
Meanwhile we also support USB, SPI and platform devices. Each of those
uses the generic device stored in struct drm_device.dev.

To reduce duplications and remove the special case of PCI, this patchset
converts all modesetting drivers from pdev to dev and makes pdev a field
for legacy UMS drivers.

For PCI devices, the pointer in struct drm_device.dev can be upcasted to
struct pci_device; or tested for PCI with dev_is_pci(). In several places
the code can use the dev field directly.

After converting all drivers and the DRM core, the pdev fields becomes
only relevant for legacy drivers. In a later patchset, we may want to
convert these as well and remove pdev entirely.

The patchset touches many files, but the individual changes are mostly
trivial. I suggest to merge each driver's patch through the respective
tree and later the rest through drm-misc-next.

Thomas Zimmermann (15):
  drm/amdgpu: Remove references to struct drm_device.pdev
  drm/ast: Remove references to struct drm_device.pdev
  drm/bochs: Remove references to struct drm_device.pdev
  drm/cirrus: Remove references to struct drm_device.pdev
  drm/gma500: Remove references to struct drm_device.pdev
  drm/hibmc: Remove references to struct drm_device.pdev
  drm/i915: Remove references to struct drm_device.pdev
  drm/mgag200: Remove references to struct drm_device.pdev
  drm/nouveau: Remove references to struct drm_device.pdev
  drm/qxl: Remove references to struct drm_device.pdev
  drm/radeon: Remove references to struct drm_device.pdev
  drm/vboxvideo: Remove references to struct drm_device.pdev
  drm/virtgpu: Remove references to struct drm_device.pdev
  drm/vmwgfx: Remove references to struct drm_device.pdev
  drm: Upcast struct drm_device.dev to struct pci_device; replace pdev

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 23 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 10 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 10 +--
 drivers/gpu/drm/ast/ast_drv.c                 |  4 +-
 drivers/gpu/drm/ast/ast_main.c                | 25 +++---
 drivers/gpu/drm/ast/ast_mm.c                  | 17 ++--
 drivers/gpu/drm/ast/ast_mode.c                |  5 +-
 drivers/gpu/drm/ast/ast_post.c                |  8 +-
 drivers/gpu/drm/bochs/bochs_drv.c             |  1 -
 drivers/gpu/drm/bochs/bochs_hw.c              |  4 +-
 drivers/gpu/drm/drm_agpsupport.c              |  9 +-
 drivers/gpu/drm/drm_bufs.c                    |  4 +-
 drivers/gpu/drm/drm_edid.c                    |  7 +-
 drivers/gpu/drm/drm_irq.c                     | 12 +--
 drivers/gpu/drm/drm_pci.c                     | 26 +++---
 drivers/gpu/drm/drm_vm.c                      |  2 +-
 drivers/gpu/drm/gma500/cdv_device.c           | 30 ++++---
 drivers/gpu/drm/gma500/cdv_intel_crt.c        |  3 +-
 drivers/gpu/drm/gma500/cdv_intel_lvds.c       |  4 +-
 drivers/gpu/drm/gma500/framebuffer.c          |  9 +-
 drivers/gpu/drm/gma500/gma_device.c           |  3 +-
 drivers/gpu/drm/gma500/gma_display.c          |  4 +-
 drivers/gpu/drm/gma500/gtt.c                  | 20 +++--
 drivers/gpu/drm/gma500/intel_bios.c           |  6 +-
 drivers/gpu/drm/gma500/intel_gmbus.c          |  4 +-
 drivers/gpu/drm/gma500/intel_i2c.c            |  2 +-
 drivers/gpu/drm/gma500/mdfld_device.c         |  4 +-
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c        |  8 +-
 drivers/gpu/drm/gma500/mid_bios.c             |  9 +-
 drivers/gpu/drm/gma500/oaktrail_device.c      |  5 +-
 drivers/gpu/drm/gma500/oaktrail_lvds.c        |  2 +-
 drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c    |  2 +-
 drivers/gpu/drm/gma500/opregion.c             |  3 +-
 drivers/gpu/drm/gma500/power.c                | 13 +--
 drivers/gpu/drm/gma500/psb_drv.c              | 16 ++--
 drivers/gpu/drm/gma500/psb_drv.h              |  8 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c       |  6 +-
 drivers/gpu/drm/gma500/psb_intel_sdvo.c       |  2 +-
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c    | 36 ++++----
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 10 +--
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c   |  4 +-
 drivers/gpu/drm/i915/display/intel_bios.c     |  2 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c    | 14 +--
 drivers/gpu/drm/i915/display/intel_csr.c      |  2 +-
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c  |  2 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c    |  2 +-
 drivers/gpu/drm/i915/display/intel_gmbus.c    |  2 +-
 .../gpu/drm/i915/display/intel_lpe_audio.c    |  5 +-
 drivers/gpu/drm/i915/display/intel_opregion.c |  6 +-
 drivers/gpu/drm/i915/display/intel_overlay.c  |  2 +-
 drivers/gpu/drm/i915/display/intel_panel.c    |  4 +-
 drivers/gpu/drm/i915/display/intel_quirks.c   |  2 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c     |  2 +-
 drivers/gpu/drm/i915/display/intel_vga.c      |  8 +-
 drivers/gpu/drm/i915/gem/i915_gem_phys.c      |  6 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c     |  2 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c     |  2 +-
 drivers/gpu/drm/i915/gt/intel_ggtt.c          | 10 +--
 drivers/gpu/drm/i915/gt/intel_ppgtt.c         |  2 +-
 drivers/gpu/drm/i915/gt/intel_rc6.c           |  4 +-
 drivers/gpu/drm/i915/gt/intel_reset.c         |  6 +-
 drivers/gpu/drm/i915/gvt/cfg_space.c          |  5 +-
 drivers/gpu/drm/i915/gvt/firmware.c           | 10 +--
 drivers/gpu/drm/i915/gvt/gtt.c                | 12 +--
 drivers/gpu/drm/i915/gvt/gvt.c                |  6 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c              |  4 +-
 drivers/gpu/drm/i915/i915_debugfs.c           |  2 +-
 drivers/gpu/drm/i915/i915_drv.c               | 20 ++---
 drivers/gpu/drm/i915/i915_drv.h               |  2 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c           |  4 +-
 drivers/gpu/drm/i915/i915_getparam.c          |  5 +-
 drivers/gpu/drm/i915/i915_gpu_error.c         |  2 +-
 drivers/gpu/drm/i915/i915_irq.c               |  6 +-
 drivers/gpu/drm/i915/i915_pmu.c               |  5 +-
 drivers/gpu/drm/i915/i915_suspend.c           |  4 +-
 drivers/gpu/drm/i915/i915_switcheroo.c        |  4 +-
 drivers/gpu/drm/i915/i915_vgpu.c              |  2 +-
 drivers/gpu/drm/i915/intel_device_info.c      |  2 +-
 drivers/gpu/drm/i915/intel_region_lmem.c      |  8 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c       |  2 +-
 drivers/gpu/drm/i915/intel_uncore.c           |  4 +-
 .../gpu/drm/i915/selftests/mock_gem_device.c  |  1 -
 drivers/gpu/drm/i915/selftests/mock_gtt.c     |  2 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c         | 20 +++--
 drivers/gpu/drm/mgag200/mgag200_i2c.c         |  2 +-
 drivers/gpu/drm/mgag200/mgag200_mm.c          | 10 ++-
 drivers/gpu/drm/nouveau/dispnv04/arb.c        | 12 +--
 drivers/gpu/drm/nouveau/dispnv04/disp.h       | 14 +--
 drivers/gpu/drm/nouveau/dispnv04/hw.c         | 10 ++-
 drivers/gpu/drm/nouveau/nouveau_abi16.c       |  7 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c        |  2 +-
 drivers/gpu/drm/nouveau/nouveau_bios.c        | 11 ++-
 drivers/gpu/drm/nouveau/nouveau_connector.c   | 10 ++-
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  5 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c       |  6 +-
 drivers/gpu/drm/nouveau/nouveau_vga.c         | 20 +++--
 drivers/gpu/drm/qxl/qxl_drv.c                 |  2 +-
 drivers/gpu/drm/qxl/qxl_ioctl.c               |  3 +-
 drivers/gpu/drm/qxl/qxl_irq.c                 |  3 +-
 drivers/gpu/drm/qxl/qxl_kms.c                 |  1 -
 drivers/gpu/drm/radeon/atombios_encoders.c    |  6 +-
 drivers/gpu/drm/radeon/r100.c                 | 27 +++---
 drivers/gpu/drm/radeon/radeon.h               | 32 +++----
 drivers/gpu/drm/radeon/radeon_atombios.c      | 89 ++++++++++---------
 drivers/gpu/drm/radeon/radeon_bios.c          |  6 +-
 drivers/gpu/drm/radeon/radeon_combios.c       | 55 ++++++------
 drivers/gpu/drm/radeon/radeon_cs.c            |  3 +-
 drivers/gpu/drm/radeon/radeon_device.c        | 17 ++--
 drivers/gpu/drm/radeon/radeon_display.c       |  2 +-
 drivers/gpu/drm/radeon/radeon_drv.c           |  3 +-
 drivers/gpu/drm/radeon/radeon_fb.c            |  2 +-
 drivers/gpu/drm/radeon/radeon_gem.c           |  6 +-
 drivers/gpu/drm/radeon/radeon_i2c.c           |  2 +-
 drivers/gpu/drm/radeon/radeon_irq_kms.c       |  2 +-
 drivers/gpu/drm/radeon/radeon_kms.c           | 20 ++---
 .../gpu/drm/radeon/radeon_legacy_encoders.c   |  6 +-
 drivers/gpu/drm/radeon/rs780_dpm.c            |  7 +-
 drivers/gpu/drm/tiny/cirrus.c                 |  1 -
 drivers/gpu/drm/vboxvideo/vbox_drv.c          | 11 +--
 drivers/gpu/drm/vboxvideo/vbox_irq.c          |  4 +-
 drivers/gpu/drm/vboxvideo/vbox_main.c         |  8 +-
 drivers/gpu/drm/vboxvideo/vbox_ttm.c          |  7 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c          |  1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c        |  8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           | 27 +++---
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c            |  2 +-
 include/drm/drm_device.h                      | 12 ++-
 132 files changed, 584 insertions(+), 507 deletions(-)

--
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
