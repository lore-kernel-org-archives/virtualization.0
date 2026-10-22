Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673921;
	b=fvKQsnST/E1AOlcAF4c4NuY7yMZ7SXDlRVCxm4iZNDbxRP4cMU5CtlyB4kzT35rMKNw9
	 VDQQ9jeZqPg5GSDdow4KJSazaOU7cVdPxLDHFn+z2oGW6QtUEhD8oQzjqpPZWWDeUjg2n
	 BY21+gYWgVEDaSREb+rn4gfXDXvwJZnk/lf6AuuM4AOoEKtGFd3fDySgrZ/7qN7ZoyRIT
	 VwLz82GtDExYpJm7GHT+i3lrVD9t9xzSZt7YB7PX2ACWXE21eikl6O5nSsyWk8j7oRu7D
	 eHc41+BNhd92eoNQnfea708fQQhm1jBV54QrCt1sFExun0v53NkzDgBLM1dEmPV/FOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673921;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=WsotF0ejH7vcgdu3Tl8WXCv39gHwci5cDXLJnOZO04U=;
	b=LqpUlJJmftR6Wgm/Jex3/Ccgy4WPi24yFiiKQrL/yC1WffqzCsezvxUdNDMqd9O9i7pv
	 B8eU090lVp7jaUtJwiuulN6ws5VOwnfh8KysWc8da4u9Mk2cwrtyFBCSU5W5CL9Ni1DMx
	 DoqtnSmEJYVmriIrlVSN2elvNfZztj16LfbptsNngOj+4rchI0UfGkpG2NahjdxpA8OPy
	 8eKx1plealZpdQWQLYA++UP58Jz2KFRx2r9rMvwH6f8osGZTNoJrwKLLFd+8Je2nRQdDD
	 n0qh33r4kI0XltGyFpgMGmN0cUAwPgFS0HUndChkGdk3n327gcwjGKBeMLOhzAKEoAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RfcxjDlk;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56E760A382F
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 12:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B56E760A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RfcxjDlk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792673919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WsotF0ejH7vcgdu3Tl8WXCv39gHwci5cDXLJnOZO04U=;
	b=RfcxjDlkzjDZL5fz2KXP19dlZN1Oc9DRTkiM2dOlPlDgJe4bhfn1Qs/v+ZtlihH8NhI8CP
	05dTxMjiZJ6Gg0TbIkTtpC6YktCE8HbWjZOSAbOfSOX4qGar+T1WD/huF9Py3RvMxq8074
	iJKkafHlhlaB6Djtx7wXaB6BZaG2QMg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-5M9vN3OlP4CPcj8sDSCm2g-1; Thu, 22 Oct 2026 12:58:38 +0000
X-MC-Unique: 5M9vN3OlP4CPcj8sDSCm2g-1
X-Mimecast-MFC-AGG-ID: 5M9vN3OlP4CPcj8sDSCm2g_1792673917
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a028616bebso13519535e9.1
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 05:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673917; x=1793278717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WsotF0ejH7vcgdu3Tl8WXCv39gHwci5cDXLJnOZO04U=;
        b=FJCfJIgYMl7GG8HJPFWiOiFur7xZkYnJTpP79tIHlH08TGCg+cQi8G6jRv9rDo8fl8
         KQ5bIxP6oVdZmkjrJ6DOA/tCE5c7rS+KsnZDajzwvTbD2V/ncNA3vmFOCkIWx7xSOfSV
         MeCj3B3cBF/u26oiPy2H3x307Btsa4nwszPr+kF0mOb1D4ek4LD/uDnWY8wEdlbskYJ7
         DfeB4jzvdzGTucV98Vsrx+PCA83FgVADko8pyfkRZxUkMhvIHZGLbYUGqSP6+vsQup3N
         2f7a3KXaGMDgCjjbaYLtTccqVbTwbtWjP9AbCMmnZ2COEuSg1O2vCCT6SQGR/NKyzSJ9
         uVSg==
X-Forwarded-Encrypted: i=1; AKwUvBzJEAThnZco1kDQu01+2ECu9w06BbtCMS+9lQanKPEWFrllqlULFfgyst2ETlPj7CBUBkV100KKkgsC8rhHUg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKo1jQkcjJM1hT+ZEpUzHHGGEsSbsGww/ShLWi8TZq9ThTZ7ovc
	NzNSvlL5yQpDXCx2yDh4ZW5nnjqtR970pLjHDBgstOB0s2mwNI0vBh07b7q31NJGuoV2VLmAoi2
	WIV4yoYHuIldj86sl5r0EReoIiT4yXM7emjm6XPBtQj/dr/UrCLVWiGb9tKlR0Xwxcol9
