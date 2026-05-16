Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129832D0C8F
	for <virtualization@lists.linux.dev>; Sat, 16 May 2026 03:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778903282; cv=none; b=cpmNN5nmEQ4f4fwcSIesEAzM9P20aOvlQbiNSe32DJ3/7VSF5g2wmNGd5FuvcURi8CciFp9zwPCg24js/VD6eBaIq1j3id9z9Drd6oOpmdF4MXbycbiEP05TRp9+7CDB4obWiAnUAu/tUYNsiS6v7ynta81Q34FtM2pZ5q+nfGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778903282; c=relaxed/simple;
	bh=uhaYEKfy/mLSn84DajFajVY0p8xS1t4EFZa65JeZ8Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hg8glbXGZgHcbcBDm2Jt8flHdNZs06SsiFrRQmQzketgKx2oVJPpN9SRZRWAFfTRhCCAjximj4LTDAebv9IYpFedjeqr+6FItYN7tX5iafg9phFUUJOG0nYU2AmIaj8nwmztfVftjkOb3VcdPci1cYuHHxYXVqlQ3MTA3GvQpWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM/JfTj6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM/JfTj6"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-365e579731fso43106a91.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 20:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778903280; x=1779508080; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGahI1dGDETqCudvdYNhAPTVGqfoPu0gvUWu1ozEgOg=;
        b=MM/JfTj6jAJLDpc5ir1Phib389l1mwj4xTnbY1kAyicxrDhFh7VU03RABcTn4dkill
         c6FvEX6x8bKIyXpG24d7GepVr6yEtv+xO4fTUInZFo7hmi6Vpsa6VWfMx8CkMtEPo9/6
         q6ZRTDNM6Q3hhW4U/qCJJkwvlNwVEZ7QQqozWoADfTA8U0zzsuxbaxktVl7Te2A/lD0Y
         I51mVJ7IPhzsqvwSJ0547n/+NF/+WQfsTSYVl+tZAnH7POoEApqQ9yh8pI8JyFI0Bu2q
         5TllktAcgeWPlcskoRFu0XQnnpyWUuh17l6H3QLSfrXYCPRsn/7Z3cRjHYF8jb6lPxko
         n5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778903280; x=1779508080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGahI1dGDETqCudvdYNhAPTVGqfoPu0gvUWu1ozEgOg=;
        b=AMDhorIF1RRbH3HXk9F5Y7Gs0g44z/5nZO5g2MrM+PJcsvonssrtV4NQ54YGekZ9lV
         XPzbX905XfCyUxWsBDCry3IrA/tXyIgag8VZHdLrwLUG1zTaqnOjFRmkwnpgUpGz0ahC
         jNsqNlG1P5cynF+IEgIi2FGq0H7A2Uw0d0vRJVCQw1f8cywXZfbp1QvQEaMpVYnx2avU
         IKEAvdjSk1eBYcskqiUTvGNTfKFOnQ2zpEaUo+CbOFzFAxTwBzBQBgjeG7R/5L30LziC
         2MDWcfvesJYHwEqsBYgRbBqXMqD47JmHheZTZgcJ0wM4l+cYQ+n8MGPben/mY+2+vb7t
         0Ghg==
X-Forwarded-Encrypted: i=1; AFNElJ9/AJaGsbKA+UNyKQbpstH/GAYpXSufa6IumXTpkm++msRiN4je/4UyxOLBYi5VU6wTrDRQgRvBiG6bplaOGA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4b9JAlu2o17ptKPZPheXPAvdCbdu9lVuf7Nb/rDWLOM3wA8I9
	lihnZ/IN6lWQgmIDb9KcAVFvyOhG0+aHgM03Bu8KwZd8RE7+NOdHpGEg
X-Gm-Gg: Acq92OEo/yW6kt7RRV9bnC8EA98sJG6zy3v0eS6OJY3e9or6QrlDLu15hkOtX/2SjBY
	me16SWngff80dkEVHTeJCRwFV9f4HN7BNcZNWfRlh2G4MIG590r4TdfS0NvgQn5BCjandTW2cQp
	wJEIzK/+f/WaUEfaHe+njdc6fEzAs5810gIrKb1+nn2FmJ37DgmnBls9GYK4FWuUNMMD9qWkWzE
	Dks13b4qGHENoMKzuZh+B44bj+OUEpdQ/QRbBCw3FFZbpKpAq0nr5GM4tfUREfkGwFeovcmYj69
	64ahYnHEi9bBy0AqDBnI7PhUFBL9GgTBMoCtaEp8FmM0Lfsu92oMmr1QwoFjZouNLam/EeIeBcC
	Nbtij5LEnK7wvhRT4+mkbqmT3oN5gtygVNJchHOnUwL5kqpWJw385cj7DkEMTN+ff06ciDJNh9m
	GM8RySEivpMk6U8LiRry1k2YRkOMakUF4=
