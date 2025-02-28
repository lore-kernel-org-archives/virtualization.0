Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083141DE880
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Feb 2025 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729557; cv=none; b=cElH3J3OzItO7/tgkN/EiJRUf9GJeCJ+NRMYlJqGpDlvcDJaoyqtmwNQVciUv3yYeF5TfSm3ApCLhlPt7mEOCmZMMjVWHIgh4TQMw0loeSMAGB/i4v1MEQAAB33lEqdx+FBRQ7DDNMGKHvOxR6bYRdiuABu8xelqScke7LFHfUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729557; c=relaxed/simple;
	bh=6JPnLhL8s35dB03n039XAvB3PJPp3xjiscDs8gfFdqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=eeOt1aMUPjGN+3XtsL9mRPjVgCFbNDmiYgQU99MNCowVMobdiWgtobUYQJRQ3vGS9H+9G4hz53qEk3aRWUmLyx5Iagp9l6BrGU00fUPyXnkBO5VtjGH7FiJ1B7qXpQaY2IQNezAO3eigUReStzsRSoHSvypbkSE3MA6G7saqZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=oG1mQyBs; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="oG1mQyBs"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86C18607E5
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Feb 2025 07:59:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JACVWOkxeDZ3 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Feb 2025 07:59:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C34366F765
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C34366F765
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=oG1mQyBs
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C34366F765
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Feb 2025 07:59:14 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2234bec7192so48081845ad.2
        for <virtualization@lists.linux-foundation.org>; Thu, 27 Feb 2025 23:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740729554; x=1741334354; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hY0V7oey/1irsg/oxeJVyzd/IX234qFLR74EBUPiqoM=;
        b=oG1mQyBsbIz34tLTVsQDsER31ATHzXhNJj17EglbzomDqLQfTUn7kp4Pp0ykpZ/EXj
         M7JK4b8Ida05X3vlutGY+shccu4Be5T6umW2kG7QXzD5P+et/DUtLiZDFZeXoQo9Oebe
         ckGkiIZEcLH7Fb+RIsY9N7LngZxmLE7cy5+eitXnTp9jIMTeNdSXx2eU5ncGUM5nFLpn
         merc7hTrfnXH/MRFkQL7MN7vj9orVQK9q2pRvJH6bTHVMJ9F6K2D8coiyoO+/tLpHDPr
         zN4a08s/QtNnWGGq15K0noSeuDEpRfG8k99sa3cw2tGogC4iG1oShKfLpa1uGCIqCi/D
         jqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729554; x=1741334354;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY0V7oey/1irsg/oxeJVyzd/IX234qFLR74EBUPiqoM=;
        b=EuJGljRArdQXcbU79N7Ar7/a7PadGoNVZnN9LXcy3ODlr+hvZPosD4pE9vs40iMB+k
         Bb5W2d+TzDMoqyLj/gzIR05RhjJKIwtOTSR1RZuT9SID1Van0LM5R7XWCrbT+YVlCo8U
         dFQLSa2XNMDmgnjFDUPLkT7FUEFyfuZXa9pe1XIN+P0q+iVpGkRY5vuJiOVuEBOk9P1c
         3I/VWO9ULt9ybbO90rT+ew1TiEkKg2alRnEXPlgiwEElLyRaV+r80IFhC9Y/zXjNkNqu
         Cxzb8vo5bSQfQVJe6VTtnS8ry5S4IKJKfyCSfk20K68wvBiV+2ZZcJjo7HP0bs6ptlSo
         8mpw==
X-Forwarded-Encrypted: i=1; AJvYcCUCcO6+aDfqJqfR87+LLzmDNXjnNBfcHWrElWHNp20hH9a+j5NkAad2wVCQdqru8323NMwqr1mkf85pKpaJlw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwYAi64/YZffCvmFfx/76t6K6oH/Zn4gTiW3Tvm/2lyg3eH4SOf
	xtHgJ3GEeHFtfUpG/ABoCDwrzxMqslZkuem3iBtub9aGQUWGdc3bNrIoi4osulPpfaoYhLDWu2k
	80Cs=
X-Gm-Gg: ASbGncuMO9R+mx+ZRHJFYF/4d01JEZSeS92jIzHpNhtV0AGhLszgfuQ7F2iiWBu0ZFM
	wroXNtm9uwM5Nm/Gdu3CLr2L5QoM3++Itm8QntuH9w0yeeWllJ6MomMEAFv5IEq3x3OsBJeHsn+
	/wRJ5hQFl4FLvrn1l6Khlj+rUfJU2wRPuupDLSKJqevFfPyyf7ZYI1jYgn1lpSJatHMYAUbWOz7
	6DgZLATyoE7ugq3KgT6sxj/20IcWlSRni973PbsLNpWbhCHR8bFvg5CvG/9KATyvQue3UEFo6mZ
	8+zvqwBBZpTpGQIknDiPXzYwTe0+Hw==
X-Google-Smtp-Source: AGHT+IFWTUEIr1u8c10m45czztBToHuvUxMVabSMAgvvIo/y/63jq+3tXupc/0FfOTFltv8uY5F7yQ==
X-Received: by 2002:a17:902:ecd0:b0:220:f030:376b with SMTP id d9443c01a7336-22368f91ed0mr42335305ad.21.1740729553732;
        Thu, 27 Feb 2025 23:59:13 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504c5bfesm27643365ad.131.2025.02.27.23.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 23:59:13 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 28 Feb 2025 16:58:48 +0900
Subject: [PATCH net-next v7 2/6] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-rss-v7-2-844205cbbdd6@daynix.com>
References: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
In-Reply-To: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
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
 Lei Yang <leiyang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
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

