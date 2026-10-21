Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792568991;
	b=yz/+FgfurDTi2vfeaY2nTkOzjNXru26lHVBFnqq0zzneULuzLrJyEVwNQEt56G+6Zlrf
	 FRlMLxshcZOTJKJbwk9d8x+b2kT3ba4sHrIT2jN9efVCIjWduTuoOyr4VXgpZQGbs4H7/
	 npb1KKHFk7It3UBEIHmeEv52KEAOc8kjXk6CIbBn5ra+EtnxCE/FjoLmh+zYhmebY0qj1
	 9LRPK/keT/zJ5avxdNiwczyBj4lzfK3DQM4BJ3yvcBZOIb6pI6VyGznzmJUcMt+/O88xQ
	 ir/TSkv0OuTcnNe5KdlL24/Sguydw1f+uNg1GtR1hGaTSSROo+8Nch4y5clP/9K66Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568991;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=cBuvcZ5fAuY78YRxSmJsRXbrsWm4GQ4YuR15OAOYw7I=;
	b=Nxq6xAzEVqPKL2GCQYGZLmz2lQe8YdpVcmG9YyaV6kJf1RSiN3Jwjv5ZVexqERWB4OEJ
	 +hGQu7Udbj5nU8iHceNrVldzSt4lKiCGWHxX/ksTAWn6lpX7wF3wRNDVqURRDmpr2cBKB
	 Nft7z3z3WoZi1/+dhANyd4g/Mk3194/zyRlobRd9Ly/4txOn2Zpa4Rz+PF+yMpXxaifL7
	 25dBgXXjxQlFlZW+Z2nHmoeFYdUJ8AA+E/cGOg+ZKRck9RwxPJiVsRWmXV7fgNYnTPlOI
	 btA9RjrPsvm2aqmDewZN329rF40i/W+dRlfZrpN+JxLA1KFym5uvTdkQVwd8q+rLiKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QsYe02Wf;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FFD606A31B
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 07:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31FFD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QsYe02Wf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792568989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cBuvcZ5fAuY78YRxSmJsRXbrsWm4GQ4YuR15OAOYw7I=;
	b=QsYe02WfEgsWlDxLqEoLv4QiMMYICVeYa9RKF7Racyuctp0jY7aVf3ygXAcodvQhR6v+nz
	wxh8LXYbjRXjLRyy6YtQAhuF527yTz7sXFCZkmo0UfA3FrR8qzFlwv02I47SOMzXlGZSSN
	QLCTyHl2pLhO00uZpOJnI9CxPEF74sM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-5oexspNvNRurG4ImmG47mA-1; Wed, 21 Oct 2026 07:49:47 +0000
X-MC-Unique: 5oexspNvNRurG4ImmG47mA-1
X-Mimecast-MFC-AGG-ID: 5oexspNvNRurG4ImmG47mA_1792568986
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4870142f030so214972f8f.2
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 00:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792568986; x=1793173786;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cBuvcZ5fAuY78YRxSmJsRXbrsWm4GQ4YuR15OAOYw7I=;
        b=jpIOrjF2/MBtKUH41iYFaBWpLJFhQGUqrOV0OmWET+mUUunI0V/X4rwAxVFvVNZa/G
         2ZJeGM84itLWSjTkX47Y2mzV9LqSy/EWkZ6u7Ys5poSddhIdiN/9HLV0MRpZDfrAuPYx
         FogK9nDIAdgCw68fiMQoGmuxTxp8gO+gaVRU2RAoQc8YTAwB8pC2P6engJTkK46Mag0d
         oXjszx8HtX/k+d9LqO6mKeUlRW3HouaJLfqayF0QT+YGzjsQ8qkJKUCyhOEkkCPnQU5E
         DRQiGID59Is1H9ou50yJGC9l9Dp/KpiHEcAEzUu/hxtE1sSoKMx9p7Je4AwORgOrQUso
         JzXA==
X-Forwarded-Encrypted: i=1; AKwUvBzOolIIdcbzFxbw7jE3FNEP7DcnPnwrV/ybO2ka3wC+bOTWsDdEoAOPZudY6t81eccLBJMGTauiRM7+llQuKA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLyEyiGtcFtJyWwveToOpOi2bfWdcKGdyfEPESVqLd/wZCE6vtE
	OhXuZTp48GGMigS/jMbbVLz+O8yAZIH7HlZ5DxMdJ1HdDgm8dk29ukGDmVkFmfSW9uSJNthsE34
	uqQuV4UOLT6FDb4RlCBEj7Q9Cqxp1Ur7LZoEBqz3J+PICnZqRiWPmePW0uuvqNS6mAeos
