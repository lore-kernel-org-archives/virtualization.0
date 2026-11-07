Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017359;
	b=L3H3MjGM2qvMG/rj+7vc+51ym1B1/s+lTIw1kWY3fJ3FhhQZw9+upIKgYQEXoAS2FwRz
	 ltjIPsFZsURY+p1ihw3LkqioDd9W81yhF+q/qg7lGzQWQoW8TFfw5k7cU6xUmhSGJI5tJ
	 lvLJe9PVfrNsKEvjRtTA9NKFYwu9c/aVWfPgGAMdWWsPQngM5/dUFUyxkCoAAiV/QwUmR
	 YC4NHi+RcsiAr2F+c5y9UCQmQ6Fsx4pYIKz+C9kGnxAr+rKHy+TtcLNTt+4SN9Nt0ttdS
	 a1shEetOiuYKwCkFXFHHY0LDrIGna078Fk+0/D1+i/djlffYYRBj+c2IvtCn6aXWG1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=oWCm5sO2ZJcIfwM/bU9hgd9OcLaoRmJrQ2OQCAcOYQw=;
	b=fFzvvv1JoSnKT9uf+ryj8xVLuPebyktzdvd9ehjxusyLoWpHo5ldz6/edBYiisNoBbOj
	 YlgJ8KRCvQx+JFJAKYKQh+2iwhjZski4Mo7OfZ8z2f9BKEas2jC0Wa8DfHh2HL4iHqlY5
	 ccFjZTEQ6EXeUdAY4/8BZCxxvwC8p6FSiaEmaOZel2ieBXQDfbcYnJtN27g35HjO8pwsx
	 VA1h2+KbB5K9r5gL/4XJcNKPi1DQMgOMfN09ZNUmrxNly0EUSQcMVgN1MQca0U2wYdHPu
	 0AkWJckz+MXO8HJaJrolvtvMLWD5c4Rq4z5DfV+X1uIV4GcQ+hrWfuSaBT7vX2xx+6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UbIj9HF5;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB9606A336
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 02:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DAB9606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UbIj9HF5
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e96502e447so10888235ad.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 18:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017359; x=1794622159; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oWCm5sO2ZJcIfwM/bU9hgd9OcLaoRmJrQ2OQCAcOYQw=;
        b=UbIj9HF5CSPW9rJvd7DGqV5Eavx0HCoZOUg1CH6QeCW3+7lJ0GSSgzFcYTSOThYRQk
         WzvsTLW7GCZ/0yX+yw5X/vdEIk8JGrd4bblHoePK/AtZLmt84FdE9VIVxjZFn94PuS88
         651RIJX3b9DC2gSUKBCDj/gtTIZCoHHlUHrY7YHftsV6tUny4mNIJKvXUiFlkq+UrEBq
         c1epXYrybM8yYueZsseeLmhmnqUfCMViRqeepx/EKWYktpcOEy4Ib0ZjuVUSFJ+A5mqd
         lN7/7kW+1vLLt2Nsd49l94m7HiQfe2Bl5Lo0OwvPYeGXMjZ8i4kwXL6X/LMcg0ahslqJ
         tbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017359; x=1794622159;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oWCm5sO2ZJcIfwM/bU9hgd9OcLaoRmJrQ2OQCAcOYQw=;
        b=BHxGuE4j7jHkatvPrY+/3G56bRa2hPJGeGgfh77orEx0nAU93E8AKuEhxUVyF6pK9v
         IOW4mhckwOAGZyVA49rE4hst8oE2A1Wc4Cm0NSOnlnuFj/U5jWAYut5VzGxA49lccp43
         VcydyeJ7Eoy6SZlWBqIYbn9pQeSYZzf3iStt2X/LstPoGD/HcpqEFqSg3RJrDwnulprm
         6qPuEG/ZxhFE6Wvb1D5QneWF6F8EUjsjPHs/mXuFfp8O14iFQlWH88dKdxrC0ONEgvi8
         ZZVyzI8eXODRzxASBMrCJopdTiavrfRNM/TLKPk2NvAbmhj3ZZRsfoymbErBVyn/9Ue7
         UJYg==
