Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7981B3B6C1D
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046203; cv=none; b=ZrJGWyZOkO1/NuU0jNeYJcmU0GM3tbnqx0B8w1vf3teKS8pkZ7+Aa3vy+WOden6rwvjVW14I8hdQT39M6RZV5KCOwI0jaqP6aqyrUhwqWd+clC0/fS+PCzLoUwny2wPtIcwkRBOxIWRQc34louKsHloAfr7z5B9rTNTwq/83cPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046203; c=relaxed/simple;
	bh=xxPCfoW71C+dY5Vk73+EVbPgQd5ga8fAuuMpvs44aSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esBXNEBlUATUNPW0/AipyF+nuhWRm0+29y7OK2da3ONiexzoRTSsa9pBZn5dwsMLWIRWS5nYCbqkHqVDj0raMqoDh0je8yVgSX++n2/ew1sVXI3dzD9B8r2z1Hsvfx5a79u9NfGQQ8d1pDYTtUdWJ8pAGM5OsNvb0xCwa5ijT7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgIV4KJh; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgIV4KJh"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf31683so33038407b3.0
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 20:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046200; x=1790651000; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B5rs7+ILfA3J/8r3zuBgSBRVCSTxSnXx2oYi6bmrhLI=;
        b=fgIV4KJhpKla7ra+5RuUE2Cu621mEZPiYtvFNumnaAp3Z68oNxcTLqnQPII+Bd7naq
         C1J5PVMn0DoRRkpZvwcWYtydzo35hBuvmjVtrqbHtpu6/tamxh7PaKM67k80KXEzhBvI
         EJnwp3hho1DLylxxu9Pw197bR+nRfMAQf1Dq1q5GAGG5XDRsJA5EE4rcmeEZY7mkPRK2
         EiPl53r/IqcKp2G8ngYFS/dra5DitmlatO9YZceIOUHoJS5yHlFUMF/dH0HkZaWnqJxU
         m+zB+NeB0nNvpzaRj+al52f207/AkgVKuiqZIF7CBVt5Ss+s1g8QsgXpjl715KumJzFT
         bdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046200; x=1790651000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B5rs7+ILfA3J/8r3zuBgSBRVCSTxSnXx2oYi6bmrhLI=;
        b=mZqGve9KQxzkIqm0ppNBRmQ3Eu01ThYmIoy3q9eQS8ihdeyOxsSJuvZpk+5wKd0I/6
         eAIDNNgCSIKItZHf9Kx9oQTDIJdWhLy10/zChXYpQ8AiPYZgPA62qjN/umaYjWiKn1Mm
         GWsPrO4b8l7F4c4XEX6F3p+QJWWFo+aGp6d5YlhZx6HSNG2RYeRwJLjX0k1bQ9p2pHLI
         pqErN8gDTFLdUljUtpHp/UayWgOaVVe9ll0YYSD93t1L+BKBfbmg+H0nsiA5/lxlxMEk
         hbtQzykoE2LOxLnbtU3UweKT0ZnOqGp0MJMeGM9J9FzOpH7QNDxpnCvG7+S7zsdm1tV0
         TGWA==
X-Forwarded-Encrypted: i=1; AKwUvBz7uDrWMnMg4u3cDAcx7LXxHZf4UPCvG38jJlu2snVHYRZzOqtT5EtG05CIwhud/qA3nEPTcS/+V8ZY2mMh9A==@lists.linux.dev
X-Gm-Message-State: AFuF++kD4URdMJ7oLPjTTY00mwAK1uKmRLQSI50nW4DZee6f8it1XaI0
	9WDsiaJMVHMQB9DObsyUeD9/O4xivUvr6ICCk7rmDfxydmQR5vdVJRq3
X-Gm-Gg: AYBFou1M5vuJhjuzJFPVRtn451q6mArch9xID0GW1yn22hFlipPgdzLUyleGJOKMjWD
	8aasSHOT7Cp5brmqEbi7DoTj/lb6sRrUDj3qRWi+JHa8ENNwNsN/1gAdBZjmJ9tetRODj/ZSCCI
	Pj5FZIR6vzaIeCQooknGLI91cZVAqlnHPxFHZm8MI8hdfXqXQ93Teg7Q8NNDb59zYTqnYiXPBhK
	Jn/scxM6G/rcCxqJyzouteZgLC44G27kLBXeBQgr951wEbY10ulxlZFqOrJliUw8eMsJkcJheHg
	1xkAOq2cRrDE7woRsW4b3IE7yWAtCaf1jQaGOPCcWo3+6uSr1FSv7blXcx2wrZuffeiM2fFw+5T
	kSNWOAXQn/623kBZr41AK65Cm6AdXNs7PMsyU19r9E51c5oIYjtaIZR+uv+HXYtDj31FSLGBp/1
	AwuZMJUgxAhIHBEwrgi07EP/sjSBdqXNzfM/0eujLGfyrQ8dV6CpEj9EnCRV+if7FZ0CfQRcMEJ
	GkKs8x9Cglkgn90rr9oSPSLg2O25eLAbxizG2wPEq20BaPL6n87Qaq6ghdZdwId/IJhUKx3
