Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7423E35B
	for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699967; cv=none; b=An12Wxh3UKQJR+Hm0l5MtpYL7WL+8udU6czccKgOvdXPsLwgjjMmBwnYgkfySa9a3CXhwAZ4wyJLH/tEWPLvy+xmiIdWJ6PCrq8eEULY2VhI2u4N78FQ+w7WYUiaaUnb4o7LKRG0VlYvL/KPdE40fQolOdclddaj5kyT3ippWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699967; c=relaxed/simple;
	bh=4rKXcsEqAaajDIbcVK5FPPjANzPZ+F4xSPgFyTeC6As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geb7UUXqTpkjWlozK2aLejnKjCkbGzgTgkQfhvuHNSXvQZ0QafZeOn05nv3mbhs6Tlj8EJza5X4VkozH7+RFumsNUO3/N+Oy+4QjEkn+1Z4Bggado8h//F2d0+mx8oUanXVSYvJo7c08DM6FtRD5iwpPUTl7sIUiMSCXw19rLZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbmkzoOw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbmkzoOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761699964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqvZkVwS4D/DMvfxtfY0zM5tRus8vTjeQLDhqse9kWE=;
	b=fbmkzoOwX1t+R8MD3FCYUkw2kciR8cM7khha/TPRAPB0QCJLhD1hnTOpdxTROiD+NR/ar/
	61bm9i9Ea/2j3sckRuJguPFuf/JqnG4utUbbAtE2C+0NjbGtIwUYBhKDA1cBgV2KHjrHL/
	OWPlrspDUxlHImc2yryJziGXjS5vS60=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-Kx_p2IixMA-CL0u0LcPFDg-1; Tue, 28 Oct 2025 21:06:03 -0400
X-MC-Unique: Kx_p2IixMA-CL0u0LcPFDg-1
X-Mimecast-MFC-AGG-ID: Kx_p2IixMA-CL0u0LcPFDg_1761699963
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-932cfea9060so2932324241.0
        for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 18:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761699963; x=1762304763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqvZkVwS4D/DMvfxtfY0zM5tRus8vTjeQLDhqse9kWE=;
        b=MTofzWs/qo+OB0+nyP6qw+rKZMr4Yy7yrsENRYk1F/lwIxxcaGpw/IDaKemFtDMpQs
         T5+NJXRsfeI9VMV/JRoowXPF8dvmrhZqYCRN+pYYC0d31z9hflsm4TLRUyPWgELvud/s
         2FKsk8s+fMBLG2uE/a2GG4tTI/oDhIH4uDS0kCu4IEKZqvhfned0rxADnAgOAD3h4cE3
         Mah2aQTLpMlRIYhA3zKIHonCtSS+2joVSDp/SVUb07dlh+aYk0L3vo8H0qoLAlM3rJSS
         GEEb3eVboA3m0V+jVJVSQ/nej3lmFhf41Gc+XTN/YMmT075m6e/vV+etKSbx6FTW6Zt5
         jvtw==
X-Forwarded-Encrypted: i=1; AJvYcCUa8f4o9A2vSr8/HEZQ4gtQeEOK+63Gz/DlQtSAmlivsw0D61dgHIBTB+AWWR2JhOnmcAFC6kKb5A4MqAlQbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNnC9OFbqm+691rQZlWpqcJuGndKLC5zVRVYcdfD4fCNyUCnUU
	tF9UnD15fMN1apn9dJl8cg0buWbU+S/x6UTsAd1UzKFG/GA7uy32QkSD6QBLS/pKs5jnbEL257h
	7WyfCfvVWU251FcodPckmPGMf1t+CU57jVPfeL4ffo01sR9PqVx2DudQY4uSYrvMIN2defILRmx
	45SqkWxQbgqrLSdGVOZlt1bspVdqlNoIwa/Q0HVreH89w=
