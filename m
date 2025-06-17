Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380323B60C
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 04:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134793; cv=none; b=rdNIwaqv1QoZTptSgxMEWP06bHRX8j/QLunS60g45jGKATF0ncWK2WMW55AdtdGTX2gOPmX5JyYhd0aKINho7VvbwvmNWc5hLRPu/wqBpT8Zw8+TDi6IPpgQ2mzwUYckntpN6WzJIwZ42DGXtZSvau7fd/DGtzsz/5UoSzJuZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134793; c=relaxed/simple;
	bh=mawhiv0L3KBPhIbjNO6APLwCsPC/bD2yqJGvqU3ndG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V/y5vmNHIIIJu9KLro5PrYeyuupFUQG5OXMDW0f3STLM+oCmkDrve++k7YhNLD5UAeCsvEr4k+Q3FuElZY3jqcBhtqxa1CmRj38hoc3tr528hnFK7SMyV+281/QL4HuAnablSNn2vzKCPrloxYPHNgnFPbnjgfp54ngau9JwNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVBLaGnK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVBLaGnK"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313a001d781so4756007a91.3
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 21:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134791; x=1750739591; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nQqyuVseDJyHOiPXQ8YAL67/IptUNPpJxUJ4iDj92c=;
        b=OVBLaGnKAOHj5YDchTduJadwe9PMnHt9M4ofVCIx1a/PadRp/Zs53gB/eyzE6O8Omg
         zjVrzhsF/ITM5z8+o9ZKq3xCr4b5U4soaGjLtPuNY3ed9Wr3Z4hcONuhWuVxMAewxocR
         NlGHUAFUqhGh7ccgXdZfJZ45CuYoUMbGkz+GhUcfOupXnLidbchWxsfaLVVkfcI2mgWu
         UZGs/ia6GT7r7MJpz020DsMBSwh4jk/hKCXpcqe1O5I1UKoomvSW3dP7dzxtZVu1B/IL
         HtwW56tbBIMaREm6xUODJD2OvpEYiqH0VjiC57/BmHRRO81RZL80tkJOfKGtiCL8qJlC
         wdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134791; x=1750739591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nQqyuVseDJyHOiPXQ8YAL67/IptUNPpJxUJ4iDj92c=;
        b=NzmPbvbal/jnbu6J0jaaP7wmizUs7OWDzhKVMOSyQGXXO6FJXwGNZO/lo4Ui6GFxiU
         l3gPw5llbmXujI2TY+72ECRSHwfcrUR+oT2LrjUIpqB86UBrg8/uCYjPZO7UPnaSGu+t
         PDa9TgcG0Ll3j1eIqtOk55RJNebrIpbPy/xP4aiYJTl+x2Q13oTknFq13nbkuOgQOZiG
         ltBL6bDMP8NuyE9iqAt5WWE/drbqaKbgWWnIDdZjsJfl0HGT0JMQQksLX2n/qsRhKDQX
         Lfxl5FiTVditFtwI4M5NfGtv51PAwN2fq3L2QUcw2Kb8Urld2nlE6cgv1Ro94wWl08AF
         no3g==
X-Forwarded-Encrypted: i=1; AJvYcCW4dd59hIk6TDel80+n7cEQ75DH8YFEfCGUKEjBGpmysI4AsXPOMfC/gz8RDgs+3aCt1Sh9NQ7XDa3PLq4hMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQr8/L3NakXr9BYBjyOwqsI5ooOM1J14X/tEM7uCM0BPtGnsT+
	fmG6cFPsc90QJwembwzvQGcunBZRfARgwslj2OIe5pjXTzuURqGfKuzP
X-Gm-Gg: ASbGncveFRpsX/aJGCy0V8y0sDMuEAMxkNMfRJJ09JihrXEQIlZiMg9yKPWU1dMEwiX
	xTFqLnpKUUxEaJ5zn/sc7WngUqrIgBKyfyA3OkxGz9x7rFMo3OxfC1W8t85z2ErBGYCrtGDc4Qe
	Wvo8AojsFFDsPKY+xeRoJMMnzSTwMs+m+fVTypBBBZlDO5mLhjTx2hEoZFhMcF55nthkWrhRT7A
	tlYC7to0bYIl4d9WN46WMXne5pcdfHHmQcPtJ9DrsRQCkAm6Ek6oPS27OJ49H9mhjjgsrq9xxgz
	BFntOv6JUmLQ8FQamlC5j95ok73Xlxb7A6OCcoiT5eF9xG+QvxiYp58epVQ=
X-Google-Smtp-Source: AGHT+IGvRdb4I9HaaHhuHW8HBDY1U3GRW+PV9CJvxql3LOfHXJTee/8j/3AWnJ695agzLnIfzr0vOw==
X-Received: by 2002:a17:90b:1847:b0:313:fa28:b223 with SMTP id 98e67ed59e1d1-313fa28cebamr14341945a91.3.1750134791287;
        Mon, 16 Jun 2025 21:33:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb0484sm69909325ad.142.2025.06.16.21.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:33:10 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:33:00 -0700
Subject: [PATCH RFC net-next v4 11/11] vsock/loopback: add netns support
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-11-bdd1659c33fb@meta.com>
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

Add NS support to vsock loopback. In theory, loopback can be viewed as
a given CID, and so should collide with other vsocks when the namespaces
are in global mode, but should not collide if the namespace is in local
mode. This has not been tested yet, but will be by the next rev.

TODO: add tests for this

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/vsock_loopback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 6e78927a598e..1b2fab73e0d0 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -46,7 +46,7 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
 	return 0;
 }
 
-static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
+static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
 static bool vsock_loopback_msgzerocopy_allow(void)
 {
 	return true;
@@ -106,7 +106,7 @@ static struct virtio_transport loopback_transport = {
 	.send_pkt = vsock_loopback_send_pkt,
 };
 
-static bool vsock_loopback_seqpacket_allow(u32 remote_cid)
+static bool vsock_loopback_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 {
 	return true;
 }

-- 
2.47.1

