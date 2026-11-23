Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450858;
	b=eRM5cg4Adv5lLGwAFMBmkrZ7+H+kom5BlfBtMz/oN6nLZr2z6Tu7HQTj/4fl9EGs70LL
	 6aohd4Jp4WUZa486FU1WwTgShH/ROsORnR1mLU/L0XZIBbgBBYoZ4c1sIS2UDi0EFTTC1
	 +QfpwztBeIG4mrw7DPLCXHqGniMfLoOqhPiGfS0w6QIDdYtUn8aX1ZoQt2H6W0RkB41LY
	 ckI/NAfevOdE2P7OXElz59ba9gpSDQeP0JpA2JWT6yJoflLOoSQbAcApxBJnrQLiz+QCr
	 HsjT8Jc3J4MIF0csmGyZc+QC1638WyFdWpomn7OoridU/F7MevXW0cTfmNct/RwHFfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450858;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=OMtq5aBML9D8zyZzLVDbeex6HGKBk1QCt6vR9V0tuYU=;
	b=r6umGezKFUTyq+XmcrWHeTxdINLjW3ZuZBYUQ3AlqgU6DlsD7ePV3dhyzPju6rL10x3V
	 pPxrEWpuAQfixC1p7hUXTRUyS7u0STLCJN+Yd08vPhykHejx4zHFm0LczROeX0W7BNrbS
	 Tm2puXDdM2xQwh7nmUl2dsDdFSyAfFQvmR+MC3nA/bEEUJjMlLlyR8ca96pXStV9A0frz
	 9y3NXhnw4oVJ21HTIxT2Kw/Bn+bjImjGsfXxNk47ZrLZcqEmAh2NgK+bFpv0x+/eXaU1n
	 Iw1zKFnzrjCx4U4OUec6B7vnpmF7n7aRKQp20a17HHakCnivfUU1pTkUoNk5u8kiWuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Yf48H/7w";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4E0606A32C
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 16:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A4E0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yf48H/7w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795450856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMtq5aBML9D8zyZzLVDbeex6HGKBk1QCt6vR9V0tuYU=;
	b=Yf48H/7w/9FB+A/8Me5stvnMKxqMCtMCAx1qe18pen+y8aOXIdb91/iK7dr7owJc/Lm62m
	HdbUgCccy8sUq+aQEbaHD5mGo4eShDRnkwlkCr04tOczE5bqi23jSoxJqISgRWd3uhluO5
	3oOrK6lempKzvyHKPSBsXaOnE9GBvXA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-c-Sdy-qwOs-230ZdogZT6A-1; Mon, 23 Nov 2026 16:20:51 +0000
X-MC-Unique: c-Sdy-qwOs-230ZdogZT6A-1
X-Mimecast-MFC-AGG-ID: c-Sdy-qwOs-230ZdogZT6A_1795450851
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4ba078f26f4so24689005e9.2
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 08:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450851; x=1796055651;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OMtq5aBML9D8zyZzLVDbeex6HGKBk1QCt6vR9V0tuYU=;
        b=zr/Z8L/w9M2+o1p0FuNPVgBv9cDSjZVyVCXxZQzSCmo8IYHTsR0xBZVq5+H0shsRVb
         UT72xf5vydqTSFX5o8zCwtkuwz8X1Czj8C2eeG04epyFm6W6TIM/KlvloAbTEFC9H8U6
         MCPvAyxhWxUglHQjqNXeow3RFHHmFoTWlnR01ndnsdID+rPDJZycn+FJybOlYjKlubLp
         Z5z8Ud25PuOmhdvlrWor3wyfz/XPgJgxpso7lyZO7rnayZRnxtaIhgAwX7FD0pGadHPT
         3y+eGjNIDzgx+O0GtCBDTrw0v3qelOM1PAmT4e505iBPbKvFp21k7Qy8jS4W6B+KG4mc
         KsZA==
X-Forwarded-Encrypted: i=1; AL+hErEa8gwBM+/zx7OjgWRWl+USwmYaCyGV5y0g0XXShcNX9W2uLdrYEsl56oKqLPHpjprPXI0VNyz+KL550y9o0g==@lists.linux.dev
X-Gm-Message-State: APuU4Z9W9KqhsT2yqzDjXuD9g4eBQGn6ownC9ReaXEOcDyZ9no2T/e8F
	3DjHYisBaPQzkGXa4LdLKc4nE7j6gzmvansDY/z1M5Cq9fWBkAs8cZOEZNUzl5NjF+wbXt2Ih+8
	49y1O0ITbUUOm/gOj6SjBK0vZg0r0QC6Rqx1pQ9Il6bufMLUM29mCMVjftQyYjXcmYakr
X-Gm-Gg: AZFdTZeT4a3x9N0vJ8PiVRBgWOkkdtz86u+/e4SCbXPhNcUbkD+yTqmpS4svUUoyL7W
	7R+gGVlTs3FSNL1gtHX1rRkgI152BLDpe3mf4+1GgmzlYUCmvKCZa1qv323jgvgMn3dtfSu4ohZ
	Z4NT2ExA7IAnDO6NGyXbihI1ZEuFfjKYetlWZ0UoQmPYEWizgVfOhCOxYyyWV3ItQOJWTvGogIi
	cm1vipMpoz0AGWuQoWKykx28aDa6k6w112nHxLPiD77Y6Su7/woreu71xWpDsmJbC0G0I0fAseK
	Wai35gPWmWlFgq+PvpM1BUcqaFrxMo5wCM+zz9Iy+9C5au7e75nt4fK5IzRxEG4HPlHzcADrMlQ
	tIcpGwb/or8y43NA7QJFIgcBjHHRXVRwL/9Ib0KBMBK95LpGvg4iYeg==
