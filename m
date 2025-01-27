Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC113AA27
	for <virtualization@lists.linux-foundation.org>; Mon, 27 Jan 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737989509; cv=none; b=LKTpzET2e6a7I+EusryRw544pkeaYTDvmCirjQqPnJpRuil5a7G+cH0DaQdVV2y5Xomby2C5U+4jCGF7ppznvTG1rtQzENec5zCEL97aq8stK7wjku2jTYMPYYCQr4EaYj3IP9E6B60TX1EfVp2/NtyUzNbHlAD1+eHixS4WmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737989509; c=relaxed/simple;
	bh=82o5UCZGVSA9UZesK2R8teTwT07ErbjUj7U5zfSimqY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l5SKfMYXwYDYek0UzQfDiaxRiLib5b2cR66ahf4Sqw6c1Xm2TRDQ9WDSpvrUsEPUT0H+8+PYSdjGN9mdmXiBRupNZgHd5ucRG2kyUHN7OdbybqrpKfvonlREVeVQEo72pP6PM9x+L0MHsHLbbWFMh78NJK5thGC94yu7dTktcI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZZhpZHm; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZZhpZHm"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD43D40941
	for <virtualization@lists.linux-foundation.org>; Mon, 27 Jan 2025 14:51:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ocn19rdm5j0k for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jan 2025 14:51:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 537644093F
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 537644093F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aZZhpZHm
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 537644093F
	for <virtualization@lists.linux-foundation.org>; Mon, 27 Jan 2025 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737989504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=iau4JPbloeWL667asjULg/fQ3/zjcPRlyMvVrpALuFo=;
	b=aZZhpZHmoSLOm1bWCLhp02AnyGk70G5DpfAHmZokFRGHmHpi8wyRHFGCP5/4WRm7T1D14+
	2XJZB+Nv3EcYDCNe1UTyaG8MYM7MsiJa0x2Iv0VECn9Chw3BP6ig1jCbR9cycW8qVPwEFc
	2IhQi0t9I9dG7+bqiAw3jeaxM5K8+xU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-vdiIywt-PVSFzM0RUZ5V8A-1; Mon, 27 Jan 2025 09:51:43 -0500
X-MC-Unique: vdiIywt-PVSFzM0RUZ5V8A-1
X-Mimecast-MFC-AGG-ID: vdiIywt-PVSFzM0RUZ5V8A
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361a8fc3bdso22078935e9.2
        for <virtualization@lists.linux-foundation.org>; Mon, 27 Jan 2025 06:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737989502; x=1738594302;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iau4JPbloeWL667asjULg/fQ3/zjcPRlyMvVrpALuFo=;
        b=a+erIdXOKbQqhlZGhQoKAiWuj3WYcQpWfxexaPFFFsegHoVindSN0D+lNjj2g+grsx
         Sp/4uKWr7nC2cQo/iaYc17tr4ZirOQJQ/BblMxsW5bZkBLgYMlpimgS7zMFcQVocUuGm
         hgkha7w/AI1MhmL6fHuPkXzRb6f3n30aNLxzW8AQqP/5/bQOZBIFfTxwbhigMVSNNHba
         qCF+PAsfVKZWDKwuDIAW5x2IB04z8a7zoxJAtk4Xo0pYztkUV3ceenbpd+k/DDP2DG1u
         8AutQ2o2jAvkK1F56nfPIcfkUcxDc+BzZRNjbb1Bc6kUXB1eckG+0njAk6FRpZGm7ZVF
         qF9g==
X-Forwarded-Encrypted: i=1; AJvYcCWQEJLC69W7e83NKDd41E/awkd5iwm6cMnvPOgusfDEI2h+F1mr92YOP0o4TbQUsTQHT5SPqoiAP3+DMIJrwQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyszeYbwfKhckVvIUJdRcQ2+8SVmFt/xi5nNJ3uVr+6GneBU8sm
	NrBZFEx1iWikaeKfrZM0Pk29sNfzrJElDgwX81qek/N+WZxfhPdG5w/RhKp/ihVmOCdOrCKrbhM
	2/bsQwjvAFdK8hPLHGldILKBf8XKQe5xEL6pb/d/Cen1eDAMumeOVmHu+FucdkqGiRW54Tec43T
	Kw+kw=
X-Gm-Gg: ASbGncumb/ruSn2oO6g+it8ta2pWdc6z6hzIs5z9j7gRx5uK++hE7xoZ7RFBThfbEPb
	eyhjF0FXnEix/0WyVlVPyHh/cwFg4yYRHCNjpQNfCpVn2GrXry3/rN+ZfOIlI6dcIt15umb9DHv
	gLxrXazEk/yAS2+oM5Iyxm5K21RjBnoxaSqURfIoaHceY6t+67YeRoHxLAxPfaPOlEuTosZiR/f
	VH+YOy8UWg8iei4Bj8mnF5HEN1QUzCguussvRBtddjpzhxMBgjRUQ2iJ1pEOLFKrqYP7kQDUMNf
	Ug==
