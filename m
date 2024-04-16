Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0184DED
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252010; cv=none; b=cuJ3EYs0Ok0oOskUwY8h5hHRCc6p6kOrqClC+gI/5z3fpJLpsyR3ccKuOd6Nw9NSNHhJZgjj8FgpYyo94zb1GSf/zBJ/PIyH8j0oox3XnDRlGpFpBX4jQwXn5mBIhUJ5R1x0JHBjrO108Oro8Mqw60Mms4HpDjMIujtSOrU6toY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252010; c=relaxed/simple;
	bh=yWsm5BADRNm0BAbA8BrXoabIASc6hnzuKhZ+xqYwZFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6aD+tY9MPOGxNJ2mXbkfZigEaIoy5I5eueDGQrgyaKKleYMSpMN4B8y2aNB0uYrwgDXTPuUMUFqhaRQQUSm0L78c5YOUcoA2dZrJIw+BQNjPPmHnm+Q+zER1HZBTsuY0Pr8uaYSHVg+QamkBwRZiofzq5+BnU7hKJHxXbTLJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoRLkf0N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoRLkf0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713252007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6JZjfWmVVy6GZCTR5QhlAS0fPiwwYqciHqJUFxR3Hw=;
	b=DoRLkf0Nkg+7SYW8mNbJdWq1ekh2ePmm+crh29nNXhTFsBgcBXLGyF3tpOwNiWfGjGkroR
	1LffoFxEAc2tJCCswlEtO8GuLR2nqnEmGMGSlyS5QMNybBY8i5pdg8h4NZkNoPzRqLWM+5
	3MssBH1uucflsEVhUqdxjGouTlz1ujQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-wlRzcMtzOhmDTQB4fdFFvQ-1; Tue, 16 Apr 2024 03:20:04 -0400
X-MC-Unique: wlRzcMtzOhmDTQB4fdFFvQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5d396a57ea5so2700319a12.2
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 00:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713252003; x=1713856803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6JZjfWmVVy6GZCTR5QhlAS0fPiwwYqciHqJUFxR3Hw=;
        b=cookQit/Kz07UYxqmYvyzJKYqPyBfgIn7QSTMEihOH7UGureFKFwwYzEXTmiovkj0A
         rY+kVxe6sHgJONKTB9+uyXNpyXb1cVCglGRmM40it3++7B1GjAIfQZilHtayNvi0xiQN
         4phD/W7EvT5uxQINwTy9FOhgLcpC+fMpbpU8KTVGsgr5U7IcCN5ES3CY6fL8F7cF9VR3
         I9XamaTrRAhuP5OVl4QStlso0liCnoCcRhUl6FUbVRg7Z1NPv5onrEpd1qKT42W578W2
         7m+iWX6DNEUn2Dvww/1s/qPI6gYc7R6Aep9W9LqnNt03t2hqoQX7hkk2om+x50QNSG6x
         0GOA==
X-Forwarded-Encrypted: i=1; AJvYcCXNFXhSoCvpYNYsfnDc2S6PVKTLQ8LcUbhb2uAf4AXD7cS3SbTeNihSdcqLBoMnDlM8Avdhb0lPk8739bxAoteKN+fWKsYYF+Kko+RAUGg=
X-Gm-Message-State: AOJu0YzIeMEmD36UxMSGoD2I5wjtP31WwsCs9VTiHLVRDQP0YVs9Ba/C
	5C6P2VicFxJ5SASadfb0zft1VR4peEfcU4Po6KwyZQMC/FutSUrCLak0sEt2e3tzuMJuB0WDjXf
	wIK1U7U94rCKz96XLvptwYqPVOMglEeHAlJNogsohyGO3eouGyafE4aobCoE7kpMxhu0mi2xZTW
	ZrvxMtc8twn17MA34V2EQFDm9ewRFOMmnkJwzGI+A=
X-Received: by 2002:a17:90b:3a8e:b0:2a5:275c:ed with SMTP id om14-20020a17090b3a8e00b002a5275c00edmr10702678pjb.23.1713252003257;
        Tue, 16 Apr 2024 00:20:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+l20/tJxppb54gd4K/tvseZzfAqVGlIC9/84+hZbdu2wNQwshpvR1SZGpF1E0rlbB94MitQIqdwJz5TJsdis=
X-Received: by 2002:a17:90b:3a8e:b0:2a5:275c:ed with SMTP id
 om14-20020a17090b3a8e00b002a5275c00edmr10702656pjb.23.1713252002908; Tue, 16
 Apr 2024 00:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240416061943.407082-1-liangchen.linux@gmail.com>
