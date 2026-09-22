Received: from mail-oi2-f26.google.com (mail-oi2-f26.google.com [74.125.231.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90391372B2F
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039904; cv=none; b=nkiCA/C6NENfEnERyHTUGZx6aWSBFNcxaIAe2gD7JQ2LEJEMh0mnBU0Bq1ZGuqeOjkzsiC8gEiLTsfVIzJiZAqVEJJH11xnO8YvnMdAhOlvAxndfIviLHPJJbks8NzNw7tOzVfPWh0LwI9WxITaYuSQ1sy9BJTojhm0W/KDLHww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039904; c=relaxed/simple;
	bh=cS9vNKu7FK5uQuQp6x72bj2FugS7mq6eGvzVjip2oIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lePtGMojhhell2PPesgAyx7c79fpZGTdhbEhtY3/e7Rda5eRx6yKI6V6b9MRaiM2xo42y8/pG0uqqSYYH6Bs8BiDZNkH/OTkVA4iwqPatj8mLfrtsuoODeqyjK31LLMD2+g1VI0v21IeWv69zdkmfMg1f0nlFJTEugnkGRfjqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecZlPw9p; arc=none smtp.client-ip=74.125.231.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecZlPw9p"
Received: by mail-oi2-f26.google.com with SMTP id 46e09a7af769-80a18990c76so2573902a34.2
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 18:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039901; x=1790644701; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eOcxxxCAKSQioxaCmq9VVEr3ww8ELRw40nRpvvXToPE=;
        b=ecZlPw9pD444aN9y8ssNfvm5CFfupGsU33R+mERctxIU0RleBDCPdM+pW+D4Fq1jjP
         UeJKfVgi4SzCNdo3Ym02X7iSCt7qMg2HBZhNfu6yFwBj0e+8cySf65KLIV/0bkQBKUIA
         gxCrb3Em1RItl79v+i9au3sAxo1No6z1/fv7ZRyoQiwQb3SQzNkq2ou878Bsfqeb2Wev
         7xeA2EGqFwGmC7V8bMvmL5Ty0PpVXcr24SSFI2iFgDsYpZXhjcsI9d6J9rZhaLnvc/CZ
         9GZM53H/539fAFWj4lnMqe2ZcQhcBDVtCpC93VmaaIxlSfNO8P10aZehNvij6CSpp6Of
         2yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039901; x=1790644701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eOcxxxCAKSQioxaCmq9VVEr3ww8ELRw40nRpvvXToPE=;
        b=eTTS4+ZZ26INB9j6glSGfzqngE2MgHi8QPF1CQt1cVBPcBTeyOecnE6pqNbnfrPLZR
         /h1yEvDcA/qfNl7PJBe+MfAwOcxuBAXDHJO1Tw4Z2NaTxxgpb3TIuypH+BUrUCXL2j0m
         tsqr7sQ9nrJUhD3QDF78I7cdBhu6eFvlMrS7YRnbaEaEb9RcCZauglE0GrQzwoOfLNp1
         dy3C4Pqz8LP3JCCKeIhPg5J0O3WhLlRPkQmcg349quN0tAxgFmhfphYy7pHsMlDcjlmC
         4/vTmnTOWt2ckU6BoXPNY24EiNqR6PrS25gjh7UxQzE80Pe6M8V2ZmpTvQ1bkKJSybiz
         4mLw==
X-Gm-Message-State: AFuF++neA+rGjNqUDfZOZAmwZp5/JwvYGsrrYXfO0f8yfuQEZed+TE56
	yUd7tO+C4VqCdMVEUD6uRvCjuMhuZG36osSVdlQyDs00jeJyYZUpiEpF
X-Gm-Gg: AYBFou0g9Dx2+A0PWE02KxET1ftQwOdo5GkCMJ+J+IBbIHTdpRdmm9Gh1EZq2TBFq0b
	hd6AU5guNzVtPujJb+7LqHuPPGdfps94d+wjfU+G+4bhckcRgEs8IuooVFJXYfb4NrzN/h1IJBG
	t2NCx0HVRIOY3GEvLxjXKisBuAVKuoeZXIDKdXQo1WO73V7kScYXuq5GwUMJJhlLkMG3MOhLJf5
	qmoXxP723HAUVqidFD6RSnXlZ1TJDmobgvTXeIYWLXmDsuXVTLPObS98M4a9zEyj1WPQsWsWKEh
	Wrj0zog1gaNyeVL/O8k8JmsHWp+0efsFwTY21XDWFJg4doakFcZBlzfW9tMvApR1pNf9/4PJE1/
	kd/UFZWDyDADXD3zJyH56V0amw3OZbDm1fYycUmSEWFfoptDaH6DUzJ4QHWkD5qj+cbhpNXKdcw
	wUwtyE6H0jZGA3hMLU/QHjUp4NbHYZln0D5S9ik9EPofRCXocaBzG3XBM+2Y+dE+yIHZE=
X-Received: by 2002:a05:6830:4905:b0:7e6:d384:459e with SMTP id 46e09a7af769-80ddff5b5f6mr12954905a34.3.1790039901424;
        Mon, 21 Sep 2026 18:18:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-814e5983e4dsm608478a34.6.2026.09.21.18.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:18:20 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 21 Sep 2026 18:18:04 -0700
Subject: [PATCH net-next v2 1/6] vsock: constify the transport in
 vsock_for_each_connected_socket()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vsock-guest-ns-v2-1-693bd78fde9e@meta.com>
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

Allow const transports to be passed too. The function only compares the
pointer against vsk->transport, which is itself const, and never writes
through it.

No functional change.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/af_vsock.h   | 2 +-
 net/vmw_vsock/af_vsock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 5549298c1ec6..370fcd3ddabc 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -233,7 +233,7 @@ bool vsock_check_source(const struct vsock_sock *vsk,
 			const struct vsock_transport *transport,
 			const struct sockaddr_vm *src);
 void vsock_remove_sock(struct vsock_sock *vsk);
-void vsock_for_each_connected_socket(struct vsock_transport *transport,
+void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 bool vsock_find_cid(unsigned int cid);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f840498b58af..8d6b705f8640 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -480,7 +480,7 @@ void vsock_remove_sock(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(vsock_remove_sock);
 
-void vsock_for_each_connected_socket(struct vsock_transport *transport,
+void vsock_for_each_connected_socket(const struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk))
 {
 	int i;

-- 
2.53.0-Meta

