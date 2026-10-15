Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650313F0773
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050335; cv=none; b=rHhcSP25OeYI+IJS7EdKyeVwF1HhodXIdvlOhKgHRvFHnd0roMuD37ResjIqzWfpb0p/oDmOOdTLvcaDqcVEjNQLqVKQyOjyiNnlpDEFlYqNyZLI/h/qM8CiYp2yXPuzrRhtfcCZ2xgSo/V/dPpiHe5EUFd7Po1y6lukRAeJKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050335; c=relaxed/simple;
	bh=wkvWUApSrQrFBFKMdGdp4vLL5y0nqDGM2AWyGgExVyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1LmJqrO6etTXyflrIxzhRmeIsFN+fNvcEXFJQwALQWBX/aO5J/GtLMI+d2C3P0Y6MkOtkc5mMJyVf2xl4nq1VMex55JDwr8KWZQTlHr6xWtSyo+TyPx8sNE+Z+gQR7Hd+rBIggsdj92hZyFC/1QcXnmLoTrQHcW2VjXBrsSUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=e2ofgmXY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="e2ofgmXY"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2dd76b1361dso12640845ad.1
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 00:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792050330; x=1792655130; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tn7PQz7YO2FDXiLMjVOvk9Md6NqVD6EXEzozd8X+sL4=;
        b=e2ofgmXYJ+xvunGBmTD2HrsATTRdsvt8SUsgWLTSdRDacxBLbCh+T8rOd+Y4aRehdv
         rqWIJOZiE2CSBre5qmzdgjnLilsdxbmVO5f9OCAOaSY4PLbx1Rie5bjiAHxfX08VmKow
         PLJa1Tj99xDtrHFheeUR8toFyQGUMuvFM7kYvVlEdADZ/eEH8bBWoo8aVmc5C017quLv
         3A5P4v6BdwToqn8RGtUYCAT9gw8nw5N6B7lZWs8cdWl3GJ7d2uNNzFVYGmjBgLDvBR+b
         tWjcJ38yLLpt2U9wUB+i0cUUDvuiZaex6q+xPLv/fane/JwA3B6rJ++ciC9n2JzpueiJ
         rEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050330; x=1792655130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tn7PQz7YO2FDXiLMjVOvk9Md6NqVD6EXEzozd8X+sL4=;
        b=C2u334V56Hd+6Xr1OGRplRaXN7N5hHnpaUXjoB5ftBgaPxixybthJV2RWZIYJszCRB
         ftpCrrHFpj5iYTN1PsN5GNd04Cw3FsIZlmXHfXMffCr9X+v52IZkxUniESmbQrM+sQHI
         wcXCgLbEiMbtP0VCR+COS05U+e1lIfxcFZnxjglIPMrnYoqQ/DU/2hw7CXHNbgCHsV+S
         CbdJjTPimfRSV8ImNcPhF62hgc3Zi9on8YqXoIMzICha9keYyqxB0ull+VZ2Fk45hJYk
         RNyTRtq4YE8N8TEM2JnGdIAi9vh79+4JULC3l83e3hPj3NuiniGTORF5tiHUx63oZWEo
         puTw==
X-Forwarded-Encrypted: i=1; AKwUvBz/BYD4Uyk6rZkTSsmSacM7bCJhIceeGD0u1DnwxraG9TL1XdZLwiqk37npRiqY0TmpLm5yEzO4SNtEWBqxmg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJeYkFB6JYBz2XeIWCZsw5AyCIxF6AJzM8gdwUYfeyMhZwY7laJ
	E5nDldsqjs0G0itkfOdoLWuMErKFOy/Wz5TtmO11B4+zjvMkY0MOtgZ1d/DXCUpGTh6g
