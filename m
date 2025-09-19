Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A3F2C0F8A
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266751; cv=none; b=HmMpKhunnKI0eUIiRz4xxh6fuwEM1B2xWg4JkwD9lVQHiy82vuH8nxT+lbJto1ZiX4xI6CmAuzKPXhpJ83u4P7UG1bCwtg2up1kB0QtqVM6nW3nEhjuxebaEN6WkNFgnDzHYtTEWglUoneeSxVHTjdLqfLjdZkIy0TyjxqJm3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266751; c=relaxed/simple;
	bh=zkVkIoUOl03T+4kpYux31FAUF2pWUEphOE/XLbf//wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCrEHDRedvDy+AHswwjysKzpvQYrvLry//5AUPpsBeEsStDG63qSQfdsEVmA18U0RiMXt+iJGiBj54TOHABer5y3W/ukqib3dCra5yhZ11QLzspOqYJkq/JJ9+ZDC0frHH8rnLoLgV3iK+WiKQb6kcurSTjFfADJU8F8BPJDf0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RN/3JCKb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RN/3JCKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758266748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bM94/nnEI8nwvokemjQlvg6Nu4kwWN6AkIyeAjLPwg=;
	b=RN/3JCKb53JKrFCsRwdN9UkusZ6GyzimH3eVW64lxF+o/iwrbygBPTgGGXtCj3R4tGSpyB
	Fqkk2iL4P1BqdM0LuJTL5gyyIlFSLNpB70Av6k+GxEcZAOSFPRP8o8LbsnGEBK/KrCotRB
	EtNqa7cKXaRBttJUvBSTh9ddZarH6qk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-dRKgrFL_OTetrUR_CRuWEg-1; Fri, 19 Sep 2025 03:25:45 -0400
X-MC-Unique: dRKgrFL_OTetrUR_CRuWEg-1
X-Mimecast-MFC-AGG-ID: dRKgrFL_OTetrUR_CRuWEg_1758266744
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329c76f70cbso1558062a91.0
        for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 00:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758266744; x=1758871544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bM94/nnEI8nwvokemjQlvg6Nu4kwWN6AkIyeAjLPwg=;
        b=RFViExibU8tmxQyQM5YnwIWvAB8qp3/mBd+nMt0GmTXeKfCONoWTFK/UeUW4zF5INC
         8WPSwIP+LzigzAwLEGUCxlh/GGWdPEEGsK0byVNFpbSkNvgNwnGArRCSN48LPVPpNViC
         K88/6sScg6u9MSqlu3fsb3X7Vq0zRyGUy7ypQZipEST77SB9sFYo/3fPfrQoq2TOTJKV
         gVzXSm85EawRcqxfrTVqZsrE5nNVC0g/Kk34OXyqNs9hyNK5CdbL91LJZY0YqRexwm8q
         q7WzJz+kOWVkXKCohF0jr2PnPjuYiINJBRK0FbVV4qlKYl+sV89L1I0I9EyV+2i/ssPA
         u6BA==
X-Forwarded-Encrypted: i=1; AJvYcCVSLjzfKlK2KW0ex9gdxStEiKw2ERvDUMSjC0qCjuFG4hbK5Ie1r+yLkQIIVxo/5gn0TNGX98CJpOcZNswkbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFJZc9k53rdvvZHHhNrQHojz+DVP1DWOTgqayYEhpsxg05lQbQ
	mDXn7ZXbuY4TuCEBcp/beKcrwU9eoziaD8QMs4Y5+Ob+UU4zwW1GOt/BPBF09PHnOywIvTu7wfM
	FlXvkUxGbSgm68eQLaHhievbkr/U6Y3T6oDoznwu9tUPWqEEcdF5WAzg1I8vumkuQVLgJZmV+I/
	1ZKWdhZvo+noiP+1eqrwJc8Mh/M0wspu2yisNBYYWfrkg=
