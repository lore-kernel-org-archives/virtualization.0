Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCF9368D72
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275853; cv=none; b=c899j7sfAJV5ImEgwQGodkpTM6fhqwvygEZ1Oxwsz7wEI8oM+IX7NwOFjmC5e07urwJ/EVjTE2ztRAOmzsXlSIX/FKwMYJWtCwgO6cYupVFzjYSeggc09G1af08Ya8x/jvNkZzdoE94pbar+YU0iWcseG+ckk5G4wPeopMAeeE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275853; c=relaxed/simple;
	bh=kWlqJdzwUmprV1aSxqcZKGIM8ovHj3K8M8iLohg+Xpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOw4M5JCl6lh1ZUGug23e2uylacGrq1DKfJvRdviz9fboHrYoVUE6P1g2J+YS7XgLkDJc1rN7mymh0pEpK7OU7FMGxKJPhvSPnDI7ZVeWTJmvHwUwk7f+G25+EXiRjgLResa7hjqvvAE0ppaJiPMEpy76uAj/NivwcqY9bvk8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoYCQpjQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoYCQpjQ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf2247e38eso10125105ad.3
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275849; x=1781880649; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w241YD07yboAYZVQiGTMi7+NJEDMiJb3z/8kHuKGMKE=;
        b=qoYCQpjQ6zTb59/ogXQFSk+PZG/b+fXRcYD2BAjf8LzBK70Dsu/8ybAEIDJb4jeyik
         TUxC8ScV9bc5rzwgX+pP6LYRxfh4fvCxKGI+MM52j/PCJQunHcAHBFAwAIN15SEkWjZN
         vkBqiQ1i1fE40jOlaFJZ3QDvyvfYSf+PkVi2pI8XXhFwIlIwZPdfHXcnkZ7InGPp883L
         1BmP9X1WVk4O4f6yUkywxOouO8W109sa7QypbxckwfFkaKzNdvhzKykazE5z4ukQhHGN
         f5zy5tJmJRJeG2MgvGn2VmZQPB8cTcNFVtiOU4b0DjlhpGs1p29pggifztNBGxLLgi45
         +VlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275849; x=1781880649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w241YD07yboAYZVQiGTMi7+NJEDMiJb3z/8kHuKGMKE=;
        b=PCqF8Xv2t0UmZmfo/v1xIo+Fr3MqWqlImZ7APRIYYm/y6GWt2+uQDBn6Q9/MzUdFyt
         kSn+K1HFyaSNhyzPBOJoQNE8dYIxBsdEpVn4MQySMbQmJmuoMysRH8fnibygIDvUJz+Q
         jZXdgkmadQ1T/OqSkmu1yyqa36gaZLfX/S6+WUmTt3DSeEiJzrWzuPdt8Uwlc7sTjdeo
         ZKsU/iOmRv7MSOF0+bvIq/Sgx/aNnQ0I1VbaMzSJi4g+BJSHFURuGA3u9RK6Bzu5G0Sl
         r+mkEcdXTShrHsv4sS9+6S3UGgkIL9QXZkDskLL++DaEiISHD7M9X6iPjXUap2oV9q3t
         FN5g==
X-Forwarded-Encrypted: i=1; AFNElJ91MUHjicv468S/CzufuDWhBZ0v1DoFERqSFa87nDR7vrSDya4StvNLEm1jx9emp8iu2X1Y533Odu2KYlTWOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjBR+rjON2jAhFbT/vL8Wz/6Z6pQnJ9ZHfsyfHxPUCZ0LKxlKH
	qiGWicncvdLuHjVtKFD5QsT9VvK39yH+YGIgnz2kCB8IZdwvfrJdxx+4RAoiJjrO
