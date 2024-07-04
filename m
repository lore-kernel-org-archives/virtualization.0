Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B431A070E
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075438; cv=none; b=sRb+GIDf4CoaqLuL8FFlMLI8N0wbVcPzsbW4Duv759XxgrZtOCCSvgkbOlJccFCGDo/qe5l2nWul8G+DFuvOt5G59fRQkuhpuvQkiFtNUU4iyToqLjohMRIfLcYPyK6xKA6yTdm9PppZQKSLKtj9CXmZ6z8NJz60+q370cR+mVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075438; c=relaxed/simple;
	bh=lkUCZNdsoWpGe5TAMtvVzCdioYeLygRXNHEUt/haElc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2cajUjrFuANaR2Q6yqHAt0L+O8ywFb5ESc2SGAiIkLzmKbEvgE5ODweoiiBVQrdbmNy29/uq5pbw83FS/K5KJfdFXRED0tETgJwnB+BFm8167wi70x4ImOSVYyXC01tM++QsJzjBfYZRg+xKHIlnjRxloFWuRK3LxromMZQeas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GSO81NP9; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GSO81NP9"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso2659001fa.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075433; x=1720680233; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bIBdDq4uk8lHUbDkVvGg9srk2kKV/M6unxsxCzAfOA0=;
        b=GSO81NP9KNkfh6lTX3gCogmaL6cwSzC7hQdFfvTsViKQk4GnxjmzhRrg9mJl14qyTV
         dv1bPp371am7uUpow8oT3fNQgnJBL+8qG8uAU6/b+jl/LUp/W830zWXeZOeLv8ATANTz
         kleSfurqoLJg/NG/KCGShWNSNfnWwn+fJvvPnjnF7NWU4RafxzI869Dz5R3lxtf+eSsb
         CtQo/paGc1Is25M7mott/I5L2Y1scUQJSbVB9cQdK0HMxsmHbTBg3gj4gWQFK4ztPnID
         3p13Xw2HMX9jK5XWCfg1iJuYC+0YvffM/Ba++B2iXM8SzmSC4Vaq15lzECZ7OgmACtdP
         ONcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075433; x=1720680233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIBdDq4uk8lHUbDkVvGg9srk2kKV/M6unxsxCzAfOA0=;
        b=aPRerLru03catyNujJjcj99QWcQHBvCgPZkPO2oYS73nYhsx3xBYwqdHUS9K2zdhxP
         vUN5qiT8IOggI346/HmHuV15r/yUuqAO98v9ziGXAkvxnCmyZ740XOJHUsJwYHIXYUry
         RkxHBDmpbUuiOlsFZ1MKdKGxbt3Q8uGw2c9KHds8SE7dgiclK5Ir1PPMFA/fPqi3ycLO
         d0XdtHGQELlqrQKZt7319JHPeg173vj6/a/jsz08SPAPQE8omZ9/sOaCqrqhbgCR57Qy
         hOwxlzCLiTv3dTr+x4xkyR/Y99ZjQy+0PKvkoDimF+5JKYa+0UVwrv/VD8bPZCe0qqsn
         RZoA==
X-Gm-Message-State: AOJu0Yz4h0qLhpVx4tf0aS6Rclsa6b/LF6VE/ufjmppfmo1u1zFndDWN
	M6Oi/oFFuW2xYBh3gzjdOZPe0R189OHm4+f9KVdwnbC20yxCci57AgtWYvNF4JpAuEPYhYOEoAN
	I
X-Google-Smtp-Source: AGHT+IFUA7r5kUAyN3v5hod1dRVhh/H3FRceBeCycIjp24pDs9g1l3I5o88+YCEqCyBpl2/XWMXYrg==
X-Received: by 2002:a2e:9b4b:0:b0:2ec:1708:4daf with SMTP id 38308e7fff4ca-2ee8edd7bacmr3268151fa.47.1720075432806;
        Wed, 03 Jul 2024 23:43:52 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a251ef5sm10985625e9.36.2024.07.03.23.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:43:52 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 00/19] virtio: consolidate vq info args of find_vqs()
Date: Thu,  4 Jul 2024 08:43:31 +0200
Message-ID: <20240704064350.1097716-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently, virtio_find_vqs() and virtio_find_vqs_ctx() accept array of
names, callbacks and ctx (in case of the second one) as separate args.
That became inconvenient as the ctx addition showed.

For virtio_net control queue, an indication of queue flavour (slow path)
is going to be needed to be passed to PCI transport in order to
assign vectors properly, another array added to virtio_find_vqs_ctx()
arg list would not be nice and convenient.

Instead, introduce a structure to carry vq callback, name and ctx. Pass
array of these structures to virtio_find_vqs() and all the way down to
transport find_vqs() op implementation.

That allows to easily extend what needs to be passed down. Also, it
makes the code a bit more cleaner. We get rid of separate
virtio_find_vqs_ctx() helper.

