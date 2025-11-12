Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FA42DA76A
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930537; cv=none; b=kwiFkfRa+U17bAtUP3UXoKALsrEdDRqiiUIar7IqzUischBC2MhbhyZtEVaz9Q6dvbfEEJgzU6f/Smml9NNl/MWnGAcg29Z9heSEtcCSGjj1vdPeZgGPI865fKw/a+jtpvlmAZMdXoXvRkoyjDigXbz0hL0/njnl0Q3qDYP3e3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930537; c=relaxed/simple;
	bh=/ZJs6hM4aBlMVwDYCyi6knawEEKBN9+OG6DspGG4uRk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rqEGzDxF0zKOm5/Fhe0+395iORKEzZnS4PGzH73sikzCBnpFugq6Nbs42TJZ6Wm4bCuVfL4lsRZii0psmUl1ih48i6FfjqQ1EjPW71AgP44/a1V2/8/4T3ywjRar2c9nvtM8wyeXz4pP43Ne/5/OffA9Hujb3TeXUu6/eOL03UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHAUiu7R; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHAUiu7R"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2958db8ae4fso4526115ad.2
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 22:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930534; x=1763535334; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke3NReGgTRFEhQlk1px8T+aLyWDyRxoG6fInQoXP324=;
        b=gHAUiu7RrdPVu8o1o+d8WJTYXiByjeFKLJHYvNIxVnWF9LVAkhgj3TF8U9M7nwCwJv
         /c4QP5mb0TvG6cMglOX/QnqlDaYcPXljW2HeLKqxf2D9I0jiu8RzpMB1Zgdg1pEMm0I2
         8qhc3FxEvU29pB4EjS0lKJXWV+Y8m/NHYstvo9znxp93MRPiTzQEOEvfzuyhrMHxaU4y
         D1jjd/EkMBdmGD0JZU0nSfqFUsms5pa2puQHN2cJE5gzCyM+H/zdpN0UrMh/zoEvVAY2
         vwHed5QiO2t3PkTxFCBwWZaYhC4E+5afbGSkMUZyfulEqt3uIqIOaEmwnS12zpbphm0i
         WzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930535; x=1763535335;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke3NReGgTRFEhQlk1px8T+aLyWDyRxoG6fInQoXP324=;
        b=qc+pjtSBk5Z3a345HUEDajiGTKL//OWbWojxt81f1JptLGRT/3Bg7wyuUSbl6PKKRT
         9OOzOGeKAdNV2a7vlRL+iPLt2b3E78EduMabkklbby4FKlsFA+wYtVGJVm4uEeYZeafA
         foUphEVFr/UDJVung6L56yogLDRmZ804YxVPqj/+B2/2/s9iRXWgDkEPCctar8ei49xj
         K/p6fJi43nLzMKojE3e/O35NYqp1Bp14jkdW84fPf+8ohyaPi7WSIDpeJ+UvBUTuIlcT
         8mZKPtGG197HYRD7NAOx1mhZFWfY9lVLUbT5NF/OHjmUyxfFZns94XWUDGTEQFzcVRlH
         C6hA==
X-Gm-Message-State: AOJu0YzrY3uq8LddKn51enJ+BEdmZiukkk1qZ245eA4eI8x22XBccfs/
	5Sd/zckFR8HRcs+x7JoBPHxH5oVL2RohcIHcRvkFMN/u+XqYcntA6Urf
X-Gm-Gg: ASbGncuXW3snbC2kK3dTbEqxiGOMZxAnQAMK7AVrJa/ADS7azypRRqyl1wtFxTzYC/r
	TrOMtdnZCHC1WcZ3QXQr8efU9Q6gYNADe7uOdIShn8lsHBWe+5FKF7HDoD1rMUzTCN6HD2KOeoj
	HhbnnSrG/6/D1qAa8/jnk/ZnHxSQeoaLKcDELLunBrRpDgjcRSOXyjwbSXe5/oGfIcdiJn539nE
	ehjsRrDTWX6pGJ1YR91g1f0N0yNaVKqwHO6lauDdpoQw01FsN5DNsUtz3C5zjSuS94LCeLqAVp8
	HzUspgqJgYqmT6FvbgLDFuw23WrXbcFVvIk7VYY4/7ZVb4d0CVu5rnT7uCYPQIXUbX2w0AqTDIg
	c1KxZMvW1V0Kche6orK+B7pdtpMuP5Rgv3QoCt4wEP3IkLxB0OrkybVSL3uUCI6KeB7N0IbyE
