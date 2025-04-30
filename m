Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5519235069
	for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005811; cv=none; b=iIHmYh5USkshEol2T3ogX6jhIs3QV3ObsNDNWUWcNpGjUHkvN4wsslaO0CAhIxVBGfa/H/I+iP9nFa3YpF8OpcMsPh0j+genmbKLV8CJOSQpu7b9UzchDt+zfAheOreoeIaq9XoWV2l3S8/m+CwLxYHotOJBSP9NskVvNa5MgpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005811; c=relaxed/simple;
	bh=5Ocuw4e8b8MCvcgZG8tAmtt1ISXlU0QTVvz2XLE1ZV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=avbK8NyzuftKYjRvNFwyG/8mpxDpcRuoC6AyCklqlEjvZMWiTEM/CY2D3QGt4KPf7JXbK05n5b4UHqZ7/9H0QFVgswclmg2qppOL8dDkmSFVs2SCAhycUtFhU2m2K2FwXvCw0h5sWRd8emgxaPfKOMhTLp4AdbzJSoDkEFFwYEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCb0Z+Ok; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCb0Z+Ok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746005808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PklXpf2mtZZMeIyH7dbSdoSYGX/kozHo8SVimCxZe+I=;
	b=PCb0Z+OkbAjKgnlb/6mGEzau2JHdNZmsuGL+83gxWIII/BZzICFf+FVrB6xKajUtDrQJVK
	/GNvUyGlFaONNe+5BLIjjnVA/efzk8zOYT1zsVHLIiROOeGGyRUr2qx6dz+2+ABjqlRztG
	L+qN7SzSwdRAZqUaI0yih5Eyni8tA/4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-caBynuj2Pa2o6xQIUMqIQQ-1; Wed, 30 Apr 2025 05:36:47 -0400
X-MC-Unique: caBynuj2Pa2o6xQIUMqIQQ-1
X-Mimecast-MFC-AGG-ID: caBynuj2Pa2o6xQIUMqIQQ_1746005806
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5f620c5f8e4so7155605a12.1
        for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 02:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746005806; x=1746610606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PklXpf2mtZZMeIyH7dbSdoSYGX/kozHo8SVimCxZe+I=;
        b=VyEu0CnwNMl/wb1/HK9maxJhxyqWjmqyPtcP34m9cf0ze48DUn340nI4Fs+ne8qBYi
         JcJGDVsc2QyqfskBriaPF3YrdC1Tfm6QJDMukLk9Udj1kxD4d7A/Wmk4U0O8EcwJDWQM
         26FbW4upPSgJ/2WpN8yfn7qen4kbs86rMrNt26uiknKWJozfRu0lvTtvMwNYYOZQl29o
         sNZPx1A4nsKxpnOi1ahtpLSuXVm9tzO/ZprRs4bGBPc+fvmcJLTHbv4yqBdePVozzbZH
         C/lkb92S9SSMGFD5nuPRV5unBd5XI25VqTqTBykOx2F1w090/uvRCkFQGcSH+yTX1IuZ
         FyHA==
X-Forwarded-Encrypted: i=1; AJvYcCV21WD+hg0Q+rMxjwDNMODOnFx2rFyY4nGcQNPGC0tpoGgvspNiaJPLYvI/J9Y4nINaNx1zCbYqyJOFVF2zLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVBv1On3InBeg+CPYTRsF0moIq55MUsMNoDSHK75fkAkdWM2/p
	hyck+DeGLCG5SVeYjbFzlO9/rfvZVbfP0hk5iAgRQMWIOSPUfv8NRd6JhiVw8yuwQtVcb5zGkH0
	Nz03PLeyZb6fVkkfcLFd82hYQsVbMF1BW49IkpmXJxsOAqlwJL72YAjDvrxJztIl6
X-Gm-Gg: ASbGnctEaCTDlHWRUrm37PXxYpSxmjH/HvvpIkOPCK2fksPiUQFH26qLKpBginLooAC
	WIJt5+GZGr2yqFPmH0IG1tm9XNDhICMrG7vG3CH/YaclWd8y0T8NYX8CQpOrxVfnEHXWBQv+qmA
	trZqwvcSqAvmKIlDchh93QQJCLHHn7DBZAkBHR3k338KMqDfXMJn1a3kTFjWAxeRRZtrxVMK4ZL
	tUVVF2HRSWwNd3aG/br6jFKkTUC4HdD5CMv6Cvs89wgnSxXmd7jIHG86u45rka8S1Fd9NiLQQ3D
	AjdPFihxlRGGw7sOxw==
