Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C75D392C4E
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111965; cv=none; b=WR0vMxVaPmZEIw5av1cPwkm/+oeCoRqT3+tbEGEs4F00TPV/fLQU8at3jIFygwYFtYXb6kFlCFYiRSfbk85Mez4u7bx3/e298As6Nh7Hg9oDXaANnmYXyCKwG+YHAgDpuDlY65EbUPair9qzO+7b/N8iQcR12FGTW4e3IVl3cm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111965; c=relaxed/simple;
	bh=5d5ZgKFjpMZUgiSFD8yWv0iyoc2ASp+Hz/FCq0sxsoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYS1wHkitrHUGi50LL//1UVPfyVWMVOaDCJvS35nYwrHqT8pDI9EBov4nGo4ZbU5BlRHGCKwDsknp48UXH5oVJ/FAtLzvZbcgcKWXICwoUutZFpvnQQRmTIJPV0qpMPD1OCZ7hp7ihkyNvih42vUPFgTUUcvvIXEGIoIDsr+Nwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdGl/4YR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdGl/4YR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773111963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZn0Boo3x89EFxqie/JvdvARfbAGd/0AJYiLM3RQAng=;
	b=TdGl/4YRd2Jz9UJcJcP4NDoR7uuDxkq89m9Erbzn72sKDptqkvTXKilU0zEtxGj+qwtM+D
	wbOxk2LBamkyp9Hew8NkFI+PY8+HvLcNz0y8q1TL6reTFB/oDgDZ0P8t0Bb4bWVjs8xptT
	pcnRrlvxqkX5hs/xuZfrOUJcd5Q76qY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-4YxZN-lTM_um9D9If-6H0A-1; Mon, 09 Mar 2026 23:05:59 -0400
X-MC-Unique: 4YxZN-lTM_um9D9If-6H0A-1
X-Mimecast-MFC-AGG-ID: 4YxZN-lTM_um9D9If-6H0A_1773111959
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c7385e8fa73so3067773a12.3
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 20:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773111959; x=1773716759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZn0Boo3x89EFxqie/JvdvARfbAGd/0AJYiLM3RQAng=;
        b=YeT/G3fazuudgs3U2wtpRv43zz6U8oz6ZC/L2ijtZApD68m/7mKrJTi/WcODi8q2Ma
         IREjZvfi8BV6XIhTT6Vmz0Csx6f1fe5QKDIojl0E1Y98AkltXTI53D10fqAYwfCDTTjo
         /6uKrqB17hX8pX+kYL9SUQIzQ9aBFFOAL7Gw4y6kJ7oL15rpSoih9K9xLEg78EvaPDY8
         WEcJ8RdNgz8D45SNz4E0TNab/T+P7X4I98IdY0NTONRs0YH60g7VxjXzjBGpekqQqMZB
         HMBFcZ9fdw+OyjOOen0lT5jVUJ/o2KUjRibAd2GfFcM4hQl0mEQcpckkYbrcyxj2qmIW
         KcIA==
X-Forwarded-Encrypted: i=1; AJvYcCUqDxc3x3mFOH2sVdwuiEMi1+Kmb7ZesrtEE3DJoX962U37LNgTyEME2KR0S+hWbQX/UXCixz+t/YB7wEMYEA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3uAixNKRYjU9XqOkFPvTajnJVQyfGIk9QS+km7yc7nN+/Gq4M
	9eRch4g9cdSwxNhCKwncktHf7wpjOa4uQDC7wO+B9gLmgB6IS8WnGHcWwZmQj20/99IMBVzeksJ
	RwGna1KySvEoFazxa1/vOgNz9VRKqy4ysCSvzfSrK3ZGDn3F+e3pGbEPPnvgPXWjLFj6E+W75cF
	bs6SR+IhTeIGNVkvwnTskvc0mKk3uyFo//VfypXb2lVRQ=
X-Gm-Gg: ATEYQzxKRiOuAsJ/SHoKPyEAf+0ykNhyESY29vNK+0CeJqdIoWWLMMly1v1G18pZ9dD
	lcFwIC9DF+dmVMwhb5B6P+LUpp9DyRELvcb/JTM/PqCklCpFXr+XBAkkJfsPC8VJDPdDxI9tBHv
	V52xFtDk0xyPVZyvOUbrmr+wxA1SrVhjdgcPqCzmdgqjqP+ivEZOvBwmEVSTZaY/K9I3ygFz4V9
	yu86Cbt
X-Received: by 2002:a05:6a20:939d:b0:398:7d4a:c2c5 with SMTP id adf61e73a8af0-3987d4b21d3mr8226191637.20.1773111958820;
        Mon, 09 Mar 2026 20:05:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:939d:b0:398:7d4a:c2c5 with SMTP id
 adf61e73a8af0-3987d4b21d3mr8226160637.20.1773111958351; Mon, 09 Mar 2026
 20:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260305031938.24518-1-xuanzhuo@linux.alibaba.com> <20260305031938.24518-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260305031938.24518-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Mar 2026 11:05:46 +0800
