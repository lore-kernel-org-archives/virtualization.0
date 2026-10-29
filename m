Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300005;
	b=e3fcGnhPrlfbDZ1+5JS7LfxaTZfNob7oaYRiB9ip6N6lI4GTCw6z2/jUZBk9RgM/8jZQ
	 rduA5GXPHV+nifVgo8MTABhAW2WvhZJN/1ZNRFbWlL0IUUOw2MkgdACJxH7GLI+fuo4HH
	 pXEGD+EIVzYSac8x74vN4Rym2qNJRmC35nYRf0UcDaELfvl1JI75ll90QpPiCiKcJQHF1
	 0TSi7GxXbzXW+MDcW2Bd6x3o/TzBGSMKXzPDqwktHroHwAwoUsLpfWlGrNxeq528vfmy6
	 MaI90Dr6Xc4WnGY+EwtZsOfN1JaOhSYCZdqOBLOEo2i3CyNNqsAlY6Eum+glN5uXyYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300005;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=Kl5aqa/5huOMBjE/HMjqhWjp8eowVgL7maZxpKhEQks=;
	b=ElOCT3zTAb92M0O5CsMjC5FSJmpLRkE7Z08mUq226dxcHdd9E1XF5/u1ayIXqBdP5xXC
	 4+6IXDGkKr+nEK67lOXrQUBaIUBk729pjLXEMZMZ2cb5Xlm2rFgXxzAmj4MFRFMli1oCJ
	 /B0yKqFEr0bqx+aFnl4kCnt8nS7V1ENAGEF4K1CCczWpO/j100E7vfKacDrl0K0wKrs+j
	 98QHuuw3HjBhIlbWGIvmBogUkrHZ10uukTLaiGryNEaJkWZqF+bgqJsSLo8oQwBDyxyGO
	 IGtvfxOuuKS/RBe2q6eZieiRyS/MMJItqxEV24JkCQsenkiagGsihaGEeLSXk4nyD7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X63AX3+Y;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A11A60A2610
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 18:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A11A60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X63AX3+Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793300004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kl5aqa/5huOMBjE/HMjqhWjp8eowVgL7maZxpKhEQks=;
	b=X63AX3+Y5PFR564t1rnhVAoFI4pO6KghOUEb2zpEMMMsIycwkWaxIYSexRnlsxIGB2e4GG
	2RY4AkE67ltlECj73hAsKu8ZAcwDAgN3+Pp2NgEl/9ohXbF2Ybu5QbnYm3a8cz7QEZImUM
	JciNfPTdC3Qr/J4Ji7qkMLVtpzExUKE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-CoeQN3ExN3OPFWjxdos4Fw-1; Thu, 29 Oct 2026 14:53:21 -0400
X-MC-Unique: CoeQN3ExN3OPFWjxdos4Fw-1
X-Mimecast-MFC-AGG-ID: CoeQN3ExN3OPFWjxdos4Fw_1793300000
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so21201615e9.1
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 11:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300000; x=1793904800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kl5aqa/5huOMBjE/HMjqhWjp8eowVgL7maZxpKhEQks=;
        b=Y4L2Sfb/nuiYcjvJ4BOBwsZPt7VGeyeByktJnPBX5iZDUhZdixASyRjhpNbdpP18Jl
         poidPHdZqwg2Vcze9EiPIPK/NRXNKRZuNtMvaN1E6ZJgBX0KPNlWnI950r4L0HpPt9Xt
         zAMkLZ5yfipagag2xfGXg+Dc41B0MEgdoXmflw6eeqsCzC4q0ZFieOt6Qo6OJ7IrtYeZ
         MmUE2i6nPoOE6955C6+G66Qv5tGD9Pbuub9jb3WEHzw/kUHgjtUiKvA1an3Uq9Asd4ZR
         CuosTknukkIFif3bk8P9Ww/IUHYc26CmtsTwCgKzE+U6n96WTmcxuHAFd9VO26zwy/fR
         ZNFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLYk9EGsjK2yh8y3Sb67A59D5IXxouBivIHDUlfQR99LuCVim5sxrzYZstU5PqecsUXh6fGCRCOj5BlpNU2Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLxNPttB+ZYh3MroUC1+8GgemNu8BsgRKy/X0G5X8/ooEUn10y9
	FgxFRDLce3yKEROJQuMu9gZdXsi+b1rmXSwDhvChHxOyzRPeYO1IH3/MNV5F9XuGP/obadXLRRK
	yixtphaREVIqYR8urDkZ+ePfde237iRVAYyNALrraWjFdtgIHNo/VqhKLbniE+7PzF3tBYhe5WP
	d+
