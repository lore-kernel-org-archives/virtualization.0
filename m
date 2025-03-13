Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8637200BA3
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849306; cv=none; b=HEy4C4pGNYokw4CHRiq5+1p+zWZn/4E2jDP+GK/XfL3PWysMFZf/3e4FF0g/6TkcmqzV33pqiXYpXtfOIHnOJaXm8DgspH8NlGO5jG4cxzueVisEcmi9M3v2uzCuuuylQihZpO6KKWGR8ihtmeMHIkbfIysNMyNLvwzyY0mcqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849306; c=relaxed/simple;
	bh=uj6BiB0IqVm8+xs3f9Zn6aCjK6f7zlPp0hv2djTMvTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=CFvb9TwyRgy8p5c0GJjwu4DIlUqoBqSu+yz5SrX9Mp95qtGWfxknONEJGz7rFGFGj0ft039piVFt6V2wwUGtrUuW1Ou+d/nxbJWeo2dFfg2LlgrgJlAU1Gy4WcL/+Wjxoy9GhZUYwUJe4puOqfKzNp/UHXdjlOfccCKHcct7/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=fWzPTLEE; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="fWzPTLEE"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AFE560D7B
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pOZxjTuItNJo for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Mar 2025 07:01:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9880F60E02
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9880F60E02
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=fWzPTLEE
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9880F60E02
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:01:43 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-223f4c06e9fso11050195ad.1
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 00:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849303; x=1742454103; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFouu/EN4lEKQm+2Nyv7q163Sd7hDT7Qc+wcMAoVrxU=;
        b=fWzPTLEEH0P4pwhWxTQ9/d+myVgh3oN3qBL4/xX6sPZxESnO44pcVlGseW82a2dpVa
         nwHVJwdOVSh0SMotj6kRuae181t+jlWbVzACV7utSKGh/Iu7Y2AlY2Wtw8xaBmgL6sQu
         +LCz7IqE9U2tXFGDEzzqpS4zsevVxGqZc+H9TKvsQiAvRxOhXbjzo64FHiX1dbDIRoyA
         JVG75jedDkdlAD4sjg/2/56gwfzdhnuCsd9fklwgBJaPpI2IvKEjHRBOWsWbHqg9OQYS
         QDD7p4ChEDJt37vYbJ7aVJOwBwiWO1BJc7jxFmIECJ7XJGF7ho20AslnARNfVhiW4T4N
         QwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849303; x=1742454103;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFouu/EN4lEKQm+2Nyv7q163Sd7hDT7Qc+wcMAoVrxU=;
        b=NCgWxLvOberGNODWtzrotM8Fg/gld1/arFSgbl4x/YSqQ1v2q1GQTIUk+/Fr5sNNMr
         LUINmpe9+SnUY8HjiDQSBQxOBMBpAo9x37sosXQcAXh7kKMHsve9hZCuVk3toJgxm+5k
         AMShS3QTC4KZAoQT9RGz99q+ugKMU9mmOHxXLPCTOHRHId0p245e0re4HOW4SFfnbpNc
         GUishk3IfYjGJV/8cTWeaop+xfN9Qyv4hXH5oUF4K+eRVy0CSEUgdT1JFwcGSbQfv3qv
         XHIIGlrGv439CtvrKGPDJHplLU0G2Zyqw7+sAsxA9KnS4b5bZb/mf8T9Cb2NxUBoY4DO
         RCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpIEYHxYzfg+TKWBr1GI/+R1y9zft44f7l+zUsaK+ci17C9lACJPpcSWST60OWpXaPQZzdQoi9m5iU7iO4jw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyayWuQlEho0/Z42eWKhDf7Zhnc8mSejgD+f43bXuJ395XrjgQG
	I9HtBzpVEDJVvuMr9ieByQo2HdKzQY0UevQvMV3h1okFpiGwyPUBEVf7te/1IT4=