X-Gm-Gg: ASbGncv9kGVmn9Synk1/2/6fAcM248Da/1//hp63fpTp8y/nbmgQ6kB8FLuvouHsAJ9
	aZHWM8ihG2a7HvkZu23/W4sRJjiSfk6x0BvJIJeitgZ/b1sRLQ/XLFfJL3xrWg81zGJIlz4qvxa
	6QoEWXyDAUj8EdFsI8SwZcfXxjA3uwrBxgr8rbxj7qICBjvQ5VP95v9lSR
X-Received: by 2002:a05:6102:c89:b0:5d5:f6ae:38cd with SMTP id ada2fe7eead31-5db906bf09fmr320208137.44.1761699962674;
        Tue, 28 Oct 2025 18:06:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI/zaw38+AhmGbx6A3agVStmL8oTqW3Nz5bSSlh7PFtDfaccTBJ4Rd1laBz7CD0TnxQIXxp/IVhKrIuqX/41k=
X-Received: by 2002:a05:6102:c89:b0:5d5:f6ae:38cd with SMTP id
 ada2fe7eead31-5db906bf09fmr320197137.44.1761699962213; Tue, 28 Oct 2025
 18:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251028030341.46023-1-jasowang@redhat.com> <20251028101144-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251028101144-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Oct 2025 09:05:47 +0800
X-Gm-Features: AWmQ_blsWiXuIt1RoBQUCAMZu2u9gBaPh9UlZ-pGRBO9KBYUDMeLmbYbRVF99MU
Message-ID: <CACGkMEu9AMtTn6cZjW=N+OJZMLqgaiLiAS6V0EhuA7fSeXJ69A@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: calculate header alignment mask based on features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AI4FyVBXXyhV4PGQUuKiX7Q_U3T1L1Lg9W8css52RYU_1761699963
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Oct 28, 2025 at 11:03:41AM +0800, Jason Wang wrote:
> > Commit 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> > switches to check the alignment of the virtio_net_hdr_v1_hash_tunnel
> > even when doing the transmission even if the feature is not
> > negotiated. This will cause
>
>
> you mean this causes
>
> >a series performance degradation of pktgen
> > as the skb->data can't satisfy the alignment requirement due to the
> > increase of the header size then virtio-net must prepare at least 2
> > sgs with indirect descriptors which will introduce overheads in the
>
>
> introduces, accordinglt
>
> > device.
> >
> > Fixing this by calculate the header alignment during probe so when
> > tunnel gso is not negotiated, we can less strict.
> >
> > Pktgen in guest + XDP_DROP on TAP + vhost_net shows the TX PPS is
> > recovered from 2.4Mpps to 4.45Mpps.
> >
> > Note that we still need a way to recover the performance when tunnel
> > gso is enabled, probably a new vnet header format.
>
> you mean improve, not recover as such

The PPS drops to 2.4Mpps after the 56a06bd40fab, so this patch
recovers it the number before 56a06bd40fab.

