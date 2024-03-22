Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818686FB2
	for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 05:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711083905; cv=none; b=CkWAGOkb4PEbMkGMPwvyReYt1wWRjdZiUGvdwwmOPLEf1cA/MMpCjaMhkturo68MtEsv9IC8XwibhN/5dlGtPX9/MVfWKV5ThzJm5U+wgBgOTdQqFZFVuNNPCmDmGa3oszIEzB2vZ9Y7XGovwaXm+zYfpfMxeV2/4PbR4o5I9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711083905; c=relaxed/simple;
	bh=f2fYbvc7tT4ucJT1n3nMqZCQoet9BVHoSh4qx6HV6Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0HSGqZ5d9vRoEnuC6w9mebp076KHDmJanLJFRBythP50GjXc5thHp6bY4TlgdbarETabV90649Kqgxy5bCktbfdJNJNWzt0xNv6hAydhcS9ngThluXQdl2F63TsvINnbbdrmRVeDwuTtqMauXoFV/wjtPTZpAm4tCrlyAE/MTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2mvUrih; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2mvUrih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711083902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LhdGUFW1bntuO8Gsl4OJDteGEtgJ6yqk5jWqFFkZyQ=;
	b=E2mvUrih4e8eizh3ZfQnDd6/UZIhgu5zywQDzWcGstI0NJkjWlMb307Q/JcBgd1DQZLLiC
	qijrhaxa5/cvVD4mk81+INm0vo1fRY9pdQF+8gAMTqdNICw+OO/Qn40bq9l5KQ3KAWupdK
	+k1GJDTJX5OhKVi2rkmOjgbGzMkIIJc=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-xgMZz7gxPuK8TozzuJ7GqQ-1; Fri, 22 Mar 2024 01:05:00 -0400
X-MC-Unique: xgMZz7gxPuK8TozzuJ7GqQ-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-221d1cc21deso2070103fac.3
        for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 22:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711083900; x=1711688700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LhdGUFW1bntuO8Gsl4OJDteGEtgJ6yqk5jWqFFkZyQ=;
        b=Uyy19JEXSdDJUFKjr4UglMTkUuE/jmaJFVuWTnf5jl7SXQmY27Wu1bFznTByH+0TiG
         As667YD0SGPmaywvL5Vfs8ImOzrHmy1d+qV43F/YQ7Mz73ZBYXkj2vXBkMvbeu5cD8at
         6YDlz9Mwx7N3Q9WAxJkXrxGU+J9EXxOeLuI20oB55ejCHqtIIYZGE/2+H8IGFrwOp6ZR
         a7p0oxlUKWDk2R4N3EeDYbios2l9FzOxmKwp+hczwxNpPxwOGtl20bSxovLFL2B5eMT7
         I4wU6AzYFq8k0nVnrF+Ny4jgtQ/BqR9a6Emm5fVljSPw6J7cYbvAzFedtKCb20tq7BCT
         kj3w==
X-Gm-Message-State: AOJu0YxaPes0mfmaFZHruq+ap4d1eX/qQeV7hmSQYVRh91rOh/yT4bkF
	dG6cqQ+qRmVqQc3AVcoVkGCMwAdgrkdRvk84vybJK1WwGU+24OmRHAlea7cxrcLHVn/XMLPid9j
	e1KLTs3ydg+ZYUqzgmT0mJlZ5ZD423T2YolUMtlu/XA/A34fUAke90SeqwwbBao9zNLhDQkPWPk
	gZvp0Bbv40K5uwxKXgF/FuUwfogOUs5hgVmDOzHr4=
X-Received: by 2002:a05:6870:c68d:b0:220:fffc:e085 with SMTP id cv13-20020a056870c68d00b00220fffce085mr1303483oab.18.1711083899969;
        Thu, 21 Mar 2024 22:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE24GHuw+CdnIpdSdqKXHD7Z9AvHsfAd4wX3hyEKpR/0MEOrLQyQiKNbpgMQMKdPjgOefKCtlRPdKEBz0u857Y=
X-Received: by 2002:a05:6870:c68d:b0:220:fffc:e085 with SMTP id
 cv13-20020a056870c68d00b00220fffce085mr1303475oab.18.1711083899704; Thu, 21
 Mar 2024 22:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240320102025.11327-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs-x-W2DHh8U=+0ORnq7=kjw9SJNNtDFfGNjC2KqqPZeA@mail.gmail.com> <1711074462.3244817-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711074462.3244817-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:04:48 +0800