X-Gm-Gg: Acq92OFHlpbxe0gy3DSYcUBdhmey+3xR8kbIvd3SAjkmyPtH3We1Wu4A7bEM/rHDiUw
	NkmyVf1b0m4kn2ffuAjmBwBOY97sNqCbMX+t5nf1PEjUsZkh2YNFqtkKjIMusFt0GAJ43Q10btm
	c08auc0H9hFQgy50pjgZ2p2S1xfD3vQbwxuVtoq5vi10diyWZcs/eov5RaVKie4foPCgH3NIosz
	TB8aWw2XshFrKHfst2YkjteQhcOCu7qvXGEmkcwjV25CDSpgsZ6vTyeuaDDa03NNlq14GjrMD66
	VIh/0z/L0u2LH1M+z2q8GyZ8hQ9gPZM5oDzjn/Uh/vJKyNJT2YNmOoKZLW7dUxzhFEdb67AyhAW
	W11bMb1d6L+M5VjR3qGqs/n02csfo3cmpJdF95CnRkoBsV51aoH75YWYjaOvq1JkVAuvsAn3QE3
	j3AofSFodPBnbQJYuBzI00/nHia+vyPAGXQMcqsqADkg2P
X-Received: by 2002:a17:902:e742:b0:2c2:4ce4:c5d4 with SMTP id d9443c01a7336-2c41235e5cbmr40486225ad.17.1781275849291;
        Fri, 12 Jun 2026 07:50:49 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:5d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm25637165ad.38.2026.06.12.07.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:50:48 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:50:44 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, leonardi@redhat.com,
	horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 1/4] vsock: introduce
 vsock_pending_to_accept() helper
Message-ID: <aiwcxOVDB8Vc2RAA@devvm29614.prn0.facebook.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-2-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-2-rafdog35@gmail.com>

On Fri, Jun 12, 2026 at 04:52:13AM +0000, Raf Dickson wrote:
> Add vsock_pending_to_accept() to move a socket directly from the
> pending list to the accept queue in a single operation, avoiding
> the sock_put/sock_hold dance and the sk_acceptq_removed()/
> sk_acceptq_added() pair that would otherwise be needed when
> calling vsock_remove_pending() followed by vsock_enqueue_accept().
> 
> Use it in vmci_transport_recv_connecting_server() where a completed
> handshake transitions the socket from pending to accept queue.
> 
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>
> ---
>  include/net/af_vsock.h         |  1 +
>  net/vmw_vsock/af_vsock.c       | 10 ++++++++++
>  net/vmw_vsock/vmci_transport.c |  3 +--
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 4e40063ada..30046a3c20 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -220,6 +220,7 @@ static inline bool __vsock_in_connected_table(struct vsock_sock *vsk)
>  void vsock_add_pending(struct sock *listener, struct sock *pending);
>  void vsock_remove_pending(struct sock *listener, struct sock *pending);
>  void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
> +void vsock_pending_to_accept(struct sock *listener, struct sock *pending);
>  void vsock_insert_connected(struct vsock_sock *vsk);
>  void vsock_remove_bound(struct vsock_sock *vsk);
>  void vsock_remove_connected(struct vsock_sock *vsk);
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 2ce1063d4a..1f94f0d44c 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -496,6 +496,16 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
>  }
>  EXPORT_SYMBOL_GPL(vsock_remove_pending);
>  
> +void vsock_pending_to_accept(struct sock *listener, struct sock *pending)
> +{
> +	struct vsock_sock *vpending = vsock_sk(pending);
> +	struct vsock_sock *vlistener = vsock_sk(listener);
> +
> +	list_del_init(&vpending->pending_links);
> +	list_add_tail(&vpending->accept_queue, &vlistener->accept_queue);
> +}
> +EXPORT_SYMBOL_GPL(vsock_pending_to_accept);
> +
>  void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
>  {
>  	struct vsock_sock *vlistener;
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 91516488a7..635ebf9da4 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1258,8 +1258,7 @@ vmci_transport_recv_connecting_server(struct sock *listener,
>  	 * listener's pending list to the accept queue so callers of accept()
>  	 * can find it.
>  	 */
> -	vsock_remove_pending(listener, pending);
> -	vsock_enqueue_accept(listener, pending);
> +	vsock_pending_to_accept(listener, pending);
>  
>  	/* Callers of accept() will be waiting on the listening socket, not
>  	 * the pending socket.
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
