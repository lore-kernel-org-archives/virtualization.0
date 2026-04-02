Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17BC35F185
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162995; cv=none; b=qCDcuUi280OqidOc3FI/txfjLShyDngHSaJ6t3AaXJRzUVUnedGfWOhwt7HmHcNIleyVPXutZIZCO8ECkPYLA5uKz3cxKHC/klN7Wb+CPkvdXTzyA1Sqr9KznGK9p4nhvzT8CEFjHtm9bvGN/jdRp1VN2B/N8hQaRtHKKNkbvnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162995; c=relaxed/simple;
	bh=/NOWjdCDjnSGtjfZ0scHtF9gHAc7SZGxwt0BAwxtaiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhLDfWtvFJvpfDyYlrFw/+DLyclUjwguD3ObwvrpJOinnkfdrrYAaO6X16nMAd0xJfSLfMiYWzfNf4+qBYWm9KWd5e7iZp6Qrj5ZG5kudK0wHewjQuGbP4EBNMgyUFJb1w4Hzezp7TplUC5ZecPoYHaZMjdXpIpSnwLHKUnszgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kg378e2N; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg378e2N"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2cc1534e026so78616eec.1
        for <virtualization@lists.linux.dev>; Thu, 02 Apr 2026 13:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775162993; x=1775767793; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNWS0mYa+ildstE8KT3uWmZVAb+dtMF6/uKnjB13/tk=;
        b=Kg378e2NLCAnIVSdYg7iTMlIWLY+V6C0ZXBu5uve/VGarAta2YsI7ViAuLIMgTrFLv
         ZslnHh341951asgWUj5VryObB7p4ByyT0pgmdIFOOLflDjiDque4lgpaRNzz3sPsQVwv
         IozPZ6WsVBUgKAD02gfe9awEyHoE6W/2hqaNb/nWbgEJSVqWu8rUN8P4LubXJCM9DoFW
         6t82NVt+R695zHD1A2NGEvRk1kJwrmE46Z3gI4ZdXAK4aKvUoG/Ehz0OWfw9vTFeNsan
         TvQYgBf73d0NN5qc6qMB6iWf0jzq66oOPypcV+yJH/iMrwB0GDp9qBlGTLocHPeTTu2i
         gJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775162993; x=1775767793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNWS0mYa+ildstE8KT3uWmZVAb+dtMF6/uKnjB13/tk=;
        b=I4Tnxpm452VXN146AupRdk42PjxFRLdNg72s21Uuyiq0v5FyyND73KVChcXpw7ezOk
         9m9YRy+h/TYEEVK3aK+D1P7JZDoH8Y7rqCAxK81fKG/OOoGhv/p5YkmWRyIQcc8uw1ah
         10WfcuMWepMiAviKTHaxjIj526quOZvWPqVvNxYrLaGqhnTEuvSQMrYb+GHffweNwTTq
         bYuoO5aoDl1SjGojMy8SBnQ+jlRNjdGVuDA2PIHlcVy9oyHM+qqqO0etKPj07dlJN/jD
         XseRawhK/Iu6gSbL9RE1nQ4lflniRbZD71OrmHag3Ojzm7hnYwFpXSndk14vpHz3a8n/
         5fDg==
X-Forwarded-Encrypted: i=1; AJvYcCWLLbC0X/HEpNjuTAIV7gJEETvhtskaPNKYlFryrDyYsJlM/KCyK+ktSLPQ6+iod0G/AAZiC+DTbRxolNv4fw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq+ANy/AqW20Dk1ncV/3IWcBKJ0VApYYPjplZCMm41+Ahq0uYe
	Lr9WPmtbNyQSglQItiSStz07aRJ8CFMrW6AV+opjgsRlwOd4WkCey+kn
