Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348E26CE17
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276935; cv=none; b=lvyq8REe9Apba5d60Sza9FQhxmERw+mUPjYD/MQr7lIHTJSm5p3Ah1NHVVLz9cKIY7hMKrKJDyAJcB5F+htsdzavW3cjVcMOwk2rzZRbDxLofrr9O7lSWtHiJL3pEIyIIdJKO2rfGOfWXT8Sld+fdzHx8DzHehlIiEWg8dknKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276935; c=relaxed/simple;
	bh=RN85k6AHL2pQ5CqZYH41YO/5F+DbetbZxo60cWxsByA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTHg1yhsAGCIQb97Joju+DAh7ssf4Ij09FwdGKYTvli6iix0z92LN2LM7vVtshbgbC8kh4gLHvqUEHIf5sJzX0AmO6QuSZ4mo5b+xvuP3grR/Zfv/+6Qq1r6DeNBigvuKqKPy/kLguS5GBc0qg3tulAOifrkqluTQ1o3VhG8FnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rnd6QOOP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rnd6QOOP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762276932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXDflPqYnW7EZU/LpvY0qXtFQSuEG8JnIwAlz6RqROg=;
	b=Rnd6QOOP4pF8T303A1vcCUuInVWGjGltdEPxV8Fi9ag1AdNGPnTOF541QoQdQNpwdNauvw
	ViPYRpfE8WgQdxLIXLDG6sNgaPkMcHK1gB+63htO7C7UnWkgJiV9ltGCGcwgc0sYpw0+2A
	+pyVPHZ88qMhmnRtf8vReAKXHlMwalo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-TlS46sCWN2KNET1nOIo27g-1; Tue, 04 Nov 2025 12:22:09 -0500
X-MC-Unique: TlS46sCWN2KNET1nOIo27g-1
X-Mimecast-MFC-AGG-ID: TlS46sCWN2KNET1nOIo27g_1762276928
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b6d42c454c2so591701566b.0
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 09:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762276928; x=1762881728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXDflPqYnW7EZU/LpvY0qXtFQSuEG8JnIwAlz6RqROg=;
        b=GFkKIh0xc+47xr+4+pkY2eyanNzDoItNzsThpGoeYWwXfn7Dxb+UCzhspjEFCXLpGa
         D7bw9qMTTSzg0zBpDq1BLFoHrL8vg/3Qw0xd4p3L5WUiqfHrPUkg3NaJW4mPHflVO5pB
         ixGtUFCF0EYlrZwuScSQlYkAAn1TX63Yf+lqj3yMCXir6fIYeRq/XiVqwX0Wnkg3fMb6
         qFu8+emHQMjg4QkhxT2k+11oksLVddqorjlfAcS2vmXLIreIyj/Du7ZS/158befvHaIK
         bUv7G+zfikKC7b3TGJ4cfQRZaOgkOplPrROumHKT4O25bjv755guNAlyRUZ7T0j9avjP
         e/qg==
X-Forwarded-Encrypted: i=1; AJvYcCXJq3cTa/2Fw+kGOJug/5U+h6CCk5dDIVeYXGZOHwE7pFYjwx1WXESEcLuEpUeLSv/ITGbrw7bkTk5dyG/44g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx17KZzdyUYAOhL42QY2pymlkgEVw01vnjCJUvh9qVvhDFe6Yju
	AJXFeR8qGpDzg3Jza4dDvwWtgyRsm69CzSyO+HDVb5447kVEBYuXQmn4eZkHJ3Wm4bLEFzIjPxJ
	sJy6KMIkz/d83wg3ILlVvXzzfA72IYxRQ6QngnahPaOw6zf5h4OqACr3gGE8kJ5vTyaFL+HWmST
	kpE9Wy8FB2Hpr1sqEUN+8Cbkqxq7gjFWWfT58kj51hO2c=
X-Gm-Gg: ASbGncuK/LI7nsoJDeojTUvI4U79BbGO0tTWf02aHjEoAhrWHV4K8l9lwG5bxDwLdj4
	lEvSRWvagTR1Qp3xht39Xyb6rVRUhgVT0+6Yz9UT7JAOz0671823JoRVm6C/ZVclzY9X152ppKA
	jbrrFV2D1a/j2OQVUtoEqy/3oLlF0qVi/OaiDd6uuy0UVITP1qu2C6Om3H
X-Received: by 2002:a17:906:dc92:b0:b71:88eb:e60c with SMTP id a640c23a62f3a-b7188ebf492mr614834366b.44.1762276928040;
        Tue, 04 Nov 2025 09:22:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmS15xkBQlo46WUljLA50Fixrdz+Xfp9YJOuOn440rslgPxVsSs5bO8JGYSwoCQVGwl9vZDe3sCRPYTRWVVjg=
