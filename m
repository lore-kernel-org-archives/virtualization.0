Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060D1C54EBD
	for <virtualization@archiver.kernel.org>; Mon,  9 Jan 2023 08:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A013814BB;
	Mon,  9 Jan 2023 08:04:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A013814BB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=2hEgmKRc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aNsnGFq3SBh9; Mon,  9 Jan 2023 08:04:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D19ED81490;
	Mon,  9 Jan 2023 08:04:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D19ED81490
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9C0CC0032;
	Mon,  9 Jan 2023 08:04:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B811CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 08:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C9FA814A0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 08:04:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C9FA814A0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pY-pDiG3DEjk
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 08:04:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8831781490
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8831781490
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 08:04:35 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id m3so5659191wmq.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Jan 2023 00:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k/eTguZ+vBXGX2AwMbtDXjvAK0CXJmCChr0POq5BYnY=;
 b=2hEgmKRc+ljrO9ZWVF8b7C9wF7B+xikXteKbU3GWtcRjFTuqGAJb83Xs3KWbHp6/sj
 DdeUOweNKQoHMxWHWpR1MN70CEuv2sA6/HRqX5LQyEqHBnjA712wbDlJSWRgxFya8+TU
 J2yCd3VXs+a9WjCoweNe+2KgpuaP4jWFTJ19bxUVGD5tmlrDNErOcRVvRajUqlG8XvD/
 R6fyVPIOLWETbxlLncLxff6BY86kglSbq//yGWWSiaaO6wYE5dXrHWU8zR7EEbAtdV3j
 TRWrJMOYdca+kXTa4TaEl7nfPxqSpml8WKHaT/shVL30FK38zv9/urYtfMpuGog1RCNn
 sCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k/eTguZ+vBXGX2AwMbtDXjvAK0CXJmCChr0POq5BYnY=;
 b=Vfn6yE5+wCBNx/rCTTXqNn84RaoZqucdFGrkr3vvQrV4S7t2YQ6RLOFWIAP6qyJGX2
 dHFjSX5GmJzle3CAlWdSgiiX6F+s2H0q8qpZ3Vz6hO5j40mHj0RUBEHWqlXCW3d0aZn2
 1eQ+X04GUvJ6/gxET408QNJHPHlEfSe3gxzq+Z4z5/+5Wl6sZAQMU/FyguLa/5L82Sgg
 UFuBbufdXn3PMdwcuN0BKwOnzet7wmD4Hjme0gx0ygtJ2cwyL2B8ANatkyS/fICcmaFe
 uSd/cd5IPnKyt50Ngd43gWQY3PigM3kExKH9OOmm0gL2FtRubXnURQDn0/nrsbyTY/pR
 Lp4A==
X-Gm-Message-State: AFqh2kqWkDyCI0GeUWk/5AA8VaJzvYBxJPQvAQBO7WeSRmiJikn7Ql32
 XTJ47bqI28QpoYOfXP3DKtPk7dCMbuXRcfrK
X-Google-Smtp-Source: AMrXdXumvAblIZk7gkbhavODifPSVuq+dW/sqDUHlF2dyv4rnpa9y81POFSuhihwVChVSm1pPoRIcQ==
X-Received: by 2002:a05:600c:34d0:b0:3d6:b691:b80d with SMTP id
 d16-20020a05600c34d000b003d6b691b80dmr44921803wmq.21.1673251472959; 
 Mon, 09 Jan 2023 00:04:32 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a5d508b000000b002779dab8d85sm7789809wrt.8.2023.01.09.00.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jan 2023 00:04:32 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v8 0/3] virtio: vdpa: new SolidNET DPU driver
Date: Mon,  9 Jan 2023 10:04:29 +0200
Message-Id: <20230109080429.1155046-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: bhelgaas@google.com, mst@redhat.com
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

This series adds a vDPA driver for SolidNET DPU.

Patch 1 adds SolidRun vendor ID to pci_ids.
Patch 2 adds a PCI quirk needed by the DPU.
Patch 3 has the driver source code.

Patch 1 is prerequisite for both patch 2 and patch 3.

