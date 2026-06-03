Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD543E5A2E
	for <virtualization@lists.linux.dev>; Wed,  3 Jun 2026 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511954; cv=none; b=NHhQgMFKhWWwVzLBvHCri1wslonYr8iKdBmII8VwALQCqhlY0Sx5obPPfs2pggVUwoa8Ne4G166d1nuZOf+rdynlundQ8hTHqBp091HCr7idpUV5kQBaDJGsRErHaz//NWK79zp296ic/tjttOzeCWBA8aOUlzb1Ho8rhd0yuMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511954; c=relaxed/simple;
	bh=ymB6v4fxjeHGAHyyQBBzUFLJbQz9tkxCo9VxIY+IdDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cjlbN/TYxueB37q+3kfvNuYXN06LjUN+UWA72pKbEUXb02W/VLqy6lnPptZIm1uq/YLhw49J89K0NJfIldpXa2YYpIzheTIDMMcrzANGOO7RhjFXeqpxcm8N/2L9teaITU9HkEAo2R3kCNmDb81ejqojkE6xitaAIcduciejZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FabqiFnE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FabqiFnE"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf20f6be6bso35955185ad.3
        for <virtualization@lists.linux.dev>; Wed, 03 Jun 2026 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780511951; x=1781116751; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E7ONTJkweAcZcnKMGezhHMuN65WNnCKGBpfevNj/QjE=;
        b=FabqiFnE7qRdKZvJP1bfJ/RHaVgc4ovNJCSAWgovTZsiw0bFZOU7xD6y9WWgE+1RNB
         MjcTr8iTv1xy3vC/TW9XMXsziSwzEP3afjNSPXglN+Sou8/6Juq0ysjkCQmPim166EbP
         9yBskd+uBwSDXdltL0B40Gtq81ST5lcMgdrjmmCrw9Q2M4msZfDjqlQxac5P26TmnrAg
         363KgkuTJfMJeGis+jc4v/k8e+VTweQ7G0aJG8u/CL4+9Lg905LvQ6ADRnVZtbvq8iY1
         Lm3W/30QGXm9oew4f5rDgMHpFkkZ999BkcultEZgtB1pPVzkZEecz24LKVT4DkbWZbLO
         rqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511951; x=1781116751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7ONTJkweAcZcnKMGezhHMuN65WNnCKGBpfevNj/QjE=;
        b=ElrWkEPF9jgeN9PbNuW4kQOaYK8Ti/ct4JzdSmTCDNr0b5m2TweY7D0/sOQOsnAZYP
         b2ujd1nykEIHdFbQonUZ5chabM9C3mTbl60Zxt6IQzHrTsVmYIso527Pig6//2xB8rzB
         PES71FqWPx039bOewBsBHs7OLwOMXJWIQgPeRk+e3MLl/uGfaUjS+KSl862WLvUw05EO
         k20vSfl+AY8Tc/QDCGFT2DHop9awlCZdhM/40PnJkxo2CZd9cE/44LElijz0x2pi+iR8
         XDx/2aCA7rPHyL0q9Dw6JzKDhFj6XgqSpygUZn6xn+4v4YT4Zqjzq0LqY0IzoYFIPtsp
         RAnA==
X-Gm-Message-State: AOJu0Ywb6zACrmqlbtT4SJM2S3f4ALBeu1GGE/FUDCISQU0MlAXOx8D/
	1Gu7epNRKiugbs5GQutflOLjId7ye9vS+bLBt8B5orLjbB/slgWgRR55
X-Gm-Gg: Acq92OEdLP58sjBS0GIXjm1XHscraMmm13wfFZT8QybpKlGltnO/SEW1Xdywy7D2rxt
	6630iE5s0LkwlE3FwPkmC1+0t9+acokBRZKU7kmc3u79XxRB6FCCiYHoNinHWvTVzOhqpn5DPiZ
	VzULw5qzlWdyiepLGYnij1NqKKoUeCUXsjy3Ko9YFY7PU2hLXAl3GiovBNUZ0d+9dJuhd146Z+3
	fDj7RkXSP8ol03glx1A0bYBRP21R9di2xZqJqsrDeYCS4jrGEo8EBEhfKtIZOe0NEGGDK3L407/
	s5cOxsEXNoz76sPYxrO5gq2X4lSegnK5TXUTPxEbM/jJdFt3ANPmLALshDadojUod7RosekYiLu
	jXTMgGTmoIFxY+XYQrXCLu+2zYACsH6Uib1Ko4ITGPgO+7XSKKA6UyUocxlq55TVylztqCoc8cu
	WOIu/0s8RQ1LOyuDBvSUwE51LUiQjjIu6XTJklYNospjVV+5VZzhcoCw6zwww7z5WCbh2STrH0s
	N4dirm80jgWfofctVeBCseHMi15ChAhtbkLwg==
