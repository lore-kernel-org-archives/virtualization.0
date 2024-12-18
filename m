Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6BB35948
	for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531557; cv=none; b=SrJDmW9VYm3I1pOsdWM+lLXt1/o0rG0AN5dOlhLS38FdKoDWXcDYanO/ZURxEzh0c31U1A1275INQknOplhK97+PHD0BJSdiPGstfGgvHPbNyQRh2Xce1hJiqj7RZ5u+Pte3GvQem2K71m6Av/ZVc3A4yVGo+ZvPixIg0YQpk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531557; c=relaxed/simple;
	bh=m/if1K64Zqo21BsmqXSEa9AQciQnbHPatnYQy9qNNZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIHVU6iOFa7WtnIqgw3FOa6yNG/6x5yv9tMNtjvoCxqu8B1dyVA/VaPkSmnObPcyAy1qI++coywAz3qvnBaI9Mdooo5YWP0FHf6vBLLTc+bpGstQIWP32WBr8h6bS7MkFDfWkL30q10q9ba4JaUk66zAjdZxj31hmNbmUawb43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=Ak44wVMd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="Ak44wVMd"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so5897618a91.3
        for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 06:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1734531553; x=1735136353; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hy/mNrslR2WJrjQxNAeuMQbIpeAIFJXQ4+GreAFDCQQ=;
        b=Ak44wVMdLJFLUKtVllhstua9UDkmi6SDmtoXyTrsc3ZYpvwh7/WBC4cIbvpl9l2GmK
         A+XTmLXibR6ReBeFvd59CMjQ06CvohSrEAAn0GWhtj/Kw5MKtYCeWw1wSkUBD7w6K45a
         BLiJvud5oPTkjHz4ZboJHk1ZFZp7ffEQ+sCK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734531553; x=1735136353;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy/mNrslR2WJrjQxNAeuMQbIpeAIFJXQ4+GreAFDCQQ=;
        b=fIG3tU4l5jtnt3NoIidayehm+THivYsTSxHgnsxnsdqqHttZ2jxpMAJnxi2DPV370r
         yYuA0hq46lOgLd+NR8tZ710uM86oKFuTpSrRK8cvMM1FMrc4fWKk2miO06oJa/fvLiz3
         h8DGUMI4WY9MNQh4pX25UVdomVb8syPWkjPQF+tWSfSkMPZEfcWWucVm+B6hVjqdoaBg
         fS5B2vzW56k5X5Zdq7f2b/Ia/v24VJXnuVvU0XI+yQG0jyykO1WdMKV+CPiLNqOt37Zg
         PNhSiB+9wMp7SJm8hCqyDpC9aqOuIDTH/u761I4LJ+NEuZSPF4VCjrmaq4OyBjEWxkv6
         PPng==
X-Forwarded-Encrypted: i=1; AJvYcCUULDCZAFkrnfUN7eq7h076ICz43BLTb6FRdofY8jjvJbSBbJLR7VubFifu95c427+b9MGILc0QeuvESZ8MTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYUYtiNs3QrJi5miMufKbeqWCEnzMbO+XZEEIZievupchTD3OE
	RjyTFuVxlyLFkosTvMMuHYRkaQShuddF4ucqxVt5IJ27bEX51l+FxXBN+7gEr4w=
X-Gm-Gg: ASbGncsllVCKPr16ATl7bm1B239k1W+xDqX6M0ayG7OdvYomAYCXrfDYItSAvoAQPj5
	hOgyToidl+P5ZbQPHDlkwD1iDAkcZKeS8IOxOAFVsIEzSUK1jSnOV9UsM8oJY9ncp3nc2Gs68XI
	4osgpmyDrlj7+dPmr+PjpbSn87mXupRWNCvDVaBPqme/vtob069sipRAlQY2LkZjf7sVgro5bTu
	i+OwsRLOCxP9UdqHdr6/OWGmeFSTEy/BcPtem4pAlM4bWx/k+EX99NOj2n46eau7nJG5Q==
X-Google-Smtp-Source: AGHT+IHxHsok6Ghzv4mG5bbwZxtJBm0KrLBeRj9Z3CAnLKY4I1RLA6A0g7k+LKSbVnlN6L2P3p0loQ==
X-Received: by 2002:a17:90a:e7cb:b0:2ee:aed6:9ec2 with SMTP id 98e67ed59e1d1-2f2e91f10b8mr4828738a91.14.1734531553429;
        Wed, 18 Dec 2024 06:19:13 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2edc3768esm1468228a91.49.2024.12.18.06.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:19:12 -0800 (PST)
