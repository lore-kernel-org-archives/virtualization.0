Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03AB33B969
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769039142; cv=none; b=JOpFXcUylt13s2FdKBnzSR3/tAz12usv3zmeTi4QakELdFi1aWiSYcYB6cvdGkMTtfnhDxFsU475OdapvnG90meT+fcXAN1Js3aGOjD5jcaLj3iQG1BRC3EVYBLdz6bS3MPVdcSjKRpulEb96UL1R0ZOhIv9dwlbxsoDM2rnNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769039142; c=relaxed/simple;
	bh=etwwWKr9Y14dXlHdkKjstCZfaDIPKSpATnqO6LamcNw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bK0eXjaXLshQ+X6bDtyG6/WoCtIW8S3Hx2uegZWQOMPJwKyHRkh7zvulBuYO+hkELfczb3r2WoBgoeeG+Asy7WD4woQxRM2MtLQB0kvQga4pf+CbNye9rT1IfrsiKHG28l9ZyzxjQZupaq9jpiZHRnfJ4eyI1zoye5hPoNcgGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhhcabrb; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhhcabrb"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-502a98c66f7so2810561cf.1
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 15:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769039138; x=1769643938; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lg4FY/CZvQhWjrS9kUd/hUaO0JJyEisDgMtnXczdMcQ=;
        b=mhhcabrblZWtjVpeEVDHiRy9U2NR9IzWvTlU+gZH3ZAimSywzLAgRO6op/2w9jJSBx
         A3vxBwis7F3dnkN6zHL/ZS3EKfL42O2O7x2fTphkesABqTc8cLRRt21BsdKND2CFOsof
         wA4UL+VW8yoSGu3oHz1d0vvJGkYhm/l55MixXnMxjvv71xqTt+5NSPXuQmw64agqeru1
         sNSfBVc/xPNav+TGYqjFPWAH1cwOLQ8Z2usXsImx4WfuX5JQ7cim0SmRearq9b2xbjXZ
         JCRnTEc6ovwiNywiL7E65VMsTEPQV595uPbU0N1yKxe7pvr7woUtjNVVs2hg/91lRw1P
         +Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769039138; x=1769643938;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lg4FY/CZvQhWjrS9kUd/hUaO0JJyEisDgMtnXczdMcQ=;
        b=ah3FKmDI4zhaMZRuiGmhIebQkGSHVasOfS2cG/1aNmuZe7bueoDBsioYx8XTsJVFiU
         rAXgScuq8CyO4zR/kSnPkIwV0Nvwh+jmAEMjJjPypH6tsgzuI5cX/vKZbw+oeelxnFtC
         IaTmBJzPMTrelL23YTJr7XoO1dAbpD3w7fL88nMw1JNA6lpt6O52vRWEeK1vv8VbeM3d
         wWIpAcJMHKPULUXx9zygnGzE3f20/ifxOAQxjbzdI6/ftofMkqEgzdtbUO1DA+8QQZxw
         ObHcXT5ZCYDLMLRaMhMY7btyu0PHakL2dJW4ZDfmSsiSXUUtWvnEN5ptHDWSvLqMslOi
         6r/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOFDBGiV3+osybZHmoZvUSjcHEDuoxiSEBvlo8TxvcplkMeWiUkt3d6j3Go7FYARh9k8XkkieLqzqAsQDL8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQHfxxb/ELypElJkCEDvif4NMFdKE2ugCpGTvIGc5TPu6zINpr
	HhHncjt8ddKhe3gU5N1Oet10w7Cl52U8A9B6PTHiP1PlcvQqI+BNBku4kehr4w==
X-Gm-Gg: AZuq6aLFdvRLfsnynODLoW/Ldx7r8qpeTA2POC5ilCFFSHzA5Yr6x8HdLkrphAQzhQJ
	zp7AZOnPdovLerBE5BjSzcRV7Lye/4WgPWkRuWUV1wQnnCAoJlEwOHxrlcGGRNmH7+9Gu+nhbFF
	wsVGYrQySapK/Fwnhp8VRboYHINmaSfKM1KCxynHhqSPzk78JzQknI1fT/a8vlovFBOim6lTgy+
	hYiteuCyla+rsWG6wEjxV9uB3WCtjfPDRWESiubw0qgDfzdVYmfcmI5EVYj98RfMTjLNLj6LZi/
	W3MgEhW1FD+hqiDaNIydSlNM9JcDZaLILva6axhmX4hp8dEbGSXrfuUfF3yZdHLvj01RGOt36iB
	VYueWq3Yk4WYkANpPJuZ9qFhTrFH0Or3oOrprSlo3Bw3+RWKf3h6MXaRlAsjUyOZPKeydp+RWKp
	4alFGwdkXy7A==
