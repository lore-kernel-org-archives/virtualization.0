Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741934;
	b=ax0Y/xnliQ46AIcyVcMe/ZTvH8Dz3lNPCr3+rXJxorRo89zVmy2zebrVAFopNdVzpQ+m
	 P0jV51H8DSNhQX5e1ImR1OEpUb3KiC2D2phhGjlK4f7ZGCGvYajySaSNqwFahk69eh3IN
	 94XcrhEPjAhn25iiyOGztBsdfZFZ9t+/V2dgLQsIllUfyI/hPzB/HIcfNnjRZ6SH2VXzI
	 kRPsjPcNoJ1ax+5F2FLG53g0ES6D3qzC+G9s1DT9jKhDVvhn0ZZYIXpPMhPWaZrFQ5hlu
	 LP8J/tjvfS3HJKyDthiKigjDR1XFt4+Awr5cfCvYe/GbExKgqxDZZf8XfYNhkDPojFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9sLBChN0O6JCo8X/aICcnwL/utelkn9MGivz/PJwNyA=;
	b=4MvYb0PtFj5hYxfkSLLGsdkbvfyDF9cHeMCgS9V77WSXCx7c5NqxzwTgibHN0U3qP6Qd
	 14sxdBJ5tn/qQG/0KlJBg2A/lW7IHzm3mpNW3IKCbwhnztKgOJlId5dqd3zUR06Fc73kd
	 JnqQ5w26jFBqaoX+0mV6rnd0yT+CyVZnFr1WIZL8HysPx2tZzvdVk4l2URT7ssPvaFxir
	 lafgSAOca4HXYZInyOYL7kGe2nnWiaf2uvNKfBO1hmov5LPHJk3b9IzGiHxtCIIJnMYHD
	 IyKYaRNOyu1vIKaYewbOLYvKSwKVRJ8jknFafhLndyCpJvly0AiTn2oOx7PiYTzm1kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qd3liUVE;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B64606A31E
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 07:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7B64606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qd3liUVE
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2db80fcdf8bso3080295ad.2
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 00:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741933; x=1793346733; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9sLBChN0O6JCo8X/aICcnwL/utelkn9MGivz/PJwNyA=;
        b=qd3liUVEHX9g9PVoDz8RKXJZyCv+zp3AtvHW5zqW4VVPBEEWnAzhISheDYkTOJoZTd
         RvwRrH1OTqeP35kUB8nLmj9JJjMqfptzOV+1aq+RjbIqsqtbRhH1/jUCgQypxC4Q7rlw
         /uwdqJnEM2uQ98d08HtsMT0yvTlBJIZ9xT63pMLx4RPgc51pVxGdPQEV6/U8DTtiOzE0
         HPXeIF1zoimUVowALjyHVD7vwm90+qeadw8LhFvoc1pH06HFBb+KTtwfWT2adNwGAMYm
         76BZPKWQgGqS7KZCTmKd9aOTU0Um1efldI8jCy1jq4O+aoG0MEhDrxJUgsjjECxtK2ni
         G9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741933; x=1793346733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9sLBChN0O6JCo8X/aICcnwL/utelkn9MGivz/PJwNyA=;
        b=K/ySGimwBsaYJwnA+qerJyL0Ffo83xdG+MVW7xJY4zKrUfawfQzon6SpCq2SSi6tJ0
         1bUvroU1reUklgQaF/pjgQ5ZSas+qhdAGBPrChWzhxTyn7BXA48Pja8TG60srZ/kJJ+1
         GCXc8nRi1ZlqBOpKlVus98b4t/K+zWh3VSrNjbePdek50nPKaM1n3qLlJWgjrMd7h+og
         fRhSm9MDVhuOgt3CjUtMe9zSVuLuQkrN6cNtvX3TwGZpTMkFGThNFB0dYnCuIQFXxJjP
         YHx18tZs9cSwtQJVWzk45upfOFuFofxbaPkykLutMro0K+2ljytOdJZLpbhyAU5TM4jF
         ba0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxAamOYJqUvFcjDLSenS7RYHyTOiFn+dCPD0kEKnA2ekf5M0yc814/j3BK2wr73Z2aRAMvQecImzXSCovFOkw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJaB7yixklChPar319MWpaqH/zmMv8jILInTXv8m85Cwjqe5jdH
	ztyW7P5Mi8r8w8kUiqlXhqZLJWbKKMM7ZlOhGnwrW6hE+Wy2lhOKiLLP