X-Gm-Gg: AYBFou2/750WgyOAKYXtgM3NP3Bm7zERwFWFIc+aCkcqs+TGluHDn0QYeNXEHL1bqvs
	1L6Iu5rUR09yFa+EfRJzkD3QExB+/lHOS6BWq4mGOtLmaaVIwNhdH+ACjEvtoL+N8vSjYCcge8Y
	9+RDC8jFnLvZ2vmhWJGpjbn9sFDjoyQ3ZDDIsm6dquZzSie9ShCCSmcWO0x0vA6YrYU6evMe/IX
	CqThCzARrUzM/4U+AbwSAZ8XWK1EaWC4K+UgvLR/OjOxc7kB/626d3YjrpwHIO8qV6FBX+Mkj5U
	Hd1PD3AEcEqj1OdoFn8CuDILE0RmZcl7nlQqz3EH8X+ESm9xUx1tEtUSzCokKEZIb+q+iayypbT
	l186oSCLwAXToYOeLNwkldwmYmR1vtrwIjdXLerAzpFXD
X-Received: by 2002:a05:600c:8183:b0:4a4:fc8c:cfd9 with SMTP id 5b1f17b1804b1-4a96710c712mr125672715e9.25.1793299999817;
        Thu, 29 Oct 2026 11:53:19 -0700 (PDT)
X-Received: by 2002:a05:600c:8183:b0:4a4:fc8c:cfd9 with SMTP id 5b1f17b1804b1-4a96710c712mr125672195e9.25.1793299999308;
        Thu, 29 Oct 2026 11:53:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b286a0sm3822575e9.4.2026.10.29.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:53:18 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:53:15 -0400
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
	Willem de Bruijn <willemb@google.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Simon Horman <horms@kernel.org>, linux-um@lists.infradead.org
Subject: [PATCH RFC v7 1/5] net: account for ingress-resolved virtio net hdr
 state
Message-ID: <305bcadb19f4a539a318c6b87c829fbe43d0ffdb.1793276116.git.mst@redhat.com>
References: <cover.1793276116.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1793276116.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K1TFEOhwP_nFAapwrxonNG1ot8_G23sq0HUx2aCRDmk_1793300000
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

Have tun count these events per device as rx_csum_sw, exposed via
ethtool -S.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes (changelog):
    v4->v5:
        count on tun only: dropped the tap, macvtap, ipvtap and
        virtio_net counters (Willem de Bruijn)

 arch/um/drivers/vector_transports.c |  4 ++-
 drivers/net/tap.c                   |  4 +--
 drivers/net/tun.c                   | 41 +++++++++++++++++++++++++++--
 drivers/net/virtio_net.c            |  2 +-
 net/packet/af_packet.c              |  4 +--
 5 files changed, 47 insertions(+), 8 deletions(-)

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
 
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 2f19fb07bb2d..101994870bac 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -650,7 +650,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
-		if (err) {
+		if (err < 0) {
 			rcu_read_unlock();
 			drop_reason = SKB_DROP_REASON_DEV_HDR;
 			goto err_kfree;
@@ -1090,7 +1090,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
-		if (err) {
+		if (err < 0) {
 			rcu_read_unlock();
 			goto err_kfree;
 		}
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 770b8fe085c3..82ea59594eba 100644
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
@@ -1944,10 +1945,14 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
+	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
+	if (err < 0) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
+	} else if (err > 0) {
+		atomic64_inc(&tun->rx_csum_sw);
+		err = 0;
 	}
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
@@ -2615,11 +2620,15 @@ static int tun_xdp_one(struct tun_struct *tun,
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
+	} else if (ret > 0) {
+		atomic64_inc(&tun->rx_csum_sw);
+		ret = 0;
 	}
 
 	skb->protocol = eth_type_trans(skb, tun->dev);
@@ -3749,7 +3758,35 @@ static void tun_get_channels(struct net_device *dev,
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
index dd2c41ef6fbe..dd3f39516f90 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2535,7 +2535,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 	skb_set_network_header(skb, ETH_HLEN);
 	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
 				      vi->rx_tnl_csum,
-				      virtio_is_little_endian(vi->vdev))) {
+				      virtio_is_little_endian(vi->vdev)) < 0) {
 		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
 				     dev->name, hdr->hdr.gso_type,
 				     hdr->hdr.gso_size, hdr->hdr.flags,
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 823e0911c910..c0cd36be53d6 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2921,7 +2921,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		}
 
 		if (has_vnet_hdr) {
-			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
+			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
@@ -3144,7 +3144,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 
 	if (vnet_hdr_sz) {
 		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
-		if (err)
+		if (err < 0)
 			goto out_free;
 		len += vnet_hdr_sz;
 	}
-- 
MST

