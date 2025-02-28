Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0241DE2C7
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Feb 2025 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729545; cv=none; b=b2TiEd3jVfrZGG2W2c6ELiqP7sr77wvdn5JJ69DZp8MP9plZWYy1h9y2/ZX3Y9CdCCajJFodXqu+SZmyT/2ATlKjJtUUDw0Wa+PclI3kE33l16z9Z3Sr9LLzFMB5UTyWRo4QX5qVaT1V/DWKrtC1Io/HrQCDNvPUk0JXtseYgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729545; c=relaxed/simple;
	bh=4nEG4dQa9iUzcHtN9a84NI2JKhWt96F/Bn6sKNrBOG0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=EIVOCNr7Y2iUZy7e954CArhh65jjrL4tO83kocNsmXOIEGR0aRlLtFPmTnBfCem5CCBI0caRRRVUHcA3EeH/FioPsrVhY0o/LcnYjmkmAfrzYY6ZywMwCUoJRZBDpsUwULJ5PjaEEHMSb/58FXIdjlF1UM+2saW23NqSuAfrXhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=NW/skLnz; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="NW/skLnz"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 99AB94043C
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Feb 2025 07:59:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vh4IobFTwD-b for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Feb 2025 07:59:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BF1D24000B
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF1D24000B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=NW/skLnz
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF1D24000B
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Feb 2025 07:59:00 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-22349bb8605so36719045ad.0
        for <virtualization@lists.linux-foundation.org>; Thu, 27 Feb 2025 23:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740729540; x=1741334340; darn=lists.linux-foundation.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fHii6osorRJQXx/ZnOpfs5YFL5tumSc91k0n7WT/jqA=;
        b=NW/skLnz2W0mfymUcAiwwdFLBH/ictXwdZyoqAnl2N0ioimFydygoFWjHRWvFWS+rC
         1NGm/mXPL/TXx897kBAid0r67zwS6Xc8kB8Z+ejZYMcT9qCX/8yYyEgh4lBRFzLgBN/g
         7CfF52vIeyeI0iEW0b2ESgZ2BHENnqPxwePjZbw10JIUVCmEdKNd1UGpRsL9H+q/sW+H
         JL6id96GFG/ziRZy42TkuHv9ZY5YbRYLcGgzuR9mxf8KsqrhwpA3VADE2iqDD7wotyIo
         QpICd9/B0BTf2F5ErjxEquwXvdx39IaTJop5mzSNY2W7kjM5HpzJX7Ms97w7EEnpMdzB
         kr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729540; x=1741334340;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHii6osorRJQXx/ZnOpfs5YFL5tumSc91k0n7WT/jqA=;
        b=ah+lq5LVklVawImj2GU1hc5Gu28ox/MYgkkxkHBpirFgKIqoSD00g14lw4BK1W3j8a
         ZeN9uplS9gRqSAlU7wziov52BeODs1lg5/YWNXwSkdx/iocphaIJKgmZqff06VMY8QKf
         D8EMdAjpVpLxErjjhlagA2mnlLovn91fdVg0mvoHG78duNpiyd3SX0L9KaMHs+NtX5pt
         1LaQGqXS+U5Z0eegD6/63d0xFbK/O2HqRKj7nmQnfANIirp90Tob6ls3e17uUIqoXlNr
         QqiAdIMx/PZ1wpeJLDKoN4EBCl9xFNMefgqHCDovRFO9ETKnmIMc8SnM+vpjorMT/hSF
         hEBw==
X-Forwarded-Encrypted: i=1; AJvYcCVVCpzWOjfiBNe164fVz89aeehh5ichhfszAu1Ad4M/X3l/+JinQWtJ15ml3kF/+zXUxaGbaNlMa3DFDXSUGg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzHmafM6ND3X3rlmm05FoxZF8ZvO5tg0ruMjDmoXpDiXRVSbt5b
	IxZ686d+BBmJyXCgvQulxa2HvI/aGGAYgLo2hZAnRscBEQmxO9lsACp8xYc6bG2RlRlCWh6l2Yz
	DIuA=