X-Received: by 2002:a17:90b:4a4e:b0:35d:ab8b:abe6 with SMTP id 98e67ed59e1d1-36951b846b9mr3959969a91.4.1778903280286;
        Fri, 15 May 2026 20:48:00 -0700 (PDT)
Received: from b330-MS-7D46.. ([122.192.219.205])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695124601asm4166871a91.2.2026.05.15.20.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 20:47:59 -0700 (PDT)
From: Ziyu Zhang <ziyuzhang201@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Andy King <acking@vmware.com>,
	George Zhang <georgezhang@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	gality369@gmail.com,
	zhenghaoran154@gmail.com,
	hanguidong02@gmail.com,
	zzzccc427@gmail.com,
	Ziyu Zhang <ziyuzhang201@gmail.com>
Subject: [PATCH net] vsock: keep poll shutdown state consistent
Date: Sat, 16 May 2026 11:47:45 +0800
Message-ID: <20260516034745.260442-1-ziyuzhang201@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vsock_poll() reads vsk->peer_shutdown before taking the socket
lock to set EPOLLHUP and EPOLLRDHUP, then reads it again under the
lock to report EOF readability. A shutdown packet can update
peer_shutdown while poll is waiting for the lock, so one poll invocation
can report EPOLLIN without the corresponding HUP/RDHUP bits.

Keep non-connectible sockets on a single lockless READ_ONCE()
snapshot. For connectible sockets, defer shutdown-derived poll bits
until after lock_sock() and use one READ_ONCE() snapshot for both EOF
readability and HUP/RDHUP. This preserves shutdowns that arrive before
the lock is acquired and keeps all peer-shutdown-derived bits consistent
for a poll pass.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index adcba1b7b..bed42347b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1122,6 +1122,25 @@ static int vsock_shutdown(struct socket *sock, int mode)
 	return err;
 }
 
+static __poll_t vsock_poll_shutdown(struct sock *sk, u32 peer_shutdown)
+{
+	__poll_t mask = 0;
+
+	/* INET sockets treat local write shutdown and peer write shutdown as a
+	 * case of EPOLLHUP set.
+	 */
+	if (sk->sk_shutdown == SHUTDOWN_MASK ||
+	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
+	     (peer_shutdown & SEND_SHUTDOWN)))
+		mask |= EPOLLHUP;
+
+	if (sk->sk_shutdown & RCV_SHUTDOWN ||
+	    peer_shutdown & SEND_SHUTDOWN)
+		mask |= EPOLLRDHUP;
+
+	return mask;
+}
+
 static __poll_t vsock_poll(struct file *file, struct socket *sock,
 			       poll_table *wait)
 {
@@ -1139,19 +1158,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		/* Signify that there has been an error on this socket. */
 		mask |= EPOLLERR;
 
-	/* INET sockets treat local write shutdown and peer write shutdown as a
-	 * case of EPOLLHUP set.
-	 */
-	if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
-	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
-	     (vsk->peer_shutdown & SEND_SHUTDOWN))) {
-		mask |= EPOLLHUP;
-	}
-
-	if (sk->sk_shutdown & RCV_SHUTDOWN ||
-	    vsk->peer_shutdown & SEND_SHUTDOWN) {
-		mask |= EPOLLRDHUP;
-	}
+	if (!sock_type_connectible(sk->sk_type))
+		mask |= vsock_poll_shutdown(sk,
+					    READ_ONCE(vsk->peer_shutdown));
 
 	if (sk_is_readable(sk))
 		mask |= EPOLLIN | EPOLLRDNORM;
@@ -1171,6 +1180,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 
 	} else if (sock_type_connectible(sk->sk_type)) {
 		const struct vsock_transport *transport;
+		u32 peer_shutdown;
 
 		lock_sock(sk);
 
@@ -1203,10 +1213,12 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		 * terminated should also be considered read, and we check the
 		 * shutdown flag for that.
 		 */
+		peer_shutdown = READ_ONCE(vsk->peer_shutdown);
 		if (sk->sk_shutdown & RCV_SHUTDOWN ||
-		    vsk->peer_shutdown & SEND_SHUTDOWN) {
+		    peer_shutdown & SEND_SHUTDOWN) {
 			mask |= EPOLLIN | EPOLLRDNORM;
 		}
+		mask |= vsock_poll_shutdown(sk, peer_shutdown);
 
 		/* Connected sockets that can produce data can be written. */
 		if (transport && sk->sk_state == TCP_ESTABLISHED) {
-- 
2.43.0