v2:
	- Semantics fixes in commit log - Patch 1.
	- Move the vendor ID to the right place, sorted by vendor ID - Patch 1.
        - Update patch subject to be more meaningful and similar to
          previous quirks - Patch 2.
        - Update the commit log to describe better what the patch does -
	  Patch 2.
	- Auto detect the BAR used for communication - Patch 3.
	- When waiting for the DPU to write a config, wait for 5secs
	  before giving up on the device - Patch 3.
	- Return EOPNOTSUPP error code in vDPA set_vq_state callback if
	  the vq state is not the same as the initial one - Patch 3.
	- Implement a vDPA reset callback - Patch 3.
	- Wait for an ACK when sending a message to the DPU - Patch 3.
	- Add endianness comments on 64bit read/write functions - Patch 3.
	- Remove the get_iova_range and free vDPA callbacks - Patch 3.
	- Usage of managed device functions to ioremap a region - Patch 3.
	- Call pci_set_drvdata and pci_set_master before
	  vdpa_register_device - Patch 3.
	- Create DMA isolation between the vDPA devices by using the
	  chip SR-IOV feature.
	  Every vDPA device gets a PCIe VF with its own DMA device - Patch 3.

v3:
	- Validate vDPA config length while receiving the DPU's config,
	  not while trying to write the vDPA config to the DPU - Patch 3.
	- Request IRQs when vDPA status is set to
          VIRTIO_CONFIG_S_DRIVER_OK - Patch 3.
	- Remove snet_reset_dev() from the PCI remove function for a VF - Patch 3.

v4:
	- Get SolidRun vendor ID from pci_ids - Patch 3.

v5:
	- Remove "select HWMON" from Kconfig.
	  Usage of "depends on HWMON || HWMON=n" instead and usage of
	  IS_ENABLED(CONFIG_HWMON) when calling to snet hwmon functions.
	  snet_hwmon.c is compiled only if CONFIG_HWMON is defined - Patch 3.
	- Remove the  #include <linux/hwmon-sysfs.h> from snet_hwmon.c - Patch 3.
	- Remove the unnecessary (long) casting from snet_hwmon_read_reg -
	  Patch 3.
	- Remove the "_hwmon" ending from the hwmon name - Patch 3.
	- Usage of IS_ERR macro to check if devm_hwmon_device_register_with_info
	  failed - Patch 3.
	- Replace schedule() with usleep_range() in the "hot loop" in
	  psnet_detect_bar - Patch 3.
	- Remove the logging of memory allocation failures - Patch 3.
	- Add parenthesis to arguments in SNET_* macros - Patch 3.
	- Prefer sizeof(*variable) instead of sizeof(struct x) when allocating
	  memory - Patch 3.

v6:
	- SNET_WRN -> SNET_WARN - Patch 3.

v7:
	- Explain the dependency of SNET_VDPA on HWMON in Kconfig - Patch 3.
	- Fix snprintf size argument in psnet_open_pf_bar and
	  snet_open_vf_bar - Patch 3.
	- Fix kernel warning in snet_vdpa_remove_vf.
	  Call pci_free_irq_vectors after vdpa_unregister_device,
	  otherwise we'll get "remove_proc_entry: removing non-empty
	  directory 'irq/..', leaking at least '..'" warnings - Patch 3.
	- Remove the psnet_create_hwmon function empty definition if
	  HWMON is not enabled, otherwise, we'll get "warning: no
	  previous prototype for 'psnet_create_hwmon'" when compiling
	  with W=1.
	  This was reported by kernel test robot <lkp@intel.com> - Patch 3.

v8:
        - Fix the series versioning.
          I updated the versions of every patch separately,
	  which seems to be wrong.

Alvaro Karsz (3):
  PCI: Add SolidRun vendor ID
  PCI: Avoid FLR for SolidRun SNET DPU rev 1
  virtio: vdpa: new SolidNET DPU driver.

 MAINTAINERS                        |    4 +
 drivers/pci/quirks.c               |    8 +
 drivers/vdpa/Kconfig               |   18 +
 drivers/vdpa/Makefile              |    1 +
 drivers/vdpa/solidrun/Makefile     |    6 +
 drivers/vdpa/solidrun/snet_hwmon.c |  188 +++++
 drivers/vdpa/solidrun/snet_main.c  | 1110 ++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_vdpa.h  |  194 +++++
 include/linux/pci_ids.h            |    2 +
 9 files changed, 1531 insertions(+)
 create mode 100644 drivers/vdpa/solidrun/Makefile
 create mode 100644 drivers/vdpa/solidrun/snet_hwmon.c
 create mode 100644 drivers/vdpa/solidrun/snet_main.c
 create mode 100644 drivers/vdpa/solidrun/snet_vdpa.h

--
2.32.0
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
