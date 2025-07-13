Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E514F121
	for <virtualization@lists.linux.dev>; Sun, 13 Jul 2025 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752407598; cv=none; b=Ea8F1PzljJhDVtIa/ClEbhJTV7g9dWrgNavFmZTfCE7Fg6Cpej3Oz5NgeIDV8EdTBJ0Ku6CsU14540edu/JpRknCxuGb4JQhGe1yulDA5nb/x98vOxgnGnjQ4sREopvbIetoZQXIuEyfaye+LjPf2ca0Iz5bLg/O/fvbhyirVys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752407598; c=relaxed/simple;
	bh=EjZMixSMyf/+k9Uf+UuW37lD8CUY2HbzyZPnbpa64xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X93sSNUNNnRHTDJ90lV/R6xujbITrYx/aZUeXINpCdba9K+XFIrhPgahGXXSuKVPnAgDb+0S4qlHWSVU322ghaBoVK+0z0V9qV0IPYdZnx8UTM5cM6FcGMYPcdKLqS2ATHtGZQHnc24Rv8MVcDhH7M+FOLujPc+/LYDoM7mIDLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=cWHWVf/E reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="cWHWVf/E"
Received: from [157.82.206.39] ([157.82.206.39])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56DBqs5v008236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 13 Jul 2025 20:53:04 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=6Nu6gtWRB9pwKQY119OYVqFA5/pvFCpiOh/jk2M0fIE=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Date:Subject:Message-Id:To;
        s=rs20250326; t=1752407584; v=1;
        b=cWHWVf/ESado64JOp+fYKbSzSSwxxp9MHbTcrchhqqhZvf3kFibUEOCXZZmHwW/e
         +mvWv7dKBziRCundYD+lAndaMTYn1ZXfcBbYybGtFGojWqCJaEfDUj4qqnFqwN7q
         aX17Mh8KNK1XY2cL+YCzvggu9fqauxhgT3b/tDNT0/4aDKrNXMZRJeRmVXYFET5b
         jGMcDVgECWNn5n01zAQyzavza4N2Mqk49dMkw1USyvSOKCW/EdyxbmzgpCm+xHSD
         u6D8d7tUiJzhRlXlYIGvkjaO8/v4qUjqvpbG24uUSoX3Z4LRp/pF4Msy0x7o/Dch
         dxOWKA700bt9bQsboRSOOA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 13 Jul 2025 20:52:43 +0900
Subject: [PATCH RFC] virtio-net: Fix VLAN filter table initialization
 timing
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-vlan-v1-1-a3cf0bcfa644@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAqec2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Nj3bKcxDxdi2RDA/NEM9PEFEtDJaDSgqLUtMwKsDHRSkFuzkqxtbU
 AE16dolsAAAA=
X-Change-ID: 20250713-vlan-8c107a65ad91
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, qemu-devel@nongnu.org
Cc: yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux.dev,
        Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2

The VLAN filter table was not being properly initialized when the driver
sets the DRIVER_OK status bit, causing incorrect VLAN filtering behavior
that could allow unintended VLAN packets to pass through. Correct the
table initialization timing to fix the issue.

Problem
-------

The expected initial state of the table depends on feature negotiation:

With VIRTIO_NET_F_CTRL_VLAN:
  The table must be empty in accordance with the specification.
Without VIRTIO_NET_F_CTRL_VLAN:
  The table should be filled to permit all VLAN traffic.

Prior to commit  ("virtio-net: do not reset vlan filtering at
set_features"), virtio_net_set_features() always initialized the VLAN
table. That commit changed the behavior to skip initialization when
VIRTIO_NET_F_CTRL_VLAN was negotiated, assuming the table would be
properly cleared during reset and remain stable.

However, this assumption breaks when a driver renegotiates features:
1. Initial negotiation without VIRTIO_NET_F_CTRL_VLAN (table filled)
2. Renegotiation with VIRTIO_NET_F_CTRL_VLAN (table will not be cleared)

The problem was exacerbated by commit 0caed25cd171 ("virtio: Call
set_features during reset"), which triggered virtio_net_set_features()
during reset, exposing the bug whenever VIRTIO_NET_F_CTRL_VLAN was
negotiated after a reset.

Solution
--------

Fix by moving VLAN table initialization to virtio_net_set_status(),
which sets the DRIVER_OK status bit. This ensures proper table
initialization regardless of feature negotiation sequence.

Fixes: 06b636a1e2ad ("virtio-net: do not reset vlan filtering at set_features")
Reported-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Not tested.

Konstantin, please see if this patch fixes your workload.
---
 hw/net/virtio-net.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 221252e00a50a46033d7ec8d18936e7c8196a6ca..6d2a67471e570e1e9b4b4fb5338d87c30e23ae36 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -389,6 +389,12 @@ static int virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
     int i;
     uint8_t queue_status;
 
+    if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+        !(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+        bool vlan = virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VLAN);
+        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
+    }
+
     virtio_net_vnet_endian_status(n, status);
     virtio_net_vhost_status(n, status);
 
@@ -998,10 +1004,6 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         vhost_net_save_acked_features(nc->peer);
     }
 
-    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
-        memset(n->vlans, 0xff, MAX_VLAN >> 3);
-    }
-
     if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
         qapi_event_send_failover_negotiated(n->netclient_name);
         qatomic_set(&n->failover_primary_hidden, false);
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

