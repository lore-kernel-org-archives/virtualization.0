Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2A1F4289
	for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760056613; cv=none; b=puol+N5AJjtaKL5PD2jMCBf0lc2dSJ5ca8XZJWimVVaUt24jURPL8y5voYyNszsFyFASIkRF3+ghwsnK+YsxFo8ktKt7xpah5QcW8fiFXctLU1DYKA7/EpW4ZzS3cGqiTJxLNCQuP8UiN5B4hWxDvi+pwGMmOiC4fBDLC33X05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760056613; c=relaxed/simple;
	bh=mquOhkT2CfnmNOef1BxykItMFTKI6V/1qexnndUEsRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDljLna56ne7TiLsbI7FCFJ6xTWV84G5LnYM+//Ww8IJ6OdpIpJqrCwRvniUyU/+QMZTmSF5E0cRzh4AZCNjYEv6/auuABRmTUTwMWrCoIqdvSkFokcfTh9rD4vJKwFyBccExLfGDkSDqGvu5+qxp4fMgWqfnnWisNeOSPWwgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZmrZ4+V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZmrZ4+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760056610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kz1dV5dl2eLpvICKmSYU7u5EoVk0dbKJcfh5LF+pC6s=;
	b=CZmrZ4+VxOYr6IlVJy/a14tEqIvM6Lz2N5anNvToz90ClsGzaWlsxpso6CtehRUONPYKWb
	dDDl90aI/40R1/Cvzp1s6Prz6VghCprPKsKGyqX4vv1tMMwRQD5feR6tn4Z+12KrpG42Jb
	Gz0ZGcMpjf75myJhptpPzgiMwLXh+WU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-5EmrsVT8NKSgQgT7xR8CNA-1; Thu, 09 Oct 2025 20:36:47 -0400
X-MC-Unique: 5EmrsVT8NKSgQgT7xR8CNA-1
X-Mimecast-MFC-AGG-ID: 5EmrsVT8NKSgQgT7xR8CNA_1760056606
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-334b0876195so3838070a91.1
        for <virtualization@lists.linux.dev>; Thu, 09 Oct 2025 17:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760056606; x=1760661406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kz1dV5dl2eLpvICKmSYU7u5EoVk0dbKJcfh5LF+pC6s=;
        b=FIyDQujAQ7wrLq+2fnbtfeAxDiyhwmhcxFqcIu+qa3M/xnTEkQHBoCtpcs+7c+c25y
         YvaJalnZpNSoRG25RSOMu14numHANRwsFyuUfx155VtAYgEIof/PmrtoP2vmBWMtVLKA
         wZrKR3I2fzQMVFUZpqwkl08meTC2awTONPPY4rT4lC6Uvof41bwLbfw6Ub6A4gDZ5cSF
         +++RwVfwUjBvD4hKT/Xn06X/gMrHT0HquQvTuR6aqTB/QVoIbUfwS1odt9gwSSBQIPfV
         CcOF6URf8mlMoh5QqbE3FCbu343y+WllJIem6Z3//GUQOroqRxmB5cDL6UBnOeIK/MB4
         75wg==
X-Forwarded-Encrypted: i=1; AJvYcCUnQ2FwReCaQf0vBO/oSrqUyk5jRooEmhmQXHWrMp35z1rSDKxx0NPAlEm04iwaiVMRArfxtg9IiUEqxa8SxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrxStnZb0Vldt4toBmHBwDgsIIFPYryy4yLW0yqTuBM6Af6KX+
	ohTKfwjonyUdUgm+9rrNtQng2QCXmHPz7gWjAAGLFgBId3ozTUG8FCvu/fIWevPVdF5m/xNw9u1
	K6yQfrqXlxih9Bhag46hhnRz1y/cFcmmmhtUEM3BMdgWisdCe5sjH+mH8P2hZuDq8ebZXVS9ddq
	kh2TCGFiysj3RGeVMZ2ggxKjQ4h6anebs78uOhi3LhG/U=
X-Gm-Gg: ASbGncvzXaNAeFTfM0y+45cOrQn+NdIqDoSJv+N9tzEJpXjrR9j4nl2Us6DPJsErFCN
	XuHgQMyqMEDDeBP8K+QsIRqu2AbHxiJtHS41dAbFxLO9/sPDPVpfQfao9gIVoBOW+jkT5C4DYae
	6tNTvR8X3naOPy7XLHNQ==
