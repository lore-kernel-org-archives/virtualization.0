Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21146184E
	for <virtualization@lists.linux.dev>; Thu,  6 Mar 2025 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220118; cv=none; b=DNLDWRVIX0ZpMmJW3oseK/F2mjaTJI6KunQrPgZS/tN0O7KNYCd8QLC2IELSdHvwznSsCRzMOhDIuz+E7z/L3/tPvAkgTlUWYQVq6kJy/7fMsm+b2FemtSCyYSN+8FFHDaDmaDuhHMWU0pJ7SxXiiZuSCBY3a7veojDWp/Ezbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220118; c=relaxed/simple;
	bh=/6IEXb3+kPC8h38g1+n1WPXpZUCUEbiDTLSputptZro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AVQ93FaZBFHrjpdOjohfIBNnGv/KQJGzw7q058lJOzWnkiygS7Xtca2lWpcJlRywlAcDrtt8W0ayVh45nTUI4O0c+ENO1XjxlU7paw3dEaeeAOu2elXAXYxP0USqZ5L2s4o26XYHnutIXi1iQtRTk9gZ6E9UNI2BfBpiiUnIWp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdBMeMom; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdBMeMom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741220116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzkSOfMIvpfEW3kC3MKb1XgIDTgn62WcB2Xn0huNZiQ=;
	b=GdBMeMom3+XwNBvW2fVl/VlYUXVeECuQjJmCYkQ7+w8ZZ9Ud49CnrIA36YjuYb3uGBNWpp
	7NqGRg3w+6HR1nLOoC+J+xGZIm001XdOmfxLa4DtDj71JIyS9vVqtoIJx5XVGsquo7EY/z
	cNBfe9RV6+LrCsvkloQGTSTUOgrbe2o=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-XTkLxjyfPcOKQhS8FtSZtQ-1; Wed, 05 Mar 2025 19:15:14 -0500
X-MC-Unique: XTkLxjyfPcOKQhS8FtSZtQ-1
X-Mimecast-MFC-AGG-ID: XTkLxjyfPcOKQhS8FtSZtQ_1741220114
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22379af38e0so801965ad.2
        for <virtualization@lists.linux.dev>; Wed, 05 Mar 2025 16:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741220113; x=1741824913;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzkSOfMIvpfEW3kC3MKb1XgIDTgn62WcB2Xn0huNZiQ=;
        b=sYCollQ832jXwvLrKHp4qs2X7vb03Mb75vllcAvr75pT3yiLEOcVhtt75x/fyvoOkz
         qtCR6Sfvju7NpX4QHWx/IXZHZpJHlzXYpwKgTvwmpp4eY+qQGLAHQoxC4AoYJz2RRFkR
         T3cs7/OX3gDnXPKqNK7+n/lHxv7GgZNSk09tuXyKozqJ7f/u4aFWnSEsBCjP5hD+H4Zg
         VeyEi4czmKJLXQOvWREC4H50OmMK2bBhqKDx89k0ngXDKU2PjBaYaqpJKDi1/aJQbEVw
         lVllziH94WCmoUyEUaoCzEftXOyU5bVNzI77B8grDHOJAp2TQZeGw6vgT+fa2WozcvR/
         pmpg==
X-Forwarded-Encrypted: i=1; AJvYcCUFQzS5vDB4h0FKfx8CKha7OCCtnKf7cbTudxx7j2yKMMjIAKCANqGdXHf8v8k1HSOuc8EhotLTeoR4b2uN7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0GYBpMQggQcAydrBMPnHoPWjjGHnyPCW1LNwMgIADVI4hYmKk
	TsavkvT/wNM7XCkl6cpk23VBXxoXRW7lJxs7yoE63b0MSlPLBv7KURQ9brbkT2pBE77uQF84+C6
	Txpmp2917PKDGzSDhjxFHzl2r6m6l7Ngb4xeX8cTSV7N2R1n/MN9b/D5XfseDqbAoZn5U8ggRuR
	Y75udgiFze7YGxSSm7wwhlJzZpK+iLP3Hc7AuoCecpP3qj9GY8YTLj
