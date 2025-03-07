Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF526AD0
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345299; cv=none; b=qaGmD/nPJb4byGWhrGVBt7P+DyNl92Nh7VMk+Cptu0RL1NS9t02LmvPkHdbn5SVrslMTmBbLOVALi6THlYxWbxNbaUwHFTf1VDC1NTkJOFPot0G+znJDewoFkRt5wKFWmf15UdNL046fP1CaE7aXNNlf1qMyYQrAY1lm81nkDxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345299; c=relaxed/simple;
	bh=/g1GkLCKmv9y6KA7+eQLnMk39ax2rDsN2Scy3l2VLdw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=P07Yjbb6mLFTLsttb+pNmRb714c4Bt2Z18Qz4YuYpKFKR0UJWuNTzDAkmUJaBE8IbeMIXYKCiRPGhXCWDjw/6wEEUjdVqUiJTNpJDCHSjbpyKqMgyyyrpPu5ekYad225YZv/OVDRPU2AL8FaaqlKAQss2zW+yANTX2Eku6WgjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=1DEpvLgB; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="1DEpvLgB"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5D8A413C7
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 11:01:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ib8y5nSiXaZe for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Mar 2025 11:01:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 29D67413C0
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29D67413C0
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=1DEpvLgB
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 29D67413C0
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 11:01:33 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-22423adf751so20563665ad.2
        for <virtualization@lists.linux-foundation.org>; Fri, 07 Mar 2025 03:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741345293; x=1741950093; darn=lists.linux-foundation.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uzMVlPOa3s/zB/a5VwTHDVG6oc6JLPQwIH8h0o1qpiY=;
        b=1DEpvLgBHXOkjuWXA1Xcr7a5P0pa7R3ObDRh6IJAFgJDxx1D6Z0/FqdpxdnXN0qa4C
         9qV6AY8e1fF6LtQCS9TNgCu5bBwr+w+28SxnOmbMuwQPX+Knnie9BjgdYxper8xRMvVi
         UKjJd0lBqphHiXG04cKPCeX4ilSyzkP8mivaxdfp2vasgy+D5zEyaukQs6Yj4EZgKNkR
         IeB7WgB/Khf7EqCk7MJC1UOFKgVjsmdNKCLBpGTxLWP4ouv4kY2XIGR/6Lwhgg9Z0KKP
         rO9jViIYNwuHUBE9K62UZWKPRvihZy0YG9aqb+8nDrvZrpXGCRX+Z5B8qm/Nz3fExO+Z
         Fu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345293; x=1741950093;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzMVlPOa3s/zB/a5VwTHDVG6oc6JLPQwIH8h0o1qpiY=;
        b=cd0DAfwrnFqgTyM+czoJ7yJsXIjsEG1HY8EC4GfwTL6I9z4JKRzzP2CRRUzlk1tNAV
         t6ebDtSYNZL3O6BTeQZKTnou4LQ0Jh59RTTgPhzB8JZiLP8db5NXHzYrIJaXAX87Nfue
         yplQ0RrfptT9QJy20hrEg6Ju+3KE8FeWt+Rt3JBKiOjoY9Vi0w35doppNRF4Ruib2+nl
         ivsZ4SbP282xhBwV9GIS073036GcIMBz2qzNEzEWBoLwx8RLsFo2xRHPQBRGnNCqTEh2
         5F94aFTerxPO3xNas8r2ZpaD7OKGjR+5TESDVj1TYcvfZ1NbtLEdBS5MAUzzLKq9ePfo
         K0YA==
X-Forwarded-Encrypted: i=1; AJvYcCW9bb8lfD+Ign7z8GhP7/iaOPlwz5nbV8c2BW99/StPNNaWT9JUUI3YTKlr5ZSMCmF/5jze+DGzm/JoCc5+Cg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YycStqRGqUwQ0jBnZGSNPRVXJCfTFInK7KmhMutuBAgH9oMcQuh
	QL0nmI+TylMu/aqiQeUjGAoBOh+xO6BP5rrM0gEYB4lB+rREBbTYmKGhRvsva/Q=
