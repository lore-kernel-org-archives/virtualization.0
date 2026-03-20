Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6727F21D585
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967134; cv=none; b=d+nyPCsBIh6cQFnUoYp9ctiLgdKTALOiGMXHfBF4BeInAKdgAVApLa8LFyMuzK0DWgzfSFT/nyplbShXQCKZoRHFGqoAwLn6HR2wakR9asYkj8+RrdgRaQ24cFuQmBF0+pOsf7tiz47bJ32bvUBKbUMU/76hbtp39IbF8x2IoSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967134; c=relaxed/simple;
	bh=ISLLuaAIOwD3fI9L8hjfoPaDT2/sL6cQenYqI86Rzk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QO+yOA332g9KrwQzWHmYzOsocyVxRHIouEP6MPyBzdgUgGyjSg+f8TBCsLKuC1l8qQSikMTQEYAdcNQykiE65B5u7lYQFPEZ0R3lUiciF23C5xTN6BFlKTHktTDxutV79O4T9/FHNd2oft1NP1894cKOau0ZmXf+k0C30YlpQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cvc/zMgQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cvc/zMgQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773967132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ezP0u+fBRK/LBUGyAtUi77M5iMbp2rxNDEQVpBVAwc=;
	b=Cvc/zMgQACWo6On2ZtzTTGGqstZPluwKln8ba5grTM9moKk/Qe4kty2vYE8IVKMlCS69DP
	IL0/kFR/CdSzwp4iLtxxEWBB5yqxyPDPXF9UF4T9FoBNgRwXDX++vAskyPzEMzZKfTLOS5
	4XPFDB7AZTgDyj2PTi1/RQfbNA6atnA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-QDJfP9CEMEmllaz78T_V2A-1; Thu, 19 Mar 2026 20:38:48 -0400
X-MC-Unique: QDJfP9CEMEmllaz78T_V2A-1
X-Mimecast-MFC-AGG-ID: QDJfP9CEMEmllaz78T_V2A_1773967128
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358f058973fso2561476a91.1
        for <virtualization@lists.linux.dev>; Thu, 19 Mar 2026 17:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773967128; x=1774571928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ezP0u+fBRK/LBUGyAtUi77M5iMbp2rxNDEQVpBVAwc=;
        b=P31kml3BX7GBR8iSbHNemskCC8h35qcPuUI8g5KZX4cttV4Ysv3oggxsXrng8O1hpA
         sqbPnrPP2mFdhe14t8QzG4dDuTgZYdE4IvkeuuNIql8yPw6BgOpoZP+BuDmiO2YPgl/3
         YEBAUgADp34qZUygjRKCdF7N+DR38K/000dNdoXgE3udKVsXb6BIvdoQJiQf0OGSzVYy
         x9zZwOaX/5EuYDzT36ro3UFGql7ETafOAWm0/UKrWpIliMd8uMCmWsdDJSFppzpfYzxx
         mn45kQ0eIFstQ4RwPFVw4TugYfjMpAlSjLi2zQpQzPTvIc7Kgy4xBs39ciyNIFnLHMTq
         MsgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt/AeYP51lUwKL9ml9/pOTOgjvZ/9qsUYnypArP1PaNezvWd5sy9tcFPMGa54fJv9KxytOV5NoQSVl0p+rBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXH/ZsvyGUG6JUhfrld34E5DY/IymxKEm+/qoa9MNoV2a+PxG9
	ODW8hFT3/EprdNMlwTipqhDS0mnXBcghyDBmkaSNT8dcym9+EyPCeg8kVr1w6xDWxPqUbjbiIPY
	lqUurK9xC5bBxzQhutQBG3hOFQyu0zxTHzoCX66wZqgQyGI0W/Yu8Bhl/QpiEfjXvRJKcJhqzlT
	HBUD/w2cPEQpq8yI2A17xf6ia5Rv3jjvpD7aH1OEkPB3Q=
X-Gm-Gg: ATEYQzys1eloH5Ulm3QehZ713jlnQGsIyL7aAkdLx9eejiW4/tbQmAWPBzM66CQv5gA
	ybgSGb7PQUFTh3qNhdEmYLepGiVbjlwMW8SVbyDM9NAvssAZzNr1T8j9eAVtwTrr07BBiqHEpiK
	jeKRoEfPrDiAhgiwTteP2eu+2AmAWk+6S/mGZBvbQKlapnmc9504QPWouDxzCYxP0VACsKFhJvv
	XbO8w==
