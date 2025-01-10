Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C44217705
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549177; cv=none; b=ZlC0mTj880DqFph7r7+1yex58otDjFtnOYefKjP9iM+0VjT3Zv6pd3Wf1UxkG5sGKHrwuuDfjpgZ4MxdJCY0ffABshZ+eKd/rpX9D/EUBNFDmmngpGxlTEhIIsgir0fh4zzsaak5yC+8iUI+CxJ3n088C4OWzzYP8XBr+0PqDvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549177; c=relaxed/simple;
	bh=tPDB/C/Z9ks/FCQETqMvVx7wDQPCoCWowTG9L7TftAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKj70fGvfW2j40bLYjVYkrhC0DYdeWtBRyZM2R0GSrjA63vTDNbp6FHizYhKLDhN14qJQ/mshOrJVSrV5UxkGrYe7ibarhxrNkuIbMAhPniRjzvqsngTp4TI2+9vrClAK/fMSZUoZlOZdl8O/iGRavFodt1mbcYNJ6NnGXtLXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=YjLETP+M; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="YjLETP+M"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2161eb94cceso31858375ad.2
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 14:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1736549175; x=1737153975; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mGseQnrTjR1YJElcRzxoONdDhsvu3Aao281T+3o5lsg=;
        b=YjLETP+MH1zLzjorX1+7R1D0id6Lci+1VXUDHnducIqcWeXEjK1g2cRkVD9c+Wix8g
         CI1irrW520npfgifR7i6TzVHHC67jqGRPcWt1rYJK/mQGvOBFp8UAdjgW34vF5KzXAz8
         SfyeW4wsA8gTppFGHS7ScemJIcCsxNezgzhBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549175; x=1737153975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGseQnrTjR1YJElcRzxoONdDhsvu3Aao281T+3o5lsg=;
        b=fdoh2uTCjmZJClw6/VBK6Xo/PhH95D9DcOPn0uilg/NILdInCjR7OMj9EppLFcMZEC
         y6vti/5fZAM1G09w7EOxAnUv5H0iQtTYuq70D0pS+BiurSh4e6ZSzbEiQEzQd2X3F5o+
         IcUwjbYsP+EjRo/gUjFDQDN6eFGCx9/zEaG2MQZjmjjJ485WuL9RrhDLuI9fr9CiLv/4
         7WiBrvJD0S1CGzCisHB2f6YzMqzHIjebnNv00YmLeW11dnMlY3LvpP2HcWJrqrGQDZ5I
         JPEHDzxnmvy8WTHY6+WaNoS/EZfnFOPR8kBIhXw3AJCulz/7XI+4xqVZyMsJGjAP4imn
         6ILA==
X-Forwarded-Encrypted: i=1; AJvYcCUXa7WsIqk9bZtNTxgozGyjryqtEZRT7Am9jJ9eSVEr625/flmoPkDTrlAZ/HqmG97ojhQjy522Nr3DlF4yeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgCYMFGf7HrbC+HrFVD5cnT0FjT7NiltNPS81R6RoSDe+zJG42
	RgXZsjNAJToe5IZm1oapFAAATzT++rFqAt1cCeV6ktgHNdUky3zSZ4goNhct8Rc=
X-Gm-Gg: ASbGncu8kJsUi6iMLyM0u+KHm2C9exWz2Ony9fvjr+4wPmRv2OFz5a39sx6x4Akt9z1
	8ghNGYSgeYNH4AuYcvrBL8vqVQzshbdDmdiEA5+xC5g1gUORaC3zEC+D9ggOmzmDfqfuUIz4iET
	4pZv0yM3M5E+U9DvBD3u9r5F6o8A6eaT7vXwtyZqowzzycWvW0p6UTpLLkxFhBnA3cQwIBMVViu
	zVn3X3BYq3VllQrQ/xRjEED0vttx4WcIN88vTUjyJcpqqHlxlthceLD4FQb7oEAh6p1SA==
X-Google-Smtp-Source: AGHT+IHXtYgcYVXlKooOzNrhJ71XOZH467c4tXOeuau5BWKoSSQdakM62UMQxWiX7c5/TI2GCGQ73Q==
X-Received: by 2002:a05:6a21:788f:b0:1e1:a094:f20e with SMTP id adf61e73a8af0-1e88cfa706fmr19490910637.17.1736549175198;
        Fri, 10 Jan 2025 14:46:15 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a319a21afe5sm3279259a12.49.2025.01.10.14.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:46:14 -0800 (PST)
Date: Fri, 10 Jan 2025 17:46:06 -0500
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
Subject: Re: [PATCH net v2 1/5] vsock/virtio: discard packets if the
 transport changes
Message-ID: <Z4GjLqPWJBIRdqME@v4bel-B760M-AORUS-ELITE-AX>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110083511.30419-2-sgarzare@redhat.com>

On Fri, Jan 10, 2025 at 09:35:07AM +0100, Stefano Garzarella wrote:
> If the socket has been de-assigned or assigned to another transport,
> we must discard any packets received because they are not expected
> and would cause issues when we access vsk->transport.
> 
> A possible scenario is described by Hyunwoo Kim in the attached link,
> where after a first connect() interrupted by a signal, and a second
> connect() failed, we can find `vsk->transport` at NULL, leading to a
> NULL pointer dereference.
> 
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Cc: stable@vger.kernel.org
> Reported-by: Hyunwoo Kim <v4bel@theori.io>
> Reported-by: Wongi Lee <qwerty@theori.io>
> Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 9acc13ab3f82..51a494b69be8 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  
>  	lock_sock(sk);
>  
> -	/* Check if sk has been closed before lock_sock */
> -	if (sock_flag(sk, SOCK_DONE)) {
> +	/* Check if sk has been closed or assigned to another transport before
> +	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	 */
> +	if (sock_flag(sk, SOCK_DONE) ||
> +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>  		(void)virtio_transport_reset_no_sock(t, skb);
>  		release_sock(sk);
>  		sock_put(sk);
> -- 
> 2.47.1
> 

Reviewed-by: Hyunwoo Kim <v4bel@theori.io>


Regards,
Hyunwoo Kim
