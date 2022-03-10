Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D523DC433F5
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 13:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C9B661211;
	Thu, 10 Mar 2022 13:10:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N6agYquoZulD; Thu, 10 Mar 2022 13:10:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CF097611FC;
	Thu, 10 Mar 2022 13:10:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E218C0012;
	Thu, 10 Mar 2022 13:10:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C48DC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7984D4027F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JPrz-gq-OdBp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:10:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B46740195
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646917803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tLCt4+oXBNeRGeTMGj6f6sRTS6x+CPbNF8lNBRcqCQI=;
 b=Rq4sAGWoH9rB6PQsErrtHo8fcPupPWWUwYnhKc0X58rw6wi9QmTcmlLPgcp8hUUCkgWV25
 ioYeXzcOGOzL+47eGt4XpiXxcEFL1fBDi3yDb2+F7bsAt6m5sHpiSBN6WPmcE9rWDSL86P
 kZafM5Tm5RefeQu1+22XBstvn8JWy7Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-jnWqUQ04OLmC278gM0hEcQ-1; Thu, 10 Mar 2022 08:10:02 -0500
X-MC-Unique: jnWqUQ04OLmC278gM0hEcQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 d8-20020a05600c34c800b0037e3cd6225eso2063520wmq.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 05:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tLCt4+oXBNeRGeTMGj6f6sRTS6x+CPbNF8lNBRcqCQI=;
 b=LLriKQaSQTBHxW+Mmgn8EvZJn+6XW2PUq4LEqtKXQikSt7U6O3WkcZiKW81dgbSHow
 IOw3b4VDQSNyYJJTZeNP+c/nlWhNI3kd0WrxamXueWBArIL+17AERnHFTOZfHwLyb0jT
 pM51/4v61239j1a6DVu04Q2jRTPTupMmFeJtBusHxEJY7q1nczbq9hH4/L1yFBbCtgCI
 BvzymC+i7tAalQWTbm7kpN2Ljbt9t6NOyiytA9WwigFsWqstcLJk/sXJlOd6tXFHZDwv
 S98K5Jqh1HMNLx0BsNMhidsPrt9oJzSY0BYZpYzFkjY2keLuydFfwwMU7bHgTMtqn2/f
 n32A==
X-Gm-Message-State: AOAM533YxHuo+8S8ivfV1y7+rr09Mac68el65q3gWeuboM7R6RMtgbFA
 tq9+89qoABCflXcnG5mAsXW9HHg3whYlAEbhKeGuqHTwqzPWWZFXo13+kuFnEnTNAS9KrSQwaSX
 U9pdrt5avwI+wP4d9v8h8NGNzrPhoo0l9Q66l2TL9Jg==
X-Received: by 2002:a05:600c:4ed0:b0:389:d27f:edb6 with SMTP id
 g16-20020a05600c4ed000b00389d27fedb6mr3729402wmq.82.1646917800446; 
 Thu, 10 Mar 2022 05:10:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQyiWOUzYxcbWxFGGWxoefhXwy+3ImxBpIZ52iOn87ZQzXPJMSab0U6KITKkbgp8AheG7ZCg==
X-Received: by 2002:a05:600c:4ed0:b0:389:d27f:edb6 with SMTP id
 g16-20020a05600c4ed000b00389d27fedb6mr3729392wmq.82.1646917800143; 
 Thu, 10 Mar 2022 05:10:00 -0800 (PST)
Received: from redhat.com ([2.53.27.107]) by smtp.gmail.com with ESMTPSA id
 i5-20020a1c3b05000000b00382871cf734sm8012017wma.25.2022.03.10.05.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 05:09:59 -0800 (PST)
Date: Thu, 10 Mar 2022 08:09:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiyong Park <jiyong@google.com>
Subject: Re: [PATCH 2/2] vsock: refactor vsock_for_each_connected_socket
Message-ID: <20220310080748-mutt-send-email-mst@kernel.org>
References: <20220310125425.4193879-1-jiyong@google.com>
 <20220310125425.4193879-3-jiyong@google.com>
MIME-Version: 1.0
In-Reply-To: <20220310125425.4193879-3-jiyong@google.com>
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

On Thu, Mar 10, 2022 at 09:54:25PM +0900, Jiyong Park wrote:
> vsock_for_each_connected_socket now cycles over sockets of a specific
> transport only, rather than asking callers to do the filtering manually,
> which is error-prone.
> 
> Signed-off-by: Jiyong Park <jiyong@google.com>

Pls just squash these two patches. Downstream will do its own thing,
probably distict from your patch 1 and depending on what its
requirements are.

