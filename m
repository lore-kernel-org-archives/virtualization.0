Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4038E1C05
	for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 04:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710995084; cv=none; b=YBVrG59zP9PFs5whbrtEFAhmHEdCFaQMthf3qEIhvISJ/IjnY6Bzcl7QEI/oK3RTCYOHqVi/ArVxn4j7ng8KwnPd6+Y8IMGlwEBB5WaclJqBtw1wRiRVqWPMNyzRpWlB+DDHTNctvxpR6VWMJqPMYzKVoehXtgp7o5vMS1a02NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710995084; c=relaxed/simple;
	bh=/29hY5IG7EQlFwEonahgndJyCOBX1B61kvxNuHIb3HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IznbcW+TEjT6vzzmz27pCArJXBbGnH2AR/Cw9jzq1Gzps+oc8MHVq+n0MtuTnt5Rhp5CyX8C1cX+MDhU2N9seyOZpJMOpXb8XOC5rEIHN1zIxwBp4Ryy6kYLgtm1jL8nNVj0vDjslAXEtm6C5YT3yCG61/ZYEvFtVwisy3YZypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWTHvIbI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWTHvIbI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710995082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yke4G17h9FSuhFMTF4qSsCfwNBeje3/pPUgFxfL3or0=;
	b=IWTHvIbIr9znNJ5KzyI+Th+MUf2Ks53Pe/Kp0jsfXw04C0MuChosm4VlcQVj6kkEDa6I/O
	zqp1GPUFmRflpsWQPXFi8zYnGvR1FTuE9J0j1EiwhsFO3ZjWsarNBnb4snn45KmNz+aBjF
	vt92Zl7CvJI4fyzxfI/yVS9zvenmQDM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-URZtyEKtOfWf-L5CWxiFNA-1; Thu, 21 Mar 2024 00:24:40 -0400
X-MC-Unique: URZtyEKtOfWf-L5CWxiFNA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e021b84d95so4437935ad.3
        for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 21:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710995079; x=1711599879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yke4G17h9FSuhFMTF4qSsCfwNBeje3/pPUgFxfL3or0=;
        b=IKKHCK/wnazyRkQKS/T3cFzCNtl11+jHkfZnYf6K6a4DJPjBbc3xAMYVvvk77gwzzM
         +WnPssKHyjpal9/may6qmSXwAbq6/4P8c21GIi6rCw2QUD7Q1mdUxtJLZqYLWjjx3b6p
         1Fhx3zNdxSIBue1Vfriaa8gmwSWbfoqzXqmK04PicVKKYeZmlnyWdyxKVoJ19+eBS7if
         w8XpEDw8uJ8nODOmSTp/FbmExzLa2w0TtpoYnU15yXvm1Yi+uwZB3YtY7ykvUQpBklPT
         dqCrQoo/LrLciQCSojRWZl+RciGmTM8jukDA+E4nr3ysfLW4moexHXPS7zlu9L3sKw9b
         wDcQ==
X-Gm-Message-State: AOJu0Yx8NjwKGH3oC9qvSQf6aMt518L4MGIEd3B/cBtlvivxeKbOBmbu
	rsfLWkrtPH/K5x4O1EamjQZ2nNxg0OJlcUzv4yExmjRYU09LWDnVKVMlmoRf7HQQoY5qf9vyH6+
	ORqXFkwAJ0bpxJ7ha+vMAwBNw7NQxAZ879dkDVFO8rutWNpYIzWwJw7gBHHxWbUxF79sIAZlZJt
	VaRAEGTmqITu1Kx0wTL1nFq2t1OhlnXnJDwtftgGe0tlXYsskAIHWa
X-Received: by 2002:a17:903:228b:b0:1e0:c9a:38db with SMTP id b11-20020a170903228b00b001e00c9a38dbmr16394253plh.35.1710995079719;
        Wed, 20 Mar 2024 21:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9umUJycB954NDEFfLYyn6CE/x8Hhuo1+FkGJozNPzMawLep2HRwqaK3CrS0gDfcw8GiyrCxwOL4xtK1zoUh8=
