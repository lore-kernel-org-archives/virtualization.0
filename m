Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2294E325C
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889135; cv=none; b=X9u/5a4xID5Uh/vEc37lTlN52JlgB1hp+xx4mjxyFKiXw1MzvOuKGxC4OlBYGXBoMtStj3BaD24PeFXj0u/uD07yUnLbp2pTuQVr3BXJX23tseQqtG132FJTp5gFa1PBkqDchQfFU5GY/eLQuJDn85WWv3HOhv2fyjBHWmhO2fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889135; c=relaxed/simple;
	bh=H0l0lW7OIR5JEAGWTHP04PSYXRXwPf9bf6J09uxs1gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FzXbjtuh9byoRmVDImoTdxRImC3jS4mvkBH0ZwnOcKhSopSITxUarP6+cqVkqtqCQvf2PBiXpTtol9SGm/yChSkRqhQdTcwG+/YCZuQ3mhwwOBU8BTb4cintq7aRH4MF6UBK14ZHhWgTBlEvJfUGVEA3tu6MIyBG3q7/2TvCDjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIG8/+Mo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIG8/+Mo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791889127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YX0cMX2Cf26EXqpfUZ4FHg8Am9Idf3c80yUtynKrkSo=;
	b=FIG8/+MowbcvvYSNicE8q9vjDTUVOb/rohE71xDp5cngDaN5pecVXgrf3D2T5M/B03bDPL
	fbzkZY6enzOQO6nSZFiO8IWFYhqanUPdCEZtRSOGI3TXcvSpIRD0yBmVq4cobZ/YRnoX+9
	rNUsAXN/2G4C7WPYpdUbJj5PPaUwd+g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-HLxla0nBNiODFKvJIa_IBg-1; Tue, 13 Oct 2026 10:58:46 +0000
X-MC-Unique: HLxla0nBNiODFKvJIa_IBg-1
X-Mimecast-MFC-AGG-ID: HLxla0nBNiODFKvJIa_IBg_1791889125
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1af80b913so2755405e9.2
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 03:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889125; x=1792493925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YX0cMX2Cf26EXqpfUZ4FHg8Am9Idf3c80yUtynKrkSo=;
        b=AELC6olyTtzOt5vxcNpTkQQ1NHK9w+FtAHq2RgJB81+CBnlPLoNvVjIez22ay93XKj
         7FwM92bA5VmXpLsdRqna7fNTGga7n50eS2DLLYofw6jCA+UK5psu8NbdLEhJkOIzkCOu
         Fx7STRCGcEYlBEGXc4C+QyfdM4zCRtFi3mQx5IXykkSpuT/MtB6tEmd8skUD8HqwwHbd
         e+Lp9X0bkx5aUlMGADMsXOuKCmJGa871dq8gLE6qPrzzERL5afm3VlddMDOvV/SgCTY/
         K73tHyBbzQa845VgN6VeRQzFHM5gm9Uvf7GLKWc7gcXxeRGw70LZmIwo1unpy++RJT/z
         4HYg==
X-Forwarded-Encrypted: i=1; AKwUvBykuJ7ci7AZC9u9cvIY4yYtkMYCLMi65FiHsEIlkQrb/dF63au3If9dckO4Lj6t+wiIgPiWsCr6unvm409/4Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLOhQiY8iAfsJtiIv/Qs4DuHo7fbHBa7HZfcvdT0xxZSaiDdaKF
	xwRTCEi/iFwQFslD1KUlXwAVJv7XXOROGB2PkWt+YY/Ld94lNK4O+thHBd0Wvo+qAwZ1Kk4LGQk
	dHORpPE4mC4ceaD44yp256H/du/yztfy24ofmAoemhu90YHXFObCx+kV3TLfEs6TInc6j
X-Gm-Gg: AYBFou2DYP/ho1HH6EWgs8ykpNEZRZaGJVDvt4nTv4tPzr42E/CuMIEi6aet8V4e1IV
	AgiAYz7AozxDegj6V6G/VQ0xlPOx1pTxHKEn9mvu3hBrXWvM9UKWrGd7zwQOh//ROUxuxMFByD5
	zIReWf52b58LvgUC/eLWeqWTvclPCpeH14B3U/6wd0DCiGFfMzdpFKL0gafg5LBc8cQSCrK5XU6
	bXstM9hBVykX6zyvo0uR9iSIaCNtC6jja15egRXwlv/UfHhFW9GEOhJud3yn27oYnszVpqclBV4
	D/o2k9IURElJGypk8xtv2eYq88VPr1aXhFN0SgzFxI1V1FUM5uGFbR+3HQvtdpfkKfPkEg==
