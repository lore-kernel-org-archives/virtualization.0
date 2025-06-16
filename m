Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719B2AF0A
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 03:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042921; cv=none; b=u5UYo/FNdtVCcfY2NlCKUDr06u7EC/61QBY65TakOlt05sT8HFUmxSyHAO7M1SXyX69r9qVOfqamI58reHMf0jFnQzRshB4MsqEZoHe6+RuUnMYlDupjAZyDZ0NjzjFvsFs7DJVrVRyTMvLljAge2i1YfO7tpKx2B736s+IMZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042921; c=relaxed/simple;
	bh=82AhWuVQoAuMPbM6xTSjCUZ/9oJnawVRvPBYrGktsSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfMksndogDBiYWuK2N2cTs1nNxwgX9dmZ61BZnyyDCZ8HcpxjfrcEIBhT93j7YpZhxpFpEN1j14bQTOL9aZhCO+rmBgwjZzTb4QSnT549U0SZ6NBUaNE3DICnaPNC3Nh2UU7wOxLaEgmt9YpL4J76vjdsyvGeAQd1KMu9JjJIzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzGZL2Q+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzGZL2Q+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750042918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCKkRtoSzZbTAPs+ac64tFtNoEnWSOUuabd/mn0iDV4=;
	b=HzGZL2Q+v2s1A3jyb55CP9KsaqR1HgjNWLgTH0iV8XgZquWS/vbW9G4Uk7gs4/RnYoJcYi
	wA+GhkqGHXRFyms7hF0Nma49tjhW/HZhbOSZnKhLUulqKFvNuR7NMU+1DLCV4rcVvVThNN
	qm9rP+K/7Icz0HemQwH7kE0JhriFIwk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-eenCszAwMSSa7waxJF110Q-1; Sun, 15 Jun 2025 23:01:55 -0400
X-MC-Unique: eenCszAwMSSa7waxJF110Q-1
X-Mimecast-MFC-AGG-ID: eenCszAwMSSa7waxJF110Q_1750042914
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so3954655a91.2
        for <virtualization@lists.linux.dev>; Sun, 15 Jun 2025 20:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750042914; x=1750647714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCKkRtoSzZbTAPs+ac64tFtNoEnWSOUuabd/mn0iDV4=;
        b=XASKj8V8rD7qVRG3JleFNVPXuJSlNSQDhtCoMHf3O6Wk471jtHwYfGsAX8Fez/EpjE
         JtBmwEsNIPcy/8iuSzHizBtoJ1+wUoJXEX/DczokDzEl/6cSNaZs4hYhhKWnImCWfamp
         Iztp0aAG9pqEpyccj8sDNHrEzZ2htQw1tqxNiNvGf978Z2IemfRCHqJif1wW9P60OkPv
         JoB+VLOvl0Eu050hmMkNmGdulqobBRQICtOUqHqCUIghKNnvv0jLTB4/k8L/ZqychxpC
         qiSIFU+1KlMxytBJL8qWVzBUXPNkpVdUYuyLbFkafxrpFtnGXBFcQhAlfQSAIkjWOODT
         srlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2NKR1WdbpN1njVlM0n/X9jX+xFD8+3TrWlGAuCTS5Rus2QofDMPH2wBlvRwljXdQqkt8nEerNjhb3o8FEiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkVphLtkVRDO7wXrcK0/ri+ItY+X/rhnOlNkMnuXZLNdG5lYEG
	xOo8ovNUPSfsukoAknt8uJ/R4I+qRn54gn5jSIrU1ZHY5lirGM0esfyjbv7ScZ/sLF/IuJM2pTG
	OnTY+r/Y57sia7+BHKgv9IHjZu7i4yv4bYA2A8iTmsuMcWuvSHCCEZjCNs/nMx280CvKuA5Ij6u
	GE6eii8CMKEZP8wUi1asW5E430Vt9TqUtN1RE4VwNAqh4=
X-Gm-Gg: ASbGncsyOUMno6OVq2VUY9hElQPW88IAzSZpn0BlCzdfzFsck0v47OAjNB7Sdy5o3R0
	kk+Urknzd3EewJMOHjEtsOUe7yE1zsKjpPg5x0fO7ORG+5AiNvXSaR9EaX01E8UD+0w7bUMcrnR
	b0xg==
