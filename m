Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1468AC3A5A7
	for <virtualization@archiver.kernel.org>; Thu,  1 Dec 2022 22:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83E6741299;
	Thu,  1 Dec 2022 22:48:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83E6741299
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=bJT+6Pf3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0cGN0t4gRSe8; Thu,  1 Dec 2022 22:48:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AA721408DE;
	Thu,  1 Dec 2022 22:48:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA721408DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F49BC0033;
	Thu,  1 Dec 2022 22:48:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD802C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B17C241066
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B17C241066
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=bJT+6Pf3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OdGyGHLea6uw
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D992540112
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D992540112
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:51 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id r12so4805992lfp.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Dec 2022 14:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b50DMxxzpcvqZuaYvZ+NeDB+ivxCzALRsRPpNk8vSuo=;
 b=bJT+6Pf3gru2G2faqNC14AW+QMpsR+xneNE6bi+nKD/YnzuiEQuBNxCfistgza0ycf
 GZRQfPHJd9PCQKfct4zOcD7tinF1//EGcbuVyO10QoRxbK6RX4VVtG4WIOUQIjLz4W8p
 FEx2qQ8d+p6PoKZHfzWYpZ3ZmZJ0Gs4l/CJpFvhnADgyC2mXMgddYYf5QbhGcnFdMVnX
 mm5cR1pz0OaE7b3Bs5WsY4NqHcUlxxUUWb20dWgMz9APsKjDt4sV0dlCzyxrxIl/yYt9
 Ce3tvHvPymkAbXbt/nE9ZXEXmjAdVEsW14oNY7PsOdsWnZR1AmaobLwlBzfrN+ekHykV
 zQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b50DMxxzpcvqZuaYvZ+NeDB+ivxCzALRsRPpNk8vSuo=;
 b=UKISgUJVP4ScKIjvjs///cMFK5KMU6qaTULwdy1zEFaIpBFFd2xU2pz9Hf3+MfHdM2
 nKFBolFHDc/pcooPn+NWw82Ms8Zlg374hbAGxPvkaLnFz4ZDoWsbYDR3esawoDe4U7Tm
 eSitvdQHx4mhDElxnrAejuMLD35mhKVvu/JMJZsrLSx2QAmbyH3IqREH/yyjSofNpt9B
 kRmsn2CVrIu2uk3s9jROJ1Ees3FaUG8kxBIPmOJThVwcCqgf7d+Ez8q7pewyQsunJCuq
 mwUjI9jNeKfVBZmGas4fElOGjjdzqUFelpkZV+7jA0QgWhHki2jChR0bDRxbxUkcXZrR
 gErQ==
X-Gm-Message-State: ANoB5plBki4Qf6oaf/DIPAo9DzWrlC9F5ctOAyfxNytbt8J3tIRA0sl5
 aD3fgbtl2/51SWW9GW64ZULREw==
X-Google-Smtp-Source: AA0mqf51S5q3EqKANfIuARmbkNeUOH//5Qb1QqfZRiiA7+e6V4Q7Wdii+gb3R41/Q/ugVOJ/EGgoTw==
X-Received: by 2002:ac2:5f6c:0:b0:4a2:bca5:76bc with SMTP id
 c12-20020ac25f6c000000b004a2bca576bcmr16343840lfc.123.1669934929672; 
 Thu, 01 Dec 2022 14:48:49 -0800 (PST)
Received: from localhost.localdomain ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a056512118700b00497ab34bf5asm797573lfr.20.2022.12.01.14.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Dec 2022 14:48:49 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v4 1/6] udp: allow header check for dodgy GSO_UDP_L4 packets.
Date: Fri,  2 Dec 2022 00:33:27 +0200
Message-Id: <20221201223332.249441-1-andrew@daynix.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Cc: devel@daynix.com
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