X-Google-Smtp-Source: AGHT+IFAYkhKzu/x9HPT+1qAO6YJQ04QKPGbuIxpHa5zaK1fC1l23/beGqYUlgExVd9PMwhrh44BTg==
X-Received: by 2002:a17:903:41cd:b0:295:8a21:155a with SMTP id d9443c01a7336-2984eda838cmr27544485ad.35.1762930534354;
        Tue, 11 Nov 2025 22:55:34 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbdac10sm19016245ad.22.2025.11.11.22.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:33 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v9 00/14] vsock: add namespace support to
 vhost-vsock and loopback
Date: Tue, 11 Nov 2025 22:54:42 -0800
Message-Id: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADMvFGkC/5WTy27cMAwAf8XQeVmQ1MPSoijyH0UOetCJ0dhOL
 ddIEey/F+suEtfJpWdhZiSCelVV5l6qOjevapa1r/00qnMTTo3Kj3F8EOiLOjeKkS1qtrDWKf+
 AdVikLpB0ZCpMyJnVqVHPs3T9y6b7rkZZYJSXRd2fGvXY12Waf2+dlbbzTWkI/1WuBASdttFTi
 Sn4fPcwxP7pS56GTbTyHm4PMAOBDkiRW61J/BHWO5j9AdZAQJ5i58jpTssRNu+wxWPZAIETjqF
 lx7m4HXy6jc+j/QAhoA2SLcVERHeDLPE9aHdB0gfWAoGR1mYTjc2SPgty+wFCwBStxyRFbDoE3
 T54vKwDghA7yhlZB8RPgoHcBwgBnSksCbMP5RBs34KETAe23VhHqU2uQ7+bzq33X8zW8/vecaI
 eEIrE4E1BTgl37OXvcs/y81df++W24YPUGrcvcm6+3qR8k1Z56q7aCtuPgDgW6IfneVplkHGp1
 0VHkCKJ2lCccfot9+36vhSrQJ6GoV/OTXAcs80xhGizlta4wGRTZ1rbsjFokEtXbFD3l8sfmhZ
 gJdMDAAA=
X-Change-ID: 20250325-vsock-vmtest-b3a21d2102c2
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series adds namespace support to vhost-vsock and loopback. It does
not add namespaces to any of the other guest transports (virtio-vsock,
hyperv, or vmci).

The current revision supports two modes: local and global. Local
mode is complete isolation of namespaces, while global mode is complete
sharing between namespaces of CIDs (the original behavior).

The mode is set using /proc/sys/net/vsock/ns_mode.

Modes are per-netns and write-once. This allows a system to configure
namespaces independently (some may share CIDs, others are completely
isolated). This also supports future possible mixed use cases, where
there may be namespaces in global mode spinning up VMs while there are
mixed mode namespaces that provide services to the VMs, but are not
allowed to allocate from the global CID pool (this mode is not
implemented in this series).

If a socket or VM is created when a namespace is global but the
namespace changes to local, the socket or VM will continue working
normally. That is, the socket or VM assumes the mode behavior of the
namespace at the time the socket/VM was created. The original mode is
captured in vsock_create() and so occurs at the time of socket(2) and
accept(2) for sockets and open(2) on /dev/vhost-vsock for VMs. This
prevents a socket/VM connection from suddenly breaking due to a
namespace mode change. Any new sockets/VMs created after the mode change
will adopt the new mode's behavior.

Additionally, added tests for the new namespace features:

