Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8A16F826
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168485; cv=none; b=rtM2ga7NPF2hlNwgu5Zvy1amNilCEeuO8CklQmepLf59n/YzixPfnBVJPQYFd4fuB8Yy8n6l/GuS++QkNvqtI/JbjMmP2lSyhwwEC3l7L/hqD9djB2wbT6zzGkIUqS3YD19OqGHKkDKk+GaSugQlCl/sAy1wMvO4Uz94kfTU7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168485; c=relaxed/simple;
	bh=jkhM+x9bNKZH2KnPiJz0Wz2oSY9j9Yf3OXEdL7BBvmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=rd0pz2gcQvWVKnPn41pfl0a5K3dg7fmtZYC2YV+2HtDBCuqjGVzvrvw+v4T6i1bQKpr/nxAy9neeIrLZ9Xuva/iQwzEaT8OchuHiv8u9DgEDf+VDlcnbY2di57s8oz5QuewPNtjczvWhKU/30oQEjqx3yAni1XPCDR+micsZs2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=RDIVSc1B; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="RDIVSc1B"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E6DA8030B
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PR76sMYFYMnz for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Sep 2024 09:01:22 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 69992811BB
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69992811BB
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=RDIVSc1B
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 69992811BB
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:22 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7b28so6694522a12.2
        for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 02:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168480; x=1727773280; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLQiR3TXPfmR5MbSmS8z1giBJhJI6LMQJhK91hzIYDE=;
        b=RDIVSc1BjAYp0MCgc3BAtZ7nRtjOkm4brDVfDVM0kSB2G1bLhu9aF1+1QH6ZuoNNLH
         sRJYwFcJEcd43gFARfs/uAAkHSWuPen88ndnoKpupRCE/VAK+LBr3l586dH9iIBf5faR
         f5USrl77bstQUfEQ+k/oaXmgkSLkRgKGR3AFhvRaTNf0LUk9tl493YKSjX23mDSn4Jw8
         Nby2xtlQzgHd1ZlNNOaskiZmkp/3YmmZk7uBtUU0x1qbIvarCRjWcFS2TI6HmFk0Ox3r
         Ut/iU/OYZv253cVSaaeg+J/jZG4wbvfh/k/hSY97am9J3+kHJBDQo9Mhv5uap7Zl42Qx
         jpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168480; x=1727773280;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLQiR3TXPfmR5MbSmS8z1giBJhJI6LMQJhK91hzIYDE=;
        b=qCvhug1ftGyH0ITLQ/U9hVWG/NdfwAwBbSIOdbF14bRMaAFs5jbor/evcfTe6/faZw
         V3yzwWr8IFP5vdV8I3KBQI5NMWltuWxVnR43p21RCdP/X2TJxWHW1IhpdSZgYSU0DHx9
         /v/tduDXnKcSphDznSK8F8e06kx+W4gGd1+zdMhvYEQilfSzoKJkf/pF5idgbsauX+dD
         Y5UqKXHhb+QXLkcZo3yNQOizCA5vvXjONi9Gkxowe21Vvv0/hF6CCcNHgCy78uXG/T4G
         GBZwVqk+tChbYFfRj6fqzdeR9IDvJ6xOYWHl4CI87GXzwwDmV81y/gRAxECHgPklTvMD
         5fTg==
X-Forwarded-Encrypted: i=1; AJvYcCUsP7gOLNFU7+PwghFm69bScUdifzj59D/wKK5eDI/aFY0atPC0TwpNw2tj51W6oESQQG91UIvDmtG5gmK08w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwAF8JkhKB6xW7f7lmwrT+6ptNgN8oSl1ibbrfGawcyKDV2lFbG
	WoP4nntLOiLJJ+NPEtJZJLpdG9nD1fWQSJqB5IQ/xMyz2bvyqXlWX2C9CcLcKbA=
X-Google-Smtp-Source: AGHT+IFpGV2s1+MT/Wmetrjt1jnUx/JVoB/QDy6LvgWwnmt/y8aBUWSPmWV8V/zA8CCvTi/SZQaLnw==
X-Received: by 2002:a17:906:6a22:b0:a8a:7b8e:fe52 with SMTP id a640c23a62f3a-a90d58c1039mr1494327966b.59.1727168480198;
        Tue, 24 Sep 2024 02:01:20 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a93930f470asm58712666b.151.2024.09.24.02.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 24 Sep 2024 11:01:08 +0200
Subject: [PATCH RFC v4 3/9] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-rss-v4-3-84e932ec0e6c@daynix.com>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

flow_keys_dissector_symmetric is useful to derive a symmetric hash
and to know its source such as IPv4, IPv6, TCP, and UDP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/flow_dissector.h | 1 +
 net/core/flow_dissector.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index ced79dc8e856..d01c1ec77b7d 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -423,6 +423,7 @@ __be32 flow_get_u32_src(const struct flow_keys *flow);
 __be32 flow_get_u32_dst(const struct flow_keys *flow);
 
 extern struct flow_dissector flow_keys_dissector;
+extern struct flow_dissector flow_keys_dissector_symmetric;
 extern struct flow_dissector flow_keys_basic_dissector;
 
 /* struct flow_keys_digest:
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 0e638a37aa09..9822988f2d49 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1852,7 +1852,8 @@ void make_flow_keys_digest(struct flow_keys_digest *digest,
 }
 EXPORT_SYMBOL(make_flow_keys_digest);
 
-static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+EXPORT_SYMBOL(flow_keys_dissector_symmetric);
 
 u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
 {

-- 
2.46.0

