Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBEB2566DF
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 03:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751860115; cv=none; b=E1vrUdPC3Ie+oQwKlCExop0VDlrIxVwi5uEQqYZiQjR7ibikG/hSfKLpHto7ZnqrklwCOKZmVWrLkEUOUZWDOjTZ4wAkRjA3rMB3QtnCW1Gx88BgHkbycuCZiebcpKNisbqe9/rOJL2wRURCzWi+2k7eZLKF7lH4ABL+Qhjt4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751860115; c=relaxed/simple;
	bh=hUgXGL6XScPWELGspZVQ6oo3NDlNSw5oN4mTr0d1/Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jndrqSOLYIS0BMkWG1ANsgPWSL8pSwGiL1xllRTT1ddxYzo5g8kdwDLkkHjwj2aFPFMjvyfmBXnbqeGXGp5crhMssSKavSkPl1dZeZxEzUTzQY1lCCxN4zW3MnJtPN8lSondYrzf/m1L58M9VlATElIr5cP6qUuj1wqQ22DLzBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUVGZlOg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUVGZlOg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751860113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EW/dDjcSXDhHVRdF+Q/wfrSLxpfj5IbBx6F7oYcVw2A=;
	b=dUVGZlOg9hQTsKlox8JcYsfkZB3+IzMEIxy04zuhC9qQVst9J+VWgRbCvBDUqyOubrPV5r
	wBHNDeZlx3EawRMVmRcclswRvMsMzeYYFQ/2UwnIIZB0pNPKw5t6b5ZrPMjAnZe4TUg0yj
	ulCRHR2KUKSFBobXYbDoTLTIJ3iIxSA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-gpgJiSdoP7irYTklunir9Q-1; Sun, 06 Jul 2025 23:48:29 -0400
X-MC-Unique: gpgJiSdoP7irYTklunir9Q-1
X-Mimecast-MFC-AGG-ID: gpgJiSdoP7irYTklunir9Q_1751860109
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31220ecc586so2446736a91.2
        for <virtualization@lists.linux.dev>; Sun, 06 Jul 2025 20:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751860108; x=1752464908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EW/dDjcSXDhHVRdF+Q/wfrSLxpfj5IbBx6F7oYcVw2A=;
        b=h+GFbIJmAvHTD0whNvu/wjZTG54e2u1vYmIhz8pz6R/xduTaCs6nFTdJQVOYvYc5NW
         TH4D38KaQBLvCg5rWywLNA2MfCXuxIFwAUNU2+SjWOZGWt/GpNc4Vmgus1HVQEc/dEdv
         M65i+SbdA94TNrGdF/hqJZq2hq5sDu4oTnA+6fMWKNZnZT62v93djfuPzKo7+RjKHp+x
         MPyMcAZEctlpHrY2V4A52LoCBxKWsCZTsaOWmWW6qixzIGlnezRzbbZhw5Jhdcnk73OY
         iJS4awGTQuIrCdbFDuMa/cBdHEcFmV3ILymv+8Ve1BbfXj2PGh5LlwBnf2p+urBXiMlW
         U4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVHUZDxF6nXDoJPpJ0BxzDxozqFd0+pfXX9zFuXD22vXPopqw/+rUkXOFuMEQW1/JbNxu+/ioJ8bFcf6QXC/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSg7fOfYeqpECSA4amFJiNnV7+fKVVsVKfzA8wlGYFkcbgkj7O
	Hl3EXlfOHlEPqbZx/fe3kTXZe7wPouEIS4fOtXoo2mznd/QkGdRZ4n3WJ66l9bxvJ9+Cc/TaZKD
	rxlG2ZT+WI6aZ6H07dmK7+HXJhmFCOKwvCV+TyYGEvLwFu+po4xZ2uG/bvZjjCUO/StHoyH27TV
	UpZjkpj+RzKUOTDavjo4HcLUF9N+1R8nv0e3Fpsz0oe4E=
X-Gm-Gg: ASbGnctyfd66MMlK3Ov6uCOA7CbR6Lr7CM+1IrUt5Deu6TH6Yqd44dlKdeEXq/deynH
	oaAymqr3/olK9s0ekJqNtLY0I7y6DUcnOlTCUn3aNytErCrP/y8U0BnrFB0kozpRb9BDclAxgg5
	4cOpkH
X-Received: by 2002:a17:90b:274c:b0:31c:15d9:8ae with SMTP id 98e67ed59e1d1-31c15d9099amr1263946a91.33.1751860108577;
        Sun, 06 Jul 2025 20:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjLb5nG3GcvhfATU5YJqipasKEl1n2CvdNYfWsQeu5NtxG78x5LGLp605MHradsamcw9tKsvLkrHk8wmRzWvI=
X-Received: by 2002:a17:90b:274c:b0:31c:15d9:8ae with SMTP id
 98e67ed59e1d1-31c15d9099amr1263906a91.33.1751860108149; Sun, 06 Jul 2025
 20:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250706141150.25344-1-minhquangbui99@gmail.com>
In-Reply-To: <20250706141150.25344-1-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Jul 2025 11:48:16 +0800
X-Gm-Features: Ac12FXxSGGJmrV5EcaTZUCctsvVfb41fa-ZbkWFbatrKcNL0Fp0w8Ch0gj5Rdr8
Message-ID: <CACGkMEvCZ1D7k+=V-Ta9hXpdW4ofnbXfQ4JcADXabC13CA884A@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix received length check in big packets
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N2zTAmxbHIrJPBN5H8pUmhQNiSbgPWXmDoiU6G8XGZA_1751860109
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 10:12=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> for big packets"), the allocated size for big packets is not
> MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> number of allocated frags for big packets is stored in
> vi->big_packets_num_skbfrags. This commit fixes the received length
> check corresponding to that change. The current incorrect check can lead
> to NULL page pointer dereference in the below while loop when erroneous
> length is received.
>
> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big p=
ackets")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5d674eb9a0f2..ead1cd2fb8af 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>  {
>         struct sk_buff *skb;
>         struct virtio_net_common_hdr *hdr;
> -       unsigned int copy, hdr_len, hdr_padded_len;
> +       unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>         struct page *page_to_free =3D NULL;
>         int tailroom, shinfo_size;
>         char *p, *hdr_p, *buf;
> @@ -887,12 +887,16 @@ static struct sk_buff *page_to_skb(struct virtnet_i=
nfo *vi,
>          * tries to receive more than is possible. This is usually
>          * the case of a broken device.
>          */
> -       if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> +       BUG_ON(offset >=3D PAGE_SIZE);
> +       max_remaining_len =3D (unsigned int)PAGE_SIZE - offset;
> +       max_remaining_len +=3D vi->big_packets_num_skbfrags * PAGE_SIZE;
> +       if (unlikely(len > max_remaining_len)) {
>                 net_dbg_ratelimited("%s: too much data\n", skb->dev->name=
);
>                 dev_kfree_skb(skb);
> +               give_pages(rq, page);

Should this be an independent fix?

>                 return NULL;
>         }
> -       BUG_ON(offset >=3D PAGE_SIZE);
> +
>         while (len) {
>                 unsigned int frag_size =3D min((unsigned)PAGE_SIZE - offs=
et, len);
>                 skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, off=
set,
> --
> 2.43.0
>

Thanks