X-Received: by 2002:a17:90b:4a45:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-33b5111731amr12392896a91.3.1760056605869;
        Thu, 09 Oct 2025 17:36:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQhXUYwK3GbRej1U2f24HeIucxQ+cXP/hWDuKOjy8hVQBFUR/n4+32ZNLmo6zlNXL1VfPIJ/3ifyvYGMwXAOc=
X-Received: by 2002:a17:90b:4a45:b0:329:cb75:fef2 with SMTP id
 98e67ed59e1d1-33b5111731amr12392868a91.3.1760056605242; Thu, 09 Oct 2025
 17:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com>
 <20250925022537.91774-3-xuanzhuo@linux.alibaba.com> <CACGkMEvhABOtHTCVW9sX7p0wo1QCMXMvOAD+u4pzBueoU=MCpg@mail.gmail.com>
 <1760008083.6644826-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1760008083.6644826-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Oct 2025 08:36:33 +0800
X-Gm-Features: AS18NWDzP344ThhtzISVDUM3jQH0MsG8FSH6w2nI936vgrRw3xVrYKPvtz35OMY
Message-ID: <CACGkMEuYTgK2CVGPTJrAdcJ=GxuhFTSfAc0KGU9=yRHX-7f8-Q@mail.gmail.com>
Subject: Re: [PATCH net 2/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lxAjAVpbkQiBScEOlI86F_-B-E3XmMEqaqYoh__3OG4_1760056606
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 7:10=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Fri, 26 Sep 2025 12:52:53 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Sep 25, 2025 at 10:25=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > The commit be50da3e9d4a ("net: virtio_net: implement exact header len=
gth
> > > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > > feature in virtio-net.
> > >
> > > This feature requires virtio-net to set hdr_len to the actual header
> > > length of the packet when transmitting, the number of
> > > bytes from the start of the packet to the beginning of the
> > > transport-layer payload.
> > >
> > > However, in practice, hdr_len was being set using skb_headlen(skb),
> > > which is clearly incorrect. This commit fixes that issue.
> > >
> > > Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length =
guest feature")
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  include/linux/virtio_net.h | 19 ++++++++++++-------
> > >  1 file changed, 12 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > index 20e0584db1dd..4273420a9ff9 100644
> > > --- a/include/linux/virtio_net.h
> > > +++ b/include/linux/virtio_net.h
> > > @@ -217,20 +217,25 @@ static inline int virtio_net_hdr_from_skb(const=
 struct sk_buff *skb,
> > >
> > >         if (skb_is_gso(skb)) {
> > >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> > > +               u16 hdr_len;
> > >
> > > -               /* This is a hint as to how much should be linear. */
> > > -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> > > -                                                skb_headlen(skb));
> > > +               hdr_len =3D skb_transport_offset(skb);
> > >                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
> > >                                                   sinfo->gso_size);
> > > -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > > +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
> > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> > > -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > > +                       hdr_len +=3D tcp_hdrlen(skb);
> > > +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
> > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> > > -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > > +                       hdr_len +=3D tcp_hdrlen(skb);
> > > +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
> > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> > > -               else
> >
> > I think we need to deal with the GSO tunnel as well?
> >
> > """
> >     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 =
bit or
> >     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} account=
s for
> >     all the headers up to and including the inner transport.
> > """
>
> I checked the new code, VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6
> and VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 are not supported, so the next ver=
sion
> will not include these feature.
>
> Thanks.

I may miss something but we had:

        if (skb->protocol =3D=3D htons(ETH_P_IPV6))
                hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
        else
                hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;

in virtio_net_hdr_tnl_from_skb() now.

Thanks

>
>
> >
> > > +                       hdr_len +=3D sizeof(struct udphdr);
> > > +               } else {
> > >                         return -EINVAL;
> > > +               }
> > > +
> > > +               hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr=
_len);
> >
> > Should we at least check against the feature of VIRTIO_NET_F_GUEST_HDRL=
EN?
> >
> > >                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> > >                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
> > >         } else
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>

