Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565ED2D6E6C
	for <virtualization@lists.linux.dev>; Sun, 19 Jul 2026 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784498549; cv=none; b=QIfd6cnS2yMjoyC24B0YGI+f0Z4PQgCnE0IlAlt15DiTv7cAosHqqJD3FzHReMZJNMmhRG2IcOdPnHQVBA+i53+UrGMuZfSqNw8koQfLLRvwTAlz8Lbtr3CiKUKfvRK75688tNrzegAezsXk7qiOqBKGcqHPpWXsHgVyeS2RPX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784498549; c=relaxed/simple;
	bh=0w+3lDYbj5Tk1FVUEhvs9fuaoqfoYazTfOE0hL658ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5b/+ClSeanxvZeXsQbnCkx6gRq2UzKmyMGxH52qIgjsxGO91y5LaJSWwv2Nps3uS1wqub73MLKXIqKhSf81aaM4WwRXvrVmvG+yzNqZ0qR57q4/zwj1Gt3qcQUwCYWwfoWWyZnej8r2LUX8nN8Qtb1ohPBeqL6ZtYD1d60omnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ganoutq/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ganoutq/"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso6165685a12.1
        for <virtualization@lists.linux.dev>; Sun, 19 Jul 2026 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784498548; x=1785103348; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZfvhkooxWj3CsP9ZhhIe5Neuekb+2Nv4jVoCxZTmOkA=;
        b=ganoutq/iQByGeFw3HlIm89B1AhGW9KK02kMLlZE8IPLRwB5mRnUW3C1FBQOdOgd7x
         kFKJIsQGB+BlS6lggkAn5fIk4zDKpDtUpM+nB9ycwEGZcI8pcasFindYEdd8qIiYh+VI
         zRrJyFR3sWF0AgrMDAlujK6iKIy8wu/LUVVQIliryer6aaOfv7Lf1cub+OxSRNXURwu6
         rygrDINom5Z8NVQ9PPbcEjJZkcnfn1Gl8KZjn/sKsAw3qw1HGPger/volurTGFRKaDR2
         jDf8WvaDbNICC75qHAeCR5hcUDMuZ1xG57Y+Amg/YlUCbqqsWTyCdxAciKphxIh0O5OL
         TxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784498548; x=1785103348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZfvhkooxWj3CsP9ZhhIe5Neuekb+2Nv4jVoCxZTmOkA=;
        b=IP7oyZoaY44UeN+4MkDjfeROklp6ZreDzFiu7+uqHlp3GFccjgXq+8pcXqzqJdtaFE
         sAaTdUx91/KZNUyaaSniAj0J0oCk+iAIZtVpEXJfdgXaAbb2JjV/f3oYKVePqUtcZDsM
         4z4RxcFlPYLpBTpzKccdszECGufizL6EC+E3bum0zT5iYeWksNfx78Z4pvvDGQ+X4kpJ
         SS1c8ij33E2aHiuI7d6zbS31lRW9a6pJ5ytNhab+vnVvpDJ2waX/kSqAKLP49KMNnsMJ
         YZxjm6M7VKEYKDTBuhDbZKt3nByz5fJWWlEOZmx6ESijfMsNv/A5qZUErzdoiHBt9BwX
         eo3g==
X-Forwarded-Encrypted: i=1; AHgh+RpUBae91AxCJsHHD7qs+jLa0fCb43CoiWR4NHiGK1s/NWCJgZo0miSyfAzbbcqi5LeVE5TgySqq6qcW89HkgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyN3QJhILM2FxpPeWcm18W8dxPcqiBWnESzoB1X+kVJl22nF4Uc
	4yxsP5KGI74gu6/FCF3xJ87ifWVzgJLDAUOoAbEzW55zTIBOGTVNApYr
X-Gm-Gg: AfdE7cmQSE2nMnMrqNM64xeBTN8p1JsRAcYlzfnwPJ4iASqeYUB1usjROW3G5qq8qC2
	RjJifAbieVtHvd5cXjgBkKt9Ox20qIs2TeibZTVNhckvIxhFqOQQjJ30YIVRm6lR2lvpqmYuEqP
	IZqeYoMCvgkieA7Ww8DcTDbKqbiIIoNCAc3TrDp+gyo1fsd4rAFxzjp8+XMa5bVPj0cG/9xfHNo
	uzdvgbbcEgeikQXWLzTiYdyDIA0sY2wY2IwcKA8fDqH7jzd3G5L1BScYE0a5agrU/3wrnmwsPGo
	6cLr5lCpkKeaPHIIGRw2HJp7MSw9Yh5AgVHCEYwqB+mU2tZZM9Gb8/i/4LeyoPUoYoYNdAxa6Bd
	jzyIfL6vp/2t6UahFxTowPevs+jC8PR6+MbGTwep5vPiMh0nvktZbrCvmqpv59dr90lB/QHRiuO
	9wWtY=
X-Received: by 2002:a05:6a21:a382:b0:3bf:96c6:78a9 with SMTP id adf61e73a8af0-3c3ad665b3fmr11748627637.2.1784498547566;
        Sun, 19 Jul 2026 15:02:27 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de21asm29507484eec.23.2026.07.19.15.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 15:02:27 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vsock: use sock_error() to consume sk_err after connect timeout
Date: Mon, 20 Jul 2026 05:57:47 +0800
Message-ID: <20260719220103.684489-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After vsock_connect() exits the wait loop due to sk->sk_err being
set, the error was read but not cleared. This left sk->sk_err set
for subsequent operations.
Switch to sock_error() which atomically reads and clears sk->sk_err,
so the error is consumed when returned.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
---
 net/vmw_vsock/af_vsock.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd046799..43eddc33ed12 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1847,14 +1847,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 	}
 
-	if (sk->sk_err) {
-		err = -sk->sk_err;
+	err = sock_error(sk);
+	if (err) {
 		sk->sk_state = TCP_CLOSE;
 		sock->state = SS_UNCONNECTED;
-	} else {
-		err = 0;
 	}
-
 out_wait:
 	finish_wait(sk_sleep(sk), &wait);
 out:
-- 
2.53.0

