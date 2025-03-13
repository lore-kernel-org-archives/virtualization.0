Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11391FCCEB
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849294; cv=none; b=axu5FCGUlkieSrlGuNjN4M/Zt81Wy34Z3YhwmxhhyiYOowrgshRKfEnokH+z0Ql7iIXUqp4x/jfi3ek8HM4Yp/LdAGwC22MoieiL8c4ons0mVwHfmht66Sh14tAeeuyOzmMBB1axIsPDlN4y7M6kxu06kHHoNIDRh6TzyakZPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849294; c=relaxed/simple;
	bh=kfhpvvDElt6du2l15UsrfA5V34sNhDDERx8i5/QevB8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=VYu0voPw5cz5Z5JLqXP6GGLlHJUjVw9zyxIaC5QpZRPwS6+1vnQ2DktrPijsiscIUEXPs8rPcjadmsNKuQXrFXmUtIzruuoGdY8A5M9pcJOEPLila5P7Y6Rqst44YjNH0jrfhW8ym7hkWMLrRvrofV5GSFIk/0Dq3jPtJ8kcHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=PRTrv33W; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="PRTrv33W"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A0EC60E02
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:01:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sEKfbwv9iok3 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Mar 2025 07:01:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AAEA660D7B
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAEA660D7B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=PRTrv33W
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AAEA660D7B
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:01:25 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2fe9759e5c1so1157112a91.0
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 00:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849285; x=1742454085; darn=lists.linux-foundation.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F95exAcnYQIEI1RaxPZgX7HWw0kZCG1DoITy3lJOXMs=;
        b=PRTrv33WaUw40emta7bqdiLyocL12l+Ej249viQHO1bluEfqw0YqKcgPSO9DfQJHBO
         Ux8kv62NumRzq60f//7VUmPEJOwKvC/ENLJfxEEgbeJUfLVPEA1DmHL1YkNN0AUGFwwP
         ssNsC93CSh1kFITM2JjPucIHoWXU1WuFalyb8UEdHLQdaBhXUmT8Ls6Ha8jV0JLSaL6A
         OPxh3nIDq4OZbYDVTco8dmRIQnpxsfS/oSnE2o8a26tQIJmiranMBnP17PnwcITYxdMY
         atYjPwP1n2ae8dtd7L908HRVIDO9nkLWIEb3n71JBvDDR8LwkXtMpK79D3G0O7pDkRfD
         pnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849285; x=1742454085;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F95exAcnYQIEI1RaxPZgX7HWw0kZCG1DoITy3lJOXMs=;
        b=skpT0mjnQEhB1eZXL+pFDEVm6wXTqWxSOAUA5PfJ+DUSwZNsXmZwxnXaySK09yL1rK
         EkI3o6LwkuKl5keSdwfhOUO4o3QzTagkUpcACkvXyyxT2sKHw8CxOg7laomfelP3AcAP
         Bb293nflGsCWNcq9bCNWV40Q/uszm/nZvugyUez8zfR2zvOKAXzdQmNbkE4+fpJjNq9b
         N702I1ASRN97oV49UWdH4hzXf3/S2Hez6wWPNEKYOVkLV8GYkglC3RhfpYywf3WxS1nJ
         TxOHXXGJqwVaH1Y816KBuP5FHjO1Lp/NuV9lnMtTKaWUnUAGM7IrctnE8SwgYZ5LadiM
         IAjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9vVJ3jKgofPrFuWVxJsUiGWTz2/Iv2ZsJfVZVYGxS4O+IR23O+UxoGHM3QfvkyfLe+ihPnqgEFGiyv9sDDg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwVDd8xNVp0B1Y9C0w2IDFvsWLy3DciwS35q6HrMuvZOM1ItsA6
	SfhfVFj1p+88YRhO+T8MrPoWPDe8XxEZOSzEq9d62hFJg1gfe4kLB3meOZSZbCc=
X-Gm-Gg: ASbGnct09zcC3KN94U+D1Syn2NP3Ct2WX/Rc/MK3LkgYbaS0KRNBHyBCJbV2i2arhiU
	d37lmO4B32IwuatQLPL+tsykC3YlkfHO3eHQ1UKpY2GSYAsw43/UlphEkyGJYdE76aqRHllMDVy
	zUzEhsOEEQx0siXK/S+vkUiILsL+fN8Wv6jLhgkHZbIaV888C7scuTZxv/7fNGCkp6kcug6TE6S
	l4VhptYwYw72m5iJuWA3lL1AF9TCXiH4kZcLNw++8rvQ9j8rEyoRGfrdE3nRLqOkPwWIkJmYSzx
	qTXmaJVk+5Fhkb59rHn0dImyEbqE3I6Id/xyExFE++jCt34A