Date: Wed, 18 Dec 2024 09:19:08 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	qwerty@theori.io, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
Message-ID: <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
 <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>

On Wed, Dec 18, 2024 at 02:40:49PM +0100, Stefano Garzarella wrote:
> On Wed, Dec 18, 2024 at 07:25:07AM -0500, Hyunwoo Kim wrote:
> > When calling connect to change the CID of a vsock, the loopback
> > worker for the VIRTIO_VSOCK_OP_RST command is invoked.
> > During this process, vsock_stream_has_data() calls
> > vsk->transport->stream_has_data().
> > However, a null-ptr-deref occurs because vsk->transport was set
> > to NULL in vsock_deassign_transport().
> > 
> >                     cpu0                                                      cpu1
> > 
> >                                                               socket(A)
> > 
> >                                                               bind(A, VMADDR_CID_LOCAL)
> >                                                                 vsock_bind()
> > 
> >                                                               listen(A)
> >                                                                 vsock_listen()
> >  socket(B)
> > 
> >  connect(B, VMADDR_CID_LOCAL)
> > 
> >  connect(B, VMADDR_CID_HYPERVISOR)
> >    vsock_connect(B)
> >      lock_sock(sk);
> >      vsock_assign_transport()
> >        virtio_transport_release()
> >          virtio_transport_close()
> >            virtio_transport_shutdown()
> >              virtio_transport_send_pkt_info()
> >                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
> >                  queue_work(vsock_loopback_work)
> >        vsock_deassign_transport()
> >          vsk->transport = NULL;
> >                                                               vsock_loopback_work()
> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
> >                                                                   virtio_transport_recv_connected()
> >                                                                     virtio_transport_reset()
> >                                                                       virtio_transport_send_pkt_info()
> >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
> >                                                                           queue_work(vsock_loopback_work)
> > 
> >                                                               vsock_loopback_work()
> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
> > 								   virtio_transport_recv_disconnecting()
> > 								     virtio_transport_do_close()
> > 								       vsock_stream_has_data()
> > 								         vsk->transport->stream_has_data(vsk);    // null-ptr-deref
> > 
> > To resolve this issue, add a check for vsk->transport, similar to
> > functions like vsock_send_shutdown().
> > 
> > Fixes: fe502c4a38d9 ("vsock: add 'transport' member in the struct vsock_sock")
> > Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> > Signed-off-by: Wongi Lee <qwerty@theori.io>
> > ---
> > net/vmw_vsock/af_vsock.c | 3 +++
> > 1 file changed, 3 insertions(+)
> > 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 5cf8109f672a..a0c008626798 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -870,6 +870,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
> > 
> > s64 vsock_stream_has_data(struct vsock_sock *vsk)
> > {
> > +	if (!vsk->transport)
> > +		return 0;
> > +
> 
> I understand that this alleviates the problem, but IMO it is not the right
> solution. We should understand why we're still processing the packet in the
> context of this socket if it's no longer assigned to the right transport.

Got it. I agree with you.

> 
> Maybe we can try to improve virtio_transport_recv_pkt() and check if the
> vsk->transport is what we expect, I mean something like this (untested):
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 9acc13ab3f82..18b91149a62e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 
>         lock_sock(sk);
> 
> -       /* Check if sk has been closed before lock_sock */
> -       if (sock_flag(sk, SOCK_DONE)) {
> +       /* Check if sk has been closed or assigned to another transport before
> +        * lock_sock
> +        */
> +       if (sock_flag(sk, SOCK_DONE) || vsk->transport != t) {
>                 (void)virtio_transport_reset_no_sock(t, skb);
>                 release_sock(sk);
>                 sock_put(sk);
> 
> BTW I'm not sure it is the best solution, we have to check that we do not
> introduce strange cases, but IMHO we have to solve the problem earlier in
> virtio_transport_recv_pkt().

At least for vsock_loopback.c, this change doesn’t seem to introduce any 
particular issues.

And separately, I think applying the vsock_stream_has_data patch would help 
prevent potential issues that could arise when vsock_stream_has_data is 
called somewhere.

> 
> Thanks,
> Stefano
> 
> > 	return vsk->transport->stream_has_data(vsk);
> > }
> > EXPORT_SYMBOL_GPL(vsock_stream_has_data);
> > -- 
> > 2.34.1
> > 
> 
