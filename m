Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913DC3C819A
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788227233; cv=none; b=s7YgmmH91ZoV70EeASphbjYOaReED6480gMsuPhPQQEptlzpYerSQBc4ZFmuN4ENGBKCactRwD9qShbVxqlqlaXJYHYu+uoZrulAmtS0DbRO0zy8iLXY7B4DNjPWI+rXM9ABhBgBoAZ+bohYuSotzEHtXNEN6qFI+cWgezACQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788227233; c=relaxed/simple;
	bh=WmIWt8sclQYC6aVL1FoXqC06hsOZBkmHb2WjqLvNwc8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gSTWTRYLnS3vlpifc5o6bPmQ0ZBqrJZU4vpRIeoa56wz3KCI3xhP6eOvSCAbBMATvD5YG5t7+8aBrRAkl9aS8F4QvLIO5g7zhJTS1x7LXRo8bCHpNdITntjQtABO+pK+IOJPj1Lh+osUZ6PPJgyEkqdfg3u60R4o2UEzdCZ86ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa7WbLHy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa7WbLHy"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so4769883a91.0
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 18:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788227218; x=1788832018; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oF3hHSmjXNzkrH0jOeW++TVcT0uT7txPwkCx0tulNXs=;
        b=Sa7WbLHy6dHRdQWE+jdTKEe6219IWGUjyOa4mZMNOHluRaVzOSz6/ZNEb9dXBbWNKE
         0MmEFsyHq9jdFuA4zXUjiZ6bmmgMhF/eOrap+6mUz2fCj8JUCFeJqNW3u95hcMiMSpYd
         jwikXFeVL6wzOBv1kxQsl3+BcDZBi1ZozHTgvXXtd/4l6WQ5W/rCraBRgOy6VkEw29Jk
         oRroiYUf4W5+egproF9cQKsa7FwcTHDti6iJp2VN+pPpLoTIZyZ6cfHyS5S6kOCwMoOe
         SezntD7ncAOdFbvNbiotdmi6M1Ghx0A2+E6wLlxk0o5VCKIva1hzK8fuZVrpa9wKpxiy
         Z4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788227218; x=1788832018;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oF3hHSmjXNzkrH0jOeW++TVcT0uT7txPwkCx0tulNXs=;
        b=ABWXprEX29SxeEBUG+R6PKZoV0W0/hllTz7z7A4dLPhVJ97lXFwN0QxyNVreAfJaZz
         HCHkGsvylzhRq4fClTTSwCn9zGYD6Vf03zrt9XFHWqXQEFIJ+eGzodlvOzd6YnIHTjOo
         3vY/LhG13eHZ7pstEgaZRgIyV0g+QOc/jnZC1WhoDMABXtY9/7YNP83Naw78BV08UwLC
         CYgn9wOP0mwGG5tcpZ36ERDWMeef4nUZ6E4SjUXouiILwjElOxeuOG+GBLrPJZyZFMri
         PYqqSNvGp6fsvPHUz/9Q/OsfEdx3DSh/iPBggB6GjkbaKWBBcvcH1QFpt/i7a98IybqA
         peOg==
X-Forwarded-Encrypted: i=1; AKwUvBxzedvFr6/uNsdlKcNdRO2KXrtRX3EMqh9I6iGDxuBgeUGDqiW021Klm7WrTBTJ46q8TdOcqgTpQLo63Oj8mA==@lists.linux.dev
X-Gm-Message-State: AFuF++l1fzdILXW/HQ8AQq3KoUA98sbsC6uVc6125zIHgiEJlefPHAXN
	e+CpNTxIlU51t64OsjKvD2tfkcEQ7Y4UdmPkSIv4RH42thRvKmct/Pcj
X-Gm-Gg: AYBFou3y/XkYxKS0fKet/LtDXNqvKYb5o7beofo2/CGtzf7KCfyhkt4iPZiDhvc3KPn
	oj2A8ZHQtCj5hSKWso/SjnMbd+v4Jf+GczHEt8QfcvtAgWxGFm3beWeCl6AtAOe4p2MiGDJVNbq
	U40WwOrgxKZa1qNk4PHVSgJR/eWy4xno/G8SFxAQElReXrhIJXVk2IHC9qT9044Hdau04W3K75K
	/4zwXJifda3czw+T3P+p0UirdF9+81dx/lFLhvLDULUnyqrNid05CDPrevUxLDmVRio/IdsyVlh
	rWZ0G/WhteKJLBrl0uvz11nyPw42dM0iRVqKMLVyS6lMETdjaLCkay+eYfGjZQ3BOClpq2n3gnK
	xEwS3YjRw8VgiBEdrUMyKIsenISR/1aLfB1jZl7AzEOl/3ZgoyZ+B2g5VDAyx9RU1jeQ2fB6UXA
	/iOi+rKOFnwUVLqQhI7C64xe616Eu8/7aeDH4/JDm3/iqiENZTo/OGQLszck/afBKo9BjhwCJXz
	LTM8Q==
