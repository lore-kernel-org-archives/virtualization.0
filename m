Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F18F7D
	for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 06:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711087539; cv=none; b=hxEsVQ+8EVH5sWbQD46Nd554ZtJOJ5Z4WrZqQtfePJ73QilqAhuUTbuXEP7kJhIoO8qQ8ErGpjP/v/J7ESryc/+scfmdZSVSuYlBBS2pcffRERnXkdudaRA3jORxlee+TOFFFnKxfTYYCZkDSIZLE42lXWj5Ipj2MWZKXpo3Id8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711087539; c=relaxed/simple;
	bh=TYsPbO8ALBiXTFGn16KeCtG8UBj5rZU5f+VCxKa0O70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FO5rTWsPJEKFDcD89F8/8YyEcU3BDt3YduTxmMGvAs82QK+pknpq6HdubrXi2wexbTb/an5ysnKtXwq4kIQ5d6aSaNraV5UuowNhFNYDWZfLd1qkfxJ1tKKISftxU+mBj7OeosXyza22ZKR/SJGDEaR/bguzKPf7V57cwQytOX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxw+Fwm1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxw+Fwm1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711087536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2oai1HqsEqaYtk7xzRySgsOW0sFIdScx+fJRlKeJ6E=;
	b=cxw+Fwm1gP/8Hgw9oYwY5phvkYaEbYtrYR1q+kJSj2nlfH2yiyXqzxf125X8aUmKG3JToP
	irDZhBlai6B1VLC0H8eR4XabUetEO+H5vxM8Umq+hypSSVd4jq5bFgydmR/oKq3UgNpm1q
	pK3tLYZFDkivRKj2meDagYUzah0HKEU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-0BEcFJU2Pp24qNyKcROGQw-1; Fri, 22 Mar 2024 02:05:35 -0400
X-MC-Unique: 0BEcFJU2Pp24qNyKcROGQw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69057317d23so30108696d6.0
        for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 23:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711087534; x=1711692334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2oai1HqsEqaYtk7xzRySgsOW0sFIdScx+fJRlKeJ6E=;
        b=d55SlcYGc/hIpithbKOCYckBVVPRA+w2VC6SSSHTZXDfyEQRMkS4xbqI5uv0+Kbt/9
         inIZ8nDSQc1QZ2VTlCMkTod2O+nwAMc59JkrJsywmZdeJNWFTI4p91+9JanbpnSo6sys
         czazv0jdHZPzkevg3spe8E3u5/IxkMDgLrefUMUOhnOBfRxVawDo74NKV1uK5+WTpeGt
         3QHO6WhvbFlK7fU7lRYOYYPBjF/KzexWhdR0SjdFX/8VjQ0YnxXtrNF8xisg1Dcy8fSN
         Z6jEJkU525Z5nX9wOKqN32lyaMLHCYMnH8SXoIVsZ9lNTFcA32pjhL/EM+uWc+kSjcUQ
         9mrg==
X-Gm-Message-State: AOJu0YwdQuQTVlFslRJUCt0Sfj5KZAutGI9bcz84bHBVacp355mR4GnX
	QRhYgvOc+okAcsfYvYjp79rLS/a/gURkXFCLmu4iL0XD4KBn/D3iGtgSkTdNEaRm9qSdkIFeQDz
	iNUY/RjmRKuXsOrxmbDXJ1NTMQh+oLeWoEX4R9cwbdeVdHzX2mb0qrkfFGaFoL+N1IyfczXO1ai
	E5gTRdR/WlRv+E24dcBL4Pb2yZIv302OoDm8tAiaRj0nM6SXibHw==
X-Received: by 2002:a05:620a:319c:b0:788:19cc:8a4b with SMTP id bi28-20020a05620a319c00b0078819cc8a4bmr1611222qkb.1.1711087534381;
        Thu, 21 Mar 2024 23:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiUY/TKBCdHDn7aWqVVssjqWjswbBSkDgUaViaSTzICzXtBUzbpl9F172nozKATzHvOZzyHkdD1P/xhduswtY=
