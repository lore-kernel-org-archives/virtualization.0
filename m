Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918B44EC67B
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411395; cv=none; b=DyZ2yqnvrFL2kG0ymOoPSJbJvSinBgQRuoh1umJ5ldMSPQJCU6/5Nzp6BNh2MR3hxFWZnXqsCAqqHBeQK+syR1zUd2yILXKYYg9XhMcuul/PQ8EFx/XGDOvWrmSzoTLJhrmHaPZCIJwk4NbRClrCZwTVTsqAmrR6ZMVm73Zc720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411395; c=relaxed/simple;
	bh=UOTdqyK/Bh3jmg5tq5waFLxklAdVZaf+YzmxhBON62A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZmoVGgG6sIwdwpMpxwMeAdxgzw4soelNRlII66F/ndibs2WrpyltVkIVr6wHVvXYbVAN/lB8MV5CWpiMSH+T8b4BV+bcHZHlCFoglbLmp9rTtSDuXkje2B6r9P2ck0kboWPk4KpmdjYFkN0mJFZeTC25ZNFBzMBT0/F7s1r/Prc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dn8Q++0M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dn8Q++0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OPjtCegbC2jn7HsffHh9I/GufwNUoioiRsioSDiFk6s=;
	b=Dn8Q++0MSKY3oKncofWBZnGg1MFi/0M0IpYvhgUUwAmYEH+ue39k87zWUJxSLf44lxeQxv
	vxk8VY+Vo2NiMeStw4xdNOlAHgwPNAXfFVlscYkyc3V/80VIjyohqky3q3k3GUHXkGWbU5
	45HHB3mWa/J+mXE4WT+GrGgD/80FKow=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-v2TmCCPOMdeGKdsxRyC-gw-1; Mon, 19 Oct 2026 12:03:09 +0000
X-MC-Unique: v2TmCCPOMdeGKdsxRyC-gw-1
X-Mimecast-MFC-AGG-ID: v2TmCCPOMdeGKdsxRyC-gw_1792411388
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a01c621dc2so15467925e9.2
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 05:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411388; x=1793016188;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OPjtCegbC2jn7HsffHh9I/GufwNUoioiRsioSDiFk6s=;
        b=C9hi5walduqs/uy+t8XQTqIreh6mFaklYHl+HxHBtF1me2ziK0/i6ngaTsXAdEbbmt
         IbxvmDWwwbQzqRIST4xFLZNKFMn418R5Wurig3Xm5i+NRiEfhbKW+1rJk/98ertT6lMt
         4kg+NJV8mMJOGMJCGKK0iCZJ7gIrRxEsi8tJX7oCXz4sIcz0FU3UnlS5FWAwGBI2qVWq
         J4IXw0YkRIlhmFOd74CM43fs16S1dqTSsU5gZdI9lQTJWcHukoZqHIExaKNyYpQNp6XM
         sdX7oSe7DckMoIp3oPsbfoo1CV6tqx9GlHOLnflO24/P6xQPE6pKC6XQe7FH0ZEQyztZ
         8r7Q==
X-Forwarded-Encrypted: i=1; AKwUvByJI3S6TaRaC6wnRdfJnjE0csOJB76mTlb4KYWezaSEIYXr11ieg8WqlUmcndiQliWWT9i3voIy7wys8ZKfAA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJYEOyy1BFqxZuGeu3X3lolsJKOHPOXPAp5jk/hLCSvNOWUNw/u
	IYmmWI+oxaHWkeW+pamPCTFxNoI9LImqq8ze2l+odoiwzBbfb5HRwa5S2M8f8m6UqFLdlwIizqN
	u0wXU97nZFzhK7wUdn+vQAy1jfKYTT7Ort3sNJp3SHc1XAjomLRNCdsMJxUXwYaw6lvgC
X-Gm-Gg: AYBFou1NjxPuzwnp8XqvnV2fuA+/f4V2lbFF1B0QDATJf/2y9LYAWJqi3nQphSGKnrh
	2zsLeEs3/+9/2JFJyXESrRDoyZJOmpm42X+6FjEiUs1QHg9ExQGTQCd7pTYYR7mJ/Sqfi7p3+PX
	08TypPBsIOxE+t1Eg4agpkoobjM+1GKb4Z3ktIU7No0/fqhB2delfPB/l9dsAtLasqrxAd//9YR
	xpfR9RQGqAM05Oi2GzuLyfXWi6Bx7vrz24jlAIYTVzjEIMfNuDIXnnn1bbZetUGqnmvyBaZAZT0
	N+9Dh6W3ggVGc8JAZ3B+5nkoQkPtfvIu8o2tZZtwS6y/UjUssijQsjadTpH95K4rgXtpCQ==
X-Received: by 2002:a05:600c:3ba7:b0:4a1:e6cb:25bb with SMTP id 5b1f17b1804b1-4a1e6cb2ad6mr73790805e9.2.1792411387274;
        Mon, 19 Oct 2026 05:03:07 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba7:b0:4a1:e6cb:25bb with SMTP id 5b1f17b1804b1-4a1e6cb2ad6mr73789795e9.2.1792411386598;
        Mon, 19 Oct 2026 05:03:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c10fe9d3sm328226975e9.13.2026.10.19.05.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:05 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:03 -0400
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v3 1/8] net: account for ingress-resolved virtio net hdr
 state
Message-ID: <b1dce3e055b973bd87bdbdc9e9729971fa383326.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 81GTfRSOVC-siZe1bgBZZBegpBDhyKbcLNYfVt9usHw_1792411388
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
only, and have tun count these events per device as rx_csum_sw, exposed
via ethtool -S.

Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/tap.c        |  4 ++--
 drivers/net/tun.c        | 41 ++++++++++++++++++++++++++++++++++++++--
 drivers/net/virtio_net.c |  2 +-
 net/packet/af_packet.c   |  4 ++--
 4 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index ff67d99deb39..73e883394446 100644
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
index daab43ac92ce..2e6fd81df9c4 100644
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

