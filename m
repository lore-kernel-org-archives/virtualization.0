Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685155;
	b=ydtzyqxbagm2zIAwS+Q2lcNSbf8tLKt5Wvdiym4f3+gEUpBwkUgxYWDIOb6J55AkbXnu
	 rJziIXzxhIngfLXWmlyy2HfipxIcGwlms9u5ND7AUUFqwLBQIU8PRIczKCzmda9cuGCG0
	 6Ikj4OusWk/uZQGyccUqIf4e3G2+qu3ynyZ3fbK3aou/sxZtTgsPv717GbyYTpnc0TcTH
	 EWyB93vZsHmfwP45PCE3vY0BteQlvqeqgSE/c9mdzRWVcu61vvEUHrkeKAEnMcvovVTWR
	 /jjdoijinoUEkxJkZbrqNdOHKh79oo8zQOwT+YHpn1i7cMIhP/VKDOWhq806fqRe0fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685155;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=LfvcaCnRXo7+ZO7tgrpqUCFteTLmrLXFEjj9APedgl0=;
	b=rYv7y068ZEBZKxru3MhjF8CmdPWT3HFsUQmYIH+PG0ICoPY6+g3eLXDXYFEla/bBlpNO
	 m6YQDRg/TSNCovnxc1qB/xlFw2tBOKr8oDwFZBYiex0l7fjriKopW+h3NqFu6F3ObU8hq
	 1YJZh+oZ6mDuCS5fmsDIbYXVwP3AR1i050QcDNILqYoBbXVg+lDidfiu9QIztS3QKCxp7
	 y7KULB6jrZTVtntMMzF2TkLYBPaBF8NeJH/Fef7Hgp54e9PmdCbYYGeH88vYVYyIUN4Fo
	 tddTHke7zXNYXhoqVJFSSAnRQ3eMa9MZcCZXkx8qbCQGdSpf3cQv60S5mrKV5DceL8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="OXtcCz/x";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A6606A31C
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 09:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B0A6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OXtcCz/x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795685153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfvcaCnRXo7+ZO7tgrpqUCFteTLmrLXFEjj9APedgl0=;
	b=OXtcCz/xtL/b9422aC1yBsKOHRr2LowHI3i7Wc77QoKc0uCGnJymDxi1ulGPrGklYPS5ha
	kjex4lBUDFfhSJ+jyXtEqt5gBtY0RsmNm9YUEfa1AizzdnpMx87Rnp3PSL9HTbPOsBiWKz
	NWfgEIxxu7nw7bKyBwLLRixVdQ1+H5I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-jCaGkj2ANYa6pRr9ag1mUA-1; Thu, 26 Nov 2026 09:25:50 +0000
X-MC-Unique: jCaGkj2ANYa6pRr9ag1mUA-1
X-Mimecast-MFC-AGG-ID: jCaGkj2ANYa6pRr9ag1mUA_1795685149
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb818d8dcfso33771295e9.3
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 01:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685149; x=1796289949;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfvcaCnRXo7+ZO7tgrpqUCFteTLmrLXFEjj9APedgl0=;
        b=uld2niP04HR9IoLqwdrZQOflpYT4rjt6BZoy1wwqTVmpyDBWDdaJqQgVjRPudoPh+L
         mqLo6wvjamAe++6RS8y49wmIqnbIQGP7wqKC+wvxRYQhks171N/Yc+tZtWCLFrTnCqZb
         mTfE2344Y0uRubHEMDssECKFtRVrgdTVmQamUnBeO9QCxzxzVMvY73Vcq6pIFBxTXRc/
         mf1dllRfI3gsYVPon8uOsYLl8cqiiX+mwtCak5pwcFhCISkX0IhSB7GiiuQOlBszzmNj
         C9O2v0cNlUdFhqLtYujwdB4GeO+HW0mwmqolYJMkR7I0Y0rLQXXPuzoKpdJOUfz3uTm2
         VxHw==
X-Forwarded-Encrypted: i=1; AL+hErFu9CrNcIoiZlBHvubcCCcDrsqvXzPai921ZsytIe1UoZRIatuHuLcsZ5uswkGkyOOzgd9BWwSf54olLYVMuw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8FS1D3nX9tDWhvsDP2ODWARV9EgYo5YI1UaLDsQhiK9f5F0cvU
	ao2TJ8riL99YFhgzCrVnYSykI71plStpiZtEZXtI+vxPAfErQJijk72CHbSWjfWL6NjP3iS/8O/
	Ggb0jplnzc0o/XZsYAg0ouy2D+c14fk8LPLJPoPBEBuV2hl2ARuWVhJAYYHOfe/0L8Cgo
X-Gm-Gg: AZFdTZc0gfJdzsgiXUnVtlDPO5pHqAYJFSZ4rK3yp6FtZGyEh0PvTmTTH4c70HvW1UF
	+dfbEWCBTwBIblJj7dt8WuiMhJCXaAwFn7s+DqWAWXk5/vsSFSDjLneFUWoMPORcEXxv05UCnqg
	yPmwTblZ+MfYHDf7eso7boDmpx4CA31J3QygSYpc4SQv/ntKaR3XvBD87DNfV04QXUB/ya39ZmO
	Nng0NuocgGUyfEMsTtN8j5ThXaBcuNPIEgsSoQOHNj6FC2Wj1THiFSykhejK73u5nH6G+J3+EOU
	tUN949j5ud+SGxLE4gC8ZYLlLPFjC6sGkxP7pnHFXHLtBByD0EqqEAAzk+3V2ssaNfRBKXqwe+r
	yM0ZUnPxNHiwrRcCcCZNt6O1pKW9C/E7UUM+GINJ5b4RZWv+ZXdzG+A==
