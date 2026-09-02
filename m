Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78041D12A
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390080; cv=none; b=Jb9Ieqh+8gDHeZ0Qu+EOCbPsGXk4yaHaag9KXN6Fq3Di6tBxzpqZTG0WG6B1rGeMmBYkRlbAkAI8+IGV8vyAzwraohttHknM/9XjPL6VAbpMR7R31i50LZMRxJll/hTa6zmaJEvnc8iuRJGXmq/mJ7MN7L34vRyjQ0EFN7s5PXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390080; c=relaxed/simple;
	bh=dqBzikGa14hqqrjBAPe6y9B3zxWzEgOKtDsMRinPnZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSA9WcJkA6FcN+DKD4iUqSobFuagsxYxjbBrXiUews+ru1DZK0MAWFstohieP3BlXGqL2s0Uu1YEwebRc22NS9mcu6KYVPQVEY8877JZlTAq8fdz4KHUmd4GhFFCvrcpbK8gCgqgau1uam02CHrnFt4kfDldKNS1JQigCkdLdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1kA8LZx; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1kA8LZx"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4b1bf68b387so764978b6e.2
        for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 16:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390071; x=1788994871; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMJ26BWtmMrRnikBYx5aKuMSmpbwrNZ5wPGOE3sWg+I=;
        b=X1kA8LZxpMaJ4XNtyxz0HTf8gcPdI1M8m3EMQ6BrYkin41zvJjKXVTZCTzu7DNblu7
         hiQ0gn5FafeGqagOP638VAkFN+ktm4gYbH/cx15Kx2fa7+Gc5PzS6h5eOJIygB5sDtWe
         kF6UsRWTyBiCIyIxFH+CbgaKFEsRnbjh6stouogPRD1LZcQ8oKJfZnEjSPPfImxK1fU1
         eNUeL9N6f4D3cxR0jOagctuIP+QntzxH7U4JS8GDff+yqqSmAivRF8MADzB8hyZsMnEI
         lvfzx/CYhBJ4+cFQDw8LSHsCdBFbczSCjfk5I4juUJAJv6Sh+Beli1Pz1WROhhUy7ppl
         Uljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390071; x=1788994871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SMJ26BWtmMrRnikBYx5aKuMSmpbwrNZ5wPGOE3sWg+I=;
        b=dAyN3l5sV+trFMEBnmDcInEhMYrRInyp0Ozp3UEjziic4iQnk8d3R+9eKjpTvF8Mj6
         umItrK3QOCtESrOR2AHw8sX9RPwCZ8jsX2A9MtdoJYzlEVzq48W/8YCw9TGggMIvYQ0/
         4OtFwRhF3vk/2x2XABB+2T9NHidO59fQDG/oXm2HFQG3aEjqI/3EufT3lv9YKVCSeIjk
         FcPfZ85tkLf3wbEsyAOUaa/E2O4efw6JWnREuvpMaBSzGnE3ASlq7bQDc59NOFM8N0pY
         6EA/8LdhoX6GESt+6RaHrscrhKiKeW4gJn9+I1NmtcgMesvMlK3pfJ2T9xVGPH0SLvIS
         cTvg==
X-Gm-Message-State: AFuF++mnijbr8Y/X2UPUJ48I5ZgR1MjLz0nbyXRb5e30+meFbV4VQmeQ
	r0rCIFXoo5Eo6dQalR2/EJjhoOHMvbN2fSB19GeOJilInlJKErG516Rl
X-Gm-Gg: AYBFou2gAumjKiwD7HEXDKgoBqO/sOCMTb5OkXiMoykXmIo1NIPsQy/SHeHt/22asjY
	ERef/Aw2Iw9A7l9HShJZ09dY+87HsikzOaLI8g0r1JyzIlaNDJm9UKcoss0PdI7GuNVO3vns6hA
	IKnwiqh696wdYecIzRZCeSXEwuNKpZwwkuTYBm1sIJvVL8akyP/2cYf21g8l/dYcu+EIP8sO8HO
	ANNtVM51mTzyADZzWeUHQ30zSUm1qBAUqHhYiP89Zh4bUzIilJ51b7iDAGamRjiiXh3+4EynwTc
	jIOUrIXiEfgRbzbQpH0MC8actdU2sBTB3ifkAGtpBICdeXUxK0u3rViRuSpvE8xMKitD7eKQOmn
	uMa+7RuarPXNJgEU+TFcAwujJpNTiU/WeZ3wa3/cDjz8AZvxpiw/nPWleHV7sLqbxChkDTVoaTp
	qOZwOF3II3T5mvmwjZItLZucH/Ou0Ipd4AOatEZBS9JRqGuPsDNtnFAa7ItgIq7UQaPh4=
X-Received: by 2002:a05:6820:1898:b0:6ae:4131:98c6 with SMTP id 006d021491bc7-6b47ecdabc4mr6868224eaf.2.1788390070886;
        Wed, 02 Sep 2026 16:01:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1d::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b40f92004fsm3807143eaf.15.2026.09.02.16.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:01:09 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 02 Sep 2026 16:00:47 -0700
Subject: [PATCH net-next 1/6] vsock: constify the transport in
 vsock_for_each_connected_socket()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-vsock-guest-ns-v1-1-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
In-Reply-To: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Allow const transports to be passed too. The function only compares the
pointer against vsk->transport, which is itself const, and never writes
through it.

No functional change.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/af_vsock.h   | 2 +-
 net/vmw_vsock/af_vsock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 3357ee62d10b..87fdec60ba45 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -230,7 +230,7 @@ struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
 					     struct sockaddr_vm *dst,
 					     struct net *net);
 void vsock_remove_sock(struct vsock_sock *vsk);
-void vsock_for_each_connected_socket(struct vsock_transport *transport,
+void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 bool vsock_find_cid(unsigned int cid);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a33b2a2d381d..29cde17e08f3 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -448,7 +448,7 @@ void vsock_remove_sock(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_remove_sock);
 
-void vsock_for_each_connected_socket(struct vsock_transport *transport,
+void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk))
 {
 	int i;

-- 
2.53.0-Meta