X-Received: by 2002:a05:690c:6d82:b0:794:267c:725f with SMTP id 00721157ae682-794267c8291mr18582147b3.52.1769033519293;
        Wed, 21 Jan 2026 14:11:59 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7941ad16ff4sm14445287b3.20.2026.01.21.14.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:11:58 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v16 00/12] vsock: add namespace support to
 vhost-vsock and loopback
Date: Wed, 21 Jan 2026 14:11:40 -0800
Message-Id: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1PcWkC/5XUzW7bMAzA8VcxdA4HkjJlOae+x9CDPujW2JJ0t
 md0KPLuQ9yi0eRedjZ+/BsEoTcz6zTqbI7Nm5l0HefxcjbHhtyhMek5nJ8UxmyOjWFkQcsC63x
 JP2A9LTovEG1gykzIic2hMS+TDuPrNu+7OesCZ31dzOOhMc/jvFymP1tope37NrIl/HfkSkAwW
 Amecoi9Tw9PpzD+/JYup23QyiXuKsxAYHukwJ21pL7GtsDsK2yBgDyFwZGzg9Uat3csWJdbIHD
 Koe/YccquwIeP9XmUHUJA6TUJhUhEDyddwj0oRZBsZQUIWu0ktaGVpPGrIHc7hIAxiMeoWSVWQ
 VcG6591QNCHgVJCtj3iF8Ge3A4hoGsza8Tk+1wFu88gIVNlu806il10A/piOx+9/zJbz5e9eqM
 eELKG3rcZOUasLOEd0+7yCG96QD+Qk3i7nkpToXl39AQIIikmj9z2oas1l7peMjEgsHSqTClL3
 rU/L9chEdf6doVBkrWco1Wuj4Kk1Lv27aRiHDIF57y0vtDX9ydh0l+/x3lc3t+Fx+v1L1NJZ+t
 3BAAA
X-Change-ID: 20250325-vsock-vmtest-b3a21d2102c2
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series adds namespace support to vhost-vsock and loopback. It does
not add namespaces to any of the other guest transports (virtio-vsock,
hyperv, or vmci).

The current revision supports two modes: local and global. Local
mode is complete isolation of namespaces, while global mode is complete
sharing between namespaces of CIDs (the original behavior).

The mode is set using the parent namespace's
/proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
created. The mode of the current namespace can be queried by reading
/proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
has been created.

Modes are per-netns. This allows a system to configure namespaces
independently (some may share CIDs, others are completely isolated).
This also supports future possible mixed use cases, where there may be
namespaces in global mode spinning up VMs while there are mixed mode
namespaces that provide services to the VMs, but are not allowed to
allocate from the global CID pool (this mode is not implemented in this
series).

Additionally, added tests for the new namespace features:

tools/testing/selftests/vsock/vmtest.sh
1..25
ok 1 vm_server_host_client
ok 2 vm_client_host_server
ok 3 vm_loopback
ok 4 ns_host_vsock_ns_mode_ok
ok 5 ns_host_vsock_child_ns_mode_ok
ok 6 ns_global_same_cid_fails
ok 7 ns_local_same_cid_ok
ok 8 ns_global_local_same_cid_ok
ok 9 ns_local_global_same_cid_ok
ok 10 ns_diff_global_host_connect_to_global_vm_ok
ok 11 ns_diff_global_host_connect_to_local_vm_fails
ok 12 ns_diff_global_vm_connect_to_global_host_ok
ok 13 ns_diff_global_vm_connect_to_local_host_fails
ok 14 ns_diff_local_host_connect_to_local_vm_fails
ok 15 ns_diff_local_vm_connect_to_local_host_fails
ok 16 ns_diff_global_to_local_loopback_local_fails
ok 17 ns_diff_local_to_global_loopback_fails
ok 18 ns_diff_local_to_local_loopback_fails
ok 19 ns_diff_global_to_global_loopback_ok
ok 20 ns_same_local_loopback_ok
ok 21 ns_same_local_host_connect_to_local_vm_ok
ok 22 ns_same_local_vm_connect_to_local_host_ok
ok 23 ns_delete_vm_ok
ok 24 ns_delete_host_ok
ok 25 ns_delete_both_ok
SUMMARY: PASS=25 SKIP=0 FAIL=0

