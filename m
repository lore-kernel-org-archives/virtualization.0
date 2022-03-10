Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836F3C433EF
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 13:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BAFF61282;
	Thu, 10 Mar 2022 13:02:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4opsQy44rUoI; Thu, 10 Mar 2022 13:02:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 456F261219;
	Thu, 10 Mar 2022 13:02:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1779CC0012;
	Thu, 10 Mar 2022 13:02:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB674C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B3BF61204
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:02:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fYIOnsqSvvJA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:02:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76D6D60B43
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646917321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RWMS1CuuTjg/dxyi6dNPKqfhAnq0QfD6tRtdo/5dGxE=;
 b=W1g7RahzbNxKakHYRAI8Gb91Ur6sa+U/V15LaW89gJ7d2puQzfYpDwdeEDCuo4P30R7nr8
 zdbvPWMi+rmdLpE09TBXY43OdvdhEol9TG+/8nSlnbKykLz1W43Yf7UuQoeLhlz7mqMS66
 u9uxboBBrH+ws/uV36uqSNE5/1QtADk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-tKfSOyFeNmOWaeLzmCfD5g-1; Thu, 10 Mar 2022 08:02:00 -0500
X-MC-Unique: tKfSOyFeNmOWaeLzmCfD5g-1
Received: by mail-wm1-f69.google.com with SMTP id
 l1-20020a1c2501000000b00389c7b9254cso2218605wml.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 05:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RWMS1CuuTjg/dxyi6dNPKqfhAnq0QfD6tRtdo/5dGxE=;
 b=RrHG3GIGDStqrBQzxkul/bembIRT3kfpUpIt6bqLXKoBOAX/N5AG7CEo2RQ0iCD2dS
 KVmk+ow4W6DZI/jEh7g93nK7E90B+jPc8xhN92XwWsnGXoYrLpjp0kTKQuHlOUadHiIf
 CxT314RFVXGMIoA9KVZUxIr/hH4zLgTE/9oN+7IQWVVXtH9OejDXAGllQKqNISb7Th+9
 qDt7Fa1JTXv9mUjIAVCnYr9OzPoyriGFWNZm5xRrtpapDJ//2MyeIPcxaaCo2nfACNdq
 OM0REcJ2e6c7HxrUFQqgh+ztI4LRPsSTZ63BiijhcgWuaubOSAvb0xw+i8Wuun/3w8zD
 h2xg==
X-Gm-Message-State: AOAM533FPwZG0FmPvkCJOC5Gn9MucXJuMsprKpEJAkSqlrFYukfEcdKH
 2ty1hIO5MocMsqzMJVTIn9sKH8oOuIIwOBZBBiuDxnimRbSBvPqdwlDa7iGnZwXG0jsXQn0zLfz
 gZD9HkVsAKU/vEvGCS1EP8EweODi5hUCG+I67l2dMhQ==
X-Received: by 2002:a5d:6d41:0:b0:1ef:f32c:18ee with SMTP id
 k1-20020a5d6d41000000b001eff32c18eemr3489817wri.532.1646917318224; 
 Thu, 10 Mar 2022 05:01:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzG8zUynya3aZ1k62/HZYUuzx+jvS8PFleAyItoEwxyNae7kQtcQuOPFd+KwfonhP3HTCC0Bw==
X-Received: by 2002:a5d:6d41:0:b0:1ef:f32c:18ee with SMTP id
 k1-20020a5d6d41000000b001eff32c18eemr3489798wri.532.1646917317914; 
 Thu, 10 Mar 2022 05:01:57 -0800 (PST)
Received: from redhat.com ([2.53.27.107]) by smtp.gmail.com with ESMTPSA id
 r186-20020a1c2bc3000000b0037bdd94a4e5sm4477363wmr.39.2022.03.10.05.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 05:01:57 -0800 (PST)