In-Reply-To: <20240416061943.407082-1-liangchen.linux@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Apr 2024 15:19:51 +0800
Message-ID: <CACGkMEuJBdsePgszsM51DZc1GvF0naorHDsMR+SGZ1SiA6jrZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 2:20=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing
> XDP hints through kfuncs to allow XDP programs to access the RSS hash.
>
> 1.
> https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.=
com/#r
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>   Changes from v7:
> - use table lookup for rss hash type
>   Changes from v6:
> - fix a coding style issue
>   Changes from v5:
> - Preservation of the hash value has been dropped, following the conclusi=
on
>   from discussions in V3 reviews. The virtio_net driver doesn't
>   accessing/using the virtio_net_hdr after the XDP program execution, so
>   nothing tragic should happen. As to the xdp program, if it smashes the
>   entry in virtio header, it is likely buggy anyways. Additionally, looki=
ng
>   up the Intel IGC driver,  it also does not bother with this particular
>   aspect.
> ---
>  drivers/net/virtio_net.c        | 42 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_net.h |  1 +
>  2 files changed, 43 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..1d750009f615 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4621,6 +4621,47 @@ static void virtnet_set_big_packets(struct virtnet=
_info *vi, const int mtu)
>         }
>  }
>
> +static enum xdp_rss_hash_type
> +virtnet_xdp_rss_type[VIRTIO_NET_HASH_REPORT_MAX_TABLE] =3D {
> +       [VIRTIO_NET_HASH_REPORT_NONE] =3D XDP_RSS_TYPE_NONE,
> +       [VIRTIO_NET_HASH_REPORT_IPv4] =3D XDP_RSS_TYPE_L3_IPV4,
> +       [VIRTIO_NET_HASH_REPORT_TCPv4] =3D XDP_RSS_TYPE_L4_IPV4_TCP,
> +       [VIRTIO_NET_HASH_REPORT_UDPv4] =3D XDP_RSS_TYPE_L4_IPV4_UDP,
> +       [VIRTIO_NET_HASH_REPORT_IPv6] =3D XDP_RSS_TYPE_L3_IPV6,
> +       [VIRTIO_NET_HASH_REPORT_TCPv6] =3D XDP_RSS_TYPE_L4_IPV6_TCP,
> +       [VIRTIO_NET_HASH_REPORT_UDPv6] =3D XDP_RSS_TYPE_L4_IPV6_UDP,
> +       [VIRTIO_NET_HASH_REPORT_IPv6_EX] =3D XDP_RSS_TYPE_L3_IPV6_EX,
> +       [VIRTIO_NET_HASH_REPORT_TCPv6_EX] =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX=
,
> +       [VIRTIO_NET_HASH_REPORT_UDPv6_EX] =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX
> +};
> +
> +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> +                              enum xdp_rss_hash_type *rss_type)
> +{
> +       const struct xdp_buff *xdp =3D (void *)_ctx;
> +       struct virtio_net_hdr_v1_hash *hdr_hash;
> +       struct virtnet_info *vi;
> +       u16 hash_report;
> +
> +       if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> +               return -ENODATA;
> +
> +       vi =3D netdev_priv(xdp->rxq->dev);
> +       hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hd=
r_len);
> +       hash_report =3D __le16_to_cpu(hdr_hash->hash_report);
> +
> +       if (hash_report >=3D VIRTIO_NET_HASH_REPORT_MAX_TABLE)
> +               hash_report =3D VIRTIO_NET_HASH_REPORT_NONE;
> +
> +       *rss_type =3D virtnet_xdp_rss_type[hash_report];
> +       *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> +       return 0;
> +}
> +
> +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D {
> +       .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> +};
> +
>  static int virtnet_probe(struct virtio_device *vdev)
>  {
>         int i, err =3D -ENOMEM;
> @@ -4747,6 +4788,7 @@ static int virtnet_probe(struct virtio_device *vdev=
)
>                                   VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
>
>                 dev->hw_features |=3D NETIF_F_RXHASH;
> +               dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
>         }
>
>         if (vi->has_rss_hash_report)
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_=
net.h
> index cc65ef0f3c3e..3ee695450096 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -176,6 +176,7 @@ struct virtio_net_hdr_v1_hash {
>  #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
>  #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
>  #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> +#define VIRTIO_NET_HASH_REPORT_MAX_TABLE      10

This should not be part of uAPI. It may confuse the userspace.

Others look good.

Thanks

>         __le16 hash_report;
>         __le16 padding;
>  };
> --
> 2.40.1
>