X-Received: by 2002:a17:90b:1a85:b0:398:a2ed:7b5c with SMTP id 98e67ed59e1d1-39907f04d76mr4922554a91.24.1788227218247;
        Mon, 31 Aug 2026 18:46:58 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d62b807sm2561122a91.16.2026.08.31.18.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:46:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: mst@redhat.com,
	eperezma@redhat.com,
	linux-kernel@vger.kernel.org,
	xuanzhuo@linux.alibaba.com,
	jasowangio@gmail.com,
	linux-scsi@vger.kernel.org,
	mkp@kernel.org,
	virtualization@lists.linux.dev,
	James.Bottomley@HansenPartnership.com
Cc: alistair@alistair23.me,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 0/2] scsi: Initial commit of VirtIO PCIe Endpoint Driver
Date: Tue,  1 Sep 2026 11:46:48 +1000
Message-ID: <20260901014650.2728658-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

This series adds a VirtIO SCSI endpoint built on top of the VirtIO PCIe
endpoint. This is a similar approach to the NVMe PCIe Endpoint
(drivers/nvme/target/pci-epf.c) but for SCSI.

This does end up being somewhat similar to the pci-epf.c code, but
re-written for SCSI.

This approach allows a PCIe Endpoint device (tested on a
radxa-rock5b) to setup what appears to be a SCSI device, using an
existing SCSI backend (tested using scsi_debug).

At this point a host can connect over PCIe, ensure virtio_pci and
virtio_scsi is loaded and on PCIe rescan will see a scsi device.

There are a few pain points with this approach though:
 1. We have to use the Legacy SCSI VirtIO driver. This is because the
    Raxda Rock5b (and AFAIK all PCIe Endpoint hardware) can't add
    capabilities. So we can't advertise the VirtIO Common configuration
    capability, which means we can't be a modern VirtIO SCSI device.

    This is unfortunate, but there doesn't seem to be any way around
    this, at least with the current hardware.

 1.2. Legacy virtio devices only have 32 feature bits and therefore can't
    set the VIRTIO_F_ACCESS_PLATFORM (bit 33) feature. This means the
    vring_use_map_api() function will return false.

    Currently Linux endpoint devices use the legacy virtio interface as
    they aren't able to advertise the Common configuration capability.
    As most PCI endpoint capable PCIe controllers do not allow modifying the
    capability list, and thus are unable to advertise the Common configuration
    capability. This means the device's inbound TLPs fault on the host
    SMMU because the vring descriptors carry raw physical addresses.

    This series adds a quirk that forces a subset of legacy virtio devices
    to use the DMA Map API (vring_use_map_api() will return true),
    which fixes this issue.

    It's unideal that we have to hard code a quirk to basically just
    advertise the VIRTIO_F_ACCESS_PLATFORM feature, but (see 1) as we
    are stuck with legacy virtio devices there isn't much else we can do.

 2. We have to pin scsit_pci_epf_poll_cfg_thread() on a CPU in order to
    respond fast enough to the host. This means we effectivly burn a CPU
    to read and write some values. But as there are no intterupts
    generated on these events and we need to be very quick there isn't
    another option.

With two Raxda Rock5bs connected together and the IOMMU turned off I see
performance numbers like this

root@radxa-rock5b:~# fio-test.sh /dev/sda
Running on /dev/sda...
  Rnd read,    4KB,  QD=1, 1 job :  IOPS=223, BW=895KiB/s (917kB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=7415, BW=29.0MiB/s (30.4MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=20.2k, BW=79.0MiB/s (82.8MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=213, BW=26.7MiB/s (28.0MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=1482, BW=185MiB/s (194MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=2599, BW=325MiB/s (341MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=184, BW=92.1MiB/s (96.6MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=1079, BW=540MiB/s (566MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=1284, BW=642MiB/s (674MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=222, BW=889KiB/s (911kB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=7433, BW=29.0MiB/s (30.4MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=20.3k, BW=79.1MiB/s (83.0MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=203, BW=25.5MiB/s (26.7MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=1521, BW=190MiB/s (199MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=2927, BW=366MiB/s (384MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=207, BW=25.9MiB/s (27.2MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=1538, BW=192MiB/s (202MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=183, BW=91.7MiB/s (96.2MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=1356, BW=678MiB/s (711MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=646, BW=647MiB/s (678MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=209, BW=26.1MiB/s (27.4MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=1576, BW=197MiB/s (207MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=166, BW=83.3MiB/s (87.4MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=891, BW=446MiB/s (468MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=539, BW=540MiB/s (566MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=453, BW=228MiB/s (239MB/s)
 IOPS=478, BW=241MiB/s (253MB/s)

claude-opus-4-8 was used to parse the crash dumps and IOMMU faults
during testing to narrow down where issues where are how to fix them

Alistair Francis (2):
  virtio_pci: Add a quirk to force DMA Map API for certain legacy
    devices
  scsi: Initial commit of VirtIO PCIe Endpoint Driver

 drivers/scsi/Kconfig               |   12 +
 drivers/scsi/Makefile              |    1 +
 drivers/scsi/virtio-scsi-pci-epf.c | 3099 ++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_legacy.c |   27 +
 drivers/virtio/virtio_ring.c       |    7 +
 include/linux/virtio.h             |    5 +
 6 files changed, 3151 insertions(+)
 create mode 100644 drivers/scsi/virtio-scsi-pci-epf.c

-- 
2.55.0