X-Received: by 2002:a05:690e:138d:b0:668:1c09:aef1 with SMTP id 956f58d0204a3-6717fc7e75dmr3816179d50.6.1790046200291;
        Mon, 21 Sep 2026 20:03:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:2875:43a3:e345:710c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a2c1b02abdsm1471447b3.17.2026.09.21.20.03.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 20:03:19 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	mst@redhat.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-um@lists.infradead.org,
	virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6 2/2] ip: reject partial checksums covering network headers
Date: Mon, 21 Sep 2026 23:03:10 -0400
Message-ID: <20260922030310.8684-3-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260922030310.8684-1-habte.yibelo@gmail.com>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_do_fragment() and nf_br_ip_fragment() complete a CHECKSUM_PARTIAL skb
before reading the IPv4 header length. ip6_fragment() and br_ip6_fragment()
complete one after parsing the IPv6 header chain. A virtualization
interface can supply a checksum start which, after link-layer removal,
still points inside that parsed network header.

skb_checksum_help() then writes the completed checksum into header bytes
the stack has already consumed. For IPv4, changing iph->ihl after routing
and validation can make fragmentation copy beyond the skb's logical linear
head into transmitted options. A negative checksum-start offset is rejected
by skb_checksum_help(), but only after a WARN_ONCE which can panic a
panic_on_warn system.

Validate the checksum start against the parsed header length before
completing it. For IPv4, read and validate IHL first, retain it, and
reacquire iph after skb_checksum_help() in both implementations. For IPv6,
use the length returned by ip6_find_1stfragopt() in both implementations.

Compare the signed checksum-start offset with the bounded signed header
length so integer promotion cannot bypass either boundary.

Fixes: dbd3393c56a8 ("ipv4: add defensive check for CHECKSUM_PARTIAL skbs in ip_fragment")
Fixes: 405c92f7a541 ("ipv6: add defensive check for CHECKSUM_PARTIAL skbs in ip_fragment")
Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
Fixes: 764dd163ac92 ("netfilter: nf_conntrack_bridge: add support for IPv6")
Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Link: https://lore.kernel.org/netdev/20260920004733.6473-3-habte.yibelo@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 21 +++++++++++++++-----
 net/ipv4/ip_output.c                       | 23 ++++++++++++++++------
 net/ipv6/ip6_output.c                      | 12 ++++++++---
 net/ipv6/netfilter.c                       | 12 ++++++++---
 4 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 7ecb8a26b..d81ed8692 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -38,18 +38,29 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 	struct iphdr *iph;
 	int err = 0;
 
-	/* for offloaded checksums cleanup checksum before fragmentation */
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
+	iph = ip_hdr(skb);
+	hlen = iph->ihl * 4;
+	if (unlikely(hlen < sizeof(*iph) || hlen > skb_headlen(skb))) {
+		err = -EINVAL;
 		goto blackhole;
+	}
 
-	iph = ip_hdr(skb);
+	/* Complete offloaded checksums only after the validated IP header. */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < (int)hlen)) {
+			err = -EINVAL;
+			goto blackhole;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto blackhole;
+		iph = ip_hdr(skb);
+	}
 
 	/*
 	 *	Setup starting values
 	 */
 
-	hlen = iph->ihl * 4;
 	frag_max_size -= hlen;
 	ll_rs = LL_RESERVED_SPACE(skb->dev);
 	mtu = skb->dev->mtu;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a24cc8ee1..fa6a74d20 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -770,16 +770,28 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	struct ip_frag_state state;
 	int err = 0;
 
-	/* for offloaded checksums cleanup checksum before fragmentation */
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
-		goto fail;
-
 	/*
 	 *	Point into the IP datagram header.
 	 */
 
 	iph = ip_hdr(skb);
+	hlen = iph->ihl * 4;
+	if (unlikely(hlen < sizeof(*iph) || hlen > skb_headlen(skb))) {
+		err = -EINVAL;
+		goto fail;
+	}
+
+	/* Complete offloaded checksums only after the validated IP header. */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < (int)hlen)) {
+			err = -EINVAL;
+			goto fail;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto fail;
+		iph = ip_hdr(skb);
+	}
 
 	mtu = ip_skb_dst_mtu(sk, skb);
 	if (IPCB(skb)->frag_max_size && IPCB(skb)->frag_max_size < mtu)
@@ -789,7 +801,6 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	 *	Setup starting values.
 	 */
 
-	hlen = iph->ihl * 4;
 	if (mtu < hlen + 8) {
 		err = -EMSGSIZE;
 		goto fail;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 550965058..d157b6ade 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -942,9 +942,15 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	frag_id = ipv6_select_ident(net, &ipv6_hdr(skb)->daddr,
 				    &ipv6_hdr(skb)->saddr);
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
-		goto fail;
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < (int)hlen)) {
+			err = -EINVAL;
+			goto fail;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto fail;
+	}
 
 	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(rt->dst.dev);
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index a7025ec87..da7ada12f 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -144,9 +144,15 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	frag_id = ipv6_select_ident(net, &ipv6_hdr(skb)->daddr,
 				    &ipv6_hdr(skb)->saddr);
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
-		goto blackhole;
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < (int)hlen)) {
+			err = -EINVAL;
+			goto blackhole;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto blackhole;
+	}
 
 	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(skb->dev);
-- 
2.46.0

