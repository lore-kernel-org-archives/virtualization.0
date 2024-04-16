Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267B33998
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247519; cv=none; b=mtuLZ9yUYE5rnQ2doSUxrpGZ3Smcp5M4f0c8HE2E7xz6nO2T3Ynhlsy2rynLSaSj4SDXprsljotSblRIMrK4rEiIdhqLsPbMkAM9YyQTxezI1gq3U1hLHluMi6KSJwGGnOfYdqvf8SxLL34XWvjfc7gO/ueq0UZSqtAKutVbvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247519; c=relaxed/simple;
	bh=2va6TA07tPbZHQYfmfqamjpjSCAGwmqHo6c9sDHfueo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJlJfd+VbQk3A+jo+tIXp9jkjZC2MZ5y8JJKFXFbShPHYWJNm0tl0fpg05XkgLP4D2tYoMwQCyT4KuVmGkDTdskH42ddvQtGh6FMJcxJY7FJdS8rPvBdb+54tJJBg+DVjsa74BgYVf9+rgipLfU2PKwHXduJn+JIedsYFBEwOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qv8ZjpTi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv8ZjpTi"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57013379e17so2428506a12.0
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 23:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713247516; x=1713852316; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVeIu3iZuh5BeH0nO5+xgyxUTQzhqaD9DYOn+xF/D1k=;
        b=Qv8ZjpTijhuGKPDa0WTDhopgLdziVOdrWbmJa2LWp0FA0/NUFKHev7h62JnNUrwNAn
         TXgG9eiZPiJzZumbOziKrfkyNDnLldlZ4fFZixEA67vQHeYbFlvWumzZVAr3TsikwtGy
         osX9Ax/rj/Gmn5GBDqS09+4Gtypa1r5iW6TlVuG/YqcoskBBwxh/RV7sGblDYHiC8MQo
         4P+568oE0QW68oWe1ppo16ai8WXYqio8lxu2cdersyNLchQv9az5flpFHwqlBOpBW1U7
         mVnyi75UfGe9XsuzAwyKkzJB6l6LkrDZ63KjSO06dnQbkmXGnLLtPinzjcqcGA9OExzX
         wwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713247516; x=1713852316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVeIu3iZuh5BeH0nO5+xgyxUTQzhqaD9DYOn+xF/D1k=;
        b=na6Yu5T7GBytgHx3mdZL7sx0Kaz08wd11bphiy7JvBQ6bNXie9W3fcYLWArZi5T6C4
         SqPoIosnK4FmHkTbjJFrZHhN31Nfqb2YGx748U9Cc9pQcpBI9AP1zkmrw+8eMBCa9/tM
         PC6g+zKBgnEUDsU7MIY/wOwOQSarDw6PoisrFy2NJCqrnMVXqTdTe+e8sYZMwBZRlgEv
         xDQmNwMY67+5qTAiBcRQ1Mf8yjfXZ1ffsY5EpczEEY4Qie4BWErx9Z3wgOuM0U0Nrcuf
         0C9OWRDzoSLsfVEUdsG5AePyuYkPKdA2RJZpnB5L5AIHj1T5ZA3ev63Kz5mfWpo2qOtL
         OQCw==
X-Forwarded-Encrypted: i=1; AJvYcCWdUf6zYc7eb6ntX9azgr6uCpzWMrlCNMbYnlEKfAYkXDmIwYyLEt/JKn82cF8aZTqS4vZCL6SFfAc/umTd+C0wdAKoTdYhC5BWy9qQ+kk=
X-Gm-Message-State: AOJu0YwkzVXo/WPT4+sUWHfPkLoLGd7vudV8SmoiIorKDmNA76K15UJY
	CuIfEzWE4//OcUzIe02nURZiHEWt2VHY2KqaEVqdO0eSIzRTih2h518w6M1pHX4wVBhiP22rvOG
	8416vXov7X3TjChTZk7Q7LKOQ23c=
