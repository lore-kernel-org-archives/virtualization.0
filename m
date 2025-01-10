Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E421C9FA
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549325; cv=none; b=EDaxxzibBC1PQIQHIBohf5IwXYBOzHtCcX6jeN76ZjYUPhyBqarwArTV77Lkys6v0QjiEaSnlLF1Vp6Ax5+4b9jTQ19ClFDiI+vtwKwIghLV5jcw06GVYOtGd9MfnGkV4gAvfpGJciJazYk0O9Xx73ml4CUdFK/9ptPNc3qpyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549325; c=relaxed/simple;
	bh=AWn3AuB7yHOLd4iesrrxgcRSmxPBHT0ef3tOlCuWqWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqohlw+BPqJCKlmiSoaq4InVy06v9suKNGIdUznLVH55Q3rUELQT3tdvKm28JXaQHX3EGwMXm1q14lvLeN9S1TT8B60di5+2zR0jF/7xuWdf6ejHJdOy2yhV6k2vKSFCFLwr+nkVVklFrfXvD/j+X4NB76E2kYahiAsb+wpR1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=UlClgLzT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="UlClgLzT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216426b0865so43564185ad.0
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 14:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1736549323; x=1737154123; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LzXivbWavWl+dN7CMkxVZypF4oLVVAvtUtJdUE5p7A0=;
        b=UlClgLzTpWQaJT6mQX0XPzvxAySO75Rv4/iIFuwzQD0XEfxJgcdn5iEH9d+BGe8HKk
         26X/frX/1W7g+/X6DworzXhTRJhSK4Pg5ZxzaHOajWhpaWplp44cM/e7MAhH9qliD17b
         Q/UHeDLFDkyd6MimSDlNld5rh32QdcwsUGsOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549323; x=1737154123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzXivbWavWl+dN7CMkxVZypF4oLVVAvtUtJdUE5p7A0=;
        b=u/yW8Ih1oLb3luK84OGgsHoZ6Kh9yg5bvyciFO9VRP1N0bwHmwW2jRHBfELL6UetiG
         FqiFkYJ22s6W8sNUoyPtuEmlURGcaadTL6NFyXWzPXXAS50yIIXtQcKeJRTlmfBxJDF9
         df/2mjVWCNrA6dqpm7CpxACiUk42/S+q3cmTyebTABdeGx+HstHwApf8FSLnSHw7xBAa
         dC0CufIQvaXyI+hlvTDrTOdxRZsTzEuJV1LOsAN11As7eknEJorwjEZh3/HWq8Lmu/1L
         mpDsEzPVs7MSiLMOpLZhSw/7OqUzODx0xWcLZWteeqwZw+L707erTLt/Jkk4RNLzdfDU
         6MCA==
X-Forwarded-Encrypted: i=1; AJvYcCWLDfZ2EwGIONK48MrFAdSNFECj2hS15B9WRL6DxqwVKH/gl8ja626xeKqa4L/5VA4lecVctiicX6dWTb8xtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZ+t571Y2dLcqs+zjPITNp686N6pbXi5vGERBKoNZN2aelDw2P
	Xrqv0ynCgbvtWknq+S1t+ZyhNsKX/N6k8G8AbxnaEWvTaJ5il40DFvFHAaynFfg=
X-Gm-Gg: ASbGncvZwTSFIl7hpxq2QTWRxaLxZgQwM2aKDMNV2vJtAASJursMCqfjcnMtbSjzrmg
	6xOuDl1MiTkSsK9TDKyWMx4tSOXvXW+Z3I9iNtwQ6aTSPQZzrk0R7L5QyOFjcRN8MbzPUj16Iym
	sXa9uPrEP604hYKTS53C5BkkrZ50NYMqbPZKoyMndCy5rJjglnG9xu0eLuq+jees0lyANbLn2Jd
	8Ul+EnDLKMiVEK2MEBv+wFii8gZeaCYCesKznh+hgqlfjh4Rmi0Xl0luCFTqeGZ+3bkYA==
