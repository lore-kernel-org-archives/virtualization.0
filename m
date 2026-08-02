Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199822FD1AA
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785692469; cv=none; b=UhqKJYEnTcpi0IBInG9IvJAy5AxXc3XAzDsHhLeSV4Kmm70Q73vqaSh2HLaSOBCx1OErceBw4+DrbcBNY0ZoQeaSRTGY/EDwGzXu9NJ6zb6QRcEkbergVJpXHc/OgDXpxN6HLWsXLc7Mwn4b97UWeQ/qT8gNq+LSI6m9+q0yR/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785692469; c=relaxed/simple;
	bh=+sHOuiEKdmN7kggP5XmVsNhd4Cg9BqyZp850cgx5e0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDT/mDMkwQ0P4Jb5vy+YKijDnbryDRKp4ZjkColqkvX891ZJ/dGmp6naiQTaFdI06l7AVHzOmGmge3sjLgGXBtEokPJUMFJSY6E7+AJHLvmVHJJBHHg5jmDpLEIFecYKYqt+yU1CKyBFcU4HRJhOtRFAMkly+ypmWiSc5YFTpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKGFvECr; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKGFvECr"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so2419700f8f.1
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785692466; x=1786297266; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xnNxxsVYMueQ9ZVEcfqJaMYgAmu+seV+sc4sUnFKJdQ=;
        b=dKGFvECrHXDhfi4bMnOIupzWlnLnpFi1WL4vyluoGmpsfw1InmycUlBS/iaho/cAsL
         rvERJIhkx2xtxHA0xXPq/s+qnZfATloewHggZJOY0xa/2qxY++uUXnRqAAkv3rfMuVlF
         1pBRiZV/8BUWJCiVMmKSIH+42N+1SZRHG9OwEaxUCKusk5CVRELojz2863i8NamLACM8
         f/hGMhVliATL9A4YOiwf6CZPrXwEXKtcaU4blB8LsiOa09zNYPojLqDZQYxnfoWrHRon
         KyUXTSzPRXOmba8zYGkSqX9+gGM2g4QpOLW0OmWZWGyZp6aBOCS5/kakpDaDMmKdlgG0
         u21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785692466; x=1786297266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xnNxxsVYMueQ9ZVEcfqJaMYgAmu+seV+sc4sUnFKJdQ=;
        b=UDVdNczLq5AvKU+1cpkuJ+ylnu49DrsVKXfcoOPVr9Gd76FQO6Ygvnl2K/WxuA7J3J
         0D3rf+dOD5YTRfgNvhR/h1aXdEwpN4oO1FHJwMLCo2T4GmhK8wnNUjzSUsAuu/RPJ4PQ
         wzulVg1r4FrANfA/LZAKhVmCArU1JTJ69sqebmJZ0VGTQUK+wNVZokygyLWB384rqiHH
         oO+0O2mR4KYImRF+ghlddth/QGOP9FI3Ci7SS7TpCpxNK1HaShDdE6Qydbt5hsJ1p4B1
         KV0Lnu4JAw2JoN4LS4CsO7srcQLCK45bbK9SERchBOiqqaHHPiSNIoFxaKBok+pdCCft
         i7hg==
X-Gm-Message-State: AOJu0YzQhTiqrDzew1wIr5o+TFOOvovR5/nQ/gI00OBnrWzehT23dh7J
	0dAZht0aU5bxIYprczdnzipvEpqE0t+4ViEuwQY1eUmzCX8T7ELD4Kk1
X-Gm-Gg: AR+sD10E3zyP09P0eBCgGIksD3pttnymdmBIcys4MyQ7OfXpvUinDqgVdEG3/Rujws9
	BOJhbLTBk3B/Pr6oDaGEl0JknMo8kIk2iWHkHdJPEww6PcP/OudZiTVgc3DEEP/ad3xxWwTXkoS
	H45obv/PY/s4+YwV9Fo0wUPH59/Yon9BkZb5Z1XJxFfyVYTy45xQh5TU+je133UunfjnVu3i8LR
	VHLaCKcRWwFi5cpiUeXr2Dl9Z5ur/5E2DJWW3mkOACDBJvCTEOSP8U6lml1NfqkXQYzMc9tlzBv
	Qpge5akd0dNKDdpYM8Sr3o8+djHjvrfip2/Y5TRNRKbuZE9fTcy3+QyTdiplqAuYwvNq9rIURpm
	hR8vTgHNQ9jlZVS8LwQ4vanr+fdT5Kc1nzsoUoaxfUOCM2cXgX6+Vwt1uzuTfQkOerVLTWug/ah
	3adTZQb5oiJ36QcLYjTkG4ZviwLdkvd6nleyWd3X+gOvnjjX6qpv9D5Ghaf3jx9bd5gHnH8NU4g
	ped3FB7B8MOmRj0oaljanEp3PvAYCaWENaDBiidJ8bVv6EBvrYhebP7
X-Received: by 2002:a05:6000:4714:b0:47f:90a5:be77 with SMTP id ffacd0b85a97d-47fd729e7a2mr18317658f8f.6.1785692466267;
        Sun, 02 Aug 2026 10:41:06 -0700 (PDT)
Received: from a9d4faf53c34.fritz.box (dynamic-002-214-008-136.2.214.pool.telefonica.de. [2.214.8.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458ab61sm25607861f8f.25.2026.08.02.10.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 10:41:05 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH 0/2] virtio_pci_modern: fix vp_reset() hang on unresponsive device
Date: Sun,  2 Aug 2026 17:40:57 +0000
Message-ID: <20260802174059.4082-1-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While investigating a syzbot report of a WARN_ON_ONCE firing in
virtio_dev_remove() [1], I found a related but more serious issue:
vp_reset() in the modern virtio-pci transport can hang indefinitely
if PCI_COMMAND memory-space decode is disabled while the device is
bound (e.g. surprise removal, hardware fault, or -- as reproduced
here -- a direct write to the PCI_COMMAND register). The status
register poll loop has no way to distinguish "device still resetting"
from "device unreachable," so it never terminates.

Patch 1 adds a VIRTIO_STATUS_ERROR() check that recognizes an
all-ones status read as invalid (per spec, bits 4-5 are reserved and
can never legitimately be set) and warns once at the point the bad
read actually happens.

Patch 2 uses that check to break out of vp_reset()'s poll loop
instead of spinning forever.

Reproduced on a modern-transport virtio-blk-pci device:

  # printf '\x00\x00' | dd of=/sys/bus/pci/devices/0000:01:00.0/config \
    bs=1 seek=4 count=2 conv=notrunc
  # echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove

The second command hangs indefinitely without this series; gdb
confirms the CPU is stuck in vp_reset()'s status-polling loop, with
vp_modern_get_status() consistently returning 0xff.

[1] https://syzbot.org/bug?extid=a1c8effc62c569d4bd25

Abhin Parekadan Jose (2):
  virtio_pci_modern_dev: warn once on invalid status
  virtio_pci_modern: avoid infinite loop in vp_reset() on invalid status

 drivers/virtio/virtio_pci_modern.c     |  6 +++++-
 drivers/virtio/virtio_pci_modern_dev.c |  8 +++++++-
 include/uapi/linux/virtio_config.h     | 16 ++++++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

--
2.51.1
