Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBE8155321
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168481; cv=none; b=Op0awOZgJDj6Aw+ZXKYVdiIThDa7AIHG18MOppZLVIEnrSMfEj0p+V8DVqA8NOpYguuYHia9vAz5SAI6VdcQbDBZCBqq3c5TmL326hWtk6W9u6eYvieJXvm9etflX4X6aJ5rdOP4QBOJF0v6Io7QZNOBPfo7U8RKoS4CB9ZQ7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168481; c=relaxed/simple;
	bh=YdshsQ9wIwHRRtPCOiCd5UbwMTOFheEkbYzE34S8Kag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=Tt/+75AUFFSTnjgcmWYIVJ9cgiupgFt555Fl83/1FxTuBblsFkxcwps21OCkkFis+Gg9O8l8FcrAtq2aUPxt8X5UejEAPIwZZPgGL5LqYHAQJaMx6xLCqbouJwQ7Ihvt5Z4KgGSYf4jMZEroi6OIj2tiFBSyWBwPyruaHeagYn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=C/k5jg6d; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="C/k5jg6d"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6571A40263
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u7-9-AivVfEB for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Sep 2024 09:01:17 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BC7434013B
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC7434013B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=C/k5jg6d
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BC7434013B
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:16 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so869115366b.1
        for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168474; x=1727773274; darn=lists.linux-foundation.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AtlB5qy8auRtRPL0RduaDGTybS6HddlcQeuq60a1IJQ=;
        b=C/k5jg6drCghH7NcJXZfM+CNqNHGrjXI3LZ0oOaXDyFFGbT2rs3w8znM+UtutR69XQ
         PtOucziQeoOIfNQ1Xbppkn71qPA9YvYdSx6XVFP7Rr6eXtpzBnY50+ZQdaukQWW1vsjP
         rpDp4oCajEJqj+vkTTCMPJwCUCb6LFNoSxEDzVNFaQ5RUZAb69uS+5xhAjDuT5T1GT2Y
         z1ulGisvoEKlbhZ8NFWsLQAkuBS0nKxRQ01I09RhfY7pqTTZGOgIeO3JXvy5woXvZUOf
         ZUh1MEq9a+UNsXOrhdM9K9sSsQ/VyD/FOt1t8SQemSOrHA7BDyOO1nupFfHjLW2gA+v4
         hV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168474; x=1727773274;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtlB5qy8auRtRPL0RduaDGTybS6HddlcQeuq60a1IJQ=;
        b=OlJpR7Z5TlnzZ0UCKCDnXRrrPTc0myrm1Jl1psNL37WZnnMekctk/MCFClHCG/mT3T
         qS68s7oxbsggVK5hx9u5z4qfV01lAJx37t0NNysvdCjkNhjTN0mDdOwjQ6y1ZT/aKEN8
         ehk37eFx8H18eRT8OqGMKaKuDLgnognbqt+RPtr8VHlYO5qIPeWcGIRTEPoSuJT8kah3
         X44jRyhYp/2oWU3LFry/gXBMRtU9N2kiyCLl/iIJU2L3rL3B1F62Dq6LgFOXRSstl1y1
         UVqSloTNgslfpuwncntv43jJ67FdsZh8yfwHmrAm6s0UQQMlz2VsisOPeMwHpr0OAYhJ
         YilA==
X-Forwarded-Encrypted: i=1; AJvYcCXe+nEfW1wuh1meGxj1iXMClYC2KhnXNUnDNtrKV9VEtb9MmlFnJWimn00l/q0Bf5tslUZLVeCMjKT5c3FCHw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwtRnUBONLRuYZ1Qr8UaGUDmfqd3VqaYwFHa0FhEv+lX1HKhTs7
	dywhJPOr2wR9jeq3PCUHPo6BnpxdQkrSbt+PB8l+JKMaM8KnXcCw8XMKmlW9w6M=
X-Google-Smtp-Source: AGHT+IHaDReVxS3zm/sAwED6+qiRDBe9ZLqtWPgerAJOI3AbbKp71Sg7dP4SnruIEzwhcJDcfUid1g==
X-Received: by 2002:a17:907:d3dc:b0:a7d:e956:ad51 with SMTP id a640c23a62f3a-a90d4ffe2a3mr1287940066b.21.1727168474351;
        Tue, 24 Sep 2024 02:01:14 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a93930f188bsm58641966b.153.2024.09.24.02.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
Date: Tue, 24 Sep 2024 11:01:05 +0200
Message-Id: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANF/8mYC/4WOwQrCMAyGX0V6tiNps256EgQfwKt4mGvnwnCVV
 oYy9u6WgqAnb/nz5/vILKIL7KLYrmYR3MSR/ZgCrVei7Zvx6iTblIUCRUCgZYhRukpXtt64rqk
 qkS7vwXX8zJaTOB724pyWPceHD69snjBXSaIRoIZSIWCBRKSURNkM3PPgC2/TtLPNa+Rn0fpb9
 kzqi8USCQ1RoQwYMn9Z/WEJNljm5yctQbZGQ5LZC9TqB1qW5Q1l3BJkFAEAAA==
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

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
Akihiko Odaki (9):
      skbuff: Introduce SKB_EXT_TUN_VNET_HASH
      virtio_net: Add functions for hashing
      net: flow_dissector: Export flow_keys_dissector_symmetric
      tap: Pad virtio header with zero
      tun: Pad virtio header with zero
      tun: Introduce virtio-net hash reporting feature
      tun: Introduce virtio-net RSS
      selftest: tun: Add tests for virtio-net hashing
      vhost/net: Support VIRTIO_NET_F_HASH_REPORT

 Documentation/networking/tuntap.rst  |   7 +
 drivers/net/Kconfig                  |   1 +
 drivers/net/tap.c                    |   2 +-
 drivers/net/tun.c                    | 255 ++++++++++++--
 drivers/vhost/net.c                  |  16 +-
 include/linux/if_tun.h               |   5 +
 include/linux/skbuff.h               |   3 +
 include/linux/virtio_net.h           | 174 +++++++++
 include/net/flow_dissector.h         |   1 +
 include/uapi/linux/if_tun.h          |  71 ++++
 net/core/flow_dissector.c            |   3 +-
 net/core/skbuff.c                    |   4 +
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tun.c    | 666 ++++++++++++++++++++++++++++++++++-
 14 files changed, 1170 insertions(+), 40 deletions(-)
---
base-commit: 752ebcbe87aceeb6334e846a466116197711a982
change-id: 20240403-rss-e737d89efa77

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