X-Gm-Gg: AYBFou1O3VFO0VxKBu+FoNq21ghWWI7Lc1vleTYZ4XV24OCxaSnbdoGclrd5BauTU70
	UWRihN8fYX5Ujf8QKAut82pTZFe54umv7Wu70hrgOykff8ZkwboJpJ+O75tUwo3N+9LY1pdtr8u
	tqWzQkQVI4ehNPj2cQmzwg/rkfYFjQqBNry+TnpjRIm4v7sduMBmWEJk8Ahh1zlnQSLNmW/Vs3C
	RIMrLn5/Gx+Qb/JIfVD4fdJelu7DeFz+BgJd1cvh2o0NuZ+MB17sjbWWST8b16U1oZZar+EMYZt
	m3V+e+DHF/EYTlvNrWmIpRge+DF6mf3qMGP49INBzmz6BmYLAbGiVz11BQZ+WCOMLHQ=
X-Received: by 2002:a05:600c:c16e:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a1fdd2aa12mr112849635e9.12.1792673916807;
        Thu, 22 Oct 2026 05:58:36 -0700 (PDT)
X-Received: by 2002:a05:600c:c16e:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a1fdd2aa12mr112848885e9.12.1792673916165;
        Thu, 22 Oct 2026 05:58:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828e2esm11998353f8f.30.2026.10.22.05.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:58:32 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:58:29 -0400
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
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev
Subject: [PATCH net v5 6/7] net: add ip4_parse()
Message-ID: <65a4d0ba37073c48d75251039882161efe5a4025.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.v5.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6z8U5szlRnG3dJ0SaSo9y_gCmsOjaPcudBBwHc7womg_1792673917
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Multiple places in the net stack open-code the same minimal IPv4 header
validation: pull the fixed header, check version 4 and IHL >= 5 (where 5
is the fixed header size in 32-bit units) - and locate the transport
header at IHL * 4 past the network header.

Add a helper for doing that: it returns the validated header and
the transport header offset, or NULL if truncated or malformed.

As noted by Phil Sutter, there are more places that could use this
helper, e.g. ip_mc_check_iphdr(). They will be converted in a follow-up
patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Phil Sutter <phil@nwl.cc>
---

Notes (changelog):
    v4->v5:
        pull the options as well, so that the transport header
        offset is within the linear data (Willem de Bruijn)

 include/linux/ip.h                  | 37 +++++++++++++++++++++++++++++
 include/linux/virtio_net.h          | 28 +---------------------
 net/bridge/br_netfilter_hooks.c     | 15 ++++--------
 net/ipv4/ip_input.c                 | 13 ++++------
 net/ipv4/netfilter/nf_reject_ipv4.c | 13 ++++------
 5 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/include/linux/ip.h b/include/linux/ip.h
index d11c25f5030a..7e047d18a61c 100644
--- a/include/linux/ip.h
+++ b/include/linux/ip.h
@@ -56,4 +56,41 @@ static inline void iph_set_totlen(struct iphdr *iph, unsigned int len)
 {
 	iph->tot_len = len <= IP_MAX_MTU ? htons(len) : 0;
 }
+
+/**
+ * ip4_parse - pull and minimally validate an IPv4 header
+ * @skb: buffer to parse
+ * @nhoff: offset of the IPv4 header within the linear data
+ * @thoff: returns the transport header offset
+ *
+ * The whole header, options included, is guaranteed linear on
+ * return, so the transport header offset is within the linear
+ * data.  Callers that need to read the transport header must
+ * pull further.
+ *
+ * Return: the validated IPv4 header, or NULL if truncated or
+ * malformed.
+ */
+static inline struct iphdr *ip4_parse(struct sk_buff *skb,
+				      unsigned int nhoff,
+				      unsigned int *thoff)
+{
+	struct iphdr *iph;
+
+	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
+		return NULL;
+
+	iph = (struct iphdr *)(skb->data + nhoff);
+	if (iph->version != 4 || iph->ihl < sizeof(struct iphdr) / sizeof(u32))
+		return NULL;
+
+	/* Pull the options as well: the transport header offset
+	 * returned below must be within the linear data.
+	 */
+	if (!pskb_may_pull(skb, nhoff + iph->ihl * sizeof(u32)))
+		return NULL;
+
+	*thoff = nhoff + iph->ihl * sizeof(u32);
+	return (struct iphdr *)(skb->data + nhoff);
+}
 #endif	/* _LINUX_IP_H */
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index cea70ccf0ed4..063cc116e51a 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -53,32 +53,6 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	return 0;
 }
 