X-Gm-Gg: AYBFou1baF+q1X8sUvB/ztTuLERn9F4MVvHr92teCflfvPOf0YL7v51ZTYf00l9vweL
	90Pp9Ipzz2Jlftwi7b6EO6hvdkhhnQengOKulS/WtyiHBkZmVgnZZbaDD2ljeaEY5olcV+7iySv
	HKfbMttLnVtl03UfiCVG4WhIfh5r9PCatHNXMFAn3aYB0BJXd40gGK/mvx3Pz67w5jIca4+vN4D
	wadbM3ZI3zMOsEJmB1dPjcjCFN/eHJM8STkc4OOe+tcUPSfWcYacZ8XaQ7A6J+6y97T+xgJZ2xt
	5Cn2flRlbJBfi+xR5vtqTeSnadDmFfrcZ/4TUEW2u3peFMEnPJTM1s2q1Jw7B9gBk6Yha9bwtzg
	aE9Lu9M4iSD5NppkKrrC72E+Pva4xmsSSLncffqWe6NO9mB/jHUU6GDjXV22HO6K0mNWOQJ1Ny2
	ohxQUpUQ+7L34uRMhaD8LKZfslxkM5BrgMAATUhCJAkn4qwXMAiirCbdtJVxn3yjeg3Kwd+S0eO
	iz+fGsl7OxSWWKJ0eKooduXBza9nuFJfavww4sZhfxqJqubIhMfcCLtKokCsBdyjZiAul+nHhZH
	90o=
X-Received: by 2002:a17:902:db01:b0:2ea:19bc:2fe2 with SMTP id d9443c01a7336-2ea7ce42bd6mr15566715ad.10.1792741932689;
        Fri, 23 Oct 2026 00:52:12 -0700 (PDT)
