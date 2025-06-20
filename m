Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F9246BB7
	for <virtualization@lists.linux.dev>; Fri, 20 Jun 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408685; cv=none; b=M/c8dmXXs7VxNPFIuEsSRjAifw43/OkvR1CmH9oQSov070dCpBLKnqib2U6DQs0gnem0DSRrjv+drz/ch2pZTu9pEQ6NIMNHhn9x69PUvdfnvZAy8mBOui5ijQKmKk3n0kA54eAcbx/Qv3iyUB7yz59OkZeKwG1vz/BKqUFKZHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408685; c=relaxed/simple;
	bh=/X0onNxIoHCituHUtODJAVeY5Sgv6GC2RODQR2Tb0Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MY0AFJR+gm8q13v+GkKX3fsPpu2oy8dyRS6hynXF0fhiIhASX+Fgj1b7ZLSIAatc2Czf3E9aDVVfM3VGvPnKXbRG0rN3UpoItaKUFyT9gtqCqCvH4C2+pU6ncoXY/1wwJy5s88U8jqHodt4HzGrMQXH+VSWW6E932MIkHmqo9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOlcKu65; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOlcKu65"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750408681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eog4yVEfqOklks2EjdMhzqPgmpWjhS9NGkes1JaQ9/0=;
	b=GOlcKu65tVg2Jo5VKaFuuvR8RsqaiDZA5o4wBoqNw/fOiDX7C72H5aF57RJERTilRfTQL2
	HjV00rs2b8n08+MaJqwe+K6j4MJUi2EPtquEcRp8fKhw25DChjk9CtY9W2qyh7+qE6gSFH
	pmpRDT3nUqiH/Tt8MdairueIshu7bKM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-hV6BmhyJMSyix0nOy2zSEA-1; Fri, 20 Jun 2025 04:38:00 -0400
X-MC-Unique: hV6BmhyJMSyix0nOy2zSEA-1
X-Mimecast-MFC-AGG-ID: hV6BmhyJMSyix0nOy2zSEA_1750408679
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fb5f71b363so30873406d6.2
        for <virtualization@lists.linux.dev>; Fri, 20 Jun 2025 01:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408679; x=1751013479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eog4yVEfqOklks2EjdMhzqPgmpWjhS9NGkes1JaQ9/0=;
        b=ey2v35sAFuiA4UHn5iwx1fLNeHaI2zzDUS0Pu+LzgbVNxwnKl4mi3lV9mGAP2oReAK
         /unPo3wo9TG5GXrdaLvrTAg2tuaadacLB3xw9jcz2FQLVlc4IqwdWW1mp8eO+/9H5Lhh
         QQx0+8dMkopm01Ok6pYBa8bhWuRXyEtqBCgj0nuXY9qditlp//XL9KTr5LFT79tOPjsE
         dhOugZ1A+PwF72mdm3dMtcc9zrbmjLKSP6Nlpqgb0JhjD2XkUecsVuYFB/efIK12J5ti
         AH6nWxYahDt7lxj7CIcaBIXHlYrgT3lw4LGnb4mUL//aTWhqLJk1auHO5x7YHTsBz5sL
         2oQw==
X-Forwarded-Encrypted: i=1; AJvYcCXiR5Vlpi4TQ3Pi4383KqZS6hr9r0K323RBy2zTX8xaRXQldaDb8KYJ3gYSkrHzi5WRp/FVIzSfJsTivQRQ5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDFGnV4k2Pue/JP8gCk8v+CIuUPs0vqzZIFvRrUNZyQjpOokJs
	WjSoeprtxRTEy1sqp63qtt913WtjvBJltH1UPlv8Xhud1lyCg4thuzhwy6JGzPUFuHyq2AXP4Mm
	PuqWPNg7GsmIKYRIMud2IZVFSHD/Ab9UD8LUOx0/9FNklQHfck5rGTVcku16OelkmJC9T
X-Gm-Gg: ASbGncsZPVq0MIbMPxkpqYYhir7gLQT7ceYjcNw1IoacI0iBNZBD6pPEypkXqZwHPp5
	xxIKnP24WAeU7bVYtU/j2IR3W4VNUp97Y4Ps2swuyHqn6kVocn6az0Ybqa7g7ONi6l9DcxeU/4H
	BupciYotdLZgcobnvHqbBedSbTTqjgOIT04LqQTK9iVxhcrcpWYQahYw6rLct4YNWy6jChDJ+wR
	VpguaL1pIrmcHnDRcIH52qg3rvZPHoHoqiJ2CCyin3Rpsja3W0iYHnIxdt/1QQ6chhVC61FXs/7
	e3rFeW2l0VmHxMVViH/64YIPhB7k