X-Gm-Gg: ASbGncu9x244zplI88HzvFPL4zlWvUSIuXPFmN4Vf2i6svri/fXCyhkSnPf53azlJtl
	3u9gqCFsVpfAXpa8gAPF5a2P5FJp+pvk9Ru1Ybo4CUyajHYHmXi4b8j6qO1wQSGAS929RcuOH2g
	/71qjzu2UlVtRhLT7pNVasfLeiMuZJgwLUru4SW65HEN9nQVFT+0687tPns0Tlli9Q8tgMui+4C
	LcLurVg3kqSWmRZachqyZ0pWhi8guK5JOFFyZoAhbKjStcv3XdZKpoNsQ6W2e3dmRkV0WK+m6AO
	9sMVm/QtVXq9wAHZ0YvxZ7UAdQFOUQ==
X-Google-Smtp-Source: AGHT+IEdlXioAUsEy2VjDZ5O865zmhvVYGdC7Nj/tdHBiMSrFhxj1TlLd05OwC/C1bWSfZUhN5yZWQ==
X-Received: by 2002:a17:902:e54b:b0:21f:7880:8472 with SMTP id d9443c01a7336-2236924fa13mr39977565ad.35.1740729539710;
        Thu, 27 Feb 2025 23:58:59 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a003eb97sm3180799b3a.148.2025.02.27.23.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 23:58:59 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next v7 0/6] tun: Introduce virtio-net hashing feature
Date: Fri, 28 Feb 2025 16:58:46 +0900
Message-Id: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZswWcC/4WRwW7bMAyGXyXweQooiaIkn/YeQw+WRC1CUbu1n
 SBBkHcv56xFhhx2E6H/+0n+vHYLz42Xrt9du5lPbWnTKIX/sevyYRh/s2pF6s6AQUCwal4Wxd7
 6EiLXwftOlO8z13beXH51I69q5PPavcjPoS3rNF82+5Pe/sXJaoAAzmjQe42Ixiithtd2aK/Tf
 iry+lmGy9jO+zy9bT4n88Bqp1ET4t4QENJ/WfvFIkTttg1OVoHKZEHMSoJgniB8gAzeIRQoIEd
 rOANTfoLcN/RnwzvkBKo2VwqlArjyBNEX5EBDvEMkUNI5wlA8hEr/QLd75DN/HOVe69/cv8/V7
 7YBjAW1HkdFxBoGjAmy76XZ42U3qbTVpNKxVp4XFUWOqUrQNfcSu8jTsLCSzm9t7XelBOudr8Q
 UaDA6hBh9Ti4kF72rHjEl7wPJmLdPMoDyj14CAAA=
X-Change-ID: 20240403-rss-e737d89efa77
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

virtio-net have two usage of hashes: one is RSS and another is hash
reporting. Conventionally the hash calculation was done by the VMM.
However, computing the hash after the queue was chosen defeats the
purpose of RSS.

Another approach is to use eBPF steering program. This approach has
another downside: it cannot report the calculated hash due to the
restrictive nature of eBPF.

Introduce the code to compute hashes to the kernel in order to overcome
thse challenges.

An alternative solution is to extend the eBPF steering program so that it
will be able to report to the userspace, but it is based on context
rewrites, which is in feature freeze. We can adopt kfuncs, but they will
not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
and vhost_net).

The patches for QEMU to use this new feature was submitted as RFC and
is available at:
https://patchew.org/QEMU/20240915-hash-v3-0-79cb08d28647@daynix.com/

This work was presented at LPC 2024:
https://lpc.events/event/18/contributions/1963/

V1 -> V2:
  Changed to introduce a new BPF program type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v7:
- Ensured to set hash_report to VIRTIO_NET_HASH_REPORT_NONE for
  VHOST_NET_F_VIRTIO_NET_HDR.
- s/4/sizeof(u32)/ in patch "virtio_net: Add functions for hashing".
- Added tap_skb_cb type.
- Rebased.
- Link to v6: https://lore.kernel.org/r/20250109-rss-v6-0-b1c90ad708f6@daynix.com

Changes in v6:
- Extracted changes to fill vnet header holes into another series.
- Squashed patches "skbuff: Introduce SKB_EXT_TUN_VNET_HASH", "tun:
  Introduce virtio-net hash reporting feature", and "tun: Introduce
  virtio-net RSS" into patch "tun: Introduce virtio-net hash feature".
- Dropped the RFC tag.
- Link to v5: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com

Changes in v5:
- Fixed a compilation error with CONFIG_TUN_VNET_CROSS_LE.
- Optimized the calculation of the hash value according to:
  https://git.dpdk.org/dpdk/commit/?id=3fb1ea032bd6ff8317af5dac9af901f1f324cab4