X-Received: by 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a18e4f56bcmr247258435e9.33.1791889124803;
        Tue, 13 Oct 2026 03:58:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a18e4f56bcmr247258035e9.33.1791889124335;
        Tue, 13 Oct 2026 03:58:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc50e0sm5758574f8f.49.2026.10.13.03.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:58:43 -0700 (PDT)
Date: Tue, 13 Oct 2026 06:58:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 4/4] net: account for ingress-resolved virtio net
 hdr state
Message-ID: <d82518764906d3b552fd3ade65b96ac741197d4e.1791887415.git.mst@redhat.com>
References: <cover.1791887415.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1791887415.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jUJMLfdvZhsr-c9ntR-pVyM6ZaidrZflM2yLLBGKnts_1791889125
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ingress resolution of uncommon virtio net hdr checksum metadata
(software checksum completion at ingress) adds performance overhead but
is currently invisible: no counter tracks it, so a hypothetical workload
relying on uncommon metadata cannot be distinguished from none at all,
and packets quietly pay the host-CPU checksum overhead instead of offload.

Have virtio_net_hdr_to_skb() return 1 when it completes an uncommon
checksum in software, and flip every converter call site to test for
negative errno.  Have tun count these events per device as
rx_csum_sw and expose the counter via ethtool -S.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")

---
 drivers/net/tap.c          |  4 ++--
 drivers/net/tun.c          | 44 ++++++++++++++++++++++++++++++++++++--
 drivers/net/virtio_net.c   |  2 +-
 include/linux/virtio_net.h | 12 +++++++++--
 net/packet/af_packet.c     |  4 ++--
 5 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index ff67d99deb39e..73e8833944463 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -649,7 +649,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
-		if (err) {
+		if (err < 0) {
 			rcu_read_unlock();
 			drop_reason = SKB_DROP_REASON_DEV_HDR;
 			goto err_kfree;
@@ -1084,7 +1084,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
-		if (err) {
+		if (err < 0) {
 			rcu_read_unlock();
 			goto err_kfree;
 		}
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 242899f7fd071..138ca8987dfc6 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -210,6 +210,7 @@ struct tun_struct {
 	u32 flow_count;
 	u32 rx_batched;
 	atomic_long_t rx_frame_errors;
+	atomic_long_t rx_csum_sw;
 	struct bpf_prog __rcu *xdp_prog;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
@@ -1935,11 +1936,19 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
+	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
+	if (err < 0) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
 	}
+	if (err > 0)
+		atomic_long_inc(&tun->rx_csum_sw);
+	/* The status is consumed: keep err clear so later exit paths
+	 * (XDP drop via unlock_frags) do not return it to write() as
+	 * a short count.
+	 */
+	err = 0;
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
 		skb->protocol = eth_type_trans(skb, tun->dev);
@@ -2605,12 +2614,15 @@ static int tun_xdp_one(struct tun_struct *tun,
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
+		atomic_long_inc(&tun->rx_csum_sw);
 
 	skb->protocol = eth_type_trans(skb, tun->dev);
 	skb_reset_network_header(skb);
@@ -3739,7 +3751,35 @@ static void tun_get_channels(struct net_device *dev,
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
+	data[0] = atomic_long_read(&tun->rx_csum_sw);
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
index daab43ac92ce4..2e6fd81df9c41 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2519,7 +2519,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 	skb_set_network_header(skb, ETH_HLEN);
 	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
 				      vi->rx_tnl_csum,
-				      virtio_is_little_endian(vi->vdev))) {
+				      virtio_is_little_endian(vi->vdev)) < 0) {
 		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
 				     dev->name, hdr->hdr.gso_type,
 				     hdr->hdr.gso_size, hdr->hdr.flags,
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index b181183118b3a..d8447db58ac83 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -14,6 +14,14 @@
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
 
+/*
+ * virtio_net_hdr_to_skb() and virtio_net_hdr_tnl_to_skb() return 0 on
+ * success and a negative errno on failure.  On success they may also
+ * return 1, indicating that an uncommon checksum was completed in
+ * software at ingress rather than deferred to the egress path;
+ * drivers can use this to account for such packets.
+ */
+
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
 	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -292,7 +300,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 
 		err = skb_checksum_help(skb);
 		skb->transport_header = old_transport;
-		return err;
+		return err ?: 1;
 	}
 
 	return 0;
@@ -441,7 +449,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	/* Let the basic parsing deal with plain GSO features. */
 	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
 				      hdr->gso_type & ~gso_tunnel_type, false);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	/* In case of USO, the inner protocol is still unknown and
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 52ae3d875e971..e6aec9ecfa994 100644
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

