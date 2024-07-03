Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352D176AC4
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010361; cv=none; b=qsdLewViiJpxH4SXcVJbWrtm0QpAC0M/9XSzUgnc2GqgEmWLyhsj/x3/LaQgrwIaPL8X0cvhb5CSy35zORBhED4zh3askOVbPsJIXIujRr4PkSC77Zd7Qt8sJfFZ1K5ICInlAn4180zxgjgUGGzeaifKRgskMZxsAWcnxZS5umY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010361; c=relaxed/simple;
	bh=qMMNRcNJeifQ0YF6+XxTg3PlKoA1Qotat0gtieoMhxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxWrc310NR80BUlOGMYq6i4xpDfTZ4vBKn3a2sXwpkdmivN+OHW3JEMx/dsxgozK3MgPFuKAdyxbBX8SXgZIIA6RqGX9zHSxMCoISlEqUGAs8cqBbnnh6ePXTBFhEeK9/nRqePWuQuUaMo6jzsG+vy2b+tAWdmY+JQQczm9mE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LV4DcaP4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LV4DcaP4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-424aa70fbc4so37583255e9.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010356; x=1720615156; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIJNp6zK/erK8PBf6rXdLZpOKroDuOLV73uwn4h8pRg=;
        b=LV4DcaP4JNq5/C1Pu0rsyMWODo13uKgs49ygDsqws9suSwAOzBHjdcu9ZYgq9UWR7A
         Qi/Lw43rIdxvCB3yq2EXw4wmjRijFPmAV7+/vJqqYdHf2n1tJRKI1qXRRloQN2u6FHYi
         u2kvvLchZuPThGGa3nC2fP9mSwbUcKM10Uqe/PwJggCCQdk7P59L8x0jbqMwQkkgFov2
         bjat0RLNoxYkQYfCtCIgA/3z1Dbme8EXVVWtdTkfXC3Azmdl0mbQdwg2NPLluqvc4RPT
         CntIjmdR0Ukn2kS/bD+AejGawtIEh4A9HzX0yRecDbc5q9FJgBtKhqNahyHN6YQ9F8HG
         dH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010356; x=1720615156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIJNp6zK/erK8PBf6rXdLZpOKroDuOLV73uwn4h8pRg=;
        b=uxB3dgo2jCONQMG92ygwPg9QIT9qL37NE8D4nQivCEynqGN2/PetRxPOBTdiDtnujw
         MkFZZn9+KyqkCYk0kUU7rgLL/eYM0fhfb7O2ztaYEhfJofZIyFcTn7uPwVyN9IctElYh
         NzWl+R73ORYeYu1A8uMyIfqtYdW6lfnKhyiVAm9VpNrVWnz0GM8AZDt7iugpIr640fa1
         9kCA15BIz4Mhyd8z+D0gK9J81xVUmjOAbvNfelwYOuGdJSm7QuJ5AyLTnsgROT2dl9kh
         0A3AEI6riE7AlviGTWgD7damqbr1GhG3uUzlkqhefjRk1t/ICfVAgvAfKdp4sIvF/i0z
         UHFQ==
X-Gm-Message-State: AOJu0YzEr43lIZZpSh2NPf2VZHs5BkAHp5QPl51vua48f2XJLf6PwAfk
	Ik4MaOz/VBpzaOXyGUDignLDx+nivxY/ZIDUz3R62NOciY5C6duprLKdIWMENyEx/KuvYOnULtO
	C
X-Google-Smtp-Source: AGHT+IFHWbJebpf5OSxHJAwEVwy4HhXAoAdV4b8cp+h8opCKsPf2PJlGWMA9MNr9Tm0fCSrud2HiNg==
X-Received: by 2002:a05:600c:2252:b0:424:a823:51d9 with SMTP id 5b1f17b1804b1-4257a06e036mr76721525e9.30.1720010355744;
        Wed, 03 Jul 2024 05:39:15 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4258036d034sm135376275e9.43.2024.07.03.05.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:15 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 00/19] virtio: consolidate vq info args of find_vqs()
Date: Wed,  3 Jul 2024 14:38:54 +0200
Message-ID: <20240703123913.969202-1-jiri@resnulli.us>
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
 drivers/virtio/virtio_pci_common.c            | 49 ++++++++-------
 drivers/virtio/virtio_pci_common.h            |  4 +-
 drivers/virtio/virtio_pci_modern.c            |  5 +-
 drivers/virtio/virtio_vdpa.c                  | 13 ++--
 fs/fuse/virtio_fs.c                           | 22 +++----
 include/linux/virtio_config.h                 | 60 +++++++++----------
 net/vmw_vsock/virtio_transport.c              | 16 ++---
 sound/virtio/virtio_card.c                    | 23 ++++---
 29 files changed, 240 insertions(+), 302 deletions(-)

-- 
2.45.2

