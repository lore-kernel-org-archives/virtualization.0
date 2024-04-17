Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3435EAD2
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 03:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323888; cv=none; b=qj+csAP4c1aMwThDbMSRT1ASR9peP0U+IiMGtOlsMVwmp3qrbdEUsRV93lB+CdMt6MhGKKzqdiAMFcEzii677svkFBoqDRub8M/DX+8vipWQFezofqPGo73er8kQjqReOLzlyYgPqq1Y2JpII4CIl41XuWlgYDeMyBpyaQ6xcUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323888; c=relaxed/simple;
	bh=DYdbJMQPWHNdCa/t4xKHn7Ep23nVCFUDURsn3OIzBkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0ht/gD2DRdgz+RfKuhVW9HlsE9WTgu2M5jWWdYcUklsch+AmqkndZ9dlsBqXzeN10Cp0FsfDLCv5wpb1RUxk6TUUlaguUkSmEdMAif2Us7itCuQQPS5hXtqGRVX3eMMz9D1U/7qRxbe5DmeaRHswKrw+ppJsxAS4Ef8Bh02Ij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz/Gyt5P; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz/Gyt5P"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso6157852a12.3
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 20:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713323885; x=1713928685; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVriCNTb+EDSZWCxPrVyKNj5dSkX49V39Dhl38sLFSg=;
        b=lz/Gyt5Ph/mROnEVRjAjTCkW/whGc/IcwN4l36wiLdWVB/ok7KxsTyqm3Gni1e+Kst
         bz6OKuTl60boW2HKrgGm8tErA9lC3RcVoUMasCp5BqvJN+e9MFyIJtcYtHlSSPT9PypU
         l8Riwd/E7stNF3MCF82oENdJtAugOmsk084cyum3HDAjm/e1V2kJC9LXnH+oNOHSOfsq
         vXKDpQuGfLVdGvWzdm58JfHGGusGDUxJiBqwblmqGP4eHawumTN5y00/wypo0ots3MJb
         MHhJu1uN6OrCewDiTCb2BHBTFjmWC6e/78Ti5wYfGLyNxT2OTg2yZa8zsoJIdtlTJ301
         gkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713323885; x=1713928685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVriCNTb+EDSZWCxPrVyKNj5dSkX49V39Dhl38sLFSg=;
        b=iZGOLjybu/Ab9qJBshhnfnYMqIN52NWYy471b2s07BNIvpi+wZL4YACx5PVpEU8jt/
         pZuJOU6ELEZOHC7BTYPPD0ZU0BvZQLQylIRyl+HZYVGA9ynW0+x6AtxxuQx5Fx1kOLUW
         oDGhV2s5LCRkhFRH24p+6IpDCGZ/tu0/p9Cc/Clqlk/vJurjgN7XiM1GfMZp42OXyOw8
         kJeSIf3LxV4FRRzbUgkQIVDa8Niz40Ti4xA0zCaNLqD77EjImqubXY3uvMEikldC31/O
         AUSFqRmqpenojWZVfIezuxMPaWfAS6PtoQT7qWLy6oGGFu64soDrrWRuyM6pANFfdpcZ
         zWuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHp7YVa5Lc8LA9IOAM9GMke3wT32OLU5uxdGEs3MS7AeZk8V1aCrakEwLnatBMcpJEHAkyYdWtVryNWG8241mulFXtpj5F5i+3EYTA/TQ=
X-Gm-Message-State: AOJu0Yx2WErThWc4Ko4fAdOcZSqG4S/ZbVTgBUrWf62u0bUil6hT5Qzp
	SvR62uvzfhZfzNAaWgu8CsOf4LFp8PrRfCnnW1AZRM/2BXwtfDGiZZ1txrF+uVQxoxuEUUgocng
	VArIqoOqi1HjiROQMgWVt5Xtm8F4=
X-Google-Smtp-Source: AGHT+IHG+tfTL+nJaNRUJwWP+LAGchmm89LD6lkmQtWHddA8bSL6nbjLM+KQAVWxzh0DA73fYqGhDXzbvvTHz6c6F6k=
X-Received: by 2002:a50:d642:0:b0:56d:fdb3:bcc5 with SMTP id
 c2-20020a50d642000000b0056dfdb3bcc5mr9491339edj.12.1713323884627; Tue, 16 Apr
 2024 20:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240416061943.407082-1-liangchen.linux@gmail.com> <04dcbbcd-7079-42d4-b77c-3bbf55cfc823@linux.alibaba.com>
