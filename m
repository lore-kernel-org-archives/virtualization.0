Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199514A012E
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050321; cv=none; b=g0US9R1SWW2XfLrpUFO8Gf77zjQFl6cLmhLV/8Nb7fV+82dNe4lCrEV4GMtxW5FXaxWdNIbS2noOW+b4NLOnes86qjRcHNqvO8t1RTP2hmij/F+QHRw6ec7hXdVwlrGh3UUNLEH8xMNZ3BmpkPLV/PNhlYylancACBftaTIy9Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050321; c=relaxed/simple;
	bh=yLyNM8HfGsASCEH5EQcPoGP7A0J7/o+NpVZh3itxuhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMm1waI3mZ3swGEggQkgaldy3MbkT/q/NZg7mI+2TnSfdF1LRxdxEqJ5nv/uHUD5yGLI7z6noBIL//vLew8TfGZoM3lP4jbig+dMqtfdr6rjXXzNnScDZ4FOzBAGsw0IjqPT3fsrNBNb8RZeu+Iqo3huaNVomRCpRwPZ0kQM89Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=DUEcjaxG; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="DUEcjaxG"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4ca696de6so2728225a12.2
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 00:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792050310; x=1792655110; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s18ZSAeaTj3uFCQOPUAhE8p5i1eeNicCpcv0Dn1C87s=;
        b=DUEcjaxG2xfzOyTalov/zuqqPSMpfwgLDP1bGRfwSTh3VNi6avXlAPdT8S77fYBufI
         ON6J81/dlK7R+pWlN+ySiBEXZPlX0DOpRVTVI8enhmExqzKRdZhviqJmLo9EZ1612TdK
         jwbu3+AZk8e/lrqVWSq2dQDeDUv7+FpnWK7EdCxsbFxr7XrcMvc+2X43uoitGYp4Lvhv
         g7tfxJRZ2ITw+Uww28ARR5jXz0siLDq7vUHvZHnT0y9O/aNQZjp8jYnbpzoFkvsbVlCp
         hXfsgzEF9KiaY4Lk4uLJTFt3tyiN7pMFglOUBrvZElcCLLQN4Xynw7a9HMnXBXMMvbD5
         kLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050310; x=1792655110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s18ZSAeaTj3uFCQOPUAhE8p5i1eeNicCpcv0Dn1C87s=;
        b=SudHmJNICR3P5tefuab3eS92u1xEKac56+9XVUitrsWi5V5uUfj5O2lk9fAqnt6EI0
         Qk6EtYiaSUWVWFNxkiZvRNbX5T0hmfy4A7eBtfzqOWl/3xEO6M15GORT79el5bt9i/0c
         HhQfuo0GTRWvTvuYH1SNjWGRq0DRcpKkX49YSNR09WW/l0IwED15GOmYyaOIMHuGI5Ew
         zod8QwBpvXOVC4u0XLwg3rvmGZJCTjiVkoSD9U4JVdyaOmRNQXJFGGJ+vopTjSmLLJ45
         tLPTHtQiVxsCFbD/pxolEBMNp5hJAg86Ul4Q05lJcDyD10Z4xx+qYzheySUk/G7DD1Kj
         FGOg==
X-Forwarded-Encrypted: i=1; AKwUvBxxlCclw6z9oNWfX04vp3ShyQ6FLWBgC5TaZxChkoqJwQAYwp6DjntzXf3BSiA1YazFY+sJWjzHxkRDcoPy/Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLrnpFwesnapCyIAsqOE0UJMeF2y+QU9c0/c1GWe5VxeGrfi/t2
	kAL1NHVkw9IcklF09LA44kPF93s0SjURomAWd+bdV8Zz9eWzbWEVGX9zRrux35jbb9Yi
X-Gm-Gg: AYBFou33ChD5xjEP9IarN/hPJkezvvaE7g/NKoGk35JMTo/WkWymS85Wg9hluwC0LTW
	s7JYLzoVmWZnmHBMCoSh7HNCZLk/8Dmg2M5juhOj5I8fWEQv5+e7MEiMXdfrBXLW5tc5+tnhcOH
	dcb1BFaTjE1NtUwsPPAk0bwEqDKpm8QesOh9kDX4EmdOdkuFv0Ccs47zcCIXD7W2CnLpfPKr+Bd
	xcWi8kZMQe7dtZXWNpADqRMOYp7ua2BnGpXDFQDoocPmkaMjQvwUhjzlq2o+g8knpJsoxSJijcm
	s9PYgXMjJUtplkx7av/Ccv1MXYsPD4Kcr/GQXpBrYxDd4m4KdMmgsc6P5tRaMZqDOs+Mby78kpp
	nJnyPM2nZf34UxOdCTRq6Pjoca1dI0xLTU2um+MEClDp3Zgv1Vxxrhkmx0RR9wTriQ3ZoL6MbMs
	UXv7cHsCaDzx8rjfTHuZ8uDI0zK2UW22ofoEjeFW88KbDi1hxCKwtZlWh3biMsSCv+QQeHkrfv/
	lxcTq9XpDDcLk6SuXMBXHfQH/dm5Q==
