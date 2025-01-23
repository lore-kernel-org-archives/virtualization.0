Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB03120330
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737600062; cv=none; b=iMGZnKQ8u5qykAGcTvIlIKIm41ASzslE14O9SSDEllEccG/2sBlthLUTmbcwctG5GHB5fWPmey1xayB/Pima1jVlOu3rrHxYSAG8w0I5yEyt7brx4gUSAT+/nF2KKyYv0SYY3TKQubGrFuCxP9Cmi2Qn2sRR+X+k0Lx19ER7hjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737600062; c=relaxed/simple;
	bh=IDSq31qW43H66Z9jxE0sZh2yPTgWaD4smSeqie292eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MmE5uBlQ9yxYKcm0RpYgm7mVs8OyIhGLFv9PGaxZhPUnlCtdxsGJohpXdXg9RKzA3oyMEoHDWy1KYvY4raFibuoGk6RloGBktAhF9SD9aq7mUXM7G4+fCXUIhUPzTDrEGvpF3wnIYXSC2DECEb84jNzZhGO85fPsjTvWFftOFHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZ1vqHKb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZ1vqHKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737600059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfzyYNEJmxf5GB0OtHAkM67x1flGOjXSV05Ky8+TnvM=;
	b=UZ1vqHKbgOqbHQQgl4UZJiAYsbUbbvx5MI1GoO7rSHMGFYXweBnyNE2yFvZKsu+cR+5T06
	OVGujvMrfouqvgVJS+NhCab/Ie+HD7aShk21KqR9z45DUG2M+LMtJp+/g2Bb8cG5CD6ErS
	dyUS5J+KSjrInntpUSwLmJmVi1ZvcPU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-vp8nyGy3PcCWve6jX-qC5Q-1; Wed, 22 Jan 2025 21:40:57 -0500
X-MC-Unique: vp8nyGy3PcCWve6jX-qC5Q-1
X-Mimecast-MFC-AGG-ID: vp8nyGy3PcCWve6jX-qC5Q
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9e38b0cfso989823a91.0
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 18:40:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737600055; x=1738204855;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfzyYNEJmxf5GB0OtHAkM67x1flGOjXSV05Ky8+TnvM=;
        b=RJqZvSwcVJ+h6ToJphxh5Vti2DyBjGavcIpqhhO3y2RSGhPwV9mqn02+qQROW+bxyQ
         wV2H+H+7sO7IRJTqg7IknvRvxd8VB3CryakXa6ANEB7aofOMdgIN9T/7jFY+6BQ8j4bB
         o+haVcbFfA5ZQlfW3F4ntI6QGmGKeNK4YeqM7h5PZJszejAC3/z0N4Cd9HnPiKsfc1NX
         HW1msHuhwqqxplUkP3G+qYoV9IW6rugHP6XWvlE2T4S4F0ZwKNRTfxd45Sr/mV3O+hyH
         ljkFyByVn4irX9k4wVuwY31uRJT+jwmDfa4HLjzMthH5EoAnjxstZ/WAEr+OMoc83Olc
         8WYg==
X-Forwarded-Encrypted: i=1; AJvYcCW9q9x6G9XnI+Lou+SvTKYRO9oGQXyRuLh5lUpXIfr9SDeIuP1Eamk7Z8oMBdYfW8d6AANQW8R0q0fVM8fnOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8nv9ujAfLXSjXkNZnpFABJT3wjFGQWJKXMv85ramL6+AIgg44
	rlXdf0AB5itUqy0r5eG4ECV64VtAE73Uguu1/ApSDABn8n/9N3DkZ1NA7gS6NtMSHpy9n3Bh9TI
	XnAr3P7zJ6mrfV5nAGD6trL5XELchPZuAzuMLYE7anI4F1t3+9obW3cUxs+LmjhwV6Q10tcqTtC
	T3iOV0Q2hKuCBZE4tlYzHghaEKzyT7zIox9+b92NHgy/bw4EDwz+by
X-Gm-Gg: ASbGnctHenbPPNVG5lLbwdpibeuuE2KymyHbg9Dr70UWSVZHJ9Q1UAYOzk8zj2xaDI2
	/+FKPgNMRmiJn4x/tWKOtwfHznDssXN6OODv8ujooSyXObgnETA==
X-Received: by 2002:a05:6a00:6088:b0:72a:a9b5:ed91 with SMTP id d2e1a72fcca58-72daf99ed03mr32272030b3a.13.1737600055350;
        Wed, 22 Jan 2025 18:40:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOsl6RhEOba8DlPMonHjaLopM4A3V0dc+2Z0w4d/Rjw3AFA4pJXIvcNU1iOes3FHDYO7VUJ4YeWGEcPJaHEBk=
X-Received: by 2002:a05:6a00:6088:b0:72a:a9b5:ed91 with SMTP id
 d2e1a72fcca58-72daf99ed03mr32271996b3a.13.1737600054923; Wed, 22 Jan 2025
 18:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121191047.269844-1-jdamato@fastly.com> <20250121191047.269844-3-jdamato@fastly.com>
 <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com> <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
In-Reply-To: <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jan 2025 10:40:43 +0800
X-Gm-Features: AbW1kvY-san13m47F8mgbLh1NqP-onuXWgGkl7kTYp-BPipcolLCBzWZ9gcC2sM
Message-ID: <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue mapping
To: Joe Damato <jdamato@fastly.com>, Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org, 
	gerhard@engleder-embedded.com, leiyang@redhat.com, xuanzhuo@linux.alibaba.com, 
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0vbC3xIcjs-rfzMXRBGawvUnz21nKHL7f9fJzzXLuuQ_1737600056
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 1:41=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Wed, Jan 22, 2025 at 02:12:46PM +0800, Jason Wang wrote:
> > On Wed, Jan 22, 2025 at 3:11=E2=80=AFAM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > Slight refactor to prepare the code for NAPI to queue mapping. No
> > > functional changes.
> > >
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > > Tested-by: Lei Yang <leiyang@redhat.com>
> > > ---
> > >  v2:
> > >    - Previously patch 1 in the v1.
> > >    - Added Reviewed-by and Tested-by tags to commit message. No
> > >      functional changes.
> > >
> > >  drivers/net/virtio_net.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7646ddd9bef7..cff18c66b54a 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq=
)
> > >         virtqueue_napi_schedule(&rq->napi, rvq);
> > >  }
> > >
> > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_st=
ruct *napi)
> > > +static void virtnet_napi_do_enable(struct virtqueue *vq,
> > > +                                  struct napi_struct *napi)
> > >  {
> > >         napi_enable(napi);
> >
> > Nit: it might be better to not have this helper to avoid a misuse of
> > this function directly.
>
> Sorry, I'm probably missing something here.
>
> Both virtnet_napi_enable and virtnet_napi_tx_enable need the logic
> in virtnet_napi_do_enable.
>
> Are you suggesting that I remove virtnet_napi_do_enable and repeat
> the block of code in there twice (in virtnet_napi_enable and
> virtnet_napi_tx_enable)?

I think I miss something here, it looks like virtnet_napi_tx_enable()
calls virtnet_napi_do_enable() directly.

I would like to know why we don't call netif_queue_set_napi() for TX NAPI h=
ere?

Thanks

>
> Just seemed like a lot of code to repeat twice and a helper would be
> cleaner?
>
> Let me know; since net-next is closed there is a plenty of time to
> get this to where you'd like it to be before new code is accepted.
>
> > Other than this.
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks.
>

