Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9021B0414
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 00:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341098; cv=none; b=iq9BVT47m3lRfZGGotwxgxNuOckRZyL0Fw0+phdzB1LPGBcu9vNrubT0eKPYa7uEQxOD60A50GfVUmLPjYDjW7wUlY+YC9V7BrertUqh7dDOyZ6UVXC9C0OREpNpiIhpcAxmquj47Tg17wHfAM2cxRRFIQyMwdcuuPjUEwxUEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341098; c=relaxed/simple;
	bh=TYmMByH+5sTf+Nmv/lFpsDIcxlWf1v6PPyxvRt0BSCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p5KAUt911Ye3KmAt6fPni/BaekWfTRhF5hxq8lol3tn37NY7P3+Wy8dbJmDD1MxRDdS7TLw5Vyfos7ppLCJWoJnTcNxR/cO2joCjzFRxVmQ15diq3vHDqYR44upUTTaf7NIMeBgXGHnGk2bVcJGnfd5yDpBpaTBya76RQ+TCtio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=be7qf9He; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="be7qf9He"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-248d5074ff7so1576845ad.0
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 17:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341095; x=1756945895; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPvtzAfXM02gxsFwP0R3/4GEgD8KwF6jICYx2UBFbv4=;
        b=be7qf9HeBUoioHJaph8hxAtcjuTm9LnCJfr3ENj/ZYgErsAeEq8SNvNpnCgQyJr+h7
         uwQEo2kNQnYBxHT3XyuaKOoC/akXvQZo2F3dbs9knnhyHVRCgC6idMvh3KgRweI672xU
         AqvdOOu7PmiGWiqfXxVF5lXL/OOx205QdAja2Bm7ImhJsAvC8YA18NAZDMlTsz7MCHkR
         02M25TUDkbWXtDx0aVBXtjD7T6Sa+3ENgabNh6INw+0JUzcW+B+QpfnVtsHQ2TkU6eiD
         WtcSoqFBwJ0F4EH+RqvcSaSfh0wX72CMOsjQznDI7M61qs8UWj3Ko1T47SHf02u/kVTI
         eajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341095; x=1756945895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPvtzAfXM02gxsFwP0R3/4GEgD8KwF6jICYx2UBFbv4=;
        b=rIby+daJk6iHKWlf+6ZnypNBZgxwJ1NW2CCTSUOk6F1W9VosF96mAWx6ThEp4VILWo
         Y5N0OuFWeOGnZzT6WhIC2i2Rf8K5t4uTlcQrceX4kL1UDiHXjvC4JE2N/6CfP0MQsZL7
         pADnTN0T+rJS768Mt6wCysfBBrtvJx8cXx6MTYYvAcnQksH1OTuT3DB91pIvY6dlTRCZ
         da4NAJb8QAIq7cFirnw7IXcpOPpYkMezQJ6lBz9EFQA9vlRxPJb+VEHeJ1bheDbpqx34
         1mQz0I4QorEym6q3bToEXlN+WmdG/lvGJcVUCd38tlqpaGuffLjkq8Q3ILt/kmbAUt9t
         UHZg==
X-Gm-Message-State: AOJu0YzwNQPNF9jcYr3saCzAHWg7R1Ljyiy1mqkFn+iG3JBgnT4aaXIS
	jwVyhGbKawa/QlBNb/q2Exww4oE6CvFFMIznB2uCwHsIScSfum06LL78
X-Gm-Gg: ASbGncvyRT/HysRxKHApN9hQevDPv/88E3q5JEGk6arCgv6mcbOe1fNAdGAuVZa9kFX
	ZtUbT7KDde6yk6mCfDkYpvyvbxIsLzz+AGL1eKLA7SfFSHalv2PsCxtE2v1mszPRTnAHs/7O99W
	lR/427hATyHLGogChTFTZgo0veWNZBvBbAy++SNjC2kJExvc2bF2IrXBgZmOx4LraV5Csq1bViH
	B/8cPKueaAJY6f5QWKqRRcYaP6clyotbUckbOk0E2PQif2W7772VroprNKxOXMB/C9/zTkyMPP4
	IeTZ5aUGZ33iQFV5gA/GoPwDF0aMrizP9/UbVIvmnJxLKpqpYsU0GzR/WP51tIf/IuojOxrA8k6
	qlkgm1dfxmjVu6SQi40jG8oCzjTaFG/pykJIC4KghEg==
X-Google-Smtp-Source: AGHT+IE2PGfR2lyF9Hr8hV5HbfYYYn2UwMgBVIhXdHI1pQtLPnrjVODZOdxlZ2k7OY2teQU7xaDFDA==
X-Received: by 2002:a17:902:e88e:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-248753a2359mr86214995ad.1.1756341095375;
        Wed, 27 Aug 2025 17:31:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24893618880sm32735435ad.99.2025.08.27.17.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:34 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 27 Aug 2025 17:31:30 -0700
Subject: [PATCH net-next v5 2/9] vsock: add net to vsock skb cb
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vsock-vmtest-v5-2-0ba580bede5b@meta.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
In-Reply-To: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a net pointer to the vsock skb and helpers for getting/setting it.
This is in preparation for adding vsock NS support.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v5:
- some diff context change due to rebase to current net-next
---
 include/linux/virtio_vsock.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0c67543a45c8..c547cda7196b 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -13,6 +13,7 @@ struct virtio_vsock_skb_cb {
 	bool reply;
 	bool tap_delivered;
 	u32 offset;
+	struct net *net;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
@@ -130,6 +131,16 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
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
 /* Dimension the RX SKB so that the entire thing fits exactly into
  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
  * rounding up to the next page order and also means that we

-- 
2.47.3

