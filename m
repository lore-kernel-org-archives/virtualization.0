Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563FE401484
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381849; cv=none; b=pGTV5XtGxvhJdk26UJ1556YRXfaN5d0wKR1qXgngVGftc6Eq4MQSKn0PXNwsMb6eYqlqbY6jjrO/JntDjilhytiYBRUT6j2T1Xpx/jIMZAIaR8uctMQQw8Q00U+cfABhoPyV2nSLW1rwxgFl/vgkiMotEoFQfChtR7Vyr9a1YCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381849; c=relaxed/simple;
	bh=j+tqaF49vVrcAgCqivH0Q0gH+G4z0Uw2YSxLSLYQ6dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXqsF1lAH5cn0zj80rkCV1B+zuRZcqigqfJ1arDo9HD+2Lule6ZEKnVK/5g3l3sDVbot24cUWir86AwLtQpRqGbDLUS11v3VukQTLlyVpLkbo3YQ5NcTKnKPCLel59WR0+TVOqabCAt5xnwg4jjzIPFTMjjwPrY75NfGqjOUP58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8GElTyU; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8GElTyU"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1230773a12.3
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786381847; x=1786986647; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o17hX9psIIM1rya7TZerzwkpY1R4GKMlzn2vF2QyCKI=;
        b=X8GElTyUmz50xAyUrhBZ8X5D54Oi9ih3OElgt5A65e81uV2qaSVxwOssntnV0rkkiJ
         7qvqsSfAK582YaO3w1ydCwkyZZK/oCSZwb+Si/z4FIOb5JqfDo6tI6lSN0b56ManQedy
         rZArZVDRXHbU0zV+ImokZi0NY5QrPw/oivpHJjXg0WIcQF4hak+DDs2sTVBrlo9e5M+S
         jwTVR/s2Vkuuup1/icfhZsk69rCsNTQfvDu7MnHbA9RgxAPqomlz6tenbyKlt5oiX9af
         Z10jT22ulGRYZQALILaRquQXkcUM9sE5JS1fEYOVDPUDEF4jU2ZjHpbKJFhPhfboSqoB
         PVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381847; x=1786986647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o17hX9psIIM1rya7TZerzwkpY1R4GKMlzn2vF2QyCKI=;
        b=HC6cFr5tL0I+aqvKLSkF/B+kovIj8xHK8QJ/42pVj6AMMZydiA74z/VwCC2wPWWXQV
         qSV1GIRpJdeo6pjsXJWik4uP82vJ5OLffu/adYOAADa9wO+MGyD0cvYfyEi9JSuIr4eE
         gLyHmwOoyPYEj9RmMOuqzI1IIRWR+MrLzj0pt0uv92hXrSejbejD8VbTF4XYQtsH25Pd
         y2TSPDVCAij6ICGBPzKzj6JI3uEkTx4iURr+2vqLgz0EyF9zRSPDmt4n2CnkN6WGnex1
         4iA0fe2ebgtx2iwkDQR8W96k6pCUtul9bXxirQsODOw38ZNC32ehu8WI3XA5dD0ORJmC
         LeXw==
X-Forwarded-Encrypted: i=1; AHgh+RpNTYKw3cXU3qBsQkDr4++bWVm04/+478rwL9Nb2a74GEFJ4f0YA3Idsz22J0BXv7ZRhSJ9KO8Cxt+mpcW6qQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4x3FkbQJ2DKhnxrthkMLppws2Fdoy4qOYgkx7b/r3kEOYFKhZ
	/LXKDWYPf0oO84WGzoBuleCg9aM79n5AHQ06e9S9328GT2q/2KO9VHRm