X-Gm-Gg: ASbGnctiv50zepzOAj7GaddFsyl7kpghJssL8pkonDIWNK/dLraWCQrW4QQUt8Ic5YO
	UKGDQ6Zrj/t+fmtsgA0Wsd+fPbJIjnckinISPPm9xak1bA+GGQGq5FAZqPjAIjB8rEES/wY94T1
	UDM7tlkFumo1nphYSdmQmF+a5VeK+o1VGX3vorRIZrTn71tQ++sDdA0APdSQY5nITTr8eG90BLK
	az23qMBZ7kJUFaCSwK5QGHnceDeLoKU2/q1xjbyUYlCwFG33xAlSK+5WsIHIRybCAxxfVt4gBpQ
	3kQqSFPY/glUVI1FVpyYvu+/oyl3YogQDVpQ8SQ7jpO3GZQe
X-Google-Smtp-Source: AGHT+IEWkspRFr7qHdskSRCnrxIpvvKyP779SqlsxZvyyYMDg2Rlwude0Tz7fnHYA8IOQruaEpUCgQ==
X-Received: by 2002:a05:6a00:1887:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-736aaae0343mr4694000b3a.18.1741345293154;
        Fri, 07 Mar 2025 03:01:33 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73698206a8csm3054423b3a.19.2025.03.07.03.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 03:01:32 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next v9 0/6] tun: Introduce virtio-net hashing feature
Date: Fri, 07 Mar 2025 20:01:16 +0900
Message-Id: <20250307-rss-v9-0-df76624025eb@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPzRymcC/4XSzW7kIAwA4FcZ5VxGBoyBnPY9Vnvgt4OqJt0kM
 5qq6rvXTfozVQ69gfBnbNkv3VymVuauP7x0U7m0uY0DX/zdoUunMNwX0TLfOwUKAUGLaZ5Fsdp
 m50sN1nYc+TSV2q5rlr/dUBYxlOvS/eOXU5uXcXpe01/k+s6ZtARwYJQEeZSIqJSQIjy0U3sYj
 2Pm058cnod2Pabxcc1zUTdWGomSEI+KgJB+tfrTInhp1g4uWoBIpIGT5QhO7RDeIIUbQkYOi9e
 qJCiUdsh8ofcON2QYVZ0quVwBTN4h+kQGJPgNEaMok4eQLbhKO2S/kVIfP9m1PFRgUow575H7R
 hpoQ46RDRGroVpR6R/odRvuVP6feTOWjwl/LUZ/WFtVGsRyHgRRkRDQR0i257Zud2gN5QYliXi
 utUyz8ByOsfJIa+p5wBwew1wE//zYlv6Qs9PW2EqFHAUlnfPepmhcNN6aahFjtNYRl/n6BmFlA
 ofIAgAA
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
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
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
Changes in v9:
- Added a missing return statement in patch
  "tun: Introduce virtio-net hash feature".
- Link to v8: https://lore.kernel.org/r/20250306-rss-v8-0-7ab4f56ff423@daynix.com

Changes in v8:
- Disabled IPv6 to eliminate noises in tests.
- Added a branch in tap to avoid unnecessary dissection when hash
  reporting is disabled.
- Removed unnecessary rtnl_lock().
- Extracted code to handle new ioctls into separate functions to avoid
  adding extra NULL checks to the code handling other ioctls.
- Introduced variable named "fd" to __tun_chr_ioctl().
- s/-/=/g in a patch message to avoid confusing Git.
- Link to v7: https://lore.kernel.org/r/20250228-rss-v7-0-844205cbbdd6@daynix.com

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
 drivers/net/tap.c                    |  68 +++-
 drivers/net/tun.c                    |  98 +++++-
 drivers/net/tun_vnet.h               | 159 ++++++++-
 drivers/vhost/net.c                  |  49 +--
 include/linux/if_tap.h               |   2 +
 include/linux/skbuff.h               |   3 +
 include/linux/virtio_net.h           | 188 ++++++++++
 include/net/flow_dissector.h         |   1 +
 include/uapi/linux/if_tun.h          |  75 ++++
 net/core/flow_dissector.c            |   3 +-
 net/core/skbuff.c                    |   4 +
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tun.c    | 656 ++++++++++++++++++++++++++++++++++-
 15 files changed, 1255 insertions(+), 61 deletions(-)
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

