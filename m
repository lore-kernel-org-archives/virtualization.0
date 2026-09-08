Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1A836F8E9
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845983; cv=none; b=cvIF6zADp/h+JjFoHCAuSKlYesuzMSrfIN96QKN15QFhMt9E9r5CULFtYr2KWG+dfQHGhucNQEgPaIFm52ORwFiju9j+sxIcTlxnXlgOz7swbtz6Ic5pHx7xot0+xHLiKPETddbNFsz14M2YzC2yr326+L8mmMfh8ncNpOFrDb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845983; c=relaxed/simple;
	bh=TCgPEL0DIPtoJrnu9N8c+v3mKdDbypOHTaZzZn4UrHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f15E/MByp1hNNJbAJLWG4TbPxc40uBkUezwpVzSgVvFB7x/3BzeeIo2J9T6AIJw2JjzzPVGmMYZxI2Q2j7HyrvnBhxKbTWT3/2SPPVC6qO73LIFm7sHkWsaA4SaPW788AiLr+zQsspaBo4hQiKENYFlmB2WYsViKCoBEn16SqaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beCHeHp7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beCHeHp7"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-485850cf499so2719939f8f.3
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 22:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845977; x=1789450777; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=69M0Zjk6fuHd53vao9gFafQcNB6wevMJ2l/Q6J8x1Ec=;
        b=beCHeHp7a8promAVyCwvkV+Q3akRmMx/XXYPdexzTD9HIKTqoBM4dfE8+rZYYD9fBe
         1q8L8lq6coctMFCE7OKhOyEYK9K/xRyVRfzAMyen/LOp9F3FAL6uP4VcMDdB2X9tbJte
         xxM4FvGhBVBsd12w+jBrUe4LR7GTSMZdtAbA8o2q+iaNJDPUrtBLF9Fg6Be76joG/KLx
         /FLt3UkSwESQKcMdT7gGoU0MYYP0guLkfL+9pOJU8SyLnctesZigZj4P4+XCXYi7FvR7
         JhiFOmPjlYwvSJpAXpwMxfnEa8jX3p2kjvpDUXv6pVpavhr/LByiiL/YuxbcDYb2Pv5g
         lBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845977; x=1789450777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=69M0Zjk6fuHd53vao9gFafQcNB6wevMJ2l/Q6J8x1Ec=;
        b=DZny2uYsnmzgWSUGpuf5p/v3u/KvvFZ4yEpGBksUL3Xvtl3tKWQ75W8sgek9RzNpnV
         9wjo/Q1eGzQErIEs6WbutCB58NXNFNi+D0JD/jEsDPOSJYUHf6G50gZB769P5iMaZ4Bq
         4lk0t4ZzbGXD8pm47YFqYxsM4S9XBwtYIabVZgD8l81va8S63CMFBzZnn1tNTbyKxQwP
         TxVBocplDVagjnTLFUuEocwj/vp6i8ZBJil/auchTVWQuUAXUpUVo1c2QCUerlHWpGvW
         GQxM4PJgLMTANzNiIPTGv2vQTWCZks0Lm4pLvRXRmVibZf5e549aOaHot5GoS3+SwAr8
         8myw==
X-Forwarded-Encrypted: i=1; AKwUvByUEk2t9sGVYU1h4hcNVnQuU4D4jJkVbgXPTBKuS+hYuPqU9rz35q7yxgPFdM2oQPjB3ztcplcdNITmOIKN+g==@lists.linux.dev
X-Gm-Message-State: AFuF++m/AMTByRsc1HevEro8xCuggOuVNAL7YzHLas1ZNwPceS/+CE1P
	Ta+gj4YPmTbOs40xTVGOQ8yds92P43PV4DzR3acAlMMT+bv/unH+X2H4
X-Gm-Gg: AYBFou1ysYmUfcpzJFjt4OIM/8nyyBNm7QVcUl86duUh0QY93EE4I10peol25dXQdBL
	U6LAhXA+RKhJXkcC7UwrC/hnRSlZHKbreEoTtwItMDiuXwfwy0NSWrVAwuS/6uUtZ9xRC9znipS
	5FVgpLboN7FP9KLUncbDA/gEr/F6p/66z4ovyxxJu7bbgITxOgJ0gAlCUmNe6uKSknSnjXXxlEl
	cFeuRUu7wjhp7m+qL4GjBPyqbPcj4kSdxwWky1fU/hH/cx+gM7a2U97Xz9Gfsx6Xq2Mrb8LscT9
	4oSGFQSAETIzvCOFIsswHvWMnaV5tBpClp5+MzIl1pzVfID1/tF9rKSGmiIJNAYxId0wS/84jqV
	d4k9eb6UTMNaVpkVrseuoKcY5A78okX6kznWDk2dJjSnaCbI1C1ab8RtIfSzVYT2XWnCYpIEucq
	VO2BytsJjHZFfiI/2YGaCGD4Isz6kHPzbmSkd1rVw214qH66c0A7/q46LOhu9aSi4NmYoljv9El
	VKTY3Votz+NOo8mr2qld3rAF+EnA449IBu8y6aJfCz/gzilFUXGh0NuaKNoSENuAKdL0IccMgDH
	TqDdzp4xWKGu/p+9t4aui/bVdmpO5L9MrlinAIjoeQ==