X-Gm-Gg: ASbGncuTh/ZvhFm6+Nyarmsjcg/Er0Tv5R906VNVCNcrg8UEk853aW7WYP8GX7z5EXE
	nNWoj6IDgJ7BxF57sKIN4hwM7TLsalEICjAjW6aWOHIOYTyNLA0AvN7x0pXDBhPazVdB50n3CzQ
	APNJwBUZIyhLXx6BbEZblfm3DPUE6sKmFJVMT/uc5Zuzgtk3IfUf6WqlWdm/uK/ftBJWzcy/RpW
	/U1hkcsJrcyyOjAakdbnhWF6apB1rdV9G236js8Ny89sDjyrQj7057VyGusSgv9RjAGCwIoA/WH
	eIXruh0+r4hO/Ybv5UN9V47apJlID4gfvOu/J6Oc87PQ+BOn
X-Google-Smtp-Source: AGHT+IF41bM6O52nxyqfLS5xcbnmD0BRXYmKkq1aTZiZh+PP5DLgrJ3Gf/DAzNS+0zNbGzXZ+/OHfQ==
X-Received: by 2002:a17:903:189:b0:221:8568:c00f with SMTP id d9443c01a7336-225c64097abmr19829395ad.0.1741849302826;
        Thu, 13 Mar 2025 00:01:42 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bbe84esm6495685ad.176.2025.03.13.00.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:01:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:06 +0900
Subject: [PATCH net-next v10 03/10] tun: Allow steering eBPF program to
 fall back
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-3-3185d73a9af0@daynix.com>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

This clarifies a steering eBPF program takes precedence over the other
steering algorithms.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 Documentation/networking/tuntap.rst |  7 +++++++
 drivers/net/tun.c                   | 28 +++++++++++++++++-----------
 include/uapi/linux/if_tun.h         |  9 +++++++++
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
index 4d7087f727be..86b4ae8caa8a 100644
--- a/Documentation/networking/tuntap.rst
+++ b/Documentation/networking/tuntap.rst
@@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
       return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
   }
 
+3.4 Reference
+-------------
+
+``linux/if_tun.h`` defines the interface described below:
+
+.. kernel-doc:: include/uapi/linux/if_tun.h
+
 Universal TUN/TAP device driver Frequently Asked Question
 =========================================================
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d8f4d3e996a7..9133ab9ed3f5 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -476,21 +476,29 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 	return txq;
 }
 
-static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
+static bool tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb,
+				  u16 *ret)
 {
 	struct tun_prog *prog;
 	u32 numqueues;
-	u16 ret = 0;
+	u32 prog_ret;
+
+	prog = rcu_dereference(tun->steering_prog);
+	if (!prog)
+		return false;
 
 	numqueues = READ_ONCE(tun->numqueues);
-	if (!numqueues)
-		return 0;
+	if (!numqueues) {
+		*ret = 0;
+		return true;
+	}
 
-	prog = rcu_dereference(tun->steering_prog);
-	if (prog)
-		ret = bpf_prog_run_clear_cb(prog->prog, skb);
+	prog_ret = bpf_prog_run_clear_cb(prog->prog, skb);
+	if (prog_ret == TUN_STEERINGEBPF_FALLBACK)
+		return false;
 
-	return ret % numqueues;
+	*ret = (u16)prog_ret % numqueues;
+	return true;
 }
 
 static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
@@ -500,9 +508,7 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	u16 ret;
 
 	rcu_read_lock();
-	if (rcu_dereference(tun->steering_prog))
-		ret = tun_ebpf_select_queue(tun, skb);
-	else
+	if (!tun_ebpf_select_queue(tun, skb, &ret))
 		ret = tun_automq_select_queue(tun, skb);
 	rcu_read_unlock();
 
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 287cdc81c939..980de74724fc 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -115,4 +115,13 @@ struct tun_filter {
 	__u8   addr[][ETH_ALEN];
 };
 
+/**
+ * define TUN_STEERINGEBPF_FALLBACK - A steering eBPF return value to fall back
+ *
+ * A steering eBPF program may return this value to fall back to the steering
+ * algorithm that should have been used if the program was not set. This allows
+ * selectively overriding the steering decision.
+ */
+#define TUN_STEERINGEBPF_FALLBACK -1
+
 #endif /* _UAPI__IF_TUN_H */

-- 
2.48.1