This patchset does the conversion in steps, using temporary _info() op
and helper. Note they are renamed back.

Patch #1 does one forgotten conversion to virtio_find_single_vq().
Patches #2 and #3 do preparations for find_vqs_info() op introduction.
Patch #4 introduces new op find_vqs_info() to replace find_vqs() it also
  introduces struct virtio_queue_info and virtio_find_vqs_info() helper.
Patches #5 and #6 convert transports to implement find_vqs_info() op
  that accepts array of virtio_queue_info structs.
Patch #7 converts virtio_find_single_vq() to use the new way as well.
Patch #8 removes original find_vqs() op.
Patch #9 renames find_vqs_info() to find_vqs() and completes first part
  of conversion this patches does.
Patches #10-#17 convert virtio_find_vqs() and virtio_find_vqs_ctx()
  users to use new virtio_find_vqs_info() helper.
Patch #18 removes no longer used virtio_find_vqs() and
  virtio_find_vqs_ctx() helpers.
Patch #19 finalizes the conversion by renaming virtio_find_vqs_info()
  to virtio_find_vqs().

---
v1->v2:
- added forgotten VIRTIO_SND_VQ_MAX for array size in virtio_card.c
- s/virtio_queue_info/virtqueue_info/
- fixed comments for struct virtqueue_info
- rebased on top of recent code changes (virtio_fs.c)
- see individual patches changelog for more details

Jiri Pirko (19):
  caif_virtio: use virtio_find_single_vq() for single virtqueue finding
  virtio: make virtio_find_vqs() call virtio_find_vqs_ctx()
  virtio: make virtio_find_single_vq() call virtio_find_vqs()
  virtio: introduce virtio_queue_info struct and find_vqs_info() config
    op
  virtio_pci: convert vp_*find_vqs() ops to find_vqs_info()
  virtio: convert find_vqs() op implementations to find_vqs_info()
  virtio: call virtio_find_vqs_info() from virtio_find_single_vq()
    directly
  virtio: remove the original find_vqs() op
  virtio: rename find_vqs_info() op to find_vqs()
  virtio_blk: convert to use virtio_find_vqs_info()
  virtio_console: convert to use virtio_find_vqs_info()
  virtio_crypto: convert to use virtio_find_vqs_info()
  virtio_net: convert to use virtio_find_vqs_info()
  scsi: virtio_scsi: convert to use virtio_find_vqs_info()
  virtiofs: convert to use virtio_find_vqs_info()
  virtio_balloon: convert to use virtio_find_vqs_info()
  virtio: convert the rest virtio_find_vqs() users to
    virtio_find_vqs_info()
  virtio: remove unused virtio_find_vqs() and virtio_find_vqs_ctx()
    helpers
  virtio: rename virtio_find_vqs_info() to virtio_find_vqs()

 arch/um/drivers/virt-pci.c                    |  8 ++-
 arch/um/drivers/virtio_uml.c                  | 12 ++--
 drivers/block/virtio_blk.c                    | 20 +++----
 drivers/bluetooth/virtio_bt.c                 | 13 ++--
 drivers/char/virtio_console.c                 | 43 ++++++-------
 drivers/crypto/virtio/virtio_crypto_core.c    | 31 ++++------
 drivers/firmware/arm_scmi/virtio.c            | 11 ++--
 drivers/gpio/gpio-virtio.c                    | 10 ++--
 drivers/gpu/drm/virtio/virtgpu_kms.c          |  9 ++-
 drivers/iommu/virtio-iommu.c                  | 11 ++--
 drivers/net/caif/caif_virtio.c                |  8 +--
 drivers/net/virtio_net.c                      | 34 ++++-------
 drivers/net/wireless/virtual/mac80211_hwsim.c | 12 ++--
 drivers/platform/mellanox/mlxbf-tmfifo.c      | 10 ++--
 drivers/remoteproc/remoteproc_virtio.c        | 12 ++--
 drivers/rpmsg/virtio_rpmsg_bus.c              |  8 ++-
 drivers/s390/virtio/virtio_ccw.c              | 13 ++--
 drivers/scsi/virtio_scsi.c                    | 32 ++++------
 drivers/virtio/virtio_balloon.c               | 32 ++++------
 drivers/virtio/virtio_input.c                 |  9 +--
 drivers/virtio/virtio_mmio.c                  | 12 ++--
 drivers/virtio/virtio_pci_common.c            | 48 ++++++++-------
 drivers/virtio/virtio_pci_common.h            |  3 +-
 drivers/virtio/virtio_pci_modern.c            |  5 +-
 drivers/virtio/virtio_vdpa.c                  | 13 ++--
 fs/fuse/virtio_fs.c                           | 22 +++----
 include/linux/virtio_config.h                 | 60 +++++++++----------
 net/vmw_vsock/virtio_transport.c              | 16 ++---
 sound/virtio/virtio_card.c                    | 23 ++++---
 29 files changed, 238 insertions(+), 302 deletions(-)

-- 
2.45.2