X-Gm-Gg: ASbGncuY+2QgpVMfFz6RqjFbENUQitEXzXy7+CKyY1MIh5M8vAQSGuHW8iurvOtVVOf
	URaWmD1QLn7KFDAq8MnMQCnyO6vPZSm5ZRCBj/QYCffB+ddT78mpzAIFGdriLdchQMX02c7MW/h
	k=
X-Received: by 2002:a05:6a00:3d0f:b0:736:3c6a:be02 with SMTP id d2e1a72fcca58-73682bfe22amr6348869b3a.11.1741220112722;
        Wed, 05 Mar 2025 16:15:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+Pz3spV69sGxcycRcHq7WRbf81Tq+kwPwJB61GZMQ3BtGGM82dqOuykRK2W4wGAVBuZATFe4m7QNuLdjS0w0=
X-Received: by 2002:a05:6a00:3d0f:b0:736:3c6a:be02 with SMTP id
 d2e1a72fcca58-73682bfe22amr6348836b3a.11.1741220112304; Wed, 05 Mar 2025
 16:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250227185017.206785-1-jdamato@fastly.com> <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org> <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2> <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
 <20250303160355.5f8d82d8@kernel.org> <Z8cXh43GJq2lolxE@LQ3V64L9R2>
 <CACGkMEug5+zjTjEiaUtvU6XtTe+tc7MEBaQSFbXG5YP_7tcPiQ@mail.gmail.com> <Z8h9IKvGh4z8h35Y@LQ3V64L9R2>
In-Reply-To: <Z8h9IKvGh4z8h35Y@LQ3V64L9R2>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Mar 2025 08:15:00 +0800
X-Gm-Features: AQ5f1JrbAXMd3bdeu_op8lg8kCwD5-0ozvqwDnLIuAighSIhe17FVCeIQAOl_N8
Message-ID: <CACGkMEvWuRjBbc3PvOUpDFkjcby5QNLw5hA_FpNSPyWjkEXD_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, mst@redhat.com, 
	leiyang@redhat.com, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uWybVXQKDD8qLR1oKNNqP5_Tz8zcNe4e7TyyxQqOBck_1741220114
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 12:34=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Wed, Mar 05, 2025 at 01:11:55PM +0800, Jason Wang wrote:
> > On Tue, Mar 4, 2025 at 11:09=E2=80=AFPM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > On Mon, Mar 03, 2025 at 04:03:55PM -0800, Jakub Kicinski wrote:
> > > > On Mon, 3 Mar 2025 13:33:10 -0500 Joe Damato wrote:
>
> [...]
>
> > > > Middle ground would be to do what you suggested above and just leav=
e
> > > > a well worded comment somewhere that will show up in diffs adding q=
ueue
> > > > API support?
> > >
> > > Jason, Michael, et. al.:  what do you think ? I don't want to spin
> > > up a v6 if you are opposed to proceeding this way. Please let me
> > > know.
> > >
> >
> > Maybe, but need to make sure there's no use-after-free (etc.
> > virtnet_close() has several callers).
>
> Sorry, I think I am missing something. Can you say more?
>
> I was asking: if I add the following diff below to patch 3, will
> that be acceptable for you as a middle ground until a more idiomatic
> implementation can be done ?

Yes, I misunderstand you before.

>
> Since this diff leaves refill_work as it functioned before, it
> avoids the problem Jakub pointed out and shouldn't introduce any
> bugs since refill_work isn't changing from the original
> implementation ?
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 76dcd65ec0f2..d6c8fe670005 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2883,15 +2883,9 @@ static void refill_work(struct work_struct *work)
>         for (i =3D 0; i < vi->curr_queue_pairs; i++) {
>                 struct receive_queue *rq =3D &vi->rq[i];
>
> -               rtnl_lock();
> -               virtnet_napi_disable(rq);
> -               rtnl_unlock();
> -
> +               napi_disable(&rq->napi);
>                 still_empty =3D !try_fill_recv(vi, rq, GFP_KERNEL);
> -
> -               rtnl_lock();
> -               virtnet_napi_enable(rq);
> -               rtnl_unlock();
> +               virtnet_napi_do_enable(rq->vq, &rq->napi);
>
>                 /* In theory, this can happen: if we don't get any buffer=
s in
>                  * we will *never* try to fill again.
>

Works for me.

Thanks

