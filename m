Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0476C3DCDAC
	for <virtualization@lists.linux.dev>; Mon, 27 Jul 2026 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136395; cv=none; b=YUckfnoHu4uPvLoJd888woLDmdrMOcO4zuqL/KcWnGw1sfFy9lwn1B51kTarY9wnhzqg4akF34e8jw5JkivLVBgyXOMDBmli1OsELkiqxm46Ze7QWk/LZzcaPGntSH3TFSTnq+YX8ODoQeQ5FhIeJo7e7V0/K3JSxAlinAfcCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136395; c=relaxed/simple;
	bh=QM05rrJY85zLcn+2ylIFOtVP0wce8tYDJfOmna9dsgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSo8YU4pnOy5xkTSKomR8I3UmVNyz6F4gRYxC6Wg1zLLFSjyzlFan64SYKkOgv89AKd5FEqEt6m3gcYQTDVjC89mJZBRhRplvBgC7cg3kqFGIw8tQvuRJJC6YYEHjP3n/MzJ942FqJMTsCFVcHwMzkSJ2Rz1UJZiA0Oagm8gu0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYXBMggy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYXBMggy"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1770015a91.2
        for <virtualization@lists.linux.dev>; Mon, 27 Jul 2026 00:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785136393; x=1785741193; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pHnrV3czUGHVnAIuseNPjMPOG4r9Mq38crYmq8Ga0JE=;
        b=lYXBMggyHK3xt+oyMUi8Rig1kG5IkdT24e+SW0Gni73PPx1qQMwqy89NMvTrHb7ztN
         StckRbjSoMpfuRlTD7senUiZve+9Ws+xCl73s1wOH2Nss9qYMwum56UB42OVVSyuDNSY
         N+TOQrnrrh3L1NoapZ6BUFVo1FJPEZc6xBg/IQaIBBa+t+9vqmtNxxTiSZRCECsGYlfG
         mckjvxpT7BQ1NiL+fd2KZnRkLE1ysHwW73zqO7lvLeOprdKsrhZIdjNto9EdMTOn4DVK
         aoX9RNjbma6EEGjWR1ZnqmbxH70PqyQgujtjNQCkCIdx+u5/5WLIwKATlEx0UzGLavLJ
         Zfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785136393; x=1785741193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pHnrV3czUGHVnAIuseNPjMPOG4r9Mq38crYmq8Ga0JE=;
        b=AfjXKcSrzZ9QOEapCCatU/MVfY5FWihtv2jnD3BqdW9vqyQ5ezCD8XBqNPMywyYgiC
         kC9WPtJrOTfe5sTejadA99BP9WbEx12BGNJWn38hNCg/LxaXYpGwkULuv7J0MWnKkjhS
         UNZigewC4Ovbj1YV8IUboAagHv8unbSx0dzN8JlLvCKD+agPHDML169J2pAjnuskByjl
         kVHvQiOsrzzeAKFvrdGwQFjD8+XxBQDeleet+W5t1ZxG4hQ8vLyJaPbDx2XEwZngwAeE
         0fo/eHpPYjlQatBz8fBZgwwWlp5p5nfzb5MCBYH86KxpRb0GEIE7x2glRWui0ObFHXPE
         QFLw==
X-Forwarded-Encrypted: i=1; AHgh+RrgGSbhzYAGSSFqc0pvFHdfcjNradz+3WFdUmNdwHSeZ/rKzTdwzYTPPyB/ZEN3ZPNSBslOwEeviMO88+khsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoMM9hphcv6LSG+Mz/W82rLIR9ALr4Twz8kqb6euGS7pRU7PV5
	ziaX/Zha0ExRrVHAayCjMjvKZsfIYNthaMcRQIHIeySFBqF3YDvaTMIu
X-Gm-Gg: AR+sD12Ac8Dx9sSFSEXEGb0TRtjF7q4dxtqMcBcYsN5AF7XgZU0T7sQnpGEYdEU8kmP
	Y0L5oIMRJLgQ9GLPwZficbP7mOwsosd2XCoE/DKLxPf9KPJPdAPJULX6mjKozTSdQ5M5cHpNNEs
	UaA4xYDjSwc5sJTSIIGOXTqtwvgWvZWvYyEcfm1vqQ+MWRqirEkxfVMtgfG+BXXotc7IgDvFL6F
	rkua4+/c19tmafLwrkUUke4UiR40fYXUJtirdJDyDRwtPqy+agN2EATnpWOTsuu/f2YAaC8oiAF
	I2qbIjTiKebdT9W5ObPT//BHXV8psJlBHci0oatA0NcY9Jmvxta+aFaK0D4OhbZJPbA5R1y5cyG
	Fuos3GXmaMGsIcpxWYnXimncQLg8Tvr04NUPB7SWW4gGJ6t7HgN1c3+fM3hrw4pt1NxDHkXglLD
	BtYGlZxIW98V5fDw==
X-Received: by 2002:a17:90b:4d0f:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-38f293caaddmr6801135a91.9.1785136393137;
        Mon, 27 Jul 2026 00:13:13 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.1])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-38f08968de4sm3238840a91.2.2026.07.27.00.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:13:12 -0700 (PDT)
From: phind.uet@gmail.com
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andy King <acking@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>,
	George Zhang <georgezhang@vmware.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vsock: use sock_error() to consume sk_err after a 
Date: Mon, 27 Jul 2026 15:13:02 +0800
Message-ID: <20260727071305.45826-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Syzbot report an issue which can be reproduced with these steps:
   r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
   bind(r0, {VMADDR_CID_ANY, PORT})
   connect(r0, {VMADDR_CID_LOCAL, PORT})
   listen(r0, backlog)

   r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
   connect(r1, {VMADDR_CID_LOCAL, PORT})
   connect(r0 -> self) -> -1, EPROTO
  
   listen(r0)          -> 0
   connect(r1 -> r0)   -> 0
   accept(r0)          -> -1, EPROTO

Basically, it creates a socket (r0) and triggers a self-connect after
binding it. This self-connect fails with EPROTO because it loops back to
r0 while the socket is still in the TCP_SYN_SENT state, causing it to be
incorrectly dispatched to the connecting-client path. The unexpected
packet type encountered there sets sk_err to EPROTO.

After that, it invokes a listen() call on the same socket. This listen()
call succeeds because the kernel's listening path never inspects or
clears sk_err. Then, a new socket (r1) is created as a normal client and
connects to r0. However, vsock_accept() rejects this incoming connection
because the listener's sk_err still holds the EPROTO error from the
earlier failed self-connect.

This rejection causes the child socket created for r1's connection to
never be freed on virtio or hyperv transports; only the VMCI transport
implements pending_work to revisit and clean up a rejected socket

Fix the issue by using sock_error() to read the sk_err to prevent the
rejection branch from occurring  in this scenario.

sock_error() atomically reads and clears sk_err, ensuring the error is
consumed when vsock_connect() returns and cannot affect subsequent
operations on the same socket. This matches the established pattern
used by other protocol connect() implementations in the network
stack like __inet_stream_connect(), tipc_wait_for_connect()...

Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
V2: Add reproducer steps to commit message.

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