X-Gm-Features: AaiRm53j3o9ttCcbKPPrTBWFnUbFVEVN2OOQqeYsV4P7O_agGBEhxYtBLpYEBAI
Message-ID: <CACGkMEsmDiTP1tz1hur_tduOUFU1bYqNzQm9nQgPUfdfHrmcKw@mail.gmail.com>
Subject: Re: [PATCH net v8 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AbpbBnqOplXiCqAWHt6iFIXb3SfZk5Col-PSL_fQ5vY_1773111959
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 11:19=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
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
>  drivers/net/tun_vnet.h     |  2 +-
>  drivers/net/virtio_net.c   |  6 +++-
>  include/linux/virtio_net.h | 58 ++++++++++++++++++++++++++++++--------
>  3 files changed, 53 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index a5f93b6c4482..fa5cab9d3e55 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
>
>         if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
>                                         tun_vnet_is_little_endian(flags),
> -                                       vlan_hlen, true)) {
> +                                       vlan_hlen, true, false)) {
>                 struct virtio_net_hdr_v1 *hdr =3D &tnl_hdr->hash_hdr.hdr;
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..7106333ef904 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, struct =
sk_buff *skb, bool orphan)
>         struct virtio_net_hdr_v1_hash_tunnel *hdr;
>         int num_sg;
>         unsigned hdr_len =3D vi->hdr_len;
> +       bool feature_hdrlen;
>         bool can_push;
>
> +       feature_hdrlen =3D virtio_has_feature(vi->vdev,
> +                                           VIRTIO_NET_F_GUEST_HDRLEN);
> +
>         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>
>         /* Make sure it's safe to cast between formats */
> @@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct s=
k_buff *skb, bool orphan)
>
>         if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
>                                         virtio_is_little_endian(vi->vdev)=
, 0,
> -                                       false))
> +                                       false, feature_hdrlen))
>                 return -EPROTO;
>
>         if (vi->mergeable_rx_bufs)
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 75dabb763c65..23f42bb8ece0 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -207,20 +207,40 @@ static inline int virtio_net_hdr_to_skb(struct sk_b=
uff *skb,
>         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_=
type);
>  }
>
> -static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> -                                         struct virtio_net_hdr *hdr,
> -                                         bool little_endian,
> -                                         bool has_data_valid,
> -                                         int vlan_hlen)
> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> +                                        struct virtio_net_hdr *hdr,
> +                                        bool little_endian,
> +                                        bool feature_hdrlen)
> +{
> +       u16 hdr_len;
> +
> +       if (feature_hdrlen) {
> +               hdr_len =3D skb_transport_offset(skb);
> +
> +               if (hdr->gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4)
> +                       hdr_len +=3D sizeof(struct udphdr);
> +               else
> +                       hdr_len +=3D tcp_hdrlen(skb);

I may miss soemthing but this still looks wrong as we could have e.g
USO and other UDP GSO packets.

> +       } else {
> +               /* This is a hint as to how much should be linear. */
> +               hdr_len =3D skb_headlen(skb);
> +       }
> +
> +       hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len);
> +}
> +
> +static inline int __virtio_net_hdr_from_skb(const struct sk_buff *skb,
> +                                           struct virtio_net_hdr *hdr,
> +                                           bool little_endian,
> +                                           bool has_data_valid,
> +                                           bool feature_hdrlen,
> +                                           int vlan_hlen)
>  {
>         memset(hdr, 0, sizeof(*hdr));   /* no info leak */
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
>
> -               /* This is a hint as to how much should be linear. */
> -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> -                                                skb_headlen(skb));
>                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
>                                                   sinfo->gso_size);
>                 if (sinfo->gso_type & SKB_GSO_TCPV4)
> @@ -231,6 +251,10 @@ static inline int virtio_net_hdr_from_skb(const stru=
ct sk_buff *skb,
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
>                 else
>                         return -EINVAL;
> +
> +               virtio_net_set_hdrlen(skb, hdr, little_endian,
> +                                     feature_hdrlen);
> +
>                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
>         } else
> @@ -250,6 +274,16 @@ static inline int virtio_net_hdr_from_skb(const stru=
ct sk_buff *skb,
>         return 0;
>  }
>
> +static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> +                                         struct virtio_net_hdr *hdr,
> +                                         bool little_endian,
> +                                         bool has_data_valid,
> +                                         int vlan_hlen)
> +{
> +       return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +                                        has_data_valid, false, vlan_hlen=
);
> +}
> +
>  static inline unsigned int virtio_l3min(bool is_ipv6)
>  {
>         return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
> @@ -385,7 +419,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>                             bool tnl_hdr_negotiated,
>                             bool little_endian,
>                             int vlan_hlen,
> -                           bool has_data_valid)
> +                           bool has_data_valid,
> +                           bool feature_hdrlen)
>  {
>         struct virtio_net_hdr *hdr =3D (struct virtio_net_hdr *)vhdr;
>         unsigned int inner_nh, outer_th;
> @@ -395,8 +430,9 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>         tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL =
|
>                                                     SKB_GSO_UDP_TUNNEL_CS=
UM);
>         if (!tnl_gso_type)
> -               return virtio_net_hdr_from_skb(skb, hdr, little_endian,
> -                                              has_data_valid, vlan_hlen)=
;
> +               return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +                                                has_data_valid,
> +                                                feature_hdrlen, vlan_hle=
n);
>
>         /* Tunnel support not negotiated but skb ask for it. */
>         if (!tnl_hdr_negotiated)
> --
> 2.32.0.3.g01195cf9f
>

Thanks

