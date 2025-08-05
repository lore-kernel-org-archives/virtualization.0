Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DD526059E
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430558; cv=none; b=Q30Jvg5eY30Y/ZTQIEqCh+2zXP1eTS8E3hw53hGpydTtz6DAzWONSA9tMWL/QiGPPr3M0wq+HxPvGmVphFGtrjUQ5RROjv2zik1exQ0DXoa0PkW8Dvj8C/Wqg6pqAKnVapDwQ/av9KXGsHGpFU0JTmIy036Cd7SSy85AKjEcszs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430558; c=relaxed/simple;
	bh=CDv1Bq9IATltc0TiHl4mQECx9R2KqlZC2n1J6SSVOj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CgbXh+CP+l1Jf81RRg/T6Qa2+3hzqXu/HoO+hLYyHSFuXLRza/q05whxLD/+fCDD+SCzAn9JdHLpasyvbMcLpQ914/J8RF+6Oj0ewBRVnf6yFR0J/7h4FdfgMMXd1faK2Qv+WwZlAsz3UdPs1aZac6KQRQsqZGiw+DlWPufaRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoGVKoWL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoGVKoWL"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32106b0930eso4770402a91.0
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 14:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430556; x=1755035356; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0FnPyhHm3WVprItOStvPF/G0ADOLLcY9YeC2HhcpJo=;
        b=XoGVKoWLpJ6lGoxUAh6B7vI2kZBeEpPIsOgjrkF02lIL86IFREvV3Jpp5xp2wdZ0Qy
         MrLLpPmy7C//xOfWFb8T/vFRFmFcxuzECkjoClfc9M9zOSdL6K/DMqwfV0Mxen2oOPIk
         uucRBLXSp3/4oz7s18G+igMAkw4InApKnUTw5MMt1lHpzBjK4CqZoLKYoW7UDwJu0wZY
         MHifWy6VUjozs/J5W2501d2WPdESSNUVOvsVzsOBEpRtgdlC7OLw1MjEqZBiQLRR1C+v
         eAsuI9gYjYm/LxCkqGkUbTom5Ps9Exd1DuExkIOlSarfakQRzmgS+HFb6dXv2ZPnovth
         8sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430556; x=1755035356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0FnPyhHm3WVprItOStvPF/G0ADOLLcY9YeC2HhcpJo=;
        b=W93Nbd+6IvNZIvWfcKg89kILQFPoHDyneDT5J6nb6c6LFO6XL2aFso/JCsR11G1lO9
         0zCKvAnLngocDDNBhdDRDY5dddxaz5ZTA0epEtoJ2LFAk/Y5TMP1beQRRoI14l2HoAVU
         Fr9Mpr6KQAnTayrpoDbPSmakjw6oEsCjzb7BtZ6+5v/MESP5wLYxXcxzknsIhsq4wMsn
         lRoXkfolL3j+kNSnZfFNhq4VZj8T2Z9Arj9+gYCCTnAWzMQqeDQnHYxPRpaiV3HEdAJO
         FEJx/HB+o5vmC65LZrIZs5meot2gviv7F9LHynHVKJJJUdWFY/QjzoP9OlcGDQ6zMT25
         hzYw==
X-Gm-Message-State: AOJu0YxKk4KnhnmjqUdpVGdWDJdBdn0hghQeVh23q8IFICde49/YfHW7
	u+Bg70gTVhLTqoYUf3AMBHZajSxoeJF0Ric8TC0hyxar/8kKLepxJP0f
X-Gm-Gg: ASbGncthDZ6kHUsO0Wr7HUHHmD4mkQPM+JADbejRqv7I0QYPWU0+UAaMyPc5je8hX3u
	u1hO2Dn5VojQnVtGTIjeZdXTT0MK97WyK78yElSlHn9Ng5Uc0LCT3JU2ddhypDKbxaHf0tzSdL6
	9T71/GOq3uyJCRa9Pq6g/etu/x50yqqMOWlhRupc2cY/+GWrE9RUj8ZKS3y40yMITOOwOcx4XWf
	lLjmN37co2LpeLBMhu2nkxhSYwHQrj6qVt2hTU4F9T1wsN+E40GTkFmkvQKZmfu+iWqzLivgDkJ
	H8EjgcwS4s2dwuEaG6H3Oh/n5qxRJkfQaS2xmR5xPhYVOZM92JPwkWQLcjv1R97XEtp95DwmM+t
	X5tT/4QmLtZOTh/dWNG0a
X-Google-Smtp-Source: AGHT+IHhgArUDVEklDhUo3FAHUEOH2pq0YKOQiSFglKsHXA8X5kgylXUPHewA95TMT6Ar3nMPtRlMQ==
X-Received: by 2002:a17:90b:568d:b0:321:1a89:f692 with SMTP id 98e67ed59e1d1-32166c2918bmr458783a91.8.1754430555834;
        Tue, 05 Aug 2025 14:49:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f33e58sm17823090a91.33.2025.08.05.14.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:15 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:10 -0700
Subject: [PATCH RFC net-next v4 02/12] vsock: add net to vsock skb cb
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-2-059ec51ab111@meta.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
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
2.47.3

