Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3C8C6FA82
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 12:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 429A4404D1;
	Wed,  7 Sep 2022 12:51:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 429A4404D1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=byTk1PER
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gS8NYAQRS8vh; Wed,  7 Sep 2022 12:51:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EAA224049D;
	Wed,  7 Sep 2022 12:51:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EAA224049D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5DC1C0033;
	Wed,  7 Sep 2022 12:51:31 +0000 (UTC)
Received: from smtp1.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe97:d076])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95530C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70F5981754
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 70F5981754
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=byTk1PER
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0YJgfHQ0ewcS
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B52981747
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B52981747
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:28 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id b17so6898618wrq.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=7KvsrxzdRu/1ZCcF3FvQUHupf11TCZFlO9FQE3i8fVg=;
 b=byTk1PERy1xg8uduZ/vlGwafyPhLGvoY7pXynSWyML06wLvc6XPLmaRqEC2aMIwacV
 tUoup1Y1MKEfke2ZQCnVfXA7ynGh9tD6fmFJ2NeosScvDVyofRNGWL1q9VsTZpKi3MZM
 G0rbog7IRrNI2AYyjOephBJ52e1JOLDh+X2Uw7hRy8ac1WLy7tCU0d4TsHTg4GNkSTRE
 e9yTAgfQzSAllIDau9CnUscSa9dC0nCASyLiFgKN8CFAVW2l5NjyXTK6x47MJJDU5nKt
 +POxsjxxGx9AL/Jl81pq1OyBQD7x4jYpWTvIlhJ9wvr/iv7LMLfbVlVMpy4KjJFiFJiA
 MS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=7KvsrxzdRu/1ZCcF3FvQUHupf11TCZFlO9FQE3i8fVg=;
 b=UA3W2WWJHpe/dMtzCv5viZXVS6eEQBJtj8XIwOb5JFTXluIR7TREiYvwRX/iL+5FeS
 eFQQlMSN7S+ZWYBzvk3hIk0f0lk/B/j6FBaziZFwdSl8Rv2NPJ5/N1DJvYGI+//Pn7zK
 dbv9xupNlE13nl79p4ZyXW7nHR1S4yA5wIYQ/fW63J8FStjHgPxBafbAd8mJ2KmKLGXq
 L3Fdoban67qZMXtci8JQ9P9fLPdub6nVpwuQkbYo+FZHldY3dqNxAFyCiLc8RXrUodVq
 35nt5ZR/kIZWSSulVgwrTbJPMmBBQDuA0kDzorTCDfklol3QYeg4kt1im1XkMTcGkTAd
 GN7A==
X-Gm-Message-State: ACgBeo0k2S3XnksY881FD3XW0GSR2WhRIhAZbRegmBvL9WEVtGFxx2KM
 YELVLxzU3Tve922kgY9CE7tpaA==
X-Google-Smtp-Source: AA6agR59YwUbyyqlrFljRm41GE4qM9ZwcVQYqqOyOqKMX0/S32LliZKD5iDf+UMvGzsxfRdrxJHjKg==
X-Received: by 2002:a5d:47ce:0:b0:228:5769:489e with SMTP id
 o14-20020a5d47ce000000b002285769489emr1946894wrc.188.1662555086828; 
 Wed, 07 Sep 2022 05:51:26 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 e27-20020adf9bdb000000b0021f0ff1bc6csm11480001wrc.41.2022.09.07.05.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 05:51:26 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: edumazet@google.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, jasowang@redhat.com, mst@redhat.com,
 pabeni@redhat.com, yoshfuji@linux-ipv6.org, dsahern@kernel.org
Subject: [PATCH v3 2/6] uapi/linux/if_tun.h: Added new offload types for
 USO4/6.
Date: Wed,  7 Sep 2022 15:50:44 +0300
Message-Id: <20220907125048.396126-3-andrew@daynix.com>
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

Added 2 additional offlloads for USO(IPv4 & IPv6).
Separate offloads are required for Windows VM guests,
g.e. Windows may set USO rx only for IPv4.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/uapi/linux/if_tun.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 2ec07de1d73b..65b58fbec335 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -88,6 +88,8 @@
 #define TUN_F_TSO6	0x04	/* I can handle TSO for IPv6 packets */
 #define TUN_F_TSO_ECN	0x08	/* I can handle TSO with ECN bits. */
 #define TUN_F_UFO	0x10	/* I can handle UFO packets */
+#define TUN_F_USO4	0x20	/* I can handle USO for IPv4 packets */
+#define TUN_F_USO6	0x40	/* I can handle USO for IPv6 packets */
 
 /* Protocol info prepended to the packets (when IFF_NO_PI is not set) */
 #define TUN_PKT_STRIP	0x0001
-- 
2.37.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
