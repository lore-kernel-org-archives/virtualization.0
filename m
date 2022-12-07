Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD42AC63706
	for <virtualization@archiver.kernel.org>; Wed,  7 Dec 2022 11:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A90441759;
	Wed,  7 Dec 2022 11:51:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A90441759
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=vvi8mLQ8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b9mzrX6nOqOA; Wed,  7 Dec 2022 11:51:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DC61241511;
	Wed,  7 Dec 2022 11:51:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC61241511
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD3F0C0071;
	Wed,  7 Dec 2022 11:51:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CFAFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6041A40942
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6041A40942
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kt86W47RU7fN
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73E79409FC
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73E79409FC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:29 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id d14so19582530edj.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Dec 2022 03:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xi/1JoZF74FcvKn/bwOZmu6e38qXh11OS7Ij6MGyCE=;
 b=vvi8mLQ8FWGj1DPzR9o/wPIx9cj4psWvbIjzttwi0YJs8sN1dzhKa9aU6H5Pg7qTHy
 bsGtCZWl5YpQj/2x1qsouY2KCqhqRrWmTdYt6WqOtdGLDd19BWhQsBJosPC5Kjh+WztE
 igsPew/lrUSoQt5Ucf+U/+CDRsycLjxVoXrhQTuliGZVp3MWREKbZkFjzw4Dwu3GTdIi
 exYK+RzQ2FlMjAf6eqQaoXrJBg+zQUUrqQVDGSKI+qPsxXhQhOkS1taS2nmKW/ynkz4l
 SjwmFv0KSwkzUwTSl/iYWckExZiNhtRPu9zfD471HNPjdM9F8zb1GnVFejWc87H6ZFkl
 uRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xi/1JoZF74FcvKn/bwOZmu6e38qXh11OS7Ij6MGyCE=;
 b=ldm0mddSQzUJIWbwdlCG4xot2o70Nirda6nEkC457s7J4bcmaWBerVxq4+AeBS8vEj
 T7JdkV9l3/YTAAylnOBDlG0wJ90oWWjud5ccSysebkarZNRV4uOeeGSVk/0eVM0hrDLW
 mN+TfhaCrxq3QrPyCF5mDMt0UopIyRiKXyr9rcJYjmJmPiWm4hHE8ETJTcgnL0l6Kn5R
 wlyLiIYoge/rV55/O/VvqH0sbAXblAkzQ/bP3rV59qCXw7ojUviHWpkZJblt6f+rcOql
 WyYgpl2jkLO2IT7KomnLSuJQet4m1agdHsjP9DrMJnxXU//NNqJ0cl3zu1IlKET4LyIA
 br2A==
X-Gm-Message-State: ANoB5pnQhZPWQtRKiJtSWS6iDXOGV7vKAsTnH8pqebyuzwBhUctTB5Mk
 petw+IMJBiD/gZeK2Dx3Ndnlbw==
X-Google-Smtp-Source: AA0mqf7hiBXQQAn0Y+l2ZkZr03wQTds9xREx1n21mzMwdfGo0jv5B6/ORm3N7D8kGcyItmXCulkrHw==
X-Received: by 2002:aa7:cdd2:0:b0:46c:7119:47ad with SMTP id
 h18-20020aa7cdd2000000b0046c711947admr15635310edw.387.1670413887674; 
 Wed, 07 Dec 2022 03:51:27 -0800 (PST)
Received: from localhost.localdomain ([193.33.38.48])
 by smtp.gmail.com with ESMTPSA id
 g26-20020a056402181a00b004618a89d273sm2132816edy.36.2022.12.07.03.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Dec 2022 03:51:27 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v5 2/6] uapi/linux/if_tun.h: Added new offload types for
 USO4/6.
Date: Wed,  7 Dec 2022 13:35:54 +0200
Message-Id: <20221207113558.19003-3-andrew@daynix.com>
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