-/* TODO: nothing virtio specific here, move to ip.h */
-
-/*
- * Pull and minimally validate the IPv4 header at @nhoff.
- * Returns the header and stores the transport header offset in
- * @thoff, or NULL if truncated or malformed.  Only the fixed header
- * is guaranteed linear; callers that need the options or the
- * transport header must pull further.
- */
-static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
-						  unsigned int nhoff,
-						  unsigned int *thoff)
-{
-	struct iphdr *iph;
-
-	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
-		return NULL;
-
-	iph = (struct iphdr *)(skb->data + nhoff);
-	if (iph->version != 4 ||
-	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
-		return NULL;
-
-	*thoff = nhoff + iph->ihl * sizeof(u32);
-	return iph;
-}
 /* Defined in net/core/dev.c, enabled while any network namespace
  * has net.core.virtio_net_hdr_validate set to 0.
  */
@@ -161,7 +135,7 @@ virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
 		    unsigned int *thoff, int *ip_proto)
 {
 	if (proto == htons(ETH_P_IP)) {
-		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
+		const struct iphdr *iph = ip4_parse(skb, nhoff, thoff);
 
 		if (!iph || ip_is_fragment(iph))
 			return false;
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0a394e5f4391..e89da0e41542 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -206,18 +206,13 @@ static inline void nf_bridge_pull_encap_header_rcsum(struct sk_buff *skb)
 static int br_validate_ipv4(struct net *net, struct sk_buff *skb)
 {
 	const struct iphdr *iph;
-	u32 len;
+	u32 len, thoff;
 
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+	iph = ip4_parse(skb, 0, &thoff);
+	if (!iph)
 		goto inhdr_error;
 
-	iph = ip_hdr(skb);
-
-	/* Basic sanity checks */
-	if (iph->ihl < 5 || iph->version != 4)
-		goto inhdr_error;
-
-	if (!pskb_may_pull(skb, iph->ihl*4))
+	if (!pskb_may_pull(skb, thoff))
 		goto inhdr_error;
 
 	iph = ip_hdr(skb);
@@ -228,7 +223,7 @@ static int br_validate_ipv4(struct net *net, struct sk_buff *skb)
 	if (skb->len < len) {
 		__IP_INC_STATS(net, IPSTATS_MIB_INTRUNCATEDPKTS);
 		goto drop;
-	} else if (len < (iph->ihl*4))
+	} else if (len < thoff)
 		goto inhdr_error;
 
 	if (pskb_trim_rcsum(skb, len)) {
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 9860178752b8..5adf01763e85 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -500,7 +500,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 {
 	const struct iphdr *iph;
 	int drop_reason;
-	u32 len;
+	u32 len, thoff;
 
 	/* When the interface is in promisc. mode, drop all the crap
 	 * that it receives, do not try to analyse it.
@@ -520,10 +520,6 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 	}
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-		goto inhdr_error;
-
-	iph = ip_hdr(skb);
 
 	/*
 	 *	RFC1122: 3.2.1.2 MUST silently discard any IP frame that fails the checksum.
@@ -536,7 +532,8 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 	 *	4.	Doesn't have a bogus length
 	 */
 
-	if (iph->ihl < 5 || iph->version != 4)
+	iph = ip4_parse(skb, 0, &thoff);
+	if (!iph)
 		goto inhdr_error;
 
 	BUILD_BUG_ON(IPSTATS_MIB_ECT1PKTS != IPSTATS_MIB_NOECTPKTS + INET_ECN_ECT_1);
@@ -546,7 +543,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 		       IPSTATS_MIB_NOECTPKTS + (iph->tos & INET_ECN_MASK),
 		       max_t(unsigned short, 1, skb_shinfo(skb)->gso_segs));
 
-	if (!pskb_may_pull(skb, iph->ihl*4))
+	if (!pskb_may_pull(skb, thoff))
 		goto inhdr_error;
 
 	iph = ip_hdr(skb);
@@ -559,7 +556,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
 		drop_reason = SKB_DROP_REASON_PKT_TOO_SMALL;
 		__IP_INC_STATS(net, IPSTATS_MIB_INTRUNCATEDPKTS);
 		goto drop;
-	} else if (len < (iph->ihl*4))
+	} else if (len < thoff)
 		goto inhdr_error;
 
 	/* Our transport medium may have padded the buffer out. Now we know it
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 59ec465a9df9..42d639854ddf 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -25,22 +25,19 @@ nf_reject_ip_tcphdr_get(struct sk_buff *oldskb,
 static int nf_reject_iphdr_validate(struct sk_buff *skb)
 {
 	struct iphdr *iph;
-	u32 len;
+	u32 len, thoff;
 
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-		return 0;
-
-	iph = ip_hdr(skb);
-	if (iph->ihl < 5 || iph->version != 4)
+	iph = ip4_parse(skb, 0, &thoff);
+	if (!iph)
 		return 0;
 
 	len = ntohs(iph->tot_len);
 	if (skb->len < len)
 		return 0;
-	else if (len < (iph->ihl*4))
+	else if (len < thoff)
 		return 0;
 
-	if (!pskb_may_pull(skb, iph->ihl*4))
+	if (!pskb_may_pull(skb, thoff))
 		return 0;
 
 	return 1;
-- 
MST