- Added patch "tun: Unify vnet implementation".
- Dropped patch "tap: Pad virtio header with zero".
- Added patch "selftest: tun: Test vnet ioctls without device".
- Reworked selftests to skip for older kernels.
- Documented the case when the underlying device is deleted and packets
  have queue_mapping set by TC.
- Reordered test harness arguments.
- Added code to handle fragmented packets.
- Link to v4: https://lore.kernel.org/r/20240924-rss-v4-0-84e932ec0e6c@daynix.com

Changes in v4:
- Moved tun_vnet_hash_ext to if_tun.h.
- Renamed virtio_net_toeplitz() to virtio_net_toeplitz_calc().
- Replaced htons() with cpu_to_be16().
- Changed virtio_net_hash_rss() to return void.
- Reordered variable declarations in virtio_net_hash_rss().
- Removed virtio_net_hdr_v1_hash_from_skb().
- Updated messages of "tap: Pad virtio header with zero" and
  "tun: Pad virtio header with zero".
- Fixed vnet_hash allocation size.
- Ensured to free vnet_hash when destructing tun_struct.
- Link to v3: https://lore.kernel.org/r/20240915-rss-v3-0-c630015db082@daynix.com

Changes in v3:
- Reverted back to add ioctl.
- Split patch "tun: Introduce virtio-net hashing feature" into
  "tun: Introduce virtio-net hash reporting feature" and
  "tun: Introduce virtio-net RSS".
- Changed to reuse hash values computed for automq instead of performing
  RSS hashing when hash reporting is requested but RSS is not.
- Extracted relevant data from struct tun_struct to keep it minimal.
- Added kernel-doc.
- Changed to allow calling TUNGETVNETHASHCAP before TUNSETIFF.
- Initialized num_buffers with 1.
- Added a test case for unclassified packets.
- Fixed error handling in tests.
- Changed tests to verify that the queue index will not overflow.
- Rebased.
- Link to v2: https://lore.kernel.org/r/20231015141644.260646-1-akihiko.odaki@daynix.com

---
Akihiko Odaki (6):
      virtio_net: Add functions for hashing
      net: flow_dissector: Export flow_keys_dissector_symmetric
      tun: Introduce virtio-net hash feature
      selftest: tun: Test vnet ioctls without device
      selftest: tun: Add tests for virtio-net hashing
      vhost/net: Support VIRTIO_NET_F_HASH_REPORT

 Documentation/networking/tuntap.rst  |   7 +
 drivers/net/Kconfig                  |   1 +
 drivers/net/tap.c                    |  62 +++-
 drivers/net/tun.c                    |  89 ++++-
 drivers/net/tun_vnet.h               | 180 +++++++++-
 drivers/vhost/net.c                  |  49 +--
 include/linux/if_tap.h               |   2 +
 include/linux/skbuff.h               |   3 +
 include/linux/virtio_net.h           | 188 +++++++++++
 include/net/flow_dissector.h         |   1 +
 include/uapi/linux/if_tun.h          |  75 +++++
 net/core/flow_dissector.c            |   3 +-
 net/core/skbuff.c                    |   4 +
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tun.c    | 627 ++++++++++++++++++++++++++++++++++-
 15 files changed, 1231 insertions(+), 62 deletions(-)
---
base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
change-id: 20240403-rss-e737d89efa77
prerequisite-change-id: 20241230-tun-66e10a49b0c7:v6
prerequisite-patch-id: 871dc5f146fb6b0e3ec8612971a8e8190472c0fb
prerequisite-patch-id: 2797ed249d32590321f088373d4055ff3f430a0e
prerequisite-patch-id: ea3370c72d4904e2f0536ec76ba5d26784c0cede
prerequisite-patch-id: 837e4cf5d6b451424f9b1639455e83a260c4440d
prerequisite-patch-id: ea701076f57819e844f5a35efe5cbc5712d3080d
prerequisite-patch-id: 701646fb43ad04cc64dd2bf13c150ccbe6f828ce
prerequisite-patch-id: 53176dae0c003f5b6c114d43f936cf7140d31bb5
prerequisite-change-id: 20250116-buffers-96e14bf023fc:v2
prerequisite-patch-id: 25fd4f99d4236a05a5ef16ab79f3e85ee57e21cc

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

