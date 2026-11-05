Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879849;
	b=iO5/ProKscBFuoR7jVJUiW3+uqqfHVhICnM2vMJaPRo9lOzElu9RVN2th8kENrbS+IIW
	 rlxxqBRfVBKEVTt0zuXVcFf9bgPEDDvl4MpdhjQYsetb6OXIOA+mmj1gHU79EngCXdHNW
	 TttSItJo0M1w2G3+QiasPIQFJ4bAFjvVQjHgXjkeI+JjQHbH57nk0RrJa+BVhwyXhcd/J
	 kHk6Kn5B+1z8/xKDwleoaw0CdlL59PzxIZS2BnSSMRIlTGapvoQ5pZJmvzzPdMd1/IiIU
	 VtvAh+4nB94aPvqUHqDRVych+J/JVreoxwUUge26DTZ4JvHRWWxZNpeTjcES6/MlPxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879849;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GcxRGuC1gmVQFpDSCHcJAJWdJBAFfwYDMIb3E9p6aY4=;
	b=G9/cudLXvdt2+I5HxSFmNTGNmyPOw/Go4J4DVFTuCjiorP7faW59OUQbZpMA/KwRLM+N
	 1oGZiorRPD8p914T+GNTuGcuy+VnmorP0xZgA6XHqseRTgkRnihCNjBlZBi5tlpJvbNLO
	 vXcQ6UZeQVJtz/FjEsSNpHntC3A+LTok4anEXSZZUHv+vSs7AeuAgvMxA45HtI4+PBgfg
	 vVCetguOAwz0Q5TZ45HQETjlR4y8izDYYLxtMsiwEU5dHHTnqne3p7ezq806Of/7BSk6K
	 14KHkJyQnK3lE0EtC+jwtBBDfGrTAOxSRaslXUqRPPQRGgnLiDuSF69UP+DrJ3Wc9Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiW+ErVV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFC606D803;
	Thu,  5 Nov 2026 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiW+ErVV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE131F000C1;
	Thu,  5 Nov 2026 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879846;
	bh=GcxRGuC1gmVQFpDSCHcJAJWdJBAFfwYDMIb3E9p6aY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fiW+ErVVgpUETyZoqg11WIm6WWDVTPaqYYX/9Snq8HHeVeIePIM8FMtQHb18O2TRA
	 +jLOB0VlZnOrvbAF1CXsxaSvSE/89HAjGW/hInc89GARn9JdFvPZxhJNWD+O4FUl6M
	 Tu82DOwTuliLT3AYzdHmGkC2zaJ37KkscvHWfeQv1TqR6BStCpdLVtzEbH9S6dGJxi
	 fokKRceB+0i9pTqOv7Ak4UuNFYmGFGRaUmOU7Ia8p+gGM8R0g3KWmP+4hK0iER7rfl
	 9CD63WPbGxQqVoWGtArTtldxdt7xJT9ylC7JcveGf/nTtx0wgH9m8XBqNG9p0v6Zji
	 EssrQ73ZLNTbw==
From: Eric Dumazet <edumazet@kernel.org>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v3 2/8] net: virtio: do not use dev->type to find the outer L3 header
Date: Thu,  5 Nov 2026 12:57:09 +0100
Message-ID: <20261105115715.1466924-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105115715.1466924-1-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_net_l3_start() decides from skb->dev->type whether the frame
starts with an Ethernet header. tun decides it from the IFF_TAP and
IFF_TUN flags, and TUNSETLINK can set the type of a down tun device
to any value, without changing the flags.

On an IFF_TAP device set to ARPHRD_NONE, the outer protocol checks
look at the IP header at the network header (ETH_HLEN), and never read
the Ethernet header. eth_type_trans() then sets skb->protocol from an
unchecked h_proto, for instance ETH_P_NSH, and the packet can reach
the skb_under_panic() addressed by the previous patch.

On an IFF_TUN device set to ARPHRD_ETHER, the checks validate an
Ethernet header that tun then treats as the start of the L3 header.

Checking in tun that the device type matches the framing is not
enough: the type is read again later, and a concurrent TUNSETLINK can
change it in between, since tun_get_user() only drops packets of a
down device after these checks.

Add a has_eth argument to virtio_net_hdr_tnl_to_skb(), passed down to
virtio_net_l3_start(), so the device type is no longer used:

- virtio_net always receives Ethernet frames.
- tun_get_user() passes whether the device is IFF_TAP.
- tun_xdp_one() always calls eth_type_trans() on its frames.

