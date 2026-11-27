Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795756767;
	b=S+Y6d9O1rLvothtfkXchazBD7jN9xVlq2uLClr2IerfzU2D+sCSOH8T2z8VKh5jNdJPz
	 8NNvSXsuWut/mISnT9ruj/T0Qtz2SCuGDXhFdd+oK/d0xIz1ZrNjCMhJg6FwaoT1LugHD
	 85ts4Yv37fhMOlX/bZEaXYL9GN1CJtVLrK5SzHF2SNxBnljLaSAj/dzex8hLLFsRtlKkD
	 tNezBJpM41ZvUkkY2ELJdYm1JrsSvka4UjURzUXzompp/UYVlIRLl9HRxhWznChw84jrL
	 FUBXyvBOo42By9le3fzAlDudSDdm855y7QQkAhUwcv64chlBQEtz3vcleZI9zVGi9Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795756767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Xq34tF7uqfa/4VrlGe9UW8XH7BMcoCHDPzLg9RgEtLg=;
	b=4xWOfYIawJIjmFcVu5l2cOPJc1rENBH4MW150XY/XgZ2QmlZiOYZg8pnqQWCVhbslmZC
	 q8B1Lo+d/0ZSgpUoWEyGeufXIo4rFjzITk+C6JwUSPhh6qNkTbN6pIL+iSW1m81kwdoLg
	 HIMpJFIdHZ/R0Z0ZoGbHFFcjAJFxE9GDDSzMkHLyVmQ+dbc6Z3Sh0AOPWspl4ojW4gOZq
	 YSKv0BPwU9HVPoCpn9cqY+uGzlYFwpiO8xcxCQoMc8iTU4aQAUmyaTa5HFKCk5QqReAjg
	 PrhBlv8sjp/ioixxmC6dWXYXEWUFXwgucdmMNprEt+gGU8JZ2cwuc12cZmxdPIPGIiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=ijpXej9w;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C860606A31E
	for <virtualization@lists.linux.dev>; Fri, 27 Nov 2026 05:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C860606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=ijpXej9w
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-386bd881d39so8331605eec.1
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 21:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1795756766; x=1796361566; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xq34tF7uqfa/4VrlGe9UW8XH7BMcoCHDPzLg9RgEtLg=;
        b=ijpXej9wttosaGNaw0QJkE8GBHc32BohueaB6ivqzC8Q4ZL9C5jMVCsweC+/LkRsoL
         7DnhCIVWlKK8VXEIEi+mbHCijEOIZLMqGuFJJ0oGfIA3FJ5rciORqjt0rlb7tUJCZHFT
         GmtyeNHruoVLdHdFXLXm+2UNqK7oh6TqRjpL2CqYADshRrf/aMh4vf0AlmEWP5pOu3JC
         qnPv4tv9D0bQtpFVouBbCrCCEDFvlt8Al7qD3UhtoFp8eHzW+YCK+cpnct8740Fu2feQ
         6FXLScPKuvSjb1Vc4oZeMiS6C0e4c0Qm5wnHLl4wNlBpJkm2jtbfYD9d0/XDuS7sNrCB
         QrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795756766; x=1796361566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xq34tF7uqfa/4VrlGe9UW8XH7BMcoCHDPzLg9RgEtLg=;
        b=UhhT7l9RwhfqiZqr7GUlVGL1VFioCxitBFSbM6Co6VPvnbRMGZYuir9cRrCz0L54bT
         J0YIJkXNkx5+VWNyk42W10/JR6TqRQeEXkI3+WoS84l+oC7/6XT78NHCOQG/VzCLSu9Q
         7HhLjLm6jAU7Z0AXF5mUPjdvzWcCPfxZ4YTXzgBtEzhpI2qGtYEMU9+WfFtci4aimgZ+
         DOqbywPv2l0HaPI1qy1H8GTqFR1XVbEJx/oSqlOeRmc4iq/0FbhgQxgO7vjfl9V/4KWC
         dy65zM3/eyw6+TTKTbBJNuRSUTNDXhqkaGSq4kyWk2ivIw2O2aE98ElhqPPAtGvVrQIe
         wB2w==
X-Gm-Message-State: APuU4Z9nnzOU+Kloq20JLkkeu23ZDqy+mIRdhMMNyX9hDtDG9wXIZkmq
	F/4LEpBgAH53bYHq/9dHU3l7d5TO6iMCyJrBiEuGk2eDVzHtl5V3xbm1KVbTpFmAxvPvUJjEFcN
	qAz2ZGA==
