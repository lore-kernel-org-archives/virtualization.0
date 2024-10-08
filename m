Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3D1E3DDA
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370481; cv=none; b=WEmDuc2R5LwnCgmCHNVDfUy9KSGN3Pi14C6qfUctlVyw05K28o4lH7MVdz6RdzerWzkKZTrmoJ00I955IXWQbJseJCIZ+dxtnupXTTcaErf59kMvq9961BtWwM/wOdlTLPZYI2hGdctcGpXJFpBBiUfgptuGC4JcV3+lT0jy3J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370481; c=relaxed/simple;
	bh=6j/9R+ZY3hri2Pq0LzMiZP+7u1JzeaSfqhBdxGp4lDo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=u/X+bNGIJmrz3hp/oq1Wvr49DlE8jXkh7ltTDHh9Jl1oRxwwpuX96W/aEfGMuolYlgZ5lzdi1pKsWOuM9kmEdCtT3D6C/AZ0kON9+shnZwszbmsKA+afEY67OJebqxga70aabgRg/BeenIYvc1NaSJMXavlOkpOdag3NqRXlFJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=hk42Fmby; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="hk42Fmby"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7807C40315
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:54:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sCNYZM7ooPGP for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Oct 2024 06:54:37 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E259A40313
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E259A40313
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=hk42Fmby
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E259A40313
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Oct 2024 06:54:36 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-20b7a4336easo38767615ad.3
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728370476; x=1728975276; darn=lists.linux-foundation.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8gty0dEnircfdREPGfEnkI3a1znlqYE3ZJr68g8y4pY=;
        b=hk42Fmby7WDSNZIkagXRzM3TpbXJCSk6Fbma4SC6jy2GpkJT7tjTj5nJ3FEewD7D8f
         sPKjS0ClPApq8PvmeUXzt9URdOp1enrP2Y/dzW/OWA1Jnc2UTUI0E7szQAPC1CTZ21+T
         iDR5Ksj/VRiejSIKaSYMqUePcVgK6B69b3It79GjwiY+EtOTXY3XYd60ak9nW+jcADic
         ejz7nujeKO1xhZ40D2UVQVEO3BeYF1snPZVtRukgJN4auaR45deVWMl9PlVtylPJJkGU
         Zhr9ci7XSnZW5geQdbVIZfbsO0Jck82KfnNQWht5hlNrIiLzqnQ5cMYQoe2sryPiwMcW
         ZQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370476; x=1728975276;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gty0dEnircfdREPGfEnkI3a1znlqYE3ZJr68g8y4pY=;
        b=rS8yp520d5Xj47wrAf4AXOCY7DIxfkqlqQ7e7Ao/dThAxCDJL7Bz4DtfIIEOcTs+Zm
         hpp/reUHUgJRkpu6iwxGY4strXtWheM+Raq5HeGib8v95hz5w58nD1Za/BDF7fYKkO26
         q7/4f2Kg2GHDff9N9o1V3L8o1nrwmQjC6yAqjOTKT8yb1Gf6VzFvrllA/m5519b5jG6g
         NVRzkkq7Jpm1GcmHLc/PnUiqpnSj4xxZXdkqj9Tx5DmQZkrS19cxBNoe30IrQXCEITFt
         JG25wnyZQW3w/1ess/o7w0ZjkRrtnAvPs181Eu7ffEmJamOxxIyrlCAShaLgk8xDslzQ
         oCdA==
X-Forwarded-Encrypted: i=1; AJvYcCVhn25HyiIhP3jrJNWPWIjo8OKxMIlU6oRCWtUYjXU8/qlpaZiEuDF5Uo/riz2Bm5Ddv9AXaknmlWgW9MXUEg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwxHtEuCHxXGBt/9WT3Wxnm0J/+0JCm1ySaerdFCeF0cRn7Pf5K
	jlEAsZP2Rvc0aUB7dtxIwV98mnRF7m1XmaHl0wRUq8W+j+O0htXG58T3DCERq0A=
X-Google-Smtp-Source: AGHT+IHPQgocRRuVmNwy/y+36pGmysZiERFRRt/OUdpP+pXSUlRa9FCdE9Lo2jrORE0Se01AVBe7kQ==
X-Received: by 2002:a17:902:e882:b0:20b:9078:707b with SMTP id d9443c01a7336-20bfe02199emr225978335ad.30.1728370475858;
        Mon, 07 Oct 2024 23:54:35 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20c13987571sm49681435ad.250.2024.10.07.23.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 23:54:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RFC v5 00/10] tun: Introduce virtio-net hashing feature
Date: Tue, 08 Oct 2024 15:54:20 +0900
Message-Id: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzXBGcC/4XOwWrDMAyA4VcpPtdBkhUn6akw6APsOnbIbLUxp
 fGwS2gpefcZj0HHDrtZlr8fP1SWFCSr3eahkiwhhziXod1ulJvG+SQ6+DIrAmJgMDrlrKUzne8
 HOY5dp8rLzyTHcKuVN/V6eFHv5XIK+RrTvZYXrKsSMQjQQ0sI2CAzE2nU4zlM4Ryb6Mtp78f7H
 G6Ni5faWejJYouMlrkhC5btv9b8WIYB2/r5xWjQzhooMf8BPf1B/ISIvxEX1LMMhsSBWPcLrev
 6BaOSk/1JAQAA
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
Akihiko Odaki (10):
      virtio_net: Add functions for hashing
      skbuff: Introduce SKB_EXT_TUN_VNET_HASH
      net: flow_dissector: Export flow_keys_dissector_symmetric
      tun: Unify vnet implementation
      tun: Pad virtio header with zero
      tun: Introduce virtio-net hash reporting feature
      tun: Introduce virtio-net RSS
      selftest: tun: Test vnet ioctls without device
      selftest: tun: Add tests for virtio-net hashing
      vhost/net: Support VIRTIO_NET_F_HASH_REPORT

 Documentation/networking/tuntap.rst  |   7 +
 MAINTAINERS                          |   1 +
 drivers/net/Kconfig                  |   1 +
 drivers/net/tap.c                    | 218 ++++--------
 drivers/net/tun.c                    | 293 ++++++----------
 drivers/net/tun_vnet.h               | 342 +++++++++++++++++++
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
 16 files changed, 1430 insertions(+), 356 deletions(-)
---
base-commit: 752ebcbe87aceeb6334e846a466116197711a982
change-id: 20240403-rss-e737d89efa77

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

