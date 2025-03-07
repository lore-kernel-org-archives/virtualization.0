Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960D5212B37
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345307; cv=none; b=BpOZbP4qLAC6YtR4nU8D7z8zlfhZ3G+ogbKi6qJPflo/SP0Mi+vNr6Pc1+mmR2Z7kKpV41+rhmB6A42zQMJQ2RO2bmC9jYFFj5jdulBWKsBWtvi3gJVZCAOZzJ8LlrElq5/fTFNqIEhhSUpmpB3PF9gBHjToQMWLfowNNXOBmk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345307; c=relaxed/simple;
	bh=0OHQ36QrTe7B1BaBYHRqBfDehy2+CeWD8fTKK9khYSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=czkqjCJucCDAMusRLvZVu38t4UKiafHC+C6xuKLF/Vv5GwJLQzENosgjEq43n+pWUPrjNVjrWS2C7AAR4bkozSTLJeW9ZRSGZHFna9Rn+Yzp1i82kW644OfDRSjr3RR6j9+554bqrli+BcuW+ELnslNjnIELHx4fygH8tSHjhwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=d/XiIpjJ; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="d/XiIpjJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 212DD83BB0
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 11:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n_G-SVvx9FPE for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Mar 2025 11:01:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5D49B838AF
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D49B838AF
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=d/XiIpjJ
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5D49B838AF
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 11:01:45 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2240b4de12bso1947785ad.2
        for <virtualization@lists.linux-foundation.org>; Fri, 07 Mar 2025 03:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741345304; x=1741950104; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hESKaeLsTlVoI9NZlnZYgG71APAUJLtsH2I4Uu+Ek7s=;
        b=d/XiIpjJEhQeAD9jf+hjMdTi1dnuwKUMhXlG7tpn85I6Q/CyTjbqYHWQIC6VEJXwLN
         fnK827RSQBlV9eVD0qe06ZtVWhGvg+t40HE18MvT+hgOAIonhht63IBEyZlktuY6v6/W
         QkpE1ej0Tn8nX0vqOT3GoWMI8/29o1vwSTgRhkbQOuK9Kwcd/HJWmuU3ZVvIGZe9pKU6
         B0h12qvkZXwFm10SyKchZuH+rvwC4832UZf0okLMsBcLgA4rbeJlIi6/8hU0iCe9WadK
         +L+goNsibfWGsrTfGQpse5n9Ti41zoTP85sfVCOSeEQU4N6WWmx6/AozmKf31mU0kp3k
         riyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345304; x=1741950104;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hESKaeLsTlVoI9NZlnZYgG71APAUJLtsH2I4Uu+Ek7s=;
        b=ua8tFYWJeiMH6PP9XoX9o2YzEE1uAmr47m/L8ItN+iuopYpTt9At9Z+Bj+tCT5vkRG
         Ih2oeg4FsEI+q3gaO+GaTu3Y3ifp4+drAysCS3hy3F1d7FzArGYgbQCia67yKpU/qf/v
         fALmd7upPs3WsQlCUv34uojfxBWA/UZ6jQZisvNUJX9QFuVgKhSpjl+xPkUeD0ABoSlW
         6nGXw2jGnpw/aycDNuPIPJd/t6upQjwOYey7ah+reHMaxNC0myHeQtJAFh1TMMEzJl2K
         22Uq/kXXhWu2NauIu3hLBMzw2slWy/mil73JNDvpNY6MuKRI0imhcZ+DeGKfGVYmFv1X
         exlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYna9z6FYl16Q+qF0OPCaldLrfpKFrWWveB3MuApan7HehheBlUJ84nQ5O7zKKsByjIP0sj1vDCE0NC/ISMA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyKBc6o0wY1T5t6azqgsEn2xXl0pvuNZRbwUYvg6BSVXsxuWx40
	op+5hZKnq0fyTJ4pEgGozwf5YiaHuBYX6ghT2BO6A+KpyR4h/XdTbcBdQL79g5E=
X-Gm-Gg: ASbGnctoT9mnP2hT3UEr09dXOwrzr50yKIkoLgizKQVD3k4yNMCwP6zVeSDc2vh03O3
	d0jDOpG3rptbi0ehJi7499Bb2ZsbIBtXynrMIGrMUvEwjNYjLiWHatYutso+PrVi57NcpOQA+Vi
	cD04rsp8PUPb3hbO7naQjmeKczsX5tO79n+zonn6eV7XaZ+N2fwVgYRbVPXSFvTXt6Yq3VRj78n
	rRuxsMtgggTy8LkWEelmLC+N2ZLatyUyUltwOlh9atWSfFZfJ+zdJ0/YsbSGunSx01nZMXddl9M
	szTn4Awjpikfdej1TPQG2uYvj3N1u8G0ZF5RlOgCwf49+ri3
X-Google-Smtp-Source: AGHT+IFjXPz+rtxm9fbn+OJtTENM9UvJxDY3nmnkxyWgPEnLzrhO14S9pj8Y+h3HFl0juxuW+kAxWw==
X-Received: by 2002:a17:902:d505:b0:223:37ec:63d5 with SMTP id d9443c01a7336-224289945e7mr53616935ad.28.1741345304575;
        Fri, 07 Mar 2025 03:01:44 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410a8ff3csm27196145ad.161.2025.03.07.03.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 03:01:44 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Mar 2025 20:01:18 +0900
Subject: [PATCH net-next v9 2/6] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-rss-v9-2-df76624025eb@daynix.com>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
In-Reply-To: <20250307-rss-v9-0-df76624025eb@daynix.com>
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
Tested-by: Lei Yang <leiyang@redhat.com>
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

