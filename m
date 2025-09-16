Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058EE2E974E
	for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066236; cv=none; b=On5MM5n5O0+yTK3zZ51zvlyce46ndSSAhJoncRiNdVR8aivLnjewuEMS66IICzjE5ydUKGH6yUBoGTa1CpSw9almG5sw7wE8TjHAjzBYVtrdaTVRiiDzU8FkiV0kvsbXkppehLz1CHqYOWNTVYNsK1+3S8NuFi2MozjM5HAGPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066236; c=relaxed/simple;
	bh=W8gd6XhWQ6pvri0xbAF1EAgDb4RZn2xcu5cNNgZFNfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsgSKt/2mNuwakJjZcjxR/yPG4zY2ViA7BvtHN4ZV81V3sdtrNvOTI7W3eGvDLdLhGgDqD8HZj/r2Nf5j8BU7XTExP0B0RfBoOfVFxvITI/xLz48iZUKNPVoMZB7L9pUahilrsgC0lG6xoPBdt/KMTIRbSkwFcQHq/BOm8SI0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPr30fUS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPr30fUS"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so4845270b3a.3
        for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 16:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066234; x=1758671034; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJb7YbnroGsFtLz5T9G1lwB92kjtyMi3xE/F7vK5JjQ=;
        b=bPr30fUSVjFYeZUmf1Efisyzxppj90CBxf/RYWM25gvHO72ijfSeGy7Vzvvx/Cgk1A
         fn3kPlUzqP5dRIu/ydio4rL+7GqTCsZqpb+VZuPjTLHHkioFmN+SN9eVLS5BUJjN9gki
         IyvS2vpr8YUMfVqpd2TM3D49R9uuUHJE2jhQaO3T9rwpqXP4akt4O9474sK0vQE8l/FP
         RjHeyqtFOqJkvInsH3gbN2YbETOQXloqV9pIx+S50mreSvsJScinBzTIOfLIQrqobuFh
         D/zYpAX6cpiK+sWGOX9TzaTWlzEOLOhDq4bPyTQLrJ8ksEQmin+ZHHvQUdby4v8t/hYO
         ftTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066234; x=1758671034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJb7YbnroGsFtLz5T9G1lwB92kjtyMi3xE/F7vK5JjQ=;
        b=IDyDluji7YMFPd0CaQGPKaZBm356PI4OOehFtQyJAYvw1fEqlRcaZ3A4w+mWB5mvOq
         YPOvIBojQw2y4e6yHZ1LotDCZCAdLpeuC47bHWrnVblRskysi/2uWh4nmiSHhOh4+n24
         lcbAYKpxD5QDo+7BeqQSWSNOPCoIi3uxkp6krudfmt323LkB3Gfp/m7uDBV5j+UUpxUx
         lik+PaOtroOMGv3GfDjaTbhX6L/sPa/Gs8eNRXLpN56/kbmkyAxy3jKBBxFGWWnozaYu
         nBfo/9xTLvlJPKuvtzsRF4my0cIVrpVzjoEf0WMJKr4czawuM9gcSNS4HvKt23xHdXd6
         gKBA==
X-Gm-Message-State: AOJu0Yw+n28zIjEdRdstDgpDQ+kvETa9tn/ZzOXxRhTw/nC9/3gY5a/9
	LYtU9lS0k4oFM6oKFveJZ3whxdIoAHeCGNryVkfxyZ2cUM5x/+D25sXe
X-Gm-Gg: ASbGncsrYlJD/Rx5jIBq2t32MOhcuRtUW07keIjsgBc/KLUinzHiLlwPFWZJ+9n8Y8i
	LSvgycSohqTeKBpTpzqR234jiC54Is9RNUbI5nlYFFVouJzKFCoTk2UDgAFVofm9I5s1Snm7yP1
	aJ+78zgCQ0VEa1fB0cMwVBJdbYmM6TfQIZtWaJjE/HCm0ZdjzDkDVDep04pPTEPV5r4HuQGgSIB
	BaOU/UawEPle4+eOj9H19VEH+y+BfFvNf6yKWtsyYlSPi3UnbQuAKcQI734SAQz14gQV3dx7FcO
	t5RqrePsr8l7UVFEvDpAW7hQgFro6zLGnu9pPG9uareh+bf0TWNysqf19BCOLbwdIGz7jeM27Qg
	Ef1yVYcBNKFtsp7TZ+ofJ
X-Google-Smtp-Source: AGHT+IF/xw2akPqfiTx346iDoeH7Z1/kqJEVjbR3GnSIaOpGaqTCjMLhCHfObu3TSyZ9Zry5A1RkkQ==
X-Received: by 2002:a17:902:ec91:b0:267:b357:9450 with SMTP id d9443c01a7336-26812179838mr1096375ad.17.1758066234099;
        Tue, 16 Sep 2025 16:43:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2679423db7fsm59353765ad.70.2025.09.16.16.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:43:53 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 16 Sep 2025 16:43:46 -0700
Subject: [PATCH net-next v6 2/9] vsock: add net to vsock skb cb
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-vsock-vmtest-v6-2-064d2eb0c89d@meta.com>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
In-Reply-To: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
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

Add a net pointer and orig_net_mode to the vsock skb and helpers for
getting/setting them.  This is in preparation for adding vsock NS
support.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v5:
- some diff context change due to rebase to current net-next
---
 include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0c67543a45c8..ea955892488a 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -13,6 +13,8 @@ struct virtio_vsock_skb_cb {
 	bool reply;
 	bool tap_delivered;
 	u32 offset;
+	struct net *net;
+	enum vsock_net_mode orig_net_mode;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
@@ -130,6 +132,27 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
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
+static inline enum vsock_net_mode virtio_vsock_skb_orig_net_mode(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode;
+}
+
+static inline void virtio_vsock_skb_set_orig_net_mode(struct sk_buff *skb,
+						      enum vsock_net_mode orig_net_mode)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->orig_net_mode = orig_net_mode;
+}
+
 /* Dimension the RX SKB so that the entire thing fits exactly into
  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
  * rounding up to the next page order and also means that we

-- 
2.47.3

