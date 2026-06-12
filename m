Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBBF25A2BB
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781239959; cv=none; b=jEgIgdfyzz60/lTXyjKJUURWqA3O27KLIiFPBDvxzitpWrlpDWijdll5Jwnv5f4pY1wyM7iAhW5DyQf+S0Wj3Ck8q6c/znjWrNsP7cWNd6OgPUzjGSfUqOE4DdyXFBOFl5I6Fp4/kHSOnlHBV1ueXBaBRETc6YOKx+6gx+njfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781239959; c=relaxed/simple;
	bh=Zb0aSc57rTv/0MGimrIJROiJKPq6Dg44hlFx/+0n818=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBbqUHHvXAr/rW+zbIJdN2OuAI0r3HVVOHqAxg2EzywTSha/4r2jiLd9yjEYtD1SCdXJuOJLNqKxz7IsvLBAU9HIXlNhaKYJaGUItBR0QSnVD96v+J9kg1TGlquS/99nxBkaFuMOgiBV4biyPOE1L5y3WlC+ab3qRjy6NLQcJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pknFoSnr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pknFoSnr"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36baec934b6so921093a91.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 21:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781239956; x=1781844756; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Osr7f8AtrbOqHr8+fTeznPttcaP3WhzGJN6RE+7tY1E=;
        b=pknFoSnrCRvyaBmeo3FFvnL+SIt+0osUTDSGg7CwK3l9jsJsXy2mXtIrxmxWbhDvcD
         5Yua4jrCst87EkunZgqnMlDTbSg5rzXb8POi3Nj857cfY8B26VN30MC/2Yeewc6zZ2mX
         S8HGyP2cb/HjSUVbW92SQJEgNkggMjYrPTnFlqnAMJWoVvbtcaomDmA79VUFxGifGD9i
         rFi6hAYtJhhVx6t/0mLmrO+mRyqP/1TzlJFXgk8QRAJttrcoEdJ+xLICuqAji/qcPUuJ
         MhuyzFcVlnn1Zuou/V49/j/jlL1U7u+wCuLpiGmzrDzO2EClCoX1FvnFU/VnGVBxMYHM
         98oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781239956; x=1781844756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Osr7f8AtrbOqHr8+fTeznPttcaP3WhzGJN6RE+7tY1E=;
        b=UX4dhSsocDwUk0xHuld45Vz3FaTvC6utaokL6tEYXn5pjSi5XziJZVrFafTulPyUGr
         yWb3tvpcIbzjwgD1dTFKz3ONyWYJP/yQOjSzF2xs5EBMR1S7A9SK8Q8kyCNW4gzaa0vv
         bN4C4C+Oaqscgcne+6Stsidp6h8GxaygnPoyw5BtUoUtObkLNfPSp6BUCeZwXay4JfuO
         WsjqwTVQ5PoY9HpQvTL4pPNP/hZgOTkIyh3L1DEe9uJdW2rTlmwSalLuW0126I7HGTH9
         nvbeRWOUTtWTN5ZkPHGsQps8lIEjfdAtB2c+WY6JpNQfchxCTRNNMEE7zwEVZ389K+EH
         zuQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uhXg71UFQCMB+QS1iRjwu6l4jh4T2uwua57/hN81k7fo1X0/H+rB/7ceJV4kNY7zU1c2Lr2Ud+b9wHskUkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvYN2V02jLZSxvSiN20rOTS3v5Omp6pTdiYSCtn+FIYBB6dEOA
	B/X9hA2muXVvRnU5LmljTjFPaLO9wPV7rfJl+s1cl/GHHNYUaZRAGV8=
