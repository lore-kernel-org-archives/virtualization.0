Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FBB347FEE
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166475; cv=none; b=TQM+J0LNeo0TgoSB52ZER9jkdxqpbiYs6D1NgoMaObC03tXrLH4jU/Ub7dcETgtvZyYLZd1hmlATJjWESPxHo8QsGIb2UDo+E5bs+WNk0vnlUIxFBrBeGGMaoEomcA9l/6cJSJ/ZKFT6MxqGODz+U6opvvd3L2Xk1fN8kYmP9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166475; c=relaxed/simple;
	bh=kBt55AKLdN/Bknuph/LjwlWldLn4H1BQhQl5mweCLDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZBZa1Ffv2W9cYX0G3iZvvND0gHIrOa7gsZxYIHQGY/+cOxQ52Qr/eiTLX0v0Z4GqJeNVbrb0fURF0cvQnSrMmorkG+fzIE6YEvTn/86O/KZzCz3x9CTo/yj7qpNAT5jvjkgP6Xw9XYeba1KLVY6h/MtDPGRdFYJsIU12YdcigKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpvJw4CU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpvJw4CU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781166473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aujw3NhVPNaL0F+ZI/pIj4L4TzWfBaiAg20ONNwBnUk=;
	b=IpvJw4CUttsE/H9CCb+EiDVPOMNoG5mawFU7C7gs669AA9ZXINlRPnLI7qEcku3IEdZcVt
	fY5/TkT4RyeD6/+rC8U06G6ERPnkAi7fHt3HsWfjW2LUslBfV4muTF9Rlq2UvR8swPqu9I
	t24CNbNSwm6caXYbQ/MIaQ1qmBsqUh4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-W5srFcyOOtiegmlsX3GhEQ-1; Thu, 11 Jun 2026 04:27:52 -0400
X-MC-Unique: W5srFcyOOtiegmlsX3GhEQ-1
X-Mimecast-MFC-AGG-ID: W5srFcyOOtiegmlsX3GhEQ_1781166471
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490cc1ae292so5454795e9.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 01:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166471; x=1781771271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aujw3NhVPNaL0F+ZI/pIj4L4TzWfBaiAg20ONNwBnUk=;
        b=PlMJJRupqXI7d91GojucH4Lm129ooSgxM8psotIMseJ3833RNzh/csxqXRKO6xwjTi
         HgwZLfT5tlJJ4AFFMLxWgp+quZZo9LolVyDOetBiC+c+P5Rvj5pp4TpLl98aX20XBKdr
         NwCDvRMvyYiCMTZAFOj0M36BdfyM9d1dZN6GbAP0DrKRPh2t5LEK/sYnvOtq1Uis8THG
         Fxffcj3tusTvgQ97cSq1yPUMgiuI0WuEE0n4vlGIvk/GUdEAS2DP0x9l3lML5S3Bn8e2
         gZH011CO8A1Mz7DhqufWH6mF+kb0nI8NBTL/OGYPDAge4W6QntUQaO5pvWzLQ7RyBBh3
         gt3w==
X-Forwarded-Encrypted: i=1; AFNElJ+pvQ5GhqeGgvF93Qj5PFcMwQgB53DaUmXR7Lj2ny+jjlD00LdB7jciIWwfIh1UaWomaEEhI2cHMFUOJnT/yA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyB7psn1Ngg85dR6UxXn8/QTlEAkfI8O9fMf5BbUVDoYWr+5v2l
	HyAYRdEDpLk6cq3qejYm58mJWElTwT/neEEuBGrGw5tIvJC6taJBiO33GymZxFKkMEUyZbQ8/z/
	ZqE9n1orqPZHXzzIP5kLOZXFe5ZAOl0SyirnqERVP884inZSu/c0fkJC5yUNWQk0dPc36
