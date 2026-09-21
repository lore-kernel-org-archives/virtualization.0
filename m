Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5A331A57
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959236; cv=none; b=ok9C3FeQD6E3HcGLddgG47/EzexnNhXJQ2rI88MN9dZr1yEgzxGgFKh7J6Rt5Z4vgIZwjZ/sRLIIA2dZxjuUsaKZ9ZDlSBBMjcZyaPL0+085kVbqySU2qQdL7g6qRwEwA/5aPg8OjGg4RpbiWUHurK4DSVyoW1sOE2ScN231AMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959236; c=relaxed/simple;
	bh=o7u+Ilnkg+4xjG93z/0C0NZxlAlBcA2mnfdP5ehaM74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUbVJe0XD60Khsp9Z5mQIOqvLplY+XSlOo1wcd4yCYfOYo0Lg1nZbkh6PbjDt8w/jQMP06nJMqE9cDLScHMkawpvtg1zLxB6b5egB9EGJQJjfk29wt7UJPFe1aPMuHqyr1vdaF2nc7KeY0jMusYfLCY5NGkOzhEUkL85TpT9Qus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqneQHKc; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqneQHKc"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93be29bb454so268882285a.1
        for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789959233; x=1790564033; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u8Ct4yW9W4ymcEv428o4m/ZX/KrAWtAnJ7CKPNzyvYY=;
        b=bqneQHKchCRiDLZpRqrdZtPfhXCf+eFhDL2tx2yItR58QQq7xKhJJ/ROQ1ODj8i8wr
         78RzeAFUgl53lFImce1jOWetl5U86xT33YUgeLpIYWdVtZAmZr/+NtD0i1XGDDakAI0s
         geIM6/N5AfKCaAafSaznN3s6Fbl5D10pFdv2YfP817oxtpe8VOe6ubPbFgEqJC2zFEi7
         0K1Z+sO+I1RLQfaVCBSIe1ufAf9Rcn7Vocx9G77/xhot0jKOuuOFoTwo3evp74bnebvB
         ODfjBeoLNtPtflNKDYcOPgNuPjgRyxv3UgOmnzyUQicwdrd6OR8Zz6TaibdN4UlvjpIr
         9CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789959233; x=1790564033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u8Ct4yW9W4ymcEv428o4m/ZX/KrAWtAnJ7CKPNzyvYY=;
        b=lbcroaYmaaBi8p+MNoWXG9ieG7WN6ekeO/cp+fgub4gd4Bu9vw9gGstUTcvRFqWnZH
         xFqUAm6v0vekWxw0/BycsXsByt9V3rJ3u/NaP91L1/e3AgipGOiW7phdgipt95CrywC5
         361LHLbadMCE3VTZVaIAsYuXm00XdII/ke7j8GbPAjikeZ4M0gGgP8cnXnzCQoe4Vw2e
         B1LjUGaqhkV5nUJvnCdYDGjBIeQShEtgtofFYIb/HErgBw5Bf5kjA9kGp6viL3tVr9z+
         0vcc3ObnYHYUbxLVbMTmu0Sj/flIG8pSMvZwVNj2LE5HZQo2O7NnLIk2B/QaYQV4ofjb
         7e2A==
X-Forwarded-Encrypted: i=1; AKwUvBzdYDToxqCQVwDUf3QeoLv/dbp6HscIEZvX3sagO1b8ONMT+Xrft53LGjQPySy+fqBXs/ZHo/kNW2n27uycPA==@lists.linux.dev
X-Gm-Message-State: AFuF++nt7QBNJuLByOQbBbZkgQuvO/mmmd0beHXjgmJBTYBkPAo0qKS1
	ovzXe2wUGSuvLwLQq3p/Cz+mf3ueWPKPCDvqMi2QKb8QSnQk4NxEC759
X-Gm-Gg: AYBFou2tuDZQbiVfb+juMmqq0afm4Dx+KHwWZvPUg2Bz1dCFAWXRucze+PzlOwNjul+
	iRezm8WKQfN79TJN9+q9m5C2H8T5z++EgJoLX1EVD6wxDksbDEyhMW0yzKocDiuRVHCBjoi+V+/
	PfL2muP+w8ouHYsszFmuUVDfuvU5npSFmcrCWIs8mGawxTgkqw8HCq9sId43YyDEjdcpV50Wm8N
	7YEiiHayHiOeZeYD5LlPucnmBppy7s7QXv+6etkpOhaVxsooNymWxnHeed40wC2l0C+l8hHpxMe
	iSgsKmTTIYXAEgTumD6wQGLNExQfCvvkVO82MPfh3A3kq2yLqIcTLpQ6XhiGjQ/05nfJjF7PaXh
	XTi4UMPyMvZfz3Z/QAMNN1UWafDBJfAoTj5voIOE0yFGFjUs3TgxP+ZJqkXee1l7N6VMy1SlyEm
	qc+Csy/VpkVNKNFoRJcuZULSsKwMDKk88tSL8FdP8EHCJsj/NHfwdP4wb6pNiAlSDQAYScqomFZ
	oUEUJEAscqXAX0Cp5f33YAofpt/wf9R27EP8lLg+/l2WXmlWJIhmQZkvpooRK2NTOSXKcYO
X-Received: by 2002:a05:620a:1724:b0:93b:d7a0:d9f0 with SMTP id af79cd13be357-93bf57eea2emr869731285a.74.1789959232559;
        Sun, 20 Sep 2026 19:53:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:64b9:5e22:f77c:324e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bedb3de58sm528732785a.37.2026.09.20.19.53.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 19:53:51 -0700 (PDT)
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
Subject: [PATCH net v5 2/2] ip: reject partial checksums covering network headers
Date: Sun, 20 Sep 2026 22:53:41 -0400
Message-ID: <20260921025341.44846-3-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260921025341.44846-1-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
 <20260921025341.44846-1-habte.yibelo@gmail.com>
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
Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
---
Changes in v5:
- Compare the checksum-start offset and IPv4 header length as signed
  values.
- Add parsed-header checks to the IPv4/IPv6 output and bridge-netfilter
  fragmentation paths.
- Drop the prior Acked-by and Reviewed-by tags because the code changed.

Changes in v4:
- State that a TUN device is sufficient and no guest is required, as
  noted by Michael S. Tsirkin.

Changes in v3:
- No code changes.

Changes in v2:
- No code changes.

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
