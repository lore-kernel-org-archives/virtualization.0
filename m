Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D555228850E
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275894; cv=none; b=WQr46+ssRio+qwUznNxqGzaWI7LdZGDzCJFf0kIVlL4jeZU2rJ/ekBEJ2BU/kvKvDWvg/PIUgQSuUEq/LBl3wr8aefDAYlrhWrtMJXTY7kf9YsIitxEwoTG13DcvmiO06sa5CX5jv1rsgF2ixsocAGKU9cBtnBr56R7A/0QYClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275894; c=relaxed/simple;
	bh=7oTdwQB7busn3pIYd7uITFnQgXBQs1X1Bba/eQqqVE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKpsxyS/NKsHG9hP+ZthF4gNyEegjJsGrhy7cOvCMevCrY5yKXinAx8bB5bWM58T0Twk1LrU3KluJZcnkKl33RX9DMEXGlJP9caZmwm6HFdgDqdlEfu91n6FYenkzv7eMdS3+J6tjT0HKiw2maFaG29ChgKrr00WXRwX9b54KbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpvJzHCy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpvJzHCy"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so800198a91.1
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275893; x=1781880693; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vFB+L8FiAJWrQfjsmsxH8l7zj4U3yueBuDW7xXAiJHQ=;
        b=bpvJzHCyyxKoc3dYoTs6xg2GgUXAkFL+tyq8rn2leEFmFgdknvVZDEN0/6Sr9RviwI
         txfErBZCM//tVQQHfstOdfEA8GWgKW52ELP6E48HzOHoTeJjuSmgkILnELMAAKFumTHY
         OBf4ksoFJy9d3rGrXyIZhrh5vyHTkz+mdf0hfSyiSyExK6VI17O7JjkIg3Vrpzkt2f8x
         Il2s/fcoc7vE0WAt6u82dZhnrpw1iJ4Ogyyo/Jgk9MBFII+MnU7QeZfNx6PHBPLN4qE7
         1czgh/zgmzh1jZQshT3EjSvuysBNn7bWtT5RbW+Mth5itKuborQ7mBXKU5UX5RJWgvpy
         vSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275893; x=1781880693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFB+L8FiAJWrQfjsmsxH8l7zj4U3yueBuDW7xXAiJHQ=;
        b=L/AUB4qFinScYDWRE0RLPsuP4+p070X+9mP6WB6aJzz8OgXot6AO24iDl2NzH8pK8h
         lN4zqvxbq3Ykm/D3QJic1pjGE6ohDr0qiHjyol/kUZUHnpDiKwNY1ZpyrOl9Fu6JzU2S
         MBzuB8MD8GgWQNIo7xE4F7ivN02EF5vFuj25ljdw+cyhXvd2oYjt1ljpbvs7K8lzQ3Uf
         OBupFpE0HN3GOsGHAYffjI5i4xoihF0nXXJ519Wa2jfdRaff+DjlEiPUi/ovxxOSVPYn
         uLOdLRqyk9LuoP6guxjcsocQWCO3OqDmwf2CDFUi6t6+4rh2Pk/mwZM1oM9AYb6ATC3c
         PgsA==
X-Forwarded-Encrypted: i=1; AFNElJ+3DpDZn1Yfr9hckMPAJL+jkFVhQztTx//897opyIp+kZymmT27ckA34ri9VI0rSIQzH+TInqA5GgeCBJObvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDQn1nD3CHViedtaaALev9a41fpj+eoEWI5+xy0Z+MSUnMRSid
	/nYZhWQ3bNMIqjuBsdYsJVzaKp6t4HaxXgZD1CE9+HlopOu/jDwdz4fN
X-Gm-Gg: Acq92OG/LT5ATbH2kxqXD7JvLOSNZ4Fd/8iDEipO9UEcvpozNJjlWUgcUdzwJDoE0f+
	EdTo3FPLEBCfFczTijrFv9WJputsy8wdwa7iJ7sjjzIcYA6OefjBycg43MfCy8vdT8XJLSKQ75M
	W+XkS0bx9dOiXXDNFZ3nhjd2vuRpQtbVkH4+L+kVH9HgOAxudt8h0VzsYczjZl1aPBimtZ1S0Rf
	2/2yK+PGMDTrv4q4m150BnZ6uxrfx5yEmRp/XmvTLTeK0za5mKH5tN6LYhQb3O973iXg2osZeR/
	g0jB5K3inobcLy5mYjWkaJDlZc7XPuAsc+5mQrvMeuHK3sp81Tb+AHc4ZjZYl3gifMNoCNgQut4
	fbybDnYGZW3cTi8I3ievKfslkidf0xFFtsD0iyRmTkelt9x+hhX7GiA25SGz+lZ28nx4k6r9xEO
	Bwp1aI+f6vciFa0DN0/wcu40aV6L2X6p3sO4v27TIaTJWn
X-Received: by 2002:a17:90b:4d08:b0:368:b01c:85a0 with SMTP id 98e67ed59e1d1-37a035ed628mr3288310a91.14.1781275893159;
        Fri, 12 Jun 2026 07:51:33 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a20dbd301sm2453885a91.10.2026.06.12.07.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:51:32 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:51:31 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, leonardi@redhat.com,
	horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 3/4] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <aiwc87mKwAWu2eJS@devvm29614.prn0.facebook.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-4-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-4-rafdog35@gmail.com>

On Fri, Jun 12, 2026 at 04:52:15AM +0000, Raf Dickson wrote:
> virtio and hyperv call sk_acceptq_added() immediately before
> vsock_enqueue_accept(). Move the call into vsock_enqueue_accept()
> itself so callers cannot forget it and the accounting is consistent.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>
> ---
>  net/vmw_vsock/af_vsock.c                | 1 +
>  net/vmw_vsock/hyperv_transport.c        | 1 -
>  net/vmw_vsock/virtio_transport_common.c | 1 -
>  3 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 6cfa89b6f3..24916dd4e9 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -518,6 +518,7 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
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
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