> ---
>  drivers/vhost/vsock.c            |  7 ++-----
>  include/net/af_vsock.h           |  3 ++-
>  net/vmw_vsock/af_vsock.c         |  9 +++++++--
>  net/vmw_vsock/virtio_transport.c | 12 ++++--------
>  net/vmw_vsock/vmci_transport.c   |  8 ++------
>  5 files changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 853ddac00d5b..e6c9d41db1de 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -722,10 +722,6 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
>  	 * executing.
>  	 */
>  
> -	/* Only handle our own sockets */
> -	if (vsk->transport != &vhost_transport.transport)
> -		return;
> -
>  	/* If the peer is still valid, no need to reset connection */
>  	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
>  		return;
> @@ -757,7 +753,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>  
>  	/* Iterating over all connections for all CIDs to find orphans is
>  	 * inefficient.  Room for improvement here. */
> -	vsock_for_each_connected_socket(vhost_vsock_reset_orphans);
> +	vsock_for_each_connected_socket(&vhost_transport.transport,
> +					vhost_vsock_reset_orphans);
>  
>  	/* Don't check the owner, because we are in the release path, so we
>  	 * need to stop the vsock device in any case.
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index ab207677e0a8..f742e50207fb 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -205,7 +205,8 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
>  struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
>  					 struct sockaddr_vm *dst);
>  void vsock_remove_sock(struct vsock_sock *vsk);
> -void vsock_for_each_connected_socket(void (*fn)(struct sock *sk));
> +void vsock_for_each_connected_socket(struct vsock_transport *transport,
> +				     void (*fn)(struct sock *sk));
>  int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
>  bool vsock_find_cid(unsigned int cid);
>  
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 38baeb189d4e..f04abf662ec6 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -334,7 +334,8 @@ void vsock_remove_sock(struct vsock_sock *vsk)
>  }
>  EXPORT_SYMBOL_GPL(vsock_remove_sock);
>  
> -void vsock_for_each_connected_socket(void (*fn)(struct sock *sk))
> +void vsock_for_each_connected_socket(struct vsock_transport *transport,
> +				     void (*fn)(struct sock *sk))
>  {
>  	int i;
>  
> @@ -343,8 +344,12 @@ void vsock_for_each_connected_socket(void (*fn)(struct sock *sk))
>  	for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++) {
>  		struct vsock_sock *vsk;
>  		list_for_each_entry(vsk, &vsock_connected_table[i],
> -				    connected_table)
> +				    connected_table) {
> +			if (vsk->transport != transport)
> +				continue;
> +
>  			fn(sk_vsock(vsk));
> +		}
>  	}
>  
>  	spin_unlock_bh(&vsock_table_lock);
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 61b24eb31d4b..5afc194a58bb 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -358,17 +358,11 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
>  
>  static void virtio_vsock_reset_sock(struct sock *sk)
>  {
> -	struct vsock_sock *vsk = vsock_sk(sk);
> -
>  	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
>  	 * under vsock_table_lock so the sock cannot disappear while we're
>  	 * executing.
>  	 */
>  
> -	/* Only handle our own sockets */
> -	if (vsk->transport != &virtio_transport.transport)
> -		return;
> -
>  	sk->sk_state = TCP_CLOSE;
>  	sk->sk_err = ECONNRESET;
>  	sk_error_report(sk);
> @@ -391,7 +385,8 @@ static void virtio_vsock_event_handle(struct virtio_vsock *vsock,
>  	switch (le32_to_cpu(event->id)) {
>  	case VIRTIO_VSOCK_EVENT_TRANSPORT_RESET:
>  		virtio_vsock_update_guest_cid(vsock);
> -		vsock_for_each_connected_socket(virtio_vsock_reset_sock);
> +		vsock_for_each_connected_socket(&virtio_transport.transport,
> +						virtio_vsock_reset_sock);
>  		break;
>  	}
>  }
> @@ -669,7 +664,8 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
>  	synchronize_rcu();
>  
>  	/* Reset all connected sockets when the device disappear */
> -	vsock_for_each_connected_socket(virtio_vsock_reset_sock);
> +	vsock_for_each_connected_socket(&virtio_transport.transport,
> +					virtio_vsock_reset_sock);
>  
>  	/* Stop all work handlers to make sure no one is accessing the device,
>  	 * so we can safely call virtio_reset_device().
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index cd2f01513fae..735d5e14608a 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -803,11 +803,6 @@ static void vmci_transport_handle_detach(struct sock *sk)
>  	struct vsock_sock *vsk;
>  
>  	vsk = vsock_sk(sk);
> -
> -	/* Only handle our own sockets */
> -	if (vsk->transport != &vmci_transport)
> -		return;
> -
>  	if (!vmci_handle_is_invalid(vmci_trans(vsk)->qp_handle)) {
>  		sock_set_flag(sk, SOCK_DONE);
>  
> @@ -887,7 +882,8 @@ static void vmci_transport_qp_resumed_cb(u32 sub_id,
>  					 const struct vmci_event_data *e_data,
>  					 void *client_data)
>  {
> -	vsock_for_each_connected_socket(vmci_transport_handle_detach);
> +	vsock_for_each_connected_socket(&vmci_transport,
> +					vmci_transport_handle_detach);
>  }
>  
>  static void vmci_transport_recv_pkt_work(struct work_struct *work)
> -- 
> 2.35.1.723.g4982287a31-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