X-Received: by 2002:a17:90b:4d85:b0:3a4:c946:9f4e with SMTP id 98e67ed59e1d1-3ab3acdc386mr14478029a91.58.1792050309820;
        Thu, 15 Oct 2026 00:45:09 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac93849da5sm1636831a91.4.2026.10.15.00.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:45:08 -0700 (PDT)
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
Subject: [PATCH nf v8 1/3] netfilter: nf_dup: preserve guard across NFQUEUE reinjection
Date: Thu, 15 Oct 2026 07:43:07 +0000
Message-ID: <1eca65f844ea4eaefa9ea4a852f1db27aacc10b9.1792048855.git.zihanx@nebusec.ai>
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

NFQUEUE can suspend traversal of a duplicated packet while the task-local
duplication guard is set. The output call then returns and clears the guard
before a later verdict resumes hook traversal.

Save the guard in the queue entry and restore it while reinjection continues
hook traversal. Preserve and restore the verdict task's prior state, including
nested synchronous reinjection.

Fixes: cd58bcd9787e ("netfilter: xt_TEE: have cloned packet travel through Xtables too")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 include/net/netfilter/nf_queue.h |  1 +
 net/netfilter/nf_queue.c         |  1 +
 net/netfilter/nfnetlink_queue.c  | 15 ++++++++++++---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index fc3e81c07364..039622d48905 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -23,6 +23,7 @@ struct nf_queue_entry {
 	struct net_device	*physout;
 #endif
 	struct nf_hook_state	state;
+	bool			in_nf_duplicate;
 	bool			nf_ct_is_unconfirmed;
 	u16			size; /* sizeof(entry) + saved route keys */
 
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 73363ceedebe..44f182eba953 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -219,6 +219,7 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 	*entry = (struct nf_queue_entry) {
 		.skb	= skb,
 		.skb_dev = skb->dev,
+		.in_nf_duplicate = current->in_nf_duplicate,
 		.state	= *state,
 		.hook_index = index,
 		.size	= sizeof(*entry) + route_key_size,
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index a3bc00280051..9a8f55498fd5 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -43,6 +43,7 @@
 #include <net/sock.h>
 #include <net/tcp_states.h>
 #include <net/netfilter/nf_queue.h>
+#include <net/net_debug.h>
 #include <net/netns/generic.h>
 
 #include <linux/atomic.h>
@@ -368,17 +369,24 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	unsigned int i;
 	int err;
 	u8 pf;
+	bool old_in_nf_duplicate;
+
+	DEBUG_NET_WARN_ONCE(current->in_nf_duplicate,
+			    "%s called with duplication guard set", __func__);
+	local_bh_disable();
+	old_in_nf_duplicate = current->in_nf_duplicate;
 
 	net = entry->state.net;
 	pf = entry->state.pf;
 
+	current->in_nf_duplicate = entry->in_nf_duplicate;
 	hooks = nf_hook_entries_head(net, pf, entry->state.hook);
 
 	i = entry->hook_index;
 	if (!hooks || i >= hooks->num_hook_entries) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_NETFILTER_DROP);
 		nf_queue_entry_free(entry);
-		return;
+		goto out;
 	}
 
 	hook_entry = &hooks->hooks[i];
@@ -401,9 +409,7 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	switch (verdict & NF_VERDICT_MASK) {
 	case NF_ACCEPT:
 	case NF_STOP:
-		local_bh_disable();
 		entry->state.okfn(entry->state.net, entry->state.sk, skb);
-		local_bh_enable();
 		break;
 	case NF_QUEUE:
 		err = nf_queue(skb, &entry->state, i, verdict);
@@ -417,6 +423,9 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	}
 
 	nf_queue_entry_free(entry);
+out:
+	current->in_nf_duplicate = old_in_nf_duplicate;
+	local_bh_enable();
 }
 
 /* return true if the entry has an unconfirmed conntrack attached that isn't owned by us
-- 
2.43.0

