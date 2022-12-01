Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4A2C4332F
	for <virtualization@archiver.kernel.org>; Thu,  1 Dec 2022 22:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A6176111A;
	Thu,  1 Dec 2022 22:48:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A6176111A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=xzvF7+sK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dLIvB_qFo-GQ; Thu,  1 Dec 2022 22:48:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EF3DD61115;
	Thu,  1 Dec 2022 22:48:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF3DD61115
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C96AFC0084;
	Thu,  1 Dec 2022 22:48:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28532C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03AE282081
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03AE282081
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=xzvF7+sK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DWi22ipLD1Lb
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3BE7D8204A
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3BE7D8204A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:53 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id l8so3527497ljh.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Dec 2022 14:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xi/1JoZF74FcvKn/bwOZmu6e38qXh11OS7Ij6MGyCE=;
 b=xzvF7+sKYs9FnkItHR1K33sb7MGYeSiGHvp2MIhfkwWzUiQxUL5b/bjUy5+9aoMJEA
 wz1hDfsiTefJ8w9dSjfPqA8Ly6b6WlKZLngPdEICZK4vxv6QufmYjI1/b5oyB1F1B8Lz
 k+DVnujYB0SnhaYWzGuHwbPsOk30z5V3OuTa3NxcXtIhLHit10GSfErJN9KBxDV9uBkw
 pal0X7LWtAxS1tmadnlATuUpNY3xZNnWMayPp4IUoBE30vVNQ4AmsHXVjg9WRTxZLXlb
 OrCzRlJoUxrfq84YMcrJYPPK0F5Kpws1z10QTUC53UCCLikAP8WRSbOiuzQe1hihjkdD
 O+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xi/1JoZF74FcvKn/bwOZmu6e38qXh11OS7Ij6MGyCE=;
 b=UN3qNPBZIGpxAOdB7JahGuLNvETcHLw6AkI6p4Z1rB7//vMbOXwjYP295KdphRFFSK
 BDW9hrsFl6OdTme3My1TjiXE4caHJtCkzif0Hai9bkvz9oEaj7+k+D9+MzXzfkf1WtHB
 VXHwToBzcpNH/VkGerN/5WZqLxaUQfA/b+XqXGJa2HTD/rzyESVcNsXUmLcjXzrgmziO
 Pqk5UPc7+6dfCEcB+Wlki2HL7vm0FvK0yk0pIZrXbw/uMQH6NR/K1IxigAxUZshv3FFB
 HpfiSsTRYCdTG1jG1cFOu+Sk5SE/R5nFO+xdChTJ1GBTbKJyr+W8vEuoVsIiVeU97rFL
 XUQA==
X-Gm-Message-State: ANoB5pmbw01JvzaTqtElA6Thov4dZlcVR3/4M1y2uyXAPSeERDwTC4Ci
 7LunuW6LE5qpcBfAUTeFPI54nw==
X-Google-Smtp-Source: AA0mqf418uc95r9fB9adti4adpv8zlD9n7w9EdZVolCHTCOFvVgKW4MDAgDvwPYxrs3JEmqj8JOlqA==
X-Received: by 2002:a2e:94cb:0:b0:279:8865:38e1 with SMTP id
 r11-20020a2e94cb000000b00279886538e1mr12232294ljh.217.1669934931102; 
 Thu, 01 Dec 2022 14:48:51 -0800 (PST)
Received: from localhost.localdomain ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a056512118700b00497ab34bf5asm797573lfr.20.2022.12.01.14.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Dec 2022 14:48:50 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v4 2/6] uapi/linux/if_tun.h: Added new offload types for
 USO4/6.
Date: Fri,  2 Dec 2022 00:33:28 +0200
Message-Id: <20221201223332.249441-2-andrew@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201223332.249441-1-andrew@daynix.com>
References: <20221201223332.249441-1-andrew@daynix.com>
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

Added 2 additional offlloads for USO(IPv4 & IPv6).
Separate offloads are required for Windows VM guests,
g.e. Windows may set USO rx only for IPv4.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/uapi/linux/if_tun.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index b6d7b868f290..287cdc81c939 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -90,6 +90,8 @@
 #define TUN_F_TSO6	0x04	/* I can handle TSO for IPv6 packets */
 #define TUN_F_TSO_ECN	0x08	/* I can handle TSO with ECN bits. */
 #define TUN_F_UFO	0x10	/* I can handle UFO packets */
+#define TUN_F_USO4	0x20	/* I can handle USO for IPv4 packets */
+#define TUN_F_USO6	0x40	/* I can handle USO for IPv6 packets */
 
 /* Protocol info prepended to the packets (when IFF_NO_PI is not set) */
 #define TUN_PKT_STRIP	0x0001
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
