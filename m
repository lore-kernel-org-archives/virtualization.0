Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886581B85D2
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363134; cv=none; b=LjcZzjsorCN7RJiEf6ryD6gNmU4OQ1VbY6lGAHSVvpTDAQCKA5tTODObrTCmH80jUQrca00xIYDTy+o1uGcJ2ZczmSHT79PFFGyFsI2wAiH+KbcK1cS8SQnLaDXnpx7r2TZuEvrDVtPwYt3P7C8Y7+4vxGrm1TdX2Ut8lAdKkgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363134; c=relaxed/simple;
	bh=jkhM+x9bNKZH2KnPiJz0Wz2oSY9j9Yf3OXEdL7BBvmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=IXulHcrFN3zHFbFmDAFVOo53VA+5tTyS5Ej17Ntswmgtj+fLHbyfM23a3NaYUY2VSOoLEh1dwt1hYRsohuihXz5R4VKjDvpy/5WqCfgZxwqJDldmqWu5NvkRtdrvWDakxpcqPxfjW5pQ1BrPI5o4CrSEXt+goQ5w6TVb2PB0bkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=dL/y4UKn; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="dL/y4UKn"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43BF540C3F
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:18:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VYCHDPVFhQHA for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Sep 2024 01:18:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 67B5840B3C
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67B5840B3C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=dL/y4UKn
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 67B5840B3C
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Sep 2024 01:18:52 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2053616fa36so39726535ad.0
        for <virtualization@lists.linux-foundation.org>; Sat, 14 Sep 2024 18:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363132; x=1726967932; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLQiR3TXPfmR5MbSmS8z1giBJhJI6LMQJhK91hzIYDE=;
        b=dL/y4UKnX8sdssnXr7BYfMX6j8kPRaWM//l8SNS5ldojRElbD8KfFyS1F6awG3lM8I
         1Cx+6ITTrFQf8e969RRDsq6rq24r5vCKhJf+hEj5V433XweADzVqljFpuGvaD84TEzA7
         Jv078lSOYUhRAOqZyGpaaruZtejerkB3KkLZoQ0iz4csfv3Ug3K7lBOn1cCZMbknmEgS
         hpoWFfb56gEbO74JgolZkYDCBqx2yzMeBTBYWGcRWDaxGJiP6FvRkLybe3SRuJlcxEJN
         NpFoQjX2NzJmMaP6oXv93GFGUzq9N+XxIqyZHaiDNdfJ0qnsdj0RoMHb9bqTsFqpMxng
         uKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363132; x=1726967932;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLQiR3TXPfmR5MbSmS8z1giBJhJI6LMQJhK91hzIYDE=;
        b=VzI/Id/JvRV2+fz1AHw9mts4xSMwJhRW17P9YjByAXW4vqSBIc/Cd1SMKK9sA3X7DY
         bge1R9pp2xKEA3j8YM1lppP5JJBSIO8hqcO05e/8mcyfM9w0YU4wqeLkTP06gC6PLdok
         Lh0msoi5xU0gnLrDy875aoJYWXdH8kuxGJNDMU33jdsvhrdUgUvoHV0d1bbEJdL8jDSF
         ZHcEeiejM9A7UVM4pwY7nMV3/xHfvV8MtynUPmsekXpJy9Xn3R7noWWb5QLGfNy2TgL2
         uheezbSxAfHpFddl2Zs918L+7LKAeHR9sW+QjWJfwi4Joyvjsd0a7wtMFewkNH/plEel
         Tcog==
X-Forwarded-Encrypted: i=1; AJvYcCUxICptq2eks6sLm7thSL2j6/8ycjOb++TsKlEieP2eZpw4jCjuTqo1JWzLyOm9oQTexr2hhWTkbX4caKKDNg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxKgsexWOkKgOq5SZatWQJ5LcMAywfX6f6oErs6Gvct/yJg93DN
	hiTFcNXkOnJL8AjzZ7yQOWrddapwk6SAIPP/JCEjeEbobutkVsaysbJ2fE8D2Sg=
X-Google-Smtp-Source: AGHT+IHa2pPsD6I/59W1SS+oOKkVkOqdCgI07i1yNz/1QsPKuheqwpLtXx9aikNZgE4fL33O/C0z7w==
X-Received: by 2002:a17:902:c40e:b0:206:add9:624 with SMTP id d9443c01a7336-2076e39fc33mr198047165ad.36.1726363131701;
        Sat, 14 Sep 2024 18:18:51 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-207946011f0sm14895345ad.78.2024.09.14.18.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:18:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:17:42 +0900
Subject: [PATCH RFC v3 3/9] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-rss-v3-3-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
In-Reply-To: <20240915-rss-v3-0-c630015db082@daynix.com>
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

