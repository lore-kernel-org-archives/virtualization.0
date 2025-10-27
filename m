Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A876214807
	for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761543259; cv=none; b=cGSVQ7bs3XkxWwtzvm9T0B8QmoMeds1ZokPQQjueS8uYMLx2p6s31T4zfOquV/55t5mbCRv+AnPZpnA8a39RmJVy4g8dSsn4Ar2iRYgApO3wtOHLoN5x7zN1dADVjL7S4wfDwSE34kkp4FSN22Vx1N+hIqZab/P/DtX/5sCBRj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761543259; c=relaxed/simple;
	bh=VeHi30FPvS0E1mPLOV2Rmu1L/d/UXODaf1G6DymqOCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWFe34xHtDzqJM74nwCf5IYvvyEslsyvTiryZVpYGIgt4IDm89nbdFzZ1czEtCHv2HQOIA2pEzlcxXAzNv70GWWk2iiEthHeR4T4QHgHgC4SYsIALQpI9POAbqMWBhLDuZk6Jda7Q6fxTKNG4jWhLJJsSo08LgnF0PDkd1grgnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HjdHXKsm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjdHXKsm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761543257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4poMbsgbm/wTcWkoIVEYoSm+itLN2T4gDpEs8mFFYI=;
	b=HjdHXKsm70CqBe5/yBQltVQ2EklPdSLxhUchXRfEe0ay29sxMKRl7BrfmpmyPS4gbWp97k
	1D54f41QWkPBmZCks0wMf7PdRhvvDGQ/gIw7auaGXCYjHjgbWe7/92GPApfQF2r2XRU9lM
	ioOgSJn2WA8nSH8A8fA6I0nsuMDcxUY=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-LJvVwCVZNrONU2abCwIZug-1; Mon, 27 Oct 2025 01:34:15 -0400
X-MC-Unique: LJvVwCVZNrONU2abCwIZug-1
X-Mimecast-MFC-AGG-ID: LJvVwCVZNrONU2abCwIZug_1761543255
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5db2984cd21so9928282137.3
        for <virtualization@lists.linux.dev>; Sun, 26 Oct 2025 22:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761543255; x=1762148055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4poMbsgbm/wTcWkoIVEYoSm+itLN2T4gDpEs8mFFYI=;
        b=nASM1dthhiTuIfKl3c1yA6sWvRhAS/TInW4Oyb2C1T0SBxzzVsbCLBNNNUci/cw5gg
         r86oy1q+QRn9lXtrY1wgYF9ZiSZKcNeYxHIdFjCWU/8lKYHMPpYSUYXFPbl7mpNM9gal
         YxGCn8ia3Nu8GS3bFizS2YMwCUk0GWlyNh6mqegx4ItKJ8JyrKJEjDDfOG2cbGRD7DQS
         f2VCrcJQkEgrRZQa9NGGQbRZj6ek7fACTISWSHg4tS60BVptadp5Pvavxt2P2d0Tpbo6
         iBFdf/mun7fa7t18ReTadpLstlftumlyMIBv6Lm/pjKj8v4lJlbVp6CLwpRl9uTxtbPZ
         wSOA==
X-Forwarded-Encrypted: i=1; AJvYcCXS190QzpJ5+58nGtSytQexkZXwCF8dY3A+g5cCavmTys6PkwkUbmzR5flf6UGlbGWnKDTn2dv6HrqsqJCPgA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq9r/XMi4Bl4FCwOu7wuKZvV8Ql4EtL/xFtrSIN7OOL3nrVLQA
	KS6s8ey0CeblwBMKtajuq/BkWd84VwWgBi3iFSPozAeq+WsEXjUJS9NNLUC+21LJ3/jOckOcPu7
	9XiKtqlSa3xn3h011tq3hUx9P9WXlOxKA/BujMMm4rngwCUezhtp+gLVYcOiWNT7hrKagxTqmHo
	LR8NejAJ7UQvzOZ/L3IebI3AuIpr27vtsoFvMFteQLjYk=
X-Gm-Gg: ASbGncspa3C7JxTr47Us1ZzDoQSKnCnsskKq0EZ3faz1Hwz2NC1TIdJJjTjTGQPZMU3
	9XMbSGP2kJVrlpGFMOrNuaPtK/UvWmETaGRjXyk5TOcwueoulUTNnW+yv1Qi/hiHQd/3/cT0obE
	UHgYCniOwEIE+uD9tclh/BpZ9IpNrOhnb3Uihl3v+yX7k/vjXZFkdo
X-Received: by 2002:a05:6102:c94:b0:5d5:f6ae:38f0 with SMTP id ada2fe7eead31-5db3fa8297dmr3197091137.39.1761543254794;
        Sun, 26 Oct 2025 22:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXxLp95liTwOuaQHppp1XxJZ6TzkMeY4wR/alp4tgZ/UX1fVHxKyWI5KlURF6UfqUGGBV31GC1JGInptq70YY=
X-Received: by 2002:a05:6102:c94:b0:5d5:f6ae:38f0 with SMTP id
 ada2fe7eead31-5db3fa8297dmr3197081137.39.1761543254410; Sun, 26 Oct 2025
 22:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251024074130.65580-1-xuanzhuo@linux.alibaba.com> <20251024074130.65580-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20251024074130.65580-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Oct 2025 13:34:01 +0800
X-Gm-Features: AWmQ_blDXFXKymmUmrrTzT3nQl1-sxWJV-05bny0vZMdr9XPAbpU5X67He0JoIc
Message-ID: <CACGkMEvvjjb_KgHsGiuAvUJaGsBWoijKOz9ELfNOo_qxYWcsrw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/3] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _wKVVNev_LQps_JYrbv-SOfAcaNv8FC8eYj-sDRK3jU_1761543255
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 3:41=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
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
>
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length gues=
t feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_net.h | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4d1780848d0e..a2ade702b369 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -217,20 +217,34 @@ static inline int virtio_net_hdr_from_skb(const str=
uct sk_buff *skb,
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> +               u16 hdr_len =3D 0;
> +
> +               /* In certain code paths (such as the af_packet.c receive=
 path),
> +                * this function may be called without a transport header=
.
> +                */
> +               if (skb_transport_header_was_set(skb))
> +                       hdr_len =3D skb_transport_offset(skb);

This deserve an independent fix?

>
> -               /* This is a hint as to how much should be linear. */
> -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> -                                                skb_headlen(skb));
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

Others look good.

Thanks