X-Received: by 2002:a05:6a20:12c5:b0:1a3:9f1e:e824 with SMTP id
 v5-20020a056a2012c500b001a39f1ee824mr1802031pzg.33.1711087066986; Thu, 21 Mar
 2024 22:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240320102025.11327-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs-x-W2DHh8U=+0ORnq7=kjw9SJNNtDFfGNjC2KqqPZeA@mail.gmail.com>
 <1711074462.3244817-3-xuanzhuo@linux.alibaba.com> <CACGkMEtOjPYuPi7MQcnp+TroxLKa4YtpTdsP4bNUSxUV8rgq3A@mail.gmail.com>
 <1711086351.5199406-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711086351.5199406-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:57:36 +0800
Message-ID: <CACGkMEv7XsRVLSgOu8=VPvLwQZf5rAXrUFD2v9mCvLiV4PRCSw@mail.gmail.com>
Subject: Re: [PATCH vhost] virtio_net: update the hdr_len calculation for xmit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Spike Du <spiked@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 1:51=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 22 Mar 2024 13:04:48 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Mar 22, 2024 at 10:29=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > On Thu, 21 Mar 2024 12:17:54 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Wed, Mar 20, 2024 at 6:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > The virtio spec says:
> > > > >     If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO option=
s have
> > > > >     been negotiated:
> > > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotia=
ted,
> > > > >         and gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the dr=
iver
> > > > >         MUST set hdr_len to a value equal to the length of the he=
aders,
> > > > >         including the transport header.
> > > > >
> > > > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been neg=
otiated,
> > > > >         or gso_type is VIRTIO_NET_HDR_GSO_NONE, the driver SHOULD=
 set
> > > > >         hdr_len to a value not less than the length of the header=
s,
> > > > >         including the transport header.
> > > > >
> > > > > So if the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated, =
the
> > > > > hdr->hdr_len should be eth header + ip header + tcp/udp header.
> > > > >
> > > > > But now:
> > > > >     hdr->hdr_len =3D __cpu_to_virtio15(little_endian, skb_headlen=
(skb));
> > > > >
> > > > > The skb_headlen() returns the linear space of the skb, not the he=
ader
> > > > > size that only match the case the VIRTIO_NET_F_GUEST_HDRLEN featu=
re has
> > > > > not been negotiated, or gso_type is VIRTIO_NET_HDR_GSO_NONE.
> > > > >
> > > > > We do not check the feature of the device. This function is a com=
mon
> > > > > function used by many places. So we do more stricter work whateve=
r
> > > > > the features is negotiated.
> > > > >
> > > > > For the case skb_is_gso(skb) is false, if none of the
> > > > > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have been negoti=
ated,
> > > > > the spec not define the action of setting hdr_len. Here I set it =
to
> > > > > skb_headlen(). If one of the above features have been negotiated,=
 we
> > > > > should set a value not less than the length of "eth header + ip h=
eader +
> > > > > tcp/udp header". So the skb_headlen() also is a valid value.
> > > > >
> > > > > For the case skb_is_gso(skb) is true, it implies that one of
> > > > > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options MUST have been
> > > > > negotiated. If the VIRTIO_NET_F_GUEST_HDRLEN is negotiated, we MU=
ST set
> > > > > it to the length of "eth header + ip header + tcp/udp header".
> > > > > If the VIRTIO_NET_F_GUEST_HDRLEN is not negotiated, that still be=
 a
