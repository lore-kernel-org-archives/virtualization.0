Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44D146585
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090424; cv=none; b=lzc5ZdnFuyFdzWJVaSHHlbLk+YcMmn8IsRPfTkpp5umXdgNLh2gsT8/sDQR98+gyIxvKGf30EUbjO5Ti691ObbTQi2BS2YDS8KZPq1y2BLU56aIgWN9zJhb1co221xlLVSJMt3o1agbCrSUPRfWmYbOQHqFU2SATj7kK61X694A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090424; c=relaxed/simple;
	bh=5lT5a275Jig/x0y4MU1RBKKAqav6WdTww5TZeVBwOjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C3StSxRXbavI6072VElWwGb/hGUlARxMeWZt17OzrcN2ed6Ic1LBXTltV/psq55/9cD7OwlDrPNgJV3V3Vr3LKqj/WnFArQ9ByglHh47tNsn2s7EZhAAof3FPs+75bj+5TNpgwRUQWA6FLjW5FNCptTre3HGSVRajLjvEL0+EsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3i5oAQt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3i5oAQt"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-339d53f4960so6369996a91.3
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090421; x=1761695221; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8QAc03+caTvAAzxQiYsQ8xN61QvIP62Vy0HUa32Vyw=;
        b=M3i5oAQtYXDF+WyMkc+6mePZr8VNkERAzk/qLlcKbI04K/pUK1UkhJdkF0JXA1BErn
         wV23iQgJjO+23vB8YX9ifLOPnNShDUZbZLQWACzDMJpCVmfUs9daVXtc2zhzD/yd3pR4
         LGHPQlonHFXkzYKHc/OtwgTll4G7Vo2vfewCJrFGbHY7IvD21HDsUfZ9nDZWYLce6gRs
         AmSdSO03XlQtltuN6/UqGf1JE5LJzob7UFuD4qMIp7y0cbgCquY5HHKNeM2xUy4BxEIz
         5rsGgqNTpkPnS5wGGQr6wTFwbdprt8OsC+uT+gwjY8gVKwDWm6vCCCd9Z5A6wKcnm/7G
         ov8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090421; x=1761695221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8QAc03+caTvAAzxQiYsQ8xN61QvIP62Vy0HUa32Vyw=;
        b=RXzKMfh94Ckn1LT5xKulQWCILouERkZ9GNMkWw6A/e9gy2cHWGebaDhG8avaO/6Y91
         6a+085q41jqRaZoh2emRHUbTjLujvfMZy7MwFfpWtwxBH1AukaCB5cO2wqVaB4JujvEf
         hrel4WJQ+0g1RckiXUpGwSOKSnyRmxdAkbeYT9/ZJRRjhoWU4dy/WBcaVojh0a+AMIhU
         bgebf2WKR0q+s9vgGhmo5VdEfsgXWQPRcuawfr7sTkYkU14fO9LVoLtmNlIN2QglYpcz
         Xdbm3ytkgJXlGnx6Tty1dJsyE/+Hr2cWjiDMx40mTAnilTT8ZbWs2po0oJ9JNpwdjVCD
         en2Q==
X-Gm-Message-State: AOJu0YxKsNCYobzJX8cL7qSUIceF2Nmd8E3UzwSdx+lsmdXOTtcSWFjN
	2rIq7S3cu3aPbhSRCYdN24Iq+sI+2gPZkJd92iTlwdMMYRJcxSn3MLh/
X-Gm-Gg: ASbGncsLOcWOoI/aDhcQtkMflBB0LOwH/s3M43l2yfsJ/s179FPRFQqBCUTdZYOhdBH
	5hkuWOeb/1qDCx+ujuUjbMXkiS24wdQmE5ECX9zKnDIHwKedq/WBTxphM7gqMeKEK733jWphGgU
	2RZbgNavrpyNONQYGC2nU+80/kU847j9pgNxMR/2OtX8YpsdMtMvl7G37qY6DGmXYSJw2ETEHAE
	sOm32RKBnzjD75AibL5ALP4/b0vyGxdSZ5sPAz27OytKJxlj3FlHkhm6RryCb2ONj2B1BIrao+Y
	EVbNTjrfr47qnVDrCNB76nEx6bGWkIvsT5spuZu7nSyLUNXTf4hEBtUE0uciX9MyoUpYMZG3Gtv
	WW24CLIejhrF8zcwDYyu2ZIPuR4EgorCJW90cTvUDZEp+wb+dJUggmkYLJNLZJ+0ruFw9n6zOM9
	3RHqRcJFQ=
X-Google-Smtp-Source: AGHT+IFnLd8MEBHJWDP/6T0bT9CF6tUU40IwqT7WMWTgte724ObVfh7g7Y965ujhPSVyLp4smF4h2g==
X-Received: by 2002:a17:90b:3942:b0:336:bfce:3b48 with SMTP id 98e67ed59e1d1-33bcf87f431mr27158450a91.9.1761090421527;
        Tue, 21 Oct 2025 16:47:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e22428b1esm708138a91.22.2025.10.21.16.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:01 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:46 -0700
Subject: [PATCH net-next v7 03/26] vsock: add netns to vsock skb cb
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-3-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
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
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a net pointer and net_mode to the vsock skb and helpers for
getting/setting them. When skbs are received the transport needs a way
to tell the vsock layer and/or virtio common layer which namespace and
what namespace mode the packet belongs to. This will be used by those
upper layers for finding the correct socket object. This patch stashes
these fields in the skb control buffer.

This extends virtio_vsock_skb_cb to 24 bytes:

struct virtio_vsock_skb_cb {
	struct net *               net;                  /*     0     8 */
	enum vsock_net_mode        net_mode;        /*     8     4 */
	u32                        offset;               /*    12     4 */
	bool                       reply;                /*    16     1 */
	bool                       tap_delivered;        /*    17     1 */

	/* size: 24, cachelines: 1, members: 5 */
	/* padding: 6 */
	/* last cacheline: 24 bytes */
};

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v7:
- rename `orig_net_mode` to `net_mode`
- update commit message with a more complete explanation of changes

Changes in v5:
- some diff context change due to rebase to current net-next
---
 include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 87cf4dcac78a..7f334a32133c 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -10,6 +10,8 @@
 #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
 
 struct virtio_vsock_skb_cb {
+	struct net *net;
+	enum vsock_net_mode net_mode;
 	u32 offset;
 	bool reply;
 	bool tap_delivered;
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
+static inline enum vsock_net_mode virtio_vsock_skb_net_mode(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->net_mode;
+}
+
+static inline void virtio_vsock_skb_set_net_mode(struct sk_buff *skb,
+						      enum vsock_net_mode net_mode)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->net_mode = net_mode;
+}
+
 /* Dimension the RX SKB so that the entire thing fits exactly into
  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
  * rounding up to the next page order and also means that we

-- 
2.47.3