X-Received: by 2002:a05:600c:64c7:b0:4bb:872a:f500 with SMTP id 5b1f17b1804b1-4bb887c2697mr421920745e9.3.1795685149241;
        Thu, 26 Nov 2026 01:25:49 -0800 (PST)
X-Received: by 2002:a05:600c:64c7:b0:4bb:872a:f500 with SMTP id 5b1f17b1804b1-4bb887c2697mr421920085e9.3.1795685148578;
        Thu, 26 Nov 2026 01:25:48 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm41351930f8f.29.2026.11.26.01.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:25:47 -0800 (PST)
Date: Thu, 26 Nov 2026 10:25:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>, Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v2] vsock: only undo SS_CONNECTING when connect()
 fails
Message-ID: <awf5zJTrZcgvdpOi@sgarzare-redhat>
References: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sH3USOSjeFov11N16kI1RDQ_X6XnxYYV1_xHXNh0-ow_1795685149
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2026 at 05:34:09PM -0800, Bobby Eshleman wrote:
> vsock_connect() sleeps with the socket unlocked. Meanwhile the transport
> can complete the handshake, setting sock->state to SS_CONNECTED, and then
> reset the connection, e.g. in vhost_vsock_reset_orphans(),
> virtio_vsock_reset_sock() or vmci_transport_handle_detach(). When
> connect() gets the lock back, it finds sk_err set and moves the socket
> back to SS_UNCONNECTED. Userspace can then connect() the socket again,
> and a connect() to a CID on another transport makes
> vsock_assign_transport() release the transport the socket was connected
> on.
> 
> Only move the socket back to SS_UNCONNECTED if it is still
> SS_CONNECTING. A socket that got connected stays SS_CONNECTED, and
> another connect() fails with -EISCONN.
> 
> Likewise, only move sk_state to TCP_CLOSE if it is still TCP_SYN_SENT.
> Otherwise a second thread blocked in connect() on the same socket can
> time out after the first one failed and called listen(), and overwrite
> TCP_LISTEN.
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Link: 
> https://lore.kernel.org/netdev/20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co/
> Suggested-by: Michal Luczaj <mhal@rbox.co>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Changes in v2:
> - Only reset sk_state if it is still TCP_SYN_SENT, so a concurrent
>   connect() caller that times out late doesn't overwrite TCP_LISTEN
>   (Sashiko).
> - Drop Michal's Reviewed-by since the code changed.
> - Link to v1: https://lore.kernel.org/r/20261116-vsock-connect-close-v1-1-43fb125973dd@meta.com
> ---
>  net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 1d7d53542724..ce958b48295b 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1704,6 +1704,19 @@ static void vsock_connect_timeout(struct work_struct *work)
>  	sock_put(sk);
>  }
>  
> +/* Avoid breaking the socket when another thread has changed its state while
> + * we were asleep.
> + */

Should we make this comment a bit more clear to explain why we are doing 
this?

Something like this (IIUC, please check and correct it)

/* Undo only the state this connect() attempt set. While we slept, the
 * transport may have connected and then reset the socket (it is still in
 * vsock_connected_table, so it must not go back to SS_UNCONNECTED), or
 * another thread may have turned it into a listener.
 */

The rest LGTM!

Thanks,
Stefano

> +static void vsock_connect_close(struct socket *sock)
> +{
> +	struct sock *sk = sock->sk;
> +
> +	if (sk->sk_state == TCP_SYN_SENT)
> +		sk->sk_state = TCP_CLOSE;
> +	if (sock->state == SS_CONNECTING)
> +		sock->state = SS_UNCONNECTED;
> +}
> +
>  static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  			 int addr_len, int flags)
>  {
> @@ -1862,8 +1875,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  			 * sk_state == TCP_SYN_SENT, which hereby we break.
>  			 * In such case VIRTIO_VSOCK_OP_RST will follow.
>  			 */
> -			sk->sk_state = TCP_CLOSE;
> -			sock->state = SS_UNCONNECTED;
> +			vsock_connect_close(sock);
>  
>  			/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>  			 * transport->connect().
> @@ -1877,10 +1889,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  	}
>  
>  	err = sock_error(sk);
> -	if (err) {
> -		sk->sk_state = TCP_CLOSE;
> -		sock->state = SS_UNCONNECTED;
> -	}
> +	if (err)
> +		vsock_connect_close(sock);
>  
>  out_wait:
>  	finish_wait(sk_sleep(sk), &wait);
> 
> ---
> base-commit: 533ec433efdc11196f438da90d683053a57257ff
> change-id: 20261116-vsock-connect-close-1beb7cb51e7a
> 
> Best regards,
> -- 
> Bobby Eshleman <bobbyeshleman@meta.com>
> 