In-Reply-To: <04dcbbcd-7079-42d4-b77c-3bbf55cfc823@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 17 Apr 2024 11:17:51 +0800
Message-ID: <CAKhg4tJwB+xQ3H7YZGF0VRR6cMdQMz3g_3kf5uqkT=j0uR8dnw@mail.gmail.com>
Subject: Re: [PATCH net-next v8] virtio_net: Support RX hash XDP hint
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	ast@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 3:35=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/4/16 =E4=B8=8B=E5=8D=882:19, Liang Chen =E5=86=99=E9=81=93=
:
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
> >    Changes from v7:
> > - use table lookup for rss hash type
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
> >   drivers/net/virtio_net.c        | 42 ++++++++++++++++++++++++++++++++=
+
> >   include/uapi/linux/virtio_net.h |  1 +
> >   2 files changed, 43 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c22d1118a133..1d750009f615 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4621,6 +4621,47 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >       }
> >   }
> >
> > +static enum xdp_rss_hash_type
> > +virtnet_xdp_rss_type[VIRTIO_NET_HASH_REPORT_MAX_TABLE] =3D {
> > +     [VIRTIO_NET_HASH_REPORT_NONE] =3D XDP_RSS_TYPE_NONE,
> > +     [VIRTIO_NET_HASH_REPORT_IPv4] =3D XDP_RSS_TYPE_L3_IPV4,
> > +     [VIRTIO_NET_HASH_REPORT_TCPv4] =3D XDP_RSS_TYPE_L4_IPV4_TCP,
> > +     [VIRTIO_NET_HASH_REPORT_UDPv4] =3D XDP_RSS_TYPE_L4_IPV4_UDP,
> > +     [VIRTIO_NET_HASH_REPORT_IPv6] =3D XDP_RSS_TYPE_L3_IPV6,
> > +     [VIRTIO_NET_HASH_REPORT_TCPv6] =3D XDP_RSS_TYPE_L4_IPV6_TCP,
> > +     [VIRTIO_NET_HASH_REPORT_UDPv6] =3D XDP_RSS_TYPE_L4_IPV6_UDP,
> > +     [VIRTIO_NET_HASH_REPORT_IPv6_EX] =3D XDP_RSS_TYPE_L3_IPV6_EX,
> > +     [VIRTIO_NET_HASH_REPORT_TCPv6_EX] =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX=
,
> > +     [VIRTIO_NET_HASH_REPORT_UDPv6_EX] =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX
> > +};
> > +
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                            enum xdp_rss_hash_type *rss_type)
> > +{
> > +     const struct xdp_buff *xdp =3D (void *)_ctx;
> > +     struct virtio_net_hdr_v1_hash *hdr_hash;
> > +     struct virtnet_info *vi;
> > +     u16 hash_report;
> > +
> > +     if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> > +             return -ENODATA;
> > +
> > +     vi =3D netdev_priv(xdp->rxq->dev);
> > +     hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hd=
r_len);
> > +     hash_report =3D __le16_to_cpu(hdr_hash->hash_report);
> > +
> > +     if (hash_report >=3D VIRTIO_NET_HASH_REPORT_MAX_TABLE)
> > +             hash_report =3D VIRTIO_NET_HASH_REPORT_NONE;
>
> When this happens, it may mean an error or user modification of the
> header occurred.
> Should the following *hash* value be cleared to 0?
>

Referring to the igc and mlx5 drivers, the hash value is not cleared
to 0 in such cases either. This is because if the rss type is
XDP_RSS_TYPE_NONE, the hash value is considered to be not relevant.
Thanks!

> Thanks,
> Heng
>
> > +
> > +     *rss_type =3D virtnet_xdp_rss_type[hash_report];
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
> > @@ -4747,6 +4788,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >                                 VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> >
> >               dev->hw_features |=3D NETIF_F_RXHASH;
> > +             dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> >       }
> >
> >       if (vi->has_rss_hash_report)
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virti=
o_net.h
> > index cc65ef0f3c3e..3ee695450096 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -176,6 +176,7 @@ struct virtio_net_hdr_v1_hash {
> >   #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> >   #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> >   #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> > +#define VIRTIO_NET_HASH_REPORT_MAX_TABLE      10
> >       __le16 hash_report;
> >       __le16 padding;
> >   };
>