X-Gm-Gg: AeBDietLytpWGwO1qH4nXKdH4ubWN5XlJ51eaFXwx2QojOgm0m1Pk+RtgnM5/gZl36V
	me3ee5uJerQ+1Hzu346NJBS5jETyowLDXTp3+tUVefDo5Cj0kdkcAIRiyywPaavnBWdDOXRxuz2
	oIW8vLhOC6kigj9GfzX9UubDSlRkD3QFqotnpcThzIz3XqmRtSU6pFKipt7CSx9g9mzj2uo98gI
	lb3it4Nut7WD1OVTCVP5cVjJrbud72a00pjALNtJ6UeI/WLGbag6w1CkKiTd0ldyrot8A5X3LoB
	EDfZ1NIZxJJqH5h0fzDnTjb5qfOijTzrSr4FErsP7oNqgxjxerxD9tSdexce96kJqNK+LlGjr3l
	rXdAiE76WAF/XyxWz+evSFF1H/QM1/lrZXF9Z7+TO31fhaCfQBmng8vwywX/DnyDYFBO69Qdy2O
	2I+Akgu92pWNHdpwXUkDt0qlWVAeB1Egm55KoQMdnh24TcQJe6ZzRm190Cdg8T
X-Received: by 2002:a05:7300:bc86:b0:2cb:53f5:553e with SMTP id 5a478bee46e88-2cbf64ab2c5mr405861eec.0.1775162992583;
        Thu, 02 Apr 2026 13:49:52 -0700 (PDT)
Received: from elmini.. (c-98-42-127-152.hsd1.ca.comcast.net. [98.42.127.152])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c30asm3575737eec.15.2026.04.02.13.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:49:51 -0700 (PDT)
From: Laurence Rowe <laurencerowe@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	Laurence Rowe <laurencerowe@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH net-next v2] vsock: avoid timeout for non-blocking accept() with empty backlog
Date: Thu,  2 Apr 2026 13:49:18 -0700
Message-ID: <20260402204918.130395-1-laurencerowe@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common pattern in epoll network servers is to eagerly accept all
pending connections from the non-blocking listening socket after
epoll_wait indicates the socket is ready by calling accept in a loop
until EAGAIN is returned indicating that the backlog is empty.

Scheduling a timeout for a non-blocking accept with an empty backlog
meant AF_VSOCK sockets used by epoll network servers incurred hundreds
of microseconds of additional latency per accept loop compared to
AF_INET or AF_UNIX sockets.

Signed-off-by: Laurence Rowe <laurencerowe@gmail.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
---

Patch v2 with feedback from Stefano Garzarella and Bobby Eshleman:

- Move prepare_to_wait before release_sock to match previous behaviour.

- Simplify not connected case.

This fixes the observed issue for me:

1. With loopback vsock on the host running Linux v6.19.10 built with
config-6.17.0-19-generic from Ubuntu 24.04 and make olddefconfig.

2. With Firecracker guests with current torvalds/master, v6.19.10, and
amazonlinux/microvm-kernel-6.1.166-24.303.amzn2023 used in Firecracker
CI and examples. (Firecracker guest vsocks are unix sockets on the host
side so this fix works there with just a fixed guest kernel.)

I struggled to build a generic 6.1.166 kernel that worked as a
Firecracker guest but the patch applies (conflict due to change of
`flags` to `arg->flags` in surrounding context) so I believe it should
work for generic v6.1.166 kernel.

Alternatively a minimal version of this fix is to just wrap the
`schedule_timeout` in an `if (timeout != 0)` but that leaves an
unnecessary additional `lock_sock` call.

There are ftrace's and reproduction tools at:
https://github.com/lrowe/linux-vsock-accept-timeout-investigation
---
 net/vmw_vsock/af_vsock.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index e4756604d5..b8794ea0f0 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1864,10 +1864,10 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 	 * created upon connection establishment.
 	 */
 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
-	prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 
 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
-	       listener->sk_err == 0) {
+	       listener->sk_err == 0 && timeout != 0) {
+		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 		release_sock(listener);
 		timeout = schedule_timeout(timeout);
 		finish_wait(sk_sleep(listener), &wait);
@@ -1876,17 +1876,14 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		if (signal_pending(current)) {
 			err = sock_intr_errno(timeout);
 			goto out;
-		} else if (timeout == 0) {
-			err = -EAGAIN;
-			goto out;
 		}
-
-		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 	}
-	finish_wait(sk_sleep(listener), &wait);
 
-	if (listener->sk_err)
+	if (listener->sk_err) {
 		err = -listener->sk_err;
+	} else if (!connected) {
+		err = -EAGAIN;
+	}
 
 	if (connected) {
 		sk_acceptq_removed(listener);

base-commit: f35340f2d653f1003602878403c901396ab03c17
-- 
2.43.0