X-Received: by 2002:a17:903:288:b0:2bf:1486:e6ca with SMTP id d9443c01a7336-2c163d61cbemr51934235ad.12.1780511950513;
        Wed, 03 Jun 2026 11:39:10 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649c01asm32764915ad.74.2026.06.03.11.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:39:09 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@gmail.com>
Subject: [PATCH v3 0/4] virtio_console: fix suspend/resume and hot-unplug races
Date: Thu,  4 Jun 2026 03:37:53 +0900
Message-Id: <20260603183757.21587-1-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patchset addresses several critical race conditions and memory
lifecycle bugs in the virtio_console driver, primarily surrounding
the TX path(`__send_to_port`, `put_chars`), device hot-unplug, and
PM freeze/restore.

The initial motivation for this series was to fix a race where
`hvc_console` writes (which can remain active during suspend
if `no_console_suspend` is enabled) could enqueue buffers while
`virtcons_freeze` was tearing down virtqueues, leading to a `BUG_ON` in
`virtqueue_detach_unused_buf_split()`.

During the investigation and testing of the freeze race, several related
vulnerabilities were uncovered in how TX paths handled buffer ownership and
stale `portdev` pointers during concurrent hot-unplugs. Because these fixes
structurally overlap in `__send_to_port()` and `put_chars()`, they are
submitted together as a single patchset to avoid merge conflicts.


Patch Summary
=============

 1. virtio_console: refactor __send_to_port() buffer ownership

    Refactors buffer ownership in `__send_to_port()`. Previously,
    `put_chars()` would allocate a raw buffer, pass it down, and `kfree()`
    it immediately upon return. If `virtqueue_get_buf()` returned an older
    completed buffer from a previous non-blocking write, the newly queued
    buffer could be freed while the host was still DMA-ing from it.
    By transferring ownership of a `struct port_buffer` to
    `__send_to_port()`, we guarantee only the exact buffer returned by
    the host is freed.

 2. virtio_console: fix hot-unplug races in TX paths

    Hardens the TX paths against concurrent hot-unplugs. It adds
    `READ_ONCE(port->portdev)` checks, bails out cleanly (returning `count`
    to prevent `hvc` infinite retries), and synchronizes `portdev = NULL`
    in `unplug_port()` using the `outvq_lock`.

 3. virtio_console: fix control queue race during restore

    Fixes a race during `virtcons_restore()` where filling the control
    receive queue (c_ivq) immediately after `DRIVER_OK` could trigger the
    control workqueue before the driver finished restoring port states,
    leading to list corruption.

 4. virtio_console: fix race between hvc put_chars and virtqueue teardown

    Addresses the original PM freeze race by introducing a `pm_freezing`
    state. TX paths now safely drop output while freezing.
    A synchronization loop in `virtcons_freeze()` ensures all active TX
    threads have drained before `virtio_reset_device()` is called.


Testing
=======

Runtime-tested on arm64 systems with `no_console_suspend` enabled
during S4 cycles.


Changes
=======

v3:
  Split the original monolithic patch into a 4-part patchset for better
  logical grouping and bisectability.


Sungho Bae (4):
  virtio_console: refactor __send_to_port() buffer ownership
  virtio_console: fix hot-unplug races in TX paths
  virtio_console: fix control queue race during restore
  virtio_console: fix race between hvc put_chars and virtqueue teardown
    on freeze

 drivers/char/virtio_console.c | 177 ++++++++++++++++++++++++++--------
 1 file changed, 137 insertions(+), 40 deletions(-)

-- 
2.34.1

