Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0620296E
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580638; cv=none; b=NNyvYAaoPM881tvBL8NHGdYvhRwjdaY0oyWc4Yw/1EICZMdCr35ln7aa2CazBZR29qwRv3HMmXcGes+NjkAnTPhghrIx+8POU1ABlkCDnCL1MfbBVYqrEPcb2QqAijJwVZ7JhX1pyzuzWxrtuxmkRAw5DTD/2pX+wUvyww4PBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580638; c=relaxed/simple;
	bh=2oUMDnIBYoOmxLZqcn3thZSyZ/SbegpNqOzQC+cCzEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=IWOK6ePIv2s2/8UIrHlkR6xyUWR1sN6dE0E3mI6mVrV5jtgxlkyUnNZ44k8Ck5TxGrevpt+Ai9ALelq28DtdnC0Ul/H0DEq8qDR7fIuvapVVyle2devedggthNmrZctDvWwErgYbOf3YqQRQE/beHrwMx9UVa5uOZRc3Zp7iVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=GhNpq/pB; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="GhNpq/pB"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85FAC417A8
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:50:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1xq3i7ho6TJA for <virtualization@lists.linux-foundation.org>;
 Fri, 30 May 2025 04:50:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EE1A740CD6
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE1A740CD6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=GhNpq/pB
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EE1A740CD6
	for <virtualization@lists.linux-foundation.org>; Fri, 30 May 2025 04:50:35 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-7376e311086so1651262b3a.3
        for <virtualization@lists.linux-foundation.org>; Thu, 29 May 2025 21:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748580635; x=1749185435; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTqe1YGUMZdFRvXBjnIPkdBxtf7RTeZ/o279FoAQM6o=;
        b=GhNpq/pBJGaS9SkKPS/4Gicrto+WJFuI8GCT8rF9a+xkQ5fgse0XMrtLyGO6JskrAH
         BlGXI0VtM6Jb9ytLxM38T7WjwhaVg+AiNfC3/ddkAYw2HpDCP+4XodSH4fV5a43B7X2Y
         2/ql3HHQFgHYa46Na8t9QLnEyDqxbUCaoGB441K8G2nxQCYWoW6c4zYOqR80YIpSd71p
         Rl+JuBJJUZh3l9nwSba0W+VioARlNg9iqPHh3BGjxZ2LLTYdj4kQwAVxP3+zInSbhG/W
         h5HQhq2dkAQEc7bteQiZ5IVWCHw9SkdXH/zxofzvyYJ5y3fIvnkSJL6d+tLmOIi/obs7
         QNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580635; x=1749185435;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTqe1YGUMZdFRvXBjnIPkdBxtf7RTeZ/o279FoAQM6o=;
        b=MiTQGX8HQ+8yZCkSFrnukLcGPTNevUG3gL0UdZ2ejYbpWawL94KyopOGchjMgI+Iwd
         5OpRgAbNkZFCnlRNInZcQvpxsz60NInFhQqh5bFkCLX+pwu9bOoId28p54vA9ADjgM7e
         eDUo8LMbj23VUw7tefdsve8bCvnq9eu7uXnZpTtveFi+l7Pm1/ptvwYZml6jVeSj1Owf
         FUbMSRBMWzoGRAOOCmlhBzHoS/5QBy9znx96AoNsFo5s2LuNZYWquIjMpOiUTDri+syy
         A/g3f4JsRIJfS75zzxuErd391nV+t0yFf1pRbp+7zp2YRqqnqxgXYR0xyh8BZkUuj459
         HPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDF6rXlc2iFrNbe2HlZWi2PC/yY7rzR1wGtzjHTK/pcFv3f/c6QwZM8rCdX7Olfp5BftIxbVbHiDKYwwGWcQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxgoFXoISfrrD/JVW7Rel+hMyv7wZ0hU8VY5AKyLlAmcKE0tXo7
	dbiJwLSRuo9eQXAcRmYxH1XnhGce/aL4+bOAxsnYDe9RGQuU4XHZtP/AHE3csu1A200=
X-Gm-Gg: ASbGncsa7gf7I7xjO2oYrLcd3JlUAj8lLZRfSvxCTEnsxrzr9OA5jHp25uyBarCqcDh
	E9zgqbIkkCICfCpj3/WZocGC1pS1OGEXcgb1sO5MEgceH3RmlX7x7fc7qCgaVaqqwdTqpKP4w3p
	m3eeYTj7jt6qxzAewnjpoCaWHMzWF/3WEcpizrHV8TZ+ALAlxRZUdbNw3B7R22DeZOoalWpFFoo
	0Ryc4E3eCTPKv5oZI7X/8Ewh1rOprxzCuxNLJdzmeKoR7m16rRObMdb57Fopwe8NlBK45msUws0
	AWPmDgXC7lqsQlUhO0zXbONQirBVIYyaZ37cR/o4g0A+xzEe1Dop5qD46S7tAi0=
X-Google-Smtp-Source: AGHT+IECFVZeba3N9ihXZ5rbjNszUdlvoohjDNehjvfvwHvZL080L1tWJfpWoXRRwXkMbrFpkWtKqw==
X-Received: by 2002:a05:6a00:4b54:b0:736:5e6f:295b with SMTP id d2e1a72fcca58-747bd97b301mr2912852b3a.12.1748580635197;
        Thu, 29 May 2025 21:50:35 -0700 (PDT)
Received: from localhost ([157.82.128.1])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-747afeab6bdsm2179867b3a.37.2025.05.29.21.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 21:50:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:50:06 +0900
Subject: [PATCH net-next v12 02/10] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-rss-v12-2-95d8b348de91@daynix.com>
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-0-95d8b348de91@daynix.com>
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

flow_keys_dissector_symmetric is useful to derive a symmetric hash
and to know its source such as IPv4, IPv6, TCP, and UDP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
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
index 9cd8de6bebb5..32c7ee31330c 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1862,7 +1862,8 @@ void make_flow_keys_digest(struct flow_keys_digest *digest,
 }
 EXPORT_SYMBOL(make_flow_keys_digest);
 
-static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+EXPORT_SYMBOL(flow_keys_dissector_symmetric);
 
 u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
 {

-- 
2.49.0

