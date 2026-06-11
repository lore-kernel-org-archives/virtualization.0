Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B943B776D
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162013; cv=none; b=cIjV2wGWQ2mRGFXSjaAL6ZQBh4gbbkoUvNFZsJB5i+3D/Q0098BKEg0XCXa+7/qF3jGlFJmB2LKCTi2EDatns/T0oS7QFltRaJIlJrCol9e5kOw/SbCyEhLoArBK1aH9mPYo3ZmvWpxKopcfHkRB5Ym+bGi2iliCdqY30uGEBxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162013; c=relaxed/simple;
	bh=lkne1EM6WpIPMx8e4MpL26FHJHdGGWRJ2jTLHd0ZWjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sc1aazGkeXRnm8TCwo9u0yCHeHz5ggf47l+MrslEBOZjdSw4pIFPbdaIDZKpFJX9gvI++w9AICfMx8EKmmaRR+isiHXUfhOXy581siY6fHEtTbm2w4eEPAqZp+n1kKvIZFNnVU6di9EA91392J9CVWTtdNUjjmZj4PVi+KgYjXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSSiK4R+; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSSiK4R+"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7dfe7712572so70013117b3.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 00:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781162011; x=1781766811; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHOxG2aEVrWsk+iCIk+Omdwp9IYJcGKP+/ZeDWqwKBM=;
        b=TSSiK4R+BbBIWcsomnqn6bt6fqoXAs04NECMCDRrSukG6R647+J6VpbfTU1nlRjel/
         v0RqlJVQhCyymOFbEaQOsao/AqmvvHa7+zta4SWe05jIbvLV3MsQ8mieDPBKZY7yL3M8
         KFSSgmPPo9KbltV4I4hkNLam0pOTl2LNQ6aHhnRlHFP201+ccygjZDP6LpRLhYMFEhbY
         lFBg/41syPJOI8Wwqz9Xg45QpHFZrRyCL4VZqONGnDiGkuC/fXyXKbXoBH+tGEkv/8uZ
         VzIYVSnyctLO6uiW8OpBpXIbhcaSCikI0EkNDv9hUeQ4smOI7GOpFIUiiTupENAH2u9X
         GfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781162011; x=1781766811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wHOxG2aEVrWsk+iCIk+Omdwp9IYJcGKP+/ZeDWqwKBM=;
        b=kqSjwRN4ksOthHTK/H+IBMrU2CG4OzOqHA2XeY8/uCtN+OLo1bfZd0Rds9emH61Sv1
         J+FM3JxZcgROfQgGulRG8BpoxBqLp3pt1HjqgstBgRPo0EWwMa8cjP2FnTilXthBaaBh
         7JydOlez5PZhUbc8HRib43nIXPa725eRkzaMVsi0WQYXwD66OYZ4PWz2U/uilPHkEb7J
         OxgDU44s1NGXvP/sK4fAnB6O4hWuZFQbAlzLNs6H8OBA+1J63VSA6uv2FG+BlSqVHnlc
         lyzLwAASxI39GvKZprHzeUeBw+qPx6FRIDWRwaRKOzv5OdMv6oEBSxfvUGAhjoBM7Ofd
         Uf5A==
X-Forwarded-Encrypted: i=1; AFNElJ9iXI+G4a8z6kwEst+7hulD2RWDW1rZVo9ShhZfqOf4550MZ1upAJDpTIhQ64bkmKL7leyKMVpm+mtLC8YlBg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzj7QeNfPlOCCafNEHdOgptszZIkjUcbY9Wn5y9qsITE8+uHEU0
	m7A2U1Q2K9Fe8TycHAmzmBWZ8/s7tuU3rMplLOWFVyyFLNYiTA7qy2tU
X-Gm-Gg: Acq92OFijNRgskmWGLnIpRGVi331anRRv05RjHjSlyrYIwrSaoLkQ9f2alqYlaCcBaY
	lWXTG/4QRH82xCX/5EYAOIiBuntZBWq+dI70uZ9T8YdnWeik7LL5Lh18l26DSYcW3W7sRlVS4/q
	2i4MBdNV5e71cqY3YpJhfl6FjrvlTZrZpqmhA8Mx6qkfuSR3YJxtxD+Fhr5pGlDHZlwsuyfPdNI
	UOJLRnDWDfUA7t9qcESNvLyDvEN/8KL4Rjhenz6jKBGM4OBYOGc9vOzYqCyEQqPu2Jtb5yyrfaD
	bDbPgJhulZyqEloSro5TQRKKme+66L6wkM5w1hKOxhzSxU8+Rf/PfuCoc7rvV5LV4TWsCJjHqk5
	SkFkUsKVn2lUxST3w8SHUQVOTu23BmOKUKHFpdqMAh7NIOxXwbA5C1ustPwz4G4e5unqKCz/4sU
	z0r6BNkRdEUsKAAwnhCHh3vVo77Uz86LFJP5lwIolSpLJhpx3D9Go=
X-Received: by 2002:a05:690c:6008:b0:7dd:16e2:7291 with SMTP id 00721157ae682-7f658709aeamr16983037b3.39.1781162010767;
        Thu, 11 Jun 2026 00:13:30 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f693504701sm2551487b3.15.2026.06.11.00.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:13:30 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: jasowang@redhat.com
Cc: mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 3/3] xsk: replace sk_busy_loop with sk_tx_busy_loop in __xsk_sendmsg()
Date: Thu, 11 Jun 2026 15:12:42 +0800
Message-ID: <20260611071242.2485058-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <dongml2@chinatelecom.cn>

Replace sk_busy_loop with sk_tx_busy_loop to support tx napi in
__xsk_sendmsg().

Fixes: a0731952d9cd ("xsk: Add busy-poll support for {recv,send}msg()")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5e5786cd9af5..2bf9a7313ac4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1158,7 +1158,7 @@ static int __xsk_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len
 		return -ENOBUFS;
 
 	if (sk_can_busy_loop(sk))
-		sk_busy_loop(sk, 1); /* only support non-blocking sockets */
+		sk_tx_busy_loop(sk, 1); /* only support non-blocking sockets */
 
 	if (xs->zc && xsk_no_wakeup(sk))
 		return 0;
-- 
2.54.0