X-Gm-Gg: AR+sD10GFEe39BH4YMJrpbHw8aetAMbWizJELfk1enGOBcAqHYuIDQizPqXyKUA0hgx
	ikX7Kln4KLlYlnYldvR1CuuwB4WQ0c+joajzd48zl9Ti1WaGSFE83RfFYJ+JbnXWrGQQYqrkOJG
	0vXPpDDHo+TWNJQQaDK3hlukkwbK+sHunmA/6cUcMxCni1QEQThXoPn6SxK+dZ4EBvi0Z2NPFO9
	+ck5vehcBFLIBF2NnpdRsYwrLBk4VcDbKe+kVK9G7ajUEvRJvLheqBNvwROqLo/8ug39AESmC1P
	QI4mKdpF5MGsukcG4RsSbeKfee5r3KuVFNC4cECA8NN7DKXxJ0YbDAg8qiP6AjzRU9deF9Qzqol
	YS77RyxsdK+mr9zglc2IS5vWKKWNM3sN/gDyIP0NqDlFdI88nWyn03r1keLAkGoeAepHOSKaCCC
	OaBDC/ZciT3cGIeX+kyK70H9HXXGe1R5nfcZTKtvD3yzQMo4Oej2T/9uAziIwmOA==
X-Received: by 2002:a05:6a20:db92:b0:3c4:147e:98f1 with SMTP id adf61e73a8af0-3cbadcfd00emr37452298637.31.1786381847406;
        Mon, 10 Aug 2026 10:10:47 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199cf49sm37194663c88.3.2026.08.10.10.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:10:46 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	George Zhang <georgezhang@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>,
	Andy King <acking@vmware.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
	Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] vsock: don't check the listener's sk_err in vsock_accept()
Date: Tue, 11 Aug 2026 01:09:30 +0800
Message-ID: <20260810170935.2242314-2-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810170935.2242314-1-phind.uet@gmail.com>
References: <20260810170935.2242314-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported an issue which can be reproduced with these steps:
	r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
	bind(r0, {VMADDR_CID_ANY, PORT})
	connect(r0, {VMADDR_CID_LOCAL, PORT}) -> -1, EPROTO (self-connect)
	listen(r0, backlog)                   -> 0
	r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
	connect(r1, {VMADDR_CID_LOCAL, PORT}) -> 0
	accept(r0)                            -> -1, EPROTO (stale sk_err)

Basically, it creates a socket (r0) and triggers a self-connect after
binding it. This self-connect fails with EPROTO because it loops back
to r0 while the socket is still in the TCP_SYN_SENT state, causing it
to be incorrectly dispatched to the connecting-client path. The
unexpected packet type encountered there sets sk_err to EPROTO.

After that, it invokes a listen() call on the same socket. This
listen() call succeeds because the kernel's listening path never
inspects or clears sk_err. Then, a new socket (r1) is created as a
normal client and connects to r0. However, vsock_accept() rejects this
incoming connection because the listener's sk_err still holds the
EPROTO error from the earlier failed self-connect.

This rejection causes the child socket created for r1's connection to
never be freed on virtio or hyperv transports; only the VMCI transport
implements pending_work to revisit and clean up a rejected socket.

For a non-blocking connect(), vsock_connect() may return -EINPROGRESS
immediately, and vsock_connect_timeout() can later set sk->sk_err
asynchronously.

Since no vsock transport ever sets sk_err on a socket while it is in
TCP_LISTEN state, checking it in vsock_accept() serves no purpose and
only carries forward errors left behind by earlier, unrelated
connection attempts on the same socket. Remove the checks so accept()
no longer rejects valid incoming connections because of a stale
error, which also avoids the resource leak described above.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
Suggested-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd046799..ff507761f472 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1893,7 +1893,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
 
 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
-	       listener->sk_err == 0 && timeout != 0) {
+		timeout != 0) {
 		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 		release_sock(listener);
 		timeout = schedule_timeout(timeout);
@@ -1906,12 +1906,6 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		}
 	}
 
-	if (listener->sk_err) {
-		err = -listener->sk_err;
-	} else if (!connected) {
-		err = -EAGAIN;
-	}
-
 	if (connected) {
 		sk_acceptq_removed(listener);
 
@@ -1941,6 +1935,8 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 
 		release_sock(connected);
 		sock_put(connected);
+	} else {
+		err = -EAGAIN;
 	}
 
 out:
-- 
2.53.0

