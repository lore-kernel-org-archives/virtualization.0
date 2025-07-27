Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D529B0
	for <virtualization@lists.linux.dev>; Sun, 27 Jul 2025 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753599472; cv=none; b=EsIiI+0R1sF7grmUy0xBrX5mDcMseBupav+JEC67pRgFMKbBLdXY+GheTLIRq6jUL6AkhSrq8RDH9XHcYYCEWNg6f2KZZ+3i+/evXb7FX/E47atXkXwyzzT5cIdH4GRqzw3HVXAqW4TjBjNa/YeQiMukeo5oliU4CZg7F+DVDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753599472; c=relaxed/simple;
	bh=KYnrQFc1ctDhkZduHGAUpm3CSE9wsRT43CxSVEH8nFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=shBQu2DzIVvgleqTezOBNsCknCHMv/bRk4mBKI3OsiEYEi91iLbu7ZC3wF63t0Kusrg8JxxppzqiAnPNtmIw8T3S2q8YdtEuasb+KBnTHB39xKCLQW/iMin3XODbFxDR5NsZ9eFHCoolq+mad8PvHS3HScxkNAtftSuqlQiQx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=PR4nWHnn reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="PR4nWHnn"
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56R6Ml3s093507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 27 Jul 2025 15:22:54 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Akdb0YA3jwzUaEHtZ7YvqK6+migMLbF4VDzJ6CtcXI0=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Date:Subject:Message-Id:To;
        s=rs20250326; t=1753597374; v=1;
        b=PR4nWHnn+dOnW0hrKyhD6P5aXYAbmzEeKQFIyM4scb8zRrhizr3knYy5+EgJYd3F
         aah7CIs/VMSoX5ZW/S0fDMicPGZgAabSEkq7m4oMyHkck/2hWpziyGu98mMHovfb
         2vXr6wuPJWI+8sObSZZg/IDfAhbU9vfOwxpd4QojRFlZ1gcammG7Ui/+3Tmm5I4u
         CgZbWGAGzRXd2q/XPXQlqvVmsr1pNalJgD5v03PcrqyvLLkjgLpibluZXGpODXo8
         22Ll81t02Q+ZWpCXK2QjUh3e2Wk1cDvh7PLI7rt6fjILwroh/r2p+hjeoUK6swQZ
         GXbpG2i7lGhRhPB7567vwQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 27 Jul 2025 15:22:36 +0900
Subject: [PATCH v3] virtio-net: Fix VLAN filter table reset timing
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-vlan-v3-1-bbee738619b1@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAKvFhWgC/3XMSwrCMBSF4a1IxiY0j74cuQ9xcJuk7VVpSlKDp
 XTvpsWBCA7/w+FbSLAebSCnw0K8jRjQDSnk8UB0D0NnKZrURGQiz0ouaXzAQCvNsxKKHEzNSbq
 O3rb42pnLNXWPYXJ+3tXIt/UHiJxyClK3WaNbKJQ6+9AxjQzZk07uPjsGmt1GsmlRfAvqI4gkC
 JNXdQPKaCP/Cuu6vgEiBzpQ5wAAAA==
X-Change-ID: 20250713-vlan-8c107a65ad91
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, qemu-devel@nongnu.org
Cc: yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux.dev,
        qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
        Lei Yang <leiyang@redhat.com>
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
Tested-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
Not tested.

Konstantin, I would also want you to test this new version. Please also
give it Tested-by, and, if possible, Reviewed-by.
---
Changes in v3:
- Dropped RFC.
- Rebased.
- Link to v2: https://lore.kernel.org/qemu-devel/20250714-vlan-v2-1-2d589ba4dcd3@rsg.ci.i.u-tokyo.ac.jp

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
index c4c49b0f9caa1e8f26fa2e03acc8786936877eba..6b5b5dace334af12e9b77a8a2765c88443cee235 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -929,8 +929,9 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         vhost_net_save_acked_features(nc->peer);
     }
 
-    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
-        memset(n->vlans, 0xff, MAX_VLAN >> 3);
+    if (virtio_has_feature(vdev->guest_features ^ features, VIRTIO_NET_F_CTRL_VLAN)) {
+        bool vlan = virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN);
+        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
     }
 
     if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
@@ -3942,6 +3943,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
 
     n->vlans = g_malloc0(MAX_VLAN >> 3);
+    memset(n->vlans, 0xff, MAX_VLAN >> 3);
 
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
@@ -4041,7 +4043,6 @@ static void virtio_net_reset(VirtIODevice *vdev)
     memset(n->mac_table.macs, 0, MAC_TABLE_ENTRIES * ETH_ALEN);
     memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
     qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
-    memset(n->vlans, 0, MAX_VLAN >> 3);
 
     /* Flush any async TX */
     for (i = 0;  i < n->max_queue_pairs; i++) {

---
base-commit: 9e601684dc24a521bb1d23215a63e5c6e79ea0bb
change-id: 20250713-vlan-8c107a65ad91

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