tools/testing/selftests/vsock/vmtest.sh
1..29
ok 1 vm_server_host_client
ok 2 vm_client_host_server
ok 3 vm_loopback
ok 4 ns_guest_local_mode_rejected
ok 5 ns_host_vsock_ns_mode_ok
ok 6 ns_host_vsock_ns_mode_write_once_ok
ok 7 ns_global_same_cid_fails
ok 8 ns_local_same_cid_ok
ok 9 ns_global_local_same_cid_ok
ok 10 ns_local_global_same_cid_ok
ok 11 ns_diff_global_host_connect_to_global_vm_ok
ok 12 ns_diff_global_host_connect_to_local_vm_fails
ok 13 ns_diff_global_vm_connect_to_global_host_ok
ok 14 ns_diff_global_vm_connect_to_local_host_fails
ok 15 ns_diff_local_host_connect_to_local_vm_fails
ok 16 ns_diff_local_vm_connect_to_local_host_fails
ok 17 ns_diff_global_to_local_loopback_local_fails
ok 18 ns_diff_local_to_global_loopback_fails
ok 19 ns_diff_local_to_local_loopback_fails
ok 20 ns_diff_global_to_global_loopback_ok
ok 21 ns_same_local_loopback_ok
ok 22 ns_same_local_host_connect_to_local_vm_ok
ok 23 ns_same_local_vm_connect_to_local_host_ok
ok 24 ns_mode_change_connection_continue_vm_ok
ok 25 ns_mode_change_connection_continue_host_ok
ok 26 ns_mode_change_connection_continue_both_ok
ok 27 ns_delete_vm_ok
ok 28 ns_delete_host_ok
ok 29 ns_delete_both_ok
SUMMARY: PASS=29 SKIP=0 FAIL=0

Dependent on series:
https://lore.kernel.org/all/20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com/

Thanks again for everyone's help and reviews!

Suggested-by: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>

To: Stefano Garzarella <sgarzare@redhat.com>
To: Shuah Khan <shuah@kernel.org>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael S. Tsirkin <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Eugenio Pérez <eperezma@redhat.com>
To: K. Y. Srinivasan <kys@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
To: Bryan Tan <bryan-bt.tan@broadcom.com>
To: Vishnu Dasa <vishnu.dasa@broadcom.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: berrange@redhat.com
Cc: Sargun Dhillon <sargun@sargun.me>

Changes in v9:
- reorder loopback patch after patch for virtio transport common code
- remove module ordering tests patch because loopback no longer depends
  on pernet ops
- major simplifications in vsock_loopback
- added a new patch for blocking local mode for guests, added test case
  to check
- add net ref tracking to vsock_loopback patch
- Link to v8: https://lore.kernel.org/r/20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com

Changes in v8:
- Break generic cleanup/refactoring patches into standalone series,
  remove those from this series
- Link to dependency: https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
- Link to v7: https://lore.kernel.org/r/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com

Changes in v7:
- fix hv_sock build
- break out vmtest patches into distinct, more well-scoped patches
- change `orig_net_mode` to `net_mode`
- many fixes and style changes in per-patch change sets (see individual
  patches for specific changes)
- optimize `virtio_vsock_skb_cb` layout
- update commit messages with more useful descriptions
- vsock_loopback: use orig_net_mode instead of current net mode
- add tests for edge cases (ns deletion, mode changing, loopback module
  load ordering)
- Link to v6: https://lore.kernel.org/r/20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com

Changes in v6:
- define behavior when mode changes to local while socket/VM is alive
- af_vsock: clarify description of CID behavior
- af_vsock: use stronger langauge around CID rules (dont use "may")
- af_vsock: improve naming of buf/buffer
- af_vsock: improve string length checking on proc writes
- vsock_loopback: add space in struct to clarify lock protection
- vsock_loopback: do proper cleanup/unregister on vsock_loopback_exit()
- vsock_loopback: use virtio_vsock_skb_net() instead of sock_net()
- vsock_loopback: set loopback to NULL after kfree()
- vsock_loopback: use pernet_operations and remove callback mechanism
- vsock_loopback: add macros for "global" and "local"
- vsock_loopback: fix length checking
- vmtest.sh: check for namespace support in vmtest.sh
- Link to v5: https://lore.kernel.org/r/20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com

Changes in v5:
- /proc/net/vsock_ns_mode -> /proc/sys/net/vsock/ns_mode
- vsock_global_net -> vsock_global_dummy_net
- fix netns lookup in vhost_vsock to respect pid namespaces
- add callbacks for vsock_loopback to avoid circular dependency
- vmtest.sh loads vsock_loopback module
- remove vsock_net_mode_can_set()
- change vsock_net_write_mode() to return true/false based on success
- make vsock_net_mode enum instead of u8
- Link to v4: https://lore.kernel.org/r/20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com

