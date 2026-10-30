Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342683;
	b=z0m4RPjvUrjhH0xy0rtR0BBIA93F6R6etS7bbUSee/b+3Zs3kmK16c1R66e8tDzV9C0i
	 hy8sEaH2z4OnLpW38Uq4/gu1MsM8v+IHhbzK0+YlkpL+UK/FOMTZd8PdXjyyp5qi2N5cX
	 aQx7LTLxK574WsScZc6Hf3O+DDwv9boyuCWnPm75DrMqqKFC0ZX0EeF/a7idvRsECGXyb
	 /2GlKMneNdf1lMoPYMG/wipDp9joAuJFUwfes/FYkDilRQjacRkc8Yrp893Ue6OvnoSmR
	 G1GtEUOD873ALnrBaZAh3CvJ7JNP5kzJtrRKea6zYe6jGt2aLv2Yr6CegnZG96AOrqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KVgic764o0iBpmXvPU3DCQnb57odNSKZ7p6xGDlXMlc=;
	b=zGaNl50sF78jSfl3upcj71WdBiCOfK63/XbV9xOEHhKmfvsF98yTBRySVxZdxtva3g/m
	 DAcBKipNqAwvhB5f/fbQ0W0Y20o3Q2XG6A9qGN83tCg+OmZ+edw2cl469x6mFlzEwvQDA
	 uX3626bV3Tx7cmy36yNasbgXo5BeYdxgnTA5PnhZKx6Kss30bEoa6OU6UAki0aMwxw+7I
	 CPGtBUv38ndJc3uAGZkssATUNf4AOAShtxPXa0ye1YR5y2RXwmNlkDd+W+3TjyjZHDM4y
	 Zk2g7a8Numv8NMDSriNd5Jqv++Eq6AAuDkdlHPIeTtY0kpflIrlcx9/+2VJsDyDx7Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TBmnhApL;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8114606A31D
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 06:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8114606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TBmnhApL
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a594d313a3so190211b3a.1
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793342682; x=1793947482; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KVgic764o0iBpmXvPU3DCQnb57odNSKZ7p6xGDlXMlc=;
        b=TBmnhApLIHLptl8U8zhvv9fo4DT/ZR0emPw8uVOhwgcQjj6jQBPTRCQPboaf0KQ2sZ
         rxtEwDQnvnVb7nx72WqWQ4PQ2sUStoX11nQr2aAlqV6GtkOKFqh+egPSzflQrAy6vW7Z
         O20cGHBpPOkkkTOud/Mt6g3d+WXXcN9oYOOSg3MbgrAG/DNYi9Nio4elQ1pNAlpy/Oji
         yJncSMwFwxFTExm4PlOwkLI6nXxcvu+vTmbiJ7UL+230gBNruJu65tvUnc1csR+h+149
         /dYhPpFZ5edjq/pbBzYnmn9TMpkylrUIyn5pzaQKKwqJytM/6EsuQNmZbUNIhW1tJ+nQ
         KDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793342682; x=1793947482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KVgic764o0iBpmXvPU3DCQnb57odNSKZ7p6xGDlXMlc=;
        b=vHFIl/GjgUn7hEIOL7JASxHwsJFINYq9zO7j0DDKLkyA6YbFberdbUCoVhBYWOvuhM
         qzHEaHMS7Ixtht1whSrc+NjvCna0WGMAFkrrBU/1EgyBmmceeHgg5nxnwwh3hbtfjiyk
         4jiNYuSkqioq6bvTO20PdcWEkenwXNpKQ1y+kcWQO1mM5lXHbzfI508rttMNXnON0z6B
         ukRh6XqWaKcOzIXYiZMn0d6lmbE2tb4XnvzOYAZOMTIhlP92kuWkA1fCi6RytXAU99S1
         cyP22OtrxVHx564au4+kAsrq/dFoPStOT/BZi8Kd1JjMy2kqRh55ZXt0lPJfOseoCB7d
         z0dw==
