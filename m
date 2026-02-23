Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9914237BE71
	for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 22:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886339; cv=none; b=DZd8/5hrY1PJyWdXeAFdKlcnxkMjXjEse2v9L2/LTpxDeUbxZiC7sXfuJOCV3E3R6PJp6wbWpcO7GychP+Vxyp727784ehvoRUwC6iIPDydygyN9kBo4xEEELffNEHBUl0DQ2e8EYzlt6kbECTMH6ZLKntm9RpMEWmBxKNYe9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886339; c=relaxed/simple;
	bh=WgeYmElNUd8JWXtDscMvKbTYKQRR4nvqCMrxNQNtld4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=STWpjsztfldr39+oUlXZEwZPguui7Yj8849oD6xcjcuwGcTqvSGoDDVaZJ5U5Ve4n3g28S+t0mWyGk4UES4qOpQApmuvY3BrJhKBj5VhRRS6S70TJ1RK/b4JDYajhB2SYSvBZ4mjs7Aig5GKVfQx/orWj0BJqbTIJ7j9GOEi+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cO3ilnkZ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO3ilnkZ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79818c7600eso33884117b3.0
        for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 14:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771886335; x=1772491135; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/yCmM+X3z1/BoTwo6svOrTqbVDwyb97Jpk/MjzyWmU=;
        b=cO3ilnkZ0MLfOxzw6Oa+AHAro8QlNgUoqjI2CsgRQ6+s6iALsdr2WHHLVXu00awF7M
         LAGOMV8zjOKUq+dsEAGkYE2z9SvJmSt+jKL2MsaJw40LLr8nbCGBN0RrLu5Y6kLYa84W
         PY5wcJB/MmIi9CeGGKUP4m71K4jxzvpmEmP9YMWZFw2vnbB0hem5iV/2mjOrhRXI1XpS
         242lRvdN2Kgpo03YSO122NxJgu4dpqrUmXEsmrcXj5EOaNxWuNcJfdFCdzOS9hPbDTHB
         rXIC6fPXnkIZcTViboCiDoixFrb7skfOTerT+D+UBm5il9d74WAXvFu3wmkQy1CaBwm2
         7qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886335; x=1772491135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g/yCmM+X3z1/BoTwo6svOrTqbVDwyb97Jpk/MjzyWmU=;
        b=OzfjrBqUpuJeyQ80kTyFoH/vf1FHzaFEkQY1gSG72iRBMdSwrL/pobcQEFCUS+tZYj
         xWOhy0F6Nb1zJ7u+0qujR735JDsPXbx+KzNXHomQJ6IEEzqK/GEaG2GNtlEpE/+R0w7J
         UZY8D7nwMtbbOOnGkT4kjDbhWmllBTjs2L4RdeS2iPOA6krtCu0GIRPhaO2ad+XIK8JL
         6PTdCMpq2mDKvR/dT8eE0x8O3sMiC2XiIPxWWxJCg0NoaMCufXQallibX1UvC0hMwtFH
         q+nw5th2sMMviIEo3VSIAwcn+TY/Wo05gdyTqapRN9h56GMGnLpLFSD98t10SAZ3NnhR
         QxWw==
X-Gm-Message-State: AOJu0Yw84AeGUpcB4xmoIpMviawOPBw/WDqeB5G0yzyu0pgy+fd6j0Fy
	lgYKxOmC10/LbvacGJ/M911yCTMpjCxAlCVOSyyftozHRlJMkHNQlKzn
X-Gm-Gg: ATEYQzwVf6JnkpZNcttsW9a35LrU1PVIQqbjtk8Iy7rk20esgBTUhj48yceHeNuiOB6
	pLBqgf+6YSGDdsYatZlKP4d8lXJ7UtpYYGOk/pXK5y9ik5Y9ByAXnZ9F3Fzdy55rI+buPN3Ws2N
	2KpyZ7nk2SlWLD2ogz+JHXozJqAHtfQzHIp0dbIeupQlvdar7W5LzOlett1xqOkXJpLRj90KBt8
	GgrQ9wdaFETDT11LxhR78ajOm6/4Vk6U4hzJbd0TmDvfCpYuokKs4KrhWZsH3cEGwfdElBtF0n8
	8fXbP/8dS/EMBy1LqPvLwa5uTSNvBbUoxS1EqOptUpkRgt3tTz00gMDgf6Vj45I3foWrE2sjo5C
	HG8Zb4W+smTj2F0TmKvU6JHXF5Xa2kEKBtSS8XrtExcR6s86PSB2vHqlatnrSwySgh+xaz1VNTh
	LAcvmaOBno3O0i63UCvxKadqETKKOHBvCx