X-Gm-Gg: Acq92OEAlO2DLmXoS8s41f2s/nxwZScixSu4KfM47pbIRudnGUj4gQHdElYaQGJQO9L
	bJo26ct3QYo9ztrTOriZXv+4jEMZLd5xeyB6r5LFQBfaqbZKonKsyQ+6Lqz2s7huZK2xikWzvpb
	0l89ro6ESx8Pb5scpRd+a7pD8gMiIULCk8Pu7nd1tfFexbZ68AB18v9uVncvUOOq/kOSkwOXUwr
	FcWSYbcM2QRP0hwvWmWyvskEmJgctaylNCvI2LSfGMrOwCw9XXAh1uwx4fmaRa2kjMS8zKeCOi0
	pJg6HgIozHtXO+oJ2t7tnvznzK5FTuOZ+A59V7mNswI1OxM7TO6CZXFnMx0FFWGha00kFS8rPpM
	6tIznUEF4PwIlH3IxV7KSzFnlMdJ2Q4BANtNxjvIDeYNcR6ND+ReSZ8cSW+Tdpw7sWp+zCbBVRM
	W0e/+2t4UWqBfwH78G7CE25rozwLyCHpmmXlmcy/JLAEBZmK+vFUO8qnZjgOfVHFLY4T0=
X-Received: by 2002:a05:6300:218e:b0:3b5:68ae:1ac8 with SMTP id adf61e73a8af0-3b7816add46mr1662547637.34.1781239956504;
        Thu, 11 Jun 2026 21:52:36 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm827558a12.5.2026.06.11.21.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:52:36 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com,
	leonardi@redhat.com,
	horms@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v3 1/4] vsock: introduce vsock_pending_to_accept() helper
Date: Fri, 12 Jun 2026 04:52:13 +0000
Message-ID: <20260612045216.105796-2-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612045216.105796-1-rafdog35@gmail.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vsock_pending_to_accept() to move a socket directly from the
pending list to the accept queue in a single operation, avoiding
the sock_put/sock_hold dance and the sk_acceptq_removed()/
sk_acceptq_added() pair that would otherwise be needed when
calling vsock_remove_pending() followed by vsock_enqueue_accept().

Use it in vmci_transport_recv_connecting_server() where a completed
handshake transitions the socket from pending to accept queue.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 include/net/af_vsock.h         |  1 +
 net/vmw_vsock/af_vsock.c       | 10 ++++++++++
 net/vmw_vsock/vmci_transport.c |  3 +--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 4e40063ada..30046a3c20 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -220,6 +220,7 @@ static inline bool __vsock_in_connected_table(struct vsock_sock *vsk)
 void vsock_add_pending(struct sock *listener, struct sock *pending);
 void vsock_remove_pending(struct sock *listener, struct sock *pending);
 void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
+void vsock_pending_to_accept(struct sock *listener, struct sock *pending);
 void vsock_insert_connected(struct vsock_sock *vsk);
 void vsock_remove_bound(struct vsock_sock *vsk);
 void vsock_remove_connected(struct vsock_sock *vsk);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2ce1063d4a..1f94f0d44c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -496,6 +496,16 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
 }
 EXPORT_SYMBOL_GPL(vsock_remove_pending);
 
+void vsock_pending_to_accept(struct sock *listener, struct sock *pending)
+{
+	struct vsock_sock *vpending = vsock_sk(pending);
+	struct vsock_sock *vlistener = vsock_sk(listener);
+
+	list_del_init(&vpending->pending_links);
+	list_add_tail(&vpending->accept_queue, &vlistener->accept_queue);
+}
+EXPORT_SYMBOL_GPL(vsock_pending_to_accept);
+
 void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
 {
 	struct vsock_sock *vlistener;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 91516488a7..635ebf9da4 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1258,8 +1258,7 @@ vmci_transport_recv_connecting_server(struct sock *listener,
 	 * listener's pending list to the accept queue so callers of accept()
 	 * can find it.
 	 */
-	vsock_remove_pending(listener, pending);
-	vsock_enqueue_accept(listener, pending);
+	vsock_pending_to_accept(listener, pending);
 
 	/* Callers of accept() will be waiting on the listening socket, not
 	 * the pending socket.
-- 
2.54.0

