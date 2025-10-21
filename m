Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FED18BBAE
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090423; cv=none; b=shj4BZVlDOuH6+CUyPpjJ9b258JcqhzyrlZ2vk4dp7TOpNj7fD768H7XpP0IvnaXATRX8NZ0mIuJBdb8Kkkvd57roB0rTnVQmKtiKkJSDQFEf8jKHe4sRv2tbnr5plbtCa98eeh8j8cvyBOhAfA/n4tKct9ViWLPZjgl+YAQ36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090423; c=relaxed/simple;
	bh=5ZnZPrVDfdO+Z9/UM3e8BCikhyLuP+zNDA80rKqdbMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iTeOXHYanjXO+01upWypGtMtNXSz2/PMo6ZrTvJrHeI02B4aKmbAmu/EENpzrEuh7s39wmYwdkfYBUDXTEk2f9975aOCbIyEysfS7LoSI9YO7RE9qwtMFYt0Nn9TlvjjrbXjr8hkESLAPBRFir51Zh4dnL6AdVwntQptSgT67q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPJtc0oQ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPJtc0oQ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so5777149a91.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 16:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090420; x=1761695220; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0IJv9dMDzYNAhk3DeojEckJoVGEYAGQr1mrX7CZmVI=;
        b=RPJtc0oQBB7gKqvb8HO0eISBOdnRfKfHad4uD9XNBzp09evHsOVQWWs1WmoQmF8ufp
         c59pGOAw3cO/xc1Vhp1nl7VQH4Z7KEz2/aTK+MOOfEpK3JGHPvUVjcwEj4qzCCdF4vbo
         F9EtAh2MrCcbYEujOs3IQEikW62HBukPvQEfkdiRZdyxqbtu92ndUG9t2ISoRDfMiOXQ
         FNs5MjlA70GKAvpE1VCE8ebEWrSbLDvRHbuQ9lrOcsONPIzLzncTSol/RxrPQ92Seden
         QK93IJBHWMst16WJG5iaK/QRVGxYCLw4o+lzSgGnHJz4wRXC+/hM7gzrCgxa2Vk5aVyF
         RxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090420; x=1761695220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0IJv9dMDzYNAhk3DeojEckJoVGEYAGQr1mrX7CZmVI=;
        b=NO5VXmJwxeXLnd9742k5eVptvceIRgWZRzX+xfYPgiRT1jM7jH6eGAyD4X8mGHV9y7
         95Tk6JIyf2Eh+gs9Uoul2UU3xXzXBiZa1u66OBtzlWWovVUhyZM16IjPmYZ6HOSCZ26h
         QTxE+IPzBSfls2uDEdOZE9xBeUqOkO/8PpR5DNSTuhjUECyZT3jgdR8IBeKHZM+CY0He
         3Ze30ARu4B81jYx7E9RjbeaRWGcWaM3xpL3Co0AgPP4ySduQ1vpvWObxR99D1gwi1TUH
         /M97hwhoi+++SCkoWF28axjb0KsvxcdN4KSAATIAJF+xIumJHbAqUbC4lmJaRD/4o+dH
         CN7w==
X-Gm-Message-State: AOJu0Yz/TAXuSL/rh8ktbmabphzemkyaeVuueoniMhADXg0b3QtHrmFY
	4UfCcp3De+ReAYarhYZi/lvqAtvzpNv3gVec+G3K/coRuIApcRhcsMRs
X-Gm-Gg: ASbGncsF9gmbDtf3/fJTLCXqynEUix6bOQJ2eEJdKB4aqpt4FSYigWmsyRTCXbh/h9K
	YfFnojsGddhFdXKmqJ4mKwI5fl5XKBi9ApJtyJbC1D0CtV5uwWhyA5En7sH/hmvaRSTjW67lhut
	FBssGE0BORObOELqzXrzTrhrfHKXRqhA5SejA1Su/iB45B0kLoo9WMNB2pEZMoJGWfA8sYy8HN7
	oMd3gRTEcHPtNZYR1QrKrY3+QGf0ZotWj9b3g5XKwmVF30+0hAA6ajiLHiwZUf6luiqySsy9ZD9
	LG1PZ374ClPTQaOGzN3k/I5fBKpnez0uZ5+hY6vRmYrlDb2O66UrelTbQG+QAS//M6Qh1wS0seW
	EgEsS50IsQOuuSmZjCjjrPArjheMmTDua6oEmqG2t76XZsAaCdPT/HVsQrbVGCsdn6AMmoj84VO
	Ehxf1lq6qQ8oJoonleSPk=
X-Google-Smtp-Source: AGHT+IENkRWCpby5KoDuBC94CdB6Y+P0mIUVkUr8FgnjZ2JlIaa5Ku2Bjeg3lNWDeg1OBhPgmqH52g==
X-Received: by 2002:a17:90b:28c4:b0:327:c0c6:8829 with SMTP id 98e67ed59e1d1-33bcf8e4f50mr24622081a91.24.1761090420572;
        Tue, 21 Oct 2025 16:47:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76645c61sm11811785a12.3.2025.10.21.16.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:00 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:45 -0700
Subject: [PATCH net-next v7 02/26] vsock/virtio: pack struct
 virtio_vsock_skb_cb
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-2-0661b7b6f081@meta.com>
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

Reduce holes in struct virtio_vsock_skb_cb. As this struct continues to
grow, we want to keep it trimmed down so it doesn't exceed the size of
skb->cb (currently 48 bytes). Eliminating the 2 byte hole provides an
additional two bytes for new fields at the end of the structure. It does
not shrink the total size, however.

Future work could include combining fields like reply and tap_delivered
into a single bitfield, but currently doing so will not make the total
struct size smaller (although, would extend the tail-end padding area by
one byte).

Before this patch:

struct virtio_vsock_skb_cb {
	bool                       reply;                /*     0     1 */
	bool                       tap_delivered;        /*     1     1 */

	/* XXX 2 bytes hole, try to pack */

	u32                        offset;               /*     4     4 */

	/* size: 8, cachelines: 1, members: 3 */
	/* sum members: 6, holes: 1, sum holes: 2 */
	/* last cacheline: 8 bytes */
};
;

After this patch:

struct virtio_vsock_skb_cb {
	u32                        offset;               /*     0     4 */
	bool                       reply;                /*     4     1 */
	bool                       tap_delivered;        /*     5     1 */

	/* size: 8, cachelines: 1, members: 3 */
	/* padding: 2 */
	/* last cacheline: 8 bytes */
};

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/linux/virtio_vsock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0c67543a45c8..87cf4dcac78a 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -10,9 +10,9 @@
 #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
 
 struct virtio_vsock_skb_cb {
+	u32 offset;
 	bool reply;
 	bool tap_delivered;
-	u32 offset;
 };
 
 #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))

-- 
2.47.3