X-Gm-Gg: AYBFou2x+JJ7HBPVOc2vOu9LosS4e0KVsbrjR1IP7zV9fh8Yyc+4nvYJp0gnA0o+EDk
	IU3yxcRd5dE+2+wiyMKoEIFg7YNSD/+MahiMadjgiu+q7HBVskz5xOrb51WVcqhTHhbi9uWKX3w
	0SlKqBR0euDRQh6k/Ga9U08RqjxMQ/ySvp7reBDU54xgWGoIyvYDTdqHcw61HM0SBf5NQ412CYL
	i17YOyMTqb6EZpa/0LByWVh9s6sYLOitAkWlMwlOIhUN6gD3tVFxGLxWKzwvnv5n1GSREfoL3a2
	JmO1dJa93YEb8n7Gfmh7yV3buQ9PzEuZXOKlt/zTgA7TTts165w2lo6I30YRmLqC+e3Dpg==
X-Received: by 2002:a05:6000:2612:b0:48d:f58f:c98 with SMTP id ffacd0b85a97d-48e264d181bmr2118105f8f.40.1792568986159;
        Wed, 21 Oct 2026 00:49:46 -0700 (PDT)
X-Received: by 2002:a05:6000:2612:b0:48d:f58f:c98 with SMTP id ffacd0b85a97d-48e264d181bmr2118037f8f.40.1792568985523;
        Wed, 21 Oct 2026 00:49:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828ca3sm3811642f8f.25.2026.10.21.00.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:49:44 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:49:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Simon Horman <horms@kernel.org>, linux-um@lists.infradead.org
Subject: [PATCH net v4 1/7] net: account for ingress-resolved virtio net hdr
 state
Message-ID: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
References: <cover.v4.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.v4.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _MHRtMtiJa_B2wIGHKXr1WkZfsUF7FqEKMlWZ1h5y0E_1792568986
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following patch will add ingress resolution of uncommon virtio net
hdr checksum metadata (software checksum completion at ingress) which
adds performance overhead to the packet processing.

We should make it visible, so a hypothetical workload relying on
uncommon metadata can be distinguished from none at all. This way issues
in the parsing will be reported and not quietly pay the host-CPU
checksum overhead instead of offload.

Flip every call to virtio_net_hdr_to_skb to test for negative errno
only.  The um vector raw transport even ignored the return value
altogether: rejected packets went on into the stack with their
metadata unvalidated, so check it there as well.

Have tun, tap and virtio_net count these events per device as
rx_csum_sw, exposed via ethtool -S.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/vector_transports.c |  4 ++-
 drivers/net/ipvlan/ipvtap.c         | 36 +++++++++++++++++++++++++
 drivers/net/macvtap.c               | 36 +++++++++++++++++++++++++
 drivers/net/tap.c                   |  8 ++++--
 drivers/net/tun.c                   | 41 +++++++++++++++++++++++++++--
 drivers/net/virtio_net.c            | 15 ++++++++---
 include/linux/if_tap.h              |  1 +
 net/packet/af_packet.c              |  4 +--
 8 files changed, 135 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
index e1fb2a76fdff..8b7548458663 100644
--- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -210,7 +210,9 @@ static int raw_verify_header(
 		return 1;
 
 	skb_set_network_header(skb, ETH_HLEN);
-	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
+	if (virtio_net_hdr_to_skb(skb, vheader,
+			virtio_legacy_is_little_endian()) < 0)
+		return -1;
 	return 0;
 }
 
diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 66c949d94261..9e2f1c7073d2 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include "ipvlan.h"
 #include <linux/if_vlan.h>
 #include <linux/if_tap.h>
@@ -74,6 +75,32 @@ static void ipvtap_update_features(struct tap_dev *tap,
 	netdev_update_features(vlan->dev);
 }
 
+static int ipvtap_get_sset_count(struct net_device *dev, int sset)
+{
+	return sset == ETH_SS_STATS ? 1 : -EOPNOTSUPP;
+}
+
+static void ipvtap_get_strings(struct net_device *dev, u32 stringset,
+			       u8 *data)
+{
+	if (stringset == ETH_SS_STATS)
+		ethtool_puts(&data, "rx_csum_sw");
+}
+
+static void ipvtap_get_ethtool_stats(struct net_device *dev,
+				     struct ethtool_stats *stats,
+				     u64 *data)
+{
+	struct ipvtap_dev *vlantap = netdev_priv(dev);
+
+	data[0] = atomic64_read(&vlantap->tap.rx_csum_sw);
+}
+
+/* checkpatch warns but this can't be const: cloned from ipvlan's
+ * ops at newlink time, with the statistics above added.
+ */
+static struct ethtool_ops ipvtap_ethtool_ops;
+
 static int ipvtap_newlink(struct net_device *dev,
 			  struct rtnl_newlink_params *params,
 			  struct netlink_ext_ack *extack)