X-Google-Smtp-Source: AGHT+IFL3U05bezNqg95x2HmYQVnB18znOwGddscITDSjOdMEJTGA2bZLmFShcBBgvVENgRqTIzeYw==
X-Received: by 2002:a05:6a20:a10c:b0:1db:ec0f:5cf4 with SMTP id adf61e73a8af0-1e88d0d9c40mr20159487637.39.1736549323168;
        Fri, 10 Jan 2025 14:48:43 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4068178csm2065630b3a.148.2025.01.10.14.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:48:42 -0800 (PST)
Date: Fri, 10 Jan 2025 17:48:35 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wongi Lee <qwerty@theori.io>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	stable@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [PATCH net v2 3/5] vsock/virtio: cancel close work in the
 destructor
Message-ID: <Z4Gjw6QMqnUsQUIw@v4bel-B760M-AORUS-ELITE-AX>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-4-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110083511.30419-4-sgarzare@redhat.com>

On Fri, Jan 10, 2025 at 09:35:09AM +0100, Stefano Garzarella wrote:
> During virtio_transport_release() we can schedule a delayed work to
> perform the closing of the socket before destruction.
> 
> The destructor is called either when the socket is really destroyed
> (reference counter to zero), or it can also be called when we are
> de-assigning the transport.
> 
> In the former case, we are sure the delayed work has completed, because
> it holds a reference until it completes, so the destructor will
> definitely be called after the delayed work is finished.
> But in the latter case, the destructor is called by AF_VSOCK core, just
> after the release(), so there may still be delayed work scheduled.
> 
> Refactor the code, moving the code to delete the close work already in
> the do_close() to a new function. Invoke it during destruction to make
> sure we don't leave any pending work.
> 
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Cc: stable@vger.kernel.org
> Reported-by: Hyunwoo Kim <v4bel@theori.io>
> Closes: https://lore.kernel.org/netdev/Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX/
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 51a494b69be8..7f7de6d88096 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -26,6 +26,9 @@
>  /* Threshold for detecting small packets to copy */
>  #define GOOD_COPY_LEN  128
>  
> +static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> +					       bool cancel_timeout);
> +
>  static const struct virtio_transport *
>  virtio_transport_get_ops(struct vsock_sock *vsk)
>  {
> @@ -1109,6 +1112,8 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
>  {
>  	struct virtio_vsock_sock *vvs = vsk->trans;
>  
> +	virtio_transport_cancel_close_work(vsk, true);
> +
>  	kfree(vvs);
>  	vsk->trans = NULL;
>  }
> @@ -1204,17 +1209,11 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
>  	}
>  }
>  
> -static void virtio_transport_do_close(struct vsock_sock *vsk,
> -				      bool cancel_timeout)
> +static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> +					       bool cancel_timeout)
>  {
>  	struct sock *sk = sk_vsock(vsk);
>  
> -	sock_set_flag(sk, SOCK_DONE);
> -	vsk->peer_shutdown = SHUTDOWN_MASK;
> -	if (vsock_stream_has_data(vsk) <= 0)
> -		sk->sk_state = TCP_CLOSING;
> -	sk->sk_state_change(sk);
> -
>  	if (vsk->close_work_scheduled &&
>  	    (!cancel_timeout || cancel_delayed_work(&vsk->close_work))) {
>  		vsk->close_work_scheduled = false;
> @@ -1226,6 +1225,20 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
>  	}
>  }
>  
> +static void virtio_transport_do_close(struct vsock_sock *vsk,
> +				      bool cancel_timeout)
> +{
> +	struct sock *sk = sk_vsock(vsk);
> +
> +	sock_set_flag(sk, SOCK_DONE);
> +	vsk->peer_shutdown = SHUTDOWN_MASK;
> +	if (vsock_stream_has_data(vsk) <= 0)
> +		sk->sk_state = TCP_CLOSING;
> +	sk->sk_state_change(sk);
> +
> +	virtio_transport_cancel_close_work(vsk, cancel_timeout);
> +}
> +
>  static void virtio_transport_close_timeout(struct work_struct *work)
>  {
>  	struct vsock_sock *vsk =
> -- 
> 2.47.1
> 

The two scenarios I presented have been resolved.

Tested-by: Hyunwoo Kim <v4bel@theori.io>


Regards,
Hyunwoo Kim
