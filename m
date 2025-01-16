Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CBA157E88
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014976; cv=none; b=XXAhnnCrLCiMvIFcgvzTuyRBnomr9dWfKNCu88sOr5wPDdCcs6kh2Kv3RKikh8gED8ifS84eFx6j8XGVuvZ+6ElbuRqkDyi93P7hMf4g0fhnexnWBPnmvBTQb8sQRhiIhC4dX+9et0/LQMcB1FeYZ8K1EmFRSgGhw4TJwR3EtdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014976; c=relaxed/simple;
	bh=hmozYSHMasgRBCBF4xrgoPZ2LwIXeYuHywhslmCDunM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=EmhUpqvKR6em3mL0HxkjUceQzW3ptH4P11uopQH00/acMTeq8SbMkA7udjOcwG3CokawpjRisjShAjKpBxnATSlABAsIvaTgMEP/YfvOeCdOKdRt46YgRzP4o6EA2B8bYITj4E7lyLxkUObTWPQ9aXxC2IgLkG5SUIJwzmGzSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Hselal2E; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Hselal2E"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E00714183C
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:09:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P4iGA2f5340F for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jan 2025 08:09:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org ED6DD41812
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED6DD41812
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Hselal2E
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED6DD41812
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:09:33 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso955613a91.2
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 00:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014973; x=1737619773; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrRxU+soYwScLHZl10nkQ00JQwkyOSxqF0iWMzuJt8Q=;
        b=Hselal2Eczfq9qOsxpXgPfBTRnU1Ws53MNkMqK/pevhWtjvo6kiERz5rHkhfEjIIvB
         7aIsCaK1+m+wVmtTsR5WaOtTa4Gvj1y94gp8k+NbhdU+H82JgMxxLDWLTf1nDYrszFOR
         0tHJ1qunLTQ6v6ifyvX5+iprXeHJP/TAD4isd0iwyPI7OGjEAPC8Ns5BjhqZ5rKKntKY
         z6nT7rVo7YMAVmBbMfJxlYwpO3fR9b0J2MJiTqj0gutnUIUeOR+RKcAiyzegVp752PvP
         rjOlDD7Mx93EHycocL3L4S9FjdPx47l+REmhaNYJxIQpWVyJC85tL+eYWk0kFTZQFIvQ
         p0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014973; x=1737619773;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrRxU+soYwScLHZl10nkQ00JQwkyOSxqF0iWMzuJt8Q=;
        b=NCPmR2vKLeSHBP5jyuHZm+bhBulvRIdfdXFi2/1aiQx6wJtF++o/dYhwdtzhkmfBTY
         +6l7xl3etl3nKZf+HYdeK1y0LZk6EdTFiNWJwh84iyODW9+Ujw+AkfRXsyG2S+NVtjQO
         aHxJYvrsyRf+ajUauFVFBtiBDGLKLenF0OaTQ8SZvumIIBDoXzqjNa+LTatHVatVEy8q
         gmpj/Z9Dk4Quk0weWS1I4PNbNJ79zfe/NAvXAzNIlUiP8b2TlHq52mffDZAW0oHkIFuJ
         4zDFQ2y69wl9nJajjz6LS1KZV+r3oZfMdVMRO/wWwwbKSErt6sLrr18cKAN3MzSGXAlE
         02ug==
X-Forwarded-Encrypted: i=1; AJvYcCU8vxLInjVKq2+6MayxqCUtoQdzhD2lC0gLWUAPpEdswQSaE+6m54CDyRKRl82o1nK0w5uAf683lYEHajUM5w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw4mQ3AesptQjKInH41fFnRTpytSDU4joZebXuuaYp/PzhvHoh7
	dYyHQS9O4HLTZp+Gd7d+jxhnq4ES1oTvaawh73NLVlzHK4i5uDTpUcqGmFrQQHQ=
X-Gm-Gg: ASbGnct2DkU5PEjxn42CSCcAHS8jlF/zWH044E0nLFQx2xK8EP8TYiuyfnIXZmV1oR6
	fzU6zY43hGhP3TxG7hsThcYUMA9v1zIHI39PtlnkM5Rh4p8H/7h77hWAnaPpx5GLJxlPKU5JHck
	YbkO80rg1+qSRmlqQMJXZe+7009bfKrtdbdlBYvrsue4EI+0KzIYHl7KV4t+OU72ii23N931DGu
	6sNDYMz3dGcMemAwvJTdCYAdujAHFmZO2PlJcwCGay3bLTeFLujPdQuoo8=
X-Google-Smtp-Source: AGHT+IF/aivT7VGN/9qY0NI0lkx2WlvvYYZoSqZ5FMDTYVZ2BGLKcm5XiuPnE5f2W/R9LM3n5U+OJg==
X-Received: by 2002:a17:90b:2642:b0:2ea:aa56:499 with SMTP id 98e67ed59e1d1-2f548e9aed3mr42283442a91.1.1737014973234;
        Thu, 16 Jan 2025 00:09:33 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f72c1ccbd3sm2690558a91.22.2025.01.16.00.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:09:32 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:11 +0900
Subject: [PATCH net v3 8/9] tap: Keep hdr_len in tap_get_user()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-8-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
In-Reply-To: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
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
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 061c2f27dfc8..7ee2e9ee2a89 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -645,6 +645,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	int err;
 	struct virtio_net_hdr vnet_hdr = { 0 };
 	int vnet_hdr_len = 0;
+	int hdr_len = 0;
 	int copylen = 0;
 	int depth;
 	bool zerocopy = false;
@@ -672,6 +673,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		err = -EINVAL;
 		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
 			goto err;
+		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
 	}
 
 	len = iov_iter_count(from);
@@ -683,11 +685,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
 		struct iov_iter i;
 
-		copylen = vnet_hdr.hdr_len ?
-			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
-		else if (copylen < ETH_HLEN)
+		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
+		if (copylen < ETH_HLEN)
 			copylen = ETH_HLEN;
 		linear = copylen;
 		i = *from;
@@ -698,11 +697,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (!zerocopy) {
 		copylen = len;
-		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
-		if (linear > good_linear)
-			linear = good_linear;
-		else if (linear < ETH_HLEN)
-			linear = ETH_HLEN;
+		linear = min(hdr_len, good_linear);
+		if (copylen < ETH_HLEN)
+			copylen = ETH_HLEN;
 	}
 
 	skb = tap_alloc_skb(&q->sk, TAP_RESERVE, copylen,

-- 
2.47.1

