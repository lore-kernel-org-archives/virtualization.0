Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BF6CA6B
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363093; cv=none; b=OD/E+bWuW/ysr/PTsAf3jVNVwPBKo/2kjhNKav7E7h2cFMiN/jAZRbnEGXB6dnhUt8l2JgvBHPb0yuYUTH6mmrksFchseSDCZOUwOtQs8l+lyw281q3SelgN74PUT9ieabGAE+uGF2Q32yVRPSf8iNXquQ3WJ5wXK7jnp7KRoc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363093; c=relaxed/simple;
	bh=DjLACX6Izp1tDR7jnoxIGZpV6PDSLXserAQrHsvK6tI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=PkF5hmY20mtznrajPDr4oZIQJaa4UfDH3v6/QUhLqLJuoPIeD9xR8NHsUVSWW0jdirTbSFJzcHZ4Rj2jBhovlOVZkYjml3MyjfigkcHPOiq9RdxbI10bIWbmUPKCitgm2MqUCf3Q6NtK9MyylEHh9lk8ODzOR6o282lMNzAj9j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ZlHJbNlB; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ZlHJbNlB"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 912C840204
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:18:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Epg-tU-O8eqa for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Sep 2024 01:18:10 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B2B10400F9
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2B10400F9
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ZlHJbNlB
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B2B10400F9
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:18:09 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2059204f448so30431705ad.0
        for <virtualization@lists.linux-foundation.org>; Sat, 14 Sep 2024 18:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363088; x=1726967888; darn=lists.linux-foundation.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4RlYLWTGEUWVMmH5uAZ3KmcTjt8vGdeFUKq4t4XgGZI=;
        b=ZlHJbNlBsqGfSdM6tI8lrgSAaYJH1wRXpQkRFGABl4KOwhgQih2tzTwONSkbByM47N
         tyhT1H0Rpe7fKHcsP8dHnTzCb26MRd5Tlg2t63IFsdhq9IsaMxluIjheB2rYRrxogUzr
         GunjHTnqgSPxlosKYB5wTChTMYwE6khtLujAxwhCDrBc8OQyASyeYn47Jh9tq9fQrarC
         012pa8ckz2quw6KQf4h/7YfSeVNLgx6qB/yMIB9GAPMSpzTX1W4BEhZD6mD2ZTweibws
         HZ5g6w+v2tehdIxRo+BrQ++RWaixXvOBmE2o1H4BiswCMb1Y4eBJ42xKohqJGy6No37x
         EEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363088; x=1726967888;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RlYLWTGEUWVMmH5uAZ3KmcTjt8vGdeFUKq4t4XgGZI=;
        b=PmuwXcjegGAGYsqM5Tnjm+NxZByXp6vdTTWhV5N4raxDCNIOPLSRGCN69XgPTPdooM
         PtVovkfycT9b9qRJe4vhKjvUq2KGq9UTLCESDFlzpZE2wGhFkhq0n6cvyfldTGpOYyJK
         B1ip+i4ylo6AAn7hygXHZy2ep98kPMMcVn0JnPRX7J4xMqbOCgrVWXthXy6IwMQTgbYd
         gFaqi7TU4zJ2ylId+lBg/j3J89On4MvYGGHnmc/MR/cKoHIcEfsAqIFStTySxh9Cus/e
         LchP1CGiGYRa7wtuOKWGplGE0wkWjM6n+RA7GONleV2FPxpXO/ea0Xo0fb4yWQRpCK/V
         lEOA==
X-Forwarded-Encrypted: i=1; AJvYcCWDcUAzYTbbq0EPz8VEBVseISjbOG0mSVKxbXJxkHHbRj9QNgkmGDuKpyIjja4+T76yj1X81rHLpNnnHRgJvw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwX8Zs/6WIk3yRqKgSFAebvX3qBjgdkjmxkl03ZLdVvzQ/VZ2WQ
	7NUsA0CXGA8nllJr4/tCIYoqRCjN+Nj5vxmZOXRtuu6TbY4JO+0mJRbaWn9Vxlw=
X-Google-Smtp-Source: AGHT+IEiuSb5mz6nz0x+3ls5vJS2I1fqTIfJlWtcvvYAYRCP14NP9cyLAAgnz5CXLZHRFQsX1yZDwg==
X-Received: by 2002:a17:902:e842:b0:205:5f35:80a0 with SMTP id d9443c01a7336-2076e460c8bmr183980385ad.57.1726363088286;
        Sat, 14 Sep 2024 18:18:08 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-207946d181fsm14749405ad.133.2024.09.14.18.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:18:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RFC v3 0/9] tun: Introduce virtio-net hashing feature
Date: Sun, 15 Sep 2024 10:17:39 +0900
Message-Id: <20240915-rss-v3-0-c630015db082@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALM15mYC/32MuwrCMBSGX6VkNiEnOU2qkyD4AK7iEJrUHoqNJ
 FJaSt/d0MnJ7b9+K8shUcjsVK0shYkyxbEYfahY27vxGTj54pmSCiVKzVPOPFhtfXMMnbOWleU
 7hY7mnXJnt+uFPUrYU/7EtOzkCfaqQDRI2chagQQBiKgUB+4G6mmIIvqizt4tI82ija+dM6mfL
 9SAYBCFMtKg+fvdtu0LzTrgp98AAAA=
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

QEMU patched to use this new feature is available at:
https://github.com/daynix/qemu/tree/akihikodaki/rss2

The QEMU patches will soon be submitted to the upstream as RFC too.

This work will be presented at LPC 2024:
https://lpc.events/event/18/contributions/1963/

V1 -> V2:
  Changed to introduce a new BPF program type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
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
 include/linux/skbuff.h               |  10 +
 include/linux/virtio_net.h           | 198 +++++++++++
 include/net/flow_dissector.h         |   1 +
 include/uapi/linux/if_tun.h          |  71 ++++
 net/core/flow_dissector.c            |   3 +-
 net/core/skbuff.c                    |   3 +
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tun.c    | 666 ++++++++++++++++++++++++++++++++++-
 13 files changed, 1195 insertions(+), 40 deletions(-)
---
base-commit: 46a0057a5853cbdb58211c19e89ba7777dc6fd50
change-id: 20240403-rss-e737d89efa77

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