Date: Thu, 10 Mar 2022 08:01:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiyong Park <jiyong@google.com>
Subject: Re: [PATCH 1/2] vsock: each transport cycles only on its own sockets
Message-ID: <20220310075933-mutt-send-email-mst@kernel.org>
References: <20220310125425.4193879-1-jiyong@google.com>
 <20220310125425.4193879-2-jiyong@google.com>
MIME-Version: 1.0
In-Reply-To: <20220310125425.4193879-2-jiyong@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: adelva@google.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, kuba@kernel.org, davem@davemloft.net
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Mar 10, 2022 at 09:54:24PM +0900, Jiyong Park wrote:
> When iterating over sockets using vsock_for_each_connected_socket, make
> sure that a transport filters out sockets that don't belong to the
> transport.
> 
> There actually was an issue caused by this; in a nested VM
> configuration, destroying the nested VM (which often involves the
> closing of /dev/vhost-vsock if there was h2g connections to the nested
> VM) kills not only the h2g connections, but also all existing g2h
> connections to the (outmost) host which are totally unrelated.
> 
> Tested: Executed the following steps on Cuttlefish (Android running on a
> VM) [1]: (1) Enter into an `adb shell` session - to have a g2h
> connection inside the VM, (2) open and then close /dev/vhost-vsock by
> `exec 3< /dev/vhost-vsock && exec 3<&-`, (3) observe that the adb
> session is not reset.
> 
> [1] https://android.googlesource.com/device/google/cuttlefish/
> 
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Signed-off-by: Jiyong Park <jiyong@google.com>
> ---
>  drivers/vhost/vsock.c            | 4 ++++
>  net/vmw_vsock/virtio_transport.c | 7 +++++++
>  net/vmw_vsock/vmci_transport.c   | 5 +++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 37f0b4274113..853ddac00d5b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -722,6 +722,10 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
>  	 * executing.
>  	 */
>  
> +	/* Only handle our own sockets */
> +	if (vsk->transport != &vhost_transport.transport)
> +		return;
> +
>  	/* If the peer is still valid, no need to reset connection */
>  	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
>  		return;


We know this is incomplete though. So I think it's the wrong thing to do
when you backport, too. If all you worry about is breaking a binary
module interface, how about simply exporting a new function when you
backport. Thus you will have downstream both:

void vsock_for_each_connected_socket(void (*fn)(struct sock *sk));

void vsock_for_each_connected_socket_new(struct vsock_transport *transport,
                                    void (*fn)(struct sock *sk));


and then upstream we can squash these two patches.

Hmm?


> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index fb3302fff627..61b24eb31d4b 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -24,6 +24,7 @@
>  static struct workqueue_struct *virtio_vsock_workqueue;
>  static struct virtio_vsock __rcu *the_virtio_vsock;
>  static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
> +static struct virtio_transport virtio_transport; /* forward declaration */
>  
>  struct virtio_vsock {
>  	struct virtio_device *vdev;
> @@ -357,11 +358,17 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
>  
>  static void virtio_vsock_reset_sock(struct sock *sk)
>  {
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +
>  	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
>  	 * under vsock_table_lock so the sock cannot disappear while we're
>  	 * executing.
>  	 */
>  
> +	/* Only handle our own sockets */
> +	if (vsk->transport != &virtio_transport.transport)
> +		return;
> +
>  	sk->sk_state = TCP_CLOSE;
>  	sk->sk_err = ECONNRESET;
>  	sk_error_report(sk);
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 7aef34e32bdf..cd2f01513fae 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -803,6 +803,11 @@ static void vmci_transport_handle_detach(struct sock *sk)
>  	struct vsock_sock *vsk;
>  
>  	vsk = vsock_sk(sk);
> +
> +	/* Only handle our own sockets */
> +	if (vsk->transport != &vmci_transport)
> +		return;
> +
>  	if (!vmci_handle_is_invalid(vmci_trans(vsk)->qp_handle)) {
>  		sock_set_flag(sk, SOCK_DONE);
>  
> -- 
> 2.35.1.723.g4982287a31-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
