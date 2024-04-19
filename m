Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D680618
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524927; cv=none; b=upjoNcNo0yxobunrrm79BLrefK5a073vK28B0BNyUxqOCwZ4GIm941hvRrIFMXg44n9S3Aonyf4i2nitR2kT2HhwlOQKXkY+IMWlmZcxMOUje4cF98DTu7z79gj4FS5cE3Mkmer/qPEST6At+qaqgC8R/m7PxVnhkDfAds0YPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524927; c=relaxed/simple;
	bh=1eVlmu4WPqTzS1vEzdsZXLCBN4erb9MBcCXhDGVcS9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W53XwZuZCDMdROgm23fs/vIMyfTb11x3EMHIjsbzJLwsUOByN8zTQ+7MGl4X1Ltts4DHS/2jEhZQ0DneqCoV9Ryw6qGriC3jpO1PZPCmCD2bt6mwbsvROJPoaNcMGIpN3xOonD6uQ4duk+KoUIzULR0VFiYIytWJCo58uxFTmaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR+twSVw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR+twSVw"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso3145759a12.3
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 04:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713524924; x=1714129724; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gztq7q+tVBfKfiFB41TR2uivJxMSmSRECNayk7q9P5o=;
        b=IR+twSVwwOoaKT3dXUSNtkys8+ToHaG6E/e3oTclzr3NsKgbM62hUmBIUEd80wI9uQ
         GZmrOQAXM+RSiQsbJzxvi2eerupCKBqwaHxQG8cPbIqOno6tcskt3SKSkV3kltRmEElH
         d+TYJlt/+GGcrYX0j2nYb+200gOUFn54y+q+Dfhol2bupGL4i2Y3Wxh+ovVu8Hf7Q3en
         Cts7aJaRaxbp4TE/4G5bI39sgHPEBtP7tb6zAvCUbbB8XYMSUjGwUzNy+uaQ+JnzzuNl
         cqJeZOrP9eyomThh28QCeGvfML2HqlZCU6P3s1oqMqSffaRY274iOKcYIAz9yY2UABvM
         M5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713524924; x=1714129724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gztq7q+tVBfKfiFB41TR2uivJxMSmSRECNayk7q9P5o=;
        b=tJOPvQkTDtpHfu4CiU9CFxF3z+XuO8UKMkXC2Czz1FbRYSM0FwU9bdNzKAFaWAJ25R
         ADwNjIEXGqzKPLva3tSBi7ucEv10jfrktaf0l3lwF4ojPVo5Z0Xfyh1yVC5YpTlbv1rG
         7zsSxoSAu6QtfeRZ9TWSaZkgiOSoLJIKdvCev880Ied5hWzYYYp4Yptu2sBe6spqtr83
         R0zp1mBIBPABgT5UmVmLBhm+8imQr91R2lQP6G8WSsN13/+a5ck2suuO0ldkebEaRo+J
         tfxDxWRZRJR2CZ6K6KYGTmLdKBGHjMj23ny7i5XzjyGFxGIuSSNGLaErgg5HR4OsDX+f
         B+Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVVvCH13U+ho11Iq3xubh0nhkTVoXg64s0Q3gvQG4+iQAtkF4+CLU2PauFFYsZSyDSK5Tr+ZPweyYLEm2LAdqJ0T3kmUew+Jy5ilegFrys=
X-Gm-Message-State: AOJu0YxHknPUCsaoHE1/f/eBSx/wuH8v2AYnZctVVFzGskrzb0s9AyFL
	JDENBa01LVCaz4XtmTGNLUpvP8n0sOE7SkkiayIaHalKdMiw/I/kiwBa5Q==
X-Google-Smtp-Source: AGHT+IFLPp89/CqqYt/oDY9TsD6MpTpW+WHomUzd8c9Q6sFQ45RxeiYZXRR2f3kaQNaQYK9HhlusCw==
X-Received: by 2002:a17:907:9624:b0:a52:2a36:38bf with SMTP id gb36-20020a170907962400b00a522a3638bfmr1634494ejc.55.1713524924521;
        Fri, 19 Apr 2024 04:08:44 -0700 (PDT)
Received: from 127.0.0.1localhost ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090655cd00b00a4739efd7cesm2082525ejp.60.2024.04.19.04.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:08:43 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	asml.silence@gmail.com,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Paul Durrant <paul@xen.org>,
	xen-devel@lists.xenproject.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH io_uring-next/net-next v2 2/4] net: add callback for setting a ubuf_info to skb
Date: Fri, 19 Apr 2024 12:08:40 +0100
Message-ID: <b7918aadffeb787c84c9e72e34c729dc04f3a45d.1713369317.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713369317.git.asml.silence@gmail.com>
References: <cover.1713369317.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment an skb can only have one ubuf_info associated with it,
which might be a performance problem for zerocopy sends in cases like
TCP via io_uring. Add a callback for assigning ubuf_info to skb, this
way we will implement smarter assignment later like linking ubuf_info
together.

Note, it's an optional callback, which should be compatible with
skb_zcopy_set(), that's because the net stack might potentially decide
to clone an skb and take another reference to ubuf_info whenever it
wishes. Also, a correct implementation should always be able to bind to
an skb without prior ubuf_info, otherwise we could end up in a situation
when the send would not be able to progress.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      | 20 ++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a44954264746..f76825e5b92a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -530,6 +530,8 @@ enum {
 struct ubuf_info_ops {
 	void (*complete)(struct sk_buff *, struct ubuf_info *,
 			 bool zerocopy_success);
+	/* has to be compatible with skb_zcopy_set() */
+	int (*link_skb)(struct sk_buff *skb, struct ubuf_info *uarg);
 };
 
 /*
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0f4cc759824b..0c8b82750000 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1824,11 +1824,18 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 	struct ubuf_info *orig_uarg = skb_zcopy(skb);
 	int err, orig_len = skb->len;
 
-	/* An skb can only point to one uarg. This edge case happens when
-	 * TCP appends to an skb, but zerocopy_realloc triggered a new alloc.
-	 */
-	if (orig_uarg && uarg != orig_uarg)
-		return -EEXIST;
+	if (uarg->ops->link_skb) {
+		err = uarg->ops->link_skb(skb, uarg);
+		if (err)
+			return err;
+	} else {
+		/* An skb can only point to one uarg. This edge case happens
+		 * when TCP appends to an skb, but zerocopy_realloc triggered
+		 * a new alloc.
+		 */
+		if (orig_uarg && uarg != orig_uarg)
+			return -EEXIST;
+	}
 
 	err = __zerocopy_sg_from_iter(msg, sk, skb, &msg->msg_iter, len);
 	if (err == -EFAULT || (err == -EMSGSIZE && skb->len == orig_len)) {
@@ -1842,7 +1849,8 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 		return err;
 	}
 
-	skb_zcopy_set(skb, uarg, NULL);
+	if (!uarg->ops->link_skb)
+		skb_zcopy_set(skb, uarg, NULL);
 	return skb->len - orig_len;
 }
 EXPORT_SYMBOL_GPL(skb_zerocopy_iter_stream);
-- 
2.44.0

