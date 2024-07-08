Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4904B364A9
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424900; cv=none; b=DDPlPP6TYxjdoyktwdeyWurQ3SeOd1Gt0qzMicyy36LOnvigFApBLjFc8LGUbKEdOLLJCYnJJpZ4fgHcWVicPoDvSu2iaWKNKAjLM3EE15uhV8l49TcGosD0p990xABOnpm8an4Er7HoVQuUvUZMGjSqs4EAUjwh+pJeyscVWo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424900; c=relaxed/simple;
	bh=8ZAYPUsrsqIgdGWK6yObspLNlZwk/n9MZWYyupkvVlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tj+qDOA2RWQbahbgJVRJU2qOsTj/NUE8AAy4b9QJ1V7glgAcENWMi/bb1q1R6kkWsyhoBDh+o+YShgHOfyrD+cJASdEV9hJ1B4TNgiQJ/b7Ma6cNnGkGibyxSYej3mgxQMehgIMJbaV4pNgMM4SgeP4QN6li/U/qXJsJKG3Wjf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nPF3HjfQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nPF3HjfQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42662d80139so7718695e9.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424896; x=1721029696; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ImRxBUc3Mx0xqUIsuXwJUH2z3TRmlvHJ/R6TMwnOI88=;
        b=nPF3HjfQaDwwlUntNyCqw0OuKNNJ4d1JVQD+/5h2JDMydNFUcr9Yb3s3Rvq+ObDhH7
         dM6q8+xDE5x/2nBQ7KnQyaFekwWo0+JQPNmzM9caLn+N9lDjneWUFQwxKFKY6Q9Kxeq7
         lFcUbiJQ10g42o559EtPim4AOYsQRXt3YPckkrbFPFqbf02IOKrheAQH5IuBD7Gp6qjn
         hyoRDb3zqi7Op/LlkLrR6mLSnVJ7wLo5Ydp1SetZg03jwoHdkDAPlNnRf53mxKkMTwe9
         mtKz9wkzIv9dIt0r98D/IuAcKpq+ojukpVT2s6hQwpX0R3wYLG249ZZ0auUiuQ6KoU22
         xTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424896; x=1721029696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImRxBUc3Mx0xqUIsuXwJUH2z3TRmlvHJ/R6TMwnOI88=;
        b=Lxzy7r6Ed0xkeEsh/4cQhP+igI2R6BQyIWjvAMxniu5tcj23c9FASITVUYTeuu5Id8
         Oktf6xg+Nr38BOnv1Iw7ZhRjsVG3qsME5D8qK5Cw7VALFVU8bm5d0ORCk2bwRAZraIxo
         zCnsQbemTuCw9fGcr1GbK30qnQpWAW6vE2eu5HtSQjR16SkpLBHYVIFVARKcMblG97qS
         tM/hamuWXEC9cR2ahXozG1gS6FxD4JJ4yYvM95DxpYyzgqQqOVZLnsqSXSU2u+4K29Mc
         Q81M7S4tR/nHOLNp51bH/G5zhMc/ZZHC65PYzng37OFg+rtNlJ4SXGIVWKuM13vjxJYS
         uFzA==
X-Gm-Message-State: AOJu0YxE3/Kma5Kqr+LsE6OltzYfTjVnnBCDVacYUgEXxv2a96I7bVro
	D5ShepnbC/xl+rJBqbE+qE/2826mpfmAE0hQlMFxM3/5Esk2V9NZFxnAcT77QIkzExXKAPYQbdN
	fsuk=
X-Google-Smtp-Source: AGHT+IHjI4ue/cxuot8Dx7DY6FWDGGgc1V6xmEa8wMomOePF79kCOjIdjj45XTI2ERqz0/5BM7MmVw==
X-Received: by 2002:a05:600c:168a:b0:426:6314:3336 with SMTP id 5b1f17b1804b1-42663143419mr27562815e9.36.1720424896257;
        Mon, 08 Jul 2024 00:48:16 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc937sm155836565e9.40.2024.07.08.00.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:15 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 00/19] virtio: consolidate vq info args of find_vqs()
Date: Mon,  8 Jul 2024 09:47:55 +0200
Message-ID: <20240708074814.1739223-1-jiri@resnulli.us>
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
v3->v4:
- changes in patch #5 and #6, one cosmetic issue, one compile issue

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