@@ -91,6 +118,15 @@ static int ipvtap_newlink(struct net_device *dev,
 	vlantap->tap.update_features =	ipvtap_update_features;
 	vlantap->tap.count_rx_dropped = ipvtap_count_rx_dropped;
 
+	/* ipvlan's ethtool ops are already installed at this point;
+	 * clone them and add the tap statistics on top.
+	 */
+	ipvtap_ethtool_ops = *dev->ethtool_ops;
+	ipvtap_ethtool_ops.get_sset_count = ipvtap_get_sset_count;
+	ipvtap_ethtool_ops.get_strings = ipvtap_get_strings;
+	ipvtap_ethtool_ops.get_ethtool_stats = ipvtap_get_ethtool_stats;
+	dev->ethtool_ops = &ipvtap_ethtool_ops;
+
 	err = netdev_rx_handler_register(dev, tap_handle_frame, &vlantap->tap);
 	if (err)
 		return err;
diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index cc975dfb7380..3288cc6ae6c2 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/if_macvlan.h>
 #include <linux/if_tap.h>
 #include <linux/if_vlan.h>
@@ -78,6 +79,32 @@ static void macvtap_update_features(struct tap_dev *tap,
 	netdev_update_features(vlan->dev);
 }
 
+static int macvtap_get_sset_count(struct net_device *dev, int sset)
+{
+	return sset == ETH_SS_STATS ? 1 : -EOPNOTSUPP;
+}
+
+static void macvtap_get_strings(struct net_device *dev, u32 stringset,
+				u8 *data)
+{
+	if (stringset == ETH_SS_STATS)
+		ethtool_puts(&data, "rx_csum_sw");
+}
+
+static void macvtap_get_ethtool_stats(struct net_device *dev,
+				      struct ethtool_stats *stats,
+				      u64 *data)
+{
+	struct macvtap_dev *vlantap = netdev_priv(dev);
+
+	data[0] = atomic64_read(&vlantap->tap.rx_csum_sw);
+}
+
+/* checkpatch warns but this can't be const: cloned from macvlan's
+ * ops at newlink time, with the statistics above added.
+ */
+static struct ethtool_ops macvtap_ethtool_ops;
+
 static int macvtap_newlink(struct net_device *dev,
 			   struct rtnl_newlink_params *params,
 			   struct netlink_ext_ack *extack)
@@ -99,6 +126,15 @@ static int macvtap_newlink(struct net_device *dev,
 	vlantap->tap.count_rx_dropped = macvtap_count_rx_dropped;
 	vlantap->tap.update_features  = macvtap_update_features;
 
+	/* macvlan's ethtool ops are already installed at this point;
+	 * clone them and add the tap statistics on top.
+	 */
+	macvtap_ethtool_ops = *dev->ethtool_ops;
+	macvtap_ethtool_ops.get_sset_count = macvtap_get_sset_count;
+	macvtap_ethtool_ops.get_strings = macvtap_get_strings;
+	macvtap_ethtool_ops.get_ethtool_stats = macvtap_get_ethtool_stats;
+	dev->ethtool_ops = &macvtap_ethtool_ops;
+
 	err = netdev_rx_handler_register(dev, tap_handle_frame, &vlantap->tap);
 	if (err)
 		return err;
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index ff67d99deb39..d7520622e809 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -649,11 +649,13 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
-		if (err) {
+		if (err < 0) {
 			rcu_read_unlock();
 			drop_reason = SKB_DROP_REASON_DEV_HDR;
 			goto err_kfree;
 		}
+		if (err > 0)
+			atomic64_inc(&tap->rx_csum_sw);
 	}
 
 	skb_probe_transport_header(skb);
@@ -1084,10 +1086,12 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
-		if (err) {
+		if (err < 0) {
 			rcu_read_unlock();
 			goto err_kfree;
 		}
+		if (err > 0)
+			atomic64_inc(&tap->rx_csum_sw);
 	}
 
 	skb_probe_transport_header(skb);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 242899f7fd07..19cb443c89b0 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -210,6 +210,7 @@ struct tun_struct {
 	u32 flow_count;
 	u32 rx_batched;
 	atomic_long_t rx_frame_errors;
+	atomic64_t rx_csum_sw;
 	struct bpf_prog __rcu *xdp_prog;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
@@ -1935,11 +1936,16 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
+	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
+	if (err < 0) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
 	}
+	if (err > 0) {
+		atomic64_inc(&tun->rx_csum_sw);
+		err = 0;
+	}
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
 		skb->protocol = eth_type_trans(skb, tun->dev);
@@ -2605,12 +2611,15 @@ static int tun_xdp_one(struct tun_struct *tun,
 	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
 	skb->dev = tun->dev;
 	skb_set_network_header(skb, ETH_HLEN);
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
+	ret = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr);
+	if (ret < 0) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
 		ret = -EINVAL;
 		goto out;
 	}
+	if (ret > 0)
+		atomic64_inc(&tun->rx_csum_sw);
 
 	skb->protocol = eth_type_trans(skb, tun->dev);
 	skb_reset_network_header(skb);
@@ -3739,7 +3748,35 @@ static void tun_get_channels(struct net_device *dev,
 	channels->max_combined = tun->flags & IFF_MULTI_QUEUE ? MAX_TAP_QUEUES : 1;
 }
 
+#define TUN_STATS_LEN	1
+static const char tun_ethtool_strings[TUN_STATS_LEN][ETH_GSTRING_LEN] = {
+	"rx_csum_sw",
+};
+
+static int tun_get_sset_count(struct net_device *dev, int sset)
+{
+	return sset == ETH_SS_STATS ? TUN_STATS_LEN : -EOPNOTSUPP;
+}
+
+static void tun_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	if (stringset == ETH_SS_STATS)
+		memcpy(data, tun_ethtool_strings,
+		       sizeof(tun_ethtool_strings));
+}
+
+static void tun_get_ethtool_stats(struct net_device *dev,
+				  struct ethtool_stats *stats, u64 *data)
+{
+	struct tun_struct *tun = netdev_priv(dev);
+
+	data[0] = atomic64_read(&tun->rx_csum_sw);
+}
+
 static const struct ethtool_ops tun_ethtool_ops = {
+	.get_sset_count		= tun_get_sset_count,
+	.get_strings		= tun_get_strings,
+	.get_ethtool_stats	= tun_get_ethtool_stats,
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
 	.get_drvinfo	= tun_get_drvinfo,
 	.get_msglevel	= tun_get_msglevel,
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index daab43ac92ce..b0441bf8e875 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -125,6 +125,7 @@ struct virtnet_rq_stats {
 	u64_stats_t packets;
 	u64_stats_t bytes;
 	u64_stats_t drops;
+	u64_stats_t rx_csum_sw;
 	u64_stats_t xdp_packets;
 	u64_stats_t xdp_tx;
 	u64_stats_t xdp_redirects;
@@ -158,6 +159,7 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
 
 static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 	VIRTNET_RQ_STAT("drops",         drops),
+	VIRTNET_RQ_STAT("rx_csum_sw",    rx_csum_sw),
 	VIRTNET_RQ_STAT("xdp_packets",   xdp_packets),
 	VIRTNET_RQ_STAT("xdp_tx",        xdp_tx),
 	VIRTNET_RQ_STAT("xdp_redirects", xdp_redirects),
@@ -2502,6 +2504,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 {
 	struct virtio_net_common_hdr *hdr;
 	struct net_device *dev = vi->dev;
+	int ret;
 
 	hdr = skb_vnet_common_hdr(skb);
 	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
@@ -2517,15 +2520,21 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 
 	skb->dev = dev;
 	skb_set_network_header(skb, ETH_HLEN);
-	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
-				      vi->rx_tnl_csum,
-				      virtio_is_little_endian(vi->vdev))) {
+	ret = virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
+					vi->rx_tnl_csum,
+					virtio_is_little_endian(vi->vdev));
+	if (ret < 0) {
 		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
 				     dev->name, hdr->hdr.gso_type,
 				     hdr->hdr.gso_size, hdr->hdr.flags,
 				     vi->rx_tnl, vi->rx_tnl_csum);
 		goto frame_err;
 	}
+	if (ret > 0) {
+		u64_stats_update_begin(&rq->stats.syncp);
+		u64_stats_inc(&rq->stats.rx_csum_sw);
+		u64_stats_update_end(&rq->stats.syncp);
+	}
 
 	skb_record_rx_queue(skb, vq2rxq(rq->vq));
 	skb->protocol = eth_type_trans(skb, dev);
diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
index 553552fa635c..4eac24bb1df7 100644
--- a/include/linux/if_tap.h
+++ b/include/linux/if_tap.h
@@ -41,6 +41,7 @@ struct tap_dev {
 	struct list_head	queue_list;
 	int			numvtaps;
 	int			numqueues;
+	atomic64_t		rx_csum_sw;
 	netdev_features_t	tap_features;
 	int			minor;
 
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 52ae3d875e97..e6aec9ecfa99 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2913,7 +2913,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		}
 
 		if (has_vnet_hdr) {
-			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
+			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
@@ -3136,7 +3136,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 
 	if (vnet_hdr_sz) {
 		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
-		if (err)
+		if (err < 0)
 			goto out_free;
 		len += vnet_hdr_sz;
 	}
-- 
MST