X-Received: by 2002:a05:6214:21ef:b0:6e8:fbb7:675b with SMTP id 6a1803df08f44-6fd0a5bb050mr37553586d6.32.1750408679567;
        Fri, 20 Jun 2025 01:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmA3h6ErxX85wD5sSfG+Vzbb3PR/XLuB7HFc0jjVgeWIZox/+0PegblvBekonQcxrwvk7ztQ==
X-Received: by 2002:a05:6214:21ef:b0:6e8:fbb7:675b with SMTP id 6a1803df08f44-6fd0a5bb050mr37553336d6.32.1750408679168;
        Fri, 20 Jun 2025 01:37:59 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.182.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd0957f69bsm9353816d6.96.2025.06.20.01.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 01:37:58 -0700 (PDT)
Date: Fri, 20 Jun 2025 10:37:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] vsock: Fix transport_* TOCTOU
Message-ID: <qvdeycblu6lsk7me77wsgoi3b5fyspz4gnrvl3m5lrqobveqwv@fhuhssggsxtk>
References: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
 <20250618-vsock-transports-toctou-v1-3-dd2d2ede9052@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250618-vsock-transports-toctou-v1-3-dd2d2ede9052@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -wgmDqFuJvx_7F4Z9yWNB1cxRU5aDRjAR9R49CdMzck_1750408679
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 18, 2025 at 02:34:02PM +0200, Michal Luczaj wrote:
>Transport assignment may race with module unload. Protect new_transport
>from becoming a stale pointer.
>
>This also takes care of an insecure call in vsock_use_local_transport();
>add a lockdep assert.
>
>BUG: unable to handle page fault for address: fffffbfff8056000
>Oops: Oops: 0000 [#1] SMP KASAN
>RIP: 0010:vsock_assign_transport+0x366/0x600
>Call Trace:
> vsock_connect+0x59c/0xc40
> __sys_connect+0xe8/0x100
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 24 +++++++++++++++++++-----
> 1 file changed, 19 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 337540efc237c8bc482a6730948fc773c00854f1..133d7c8d2231e5c2e5e6a697de3b104fe05d8020 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -407,6 +407,8 @@ EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
>
> static bool vsock_use_local_transport(unsigned int remote_cid)
> {
>+	lockdep_assert_held(&vsock_register_mutex);
>+
> 	if (!transport_local)
> 		return false;
>
>@@ -464,6 +466,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>
> 	remote_flags = vsk->remote_addr.svm_flags;
>
>+	mutex_lock(&vsock_register_mutex);
>+
> 	switch (sk->sk_type) {
> 	case SOCK_DGRAM:
> 		new_transport = transport_dgram;
>@@ -479,12 +483,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 			new_transport = transport_h2g;
> 		break;
> 	default:
>-		return -ESOCKTNOSUPPORT;
>+		ret = -ESOCKTNOSUPPORT;
>+		goto unlock;
> 	}
>
> 	if (vsk->transport) {
>-		if (vsk->transport == new_transport)
>-			return 0;
>+		if (vsk->transport == new_transport) {
>+			ret = 0;
>+			goto unlock;
>+		}
>
> 		/* transport->release() must be called with sock lock acquired.
> 		 * This path can only be taken during vsock_connect(), where we
>@@ -508,8 +515,12 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	/* We increase the module refcnt to prevent the transport unloading
> 	 * while there are open sockets assigned to it.
> 	 */
>-	if (!new_transport || !try_module_get(new_transport->module))
>-		return -ENODEV;
>+	if (!new_transport || !try_module_get(new_transport->module)) {
>+		ret = -ENODEV;
>+		goto unlock;
>+	}
>+

I'd add a comment here to explain that we can release it since we
successfully increased the `new_transport` refcnt.

>+	mutex_unlock(&vsock_register_mutex);
>
> 	if (sk->sk_type == SOCK_SEQPACKET) {
> 		if (!new_transport->seqpacket_allow ||
>@@ -528,6 +539,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	vsk->transport = new_transport;
>
> 	return 0;
>+unlock:

I'd call it `err:` so it's clear is the error path.

Thanks,
Stefano

>+	mutex_unlock(&vsock_register_mutex);
>+	return ret;
> }
> EXPORT_SYMBOL_GPL(vsock_assign_transport);
>
>
>-- 
>2.49.0
>

