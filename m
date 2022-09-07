Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A1EC54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 12:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 815558151E;
	Wed,  7 Sep 2022 12:51:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 815558151E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=zebyzyv5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i4y8LnbkdudB; Wed,  7 Sep 2022 12:51:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AC332813E4;
	Wed,  7 Sep 2022 12:51:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC332813E4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8880DC0033;
	Wed,  7 Sep 2022 12:51:23 +0000 (UTC)
Received: from smtp1.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe97:d076])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D3D8C0033
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1ADB813E4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1ADB813E4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AVAxfNdhWqvv
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A298813D8
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A298813D8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:21 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id t14so12951720wrx.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=K10uAJSt1u89AHdHDm3QcGmANMSoQ/8HY7X6zX3XZWE=;
 b=zebyzyv5uKr+UqsozuiNEURIYqvNSEMx/k5mlK+LX3bAhdI2PaQP2VCIgM9lmXtdeo
 JkMS58BTcZhx+QgoTSa9bOMHDIujGKqs6m3ZQKBtUJDMNicEjA07WZN/Qh0PJA9TYhpd
 3fcOrWd2LJJY/CeIk+4iQRL3yQ4nz7ws8FLReQL++JjQuPsCoS83B8l6ZERbys591+XP
 NC6/iLKXCGyqblLuTPfA/r/cjJFcoavZ/Gj6P1w4ROG8A8ZzO2dl3COIE1A/XUjRwMGD
 wZuy80hJFk+2Pq1ZHJc7wbkRe7TCJY9uN933qBYe0FGW8IxV/hOy93L43ghqQBxlx1sU
 mo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=K10uAJSt1u89AHdHDm3QcGmANMSoQ/8HY7X6zX3XZWE=;
 b=GFjOhxvLZ0oGB0R3olfTt1PbnrGZiG3u1GwrUClg3/ec46me2jxFQmca1KQT8oX3mA
 +prJ6cCmd3XsnMb/1FC9YtPLvoWqSc6xtjFxbLQYqV5ntL9rXp56p1ObBExBR8X51Xem
 rJmVzeepg+IaS3kkiVmK7z4cvR6JX+TQSp0+rZOItw3gZHhsagWJ1hoaqNtXMdGLatCx
 49UsvvgcMSGe6aiqC4Nj/ww+i0+sNUEn0nBS6yJq9tMzWkgQb9VLYyikctYTvqAxukH9
 /nMi/Om+iYVX/PQHKdvzXhkR8kTJYgxf0j9ddUm+RLaKasCj2bDT7KhbW7Oua8iH5J3A
 Ipng==
X-Gm-Message-State: ACgBeo0pRychNiVeTh/rjTcplxfz/z8Nq/ppEWCwzvN9Yrh9c4pJK0/r
 k8NVnmqp5JmQp1QimrSSGKY/Tw==
X-Google-Smtp-Source: AA6agR6xJNUBhe9XopgqmLTZOld7yTF3ZPNZlh6fC1ETvTmQOaZ4LXyB4dTCOss9jZ/lXbavFtgZQw==
X-Received: by 2002:a5d:588b:0:b0:227:1c28:f470 with SMTP id
 n11-20020a5d588b000000b002271c28f470mr2105741wrf.331.1662555079421; 
 Wed, 07 Sep 2022 05:51:19 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 e27-20020adf9bdb000000b0021f0ff1bc6csm11480001wrc.41.2022.09.07.05.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 05:51:19 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: edumazet@google.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, jasowang@redhat.com, mst@redhat.com,
 pabeni@redhat.com, yoshfuji@linux-ipv6.org, dsahern@kernel.org
Subject: [PATCH v3 1/6] udp: allow header check for dodgy GSO_UDP_L4 packets.
Date: Wed,  7 Sep 2022 15:50:43 +0300
Message-Id: <20220907125048.396126-2-andrew@daynix.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907125048.396126-1-andrew@daynix.com>
References: <20220907125048.396126-1-andrew@daynix.com>
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

Packets from TAP devices with USO offload converts
to GSO_UDP_L4 & GSO_DODGY sk buffers.
Added changes allow skipping segmentation for DODGY/ROBUST packets.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 net/ipv4/udp_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 6d1a4bec2614..8e002419b4d5 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -387,7 +387,7 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 		goto out;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 && !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
 		return __udp_gso_segment(skb, features, false);
 
 	mss = skb_shinfo(skb)->gso_size;
-- 
2.37.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