> > > > > valid value.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Reported-by: Spike Du <spiked@nvidia.com>
> > > > > ---
> > > > >  include/linux/virtio_net.h | 41 ++++++++++++++++++++++++++++----=
------
> > > > >  1 file changed, 31 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_ne=
t.h
> > > > > index 4dfa9b69ca8d..51d93f9762d7 100644
> > > > > --- a/include/linux/virtio_net.h
> > > > > +++ b/include/linux/virtio_net.h
> > > > > @@ -201,24 +201,45 @@ static inline int virtio_net_hdr_from_skb(c=
onst struct sk_buff *skb,
> > > > >
> > > > >         if (skb_is_gso(skb)) {
> > > > >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb)=
;
> > > > > +               u32 hdrlen;
> > > > >
> > > > > -               /* This is a hint as to how much should be linear=
. */
> > > > > -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> > > > > -                                                skb_headlen(skb)=
);
> > > > > -               hdr->gso_size =3D __cpu_to_virtio16(little_endian=
,
> > > > > -                                                 sinfo->gso_size=
);
> > > > > -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > > > > +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
> > > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV=
4;
> > > > > -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > > > > +                       hdrlen =3D tcp_hdrlen(skb) + skb_transpor=
t_offset(skb);
> > > >
> > > > So could evil guests give us a 0 hdrlen through this. If yes, it se=
ems
> > > > much more dangerous than headlen or we need harden the value as
> > > > 9181d6f8a2bb32d158de66a84164fac05e3ddd18 did.
> > >
> > > Spec says:
> > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,=
 and
> > >         gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the device MAY=
 use
> > >         hdr_len as the transport header size. Note: Caution should be=
 taken by
> > >         the implementation so as to prevent a malicious driver from a=
ttacking
> > >         the device by setting an incorrect hdr_len.
> > >
> > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotia=
ted, or
> > >         gso_type is VIRTIO_NET_HDR_GSO_NONE, the device MAY use hdr_l=
en only as
> > >         a hint about the transport header size. The device MUST NOT r=
ely on
> > >         hdr_len to be correct. Note: This is due to various bugs in
> > >         implementations.
> > >
> > > The device nerver trust the hdr_len completely.
> > > So I think that is safe.
> >
> > It doesn't, there's no way to audit all the existing implementations of=
 virtio.
> >
> > For example, have you seen the commit I've pointed to you?
>
> I haven seen it.
>
> But here, this is driver, the device should handen the check.

Unfortunately not. We can't audit all device implementations.

> For the driver, we should do as the spec.
> Do you mean that some evil driver pass 0 to device?
> Now we fix that.

hdrlen =3D tcp_hdrlen(skb) + skb_transport_offset(skb)

Did you mean hdrlen can't be zero here? I guess it is done by the
DODGY checking in the GSO path?

Then, let's explain it here.

>
>
> >
> > >
> > >
> > > >
> > > > > +
> > > > > +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
> > > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV=
6;
> > > > > -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > > > > +                       hdrlen =3D tcp_hdrlen(skb) + skb_transpor=
t_offset(skb);
> > > > > +
> > > > > +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
> > > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_=
L4;
> > > > > -               else
> > > > > +                       hdrlen =3D sizeof(struct udphdr) + skb_tr=
ansport_offset(skb);
> > > > > +
> > > > > +               } else {
> > > > >                         return -EINVAL;
> > > > > +               }
> > > > > +
> > > > > +               /* One of VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UF=
O options MUST
> > > > > +                * have been negotiated. If the VIRTIO_NET_F_GUES=
T_HDRLEN is
> > > > > +                * negotiated, we MUST set it to the length of "e=
th header + ip
> > > > > +                * header + tcp/udp header".  If the VIRTIO_NET_F=
_GUEST_HDRLEN
> > > > > +                * is not negotiated, that still be a valid value=
.
> > > > > +                */
> > > >
> > > > I'd stick the headlen for deivce without GUEST_HDRLEN. It seems muc=
h
> > > > more safe as we don't want to break legacy devices.
> > >
> > > I do not get it.
> >
> > if (GUEST_HDRLEN)
> >     tell the offset of the payload
> > else
> >     tell the headlen (stick to the old behaviour)
>
>
> I am ok. Then we need to pass the features of the device to this function=
.

Yes, a boolean probably.

Thanks

>
> Thanks
>
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > >
> > >
> >
>