X-Received: by 2002:a05:690c:a:b0:794:c01a:18e6 with SMTP id 00721157ae682-7982903c9aamr91568337b3.47.1771886334599;
        Mon, 23 Feb 2026 14:38:54 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbdf23dsm37723417b3.21.2026.02.23.14.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:38:54 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 23 Feb 2026 14:38:33 -0800
Subject: [PATCH net v3 2/3] vsock: lock down child_ns_mode as write-once
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-vsock-ns-write-once-v3-2-c0cde6959923@meta.com>
References: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
In-Reply-To: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 kuniyu@google.com, ncardwell@google.com, 
 Daan De Meyer <daan.j.demeyer@gmail.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Two administrator processes may race when setting child_ns_mode as one
process sets child_ns_mode to "local" and then creates a namespace, but
another process changes child_ns_mode to "global" between the write and
the namespace creation. The first process ends up with a namespace in
"global" mode instead of "local". While this can be detected after the
fact by reading ns_mode and retrying, it is fragile and error-prone.

Make child_ns_mode write-once so that a namespace manager can set it
once and be sure it won't change. Writing a different value after the
first write returns -EBUSY. This applies to all namespaces, including
init_net, where an init process can write "local" to lock all future
namespaces into local mode.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Co-developed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/af_vsock.h    | 13 +++++++++++--
 include/net/netns/vsock.h |  3 +++
 net/vmw_vsock/af_vsock.c  | 15 ++++++++++-----
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d3ff48a2fbe0..533d8e75f7bb 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -276,10 +276,19 @@ static inline bool vsock_net_mode_global(struct vsock_sock *vsk)
 	return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
 }
 
-static inline void vsock_net_set_child_mode(struct net *net,
+static inline bool vsock_net_set_child_mode(struct net *net,
 					    enum vsock_net_mode mode)
 {
-	WRITE_ONCE(net->vsock.child_ns_mode, mode);
+	int new_locked = mode + 1;
+	int old_locked = 0; /* unlocked */
+
+	if (try_cmpxchg(&net->vsock.child_ns_mode_locked,
+			&old_locked, new_locked)) {
+		WRITE_ONCE(net->vsock.child_ns_mode, mode);
+		return true;
+	}
+
+	return old_locked == new_locked;
 }
 
 static inline enum vsock_net_mode vsock_net_child_mode(struct net *net)
diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
index b34d69a22fa8..dc8cbe45f406 100644
--- a/include/net/netns/vsock.h
+++ b/include/net/netns/vsock.h
@@ -17,5 +17,8 @@ struct netns_vsock {
 
 	enum vsock_net_mode mode;
 	enum vsock_net_mode child_ns_mode;
+
+	/* 0 = unlocked, 1 = locked to global, 2 = locked to local */
+	int child_ns_mode_locked;
 };
 #endif /* __NET_NET_NAMESPACE_VSOCK_H */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9880756d9eff..50044a838c89 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -90,16 +90,20 @@
  *
  *   - /proc/sys/net/vsock/ns_mode (read-only) reports the current namespace's
  *     mode, which is set at namespace creation and immutable thereafter.
- *   - /proc/sys/net/vsock/child_ns_mode (writable) controls what mode future
+ *   - /proc/sys/net/vsock/child_ns_mode (write-once) controls what mode future
  *     child namespaces will inherit when created. The initial value matches
  *     the namespace's own ns_mode.
  *
  *   Changing child_ns_mode only affects newly created namespaces, not the
  *   current namespace or existing children. A "local" namespace cannot set
- *   child_ns_mode to "global". At namespace creation, ns_mode is inherited
- *   from the parent's child_ns_mode.
+ *   child_ns_mode to "global". child_ns_mode is write-once, so that it may be
+ *   configured and locked down by a namespace manager. Writing a different
+ *   value after the first write returns -EBUSY. At namespace creation, ns_mode
+ *   is inherited from the parent's child_ns_mode.
  *
- *   The init_net mode is "global" and cannot be modified.
+ *   The init_net mode is "global" and cannot be modified. The init_net
+ *   child_ns_mode is also write-once, so an init process (e.g. systemd) can
+ *   set it to "local" to ensure all new namespaces inherit local mode.
  *
  *   The modes affect the allocation and accessibility of CIDs as follows:
  *
@@ -2853,7 +2857,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 		    new_mode == VSOCK_NET_MODE_GLOBAL)
 			return -EPERM;
 
-		vsock_net_set_child_mode(net, new_mode);
+		if (!vsock_net_set_child_mode(net, new_mode))
+			return -EBUSY;
 	}
 
 	return 0;

-- 
2.47.3

