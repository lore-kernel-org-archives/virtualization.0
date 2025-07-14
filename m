Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034002E3718
	for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485526; cv=none; b=lTOppmmoSEd1ETvkVtL3k6fPqT8sfH6jGsGzBCCWPTkzX3rfgvZV9kHzgW13WNVFA6EeqdyaAA3NTAxL0k0lFfcpLto3vi8OoTIdO42R1wrBRSCANp+2pzJfjb0cDZQDsM4KTNHfKtDSfXjE2spavQ3tfWI5qLMkQhXcuiWGJCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485526; c=relaxed/simple;
	bh=0xLUay+zqVzSSxgOHZ9QKM5GVub9jYMOsrtJ0OmHY18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KzPKxHczqFpTxHsvgEbiOxalRLCY7KObgafw5mluGHUwHt4CTEszEarIrFzfiyd1U2wFccnN94QQH+zaf3PfW7ySaHKaZJtWH8Z6+8yMDWzGHaFlCOpXjVhGlfzvcl7uRZz8QUy0el1GjVCZJe6OVP9gyIusR8P88cRkrpfDw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=qpJEdJQ4 reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="qpJEdJQ4"
Received: from [157.82.206.39] ([157.82.206.39])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56E9Viad087593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 14 Jul 2025 18:31:57 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+8HGDbhAn09FdTQ9BmyGXXC74ug6db6ifTOWovIuvN8=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Date:Subject:Message-Id:To;
        s=rs20250326; t=1752485517; v=1;
        b=qpJEdJQ48ygDI4blgZL1+UNUvswKQ3BMii/HDNjNOZsk8W4idsl6Pd6Yw01J3Ahm
         Y4CtDP3THnS10zQqYPYCjqvmmf6xiSJzTuTAMgSGrMMaxbOEK6GDw9cUDKGHwJfJ
         gBUEn7BObvQMJ/wtSNDF6PclILy1Bz+SkwdwG9rqhZm8sTP3ad7YcloRRBvna+PY
         p4B11ad06DZ1SJKIMhFo/3lZarYCwJ4+1sU6JP3yxFuPYihwe1MxtfLKJLVhvWrQ
         a2YzpfsNbudM6cQbzXDm6YGa5cBhTj1k/3/ANwft7pgxiVsyh9aHBY4z/HsEg2az
         kKGimGjvFxvESvipG/sfEA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 14 Jul 2025 18:31:41 +0900
Subject: [PATCH RFC v2] virtio-net: Fix VLAN filter table reset timing
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-vlan-v2-1-2d589ba4dcd3@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAHzOdGgC/1WMywrCMBBFf6XM2oSkT3UlCH6AW+liTNN2qiQlq
 cFS8u+G7lyeew9nA68daQ/nbAOnA3myJkF+yECNaAbNqEsMucgr0ciChTcadlRSNFhX2J0kJHV
 2uqfvnnnA/XaFNo0j+cW6dU8HuV//lSCZZFioXjxVj3VZXpwfuCJO/MMW+1otR8WnGdoY4w9iO
 4RMqgAAAA==
X-Change-ID: 20250713-vlan-8c107a65ad91
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, qemu-devel@nongnu.org
Cc: yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux.dev,
        qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2

Problem
-------

The expected initial state of the table depends on feature negotiation:

With VIRTIO_NET_F_CTRL_VLAN:
  The table must be empty in accordance with the specification.
Without VIRTIO_NET_F_CTRL_VLAN:
  The table must be filled to permit all VLAN traffic.

Prior to commit 06b636a1e2ad ("virtio-net: do not reset vlan filtering
at set_features"), virtio_net_set_features() always reset the VLAN
table. That commit changed the behavior to skip table reset when
VIRTIO_NET_F_CTRL_VLAN was negotiated, assuming the table would be
properly cleared during device reset and remain stable.

However, this assumption breaks when a driver renegotiates features:
1. Initial negotiation without VIRTIO_NET_F_CTRL_VLAN (table filled)
2. Renegotiation with VIRTIO_NET_F_CTRL_VLAN (table will not be cleared)

The problem was exacerbated by commit 0caed25cd171 ("virtio: Call
set_features during reset"), which triggered virtio_net_set_features()
during device reset, exposing the bug whenever VIRTIO_NET_F_CTRL_VLAN
was negotiated after a device reset.

Solution
--------

Fix the issue by initializing the table when virtio_net_set_features()
is called to change the VIRTIO_NET_F_CTRL_VLAN bit of
vdev->guest_features.

This approach ensures the correct table state regardless of feature
negotiation sequence by performing initialization in
virtio_net_set_features() as QEMU did prior to commit 06b636a1e2ad
("virtio-net: do not reset vlan filtering at set_features").

This change still preserves the goal of the commit, which was to avoid
resetting the table during migration, by checking whether the
VIRTIO_NET_F_CTRL_VLAN bit of vdev->guest_features is being changed;
vdev->guest_features is set before virtio_net_set_features() gets called
during migration.

It also avoids resetting the table when the driver sets a feature
bitmask with no change for the VIRTIO_NET_F_CTRL_VLAN bit, which makes
the operation idempotent and its semantics cleaner.

Additionally, this change ensures the table is initialized after
feature negotiation and before the DRIVER_OK status bit being set for
compatibility with the Linux driver before commit 50c0ada627f5
("virtio-net: fix race between ndo_open() and virtio_device_ready()"),
which did not ensure to set the DRIVER_OK status bit before modifying
the table.

Fixes: 06b636a1e2ad ("virtio-net: do not reset vlan filtering at set_features")
Cc: qemu-stable@nongnu.org
Reported-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Not tested.

Konstantin, I would also want you to test this new version. Please also
give it Tested-by, and, if possible, Reviewed-by.
---
Changes in v2:
- Addressed a concern with old drivers that do not properly set
  DRIVER_OK (pointed out by Michael S. Tsirkin).
- Noted that this change does not simply revert commit 06b636a1e2ad
  ("virtio-net: do not reset vlan filtering at set_features") but
  preserves its goal.
- Added Cc: qemu-stable@nongnu.org.
- Link to v1: https://lore.kernel.org/qemu-devel/20250713-vlan-v1-1-a3cf0bcfa644@rsg.ci.i.u-tokyo.ac.jp
---
 hw/net/virtio-net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 221252e00a50a46033d7ec8d18936e7c8196a6ca..623c11b82e0a7fe1ae0095bf23a285f66322b948 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -998,8 +998,9 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         vhost_net_save_acked_features(nc->peer);
     }
 
-    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
-        memset(n->vlans, 0xff, MAX_VLAN >> 3);
+    if (virtio_has_feature(vdev->guest_features ^ features, VIRTIO_NET_F_CTRL_VLAN)) {
+        bool vlan = virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN);
+        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
     }
 
     if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
@@ -3900,6 +3901,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
 
     n->vlans = g_malloc0(MAX_VLAN >> 3);
+    memset(n->vlans, 0xff, MAX_VLAN >> 3);
 
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
@@ -3990,7 +3992,6 @@ static void virtio_net_reset(VirtIODevice *vdev)
     memset(n->mac_table.macs, 0, MAC_TABLE_ENTRIES * ETH_ALEN);
     memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
     qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
-    memset(n->vlans, 0, MAX_VLAN >> 3);
 
     /* Flush any async TX */
     for (i = 0;  i < n->max_queue_pairs; i++) {

---
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
change-id: 20250713-vlan-8c107a65ad91

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