X-Gm-Gg: AZFdTZfKtfr/AsJCCM5SF3TSHrZBwu/vyHWCV6IP0RQqYLSXS+z0w4JSVOgbHrMFwA1
	vsxXujHWBnqLQ96YTVURYPf6ToylseKMbNGDVGO3a/gJncMDa5EfLUhL4eCJsh5GPqVwgDYJsMy
	VXOTRS+aSJoXaWw6RH+W1zBrQNqxwUZ5G177UDzx5jhfj4BUk9Hy7l8/Zw4lRWsTKkMEOfFUI34
	faaKBo055jUHo2kOCiWdit/waNgV7fCtHsHG4VtXHBoI7UIbSO85lqZoK1XlTHqeMW4aGAm4c7t
	4hhlxFMy2kwUe4ulIlHrYQSaRAovrmst7eK2VX9jO7X/W408/7hCcxXXekGZ0Ogs6CKP6BST8ox
	xFo4uSPUO53klWarBaFsN0QjHQbHqAWBXWCiyVV6IcVnL6Pw48tzhg6YkxuI/MjSyP5j8uQZnbZ
	WgYtuTE03YFr9PwTWYfkB7HIuvrdsL2P/qTz0m+/DtMFER0KcUphAFv5a5ozfZaKfbLJ39uinse
	OWNzncUJusNdgyRE1iMIULcQRPPkPvf92sEtFDzOnsPffV9Y175h+kchVnfzLcDwWBweYgW0bE9
	AEPiRi6IGnIM1+W/N1ReLpDS7Hs4FTAFqTneeg4=
X-Received: by 2002:a05:7300:4721:b0:386:da66:671f with SMTP id 5a478bee46e88-386da66762cmr4664632eec.28.1795756765613;
        Thu, 26 Nov 2026 21:19:25 -0800 (PST)
Received: from enjou-Legion-Y7000P-2019 ([174.136.206.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm82950093eec.10.2026.11.26.21.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:19:25 -0800 (PST)
From: Ren Wei <weir@nebusec.ai>
To: virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@meta.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	horms@kernel.org,
	arseny.krasnov@kaspersky.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/2] vsock: preserve receive timeout across partial reads
Date: Fri, 27 Nov 2026 13:19:13 +0800
Message-ID: <e8c2a7015710acbd5fb1832fd03659414465a399.1795587333.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795587333.git.caoruide123@gmail.com>
References: <cover.1795587333.git.caoruide123@gmail.com>
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

From: Ruide Cao <caoruide123@gmail.com>

__vsock_stream_recvmsg() passes its receive timeout by value to
vsock_connectible_wait_data(). schedule_timeout() therefore updates only
the helper's local copy. After a partial dequeue, the stream receive loop
calls the helper again with the original timeout, allowing a peer to
restart SO_RCVTIMEO with periodic short writes.

This was found with LLM assistance on the Vega platform and reproduced
with the platform PoC in QEMU as an unprivileged user on
VMADDR_CID_LOCAL. recv(MSG_WAITALL, 6) with SO_RCVTIMEO=1s returned 6
bytes after ~4.8s while the peer sent one byte every 0.8s:

    client: recv(MSG_WAITALL, 6) returned 6 after 4.816 s (timeout=1 s)
    RESULT: bug observed. Finite SO_RCVTIMEO did not cap total wait time.

Pass the timeout by reference so the remaining time is retained across
partial reads. This makes the receive wait budget cumulative without
changing the existing blocking behavior. The seqpacket call site is
updated the same way; it only waits once, so the change is mechanical.

Fixes: b3f7fd54881b ("af_vsock: separate wait data loop")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/vmw_vsock/af_vsock.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 1d7d53542724..99542ac080b4 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2406,7 +2406,7 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
 
 static int vsock_connectible_wait_data(struct sock *sk,
 				       struct wait_queue_entry *wait,
-				       long timeout,
+				       long *timeout,
 				       struct vsock_transport_recv_notify_data *recv_data,
 				       size_t target)
 {
@@ -2432,7 +2432,7 @@ static int vsock_connectible_wait_data(struct sock *sk,
 		}
 
 		/* Don't wait for non-blocking sockets. */
-		if (timeout == 0) {
+		if (*timeout == 0) {
 			err = -EAGAIN;
 			break;
 		}
@@ -2444,13 +2444,13 @@ static int vsock_connectible_wait_data(struct sock *sk,
 		}
 
 		release_sock(sk);
-		timeout = schedule_timeout(timeout);
+		*timeout = schedule_timeout(*timeout);
 		lock_sock(sk);
 
 		if (signal_pending(current)) {
-			err = sock_intr_errno(timeout);
+			err = sock_intr_errno(*timeout);
 			break;
-		} else if (timeout == 0) {
+		} else if (*timeout == 0) {
 			err = -EAGAIN;
 			break;
 		}
@@ -2509,7 +2509,7 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
 	while (1) {
 		ssize_t read;
 
-		err = vsock_connectible_wait_data(sk, &wait, timeout,
+		err = vsock_connectible_wait_data(sk, &wait, &timeout,
 						  &recv_data, target);
 		if (err <= 0)
 			break;
@@ -2565,7 +2565,7 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
 
 	timeout = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 
-	err = vsock_connectible_wait_data(sk, &wait, timeout, NULL, 0);
+	err = vsock_connectible_wait_data(sk, &wait, &timeout, NULL, 0);
 	if (err <= 0)
 		goto out;
 
-- 
2.47.3