X-Gm-Gg: AYBFou2iZZXWeq0Kuv/QGtMdjOW0J4gJ2VWd1h7fmScbeiIWYjhaCpU4RJKFM/0qs3I
	U+cY090Er2dKDG/ZEWQ7RRzCoa0uPR7hoiHajWiJzRj0BoFQysP1S0f3XgNQT7c3r3fArw16BXj
	eUoPjim68S0Qzj5YBJTR0uFt1E8pdSW9e0sq887B11xkJYYHKVvz2qfKdyK/cmJnku0OJ3muM61
	ZVCxpiG585tMPZZbwH2J4US/SeOyviXfBiCja6RQAU5G7Z+C5s0ruMF7SoFB63J00g6MVJn3/U9
	9wBzbuAGqnbTt/I5zEODZwaoh1fOOUJefemvC4pRFadgFJrwk2oRJZjix6Rjhsc0zb4gVEb11rV
	ivT/RT+CZDikebvTb/4ZTlXV2U7s3Mt0mbwinuPR7TZsaa+MBnHUXaM0cbWppNmSfs9X8T+DcLR
	deRSctEtgNIdhmp0pQuQJHj6pc7c6DrBDvQM/nB17TTGILdONYfr4uF91m4z+Jqby62fCHV+Ekz
	HskOVs5qowMKalW5LEN037Z7b8t+A==
X-Received: by 2002:a17:90b:3b4f:b0:3ac:a7ee:6780 with SMTP id 98e67ed59e1d1-3aca7ef2dd1mr318175a91.66.1792050330377;
        Thu, 15 Oct 2026 00:45:30 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac93849da5sm1636831a91.4.2026.10.15.00.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:45:28 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netfilter-devel@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	bpf@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kaber@trash.net,
	jengelh@medozas.de,
	andrew+netdev@lunn.ch,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	willemb@google.com,
	alice.kernel@fastmail.im,
	eilaimemedsnaimel@gmail.com,
	imv4bel@gmail.com,
	shiming.cheng@mediatek.com,
	sd@queasysnail.net,
	vega@nebusec.ai,
	root@tr0jan.top,
	zihanx@nebusec.ai
Subject: [PATCH nf v8 3/3] netfilter: nf_dup: prevent TTL and hop-limit underflow
Date: Thu, 15 Oct 2026 07:43:09 +0000
Message-ID: <3db2db978957de74be13ba48cc16c5e0829003e3.1792048855.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1792048855.git.zihanx@nebusec.ai>
References: <cover.1792048855.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPv4 and IPv6 duplication helpers decrement TTL or hop limit for
copies processed at PRE_ROUTING or LOCAL_IN. Stop duplicating when the
value is at or below one, before a subsequent decrement can wrap.

Fixes: e281b19897dc ("netfilter: xtables: inclusion of xt_TEE")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/ipv4/netfilter/nf_dup_ipv4.c | 3 +++
 net/ipv6/netfilter/nf_dup_ipv6.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/netfilter/nf_dup_ipv4.c b/net/ipv4/netfilter/nf_dup_ipv4.c
index 9a773502f10a..5f9d6c473fb0 100644
--- a/net/ipv4/netfilter/nf_dup_ipv4.c
+++ b/net/ipv4/netfilter/nf_dup_ipv4.c
@@ -56,6 +56,9 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	local_bh_disable();
 	if (current->in_nf_duplicate)
 		goto out;
+	if ((hooknum == NF_INET_PRE_ROUTING || hooknum == NF_INET_LOCAL_IN) &&
+	    ip_hdr(skb)->ttl <= 1)
+		goto out;
 	/*
 	 * Copy the skb, and route the copy. Will later return %XT_CONTINUE for
 	 * the original skb, which should continue on its way as if nothing has
diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_ipv6.c
index 6da3102b7c1b..5095f9623001 100644
--- a/net/ipv6/netfilter/nf_dup_ipv6.c
+++ b/net/ipv6/netfilter/nf_dup_ipv6.c
@@ -50,6 +50,9 @@ void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	local_bh_disable();
 	if (current->in_nf_duplicate)
 		goto out;
+	if ((hooknum == NF_INET_PRE_ROUTING || hooknum == NF_INET_LOCAL_IN) &&
+	    ipv6_hdr(skb)->hop_limit <= 1)
+		goto out;
 	skb = pskb_copy(skb, GFP_ATOMIC);
 	if (skb == NULL)
 		goto out;
-- 
2.43.0