Received: from gmail.com ([185.220.236.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b368c90sm7208265ad.29.2026.10.23.00.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:52:11 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@meta.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 5/5] vsock/virtio: defer native RX readiness notifications until batch unlock
Date: Fri, 23 Oct 2026 15:51:40 +0800
Message-Id: <20261023075140.9613-6-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023075140.9613-1-physicalmtea@gmail.com>
References: <20261023075140.9613-1-physicalmtea@gmail.com>
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

An RX batch can make a socket readable while the RX worker retains its
socket lock. Waking a blocked reader before release_sock() merely makes it
wait for the same lock.

P4 coalesces native sk_write_space notifications while retaining their
under-lock callback context. This patch also coalesces native sk_data_ready
notifications and moves both callbacks after release_sock(), so awakened
tasks do not immediately block on the RX worker's socket lock.

Save the native data-ready callback before the AF_VSOCK socket is
published. Batch only while the native protocol and both native readiness
callbacks are present and no psock is observed under sk_callback_lock. A
socket with a replacement callback continues down the existing per-packet
path.

At batch finish, deliver write-space before data-ready and hold the
connected lookup reference until both callbacks return. Packets admitted on
the native path continue to use their saved native callbacks. Loading a
current sockmap callback at finish would not serialize its invocation
against sockmap teardown and could lose the native wakeup or invoke a stale
data-ready wrapper.

Extract the data-ready predicate from vsock_data_ready() so the deferred
and regular paths share the low-watermark test.

Performance:

P4-P5 contribution (P1-P3 vs P1-P5):

End-to-end RX throughput (64K Guest recv() size, SO_RCVLOWAT=1; Gbit/s):

  payload  P1-P3 RX  P1-P5 RX  throughput change (95% CI)
           (Gbit/s)      (Gbit/s)
  64B        0.2449       0.2463    +0.55% [-3.86%, +5.17%]
  256B       0.9649       0.9931    +2.93% [+0.83%, +5.07%]
  512B       1.8205       1.8260    +0.30% [-4.27%, +5.10%]
  1K         3.3431       3.3420    -0.03% [-2.15%, +2.12%]
  4K         5.6541       5.8428    +3.34% [+1.10%, +5.63%]
  8K         5.4280       5.3364    -1.69% [-15.55%, +14.46%]
  16K        5.5935       5.6701    +1.37% [-1.41%, +4.23%]
  64K        5.6917       5.8351    +2.52% [-0.20%, +5.31%]

Fixed-syscall stress test (receiver recv() size = sender write size;
Gbit/s):

  payload P1-P3 RX P1-P5 RX throughput change (95% CI)
  recv() calls are listed as P1-P3/P1-P5.
  64B      0.2553   0.2575   +0.87% [-3.68%, +5.63%]
           1048577/1048577
  256B     0.9069   0.9183   +1.26% [-3.96%, +6.76%]
           1048577/1048577
  512B     1.6048   1.6459   +2.56% [+0.98%, +4.18%]
           1048577/1048577
  1K       2.6939   2.7357   +1.55% [-1.35%, +4.54%]
           1048577/1048577
  4K       4.9168   4.9678   +1.04% [-1.84%, +4.00%]
           524965/525283
  8K       5.1476   5.2005   +1.03% [-4.02%, +6.34%]
           262926/263156
  16K      5.5964   5.6609   +1.15% [-2.86%, +5.33%]
           131311/131475
  64K      5.9439   5.9073   -0.62% [-3.00%, +1.83%]
           32875/32937

Guest CPU1 aggregate cycles per received byte
(fixed 64K receiver, with perf):

  payload     P1-P3     P1-P5  change (95% CI)
  64B        60.281    58.258  -3.36% [-8.74%, +2.35%]
  256B       14.242    13.648  -4.17% [-9.81%, +1.82%]
  512B        7.547     7.211  -4.45% [-9.73%, +1.13%]
  1K          3.987     3.853  -3.35% [-8.52%, +2.12%]
  4K          1.983     1.880  -5.17% [-7.97%, -2.27%]
  8K          1.665     1.620  -2.75% [-9.03%, +3.96%]
  16K         1.409     1.346  -4.52% [-10.94%, +2.37%]
  64K         1.322     1.281  -3.11% [-6.49%, +0.38%]

Full-series cycles/B (baseline vs P1-P5):

Guest CPU1 aggregate cycles per received byte
(fixed 64K receiver, with perf):

  payload  baseline     P1-P5  change (95% CI)
  64B        65.282    57.843  -11.40% [-13.77%, -8.95%]
  256B       14.710    13.813   -6.10% [ -7.89%, -4.28%]
  512B        7.709     7.188   -6.75% [ -8.79%, -4.66%]
  1K          4.075     3.862   -5.23% [ -6.80%, -3.63%]
  4K          2.034     1.887   -7.21% [ -8.67%, -5.72%]
  8K          1.664     1.568   -5.78% [ -7.83%, -3.69%]
  16K         1.450     1.385   -4.48% [ -6.08%, -2.86%]
  64K         1.338     1.317   -1.51% [ -3.21%, +0.22%]

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  5 ++-
 include/net/af_vsock.h                  |  9 +++--
 net/vmw_vsock/af_vsock.c                | 27 ++++++++++---
 net/vmw_vsock/virtio_transport_common.c | 52 +++++++++++++++----------
 4 files changed, 62 insertions(+), 31 deletions(-)

Tested:
  Concurrent map-entry attach/detach during sequenced RX and duplex traffic
  passed on baseline, P1-P3, P1-P4, and P1-P5. The active SK_PASS case also
  passed on each state, with 200,000 verdict invocations. The concurrent
  SK_PASS attach/detach case completed 1,000 insert/remove pairs per state;
  its 10,000-record suffix after the final detach was verified. No kernel
  diagnostic markers were found in successful runs.

  Sockmap may replace sk_data_ready and sk_write_space. With non-native
  callbacks, native RX batching must be declined and the ordinary per-packet
  receive path used. The active SK_PASS case covers the condition expected to
  trigger this fallback. The test does not trace each packet's internal
  branch, so it verifies the fallback scenario without asserting that every
  packet took that branch.

  The duplex cases exercised write-space backpressure: the guest's nonblocking
  send reached EAGAIN while the host was not reading. After the host began
  draining data, the guest observed POLLOUT and resumed sending. Counts below
  are observed EAGAIN/POLLOUT recoveries.

    Test / result                              baseline   P1-P3   P1-P4   P1-P5
    No-verdict RX churn: attach/detach pairs     433493  455507  430985  380351
    No-verdict duplex: attach/detach pairs       229793  212410  214198  148755
    No-verdict duplex: EAGAIN/POLLOUT            365/365  266/266  264/264  443/443
    Active SK_PASS: EAGAIN/POLLOUT              2548/2548 3013/3013 3093/3093 4208/4208
    SK_PASS attach/detach: intervals with verdict progress 705 616 631 692
    SK_PASS attach/detach: verdict invocations  99747   99894   97475   82409
    Post-detach SK_PASS suffix                 10,000/10,000 records per run

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index bf28e8e32e280..2aa0e81e655d5 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -287,14 +287,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
  * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
  * lock and the reference returned by vsock_find_connected_socket_net(). The
  * caller retains both until it calls virtio_transport_rx_batch_finish(). An
- * empty batch owns neither. A pending native write-space notification belongs
- * to the lock holder and is delivered by virtio_transport_rx_batch_finish().
+ * empty batch owns neither. Pending native readiness notifications belong to
+ * the lock holder and are delivered by virtio_transport_rx_batch_finish().
  */
 struct virtio_transport_rx_batch {
 	struct sock *sk;
 	unsigned int pkts;
 	size_t bytes;
 	bool write_space_pending;
+	bool data_ready_pending;
 };
 
 static inline bool
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index b76ab565ea58b..57ee545fdb496 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -64,9 +64,10 @@ struct vsock_sock {
 	bool sent_request;
 	bool ignore_connecting_rst;
 	/*
-	 * Captured before the socket is published. This identifies AF_VSOCK's
-	 * native write-space callback after a consumer has replaced it.
+	 * Captured before the socket is published. These identify AF_VSOCK's
+	 * native readiness callbacks after a consumer has replaced them.
 	 */
+	void (*native_data_ready)(struct sock *sk);
 	void (*native_write_space)(struct sock *sk);
 
 	/* Protected by lock_sock(sk) */
@@ -83,7 +84,9 @@ s64 vsock_stream_has_data(struct vsock_sock *vsk);
 s64 vsock_stream_has_space(struct vsock_sock *vsk);
 struct sock *vsock_create_connected(struct sock *parent);
 void vsock_data_ready(struct sock *sk);
-bool vsock_write_space_is_native(const struct sock *sk);
+bool vsock_data_ready_pending(struct sock *sk);
+bool vsock_callbacks_are_native(const struct sock *sk);
+void vsock_call_native_data_ready(struct sock *sk);
 void vsock_call_native_write_space(struct sock *sk);
 
 /**** TRANSPORT ****/
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index e39567990539f..0617073e99ed8 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
 		sk->sk_type = type;
 
 	vsk = vsock_sk(sk);
+	vsk->native_data_ready = sk->sk_data_ready;
 	vsk->native_write_space = sk->sk_write_space;
 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
@@ -1113,24 +1114,38 @@ s64 vsock_stream_has_space(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_space);
 
-void vsock_data_ready(struct sock *sk)
+bool vsock_data_ready_pending(struct sock *sk)
 {
 	struct vsock_sock *vsk = vsock_sk(sk);
 
-	if (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
-	    sock_flag(sk, SOCK_DONE))
+	return vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
+	       sock_flag(sk, SOCK_DONE);
+}
+EXPORT_SYMBOL_GPL(vsock_data_ready_pending);
+
+void vsock_data_ready(struct sock *sk)
+{
+	if (vsock_data_ready_pending(sk))
 		sk->sk_data_ready(sk);
 }
 EXPORT_SYMBOL_GPL(vsock_data_ready);
 
-bool vsock_write_space_is_native(const struct sock *sk)
+bool vsock_callbacks_are_native(const struct sock *sk)
 {
 	const struct vsock_sock *vsk = vsock_sk(sk);
 
-	return READ_ONCE(sk->sk_write_space) ==
+	return READ_ONCE(sk->sk_data_ready) ==
+	       READ_ONCE(vsk->native_data_ready) &&
+	       READ_ONCE(sk->sk_write_space) ==
 	       READ_ONCE(vsk->native_write_space);
 }
-EXPORT_SYMBOL_GPL(vsock_write_space_is_native);
+EXPORT_SYMBOL_GPL(vsock_callbacks_are_native);
+
+void vsock_call_native_data_ready(struct sock *sk)
+{
+	vsock_sk(sk)->native_data_ready(sk);
+}
+EXPORT_SYMBOL_GPL(vsock_call_native_data_ready);
 
 void vsock_call_native_write_space(struct sock *sk)
 {
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index af26344678e41..9d02e81042c21 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1598,7 +1598,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 
 static int
 virtio_transport_recv_connected(struct sock *sk,
-				struct sk_buff *skb)
+				struct sk_buff *skb,
+				bool *data_ready_pending)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
@@ -1617,7 +1618,12 @@ virtio_transport_recv_connected(struct sock *sk,
 			vsock_remove_sock(vsk);
 			break;
 		}
-		vsock_data_ready(sk);
+		if (data_ready_pending) {
+			if (!*data_ready_pending && vsock_data_ready_pending(sk))
+				*data_ready_pending = true;
+		} else {
+			vsock_data_ready(sk);
+		}
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
 		virtio_transport_send_credit_update(vsk);
@@ -1874,20 +1880,19 @@ __virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
 		return false;
 
 	/*
-	 * Sockmap can replace sk_prot or sk_write_space, and publish a psock,
-	 * without the socket lock. Coalescing is safe only for the native
-	 * write-space callback, so a boundary that sees a replacement returns to
-	 * the existing per-packet path.
+	 * Sockmap can replace sk_prot or either readiness callback, and publish a
+	 * psock, without the socket lock. Coalescing is safe only for native
+	 * callbacks, so a boundary that sees a replacement returns to the existing
+	 * per-packet path.
 	 */
 	return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
-	       vsock_write_space_is_native(sk) &&
+	       vsock_callbacks_are_native(sk) &&
 	       !virtio_transport_sock_has_psock(sk);
 }
 
 /*
- * Sockmap teardown restores the native protocol and write-space callback
- * under sk_callback_lock. Serialize each packet admission check with those
- * updates.
+ * Sockmap teardown restores the native protocol and callbacks under
+ * sk_callback_lock. Serialize each packet admission check with those updates.
  */
 static bool
 virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
@@ -1905,9 +1910,8 @@ virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
 /*
  * The caller holds sk's socket lock. If @batchable is non-NULL, update it
  * after processing @skb to say whether a native STREAM/RW batch can continue.
- * When @batch is non-NULL, record a native write-space notification for batch
- * finish. A writer cannot consume the updated credit until this lock is
- * released.
+ * When @batch is non-NULL, record native readiness notifications for batch
+ * finish. A reader or writer cannot make progress until this lock is released.
  */
 static void
 virtio_transport_recv_pkt_locked(struct virtio_transport *t,
@@ -1917,6 +1921,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
+	bool *data_ready_pending;
 	struct sockaddr_vm src;
 	bool space_available;
 
@@ -1926,6 +1931,8 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	if (batchable)
 		*batchable = false;
 
+	data_ready_pending = batch ? &batch->data_ready_pending : NULL;
+
 	/*
 	 * The socket may have been closed or reassigned after lookup but before
 	 * its socket lock was acquired. Listener sockets have no assigned
@@ -1962,7 +1969,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	case TCP_ESTABLISHED:
-		virtio_transport_recv_connected(sk, skb);
+		virtio_transport_recv_connected(sk, skb, data_ready_pending);
 		break;
 	case TCP_CLOSING:
 		virtio_transport_recv_disconnecting(sk, skb);
@@ -2036,32 +2043,37 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
 
 /*
  * Release an active RX batch. A non-empty batch holds the socket lock and the
- * reference returned by vsock_find_connected_socket_net(). Deliver any
- * deferred native write-space notification while holding the lock, preserving
- * the callback context of the regular receive path. An empty batch holds
- * neither.
+ * reference returned by vsock_find_connected_socket_net(). Release the lock,
+ * deliver deferred native write-space and data-ready notifications in that
+ * order, then drop the reference. An empty batch holds neither.
  */
 void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 {
 	bool write_space_pending = batch->write_space_pending;
+	bool data_ready_pending = batch->data_ready_pending;
 	struct sock *sk = batch->sk;
 
 	batch->sk = NULL;
 	batch->pkts = 0;
 	batch->bytes = 0;
 	batch->write_space_pending = false;
+	batch->data_ready_pending = false;
 
 	if (!sk)
 		return;
 
+	release_sock(sk);
+
 	/*
-	 * The packet was admitted with the native callback. Do not reload a current
+	 * Packets were admitted with native callbacks. Do not reload a current
 	 * callback here: sockmap can replace or remove its wrapper independently.
 	 */
 	if (write_space_pending)
 		vsock_call_native_write_space(sk);
 
-	release_sock(sk);
+	if (data_ready_pending)
+		vsock_call_native_data_ready(sk);
+
 	sock_put(sk);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
-- 
2.53.0