X-Received: by 2002:a05:600c:4e46:b0:49b:910c:7703 with SMTP id 5b1f17b1804b1-49cf823f160mr260148885e9.9.1788845977155;
        Mon, 07 Sep 2026 22:39:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:36 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 0/6] virtio: fix and add callback synchronization hooks
Date: Tue,  8 Sep 2026 07:38:11 +0200
Message-Id: <20260908053817.26065-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the callback synchronization series. It is based on
Michael S. Tsirkin's linux-next branch at f49e6cf91942 ("virtio:
synchronize callbacks after device reset"), which already contains the
core change and the virtio_input teardown reorder from v2.

Patches 1 and 2 fix two bugs in virtio-ccw's existing
synchronize_cbs() hook. After a fallback from adapter to classic
interrupts it selects the wrong lock, and the classic interrupt handler
only takes the matching lock when notification hardening is enabled.
Patch 3 adds SRCU tracking for remoteproc callbacks, which can sleep.
Patches 4 and 5 replace the RCU fallback with synchronization against
the UML IRQ and the TmFIFO callback locks. The fallback already covers
these IRQ handlers and spinlock sections. Patch 6 adds SRCU tracking
in virtio_vdpa so callback synchronization does not depend on the
context in which the vDPA driver invokes the callback.

The UML, TmFIFO and remoteproc reset paths do not themselves prevent
new virtqueue callbacks. UML and TmFIFO only clear a status field, and
remoteproc does not wait for the remote side to acknowledge the reset.
Without notification hardening or driver-specific teardown protection,
callbacks can still start after reset. The new synchronization hooks
do not fix that. The TmFIFO hook also does not synchronize with the
rest of the FIFO work item outside the callback locks.

The virtio_input loop change from v2 (continue instead of break, so
events the device already completed are still delivered) and the
event buffer leak are sent separately.

Changes in v3:
- Rebased on Michael's linux-next branch. Dropped the core change and
  the virtio_input patch, which are there already.
- Split the virtio-ccw fixes out of the core patch, one per bug, and
  the transport patch into one patch per transport. The CCW and TmFIFO
  changes are functionally unchanged from v2.
- Patch 2: added a Fixes tag and described the existing shutdown
  case. Removed the dependency note on the core reset change.
- remoteproc: read the queue pointer once in rproc_vq_interrupt(), and
  synchronize with callbacks in __rproc_virtio_del_vqs() before
  freeing the queues (Sashiko). Place vq_srcu next to rvdevs so the
  hunk also applies to mainline, which added attach_work after index.
- virtio_uml: compare against UM_IRQ_ALLOC instead of a bare negative
  check.
- virtio_vdpa: use SRCU instead of a per-device rwlock, so the
  callback tracking uses per-CPU counters, and cover the config
  callback (Sashiko).
- Rewrote the commit messages. Corrected the RCU fallback description
  for UML, TmFIFO and the vDPA simulators. Dropped the claimed simulator
  reset race: the simulators disable bottom halves around virtqueue
  callbacks and serialize reset with the worker's mutex.

Changes in v2:
- Moved callback synchronization from virtio-pci into the core, as
  Michael suggested, and added the missing synchronize_cbs() hooks.

Testing: the changed objects build with W=1 without warnings, with
clang on arm64, x86-64 and s390 and with gcc on SMP UML, and the
patches also apply to current mainline and linux-next. The runtime
tests from v2 were not repeated on this version: the input, rebind and
shutdown checks on arm64 MMIO and x86 PCI covered code that is
unchanged here, and the remoteproc and virtio_vdpa hooks have only
been build-tested. No remoteproc, TmFIFO or s390 hardware was
available.

v2: https://lore.kernel.org/r/20260905152059.89560-1-kmehltretter@gmail.com
v1: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com

Karl Mehltretter (6):
  virtio_ccw: fix synchronize_cbs() after interrupt fallback
  virtio_ccw: always take irq_lock in the classic interrupt handler
  remoteproc: implement synchronize_cbs() for virtio devices
  um: virtio_uml: implement synchronize_cbs()
  platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()
  virtio_vdpa: implement synchronize_cbs()

 arch/um/drivers/virtio_uml.c             | 10 +++++++
 drivers/platform/mellanox/mlxbf-tmfifo.c | 15 ++++++++++
 drivers/remoteproc/remoteproc_core.c     | 12 ++++++++
 drivers/remoteproc/remoteproc_virtio.c   | 37 +++++++++++++++++++-----
 drivers/s390/virtio/virtio_ccw.c         |  6 +---
 drivers/virtio/virtio_vdpa.c             | 34 ++++++++++++++++++++--
 include/linux/remoteproc.h               |  3 ++
 7 files changed, 102 insertions(+), 15 deletions(-)


base-commit: f49e6cf919425cc55f10fd7cda7e0fc895df4cc0
-- 
2.39.5 (Apple Git-154)