X-Forwarded-Encrypted: i=1; AKwUvBw2dKvFjyoBJbjp05RC1TEeDmMurowbrIinV4kB/TNMlbPQ1Xa6U74jMoZdOyGPrHHfFFKORDgXsoYeqnS7Pg==@lists.linux.dev
X-Gm-Message-State: AFq9FYI8aQ8ckATTTAj9rqXro1xnNlTSC1KgP+rCJ//0XUG2tLk/xIYa
	4eiGrSSXDDk1kU3LN4C6LqCJoH7h116APMYRQeH57/9aqLkXvdGLHVgp
X-Gm-Gg: AYBFou03filfJ4HcX2LUt9rv/k8Wj02F4+Z5D/74o0TLHFT1hBw90IYloxLrn91BqdZ
	BKIpg9kNy5mQgdHiOF9tTEXt1hHS0jfdfSGiepwtiWv3A3B4uYRHGt94PVvjgw7tAV4PwbWnv+7
	A3biWZzH52stXxP8VMBmlVexekZA1UgW9SUbwL/r6r6o/J6yM/TA1QSQkZ2spvOxNnEVMpH5F+s
	wQmZVP6KhqXqqs7+suhrZGbPNO5w0ocMjsL66OX3rIyBW2psgXflcnMFeQEEnxpZGJqtzo4FQEw
	xigxajs3NaJFgRI6bbvoTOCa1634TkCy4JP6n7SxRddFcUIV1yim1A7tuewf9qir9VRXcPlywbY
	E/8uBN/GrRogpLrNvAZwlN/LBlxdcrM8lJz7H3OhPV9Y7hRmcHnIj3jSlt0uW0WyEesD+3q8GxY
	ykq6ASjuhWLWeBccBVkLwYXfBKJXo4errulrOd9txcOlS3/nTF2SxpuHBE3KAKFBuQVwxjhqXim
	8ImILCcjInEujJ0JMoa+jskzNZKxpW6TDdZPBJ/Yep714X/gOzWzu9fRsghb6lasHTtwK6a0T/d
	cqEVIE0qO1k+1bUaLaZHh823Tb794SGPS51P0xloUg==
X-Received: by 2002:a05:6a00:4612:b0:857:726d:2e96 with SMTP id d2e1a72fcca58-8a9bd1faff2mr1359294b3a.19.1793342682057;
        Thu, 29 Oct 2026 23:44:42 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.1])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8a9ef56b38dsm363397b3a.31.2026.10.29.23.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 23:44:41 -0700 (PDT)
From: phind.uet@gmail.com
To: Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	George Zhang <georgezhang@vmware.com>,
	Andy King <acking@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vsock: reject negative tv_usec in SO_VM_SOCKETS_CONNECT_TIMEOUT
Date: Fri, 30 Oct 2026 14:43:50 +0800
Message-ID: <20261030064428.73930-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nguyen Dinh Phi <phind.uet@gmail.com>

The timeval validation checks tv_usec < USEC_PER_SEC but not
tv_usec >= 0, so a negative tv_usec makes the timeout computation
wrap into a bogus value, later tripping "schedule_timeout: wrong
timeout value" instead of being rejected.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d0508887a2fb..1d7d53542724 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2156,7 +2156,8 @@ static int vsock_connectible_setsockopt(struct socket *sock,
 					     optname == SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD);
 		if (err)
 			break;
-		if (tv.tv_sec >= 0 && tv.tv_usec < USEC_PER_SEC &&
+		if (tv.tv_sec >= 0 && tv.tv_usec >= 0 &&
+		    tv.tv_usec < USEC_PER_SEC &&
 		    tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1)) {
 			vsk->connect_timeout = tv.tv_sec * HZ +
 				DIV_ROUND_UP((unsigned long)tv.tv_usec, (USEC_PER_SEC / HZ));
-- 
2.43.0

