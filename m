Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437F2E7635
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642309; cv=none; b=on5oShzj9maxbK7uOoHyzoUuijJDtSGKUXS1FVFAxXj4XV6s37GCftOoYN3K1f8/IWKzK1JXMIMRO9PfbxhUIT9v+qDasmry7Y8QYHj1GrB3t0zWjJi9tEo93xrcYc1Q/tWzoN44uistVKoT0cR9k/xwTaHYfrMvG8f9fFbGrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642309; c=relaxed/simple;
	bh=OeOX0RoRjBPyIuSi1g0jByNM0OtD/yGNyEiSTE2q4+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awzQyEBd0QmFhhnbfWpNZnvpGK4+BOEy70oyW5p3irUG6g+g0MDznVDcpjvLWD4MWVqDCozc6upRYwmukdn+piLQMhY2xIbnj346+dj0nGTE2Vn/ECFw6D2oi8TKsokVv+tndmPTvMQLOSKvzBMhSlBHxHKuFdSCl1IfRJxdiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKfWG5QO; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKfWG5QO"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e7391839cso102531a12.0
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786642308; x=1787247108; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QzQ+02ZArwstq/stXjbk7JGbozF3cjKbB/DHV6r4yWE=;
        b=NKfWG5QOiuaGF1o/oWoFlypxDnwRYYJkn1EcG58gsibXaxPHTGYmGYLNtWl/7Z+wSn
         amKTCH17ywl3HTADkhBKNZ1O7IFTucUdnj74A/QG5yNCoLAGh7w1HFIwXjpOriNLJb/v
         yLly3jNQyhPAe0npTHNJeSd9e7yg3BDsmTa6gVllIt5/qF7PaRIbsIRU2I3U2m0SM/Xz
         9+UEAWS8D6SGNpBDKyEWxdHj5EsBlGEEM2bYyJFYDDHzL2ACl+tdc7rp5jDMLtME/1a5
         OQw9f9BLG/j9kqUzMcHYmwfWaVIsFIHzAXYZTesP7IVpVetNbrEzk1FWzdCZDTO5Mg9P
         mf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642308; x=1787247108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QzQ+02ZArwstq/stXjbk7JGbozF3cjKbB/DHV6r4yWE=;
        b=YbmSIkgolu7kfW3CxdwmUzI5WmqBv0M6nQnuc6/t3bZhTExkRiwKUt5p5MUzwcJEUU
         Ar0Eh+q+DUbmGhNLOzMXAKq1or0v7dnLrNUkra8u03kC6lDiuG9jv5C54PHqHEmqRerP
         kDXPTTHYAoYwiXrdF0kJjvb/tjPtg8IwK5gblGQYM4tAZxAWysuCE73yAIrPsckrQXD8
         9kV+9XjCYSW1+5eJ0UX2bus7vO2fqJ/EJ7EYpi9ORrlIkoNKuy7vVLawi+DjOwGuZfVS
         oGPL7lAX4+8OafO/V81A8EpwPZEI/ui5X6vYDhtnMSNpqgKZIoNPXnyw4Fwjm5HCGK1K
         s7Ug==
X-Forwarded-Encrypted: i=1; AHgh+RqDBzkpW+wLQ88FYtChHmwga65g1mSiBsjaezt0xySiVDKX4vT1c++nJDqR4dTB1kzQLNYJDj+z3CtUqtLiUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGwvtiSY0pECjO5gNkt31q5pzIRa8mJQ8ADWElFi3Oivz7Ddtm
	NSSFxbD/0V4BWdG+anKA4Rtvm4mYV45EgekN3uK/iDDL8p182cmRCrnn
X-Gm-Gg: AR+sD11q91XLqS1ENxLH4b4WcjtJzNn2CxhDQYpCTt6CjMd9czz8UVohe/tL7ro3EaC
	y5XwXpND3norRked8++mmbTdsdPU/eBL2Oa6Ifl4eG0nDLmYMfZQGq7pkmdikNvFn7m3yCO0NwG
	MebDD9ptQjTBg+p5MgTfWcL/ImfzYYBjD1/VDSf3i1tUPD8lW8Nm5+bfMQq9R9UVH4dt6kTweUX
	CHIaB3L7cdt/92dLZBOT2741MB3oGnHApQz3tZ67lptHe17XuZih5CVSp1aeFWp/hLY4ztNMQYO
	GeV5ry020dIebPaB/W6czY9MHoXXLdsvRxEaFiYf1EZvPPb5ZwLLJe8mMU+wYP6Op6X8vhsWx5u
	ZYrpVhkXrMNcaQJ1YiI3iLXXGZI5nTx8RSRWBXDPhBBS09To//fvkFZr7BoJvkneu6nyz6sai6w
	VjuGCD0pcohJYE0Raj46n/ruCq+EYP/CVnAOHk9CdbOUb4LZEIvEITuFGtlpCrgw==
X-Received: by 2002:a05:6a20:da1b:b0:3c0:278c:6a31 with SMTP id adf61e73a8af0-3cc54ff0e51mr11048975637.11.1786642307657;
        Thu, 13 Aug 2026 10:31:47 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebc75d8casm10961169eec.3.2026.08.13.10.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:31:47 -0700 (PDT)
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
Subject: [PATCH v6 1/3] vsock: don't check the listener's sk_err in vsock_accept()
Date: Fri, 14 Aug 2026 01:30:18 +0800
Message-ID: <20260813173024.2362935-2-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813173024.2362935-1-phind.uet@gmail.com>
References: <20260813173024.2362935-1-phind.uet@gmail.com>
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
index 622dbd046799..3cd5c3561be3 100644
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
@@ -1906,13 +1906,9 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		}
 	}
 
-	if (listener->sk_err) {
-		err = -listener->sk_err;
-	} else if (!connected) {
+	if (!connected) {
 		err = -EAGAIN;
-	}
-
-	if (connected) {
+	} else {
 		sk_acceptq_removed(listener);
 
 		lock_sock_nested(connected, SINGLE_DEPTH_NESTING);
-- 
2.53.0