X-Gm-Gg: ASbGnctQAWO1Sm8R9BduwhXqilr4c2z13qd3gOvgJ2IjP6GNYjBd3wUwZPr86zsplcI
	VL/XGJTroD5fyLKulRSkDCUSYDoJEqOsYctqMW5RrSO5OIIh+yPjyTH68YYzbWbQOOJkEB/sQcN
	qxub4wtEqftTrRmEW1PbJJBA==
X-Received: by 2002:a17:90b:4d:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-3309838e07dmr3146555a91.33.1758266744224;
        Fri, 19 Sep 2025 00:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHioX/aUb/kf3X7YbtUfx1ZTiAhYMo4GyJt6XgUNBRLxjMQjBMLN0ziU1pYTAvo5cwkJNciXxXsSL6B3HEhWEE=
X-Received: by 2002:a17:90b:4d:b0:321:9366:5865 with SMTP id
 98e67ed59e1d1-3309838e07dmr3146523a91.33.1758266743790; Fri, 19 Sep 2025
 00:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250917063045.2042-1-jasowang@redhat.com> <20250918105037-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250918105037-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Sep 2025 15:25:32 +0800
X-Gm-Features: AS18NWCuouHf_lzYXemPvsvzosa6Qbb26dhl00LIb1AvW_Yc0kDUxptSh5xarsQ
Message-ID: <CACGkMEsUb0sXqt8yRwnNfhgmqWKm1nkMNYfgxSgz-5CtE3CSUA@mail.gmail.com>
Subject: Re: [PATCH vhost 1/3] vhost-net: unbreak busy polling
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, 
	jon@nutanix.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W7eiRxg_MqCezExrdzS6pzBNFjTbGEiPmOZSCxGnGwU_1758266744
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Sep 17, 2025 at 02:30:43PM +0800, Jason Wang wrote:
> > Commit 67a873df0c41 ("vhost: basic in order support") pass the number
> > of used elem to vhost_net_rx_peek_head_len() to make sure it can
> > signal the used correctly before trying to do busy polling. But it
> > forgets to clear the count, this would cause the count run out of sync
> > with handle_rx() and break the busy polling.
> >
> > Fixing this by passing the pointer of the count and clearing it after
> > the signaling the used.
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 67a873df0c41 ("vhost: basic in order support")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> I queued this but no promises this gets into this release - depending
> on whether there is another rc or no. I had the console revert which
> I wanted in this release and don't want it to be held up.
>

I see.

> for the future, I expect either a cover letter explaining
> what unites the patchset, or just separate patches.

Ok.

Thanks

>
> > ---
> >  drivers/vhost/net.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index c6508fe0d5c8..16e39f3ab956 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtque=
ue *rvq, struct sock *sk)
> >  }
> >
> >  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct so=
ck *sk,
> > -                                   bool *busyloop_intr, unsigned int c=
ount)
> > +                                   bool *busyloop_intr, unsigned int *=
count)
> >  {
> >       struct vhost_net_virtqueue *rnvq =3D &net->vqs[VHOST_NET_VQ_RX];
> >       struct vhost_net_virtqueue *tnvq =3D &net->vqs[VHOST_NET_VQ_TX];
> > @@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhos=
t_net *net, struct sock *sk,
> >
> >       if (!len && rvq->busyloop_timeout) {
> >               /* Flush batched heads first */
> > -             vhost_net_signal_used(rnvq, count);
> > +             vhost_net_signal_used(rnvq, *count);
> > +             *count =3D 0;
> >               /* Both tx vq and rx socket were polled here */
> >               vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
> >
> > @@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
> >
> >       do {
> >               sock_len =3D vhost_net_rx_peek_head_len(net, sock->sk,
> > -                                                   &busyloop_intr, cou=
nt);
> > +                                                   &busyloop_intr, &co=
unt);
> >               if (!sock_len)
> >                       break;
> >               sock_len +=3D sock_hlen;
> > --
> > 2.34.1
>