Fixes: 288f30435132 ("tun: enable gso over UDP tunnel support.")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/sashiko-outbox-198573@kernel.org/
Link: https://lore.kernel.org/netdev/179387332014.488856.9111956413610107951@kernel.org/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 drivers/net/tun.c          |  9 +++++++--
 drivers/net/tun_vnet.h     |  5 +++--
 drivers/net/virtio_net.c   |  2 +-
 include/linux/virtio_net.h | 27 +++++++++++++--------------
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dcec7311e601..3920b3dff1e8 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1944,7 +1944,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
+	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr,
+				    (tun->flags & TUN_TYPE_MASK) == IFF_TAP)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
@@ -2621,7 +2622,11 @@ static int tun_xdp_one(struct tun_struct *tun,
 	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
 	skb->dev = tun->dev;
 	skb_set_network_header(skb, ETH_HLEN);
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
+	/* Frames always start with an Ethernet header here, as the
+	 * eth_type_trans() call below expects.
+	 */
+	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr,
+				    true)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
 		ret = -EINVAL;
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index f4c652b1fa44..3364e08dd6e0 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -197,9 +197,10 @@ static inline netdev_features_t tun_vnet_hdr_guest_features(int vnet_hdr_sz)
 static inline int
 tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
 			struct sk_buff *skb,
-			const struct virtio_net_hdr_v1_hash_tunnel *hdr)
+			const struct virtio_net_hdr_v1_hash_tunnel *hdr,
+			bool has_eth)
 {
-	return virtio_net_hdr_tnl_to_skb(skb, hdr,
+	return virtio_net_hdr_tnl_to_skb(skb, hdr, has_eth,
 				features & NETIF_F_GSO_UDP_TUNNEL,
 				features & NETIF_F_GSO_UDP_TUNNEL_CSUM,
 				tun_vnet_is_little_endian(flags));
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe..ed20e76fbc4c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2533,7 +2533,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 
 	skb->dev = dev;
 	skb_set_network_header(skb, ETH_HLEN);
-	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
+	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, true, vi->rx_tnl,
 				      vi->rx_tnl_csum,
 				      virtio_is_little_endian(vi->vdev))) {
 		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 357116c2a148..b7b6b542f476 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -87,20 +87,18 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
 }
 
 /* Where does the L3 header start, and what protocol is it?
- * Handles Ethernet and VLAN headers; other devices use the
- * network header offset the caller set up.
+ * With @has_eth, the frame starts with an Ethernet header, possibly
+ * followed by VLAN tags. Otherwise the L3 header starts at the network
+ * header offset the caller set up.
+ *
+ * The caller knows how the frame will be parsed later: the device
+ * type does not tell, as tun can change it with TUNSETLINK.
  */
 static inline bool
-virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
+virtio_net_l3_start(struct sk_buff *skb, bool has_eth, int *nhoff,
+		    __be16 *proto)
 {
-	/* skb->dev should always be set here already,
-	 * but let's not crash when it is not.
-	 */
-	if (WARN_ON_ONCE(!skb->dev))
-		return false;
-
-	if (skb->dev->type == ARPHRD_ETHER ||
-	    skb->dev->type == ARPHRD_LOOPBACK) {
+	if (has_eth) {
 		__be16 h_proto;
 
 		if (!pskb_may_pull(skb, ETH_HLEN))
@@ -431,7 +429,7 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
  * carries, with UDP following it at @outer_th.
  */
 static inline bool
-virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
+virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool has_eth, bool outer_isv6,
 			  unsigned int outer_th)
 {
 	int nhoff;
@@ -439,7 +437,7 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
 	unsigned int thoff;
 	int ip_proto;
 
-	if (!virtio_net_l3_start(skb, &nhoff, &proto))
+	if (!virtio_net_l3_start(skb, has_eth, &nhoff, &proto))
 		return false;
 	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
 		return false;
@@ -452,6 +450,7 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
 static inline int
 virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
+			  bool has_eth,
 			  bool tnl_hdr_negotiated,
 			  bool tnl_csum_negotiated,
 			  bool little_endian)
@@ -505,7 +504,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	if (ret)
 		return ret;
 
-	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
+	if (!virtio_net_tnl_offsets_ok(skb, has_eth, outer_isv6, outer_th))
 		return -EINVAL;
 
 	/* In case of USO, the inner protocol is still unknown and
-- 
2.53.0

