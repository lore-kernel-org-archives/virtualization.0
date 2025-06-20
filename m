Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE2E2264BB;
	Fri, 20 Jun 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750449188; cv=none; b=fJKNvK8mGbYrOoXAMQGnTVy1AOM+fhumPKCyAJvVvpNJbE6jVLFdL98I6chnO0LaflYF+7Y7n2myPBf+fOv60f5rXLycVJSaPjNQQftqnc9/7sSsBBbFKkWg2BvMZEB0Sfl2abYoSs5G3LXcArSItMT8NwxHV8bME6w6Ihhg+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750449188; c=relaxed/simple;
	bh=s7vFseYvObhMUR9kiliY1dbgNdscojmG8Kzgtmg7lpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WC3jz3FrQbbICTE5ofcMYWKNDQ4NPn86g3SgIEXy7vva5fCFvnD7g3bWhsQjT0XFvVS4DAWudaU1hidbfwQHMWpldlzh55JYU17FBA74afau1KuIB6KajcevcRLxFG9SgPWnH1rOWif4yyab3h1ZgJaExFl54wRD7N8SF5B5rWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=prcWwEEF; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="prcWwEEF"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uShnN-000fBE-5q; Fri, 20 Jun 2025 21:53:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=xeaQq61+HXvHVxBxeioIeJobV1RnZZxSPJ0J8d4RGnI=; b=prcWwEEFZROMlp2ZRheYoFs+Nv
	ZBG9sv3T4wgxBT6e3xRy8b3uz6Iy5XiZBAssSV883z/2mdIUr/VMovVt8eNPVCcHt2QEKyGa9x+Ca
	05xOo9bqJ92MjD9SEBC8mqxp9OlTeC/oS1Qo74RMfcaFlyElyyFC9VtPEWqOwDGzLqGPb+V6gq3yI
	Er0qlrPvee4H+aeXna88A+t6JIdzIIyzbq5ZwQXOpFYVyO/ihSt+TDqC5mQ+qa5APuMcYCsP6HdcY
	2qMIPm50ilG9T/+GntEhLdKsKUJVCGrS0Xbjv7XieEzWEYO2ESXr2jYE7T3Y8Sep0i3bSBTbNJfmo
	su76ThjQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uShnM-0008Ih-Qz; Fri, 20 Jun 2025 21:53:05 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uShnC-00CRMQ-SE; Fri, 20 Jun 2025 21:52:54 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 20 Jun 2025 21:52:43 +0200
Subject: [PATCH RFC net v2 1/3] vsock: Fix transport_{g2h,h2g} TOCTOU
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-vsock-transports-toctou-v2-1-02ebd20b1d03@rbox.co>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
In-Reply-To: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
transport_{g2h,h2g} may become NULL after the NULL check.

Introduce vsock_transport_local_cid() to protect from a potential
null-ptr-deref.

KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
RIP: 0010:vsock_find_cid+0x47/0x90
Call Trace:
 __vsock_bind+0x4b2/0x720
 vsock_bind+0x90/0xe0
 __sys_bind+0x14d/0x1e0
 __x64_sys_bind+0x6e/0xc0
 do_syscall_64+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
Call Trace:
 __x64_sys_ioctl+0x12d/0x190
 do_syscall_64+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2e7a3034e965db30b6ee295370d866e6d8b1c341..63a920af5bfe6960306a3e5eeae0cbf30648985e 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -531,9 +531,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 }
 EXPORT_SYMBOL_GPL(vsock_assign_transport);
 
+static u32 vsock_transport_local_cid(const struct vsock_transport **transport)
+{
+	u32 cid = VMADDR_CID_ANY;
+
+	mutex_lock(&vsock_register_mutex);
+	if (*transport)
+		cid = (*transport)->get_local_cid();
+	mutex_unlock(&vsock_register_mutex);
+
+	return cid;
+}
+
 bool vsock_find_cid(unsigned int cid)
 {
-	if (transport_g2h && cid == transport_g2h->get_local_cid())
+	if (cid == vsock_transport_local_cid(&transport_g2h))
 		return true;
 
 	if (transport_h2g && cid == VMADDR_CID_HOST)
@@ -2536,18 +2548,17 @@ static long vsock_dev_do_ioctl(struct file *filp,
 			       unsigned int cmd, void __user *ptr)
 {
 	u32 __user *p = ptr;
-	u32 cid = VMADDR_CID_ANY;
 	int retval = 0;
+	u32 cid;
 
 	switch (cmd) {
 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
 		/* To be compatible with the VMCI behavior, we prioritize the
 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
 		 */
-		if (transport_g2h)
-			cid = transport_g2h->get_local_cid();
-		else if (transport_h2g)
-			cid = transport_h2g->get_local_cid();
+		cid = vsock_transport_local_cid(&transport_g2h);
+		if (cid == VMADDR_CID_ANY)
+			cid = vsock_transport_local_cid(&transport_h2g);
 
 		if (put_user(cid, p) != 0)
 			retval = -EFAULT;

-- 
2.49.0