X-Received: by 2002:a17:90a:e7d1:b0:35b:90e7:c458 with SMTP id 98e67ed59e1d1-35bd2bba0admr840880a91.3.1773967127744;
        Thu, 19 Mar 2026 17:38:47 -0700 (PDT)
X-Received: by 2002:a17:90a:e7d1:b0:35b:90e7:c458 with SMTP id
 98e67ed59e1d1-35bd2bba0admr840853a91.3.1773967127303; Thu, 19 Mar 2026
 17:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
 <20260313075930.105466-2-xuanzhuo@linux.alibaba.com> <CACGkMEv_Fu5wsS3DKuOn3pLjqAssPEV7GXn0702t2pOLYHfwHA@mail.gmail.com>
 <CACGkMEutuueTx_QhEa9gV72NYTqaGD=69YvMKG=RcmEfdrJKhQ@mail.gmail.com> <6be7d6f0-08ce-466c-87cc-bc2ad3f26aab@redhat.com>
In-Reply-To: <6be7d6f0-08ce-466c-87cc-bc2ad3f26aab@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Mar 2026 08:38:35 +0800
X-Gm-Features: AaiRm51Cgmr_6KcHsvMLEhMg1ooE2wNm_OXHGeR3ESMy6iFQsh2XE_XRq9XTcsI
Message-ID: <CACGkMEvTXpQ8pxL5DQjWeaJPMLP9X3=c5=hc-Geoj1PSZ+_sJQ@mail.gmail.com>
Subject: Re: [PATCH net v10 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Paolo Abeni <pabeni@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OBDZJ06N6uI5VaLWoO0TXUGzvoFtF1FuLGTbsbgq5vM_1773967128
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 4:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On 3/18/26 5:11 AM, Jason Wang wrote:
> > On Wed, Mar 18, 2026 at 12:07=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> >> On Fri, Mar 13, 2026 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> >>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> >>> index 75dabb763c65..48de4a16a96a 100644
> >>> --- a/include/linux/virtio_net.h
> >>> +++ b/include/linux/virtio_net.h
> >>> @@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct s=
k_buff *skb,
> >>>         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->=
gso_type);
> >>>  }
> >>>
> >>> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> >>> +                                        struct virtio_net_hdr *hdr,
> >>> +                                        bool little_endian)
> >>> +{
> >>> +       u16 hdr_len;
> >>> +
> >>> +       hdr_len =3D skb_transport_offset(skb);
> >>> +
> >>> +       if (hdr->gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4)
> >>> +               hdr_len +=3D sizeof(struct udphdr);
> >>> +       else
> >>> +               hdr_len +=3D tcp_hdrlen(skb);
> >>
> >> Ok, I think this depends on the logic inside virtio_net_hdr_from_skb()
> >>
> >>                 if (sinfo->gso_type & SKB_GSO_TCPV4)
> >>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> >>                 else if (sinfo->gso_type & SKB_GSO_TCPV6)
> >>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> >>                 else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> >>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> >>         else
> >>                         return -EINVAL;
> >>
> >> To be more robust, I'd suggest moving it there.
> >>
> >> But I have another question, the logic above depends on the headlen is
> >> correctly set:
> >>
> >>                 /* This is a hint as to how much should be linear. */
> >>                 hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> >>                                                  skb_headlen(skb));
> >>
> >> Is the headlen guaranteed to be correct in all cases (e.g for nested
> >> setups or dodgy packets?)
> >
> > Speak too fast, I miss
> >
> > hdr_len =3D skb_transport_offset(skb);
> >
> > This is probably another call to
> >
> > 1) Move virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb() or
> > 2) call virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb().
>
> It looks like that the above leads to more complex code with a bunch of
> additional conditionals, which possibly the compiler can't optimize out,
> and IMHO not nice layering violation, see the already mentioned previous
> iteration:
>
> https://lore.kernel.org/all/cf62a942-e1e8-4b37-837a-b0bd76297656@redhat.c=
om/
>
> What about instead simply rename virtio_net_set_hdrlen() to
> __virtio_net_set_hdrlen(), virtio_net_set_tnl_hdrlen() to
> __virtio_net_set_tnl_hdrlen(), and add explicitly mention in a comment
> that such functions must be invoked only after virtio_net_hdr_from_skb()
> validation?

Works for me.

Thanks

>
> /P
>