>
>
> >
> > Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 31bd32bdecaf..5b851df749c0 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -441,6 +441,9 @@ struct virtnet_info {
> >       /* Packet virtio header size */
> >       u8 hdr_len;
> >
> > +     /* header alignment */
> > +     size_t hdr_align;
> > +
>
> It makes no sense to have u8 for length but size_t for alignment,
> and u8 would fit in a memory hole we have, anyway.

Oh right.


>
> >       /* Work struct for delayed refilling if we run low on memory. */
> >       struct delayed_work refill;
> >
> > @@ -3308,8 +3311,9 @@ static int xmit_skb(struct send_queue *sq, struct=
 sk_buff *skb, bool orphan)
> >       pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
> >
> >       can_push =3D vi->any_header_sg &&
> > -             !((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
> > +             !((unsigned long)skb->data & (vi->hdr_align - 1)) &&
>
>
> So let me get it straight.
> We use the alignment check to be able to cast to the correct type.
> The issue is that alignment for the header changed.
>
> virtio_net_hdr_v1 has 2 byte alignment, but:
>
>
>
> struct virtio_net_hdr_v1_hash {
>         struct virtio_net_hdr_v1 hdr;
>         __le32 hash_value;
> #define VIRTIO_NET_HASH_REPORT_NONE            0
> #define VIRTIO_NET_HASH_REPORT_IPv4            1
> #define VIRTIO_NET_HASH_REPORT_TCPv4           2
> #define VIRTIO_NET_HASH_REPORT_UDPv4           3
> #define VIRTIO_NET_HASH_REPORT_IPv6            4
> #define VIRTIO_NET_HASH_REPORT_TCPv6           5
> #define VIRTIO_NET_HASH_REPORT_UDPv6           6
> #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>         __le16 hash_report;
>         __le16 padding;
> };
>
>
> has 4 byte due to hash_value, and accordingly:
>
>
> struct virtio_net_hdr_v1_hash_tunnel {
>         struct virtio_net_hdr_v1_hash hash_hdr;
>         __le16 outer_th_offset;
>         __le16 inner_nh_offset;
> };
>
>
> now is 4 byte aligned so everything is messed up:
> net tends not to be 4 byte aligned.
>
>
>
>
> >               !skb_header_cloned(skb) && skb_headroom(skb) >=3D hdr_len=
;
> > +
> >       /* Even if we can, don't push here yet as this would skew
> >        * csum_start offset below. */
> >       if (can_push)
> > @@ -6926,15 +6930,20 @@ static int virtnet_probe(struct virtio_device *=
vdev)
> >       }
> >
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |=
|
> > -         virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
> > +         virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)) {
> >               vi->hdr_len =3D sizeof(struct virtio_net_hdr_v1_hash_tunn=
el);
> > -     else if (vi->has_rss_hash_report)
> > +             vi->hdr_align =3D __alignof__(struct virtio_net_hdr_v1_ha=
sh_tunnel);
> > +     } else if (vi->has_rss_hash_report) {
> >               vi->hdr_len =3D sizeof(struct virtio_net_hdr_v1_hash);
> > -     else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
> > -              virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> > +             vi->hdr_align =3D __alignof__(struct virtio_net_hdr_v1_ha=
sh);
> > +     } else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
> > +             virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> >               vi->hdr_len =3D sizeof(struct virtio_net_hdr_mrg_rxbuf);
> > -     else
> > +             vi->hdr_align =3D __alignof__(struct virtio_net_hdr_mrg_r=
xbuf);
> > +     } else {
> >               vi->hdr_len =3D sizeof(struct virtio_net_hdr);
> > +             vi->hdr_align =3D __alignof__(struct virtio_net_hdr);
> > +     }
> >
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CS=
UM))
> >               vi->rx_tnl_csum =3D true;
>
> So how about just fixing the root cause then?
> Like this (untested, if you agree pls take over this):
>
> ---
>
> virtio_net: fix alignment for virtio_net_hdr_v1_hash
>
>
> changing alignment of header would mean it's no longer safe to cast a 2
> byte aligned pointer between formats. Use two 16 bit fields to make it 2
> byte aligned as previously.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

This looks indeed better, will go this way.

>
> --
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 31bd32bdecaf..02ce5316f47d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2535,6 +2535,13 @@ static struct sk_buff *receive_mergeable(struct ne=
t_device *dev,
>         return NULL;
>  }
>
> +static inline u16

Should be u32.

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
> @@ -2561,7 +2568,7 @@ static void virtio_skb_set_hash(const struct virtio=
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
> @@ -3307,6 +3314,10 @@ static int xmit_skb(struct send_queue *sq, struct =
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
> @@ -6755,7 +6766,7 @@ static int virtnet_xdp_rx_hash(const struct xdp_md =
*_ctx, u32 *hash,
>                 hash_report =3D VIRTIO_NET_HASH_REPORT_NONE;
>
>         *rss_type =3D virtnet_xdp_rss_type[hash_report];
> -       *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> +       *hash =3D virtio_net_hash_value(hdr_hash);
>         return 0;
>  }
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
>

Thanks

