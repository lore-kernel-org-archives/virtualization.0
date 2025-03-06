Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2F20AF72
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255035; cv=none; b=Mshh2TjFLQJEOtMDWsq+VD9RK/sOBNVqe4Fl7wg10i2x2QwOxNzQF0yEyuWmYJwvMEUr3uSFEYpIhBR0vKDz+7sfp4k8sTAwhImB04aMZ+6gjZoELj1pCz8MuruZCR83x+3MwPwpUQhTd5aMsGCcZvEuGhHjV+c4k7s6ze/zUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255035; c=relaxed/simple;
	bh=6JPnLhL8s35dB03n039XAvB3PJPp3xjiscDs8gfFdqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=j7Iy8bYXMIMeOzDy3GLRZTc/IeQwK7s6AAAURFCSEOWJaItw80Up/Y4FOuQxpzT/r+aF2sq39tWV9gLTA96ld4DL2DIUmBybWblE4FxE3AbRISAtg8PCBG+qeFB0cszKEcn6jc14QVV8kA9fSEUpdfwja90qkhitGpgD7l/wgRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=r/JZ5BpZ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="r/JZ5BpZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D99D4405F9
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 09:57:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eZDXg6TGUbny for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Mar 2025 09:57:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D1716405E6
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1716405E6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=r/JZ5BpZ
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D1716405E6
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 09:57:12 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-223a7065ff8so8886165ad.0
        for <virtualization@lists.linux-foundation.org>; Thu, 06 Mar 2025 01:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741255032; x=1741859832; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hY0V7oey/1irsg/oxeJVyzd/IX234qFLR74EBUPiqoM=;
        b=r/JZ5BpZHaraaYCYrpumTJnYKpwu4tiYAyM6NMkqEO08KbQhXJBVN+8rI2L0C6SEOA
         tvRYrvEc3XFp4egP8NJwI0e2sqpKQ8Xz7jSGBZdcg+vMscmMazSTLnk24hAHwFBPtksG
         sEOxppDRTewh1hGTr83CyKx+9qJO/iExcCK0sANAJbsmTrTkzKEeqQLuCaNfrLYTYzuW
         TAES6gRZd+HbCwdi3/+LqIs7X0eyz9tVpSRmsiHcnDMRLjBQNyY2T7guU8BzuWxGN+SQ
         k4IBl/ARla+WdIXUrydRUYjLzsyr67+3kv3p56/9UpuKVGZf/bwJKB4dGPv3Xrb65f+c
         Dt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741255032; x=1741859832;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY0V7oey/1irsg/oxeJVyzd/IX234qFLR74EBUPiqoM=;
        b=axu8xKylFOITgS2CfNtY4ZrAVcyGbi5NQKfrh1VemJ36ITT4nIidCVdR+y8AyFsp2Y
         A7i3piBizVH1xC346kvCMx9qDBJLenVyfK7TU+vM9ld+ziZ6Bv7TFqGmLC9DX4enHWlx
         KLDR1zfjhLN0uP+3baSQFIG/z5tTEqkdmfgVUNW1vhkoC0pBiVAxs+URlsA0Un/E8rCy
         +rAaWJN19KlMZe1bOtgjQjBSYQJEus+s5VEO9wBRd5e1y45WOT7Q4mkOCToUfN0o+4rQ
         IAI/wndlECdeVdfhoSL7RTLfgkBvNRUPgjatPowPdmtCvP2gR+TVtGjoYqvCa0ScVKso
         isgw==
X-Forwarded-Encrypted: i=1; AJvYcCWui64oA68onx7Sn4lRqTbAgpgRGWnFsVupY7z/meezNb+gYjboiI19YrCSOvWHY51VAbi2PngQkmhEAAHq4Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy99S7035kyiPh3/yVTu2EGB25IyhtHUJWg5Z25imJC3WTFIxNW
	iehiUKe4wTwzbVEd7E1jKuqCH0OuEK2962X++hrNkaCG/YBjS6VYjEiFBKqCmTU=
X-Gm-Gg: ASbGncs5mx673P9jzjNB1fYm5LgxFl9RxEd//s0PCpehRXEsSRJrHPKWRO+I43ut+9G
	sYW7QyyL2latc1ySUgicTanPpsibl16mjX4KbC4hztbDhCiwer/Ir/qSxDP/6/WbpNRlOhR716/
	fSLopoBfNFnynyXhDdiz+NCu3gDWZ4LoKgENWncwsgTDNdkpFWYo7NxX6b07SMQWhXtu8WALRHt
	ob27R3QP5DdOqQhMBRGhehEehfpazgFZFXd/v4J2EzNMnJb3zNyGnAmzaPWMKfluAZKboQ5VEuC
	1xsiHvT1I4gQWXXXWjxQpodKIMqPppo1twMIkMqwFnNf9Wg6
X-Google-Smtp-Source: AGHT+IGlvJ3QJNQ7zdOmSl6WruunBWchSJlMnXfPdh91/T3HMnxY+JOOEGUyqA7YRqbtPgOIa/y+WA==
X-Received: by 2002:a17:902:ea03:b0:223:f928:4553 with SMTP id d9443c01a7336-223f928486bmr88417775ad.44.1741255032170;
        Thu, 06 Mar 2025 01:57:12 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410a7fc55sm8314515ad.138.2025.03.06.01.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:57:11 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 06 Mar 2025 18:56:32 +0900
Subject: [PATCH net-next v8 2/6] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-rss-v8-2-7ab4f56ff423@daynix.com>
References: <20250306-rss-v8-0-7ab4f56ff423@daynix.com>
In-Reply-To: <20250306-rss-v8-0-7ab4f56ff423@daynix.com>
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
X-Mailer: b4 0.14.2

flow_keys_dissector_symmetric is useful to derive a symmetric hash
and to know its source such as IPv4, IPv6, TCP, and UDP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/flow_dissector.h | 1 +
 net/core/flow_dissector.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index ced79dc8e8560e25a4dd567a04f5710b53452b45..d01c1ec77b7d21b17c14b05c47e3cdda39651bec 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -423,6 +423,7 @@ __be32 flow_get_u32_src(const struct flow_keys *flow);
 __be32 flow_get_u32_dst(const struct flow_keys *flow);
 
 extern struct flow_dissector flow_keys_dissector;
+extern struct flow_dissector flow_keys_dissector_symmetric;
 extern struct flow_dissector flow_keys_basic_dissector;
 
 /* struct flow_keys_digest:
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 9cd8de6bebb543c3d672f576e03b29aa86b9d34a..32c7ee31330cf52df05d7a23b3e50d1a1bed9908 100644
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
2.48.1