X-Forwarded-Encrypted: i=1; AL+hErECe5d6Z2h2NR1mclW8zxJsyoAxACeAOx2sJ5oKFHtvUmqz4JXk+UxYCXNyi7KK2uk38CGQJKBQMNBFAIp3KA==@lists.linux.dev
X-Gm-Message-State: APuU4Z985xfjSzdjgmvHp+jwKoEgIlSyzyiYtcdEen8f3avVWlk/MEHr
	8M9vtbwgIW9DGRJ8SLZ/HbLsVMXq2gU2eskXiKw1+XycRENM61sZyBqp
X-Gm-Gg: AYBFou3r03VR2pXOHG+mv3JX+c+6jqJCd2TUzbF9jE7XVFkvBfNZTgZTrxU1brTTFTe
	0Tnd7YfzXB0S2ynIq7ClDZxoKwOde4BZZ0IJF5WsOK+daLgzSaEpdu8y2xaftC1COB+Zv+OR4Th
	oXWgrmkfZpzG3dAAx6TxZAY6NBFqSmUwIF5AFB3GJySI/7P9hD6pwV8teYjSUaTNTp49jXfmjdw
	chlE5QDTGqLh/3mCEHIwZC0J6h4sSuV06VjvRGz1sQpvVvbsMiEcc+QDmRIrsGNt2N+Qn492gsD
	5RZq/buVN+4DRyY78xvGxLLT4wNUUDeSMpDWs/m2DEL8HPAMDCKk0RZWEEI54uj4SIlfGCfpcSY
	KPdA3aWaC4wVmptIrVsoMRl6QpgOzyNMBpHqxSZISkad1SATnuk64+dPI46WjzIPSO3D8zUmAuV
	c4fHTIm8PcOXs9LEwMXpNgnoXtvlh/kEUH4rImVXrV/4AKZYauf5t+TMf8fjIZOzmEBy72PFnjx
	GgR+2YJjyVu6vlL3W6xzH4YKn5WyAmo4MYvJqLFcr7H22ZB6TtoNP/Wzl5cP6gZUwrC/xGunF1R
	aYBx0sxTcNHTF6xS6A/grk3Nuh+ycIzRwcRdXhf+0l8EjYsSlGO92NrQ1O0zHl72kGMG9B6CiBy
	HDiUjjW1Azm/CVeQnivuWkki02l9Lq76ATQ==
X-Received: by 2002:a17:90b:1a91:b0:3b0:ae41:2707 with SMTP id 98e67ed59e1d1-3b0db6fe133mr4547927a91.45.1794017358501;
        Fri, 06 Nov 2026 18:09:18 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105864375sm1156571a91.4.2026.11.06.18.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 18:09:18 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 02:09:17 +0000
Message-Id: <DMOM2SFCFHYK.3BT44IQ90X9UB@gmail.com>
Cc: "Michal Luczaj" <mhal@rbox.co>, <virtualization@lists.linux.dev>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v4 1/2] vsock/bpf: release sock lock while waiting
 for data in recvmsg
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <jrmmhm.kernel@eldare.de>, "Stefano Garzarella" <sgarzare@redhat.com>,
 "Bobby Eshleman" <bobbyeshleman@meta.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261106-kbh3-1-022-fix-v2-v4-1-c7d36703814d@eldare.de>
References: <20261106-kbh3-1-022-fix-v2-v4-0-c7d36703814d@eldare.de> <20261106-kbh3-1-022-fix-v2-v4-1-c7d36703814d@eldare.de>
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 06, 2026 at 01:57 PM Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org> wrote:
> example by a credit update. So the wait also loops until data arrives
> or one of the native exits applies: a socket error, a local or peer
> shutdown, a socket that is no longer connected, the timeout or a
> pending signal. The loop alone, with the lock still held, keeps the
> deadlock, so the fix needs both halves and stays one patch.

