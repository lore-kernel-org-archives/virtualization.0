Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5566C1842
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063246; cv=none; b=Qjxxrzt0yM5kyEMzmhg4vL34IGnseO4yY9IbXjnbZ4sYTFaNRuxdttg0CUGIhr/dvQcxKfzsc3o3LO/wiiF7kJH6V7K2kqCwGZEEdZzFHyK+/pYJMgXzTZdcFMaJoSmDb/1lToo5ILluGAQXtarNCFl5TyLPW+ICsoJHRStVM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063246; c=relaxed/simple;
	bh=wvo7LjfFKzlE79cgaD689QaQxVmVMsxOvMEBBTVkI7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTmw1XkpuRYiZV2Ju7TqLVHS5MOIQkSH9hk/qKItU+CR0EhESEPGtPyePPcL/5ALQFKQEuNoGU9UiSwSk3DUSVDdkQmF5jRl7kICYOF0bPr7rba80+6F1pz1DjSXiP7pR0ER1yUN5eOzDimny4nlvECokLMJq7qos9yCb9h449c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSUWq56e; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSUWq56e"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCE8F8507F
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 02:27:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCE8F8507F
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lSUWq56e
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WlGm8-rCoS0t
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 02:27:24 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7D728506A
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 02:27:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7D728506A
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so4146456a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Jan 2024 18:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706063242; x=1706668042; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0OO2kNsfTulrolzVWOPc5d52vzKo7FmwBEwV4HF2i0=;
        b=lSUWq56etI44kq6MHiReqdx/V/ohM0jsPwkznbgyUuYRa19TG1Sg75+xPY5VzZXLel
         sMMJ2OJZFwhCrnviN33+xwMFeNQ0yUf5OSjSI5H71goL/iO+D3E9L78bYe+w4lHYOXJ5
         aKESvI/D1Up5dUKzEnPvBVh34UqvV3e6xniTHfBgtaGpbUS7zGHLjYGGiS36+8ozgbT1
         opfQ4pBPTsiuGetYcLsMudICF3BoXpTh/dofXW17wmlRK2jf4ZUcKHKeQ2wlm3vkWxbX
         kYqkIIwJ2tp2OATgtvEF0q6JgUvMtmeU545R0SAlapvAW+1GtmVQo9Bc8MH5RtbZVUT8
         Jo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706063242; x=1706668042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0OO2kNsfTulrolzVWOPc5d52vzKo7FmwBEwV4HF2i0=;
        b=UNuXxupLEmGMm0BaSYY+flRhksx7hMXMaHIkBSIN4iNZJ3luhVUZtU/G3xmYUUdYkD
         naBcGqUV8lHTDQ606bQMWn99/Z6MV3fFOC4TOvd5L8CowCEfomeAUMbL35H7SB4EZ3Uw
         aBotD5roHOfumUasL6HSAQe7ewx+M8FiPcX1QJrcC6c5WK+VCeUI2lHrqZGMk4i7K9bw
         3FZVR/o8byA6NkDJvC/sBh1pJxllhb3vqWKzO1O6f42CbPkt3o8niPZt9sx6kahQZi/J
         HeSEUh3tZBrAYfIB0sXbbTm12mgeo8qdFa3U4FXi9r56axYiVJXPhG+7KNSZDYStwzO5
         nnlg==
X-Gm-Message-State: AOJu0YxZM0yNAH2lkhzGaaONL0VnjLj+WBfO6lD9Xy/jz89yGFOae9T1
	xi6GdBdGskj7Xu3e7oMbK6ocUYnJUUJrvv+yrFWnSw5bo35r/6qcPpl/fd8rddZInTUnicq3OqT
	UEwH+8Xygu0nhSuHUEMAVE3mBOcU=
X-Google-Smtp-Source: AGHT+IFiCRdOaCAOvtAXc7e6Uar32bBy/m3xFl3wVt9f8tkxcTCM7lDMIjNyLBam6Y4E+nEXxZWmMIH92heyLO8oNgQ=
X-Received: by 2002:a17:906:5988:b0:a30:df55:ef5e with SMTP id
 m8-20020a170906598800b00a30df55ef5emr198932ejs.172.1706063241665; Tue, 23 Jan
 2024 18:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122102256.261374-1-liangchen.linux@gmail.com> <20240123020132-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240123020132-mutt-send-email-mst@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 24 Jan 2024 10:27:09 +0800
Message-ID: <CAKhg4tK6ea27iKNAPe=-G9wfzNe4hh9=9fk0cpt0qyAVW1Fa1g@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 3:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jan 22, 2024 at 06:22:56PM +0800, Liang Chen wrote:
> > The RSS hash report is a feature that's part of the virtio specificatio=
n.
> > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhos=
t
> > (still a work in progress as per [1]) support this feature. While the
> > capability to obtain the RSS hash has been enabled in the normal path,
> > it's currently missing in the XDP path. Therefore, we are introducing X=
DP
> > hints through kfuncs to allow XDP programs to access the RSS hash.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 56 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index d7ce4a1011ea..1463a4709e3c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >       }
> >  }
> >
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                        enum xdp_rss_hash_type *rss_type)
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
> > +             case VIRTIO_NET_HASH_REPORT_TCPv4:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_TCP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_UDPv4:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV4_UDP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_TCPv6:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_UDPv6:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > +                     *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_IPv4:
> > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV4;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_IPv6:
> > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > +                     *rss_type =3D XDP_RSS_TYPE_L3_IPV6_EX;
> > +                     break;
> > +             case VIRTIO_NET_HASH_REPORT_NONE:
> > +             default:
> > +                     *rss_type =3D XDP_RSS_TYPE_NONE;
> > +     }
> > +
> > +     *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> > +     return 0;
> > +}
> > +
> > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D {
> > +     .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > +};
> > +
> >  static int virtnet_probe(struct virtio_device *vdev)
> >  {
> >       int i, err =3D -ENOMEM;
> > @@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >       dev->ethtool_ops =3D &virtnet_ethtool_ops;
> >       SET_NETDEV_DEV(dev, &vdev->dev);
> >
> > +     dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> > +
>
> How about making this assignment depend on
>
> xdp->rxq->dev->features & NETIF_F_RXHASH
>

Thanks! How about dev->hw_features & NETIF_F_RXHASH? dev->features &
NETIF_F_RXHASH has not been enabled at this point.

> ?
>
> >       /* Do we support "hardware" checksums? */
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
> >               /* This opens up the world of extra features. */
> > --
> > 2.40.1
>