X-Gm-Gg: Acq92OGXG/kEwJ9GZUCccoqBOtJcHEiWQ4nUeJ3ehLmlikRaSgaiDwcvynNrdHgYa+B
	x1lF+xnNsDTVz+lUo2IskY2c7RhrRnDoaAEtnzeyGM1o1X6VM8AvgCaKasscTStzXHS7fAs4GeL
	nwKK44rCouYHmx3oGPFMUsAAAokdIZoYYX6WfQ3JmBz+WFKp2cUeuZBSryTm+QszS4Bi0ngLgoX
	CrkzVLaf6p7lu2ID8wPC9zQCXvdey+zh6BwK24hji9yAQgygcxePSeYOT0sWWI/4zrPbbMRxZVA
	IqwbKjRQ3yDtijtMikDQqjEzxBB7d0crM4Mj5BKYEYlP/LxI+Q5X5PIYrDzS6efY6S4KtDGNc1T
	/ETOFuclTIkFZSPvSRFyPxwwcc6g/9r8OBFvioV0zcTY+ic6go6K6R7JsMT04qo+prGG6aXaDYZ
	JsZ7knjg==
X-Received: by 2002:a05:600c:3ba7:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490e52cad04mr18100855e9.2.1781166470837;
        Thu, 11 Jun 2026 01:27:50 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba7:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490e52cad04mr18100565e9.2.1781166470435;
        Thu, 11 Jun 2026 01:27:50 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e5329d3asm28397365e9.13.2026.06.11.01.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:27:49 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:27:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 1/2] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <aiptrtQIC5ivKjem@sgarzare-redhat>
References: <20260611021317.69362-1-rafdog35@gmail.com>
 <20260611021317.69362-2-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260611021317.69362-2-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eRCU76QQLJoKJLePKazltqptXtnxiBIWTne7QOYQnfc_1781166471
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jun 11, 2026 at 02:13:16AM +0000, Raf Dickson wrote:
>virtio and hyperv call sk_acceptq_added() immediately before
>vsock_enqueue_accept(). Move the call into vsock_enqueue_accept()
>itself so callers cannot forget it and the accounting is consistent.
>
>vmci is left unchanged as sk_acceptq_added() there pairs with

I'm confused, vmci is also calling vsock_enqueue_accept(), are we 
calling sk_acceptq_added() twice?

Aaaah, vmci is calling vsock_enqueue_accept() after 
vsock_remove_pending(), so IIUC with the next patch we fix this, so 
should we reverse the order of the patches?

Also, should we avoid this?
Maybe adding a new function that moves a socket from the pending queue 
to the accept queue avoiding also sock_put/sock_hold dance and 
sk_acceptq_removed()/sk_acceptq_added().

I mean something like this (untested):

void vsock_pending_to_accept(struct sock *listener, struct sock *pending)
{
	struct vsock_sock *vpending = vsock_sk(pending);
	struct vsock_sock *vlistener = vsock_sk(listener);

	list_del_init(&vpending->pending_links);
	list_add_tail(&vpending->accept_queue, &vlistener->accept_queue);
}

To be called in vmci_transport_recv_connecting_server().

WDYT?

>vsock_add_pending(), not vsock_enqueue_accept(), since connections

So can we move sk_acceptq_added() also in vsock_add_pending()?
(with another patch I guess)

Thanks,
Stefano

>can be cleaned up by the pending work timer before ever reaching
>vsock_enqueue_accept().
>
>Suggested-by: Paolo Abeni <pabeni@redhat.com>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/af_vsock.c                | 1 +
> net/vmw_vsock/hyperv_transport.c        | 1 -
> net/vmw_vsock/virtio_transport_common.c | 1 -
> 3 files changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2ce1063d4a..73e6416ee9 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -507,6 +507,7 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
> 	sock_hold(connected);
> 	sock_hold(listener);
> 	list_add_tail(&vconnected->accept_queue, &vlistener->accept_queue);
>+	sk_acceptq_added(listener);
> }
> EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index b3394946b2..0de8148877 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -410,7 +410,6 @@ static void hvs_open_connection(struct vmbus_channel *chan)
>
> 	if (conn_from_host) {
> 		new->sk_state = TCP_ESTABLISHED;
>-		sk_acceptq_added(sk);
>
> 		hvs_new->vm_srv_id = *if_type;
> 		hvs_new->host_srv_id = *if_instance;
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b10666937c..4a39d48db9 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1582,7 +1582,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 		return ret;
> 	}
>
>-	sk_acceptq_added(sk);
> 	if (virtio_transport_space_update(child, skb))
> 		child->sk_write_space(child);
>
>-- 
>2.54.0
>

