Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC451AC247
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103599; cv=none; b=cFsA6cNeAOzbIe8siaHWEE8RSqEvyiGCBCmJhQhoUU6SOvAZiH4WFUS4GPlAa15ZQWT3tVe4TjaVOvV3PDpMOz0egEuMGm0BCShjlEDv8btAcl37cxL+2Xt7eSVrBE6y1/0sjpKdploCk5b3+KWGFJrXrBcsV4IXBNefCWOHgA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103599; c=relaxed/simple;
	bh=ScMokjX/7gOoPAf4P/UeITBMJOFCgt9up4D1pgTystc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BfqxGWpcnWgidKJI6trsBjEYqPXRrXsNleGNhZlUTkhfP0iRC8AKrEOteUxGH3JgSVEKNXA/o3Uitkx6YWCHbDnmkMmg0K9/YLWMGQfypLXRDlAXq35FkSZkCeHviZTc1/pZ2AShJqD5vfUjNUzTwU2fx8ccgsxHXbw1R/YRXT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VVXCmN2o; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VVXCmN2o"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42565cdf99cso6041285e9.3
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103594; x=1720708394; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+XcHt72PqD48gjXmTjJ0nKJ4gTlxCsTMHGoaMCYVc8=;
        b=VVXCmN2o/ZJA76J4wBy9OQYFjdix2ENWVkYRPCXJyZm8nhVhqGPBDJ5zkNlsjk1txg
         p2kZbCvMG8H587jbmbKor494w5+rN9qBDBMLoVp3punJC1wIewlV20TFlrHT2MOy193/
         YFb1Pck/GjEuR83KbkFc8XAe+BktMZOxFS76PlSEQQ3JueUvus4VaItZhCapX7N10e2U
         DkfTCp/g00ROoWUiPOpHWBXC9DI4tXAZZILECggwYWN5/wrEPad83mYHh3rFPEx2I2G8
         uPG7aJ26TOa3It3vKYYL632PBxtS4WcwJgpE0j4xRSYQG5BbuOE1kiqEmbGi6TXPbzJ6
         BGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103594; x=1720708394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+XcHt72PqD48gjXmTjJ0nKJ4gTlxCsTMHGoaMCYVc8=;
        b=eikd9PprMqR/I5woAYOkQoLMFzIyS6VKuQ8dmbQZzARzj+FpAjxAnI2G3Tqcr6Akzc
         aPpuODc77PuZoLzkpay7FKCgrq3dwdiHRMfDZb3/dNVkReMTcOww5p7VHkEc1GscuV//
         m7k3ttR+dsCBi1bb1uTA6mcy0zhGIygj0PlEievnRDEG8Dsnz5kuy1IEfbrxAkfm5QYF
         ln+muyxkbAjQK4cIO3xmiJTRgysq63/zjCBNrlJBG1A0Ofyls/SISFIQjacJO9nMAZwS
         AbUDp4RDD0pd4Dm6HxYnEgavCsLKE0EUV8L0OfJuLnccPIgUzmksRHOpQbBDZmY7lzlB
         rduA==
X-Gm-Message-State: AOJu0YzgwvfN6MFoWlV3hD10mYN2zzbriLZduBUzi7LydGuFXf/unUSV
	D6hsMd8Lb91kMuUVSyGVODp5TcLT8ZgasdEpHMb+IAwIxJAkU9Xu3yFC/4GWb8qYjkE2QgdfXxK
	ywqk=
X-Google-Smtp-Source: AGHT+IFepNjVAxi9b2oVoQS2eiQk6dcO17r2Is4fGu8gu10nX4CTpCNUfiYG0RGCgKN5fYj/tysr6g==
X-Received: by 2002:a05:600c:15d4:b0:425:6927:5f4e with SMTP id 5b1f17b1804b1-4264a41e878mr19179955e9.37.1720103594069;
        Thu, 04 Jul 2024 07:33:14 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264879f1b5sm16251735e9.0.2024.07.04.07.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:33:13 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 00/19] virtio: consolidate vq info args of find_vqs()
Date: Thu,  4 Jul 2024 16:32:48 +0200
Message-ID: <20240704143307.1212454-1-jiri@resnulli.us>
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
v2->v3:
- added proper struct description comment to patch #4
- added suggested by tag to patches #4, #10-#17

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
 drivers/block/virtio_blk.c                    | 20 +++---
 drivers/bluetooth/virtio_bt.c                 | 13 ++--
 drivers/char/virtio_console.c                 | 43 +++++--------
 drivers/crypto/virtio/virtio_crypto_core.c    | 31 ++++-----
 drivers/firmware/arm_scmi/virtio.c            | 11 ++--
 drivers/gpio/gpio-virtio.c                    | 10 +--
 drivers/gpu/drm/virtio/virtgpu_kms.c          |  9 ++-
 drivers/iommu/virtio-iommu.c                  | 11 ++--
 drivers/net/caif/caif_virtio.c                |  8 +--
 drivers/net/virtio_net.c                      | 34 ++++------
 drivers/net/wireless/virtual/mac80211_hwsim.c | 12 ++--
 drivers/platform/mellanox/mlxbf-tmfifo.c      | 10 +--
 drivers/remoteproc/remoteproc_virtio.c        | 12 ++--
 drivers/rpmsg/virtio_rpmsg_bus.c              |  8 ++-
 drivers/s390/virtio/virtio_ccw.c              | 13 ++--
 drivers/scsi/virtio_scsi.c                    | 32 ++++------
 drivers/virtio/virtio_balloon.c               | 32 ++++------
 drivers/virtio/virtio_input.c                 |  9 +--
 drivers/virtio/virtio_mmio.c                  | 12 ++--
 drivers/virtio/virtio_pci_common.c            | 48 +++++++-------
 drivers/virtio/virtio_pci_common.h            |  3 +-
 drivers/virtio/virtio_pci_modern.c            |  5 +-
 drivers/virtio/virtio_vdpa.c                  | 13 ++--
 fs/fuse/virtio_fs.c                           | 22 +++----
 include/linux/virtio_config.h                 | 64 ++++++++++---------
 net/vmw_vsock/virtio_transport.c              | 16 ++---
 sound/virtio/virtio_card.c                    | 23 +++----
 29 files changed, 242 insertions(+), 302 deletions(-)

-- 
2.45.2