X-Google-Smtp-Source: AGHT+IG/2TUsxjSP8SAJkKonb+AXsMlQnT1GibK5u7KLisnvk4f6w1Qgk6Dn5pj1HIS4hmUjn2b80w==
X-Received: by 2002:a17:90a:e70e:b0:2ee:f076:20fb with SMTP id 98e67ed59e1d1-300ff10c978mr15687591a91.17.1741849284620;
        Thu, 13 Mar 2025 00:01:24 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301182181c3sm3092882a91.5.2025.03.13.00.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:01:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next v10 00/10] tun: Introduce virtio-net hashing
 feature
Date: Thu, 13 Mar 2025 16:01:03 +0900
Message-Id: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALCC0mcC/4XSS27kIBAG4Ku0vA6tAooCvJp7jGbBM42i2Bnb3
 eooyt1TsfPoyIvsjKmvgNL/0s1lamXu+sNLN5VLm9s48ELC3aFLpzDcF9Ey/+gUKAQELaZ5FsV
 qm50vNVjbceXTVGq7rm3+dkNZxFCuS/ePd05tXsbpee1/kes+d9ISwIFREuRRIqJSQorw0E7tY
 TyOmb/+5PA8tOsxjY9rn4u6sdJIlIR4VASE9KvVnxbBS7O+4KIFiEQauFmO4NQO4Q1SuCFk5LB
 4rUqCQmmHzBd6f+GGDKOqUyWXK4DJO0SfyIAEvyFiFGXyELIFV2mH7DdS6uMku14PFZgUY8575
 L6RBtqQY2RDxGqoVlR6h/wtshvyjHK1RDwdZUr8gV63REzl/5nztHzE4itN/WGdj9IglvMgiIq
 EgD5Csj3P4jZ4aylPRZKI51rLNAvP5Rgr56CmnlPB5THMRfDJj23pDzk7bY2tVMhRUNI5722Kx
 kXjrakWMUZrHfE1X98A0L/L2f4CAAA=
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
X-Mailer: b4 0.15-dev-edae6

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
https://patchew.org/QEMU/20250313-hash-v4-0-c75c494b495e@daynix.com/

This work was presented at LPC 2024:
https://lpc.events/event/18/contributions/1963/

V1 -> V2:
  Changed to introduce a new BPF program type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v10:
- Split common code and TUN/TAP-specific code into separate patches.
- Reverted a spurious style change in patch "tun: Introduce virtio-net
  hash feature".
- Added a comment explaining disable_ipv6 in tests.
- Used AF_PACKET for patch "selftest: tun: Add tests for
  virtio-net hashing". I also added the usage of FIXTURE_VARIANT() as
  the testing function now needs access to more variant-specific
  variables.
- Corrected the message of patch "selftest: tun: Add tests for
  virtio-net hashing"; it mentioned validation of configuration but
  it is not scope of this patch.
- Expanded the description of patch "selftest: tun: Add tests for
  virtio-net hashing".
- Added patch "tun: Allow steering eBPF program to fall back".
- Changed to handle TUNGETVNETHASHCAP before taking the rtnl lock.
- Removed redundant tests for tun_vnet_ioctl().
- Added patch "selftest: tap: Add tests for virtio-net ioctls".
- Added a design explanation of ioctls for extensibility and migration.
- Removed a few branches in patch
  "vhost/net: Support VIRTIO_NET_F_HASH_REPORT".
- Link to v9: https://lore.kernel.org/r/20250307-rss-v9-0-df76624025eb@daynix.com

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
Akihiko Odaki (10):
      virtio_net: Add functions for hashing
      net: flow_dissector: Export flow_keys_dissector_symmetric
      tun: Allow steering eBPF program to fall back
      tun: Add common virtio-net hash feature code
      tun: Introduce virtio-net hash feature
      tap: Introduce virtio-net hash feature
      selftest: tun: Test vnet ioctls without device
      selftest: tun: Add tests for virtio-net hashing
      selftest: tap: Add tests for virtio-net ioctls
      vhost/net: Support VIRTIO_NET_F_HASH_REPORT

 Documentation/networking/tuntap.rst  |   7 +
 drivers/net/Kconfig                  |   1 +
 drivers/net/tap.c                    |  68 ++++-
 drivers/net/tun.c                    |  90 +++++--
 drivers/net/tun_vnet.h               | 155 ++++++++++-
 drivers/vhost/net.c                  |  68 ++---
 include/linux/if_tap.h               |   2 +
 include/linux/skbuff.h               |   3 +
 include/linux/virtio_net.h           | 188 ++++++++++++++
 include/net/flow_dissector.h         |   1 +
 include/uapi/linux/if_tun.h          |  82 ++++++
 net/core/flow_dissector.c            |   3 +-
 net/core/skbuff.c                    |   4 +
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tap.c    |  97 ++++++-
 tools/testing/selftests/net/tun.c    | 491 ++++++++++++++++++++++++++++++++++-
 16 files changed, 1185 insertions(+), 77 deletions(-)
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