X-Received: by 2002:a05:6a20:8f29:b0:1a3:5462:f891 with SMTP id
 b41-20020a056a208f2900b001a35462f891mr13999008pzk.14.1710994685995; Wed, 20
 Mar 2024 21:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240320102025.11327-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240320102025.11327-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Mar 2024 12:17:54 +0800
Message-ID: <CACGkMEs-x-W2DHh8U=+0ORnq7=kjw9SJNNtDFfGNjC2KqqPZeA@mail.gmail.com>
Subject: Re: [PATCH vhost] virtio_net: update the hdr_len calculation for xmit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Spike Du <spiked@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 6:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The virtio spec says:
>     If one of the VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have
>     been negotiated:
>         If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
>         and gso_type differs from VIRTIO_NET_HDR_GSO_NONE, the driver
>         MUST set hdr_len to a value equal to the length of the headers,
>         including the transport header.
>
>         If the VIRTIO_NET_F_GUEST_HDRLEN feature has not been negotiated,
>         or gso_type is VIRTIO_NET_HDR_GSO_NONE, the driver SHOULD set
>         hdr_len to a value not less than the length of the headers,
>         including the transport header.
>
> So if the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated, the
> hdr->hdr_len should be eth header + ip header + tcp/udp header.
>
> But now:
>     hdr->hdr_len =3D __cpu_to_virtio15(little_endian, skb_headlen(skb));
>
> The skb_headlen() returns the linear space of the skb, not the header
> size that only match the case the VIRTIO_NET_F_GUEST_HDRLEN feature has
> not been negotiated, or gso_type is VIRTIO_NET_HDR_GSO_NONE.
>
> We do not check the feature of the device. This function is a common
> function used by many places. So we do more stricter work whatever
> the features is negotiated.
>
> For the case skb_is_gso(skb) is false, if none of the
> VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options have been negotiated,
> the spec not define the action of setting hdr_len. Here I set it to
> skb_headlen(). If one of the above features have been negotiated, we
> should set a value not less than the length of "eth header + ip header +
> tcp/udp header". So the skb_headlen() also is a valid value.
>
> For the case skb_is_gso(skb) is true, it implies that one of
> VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO options MUST have been
> negotiated. If the VIRTIO_NET_F_GUEST_HDRLEN is negotiated, we MUST set
> it to the length of "eth header + ip header + tcp/udp header".
> If the VIRTIO_NET_F_GUEST_HDRLEN is not negotiated, that still be a
> valid value.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reported-by: Spike Du <spiked@nvidia.com>
> ---
>  include/linux/virtio_net.h | 41 ++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4dfa9b69ca8d..51d93f9762d7 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -201,24 +201,45 @@ static inline int virtio_net_hdr_from_skb(const str=
uct sk_buff *skb,
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> +               u32 hdrlen;
>
> -               /* This is a hint as to how much should be linear. */
> -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> -                                                skb_headlen(skb));
> -               hdr->gso_size =3D __cpu_to_virtio16(little_endian,
> -                                                 sinfo->gso_size);
> -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> +                       hdrlen =3D tcp_hdrlen(skb) + skb_transport_offset=
(skb);

So could evil guests give us a 0 hdrlen through this. If yes, it seems
much more dangerous than headlen or we need harden the value as
9181d6f8a2bb32d158de66a84164fac05e3ddd18 did.

> +
> +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> +                       hdrlen =3D tcp_hdrlen(skb) + skb_transport_offset=
(skb);
> +
> +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> -               else
> +                       hdrlen =3D sizeof(struct udphdr) + skb_transport_=
offset(skb);
> +
> +               } else {
>                         return -EINVAL;
> +               }
> +
> +               /* One of VIRTIO_NET_F_HOST_TSO4, TSO6, USO or UFO option=
s MUST
> +                * have been negotiated. If the VIRTIO_NET_F_GUEST_HDRLEN=
 is
> +                * negotiated, we MUST set it to the length of "eth heade=
r + ip
> +                * header + tcp/udp header".  If the VIRTIO_NET_F_GUEST_H=
DRLEN
> +                * is not negotiated, that still be a valid value.
> +                */

I'd stick the headlen for deivce without GUEST_HDRLEN. It seems much
more safe as we don't want to break legacy devices.

Thanks