Thanks again for everyone's help and reviews!

Suggested-by: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>

Changes in v16:
- updated comments/docs/commit msg (vsock_find_* funcs, init net
  mode, why change random port alloc)
- removed init ns mode cmdline
- fixed the missing ${ns} arg for vm_ssh in vmtest.sh
- Link to v15: https://lore.kernel.org/r/20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com

Changes in v15:
- see per-patch change notes in 'vsock: add netns to vsock core'
- Link to v14: https://lore.kernel.org/r/20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com

Changes in v14:
- squashed 'vsock: add per-net vsock NS mode state' into 'vsock: add
  netns to vsock core' (MST)
- remove RFC tag
- fixed base-commit (still had b4 configured to depend on old vmtest.sh
  series)
- Link to v13: https://lore.kernel.org/all/20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com/

Changes in v13:
- add support for immutable sysfs ns_mode and inheritance from sysfs child_ns_mode
- remove passing around of net_mode, can be accessed now via
  vsock_net_mode(net) since it is immutable
- update tests for new uAPI
- add one patch to extend the kselftest timeout (it was starting to
  fail with the new tests added)
- Link to v12: https://lore.kernel.org/r/20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com

Changes in v12:
- add ns mode checking to _allow() callbacks to reject local mode for
  incompatible transports (Stefano)
- flip vhost/loopback to return true for stream_allow() and
  seqpacket_allow() in "vsock: add netns support to virtio transports"
  (Stefano)
- add VMADDR_CID_ANY + local mode documentation in af_vsock.c (Stefano)
- change "selftests/vsock: add tests for host <-> vm connectivity with
  namespaces" to skip test 29 in vsock_test for namespace local
  vsock_test calls in a host local-mode namespace. There is a
  false-positive edge case for that test encountered with the
  ->stream_allow() approach. More details in that patch.
- updated cover letter with new test output
- Link to v11: https://lore.kernel.org/r/20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com

Changes in v11:
- vmtest: add a patch to use ss in wait_for_listener functions and
  support vsock, tcp, and unix. Change all patches to use the new
  functions.
- vmtest: add a patch to re-use vm dmesg / warn counting functions
- Link to v10: https://lore.kernel.org/r/20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com

Changes in v10:
- Combine virtio common patches into one (Stefano)
- Resolve vsock_loopback virtio_transport_reset_no_sock() issue
  with info->vsk setting. This eliminates the need for skb->cb,
  so remove skb->cb patches.
- many line width 80 fixes
- Link to v9: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-0-852787a37bed@meta.com

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
Bobby Eshleman (12):
      vsock: add netns to vsock core
      virtio: set skb owner of virtio_transport_reset_no_sock() reply
      vsock: add netns support to virtio transports
      selftests/vsock: increase timeout to 1200
      selftests/vsock: add namespace helpers to vmtest.sh
      selftests/vsock: prepare vm management helpers for namespaces
      selftests/vsock: add vm_dmesg_{warn,oops}_count() helpers
      selftests/vsock: use ss to wait for listeners instead of /proc/net
      selftests/vsock: add tests for proc sys vsock ns_mode
      selftests/vsock: add namespace tests for CID collisions
      selftests/vsock: add tests for host <-> vm connectivity with namespaces
      selftests/vsock: add tests for namespace deletion

 MAINTAINERS                             |    1 +
 drivers/vhost/vsock.c                   |   44 +-
 include/linux/virtio_vsock.h            |    9 +-
 include/net/af_vsock.h                  |   61 +-
 include/net/net_namespace.h             |    4 +
 include/net/netns/vsock.h               |   21 +
 net/vmw_vsock/af_vsock.c                |  335 +++++++++-
 net/vmw_vsock/hyperv_transport.c        |    7 +-
 net/vmw_vsock/virtio_transport.c        |   22 +-
 net/vmw_vsock/virtio_transport_common.c |   62 +-
 net/vmw_vsock/vmci_transport.c          |   26 +-
 net/vmw_vsock/vsock_loopback.c          |   22 +-
 tools/testing/selftests/vsock/settings  |    2 +-
 tools/testing/selftests/vsock/vmtest.sh | 1055 +++++++++++++++++++++++++++++--
 14 files changed, 1531 insertions(+), 140 deletions(-)
---
base-commit: d8f87aa5fa0a4276491fa8ef436cd22605a3f9ba
change-id: 20250325-vsock-vmtest-b3a21d2102c2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

