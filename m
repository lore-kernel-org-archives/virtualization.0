Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930652772D
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781133161; cv=none; b=H95aQLH8zbQ3KZR4YZp3BgTraumN8wbqyoUUGT7K9xI+8EFnbJnln/kuUcWChMKwYEPT7wVtm/q9+x2L71wdfFtFUlRWKY2D9mWBDpmuYyujCqf5rQtQVwoT/CBEaCB3A4GKC74hyCidgg+Flz5Y5uVNrw1UDdOg7d+mf3D84/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781133161; c=relaxed/simple;
	bh=2OLiIqVkhj3ggpwre3HAy5E5W5ZI0nG/3TV62WY1E5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4KcLgi/HjbB6suR20HwpMYkPy5/Lrm5sPwXbK/3VbFrf5T1XXEA3RDkmukmjPlx8kViODF43SEhWWZeQjjdHM9YDNieFal9kCQ6lhHiF1AEOqzEON0bjs9JecQc+he/IxudHsckXBNRZbHg8Ub/IfRNGk/CVOxgwpWv0Cn9v3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJkqufS/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJkqufS/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c132ac5ec2so72379605ad.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781133160; x=1781737960; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQLCg81en/xiSDiPUo9OAx2p+vBmXiFBiAm/qA8ZaPM=;
        b=EJkqufS/hVifCQ5asHbSyWojeIDa4ZzpKRz2tP/04/jF22pJKuyl3PM+k82Lnzbxoj
         wVL/gPUECqoqfhGsF1BYLJLiwdCf6B2xDkPUe8WVqQ+5Y8WyBIh4omuKs2blCWMJ/R2H
         9GGyCc3SpxuuyPcwdNw9z0ixjZSCybjqVyVitnFT+h0eJar3ngzypMHSK+rScIga44uS
         15R+xHI5GTTL8eATzDoi8MvqcjZQMAHWLW7AiknT+3wkrRCSNByU1cr7yTSDq2HSs8Xv
         ae/2VpQsJV4G+ngdHdaLaqNWAlMYGQl3SJzWVhoVhk470mQAB9PQwW7il8VLA7C/41Zv
         tdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781133160; x=1781737960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQLCg81en/xiSDiPUo9OAx2p+vBmXiFBiAm/qA8ZaPM=;
        b=mfcU8KDjvTxKN6qVV5yN1NMLCYCTfLf3k9kt54PNAxvAIHGZF8CA8vhggnLw3RI3cw
         /iKfdrHdnBFDvgxjVlhBrlnoGYkT/U7HPbj29rcL2oVMGSzcCxK0GpbRXsWxkIpJ90sC
         qdoGW1F8E5cWCWqq3kWHuZwxgc7Ghco+XOwvqcmWJr0DJZunxbZN3V8UwOkRdSvBDeAG
         wYkw1FHKmMQOJWgZv9Zt7iapTiZhq/tSzAfbUy4g0PabwBoV6ZfAkVGUSMryMZevCHga
         EFJByUw2dEOA8tWGhH6oSR3rs4hCrz1EtBzpN/vWwgnBZLkv6DcHMdFjNDha2PQwL1Cc
         0d4w==
X-Forwarded-Encrypted: i=1; AFNElJ97lbp097qsCqvLG8AKyuSGjvZsYXkYIt6P/XeGBBhLqVnCAIEefEEZN7q+BroKrVx59ugGbn6veENI3s6OFw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3HdptXXYojHKWNKTx5EdWBZoNlHq41AI5LRI28sYXnvx86pJ5
	iPLlks3MRBaqrnb7eQ/ddQxFqwuM/V6CjPnYNk4V0bEW6zDVin19LYWm
X-Gm-Gg: Acq92OGgzAdidTqwh9vXcMX9rrnrDajzQN6cDxsHtPf1FkHOFZL5lhlGsezoLLD50Im
	k6MgVUeOT80Of61je34B60ZzE58IAF9dqj//AC2YZp5YuniTN1wdvcNTcPsIQJDLj4j6ggJ0gJ0
	0nj+8XZ43Xs7zdKrQru8sJm6DdHJyZkvlLteLu4GR4TpNjr46xymdFjW7ubYdItvJHZK+uR5P1O
	A6LlLEVnyqDCp8uoHOr2SNbeUcB02YypAJ/m3ttyCjg8WdjcPK81XQQqnWaKemMyTwQdqYVnF9f
	s3Gxs+tAHxmIRwMfmmYJE9bHPWDFuQkBY2zDryW4MwgBpQH9tUxavUld4KbTKmVA1brTdIeRIJj
	NpSKVaU7IxfouGa6IYd1Tqwb8MUUfcy6DMDvF37KpIqVIOUhfqngp7DsU53e6L31HmWRjfwAfDd
	Pe0VvCrB3Y5nRwwNWMObPuAIZEt2bo0BzxaN1eeVXGcA2RpYIA6XaEgNg=
X-Received: by 2002:a17:902:c408:b0:2c1:d49c:8396 with SMTP id d9443c01a7336-2c2f20a9792mr985115ad.1.1781133159786;
        Wed, 10 Jun 2026 16:12:39 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609ed97sm276399455ad.41.2026.06.10.16.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:12:39 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:12:37 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next 1/2] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <ainvZQppoc7LfPRs@devvm29614.prn0.facebook.com>
References: <20260610091121.213324-1-rafdog35@gmail.com>
 <20260610091121.213324-2-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610091121.213324-2-rafdog35@gmail.com>

On Wed, Jun 10, 2026 at 09:11:20AM +0000, Raf Dickson wrote:
> All three transports (vmci, virtio, hyperv) call sk_acceptq_added()
> immediately before vsock_enqueue_accept(). Move the call into
> vsock_enqueue_accept() itself so callers cannot forget it and the
> accounting is always consistent.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>
> ---
>  net/vmw_vsock/af_vsock.c                | 1 +
>  net/vmw_vsock/hyperv_transport.c        | 1 -
>  net/vmw_vsock/virtio_transport_common.c | 1 -
>  net/vmw_vsock/vmci_transport.c          | 1 -
>  4 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 2ce1063d4a..73e6416ee9 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -507,6 +507,7 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
>  	sock_hold(connected);
>  	sock_hold(listener);
>  	list_add_tail(&vconnected->accept_queue, &vlistener->accept_queue);
> +	sk_acceptq_added(listener);
>  }
>  EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
>  
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index b3394946b2..0de8148877 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -410,7 +410,6 @@ static void hvs_open_connection(struct vmbus_channel *chan)
>  
>  	if (conn_from_host) {
>  		new->sk_state = TCP_ESTABLISHED;
> -		sk_acceptq_added(sk);
>  
>  		hvs_new->vm_srv_id = *if_type;
>  		hvs_new->host_srv_id = *if_instance;
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index b10666937c..4a39d48db9 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1582,7 +1582,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>  		return ret;
>  	}
>  
> -	sk_acceptq_added(sk);
>  	if (virtio_transport_space_update(child, skb))
>  		child->sk_write_space(child);
>  
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 91516488a7..4ce6660c11 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1109,7 +1109,6 @@ static int vmci_transport_recv_listen(struct sock *sk,
>  	}
>  
>  	vsock_add_pending(sk, pending);
> -	sk_acceptq_added(sk);

It looks like vmci might be an odd duck here, where sk_acceptq_added
actually pairs with vsock_add_pending(), instead of
vsock_enqueue_accept()...

For example, if the pending work timer below fires, vsock_pending_work()
will see vsock_is_pending() is true, and then hit sk_acceptq_removed()
and underflow the zero backlog counter?

Best,
Bobby