Message-ID: <CACGkMEtOjPYuPi7MQcnp+TroxLKa4YtpTdsP4bNUSxUV8rgq3A@mail.gmail.com>
Subject: Re: [PATCH vhost] virtio_net: update the hdr_len calculation for xmit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Spike Du <spiked@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 10:29=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Thu, 21 Mar 2024 12:17:54 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Mar 20, 2024 at 6:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > The virtio spec says:
> > >     If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options ha=
ve
> > >     been negotiated:
> > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
> > >         and gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the driver
> > >         MUST set hdr_len to a value equal to the length of the header=
s,
> > >         including the transport header.
> > >
> > >         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotia=
ted,
> > >         or gso_type is VIRTIO_NET_HDR_GSO_NONE, the driver SHOULD set
> > >         hdr_len to a value not less than the length of the headers,
> > >         including the transport header.
> > >
> > > So if the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated, the
> > > hdr->hdr_len should be eth header + ip header + tcp/udp header.
> > >
> > > But now:
> > >     hdr->hdr_len =3D __cpu_to_virtio15(little_endian, skb_headlen(skb=
));
> > >
> > > The skb_headlen() returns the linear space of the skb, not the header
> > > size that only match the case the VIRTIO_NET_F_GUEST_HDRLEN feature h=
as
> > > not been negotiated, or gso_type is VIRTIO_NET_HDR_GSO_NONE.
> > >
> > > We do not check the feature of the device. This function is a common
> > > function used by many places. So we do more stricter work whatever
> > > the features is negotiated.
> > >
> > > For the case skb_is_gso(skb) is false, if none of the
> > > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have been negotiated=
,
> > > the spec not define the action of setting hdr_len. Here I set it to
> > > skb_headlen(). If one of the above features have been negotiated, we
> > > should set a value not less than the length of "eth header + ip heade=
r +
> > > tcp/udp header". So the skb_headlen() also is a valid value.
> > >
> > > For the case skb_is_gso(skb) is true, it implies that one of
> > > VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options MUST have been
> > > negotiated. If the VIRTIO_NET_F_GUEST_HDRLEN is negotiated, we MUST s=
et
> > > it to the length of "eth header + ip header + tcp/udp header".
> > > If the VIRTIO_NET_F_GUEST_HDRLEN is not negotiated, that still be a
> > > valid value.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Reported-by: Spike Du <spiked@nvidia.com>
> > > ---
> > >  include/linux/virtio_net.h | 41 ++++++++++++++++++++++++++++--------=
--
> > >  1 file changed, 31 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > index 4dfa9b69ca8d..51d93f9762d7 100644
> > > --- a/include/linux/virtio_net.h
> > > +++ b/include/linux/virtio_net.h
> > > @@ -201,24 +201,45 @@ static inline int virtio_net_hdr_from_skb(const=
 struct sk_buff *skb,
> > >
> > >         if (skb_is_gso(skb)) {
> > >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> > > +               u32 hdrlen;
> > >
> > > -               /* This is a hint as to how much should be linear. */
> > > -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> > > -                                                skb_headlen(skb));
> > > -               hdr->gso_size =3D __cpu_to_virtio16(little_endian,
> > > -                                                 sinfo->gso_size);
> > > -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > > +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
> > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> > > -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > > +                       hdrlen =3D tcp_hdrlen(skb) + skb_transport_of=
fset(skb);
> >
> > So could evil guests give us a 0 hdrlen through this. If yes, it seems
> > much more dangerous than headlen or we need harden the value as
> > 9181d6f8a2bb32d158de66a84164fac05e3ddd18 did.
>
> Spec says:
>         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated, and
>         gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the device MAY use
>         hdr_len as the transport header size. Note: Caution should be tak=
en by
>         the implementation so as to prevent a malicious driver from attac=
king
>         the device by setting an incorrect hdr_len.
>
>         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotiated,=
 or
>         gso_type is VIRTIO_NET_HDR_GSO_NONE, the device MAY use hdr_len o=
nly as
>         a hint about the transport header size. The device MUST NOT rely =
on
>         hdr_len to be correct. Note: This is due to various bugs in
>         implementations.
>
> The device nerver trust the hdr_len completely.
> So I think that is safe.

It doesn't, there's no way to audit all the existing implementations of vir=
tio.

For example, have you seen the commit I've pointed to you?

>
>
> >
> > > +
> > > +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
> > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> > > -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > > +                       hdrlen =3D tcp_hdrlen(skb) + skb_transport_of=
fset(skb);
> > > +
> > > +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
> > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> > > -               else
> > > +                       hdrlen =3D sizeof(struct udphdr) + skb_transp=
ort_offset(skb);
> > > +
> > > +               } else {
> > >                         return -EINVAL;
> > > +               }
> > > +
> > > +               /* One of VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO op=
tions MUST
> > > +                * have been negotiated. If the VIRTIO_NET_F_GUEST_HD=
RLEN is
> > > +                * negotiated, we MUST set it to the length of "eth h=
eader + ip
> > > +                * header + tcp/udp header".  If the VIRTIO_NET_F_GUE=
ST_HDRLEN
> > > +                * is not negotiated, that still be a valid value.
> > > +                */
> >
> > I'd stick the headlen for deivce without GUEST_HDRLEN. It seems much
> > more safe as we don't want to break legacy devices.
>
> I do not get it.

if (GUEST_HDRLEN)
    tell the offset of the payload
else
    tell the headlen (stick to the old behaviour)

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> >
>