X-Received: by 2002:a17:90b:4c09:b0:311:c939:c851 with SMTP id 98e67ed59e1d1-313f1ca12edmr11875513a91.4.1750042914292;
        Sun, 15 Jun 2025 20:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDgoqXu/ryVb1qiAXAGjdpMZc6vHNXfms6UXRPPQBfj+M9c5as5mZfMjZanre+4SB2mOQj6vOqZlGwhMGx3nQ=
X-Received: by 2002:a17:90b:4c09:b0:311:c939:c851 with SMTP id
 98e67ed59e1d1-313f1ca12edmr11875456a91.4.1750042913801; Sun, 15 Jun 2025
 20:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250612083213.2704-1-jasowang@redhat.com> <20250612083213.2704-2-jasowang@redhat.com>
 <684b89de38e3_dcc452944e@willemb.c.googlers.com.notmuch>
In-Reply-To: <684b89de38e3_dcc452944e@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Jun 2025 11:01:41 +0800
X-Gm-Features: AX0GCFsoBTIoj8eDkU_o6slNuA7yTes0y0TTyhZGfKJwDR3Xf-iokYyjHozULQs
Message-ID: <CACGkMEsKTLfD1nz-CQdn5+ZmxyWdVDwhBOAcB9fO4TUcwzuLPA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] vhost-net: reduce one userspace copy when
 building XDP buff
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, davem@davemloft.net, 
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LKYXodrnkpNkQZ-b7YmT0NGVr5NV2K3rNQDr6FkVwwg_1750042914
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 10:16=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Wang wrote:
> > We used to do twice copy_from_iter() to copy virtio-net and packet
> > separately. This introduce overheads for userspace access hardening as
> > well as SMAP (for x86 it's stac/clac). So this patch tries to use one
> > copy_from_iter() to copy them once and move the virtio-net header
> > afterwards to reduce overheads.
> >
> > Testpmd + vhost_net shows 10% improvement from 5.45Mpps to 6.0Mpps.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Acked-by: Willem de Bruijn <willemb@google.com>
>
> > ---
> >  drivers/vhost/net.c | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index 777eb6193985..2845e0a473ea 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -690,13 +690,13 @@ static int vhost_net_build_xdp(struct vhost_net_v=
irtqueue *nvq,
> >       if (unlikely(!buf))
> >               return -ENOMEM;
> >
> > -     copied =3D copy_from_iter(buf, sock_hlen, from);
> > -     if (copied !=3D sock_hlen) {
> > +     copied =3D copy_from_iter(buf + pad - sock_hlen, len, from);
> > +     if (copied !=3D len) {
> >               ret =3D -EFAULT;
> >               goto err;
> >       }
> >
> > -     gso =3D buf;
> > +     gso =3D buf + pad - sock_hlen;
> >
> >       if (!sock_hlen)
> >               memset(buf, 0, pad);
> > @@ -715,12 +715,7 @@ static int vhost_net_build_xdp(struct vhost_net_vi=
rtqueue *nvq,
> >               }
> >       }
> >
> > -     len -=3D sock_hlen;
> > -     copied =3D copy_from_iter(buf + pad, len, from);
> > -     if (copied !=3D len) {
> > -             ret =3D -EFAULT;
> > -             goto err;
> > -     }
> > +     memcpy(buf, buf + pad - sock_hlen, sock_hlen);
>
> It's not trivial to see that the dst and src do not overlap, and does
> does not need memmove.
>
> Minimal pad that I can find is 32B and and maximal sock_hlen is 12B.
>
> So this is safe. But not obviously so. Unfortunately, these offsets
> are not all known at compile time, so a BUILD_BUG_ON is not possible.

We had this:

int pad =3D SKB_DATA_ALIGN(VHOST_NET_RX_PAD + headroom + nvq->sock_hlen);
int sock_hlen =3D nvq->sock_hlen;

So pad - sock_len is guaranteed to be greater than zero.

If this is not obvious, I can add a comment in the next version.

Thanks

>
> >       xdp_init_buff(xdp, buflen, NULL);
> >       xdp_prepare_buff(xdp, buf, pad, len, true);
> > --
> > 2.34.1
> >
>
>