No need for a 2nd copy of the return values.
The old code returns true on RCV_SHUTDOWN. The psock queue is empty, so
the caller goes to __vsock_recvmsg(), which picks the return value.
tcp_bpf, udp_bpf and unix_bpf do the same.
Do it for sk_err, peer_shutdown and sk_state too.
__vsock_recvmsg() doesn't wait in any of these states.
It handles len == 0, MSG_OOB and MSG_ERRQUEUE as well.

The copy differs from a socket that is not in a sockmap in four cases.
The diff differs in one, the last row:

  recv()                          no sockmap    this series   the diff
  ------------------------------  ------------  ------------  -----------
  after a virtio reset            -ENOTCONN     -ECONNRESET   -ENOTCONN
  after a reset, len == 0         -ENOTCONN     0             -ENOTCONN
  after a reset, MSG_OOB          -ENOTCONN     -EOPNOTSUPP   -ENOTCONN
  after peer shutdown, SO_INQ on  0 + SCM_INQ   0             0 + SCM_INQ
  asleep when the reset comes     -ECONNRESET   -ECONNRESET   -ENOTCONN

Instead of patches 1 and 2 (compile tested only):

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 9049d26..3cf017d 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -34,24 +34,34 @@ static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
 	return vsock_sk_has_data(sk, psock);
 }

-static bool vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
+/* __vsock_recvmsg() doesn't wait in these states and knows what to return. */
+static bool vsock_rx_done(struct sock *sk)
 {
-	bool ret;
-
-	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	return sk->sk_err || sk->sk_state != TCP_ESTABLISHED ||
+	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
+	       (vsock_sk(sk)->peer_shutdown & SEND_SHUTDOWN);
+}

-	if (sk->sk_shutdown & RCV_SHUTDOWN)
-		return true;
+static int vsock_msg_wait_data(struct sock *sk, struct sk_psock *psock, long timeo)
+{
+	int ret = 0;

-	if (!timeo)
-		return false;
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);

 	add_wait_queue(sk_sleep(sk), &wait);
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-	ret = vsock_has_data(sk, psock);
-	if (!ret) {
-		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
-		ret = vsock_has_data(sk, psock);
+	while (!vsock_has_data(sk, psock) && !vsock_rx_done(sk)) {
+		if (!timeo) {
+			ret = -EAGAIN;
+			break;
+		}
+		if (signal_pending(current)) {
+			ret = sock_intr_errno(timeo);
+			break;
+		}
+		release_sock(sk);
+		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
+		lock_sock(sk);
 	}
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -80,6 +90,9 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	struct vsock_sock *vsk;
 	int copied;

+	if (unlikely(!len || (flags & (MSG_OOB | MSG_ERRQUEUE))))
+		return __vsock_recvmsg(sk, msg, len, flags);
+
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
 		return __vsock_recvmsg(sk, msg, len, flags);
@@ -102,10 +115,9 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	while (copied == 0) {
 		long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);

-		if (!vsock_msg_wait_data(sk, psock, timeo)) {
-			copied = -EAGAIN;
+		copied = vsock_msg_wait_data(sk, psock, timeo);
+		if (copied)
 			break;
-		}

 		if (sk_psock_queue_empty(psock)) {
 			release_sock(sk);

[...]

> guest's virtio-vsock device. With the series applied they behave as on
> a native socket, except for the reset case above, and the vsock
> vmtest.sh single-VM tests and the BPF sockmap test_progs pass.

None of these tests sleeps in vsock_msg_wait_data().
The sockmap tests call select() before recv() or pass MSG_DONTWAIT.
vmtest.sh doesn't use sockmap.

pw-bot: cr