Changes in v4:
- removed RFC tag
- implemented loopback support
- renamed new tests to better reflect behavior
- completed suite of tests with permutations of ns modes and vsock_test
  as guest/host
- simplified socat bridging with unix socket instead of tcp + veth
- only use vsock_test for success case, socat for failure case (context
  in commit message)
- lots of cleanup

Changes in v3:
- add notion of "modes"
- add procfs /proc/net/vsock_ns_mode
- local and global modes only
- no /dev/vhost-vsock-netns
- vmtest.sh already merged, so new patch just adds new tests for NS
- Link to v2:
  https://lore.kernel.org/kvm/20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com

Changes in v2:
- only support vhost-vsock namespaces
- all g2h namespaces retain old behavior, only common API changes
  impacted by vhost-vsock changes
- add /dev/vhost-vsock-netns for "opt-in"
- leave /dev/vhost-vsock to old behavior
- removed netns module param
- Link to v1:
  https://lore.kernel.org/r/20200116172428.311437-1-sgarzare@redhat.com

Changes in v1:
- added 'netns' module param to vsock.ko to enable the
  network namespace support (disabled by default)
- added 'vsock_net_eq()' to check the "net" assigned to a socket
  only when 'netns' support is enabled
- Link to RFC: https://patchwork.ozlabs.org/cover/1202235/

---
Bobby Eshleman (14):
      vsock: a per-net vsock NS mode state
      vsock: add netns to vsock core
      vsock/virtio: add netns support to virtio transport and virtio common
      vsock/virtio: pack struct virtio_vsock_skb_cb
      vsock: add netns and netns_tracker to vsock skb cb
      vsock/loopback: add netns support
      vhost/vsock: add netns support
      vsock: reject bad VSOCK_NET_MODE_LOCAL configuration for G2H
      selftests/vsock: add namespace helpers to vmtest.sh
      selftests/vsock: prepare vm management helpers for namespaces
      selftests/vsock: add tests for proc sys vsock ns_mode
      selftests/vsock: add namespace tests for CID collisions
      selftests/vsock: add tests for host <-> vm connectivity with namespaces
      selftests/vsock: add tests for namespace deletion and mode changes

 MAINTAINERS                             |   1 +
 drivers/vhost/vsock.c                   |  48 +-
 include/linux/virtio_vsock.h            |  43 +-
 include/net/af_vsock.h                  |  57 +-
 include/net/net_namespace.h             |   4 +
 include/net/netns/vsock.h               |  17 +
 net/vmw_vsock/af_vsock.c                | 290 +++++++++-
 net/vmw_vsock/hyperv_transport.c        |   1 +
 net/vmw_vsock/virtio_transport.c        |  14 +-
 net/vmw_vsock/virtio_transport_common.c |  57 +-
 net/vmw_vsock/vsock_loopback.c          |  48 +-
 tools/testing/selftests/vsock/vmtest.sh | 931 ++++++++++++++++++++++++++++++--
 12 files changed, 1418 insertions(+), 93 deletions(-)
---
base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59
change-id: 20250325-vsock-vmtest-b3a21d2102c2
prerequisite-message-id: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
prerequisite-patch-id: a2eecc3851f2509ed40009a7cab6990c6d7cfff5
prerequisite-patch-id: 501db2100636b9c8fcb3b64b8b1df797ccbede85
prerequisite-patch-id: ba1a2f07398a035bc48ef72edda41888614be449
prerequisite-patch-id: fd5cc5445aca9355ce678e6d2bfa89fab8a57e61
prerequisite-patch-id: 795ab4432ffb0843e22b580374782e7e0d99b909
prerequisite-patch-id: 1499d263dc933e75366c09e045d2125ca39f7ddd
prerequisite-patch-id: f92d99bb1d35d99b063f818a19dcda999152d74c
prerequisite-patch-id: e3296f38cdba6d903e061cff2bbb3e7615e8e671
prerequisite-patch-id: bc4662b4710d302d4893f58708820fc2a0624325
prerequisite-patch-id: f8991f2e98c2661a706183fde6b35e2b8d9aedcf
prerequisite-patch-id: 44bf9ed69353586d284e5ee63d6fffa30439a698
prerequisite-patch-id: d50621bc630eeaf608bbaf260370c8dabf6326df

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

