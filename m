Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BBA23ED76
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134780; cv=none; b=fkGGcaa8Z9ziIeGjlMz9GaBrWrlEadblM2qW+LSBVM9Z07fs6zpBhF4jhLQr4tBrz+ck2Z1vx6ddwrFFbBA/k+sxe+AObhawm6JufNsuAR6vTsaCvXmhZBUpeskkuxOknn58YbBaadPKcaBGcmcSsncUJyZA+CO8Ev+Bm27DV48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134780; c=relaxed/simple;
	bh=qoJJ4i/W50edlHBToQPG13aPO77yuBEPT9SZ9aqVWJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gpcO0cIE995AzCrfT1OKu31aq5c3CFMqhytWJGKP1PerTfRCmncEIvFvuwjeirvlsaWSlDogl5Cvb95YutIW0L55A1unFbWaApNG4AUtAB4OEeCoUghX7v8UhOiZZ9GPabAVaMh/QAvvCy9u2BLxHNAVxoxKVnUjC/gWZGVWxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR+0hK2x; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR+0hK2x"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b3192eab3c9so3046809a12.3
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 21:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134778; x=1750739578; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdPQ5Aka/ET/K6+EX7H2iku6AwIaWmDdsZFMu+a0Iz8=;
        b=hR+0hK2xeBS70X7KPV7g4MDovVBJRtLT8rTopxtWnPDzwvmzc7ED9iNbci67D+z6YJ
         WrA6MeAFTK/x7gevwcxRCDM66VgkuGDjTkCY2Qg8Wzr6JnFVlmTa000g4Qew82sCxZFW
         MHcQnVKaaoBHNNma0eUq4bGL7pzHIZtzmP71IApI6om23EkPHXs8w7oVd8tZImSNh3X9
         AUUGywCcfEv6omnOnCmgLgsjlNBJ+mIRp3oK2X6anWQ2747R3JazP3ykz7iacd0yo/WO
         h5/P1eXBuAQAmv747O8+eC5WADy4FVBff+UY6Q2MkYFCJXYM2SAxFIfmCYg1iMsV3fBA
         L0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134778; x=1750739578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdPQ5Aka/ET/K6+EX7H2iku6AwIaWmDdsZFMu+a0Iz8=;
        b=nzASy+Bc+rEtVfHRnez9xvjKKR+e0DyLWNTuzbnuMiAou64/h8Nnl5iF/XUaNhZhJX
         hqlTdQwlVaAU8lwL6VbD1nb1+YnifdWOpFVEUaVsFk5GGV39nipn8cgxfBaH50Yujxjb
         +z2mCJiKOSQ184fi6lgeUBLLXVhJ6QGJ+/XTU8Mi5W42M7DEJdDMbSUXQMLzW+6r8lid
         abCm0se7tqy3+YsMHhGD6gcfvAe7HylPNvxRSefqM1j4idwxQn2q86NlSDyPgDn8P8fp
         TWv0Yj5bOHKVFR1C6x3nFgxVkEyg1mJslsedPUzpnK/huyIaVvRxVdbrBNzIvcaDY3H3
         dEvA==
X-Forwarded-Encrypted: i=1; AJvYcCWMc6zwDe92TJvr/3f9aJujmHvIIURRx7EQEC54EbPonao30ouMjyshYMGGNObWyZ1ZJmnLUDzkjKdAUpc03g==@lists.linux.dev
X-Gm-Message-State: AOJu0YygNhH6WeE4Q7yj8kAdRSbqKYnTKrtF8zJ2SD1HTXBV/9LtNaKB
	mM0fD48ccYAR8nFU5zr4Rz6E8V7LDxSOWZDToQzQCF4H6JsdZqcC/BLU
X-Gm-Gg: ASbGncuyha/z1KlJVlnXxI5c1bYkXF9RmxYyWutuCShl7fYFnimyxumXxZPKXofCqgZ
	NvyZsbTyyEu25mww2dP1nX/Q9gDDXrP5BI4G8QTlldKitK1QxTOLH8e7grpW6aLU2d4G7ZKhrdF
	tGN/twWK7hXnLCCrUXEqRd0ATW6E0qRjU+t5YjwnSe4lLRVtLFDgLmu+oStppb8crFNPPUve5QL
	IBKhMWn47gYYsPrc/y3yVrK8vnfAZovRimbyr67dXXTiJonDQKRXvxF6mT+bfJ5+Sl+Lly35OB0
	77FIXpZvzz0M4R572nz1lyzQdYjtA/poXpkPkjjP4eUsp+N8sFu2il/CkPLt
X-Google-Smtp-Source: AGHT+IH265eeeimXvBdGeNS8fFQQO32TNNnphVtyrQ1wwHVb3dE1zI1bmUAeXXk6oS7lTC1LBMOMGw==
X-Received: by 2002:a05:6a00:4f82:b0:736:6d4d:ffa6 with SMTP id d2e1a72fcca58-7489cffbc7fmr14615749b3a.15.1750134778566;
        Mon, 16 Jun 2025 21:32:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d257asm7746822b3a.165.2025.06.16.21.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:32:57 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:53 -0700
Subject: [PATCH RFC net-next v4 04/11] vsock: add net to vsock skb cb
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-4-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a net pointer to the vsock skb and helpers for getting/setting it.
This is in preparation for adding vsock NS support.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 36fb3edfa403..93edc1e798a5 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -13,6 +13,7 @@ struct virtio_vsock_skb_cb {
 	bool reply;
 	bool tap_delivered;
 	u32 offset;
+	struct net *net;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
@@ -111,6 +112,16 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
 	return (size_t)(skb_end_pointer(skb) - skb->head);
 }
 
+static inline struct net *virtio_vsock_skb_net(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->net;
+}
+
+static inline void virtio_vsock_skb_set_net(struct sk_buff *skb, struct net *net)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->net = net;
+}
+
 #define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
 #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
 #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)

-- 
2.47.1