X-Received: by 2002:a17:906:dc92:b0:b71:88eb:e60c with SMTP id
 a640c23a62f3a-b7188ebf492mr614831566b.44.1762276927657; Tue, 04 Nov 2025
 09:22:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251031060551.126-1-jasowang@redhat.com>
In-Reply-To: <20251031060551.126-1-jasowang@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 5 Nov 2025 01:21:29 +0800
X-Gm-Features: AWmQ_bmCsEsZ54yScl_2yysAyvg-JGUKJB9xsSDFcnkTf1mDrO5lo_hg0ahm2LQ
Message-ID: <CAPpAL=ybrp2kBCLivWpX_0NpV7tiCS26o6tzeDea6RWsAkS2Hg@mail.gmail.com>
Subject: Re: [PATCH net V2] virtio_net: fix alignment for virtio_net_hdr_v1_hash
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C_e1rCz3h5Z3nmf2NYbGF9O1JTrU6BAvQe3_AZaMiGU_1762276928
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Oct 31, 2025 at 2:06=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> From: "Michael S. Tsirkin" <mst@redhat.com>
>
> Changing alignment of header would mean it's no longer safe to cast a
> 2 byte aligned pointer between formats. Use two 16 bit fields to make
> it 2 byte aligned as previously.
>
> This fixes the performance regression since
> commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
> virtio_net_hdr_v1_hash_tunnel which embeds
> virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
> shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.
>
> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - Fix build issues of virtio_net_hdr_tnl_from_skb()
> ---
>  drivers/net/virtio_net.c        | 15 +++++++++++++--
>  include/linux/virtio_net.h      |  3 ++-
>  include/uapi/linux/virtio_net.h |  3 ++-
>  3 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..e6e650bc3bc3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2539,6 +2539,13 @@ static struct sk_buff *receive_mergeable(struct ne=
t_device *dev,
>         return NULL;
>  }
>
> +static inline u32
> +virtio_net_hash_value(const struct virtio_net_hdr_v1_hash *hdr_hash)
> +{
> +       return __le16_to_cpu(hdr_hash->hash_value_lo) |
> +               (__le16_to_cpu(hdr_hash->hash_value_hi) << 16);
> +}
> +
>  static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr=
_hash,
>                                 struct sk_buff *skb)
>  {
> @@ -2565,7 +2572,7 @@ static void virtio_skb_set_hash(const struct virtio=
_net_hdr_v1_hash *hdr_hash,
>         default:
>                 rss_hash_type =3D PKT_HASH_TYPE_NONE;
>         }
> -       skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_t=
ype);
> +       skb_set_hash(skb, virtio_net_hash_value(hdr_hash), rss_hash_type)=
;
>  }
>
>  static void virtnet_receive_done(struct virtnet_info *vi, struct receive=
_queue *rq,
> @@ -3311,6 +3318,10 @@ static int xmit_skb(struct send_queue *sq, struct =
sk_buff *skb, bool orphan)
>
>         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>
> +       /* Make sure it's safe to cast between formats */
> +       BUILD_BUG_ON(__alignof__(*hdr) !=3D __alignof__(hdr->hash_hdr));
> +       BUILD_BUG_ON(__alignof__(*hdr) !=3D __alignof__(hdr->hash_hdr.hdr=
));
> +
>         can_push =3D vi->any_header_sg &&
>                 !((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
>                 !skb_header_cloned(skb) && skb_headroom(skb) >=3D hdr_len=
;
> @@ -6750,7 +6761,7 @@ static int virtnet_xdp_rx_hash(const struct xdp_md =
*_ctx, u32 *hash,
>                 hash_report =3D VIRTIO_NET_HASH_REPORT_NONE;
>
>         *rss_type =3D virtnet_xdp_rss_type[hash_report];
> -       *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> +       *hash =3D virtio_net_hash_value(hdr_hash);
>         return 0;
>  }
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4d1780848d0e..b673c31569f3 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -401,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>         if (!tnl_hdr_negotiated)
>                 return -EINVAL;
>
> -        vhdr->hash_hdr.hash_value =3D 0;
> +       vhdr->hash_hdr.hash_value_lo =3D 0;
> +       vhdr->hash_hdr.hash_value_hi =3D 0;
>          vhdr->hash_hdr.hash_report =3D 0;
>          vhdr->hash_hdr.padding =3D 0;
>
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_=
net.h
> index 8bf27ab8bcb4..1db45b01532b 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -193,7 +193,8 @@ struct virtio_net_hdr_v1 {
>
>  struct virtio_net_hdr_v1_hash {
>         struct virtio_net_hdr_v1 hdr;
> -       __le32 hash_value;
> +       __le16 hash_value_lo;
> +       __le16 hash_value_hi;
>  #define VIRTIO_NET_HASH_REPORT_NONE            0
>  #define VIRTIO_NET_HASH_REPORT_IPv4            1
>  #define VIRTIO_NET_HASH_REPORT_TCPv4           2
> --
> 2.31.1
>
>