X-Google-Smtp-Source: AGHT+IFDDfSvhXKXykNEiYbNF09kT74gern125Ecb7UQX/J1w9LVvZmjMX30hv92cxPrzmNu9rlMSf+Z7OGR8N2wIM0=
X-Received: by 2002:a17:907:9496:b0:a52:30d3:41dd with SMTP id
 dm22-20020a170907949600b00a5230d341ddmr10199039ejc.41.1713247515527; Mon, 15
 Apr 2024 23:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240413041035.7344-1-liangchen.linux@gmail.com> <01c82cfb-e215-4929-9540-484378275ec3@kernel.org>
In-Reply-To: <01c82cfb-e215-4929-9540-484378275ec3@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Tue, 16 Apr 2024 14:05:02 +0800
Message-ID: <CAKhg4t+AzkV3qNfg5CTB8dGy7wk_RfEfO799+P+yAqPncK2=mA@mail.gmail.com>
Subject: Re: [PATCH net-next v7] virtio_net: Support RX hash XDP hint
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, john.fastabend@gmail.com, daniel@iogearbox.net, 
	ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:36=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 13/04/2024 06.10, Liang Chen wrote:
> > The RSS hash report is a feature that's part of the virtio specificatio=
n.
> > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhos=
t
> > (still a work in progress as per [1]) support this feature. While the
> > capability to obtain the RSS hash has been enabled in the normal path,
> > it's currently missing in the XDP path. Therefore, we are introducing
> > XDP hints through kfuncs to allow XDP programs to access the RSS hash.
> >
> > 1.
> > https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@dayni=
x.com/#r
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >    Changes from v6:
> > - fix a coding style issue
> >    Changes from v5:
> > - Preservation of the hash value has been dropped, following the conclu=
sion
> >    from discussions in V3 reviews. The virtio_net driver doesn't
> >    accessing/using the virtio_net_hdr after the XDP program execution, =
so
> >    nothing tragic should happen. As to the xdp program, if it smashes t=
he
> >    entry in virtio header, it is likely buggy anyways. Additionally, lo=
oking
> >    up the Intel IGC driver,  it also does not bother with this particul=
ar
> >    aspect.
> > ---
> >   drivers/net/virtio_net.c | 55 +++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 55 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c22d1118a133..2a1892b7b8d3 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4621,6 +4621,60 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >       }
> >   }
> >
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                            enum xdp_rss_hash_type *rss_type)
> > +{
> > +     const struct xdp_buff *xdp =3D (void *)_ctx;
> > +     struct virtio_net_hdr_v1_hash *hdr_hash;
> > +     struct virtnet_info *vi;
> > +
> > +     if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> > +             return -ENODATA;
> > +
> > +     vi =3D netdev_priv(xdp->rxq->dev);
> > +     hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hd=
r_len);
> > +
> > +     switch (__le16_to_cpu(hdr_hash->hash_report)) {
> > +     case VIRTIO_NET_HASH_REPORT_TCPv4:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV4_TCP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_UDPv4:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV4_UDP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_TCPv6:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_UDPv6:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_IPv4:
> > +             *rss_type =3D XDP_RSS_TYPE_L3_IPV4;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_IPv6:
> > +             *rss_type =3D XDP_RSS_TYPE_L3_IPV6;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > +             *rss_type =3D XDP_RSS_TYPE_L3_IPV6_EX;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_NONE:
> > +     default:
> > +             *rss_type =3D XDP_RSS_TYPE_NONE;
> > +     }
>
> Why is this not implemented as a table lookup?
>

Sure. Thanks for the suggestion!

> Like:
>
> https://elixir.bootlin.com/linux/v6.9-rc4/source/drivers/net/ethernet/int=
el/igc/igc_main.c#L6652
>   https://elixir.bootlin.com/linux/latest/A/ident/xdp_rss_hash_type
>
> --Jesper
>
> > +
> > +     *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> > +     return 0;
> > +}
> > +
> > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D {
> > +     .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > +};
> > +
> >   static int virtnet_probe(struct virtio_device *vdev)
> >   {
> >       int i, err =3D -ENOMEM;
> > @@ -4747,6 +4801,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >                                 VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> >
> >               dev->hw_features |=3D NETIF_F_RXHASH;
> > +             dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> >       }
> >
> >       if (vi->has_rss_hash_report)