X-Received: by 2002:a05:600c:8719:b0:434:9499:9e87 with SMTP id 5b1f17b1804b1-43891437217mr333777705e9.25.1737989501767;
        Mon, 27 Jan 2025 06:51:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuV4H4eM+0+8cCmZ4gGN82WCYmpRuJq01+bj07H2U3xuDnsFknD44BEnMwIVHwLR+uIAWc4g==
X-Received: by 2002:a05:600c:8719:b0:434:9499:9e87 with SMTP id 5b1f17b1804b1-43891437217mr333777455e9.25.1737989501407;
        Mon, 27 Jan 2025 06:51:41 -0800 (PST)
Received: from redhat.com ([2a06:c701:740d:3500:7f3a:4e66:9c0d:1416])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b171e68bsm158813595e9.0.2025.01.27.06.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:51:40 -0800 (PST)
Date: Mon, 27 Jan 2025 09:51:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	akihiko.odaki@daynix.com, akpm@linux-foundation.org, bhe@redhat.com,
	david@redhat.com, israelr@nvidia.com, jasowang@redhat.com,
	mst@redhat.com, pstanner@redhat.com, sgarzare@redhat.com,
	skoteshwar@marvell.com, sthotton@marvell.com,
	xieyongji@bytedance.com, yuxue.liu@jaguarmicro.com,
	zhangjiao2@cmss.chinamobile.com
Subject: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20250127095138-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k39h3v2ISoMtt4oVdlo2MhrmIghM-gbCOvovdhgoJKg_1737989502
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There are still some known issues that I hope to address by rc2.
Giving them more time to get tested for now - none of them are
regressions.

The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:

  Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 5820a3b08987951e3e4a89fca8ab6e1448f672e1:

  virtio_blk: Add support for transport error recovery (2025-01-27 09:39:26 -0500)

----------------------------------------------------------------
virtio: features, fixes, cleanups

A small number of improvements all over the place:

vdpa/octeon gained support for multiple interrupts
virtio-pci gained support for error recovery
vp_vdpa gained support for notification with data
vhost/net has been fixed to set num_buffers for spec compliance
virtio-mem now works with kdump on s390

Small cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (1):
      vhost/net: Set num_buffers for virtio 1.0

David Hildenbrand (12):
      fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex
      fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex
      fs/proc/vmcore: disallow vmcore modifications while the vmcore is open
      fs/proc/vmcore: prefix all pr_* with "vmcore:"
      fs/proc/vmcore: move vmcore definitions out of kcore.h
      fs/proc/vmcore: factor out allocating a vmcore range and adding it to a list
      fs/proc/vmcore: factor out freeing a list of vmcore ranges
      fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM ranges in 2nd kernel
      virtio-mem: mark device ready before registering callbacks in kdump mode
      virtio-mem: remember usable region size
      virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM
      s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)

Israel Rukshin (2):
      virtio_pci: Add support for PCIe Function Level Reset
      virtio_blk: Add support for transport error recovery

Philipp Stanner (1):
      vdpa: solidrun: Replace deprecated PCI functions

Satha Rao (1):
      vdpa/octeon_ep: handle device config change events

Shijith Thotton (3):
      vdpa/octeon_ep: enable support for multiple interrupts per device
      virtio-pci: define type and header for PCI vendor data
      vdpa/octeon_ep: read vendor-specific PCI capability

Yongji Xie (1):
      vduse: relicense under GPL-2.0 OR BSD-3-Clause

Yuxue Liu (1):
      vdpa/vp_vdpa: implement kick_vq_with_data callback

zhang jiao (1):
      virtio_balloon: Use outer variable 'page'

 arch/s390/Kconfig                        |   1 +
 arch/s390/kernel/crash_dump.c            |  39 ++++-
 drivers/block/virtio_blk.c               |  28 ++-
 drivers/vdpa/octeon_ep/octep_vdpa.h      |  32 +++-
 drivers/vdpa/octeon_ep/octep_vdpa_hw.c   |  38 ++++-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  99 +++++++----
 drivers/vdpa/solidrun/snet_main.c        |  57 +++----
 drivers/vdpa/virtio_pci/vp_vdpa.c        |   9 +
 drivers/vhost/net.c                      |   5 +-
 drivers/virtio/virtio.c                  |  94 +++++++---
 drivers/virtio/virtio_balloon.c          |   2 +-
 drivers/virtio/virtio_mem.c              | 103 ++++++++++-
 drivers/virtio/virtio_pci_common.c       |  41 +++++
 fs/proc/Kconfig                          |  19 +++
 fs/proc/vmcore.c                         | 283 ++++++++++++++++++++++++-------
 include/linux/crash_dump.h               |  41 +++++
 include/linux/kcore.h                    |  13 --
 include/linux/virtio.h                   |   8 +
 include/uapi/linux/vduse.h               |   2 +-
 include/uapi/linux/virtio_pci.h          |  14 ++
 20 files changed, 735 insertions(+), 193 deletions(-)

