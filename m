Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923CA1FC109
	for <virtualization@lists.linux.dev>; Thu, 10 Jul 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144260; cv=none; b=acDgUxeJpI/Lu+IICLpu6UHO5nStd+MKMmD0oTi0Cw59XFiMK5KjAmyKvD0K8Br8cmuLW0f0WnWW743NjWeILRDAWMUGtEohn56sn81JIxpWipnbNK03zrn4Siq078IbGCERUGwynKLkCav3TiQex9I/WSi3Falt00MHsRW83eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144260; c=relaxed/simple;
	bh=eT95pxhU8RtV8vghCj7CgQHgVurXwFlZ6cSoxK076RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQgY5x9xj5SvfFDZyqyHXx25hjfacXb8WxL1rwT0cw3L/amvaKoqsrQu0FvoTQVvf1aPV1r16l0UasCjVu9/f7T5jSuocJsFKgx+oTxunVFb0Gl7ybv14eSeo2TbthlpqUiRoHcTl50EyQzZa/cA8kN+EFXIHQTDcGHOa+MiAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1vOlFVJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1vOlFVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752144257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CuYLuo/2Mbdt10kaLMIma7+VZaAp4h5ieIlEmZoMkg=;
	b=N1vOlFVJYJNoZ2wuls9oMYn2YLPvdYkxRqmITIH03uQSy8d6txO2AyHeukh72ftS4y0CMs
	ffBO14oHkI064yuLAqdQmte58oHG3EH5lLNqRzS/Ukz9Oy1olcHhx+7eKZV/dvqSV3qkSL
	8p99EvdNbx5k6YnhBmkTnVrgVlgO0s8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-Tcv7H3vwOUC7YlYLaU6-eQ-1; Thu, 10 Jul 2025 06:44:16 -0400
X-MC-Unique: Tcv7H3vwOUC7YlYLaU6-eQ-1
X-Mimecast-MFC-AGG-ID: Tcv7H3vwOUC7YlYLaU6-eQ_1752144255
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311a6b43ed7so960076a91.1
        for <virtualization@lists.linux.dev>; Thu, 10 Jul 2025 03:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752144255; x=1752749055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CuYLuo/2Mbdt10kaLMIma7+VZaAp4h5ieIlEmZoMkg=;
        b=FA2Dup9IZzpJZsd4aW9pnJPSUBtW3U5bEjlg6xr2hsw7hMUR+uNHWfOkukL3gp5s8K
         g5IjZzuzQNJ/y2TymcuSoq64wsvipndzfaQB4sKbDKNYpkQu/kdlbpjsE9jbMn/uu3Q5
         SjamEjQYLmrCvnwjZj3wv6SHP0kalPQggx5ps83FYRAsD5mYVBEFa9iAXPfVlwYXxL38
         lH9xfttU1lYZn7Ikm4Vy1dIf0MZWJ9ABI5uSv6bE9UZduupkheqUXtI2X5LizE9VpKqX
         FPwC7qArXL4UIEmBvFKAhMfs4+rHoh3CjWOoSQasGlFEqFS7T6B8lXEgEl1Gi+Kg+hme
         AD0A==
X-Forwarded-Encrypted: i=1; AJvYcCUJkcVa0bUNs7g26PfbAKAd03WyRzTYAbEj69JTJ9YjRSRioaWnnQnU9xaCVvSSRSG9/8VrAeVwHnFh4DuiaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjD0fAPDlgLDbvWtTYg3sl7J5965EWc3fnp4OaF9XbtfItObOC
	i21U1SYTJh3tj5xYAvK0kzJUiqh25vDZpRIjmyQkqPqGu8YTT+4mUutyWGzedtF514x9M0tiVXh
	JcSx3glc9GwrViptxkx0f+9BWtDHrKyz05G/5CRYRXTMpSGx9eSTQNDnJubuENPe+yf00ic7D01
	VZiagGFn17dXK7ZrnkHpRgkWY4BPdr9mxJ/WBu4hZ9CnU=
X-Gm-Gg: ASbGnctV+vfKb+di2gcelzfBAL3zskX//ZWWBIXvxJnmBr8UA1WAUHPRemSPRomZfPM
	VR/YMhUiAnMTKOUA5K9WFKa0HLIePsNBWsbNgLYU7PnDVYoG607TWRvzbpZsvh3ZxWJH/3DpYiH
	bqG8PU
X-Received: by 2002:a17:90b:2d8d:b0:314:2bae:97d7 with SMTP id 98e67ed59e1d1-31c3ef8f4d2mr3609361a91.15.1752144255287;
        Thu, 10 Jul 2025 03:44:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFwezNPSDR0OY8bEu9AM3jw2WPYc03gF+OPZi3VVVXopaM3IyuhrTf09fnMSDK2SfqLHqjjnRxLMCIC+bfanw=
X-Received: by 2002:a17:90b:2d8d:b0:314:2bae:97d7 with SMTP id
 98e67ed59e1d1-31c3ef8f4d2mr3609334a91.15.1752144254874; Thu, 10 Jul 2025
 03:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250708144206.95091-1-minhquangbui99@gmail.com> <d808395d-2aad-47a3-a43a-cf2138d1d2b1@redhat.com>
In-Reply-To: <d808395d-2aad-47a3-a43a-cf2138d1d2b1@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Jul 2025 18:44:03 +0800
X-Gm-Features: Ac12FXxPNEYS_Ei4p2IcT1GM3jGceeSfmUh4auJlrYXPw23N2AtGMVltUTswdZo
Message-ID: <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big packets
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Gavin Li <gavinl@nvidia.com>, 
	Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j61s8LnR0RHwmO4p8zC4DXPc7hmeclkivPw_ZjthrSE_1752144255
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 5:57=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/8/25 4:42 PM, Bui Quang Minh wrote:
> > Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> > for big packets"), the allocated size for big packets is not
> > MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> > number of allocated frags for big packets is stored in
> > vi->big_packets_num_skbfrags. This commit fixes the received length
> > check corresponding to that change. The current incorrect check can lea=
d
> > to NULL page pointer dereference in the below while loop when erroneous
> > length is received.
> >
> > Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big=
 packets")
> > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > ---
> > Changes in v2:
> > - Remove incorrect give_pages call
> > ---
> >  drivers/net/virtio_net.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 5d674eb9a0f2..3a7f435c95ae 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_i=
nfo *vi,
> >  {
> >       struct sk_buff *skb;
> >       struct virtio_net_common_hdr *hdr;
> > -     unsigned int copy, hdr_len, hdr_padded_len;
> > +     unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
> >       struct page *page_to_free =3D NULL;
> >       int tailroom, shinfo_size;
> >       char *p, *hdr_p, *buf;
> > @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct virtnet=
_info *vi,
> >        * tries to receive more than is possible. This is usually
> >        * the case of a broken device.
> >        */
> > -     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> > +     BUG_ON(offset >=3D PAGE_SIZE);
>
> Minor nit (not intended to block this patch): since you are touching
> this, you could consider replacing the BUG_ON() with a:
>
>  if (WARN_ON_ONCE()) <goto error path>.

I'm not sure I get this, but using BUG_ON() can help to prevent bugs
from being explored.

Thanks

>
> /P
>

