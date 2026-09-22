Received: from mail-oi2-f20.google.com (mail-oi2-f20.google.com [74.125.231.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8437105A
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039907; cv=none; b=IGrNbtJs/s8aP6dFh4+lF76gICjZZLFdOMtBj1NlW8LSARQ7azpB/gcx8HIfIsWcfaSAygnC5EWLUuOiBmW/nj142NKhOCwkrRH75enQN1EOeb2ptCLs2ztm9TndXYJ9k68U/fj36vgNE+IiaSirpOtadEGKfY1nGshDPxFi5Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039907; c=relaxed/simple;
	bh=6+1OlWggIwcOyMWnxSKHvIBN5o/ar+FZaJVwUICSkfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urF1urxgvWiBiz11q7Pt0SL592oveKZLCKpn+uZttBNbNrULDWPNMx+DxgW5yy7d4A21vSYAMS1me8kLuvQOLYcFtW1gNLXnQ/U6O6h1NGebNRWqpy53Muvf6KAmXgv+ZC6GF5m2sD7xN++7TcWCtTqXGUJhuoY+3F4w2iHcTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iazUz5/L; arc=none smtp.client-ip=74.125.231.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iazUz5/L"
Received: by mail-oi2-f20.google.com with SMTP id 46e09a7af769-7f4f1354076so853039a34.1
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 18:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039904; x=1790644704; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+uW+WsuQLmfydKrFyIa5Cn6MVzEK6YuLCP3KSD2va7w=;
        b=iazUz5/L/8rduEmRScmoVsApmXyZXfX5Ls7V7fB9MPOjPUDrfOs5dZCaWULnst8Xlx
         85jnzhMs35d5WiJk/2CV5d/SyMRDuiw6hCazJpA4D4m+VKiWOWRVTGSt0esNRMyOaH4U
         6uP2d6JaY0JtIchXjFrIpMkzqfeLsfpLQwykT+7/+Zc+VJPY/CGAkOeYu/nbaF3CxPfV
         66lbSsRQd+2whdb+UGCn0tj+99USzwocPKiRPXloYs7C99oqGI8F4VV0OAHoPYDVn9k8
         FKzZTIrg1/ehFWIj9RdlgyjxOThvWe+nu/7Cz/lxdccjSnMaEsaqpxy7AbOPkTw3makH
         7BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039904; x=1790644704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+uW+WsuQLmfydKrFyIa5Cn6MVzEK6YuLCP3KSD2va7w=;
        b=WUMJlJTHpfAodhidujmwHgEn7ffkkV5XjomdaUtxoAULbiI6LKoTWHv3bkHYGOvjaE
         EUnzpXRLrCSBJEeWUKIBXGVd3HvjSlWun2Qw/qlubAnrvhvKmAWUYN0whOtN/FFDG5o6
         p0q8MlwaDSBnhpWQlr1qUgvpW6UxYTP7ltqCVlXT/3lHmUvJqh1qogQ5/wnowKIklHW3
         udicIgZYxqzmfUkqm6lPvydtYZKTbWMRqOx9c9hDJ9I/wceRmR4QuAl+MJkTzOBYb+CK
         uqOhKcbd4ZMWnhrcycJ43Hv89nbKjCHkx47wBZKBfrsqirLI3WJ04k6ctRkrNV5eF7tK
         Le1g==
X-Gm-Message-State: AFuF++nOLBLL4vKa+1qAmzkfAAEInvI1NBBSSk6IeVc5iYxuNxHYxnzJ
	ml9pINfyCtxWgbiaEKmVyw4xq5DTS2BlGZMe+yCANu5erFitY3D4UC6i
X-Gm-Gg: AYBFou1/dcWDfh8EQBVucIy6YGXp8Pr1aY2CpSt2QXE3E1Mj6TiKmGDfbcqEnJqwdK7
	uxiMO+mF5aXYjYY/68zmQIe8eFUSZlQgOq3zoY6EZYZJZ0XlEcIPa7BYYNsZKaD356gEO2WmYl/
	okEYcxxxY2UOiNYHjuq7o3AEz1uc8462YLd97Q/IfxNwtbzGfyzdkwdE33bNrgJcCNKJ62lrhpL
	vHm770sdwBpsCdDmpL6FULqQKdIcysp0NN/ExI8NyrMvDHT/B87WNVrvzJ8JSuChjVP/H+J050e
	7ndRrLQxIjsqJ8M2DVgg0OZZqA5GGpUpbPiu6CEXdhkIIUz6h520CTp9GVRx8IUPSy7BPsdfalC
	frQOpKi3fzEqXEfGTgLlFckzMd9eQBflgqvkVm8sGL5F1/nzY58xc3DpKzWnhGTSpANiDV3Qhc6
	k55nkMGTgECnlGnfVHtnOPl6HCf0xJiMZpEPogjhpvGaXNGJYw8GpXxYxmaaGchlyHBpI=
X-Received: by 2002:a05:6830:b16:b0:805:aa3f:fff6 with SMTP id 46e09a7af769-81489cdff11mr1426321a34.17.1790039904129;
        Mon, 21 Sep 2026 18:18:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-814e648bd3asm555996a34.17.2026.09.21.18.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:18:22 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 21 Sep 2026 18:18:05 -0700
Subject: [PATCH net-next v2 2/6] vsock: rename the vsock pernet operations
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vsock-guest-ns-v2-2-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
In-Reply-To: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Stanislav Fomichev <sdf.kernel@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

vsock_sysctl_ops and its two callbacks are named for the sysctl tables
they register, but the init callback already does more than that: it
also initialises the per-namespace vsock state through vsock_net_init().

Rename them to vsock_pernet_ops, vsock_pernet_init and
vsock_pernet_exit, so that later per-namespace work has somewhere to go
that does not read as sysctl handling.

No functional change.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- New patch
---
 net/vmw_vsock/af_vsock.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 8d6b705f8640..95a435aef512 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2998,7 +2998,7 @@ static void vsock_net_init(struct net *net)
 	net->vsock.g2h_fallback = 1;
 }
 
-static __net_init int vsock_sysctl_init_net(struct net *net)
+static __net_init int vsock_pernet_init(struct net *net)
 {
 	vsock_net_init(net);
 
@@ -3008,14 +3008,14 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
 	return 0;
 }
 
-static __net_exit void vsock_sysctl_exit_net(struct net *net)
+static __net_exit void vsock_pernet_exit(struct net *net)
 {
 	vsock_sysctl_unregister(net);
 }
 
-static struct pernet_operations vsock_sysctl_ops = {
-	.init = vsock_sysctl_init_net,
-	.exit = vsock_sysctl_exit_net,
+static struct pernet_operations vsock_pernet_ops = {
+	.init = vsock_pernet_init,
+	.exit = vsock_pernet_exit,
 };
 
 static int __init vsock_init(void)
@@ -3045,7 +3045,7 @@ static int __init vsock_init(void)
 		goto err_unregister_proto;
 	}
 
-	if (register_pernet_subsys(&vsock_sysctl_ops)) {
+	if (register_pernet_subsys(&vsock_pernet_ops)) {
 		err = -ENOMEM;
 		goto err_unregister_sock;
 	}
@@ -3069,7 +3069,7 @@ static void __exit vsock_exit(void)
 	misc_deregister(&vsock_device);
 	sock_unregister(AF_VSOCK);
 	proto_unregister(&vsock_proto);
-	unregister_pernet_subsys(&vsock_sysctl_ops);
+	unregister_pernet_subsys(&vsock_pernet_ops);
 }
 
 const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)

-- 
2.53.0-Meta