X-Received: by 2002:a05:6402:2709:b0:5f0:48df:25ae with SMTP id 4fb4d7f45d1cf-5f89ab673f7mr1878512a12.2.1746005806242;
        Wed, 30 Apr 2025 02:36:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHof0+CLIrQBgrHPd0uIgVEPaVcOjpvBaOfPCPKfVxm8p9SM0QtTIrzlcOdGN1NnRYvxDRhEg==
X-Received: by 2002:a05:6402:2709:b0:5f0:48df:25ae with SMTP id 4fb4d7f45d1cf-5f89ab673f7mr1878477a12.2.1746005805553;
        Wed, 30 Apr 2025 02:36:45 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.220.254])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7013fef5esm8463493a12.18.2025.04.30.02.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:36:44 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:36:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/4] vsock: Move lingering logic to af_vsock
 core
Message-ID: <oo5tmbu7okyqojwxt4xked4jvq6jqydrddowspz3p66nsjzajt@36mxuduci4am>
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
 <20250430-vsock-linger-v3-3-ddbe73b53457@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250430-vsock-linger-v3-3-ddbe73b53457@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cJHC96BmUZOgmb1cj1kQtehjmEIz3YDushZxunx0JvI_1746005806
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 30, 2025 at 11:10:29AM +0200, Michal Luczaj wrote:
>Lingering should be transport-independent in the long run. In preparation
>for supporting other transports, as well the linger on shutdown(), move
>code to core.
>
>Guard against an unimplemented vsock_transport::unsent_bytes() callback.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> include/net/af_vsock.h                  |  1 +
> net/vmw_vsock/af_vsock.c                | 25 +++++++++++++++++++++++++
> net/vmw_vsock/virtio_transport_common.c | 23 +----------------------
> 3 files changed, 27 insertions(+), 22 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 9e85424c834353d016a527070dd62e15ff3bfce1..bd8b88d70423051dd05fc445fe37971af631ba03 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -221,6 +221,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
> 				     void (*fn)(struct sock *sk));
> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
> bool vsock_find_cid(unsigned int cid);
>+void vsock_linger(struct sock *sk, long timeout);
>
> /**** TAP ****/
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index fc6afbc8d6806a4d98c66abc3af4bd139c583b08..946b37de679a0e68b84cd982a3af2a959c60ee57 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1013,6 +1013,31 @@ static int vsock_getname(struct socket *sock,
> 	return err;
> }
>
>+void vsock_linger(struct sock *sk, long timeout)
>+{
>+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+	ssize_t (*unsent)(struct vsock_sock *vsk);
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+
>+	if (!timeout)
>+		return;
>+
>+	/* unsent_bytes() may be unimplemented. */
>+	unsent = vsk->transport->unsent_bytes;
>+	if (!unsent)
>+		return;
>+
>+	add_wait_queue(sk_sleep(sk), &wait);
>+
>+	do {
>+		if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>+			break;
>+	} while (!signal_pending(current) && timeout);
>+
>+	remove_wait_queue(sk_sleep(sk), &wait);
>+}
>+EXPORT_SYMBOL_GPL(vsock_linger);
>+
> static int vsock_shutdown(struct socket *sock, int mode)
> {
> 	int err;
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 4425802c5d718f65aaea425ea35886ad64e2fe6e..9230b8358ef2ac1f6e72a5961bae39f9093c8884 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1192,27 +1192,6 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
> 	vsock_remove_sock(vsk);
> }
>
>-static void virtio_transport_wait_close(struct sock *sk, long timeout)
>-{
>-	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>-	ssize_t (*unsent)(struct vsock_sock *vsk);
>-	struct vsock_sock *vsk = vsock_sk(sk);
>-
>-	if (!timeout)
>-		return;
>-
>-	unsent = vsk->transport->unsent_bytes;
>-
>-	add_wait_queue(sk_sleep(sk), &wait);
>-
>-	do {
>-		if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>-			break;
>-	} while (!signal_pending(current) && timeout);
>-
>-	remove_wait_queue(sk_sleep(sk), &wait);
>-}
>-
> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> 					       bool cancel_timeout)
> {
>@@ -1283,7 +1262,7 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
> 		(void)virtio_transport_shutdown(vsk, SHUTDOWN_MASK);
>
> 	if (sock_flag(sk, SOCK_LINGER) && !(current->flags & PF_EXITING))
>-		virtio_transport_wait_close(sk, sk->sk_lingertime);
>+		vsock_linger(sk, sk->sk_lingertime);

Ah, I'd also move the check in that function, I mean:

void vsock_linger(struct sock *sk) {
	...
	if (!sock_flag(sk, SOCK_LINGER) || (current->flags & PF_EXITING))
		return;

	...
}

Or, if we move the call to vsock_linger() in __vsock_release(), we can
do the check there.

Thanks,
Stefano

>
> 	if (sock_flag(sk, SOCK_DONE)) {
> 		return true;
>
>-- 
>2.49.0
>
>

