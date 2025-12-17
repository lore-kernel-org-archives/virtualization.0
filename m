Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18B32C0F7A
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995158; cv=none; b=apS85PqfOsRNQ7H0rzX7aG2vw2nOxUGMrhK8QzKI4/UZ5+u2njRY6T3uez8hYkEpGYwb4/ouyBiXBYyAweOMvMdcBBStWitQtb54R39vx2zJ1uXzRUECE14y9lkBP4xbT1QguI7Fnexw0BwpQ6l6Up8U/uHxjCGEk7ooTGI8Rc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995158; c=relaxed/simple;
	bh=Jmqh+IeYEuPfjt31rwC4R8TE4lp1zQaI90wvXPqlmWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UmeU/kkw3dS2LURm7mn9xs/EYjsZMOIcIQGWAUnaqqkh35J+u9RPnxgRySg6QYhSNozWsMG8OGWusid5QN8oTR+yJuI9c90NlRv1dFFAhHemMMXhLyznfRZmAIuU6f3Hl/IHKKTuKrEqrC9rmalKkBFPfe6eg2AV1InkCcqBcEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERoxnJel; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERoxnJel"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-597d57d8bb3so5188330e87.3
        for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765995150; x=1766599950; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+qEOT5fYFn8bKw8MykPWrfcTTy8Zhs7SgEc83K5GNw=;
        b=ERoxnJel29XHWo985pIy9JPp+/jWez/EP6jQ7Wh8CicHivaXOKNai1sJE+oUOEnVtl
         VgqDOGGHj4Vz46rhW7fvxtWpqO7V4KfXtIpO2hfwHG58yYDrDnFIJF/LC/fcKRxPcnBR
         +y5OCwkIq5//eEk74YAHgVZU2AlUsmeu2/K4k60dbUi//nvPyj/1tLP7kI07Quo8zgSd
         fvpQbfDn1VaI6/bKv/qonUlRzDqhDMEoM0dJCDMdyuyGsJbt3W5lfLBdUgQJcBVJMLEz
         OwnX8rHZctH7KEHoycoGM6al/0JxoxJcmNp/6HlLQZZPjL2WhZ+TOXCnfBCrXHAV3xDZ
         mOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995150; x=1766599950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+qEOT5fYFn8bKw8MykPWrfcTTy8Zhs7SgEc83K5GNw=;
        b=f/3cNJoXt2eO1hHmeO8zlLHIrfhDjoytyslZwOX2mTjPU63dIFV1N5OcHjK+XiTG49
         ixEYC8QVlfx8jHSP+6D1adifoTxFnhwOvkzMCsIYoG0XmvOzWatYucfvniCU2fJukQd4
         LanuUA1MpGX9RIcfEOOMAXLDEQ4eIR6xpZ7hZFwMip1+6yLPMBFzU6jNKNIGni65IOgb
         uKKdsErEeDs3QjZaa1aVQeWQ8jdgX1D05QgU2rKAH2k2iR7fYsEENhi6z+YJyD1+Jhgp
         LKnF/6dPGZsPa2E+rAYzkdbUM/LutXliYuBmu2SXjt8qYrjVfxvt2u3iKwwGmoezgPxM
         eldw==
X-Forwarded-Encrypted: i=1; AJvYcCUdQPL4H8uHtRKzMeBHt/iJzjZV04iP/1pvTjMZlALIRpCLsY8oNCWpWSwLaDCjGwVKWcTQrVwwLMhMZ5MnUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcxylNN2QReGCQidfIG1L3VYDYcS+qCfbyUCY72UDmuO/FnXiP
	jm/d8knuAiZrnH+h2rvT8Mfrf7rv6ixSIwMgmP8U8R3WG0E0rxLJTZ5G
X-Gm-Gg: AY/fxX5fVSQ6Fi9uxv4i75kbFaT28p3V3IFC5eD7Zf/SNE6WRqfP7+42gcISvsOR/VN
	huxAjHlyOqCi94lfLx/ua5wAAjDQucihjA1n1/AqJ0eICadSuVWR7yML0/PEq/lfmAf3MPckoAF
	Bip4kXMdq/tz13fMsoTBoiUSplA7fzJlqb1bHa4hO8kffkVRRIeUGjqEwUCBrkQ8KgGMPwtcKkI
	Z9Njh/FdjEixiN/oPBz9Cb5cVSg1PsKlUpCQs63/+b306tnTsCThSb7qrytSf666YcpMSfGDjQ6
	IF8S8ipsOqyCzHJhEvm5GeQrOBBegxrVaGU1VjPAOblsYZdLAxhhDZUq7Vs5DzkTI7zL4tlKKVW
	P8d7SejHEFeeCZAzSqVrGpGPdiXTghboBZvy74ZOQXQcp1VvZ7jUzj45nDk9pHSchL7oGJyN9AY
	37kFWnZAgQzPo=
X-Google-Smtp-Source: AGHT+IFaImgQ8mUsB8FX9vCVAZe8oyinyLF2HvL8aiazJQVjXwZSAkQ7Y1ZG0/etX5aTcNag1fMWgA==
X-Received: by 2002:a05:6512:3e0e:b0:595:840c:cdd0 with SMTP id 2adb3069b0e04-598faa14759mr5788325e87.2.1765995149770;
        Wed, 17 Dec 2025 10:12:29 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da790efsm2591419e87.102.2025.12.17.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:12:29 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v4 1/4] vsock/virtio: fix potential underflow in virtio_transport_get_credit()
Date: Wed, 17 Dec 2025 19:12:03 +0100
Message-Id: <20251217181206.3681159-2-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217181206.3681159-1-mlbnkm1@gmail.com>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The credit calculation in virtio_transport_get_credit() uses unsigned
arithmetic:

  ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);

If the peer shrinks its advertised buffer (peer_buf_alloc) while bytes
are in flight, the subtraction can underflow and produce a large
positive value, potentially allowing more data to be queued than the
peer can handle.

Use s64 arithmetic for the subtraction and clamp negative results to
zero, matching the approach already used in virtio_transport_has_space().

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..d692b227912d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -494,14 +494,25 @@ EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 {
 	u32 ret;
+	u32 inflight;
+	s64 bytes;
 
 	if (!credit)
 		return 0;
 
 	spin_lock_bh(&vvs->tx_lock);
-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
-	if (ret > credit)
-		ret = credit;
+
+	/*
+	 * Compute available space using s64 to avoid underflow if
+	 * peer_buf_alloc < inflight bytes (can happen if peer shrinks
+	 * its advertised buffer while data is in flight).
+	 */
+	inflight = vvs->tx_cnt - vvs->peer_fwd_cnt;
+	bytes = (s64)vvs->peer_buf_alloc - inflight;
+	if (bytes < 0)
+		bytes = 0;
+
+	ret = (bytes > credit) ? credit : (u32)bytes;
 	vvs->tx_cnt += ret;
 	vvs->bytes_unsent += ret;
 	spin_unlock_bh(&vvs->tx_lock);
-- 
2.34.1

