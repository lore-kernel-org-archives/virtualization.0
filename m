Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627782147EB
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406851; cv=none; b=ftmp7BwN3qGWupiw8Uk04nKIpFBw6IjgPg2kYCQR5qqtcSGMqlkQ3rCnQ1b8OTPIJI/NjXAw2pQfYI8bHzuLZlKCvzciAUWgvDtZf5pSUqipK4fqgn0gF9fAw1B52+nojDC8TJikGpmTP4+6mB2TMf5SE9GjXEGO8JpwilQuWNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406851; c=relaxed/simple;
	bh=LqvxA5ftiyTpqtyco60E1+2R8PkBLlpmDEhHjtL9mxY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=d2R5wYD2m/vcL3PDDZ6E42GBXhUbGhys7pR4HY0h6cvdmjydF02uqykP6irDDuPbyw2lSk7gUemXEDbZvp7VjN9iSt9hLahux7w624UBQ2kq98CxwH5MiYK+3iYiM0AClWM82lg6ZnQA9Gt18bV5i5Xl94UVGSR8CVXNZnGK7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=PaEa1kU8; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="PaEa1kU8"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 145CA60890
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Us4ISbq9q_Fe for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 07:14:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E9067608A0
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9067608A0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=PaEa1kU8
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E9067608A0
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:14:07 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so784718a91.3
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 23:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736406847; x=1737011647; darn=lists.linux-foundation.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ja/03/V9ZzSisHs2kOKIjRXGVbNIxLyyvnfSlbsG0Y=;
        b=PaEa1kU8s27c55dZH0YeDdqd+2iycugn3qXEabztifgCU6DCBMD7C/X1HN80ecJ7wt
         2jnYp1q3BDRI/PYcqf5Laxs7W+jF/BQMeO1XmZLt5aAHVmuO6dH8vL/sIDmFFHhMhj4G
         JR86NmR9k2nRPxSmaHKfzENn70nObL02WvH+WtdUKr5oHuZXidZR/mxQMQjQZWKgOCmg
         eezYbr8RG3uERNlYnhMSj1fiar5oRMrGJvkIdxTFTzfyPdYlVVgosOtMpVsUFzUlsZ3L
         CIgq2tVrZV5NqHeDrY/lg0B9Z5z3NU1jMvGlt81Ts/vVcKubfhkXVDu+W7ikH41tPon6
         Srrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736406847; x=1737011647;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ja/03/V9ZzSisHs2kOKIjRXGVbNIxLyyvnfSlbsG0Y=;
        b=a9/YnNrRT/JgFh4ufcayj9MjhnB8w6MeIp2VV4KF04rbHiHOeQQVpFYJp4TjkhuOzt
         f9URxs5mnGUYGRD8SkhXE0tDTxO9gFLSMvp1RLC/hKayDXSDJKxUTo9An8NHfYPTGx9W
         mCzlhcMYQ+LMHQ124nUM8dU9PtiGxrZfPmKZUtX/xY5MMcqU++e+9YPhditledIrIWMo
         FWsWVI6k8X+QMnhM8usC1exl9Jv3IxVpVuaUAi9AO0r7/khBP5CfZYfCDP4ujadxk9xu
         z54SL7OZUgi1z2Wc94D0DemYpBGJE5Sqwx4B9Iw7AtZEt1kjWRI2iaAoWJAtqbg7q9JT
         b0uA==
X-Forwarded-Encrypted: i=1; AJvYcCWw8zKtTmw1t/W3s3iOr3fPbNlBQiBJXuc8K611xNTqTdo+cPSb6z2pqWvLqMhww7frmLFItq/cuw/jFin76w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzCDT7IYxvDEeUxltTk9LS94WTrvgqWbQuTTqFSnfiVOd1hoDop
	DAY4iroOSoSQ1hTO9OpAx38HXhSAH9EBO1Eua4rKr8qwGM3vR0RctCepED9MiQc=
X-Gm-Gg: ASbGnculsSzqgfG0VDbdiBr7rccrBNyEiufdXYwgBv/ObB3CQbd44rAo0NeUySBo3sk
	wRJgdYG68ZcPMVMCU2Sl8Rvy6K0xgAkqm9k4W+3CXFEqk8RuGyDR3baXS92yjnqLXPmPeJ2qfyL
	fL2/PozRIXUuo+A0FOcduYkPlkRX3yTKYoIZNBfNe5gZHzeHjmGcYfhNHamR34JCQ+gJHdoH0rw
	axPjQqoyu2Tq3flaSNIgXJw02IgNzGLi9AJ6F6smtI/EuZi41NJB+97G4o=
X-Google-Smtp-Source: AGHT+IFJUP6kT2nk/Shr8HhgnublEXClAdP2xLMbF7YF7Q3uJCPF52tP7YCh+wLuw1haRrn273Yx8A==
X-Received: by 2002:a17:90b:540f:b0:2ee:48bf:7dc3 with SMTP id 98e67ed59e1d1-2f548eb321emr9251390a91.15.1736406847130;
        Wed, 08 Jan 2025 23:14:07 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f559404c43sm633599a91.16.2025.01.08.23.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 23:14:06 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 0/6] tun: Introduce virtio-net hashing feature
Date: Thu, 09 Jan 2025 16:13:38 +0900
Message-Id: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACJ3f2cC/4XQQW7DIBAF0KtYrIs1wBiwV71H1QWGoUFR7dY4V
 qIody+21TZVFt0xiPeBf2WZpkSZddWVTbSknMahDPqpYv7ghjfiKZSZSZAICIpPOXMyygTbUnT
 GsHLyY6KYzlvKy2uZDynP43TZQhex7q5eCQALjRQgaoGIUnLB3TEd0nGsx1BWz8FdhnSu/fjO1
 pxF3lnRCBQasZYaNOp/rfq2CK1otncvigP3WkEJCz1Y+YDwDkncERZkkVolyQNp/4CaH7T+cEd
 NQVH5qG2IAE34g257ZxN9nkrh817cb99dtWVJBXw+DVxrEuCw7cGbrlRScO8y8RL1nuauansZo
 9MCbS8IsdwINhoCMqSM8Ki8822MVO69fQE99LhV8AEAAA==
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

This series depends on: "[PATCH v2 0/3] tun: Unify vnet implementation
and fill full vnet header"
https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com

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
 drivers/net/tap.c                    |  50 ++-
 drivers/net/tun.c                    |  93 ++++--
 drivers/net/tun_vnet.c               | 167 +++++++++-
 drivers/net/tun_vnet.h               |  33 +-
 drivers/vhost/net.c                  |  16 +-
 include/linux/if_tap.h               |   2 +
 include/linux/skbuff.h               |   3 +
 include/linux/virtio_net.h           | 188 +++++++++++
 include/net/flow_dissector.h         |   1 +
 include/uapi/linux/if_tun.h          |  75 +++++
 net/core/flow_dissector.c            |   3 +-
 net/core/skbuff.c                    |   4 +
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tun.c    | 630 ++++++++++++++++++++++++++++++++++-
 16 files changed, 1224 insertions(+), 51 deletions(-)
---
base-commit: 9b2ffa6148b1e4468d08f7e0e7e371c43cac9ffe
change-id: 20240403-rss-e737d89efa77
prerequisite-change-id: 20241230-tun-66e10a49b0c7:v2
prerequisite-patch-id: 057e888c371f2ce750064b7c40c2cc6abbdf6819
prerequisite-patch-id: 22d53dd3443a2c72496bffb90f19d429972550a3
prerequisite-patch-id: 1520f0c1f7b11559d0898bea556f745f6b8914ac

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