X-Received: by 2002:a05:600c:3b8a:b0:4bb:76d9:f81a with SMTP id 5b1f17b1804b1-4bb88824fc8mr265197995e9.34.1795450850746;
        Mon, 23 Nov 2026 08:20:50 -0800 (PST)
X-Received: by 2002:a05:600c:3b8a:b0:4bb:76d9:f81a with SMTP id 5b1f17b1804b1-4bb88824fc8mr265197125e9.34.1795450850173;
        Mon, 23 Nov 2026 08:20:50 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm320400955e9.8.2026.11.23.08.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:20:49 -0800 (PST)
Date: Mon, 23 Nov 2026 17:20:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v6 2/2] vsock/bpf: release sock lock while waiting
 for data in recvmsg
Message-ID: <awRnkbbxYUw-ihGb@sgarzare-redhat>
References: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
 <20261114-kbh3-1-022-fix-v2-v6-2-96b6029bbffa@eldare.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261114-kbh3-1-022-fix-v2-v6-2-96b6029bbffa@eldare.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c8j08FAMiWLxq38zp7QD2FyS4j0ROJKlbknFqFAND_I_1795450851
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Nov 14, 2026 at 12:59:15PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>vsock_bpf_recvmsg() sleeps in vsock_msg_wait_data() with the socket lock
>held, so the virtio delivery worker, which needs that lock, deadlocks
>with the reader and all vsock rx on that worker stops.
>
>Release the lock around the wait. The reader can then wake without
>data, so the wait also has to loop; the fix needs both halves. The loop
>ends on data, the timeout, a signal (the sleep returns at once while
>one is pending), a lost transport after a failed connect(), or a state
>in which __vsock_recvmsg() would not wait. Those states go to
>__vsock_recvmsg(), so a non-blocking read now sees them before -EAGAIN.
>A blocking read interrupted by a signal now gets -EINTR, or restarts,
>instead of -EAGAIN. One tested difference remains: a reader asleep at a
>virtio transport reset gets -ENOTCONN, where a native socket gets
>-ECONNRESET (0 on seqpacket).
>
>The deadlock was found with the help of Anthropic's Claude; the netdev
>Sashiko reviews and Alexei found the wakeup, reset, shutdown and
>lost-transport cases. Each was reproduced in a VM without kernel
>changes or error injection (the resets unbind the guest's virtio-vsock
>device), except the lost transport and a SHUT_RD with a pending socket
>error, which were checked only in the code. With this patch the
>reproduced cases behave as on a native socket, apart from the reset. I
>ran the vsock vmtest.sh single-VM tests and the BPF sockmap selftests
>with the series; they pass, though none of them sleeps in this wait.

Ditto about series/patches.

>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
> net/vmw_vsock/vsock_bpf.c | 42 +++++++++++++++++++++++++++---------------
> 1 file changed, 27 insertions(+), 15 deletions(-)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index c9b399f37720..41307759da99 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -34,24 +34,37 @@ static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
> 	return vsock_sk_has_data(sk, psock);
> }
>
>-static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
>+/* __vsock_recvmsg() doesn't wait in these states. */
>+static bool vsock_rx_done(struct sock *sk)
> {
>-	bool ret;
>+	return sk->sk_err || sk->sk_state != TCP_ESTABLISHED ||
>+	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
>+	       (vsock_sk(sk)->peer_shutdown & SEND_SHUTDOWN);
>+}
>+
>+static int vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock,
>+			       long timeo)
>+{
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	int ret = 0;
>
> 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>
>-	if (sk->sk_shutdown & RCV_SHUTDOWN)
>-		return true;
>-
>-	if (!timeo)
>-		return false;
>-
> 	add_wait_queue(sk_sleep(sk), &wait);
> 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>-	ret = vsock_has_data(sk, psock);
>-	if (!ret) {
>-		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>-		ret = vsock_has_data(sk, psock);

nit: a comment here to explain why a transport can become null would be 
nice.

>+	while (vsk->transport && !vsock_has_data(sk, psock) &&
>+	       !vsock_rx_done(sk)) {
>+		if (!timeo) {
>+			ret = -EAGAIN;
>+			break;
>+		}
>+		if (signal_pending(current)) {
>+			ret = sock_intr_errno(timeo);
>+			break;
>+		}
>+		release_sock(sk);
>+		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
>+		lock_sock(sk);
> 	}
> 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> 	remove_wait_queue(sk_sleep(sk), &wait);
>@@ -105,10 +118,9 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 	while (copied == 0) {
> 		long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>
>-		if (!vsock_msg_wait_data(sk, psock, timeo)) {
>-			copied = -EAGAIN;
>+		copied = vsock_msg_wait_data(sk, psock, timeo);
>+		if (copied)
> 			break;
>-		}
>
> 		if (sk_psock_queue_empty(psock)) {
> 			release_sock(sk);
>
>-- 
>2.56.0
>
>

I can't see anything wrong, just some nit comments left.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


