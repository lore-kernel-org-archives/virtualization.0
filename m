Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65049C433E0
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 19:42:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2152311A
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 19:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2152311A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A31FB203FA;
	Tue, 12 Jan 2021 19:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xa1GHJRsALO1; Tue, 12 Jan 2021 19:42:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4C6CE203C4;
	Tue, 12 Jan 2021 19:42:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3170EC088B;
	Tue, 12 Jan 2021 19:42:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BD8FC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3452386D73
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:42:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F9K-+4iNJ2Rm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:41:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6F96586D37
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:41:59 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id y187so3236436wmd.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 11:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+hdtHCSFxGXzmG9zcdLMtsA9CM+yy9a1rXrTwefd0k4=;
 b=uDUgsIFWkCAbgZpUVsXjZnHVBtT5AU2g2Tu3bHmPpimoSMu5Pt0D9DUupyK66NiDmr
 SFEsFzaU9DeZGgsQNEmiMdYaft+Prt2oiSZp3IwXkNZcxt/HhMRiefuYPbdbHk207Kqk
 Ox0YHcUONluOucMlOfT29PUY08TWwE4IG1a6SaLfcUzRQriJ5ZteB9zJYi6UG87ywCfN
 JJHQnkpHwdqQk0KZ4i9o+jUIFEziT+WLlSsXAP0tJN8Igphnx/Aqlr/nyFJ/mvZPN5MB
 EXwGgSs6GpQKpUPrMqOtt2NwAzA19W1ixaml8FgEQbVfWvbklv/rk1W2DIbuFaxQ7f41
 yRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+hdtHCSFxGXzmG9zcdLMtsA9CM+yy9a1rXrTwefd0k4=;
 b=oT4c2r7sZwclFg84AB5gz6PMcjzdZ46mkmM51nGppLNr1teSxCpF36jR4m30Uk/nfm
 XJcpx86ccxCsHiaZHMbebKgIOkRvxs0yF5La8K9EEj4e/tqjojAjdtglkLrfmOTAvOQh
 D90DnpPpOEdgWERWG30XrrkgJkywxqq8ZcCXVa9bh3XcHe7Svjy09VRflYt83kW35JCP
 PmfxUAy8Nsf1aegWz9J2Z+ivmk1D91PU7oxh+dFowuwkt9K+2Pi7CO62WFrItVRrR7R+
 U4m3e1AyooAa2Y1K25zkDmXxtuG85Y0dHgDdsqHJtwlM5AL5Aoo5AD4wb414nJks8FCB
 24rw==
X-Gm-Message-State: AOAM531C9gjFIGwUZHz0yMA7J2OXHkLL9kvd+XK+pNFyR3I+4HEeXw/k
 nu7g6BerSSzze9N042RM4USI1Q==
X-Google-Smtp-Source: ABdhPJx/0woun/MhI7lJlAwq65ikInzHiKo9rw3lXUFvfj5s5Qs3xrAuB3tgEtBp9fISRu7oCo34FA==
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr809749wmm.122.1610480517946; 
 Tue, 12 Jan 2021 11:41:57 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net.
 [79.183.72.147])
 by smtp.gmail.com with ESMTPSA id z63sm4885315wme.8.2021.01.12.11.41.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 11:41:57 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
 gustavoars@kernel.org, herbert@gondor.apana.org.au,
 steffen.klassert@secunet.com, nogikh@google.com, pablo@netfilter.org,
 decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com, elver@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
Subject: [RFC PATCH 1/7] skbuff: define field for hash report type
Date: Tue, 12 Jan 2021 21:41:37 +0200
Message-Id: <20210112194143.1494-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112194143.1494-1-yuri.benditovich@daynix.com>
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
Cc: yan@daynix.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Used by virtio-net receive side scaling

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/linux/skbuff.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 416bf95cd5f2..36cf40ec0259 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -510,7 +510,7 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
  * the end of the header data, ie. at skb->end.
  */
 struct skb_shared_info {
-	__u8		__unused;
+	__u8		hash_report_type; /* virtio-net rss */
 	__u8		meta_len;
 	__u8		nr_frags;
 	__u8		tx_flags;
@@ -1430,6 +1430,11 @@ static inline struct skb_shared_hwtstamps *skb_hwtstamps(struct sk_buff *skb)
 	return &skb_shinfo(skb)->hwtstamps;
 }
 
+static inline __u8 *skb_hash_report_type(struct sk_buff *skb)
+{
+	return &skb_shinfo(skb)->hash_report_type;
+}
+
 static inline struct ubuf_info *skb_zcopy(struct sk_buff *skb)
 {
 	bool is_zcopy = skb && skb_shinfo(skb)->tx_flags & SKBTX_DEV_ZEROCOPY;
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
