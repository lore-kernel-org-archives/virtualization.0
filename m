Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415834E324A
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889128; cv=none; b=Qora89TI1L4Cj0EpSV48lw/AUepH3zyrjDZSyoJds7gFrm64jxR/jHRcd7UyHDwu67L58fim6JkGWZQwEqRmcznk6VteKnlwDrj6m9YLqa7/TWnJXp56d1d5RQrrOexmsVwsTdAn9/EzUnBdfCAuBbC87GpQcpIZaUGlFNp7e9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889128; c=relaxed/simple;
	bh=yPvbXQJO4g4fSdUPeHvPpxAec2+KPnTBizqvTfKMhnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Lh4CUYWlaF03F6m4eGBD3mas7RJJlcQ0HEvcvD0U7dKpTF5E1/pclIgC0AMw180G78G2V2TQ3Kh/7Ogpxhd1JpDzKhXRHYGIbn4HVENv7nb+VC2ZYyp80xYGjmEBV+hHWywJIoNrWRVQQl/JNASXP3EkQ+jkgLk+JDTJGch0www=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecBbNItI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecBbNItI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791889120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dq0crgc7vKDC3fZNlazsaBKXkICbHKAerCxw9oAOLWE=;
	b=ecBbNItIItz9JBR1j4qa23jPxt+gkl0m6iM+bX7JgBG4qFFXKxyaf5OxQ3oEUOlueOdCzI
	+cOtWe/Okzlnww+kxPxfhBzFD0C9m9UCb1h3c36rDOzM34lHePP59LK8wBsTnPpaNz27ey
	0FEHaQDqM/8VT44qJ9JPmiOdEhVrvT4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286--SGKk-v4MXSy40m_Mkvx_g-1; Tue, 13 Oct 2026 10:58:39 +0000
X-MC-Unique: -SGKk-v4MXSy40m_Mkvx_g-1
X-Mimecast-MFC-AGG-ID: -SGKk-v4MXSy40m_Mkvx_g_1791889118
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a0761224e1so26012565e9.0
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 03:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889118; x=1792493918;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dq0crgc7vKDC3fZNlazsaBKXkICbHKAerCxw9oAOLWE=;
        b=kYoc/uW4eWM7TGMrCkUvt/0v4n2bqpnFrECSMY2ZNglt2uFtIjYdpfJOy3rsrtbe8w
         uzGu/jRAH5lRy9VVN4WY63CGbCjdwSWrgACfPb/V7tC5YgxMRBMclpMgm+zgzjhCSNlK
         4fW+NYWheXWhi5Je1wV6dXyCEfPgbd9KLGb9r3Z5KRUjlVa8kTL2iO5RWuGf8hr43TYG
         TFNMHMxzTuA4AfHhtKxAWOaAKtXqsrgr1KGaTjnm2sqA5/41ct2KXyDS0nYz7yS8HtXv
         3hSDi7e47T71pNr9h59RByF+NxgQPPlsVCuGan9yUDXM2QztRIiyVrJqCN1dFc65qElE
         lD5Q==
X-Forwarded-Encrypted: i=1; AKwUvByndapbykkifjHxyWGev1gW1pLl6uziZqOeVmYbceNA5BahqVkA9Zj9APMEtiNmlIK6wcPwvD0nyer3HgkOiQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKeX0GFeSSA+mGK5CaGdPCGCbLVfPHgLG4x8gILsRsrKmSwTjYx
	IcIx+hvxFRrcnS/pPDKlRaj364I5HyMXyrFJH344CHsePyrMhc0dhClVa4NxLN2DE+aWMlVD6g6
	LloyEZdFH6eLkmETGXxoT9qSR3VG5gWnMJ18AvW6LlsAUWcczs8KHZfdyPyJMEa9k2gNg
X-Gm-Gg: AYBFou0rKZtABKXPo1WuCaRdDklUV0TcwyxOVYWPvGKi0EF7dGrFG97Ch1wujXnm5Uq
	O42L1zo/OwV6kk/VG4jCbo5N+PefSSrCpG9NY9v0Pl8KEmsTM6dYTVYSGtvVApKmLsccoUAtZJN
	4UJk01hbrfh2fq9QOGVkLEwB0w59MuGaEsA97q65SdWDB+l2vU603j9k3PYeMIyKuxFdwapRawG
	mE2qQEI0qLp4QhFxHr25ID0269Vu6Qs9oFEmI1ospHxuCMV5OHHFDmBqPIpkUV4BlOnMD5Ghlkn
	gWMIEABFUZMyqDXXinfFvYTicf/QUNgnG8V7SRtwy8/8n6czJnzH1NCaTf2HgKief6pjng==
X-Received: by 2002:a05:600c:4e41:b0:49f:c1a1:5222 with SMTP id 5b1f17b1804b1-4a18e4d80bdmr231408535e9.33.1791889117996;
        Tue, 13 Oct 2026 03:58:37 -0700 (PDT)
X-Received: by 2002:a05:600c:4e41:b0:49f:c1a1:5222 with SMTP id 5b1f17b1804b1-4a18e4d80bdmr231407945e9.33.1791889117450;
        Tue, 13 Oct 2026 03:58:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaac3esm4507970f8f.11.2026.10.13.03.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:58:35 -0700 (PDT)
Date: Tue, 13 Oct 2026 06:58:32 -0400
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
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev
Subject: [PATCH net-next 2/4] net: use ip4_parse() in receive validation
Message-ID: <05eb0a83a9975e8e042caeeb4fca5fad30e02fb4.1791887415.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: TgP6Cib3nPxgBtiUJXEHH7RdWE9-UCDQxB4b1maZ8hc_1791889118
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the sites that pull and do version and ihl checks on the ipv4
header and validate the packet transport offset to use ip4_parse.

Sites that validate a read-only copy instead of pulling - the nft
and nft_inner header_pointer validators, ip_check_defrag()'s
skb_copy_bits, the flow dissector - stay open-coded for now.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
 net/bridge/br_netfilter_hooks.c     | 15 +++++----------
 net/ipv4/ip_input.c                 | 13 +++++--------
 net/ipv4/netfilter/nf_reject_ipv4.c | 13 +++++--------
 3 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0a394e5f43916..e89da0e415426 100644
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
index 9860178752b8c..5adf01763e857 100644
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
index 59ec465a9df98..42d639854ddf1 100644
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

