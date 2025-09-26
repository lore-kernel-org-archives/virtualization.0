Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E238DD8
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 04:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758862402; cv=none; b=DW+oWuNyMoq6LzrFV5Jji4Ltd/bOkYBch4mi1/iXsefme+vHHaEPGIussp8OledVZQZOkKrbuprTGSnA9fDNhDR7mVvG5fOUPokEPJFKZ5E22YwUu+F2nVxMVpzPPWizWr+nnWKOcpVBQgqkvUXXIvPQYrC9DA7KOdiiI6XfYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758862402; c=relaxed/simple;
	bh=p8OgjDKlqKgiMFaRAqKJY1gzN6Syy48c4mCc9sh9pMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7BBJNS/C3YJ9oJsbEi9trMe/B1hYOvGAn33SBHu3ny1jkrTzc0jqoUgyQfoWBZe0N1YMts25V9uhoZ3I2Yu8JKiT8k6dHE6Y8EgqohL/vFO0vzoXLRmIqLfc2AJE9B14kJ0fKpxyHnOUzWIcP0rSAP5RCWjRtJ9Nius+McZls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2mv15MM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2mv15MM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758862399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipe76653qksNE5m5Tu3UwejDA9Jg2eMeIFFu07Sa/Jc=;
	b=V2mv15MMDCPZVsYUTw/UoCKMK1F2uZmKjTKqnyIhvNXczjtBukaC5GfNYXLSNmC+QHqwYI
	k/bJjuIeR3CwZyhd/1A7VwV5j4re7zTUHaBSlKJMknPXZBVV+no7mbsmqRON5SmadGcC3Y
	cq5y6zSV6ijYSvF/YjJ+Uf9dc8tF5nQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-oEmZ-m-QP8SsrWMZuemzLg-1; Fri, 26 Sep 2025 00:53:06 -0400
X-MC-Unique: oEmZ-m-QP8SsrWMZuemzLg-1
X-Mimecast-MFC-AGG-ID: oEmZ-m-QP8SsrWMZuemzLg_1758862385
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ecab3865dso2557995a91.1
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 21:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758862385; x=1759467185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipe76653qksNE5m5Tu3UwejDA9Jg2eMeIFFu07Sa/Jc=;
        b=snBJ4k9+gaWyvth9QbpN5DyY5WCAiY83VUCyrrSCHmxvxZamS8ZoFocuAYap0slFkc
         KaDvevSKE20gMDC4bLhGW2RRIuMZ0S/MH47qw3E2V7CMYdYaHwfREW9kqe+8dRkF3tnd
         qpHh/r8b+UpTxL/myZnSPTW0I0EA5q9vbADHz5CDFb7p/O1TP2IYZJdA51R38QM5kghM
         OVvcmWdVQsvAui+S3eUEuVP2gM5mZHdUfKUxX0wNb6uMBVWJ6Pn2zhivNsKR1RYoGqLr
         r7KXVdeCrTMbfK2cY1Alage4lXb0vakWW/Y98GtmP/8GW/1OQbwpZSaGfWa2XR2jckVS
         zBdw==
X-Forwarded-Encrypted: i=1; AJvYcCULzpzKEKajNLw11z5z8NJJo1pPuZgcXrd/F1RJV345GJa5qg0aTgFjAD451xR6/0DkBj1/B7eIGJxMXHbrBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLTXq1Ue7P6HY7JZRr8rZ7Ch27XpKbVPA1lScSnz5jxIkRhv2E
	JOGABfCyYnJkujGQb4aH28NRbp9Uid3s87fl2aEiskMZdwkX3XxOu0P7795C2Ir6Cbh7fX2FLcC
	wxTFgtX/SmRSTPpflCVSRaC6Uued02RSijwIADCfpeghZNKc/P9iPIvUlm3R/TPUCAmgigEG6lO
	nNHGjFLo2InbpKjVx5KYM4BgfAcfgwfSGJFFe+Ro8AkN4=
X-Gm-Gg: ASbGnctDK7Mm7j/5BNJ7DjBF9bVza5n3bSWzA4q1UDlxonMzccKy7n3pXI/ROMKrCvi
	cQ2n4sBRF4hFGni9K6OB6NsZbHtMZU+FfEtfcwfO7Bg7A8kTL2DOgBHebV0apSZX8FeaIDo+c9s
	1Qo8no1UgD+LBZHlJh9Q==
X-Received: by 2002:a17:90b:1809:b0:32e:6fae:ba53 with SMTP id 98e67ed59e1d1-3342a20bdd9mr6808884a91.8.1758862385455;
        Thu, 25 Sep 2025 21:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMmqyM/PNWn17h5S70mcJ3JavjErS0o+QP6dUU2G2gn6USvpy9B+txWp6jCVExFFYakNfKlYlxhtgvqCrCW+8=
X-Received: by 2002:a17:90b:1809:b0:32e:6fae:ba53 with SMTP id
 98e67ed59e1d1-3342a20bdd9mr6808854a91.8.1758862384931; Thu, 25 Sep 2025
 21:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com> <20250925022537.91774-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20250925022537.91774-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Sep 2025 12:52:53 +0800
X-Gm-Features: AS18NWDrdikWUMcD611GxFljDjGpRIrPar_0b_HsS3n9y_SZqw9yGNHwwZQvhiI
Message-ID: <CACGkMEvhABOtHTCVW9sX7p0wo1QCMXMvOAD+u4pzBueoU=MCpg@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: 3oh58nrJGIECDHyKWki2GIKMWAuMdYDxJizEnLovfzY_1758862385
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:25=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
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
>
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length gues=
t feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_net.h | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 20e0584db1dd..4273420a9ff9 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -217,20 +217,25 @@ static inline int virtio_net_hdr_from_skb(const str=
uct sk_buff *skb,
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> +               u16 hdr_len;
>
> -               /* This is a hint as to how much should be linear. */
> -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> -                                                skb_headlen(skb));
> +               hdr_len =3D skb_transport_offset(skb);
>                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
>                                                   sinfo->gso_size);
> -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> +                       hdr_len +=3D tcp_hdrlen(skb);
> +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> +                       hdr_len +=3D tcp_hdrlen(skb);
> +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> -               else

I think we need to deal with the GSO tunnel as well?

"""
    If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit =
or
    VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts fo=
r
    all the headers up to and including the inner transport.
"""

> +                       hdr_len +=3D sizeof(struct udphdr);
> +               } else {
>                         return -EINVAL;
> +               }
> +
> +               hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len=
);

Should we at least check against the feature of VIRTIO_NET_F_GUEST_HDRLEN?

>                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
>         } else
> --
> 2.32.0.3.g01195cf9f
>

