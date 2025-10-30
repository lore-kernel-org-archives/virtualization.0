Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD732B9B2
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792802; cv=none; b=WG+w6245NluY/HCMQvA/y5j0C7Jms63tedinlBI73A7/86TxIVOYZZmceP3IovyK+bEpVq0KzB0TGfWECanqDVHEGs8PF5Jmou8E02B6mRBpAVvoPIEO4hSE7dFbcfbYRa79QBCidW+qWmlRLJtwNQdxqY9A1n2g6z7xpQcFY3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792802; c=relaxed/simple;
	bh=jzwxuky7qyY30SUTGdO0z8vz+l1kh9dfHf1H3lxmMHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5qVH7bnrWIjCY095P2Wx17zKW8EE7hTSMr5BRKg//Ux9FoUkFkvxGtYTnQUXYsshtR2Dd7olXoVG3Iw6Jbq5EZmeB/qr+h7dTCYoO/On1b90HjHWRIBaDrGvY+KPz43Dj9LeaAi+5A5aBpu5DmTd5HW406kNGm3Bj0hhp02C5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5y1Xe7T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5y1Xe7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761792799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjsYQYRNMIhNAf7/U8NqV3RSAWE80f2s4DbWVuj2fGY=;
	b=G5y1Xe7Tll67y9r/YZ1gYjHKB7pTtK2RbDKu+vy1o2OMzw917nucoFKHC7o4cfaRwN+oEq
	orXchljM+B2k/Ckt5q/FslfOS/DF4WC794am3B1nMmGAPEZG9Vmg2cPe+dqeEDprYpqFXT
	Y8afFk8kiEsH1LK6sgDz5AApk1v1LVA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-PpI4ankPMYq3odagvyhEIQ-1; Wed, 29 Oct 2025 22:53:18 -0400
X-MC-Unique: PpI4ankPMYq3odagvyhEIQ-1
X-Mimecast-MFC-AGG-ID: PpI4ankPMYq3odagvyhEIQ_1761792797
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b63038a6350so1106192a12.0
        for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 19:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761792796; x=1762397596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjsYQYRNMIhNAf7/U8NqV3RSAWE80f2s4DbWVuj2fGY=;
        b=TWWhpUQGz/vecF97T1fpGQuklAs9ohwoF+gtrEP9qgFi+8le4dDRLLn0EcgIV4FBq9
         v+OXUEb8jpmtipShESt/oDKBlnmIsJqNZkhIveQ38Xv090s+nYZ01PtVCkR3lRayUjMH
         LSR6az1pPtt10LJsUA5j+MQPfws+UEUsx1RNsk/w7qK/qD0ulW1T/PuHfdMIz64DOExj
         kgqkESZcPwEb7jZD6rkpL9n8t8APto92yNdHwcgjFSCuUhFCz6SeILUcqn1AnZt3E9gA
         v/ZEVO3V9iCekk1ZMFkYJHGu2ZlZNoGaTwE+ZewpfHWUpvz7W6yyr2B5FbupUDxEK+1G
         6ejg==
X-Forwarded-Encrypted: i=1; AJvYcCW8zEoM7AItBM/1M8J0rANFGq4f8Pcwdy0pL1x/Xf2eWy9v+Je4VqKLPi5BxPk9plDBRF+HijNfoHUJ+LdhLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHNJbw5qwmFt8Rn84jPat6slimWFlFVprJ3NhrlVQXyp/gSczR
	7MpdqYUveyb1+vw93q6xJKuTlgdfOeG60sgaVPHovGTFBgk9Pm6DrhRmtcEHHjl2U7nYlCFW6Tz
	Kt4+yZKFGi6lB5MRfaWKg3lxSKPfQg1olMeAc4hv1MkbNCBjJSTDvNB8i3EKRFlyagiLvRk5m+2
	Z9xYSMZxByq6Vh7j9/QpAEe5nWfokLqXpYm12H+1zA6bGyVIiPM0DEiCWP
X-Gm-Gg: ASbGnctgmKJktNs6Ii89vvcGgwH8dK5KLplLL3WMPoGcfmBhZLR7pz85uwS6ueru9ON
	Iy/3no2+0qC6QxHT8xLEq/Tcc4g/t3LHxiltFEWG7q+7ElZDjGk4uFSCl7dFtY7SP8VGqedl0dt
	SA5/jSr8XT1fyo41QqecG1fZVOtSYsaIjwkBhjTuid3O+NWl+TTDc2lx5K
X-Received: by 2002:a05:6a20:2451:b0:2ab:a456:9b09 with SMTP id adf61e73a8af0-3477bbe375bmr2392927637.15.1761792796514;
        Wed, 29 Oct 2025 19:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELMHFStV21waj0bP6q/2p08rAPkLlE4mfBjZ3827b23FGQXmJIODmUgsABbPjVg2nksbo5B6+Hm9pb7WvgNkw=
X-Received: by 2002:a05:6a20:2451:b0:2ab:a456:9b09 with SMTP id
 adf61e73a8af0-3477bbe375bmr2392894637.15.1761792796097; Wed, 29 Oct 2025
 19:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com> <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Oct 2025 10:53:01 +0800
X-Gm-Features: AWmQ_bll86rnWy9pG9gq4GCIiPauN6NE6YO3ljaSX-NQc3zI_7ME6G9qYDKXXCw
Message-ID: <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, Willem de Bruijn <willemb@google.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KtDN3O8E4IH-eMYkeO6mni8Lxh-tNohZRqU5E8beLKY_1761792797
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:09=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
>
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
>
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This commit fixes that issue.

I still think it would be more safe to check the feature and switch to
the new behaviour if it is set. This seems to be more safe.

But I'm fine if it's agreed that this could be the way to go.

>
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length gues=
t feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_net.h | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 710ae0d2d336..6ef0b737d548 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -217,25 +217,35 @@ static inline int virtio_net_hdr_from_skb(const str=
uct sk_buff *skb,
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> +               u16 hdr_len =3D 0;
>
>                 /* In certain code paths (such as the af_packet.c receive=
 path),
>                  * this function may be called without a transport header=
.
>                  * In this case, we do not need to set the hdr_len.
>                  */
>                 if (skb_transport_header_was_set(skb))
> -                       hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> -                                                        skb_headlen(skb)=
);
> +                       hdr_len =3D skb_transport_offset(skb);
>
>                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
>                                                   sinfo->gso_size);
> -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> +                       if (hdr_len)
> +                               hdr_len +=3D tcp_hdrlen(skb);
> +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> +                       if (hdr_len)
> +                               hdr_len +=3D tcp_hdrlen(skb);
> +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> -               else
> +                       if (hdr_len)
> +                               hdr_len +=3D sizeof(struct udphdr);
> +               } else {
>                         return -EINVAL;
> +               }
> +
> +               hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len=
);
> +
>                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
>         } else
> --
> 2.32.0.3.g01195cf9f
>

Thanks

