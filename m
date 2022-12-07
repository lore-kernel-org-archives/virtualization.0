Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4119C4708E
	for <virtualization@archiver.kernel.org>; Wed,  7 Dec 2022 11:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6881540983;
	Wed,  7 Dec 2022 11:51:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6881540983
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ah+7qtSP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6QNoAh9pPDvC; Wed,  7 Dec 2022 11:51:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9BBE540A00;
	Wed,  7 Dec 2022 11:51:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BBE540A00
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82949C0033;
	Wed,  7 Dec 2022 11:51:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07D87C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C901F409FC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C901F409FC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aEhsotfZ7tLR
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5D1240942
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5D1240942
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:27 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id z92so24589792ede.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Dec 2022 03:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b50DMxxzpcvqZuaYvZ+NeDB+ivxCzALRsRPpNk8vSuo=;
 b=ah+7qtSPQPfP7JCSCAvryAWT9SaG5pcJwqrq8YnhlRflNzMbRupaadUDIHbI+2nJzU
 TMrmD0Xuy2WF5G5MQUev9P92s685Ze1SJ4Z+/MRt4ew43KoMCku4hGDnPxnQhBdxhYUW
 bcYduHfJena87oqsnUpOuNyRtQOTaKd4dZeBByE9r2fpmjcmpuvnPBf0njAzI6TCdRn3
 7JXRYMSiWd5cYeD19na2UwaItZHATd6+rHx3/s39/WmVj7P2YS3KBEkfEYFfI1fo+WLd
 oDInrXxfA8aZO8kSxq4xZU+pKMSp6KBqdn6d/frwiivwnRoi5Z3QXbPpxup4u3cPVYEs
 Sg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b50DMxxzpcvqZuaYvZ+NeDB+ivxCzALRsRPpNk8vSuo=;
 b=JTxO4qYH7Em3XXuFhgzBcs/Bx/o/rrMGs2hKtELNNp06XRvEA4RnmLLCWZ+R9WtGgd
 rjdBR4XPHKWSbl9fHsH9ur879Xkms3L2iARxs4RZUqKPMG4Mp5XHaawegSgh8iWtCQSl
 1KDOhCHcT5oDIcsrymguj9ckJjCX1iC+FN+fhLOoPT9NWAWftBT8LlNOzgFfbbCjaZD6
 s6RIbr8Zdx9xO4zNe30F24AjdX0GnCPrFchdR3B0uwruNSSOYbTrmHecBlHUzqvsnVe5
 ekk6A3/fSdAGgNqwXBYQztRBNgmpRmfiyVIO7Axx70ihqMo3uInfkh/fpidOWRDz63Bi
 8QEg==
X-Gm-Message-State: ANoB5pmyZI8oWSulgXdri7QcZwh7xLskbvrU/PWrZZQQCZVMtmfmqWvo
 /lLc/UZLKo5E9liSq2gunofZAA==
X-Google-Smtp-Source: AA0mqf5Jgn1LUauRgbHQj9w8QV4AUcZH5sRBPp3Nm6PB9JKg3E7uiSJV4t3LjuIeCcrLPSexUTR2iQ==
X-Received: by 2002:a05:6402:5289:b0:462:70ee:fdb8 with SMTP id
 en9-20020a056402528900b0046270eefdb8mr47279793edb.66.1670413886071; 
 Wed, 07 Dec 2022 03:51:26 -0800 (PST)
Received: from localhost.localdomain ([193.33.38.48])
 by smtp.gmail.com with ESMTPSA id
 g26-20020a056402181a00b004618a89d273sm2132816edy.36.2022.12.07.03.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Dec 2022 03:51:25 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v5 1/6] udp: allow header check for dodgy GSO_UDP_L4 packets.
Date: Wed,  7 Dec 2022 13:35:53 +0200
Message-Id: <20221207113558.19003-2-andrew@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207113558.19003-1-andrew@daynix.com>
References: <20221207113558.19003-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Allow UDP_L4 for robust packets.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 net/ipv4/udp_offload.c | 3 ++-
 net/ipv6/udp_offload.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 6d1a4bec2614..f65b1a7a0c26 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -387,7 +387,8 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 		goto out;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+	    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
 		return __udp_gso_segment(skb, features, false);
 
 	mss = skb_shinfo(skb)->gso_size;
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 7720d04ed396..057293293e30 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -42,7 +42,8 @@ static struct sk_buff *udp6_ufo_fragment(struct sk_buff *skb,
 		if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 			goto out;
 
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+		    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
 			return __udp_gso_segment(skb, features, true);
 
 		mss = skb_shinfo(skb)->gso_size;
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
