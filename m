Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A72641C6
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762230971; cv=none; b=bGTODcqndLtnQnC3GUD+0RMKSdEoIuYuhjgZ682BwpdJOE6CbLAuDrX36Uz0rT7MxmBIvWTnl6LwdCd4PdtyiHfW8m6vgzlSzhL5qsiErRPD8PJrug7+dR+/AaJeIuCIqSaOTPwjO4pDAu8ojXJXtVgGqOLDqWDvIGC9ge7Ga5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762230971; c=relaxed/simple;
	bh=yCrStC4YpQgBIxw78bx6aHRmVXxUUgdVIwCLnEwIxZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlqRkKbF6GJo6jx90voE52WATjQlAk1TM54a0til7pIhP/2JzK+624fBP/fksv0Zg1pZgoiCjs0RG7z9amThj1piVLFYs4qe+4mZtLPzty8wHv5Yr67tE0sIIoKgelmxEC06SJprmZwjSuHeYj3zOargolu9h00yv/r4J3yzC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIlmGZGT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIlmGZGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762230968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMEgALT3vYkI3BPRmrl7x3ijGxSzQd/8KF3u3X+wKTQ=;
	b=fIlmGZGTUc01n+WlE9C4dTai54X7luXp5NS8USgaTh8WbYK6Vno8p85Yry/g7h1SCFkcQ0
	NToN921OjB0sAF7xFSKx1AMXZkJtsrIx93RZl6ei+5bvn8wNUKivpWnMoZOeW5xQYecvKd
	B7deHrzS9JS/ROqNPVZj1HGQvdBTTNw=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-ETat5wSYMZyEkA-FAcYJaw-1; Mon, 03 Nov 2025 23:36:04 -0500
X-MC-Unique: ETat5wSYMZyEkA-FAcYJaw-1
X-Mimecast-MFC-AGG-ID: ETat5wSYMZyEkA-FAcYJaw_1762230964
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-934e1916338so9633528241.0
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 20:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762230964; x=1762835764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMEgALT3vYkI3BPRmrl7x3ijGxSzQd/8KF3u3X+wKTQ=;
        b=ga6K15xjBpCQ42J+x3dYS5BAiM3v9zaNQMZENCUIW0w5yLxwpHsEbyvH1YQ50t+8aF
         1riP6IhXFqg5KMdMrGhSV2cG7KEiA04wrwepbS6FDcLC1ecuUwwt1nP0fva+kZnKFE2a
         2lFVv1zyvUC/FvHpwY7JV+SD7xDgzIlDgqBlPMDzf1P1SV3CuOLVvuNv8RJX+YkXL1B/
         X/uKsTprUtAXVsfm62xDR5J7F1+Dwx6ZVDiCk5b7JCL2A9Eza1hqwApS102Gm4k27J41
         d2UyqwXaJFH/3nczkAzovo6j/U6IR9B4aI4WN+97Kw/CzNyj4/qINXTVlkmvWr7GQdOe
         XoQg==
X-Forwarded-Encrypted: i=1; AJvYcCW2TDFQbagCRaQCKCOpwYrW40AJy6OLXWoWlF07MHIjCcU4a5I6tSYeYEvHGG5PAeNuGZRGjj5u+f2qNcuyDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfUdzd6XXPYvAwoqLW0QRDjzsCcKXIbHAGfhsGv5+f/PiPboaa
	c/OHuhp78PRPOyQ2Z4vcNXylSBAuxCFOVr0K02DP0uM4i35N3PHmEFfPsZE2yuhgDK1ULQRl7Ie
	x/NRoCAkngD4o0SeQwJ/06iFr3Ouo2SSzFvqsYN5xBC4J6BDiuZSz82fYMtRxp9nsu+EvcSQs4m
	jF4WLZHuU8Y6bQbnDUmdd1Qafsdm97WIgxG5jEosXKS+Q=
X-Gm-Gg: ASbGncsCG+BUMDN89BL9U7ZHQubJT+ZD6tl0UKZTrXO9ueTNumGmOuM2DqVfACDoe/J
	Gu4md25N+Ee/kr1m+owgGfF/qkvye7ltsZ2iF5IHkqvhUUwH6RnB8dO4kI4qLpQNbZxWWKWBIjQ
	jR4mB0hybsCi5xZxCZgj9baq0poJlYrx4bSAQrwn1ZOPpcWQlDX/0j0Xuq
X-Received: by 2002:a05:6102:292a:b0:5db:fddb:3155 with SMTP id ada2fe7eead31-5dbfddb34bamr214517137.17.1762230964002;
        Mon, 03 Nov 2025 20:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFRW6KkXajXhV04APlxXz+gy1FqV5c0nq7g6USx0JM1aAfKDHqf43nWjYmEUhnInaP7fzfa3SuxEnx6iDC3x0=
X-Received: by 2002:a05:6102:292a:b0:5db:fddb:3155 with SMTP id
 ada2fe7eead31-5dbfddb34bamr214502137.17.1762230963620; Mon, 03 Nov 2025
 20:36:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251103225514.2185-1-danielj@nvidia.com> <20251103225514.2185-10-danielj@nvidia.com>
In-Reply-To: <20251103225514.2185-10-danielj@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Nov 2025 12:35:50 +0800
X-Gm-Features: AWmQ_bnTyxts-_nG6FYbdQYkJWj3FPKz4FkkPVV3zWU9Rotlr6GeQtv3lh-ZypI
Message-ID: <CACGkMEvNPzVkD8RQ84bU0yTSJeVNiq63jYbxCKhLQLpMPd0tZA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 09/12] virtio_net: Implement IPv4 ethtool flow rules
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, alex.williamson@redhat.com, 
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, 
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zQGm4P6ctERTu4ocL8_96h4iiz-7RyJ_c8fID9flegE_1762230964
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 6:56=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com> =
wrote:
>
> Add support for IP_USER type rules from ethtool.
>
> Example:
> $ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
> Added rule with ID 1
>
> The example rule will drop packets with the source IP specified.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4:
>     - Fixed bug in protocol check of parse_ip4
>     - (u8 *) to (void *) casting.
>     - Alignment issues.
> ---
>  drivers/net/virtio_net.c | 122 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 115 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a0e94771a39e..865a27165365 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6889,6 +6889,34 @@ static bool validate_eth_mask(const struct virtnet=
_ff *ff,
>         return true;
>  }
>
> +static bool validate_ip4_mask(const struct virtnet_ff *ff,
> +                             const struct virtio_net_ff_selector *sel,
> +                             const struct virtio_net_ff_selector *sel_ca=
p)
> +{
> +       bool partial_mask =3D !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PA=
RTIAL_MASK);
> +       struct iphdr *cap, *mask;
> +
> +       cap =3D (struct iphdr *)&sel_cap->mask;
> +       mask =3D (struct iphdr *)&sel->mask;
> +
> +       if (mask->saddr &&
> +           !check_mask_vs_cap(&mask->saddr, &cap->saddr,
> +                              sizeof(__be32), partial_mask))
> +               return false;
> +
> +       if (mask->daddr &&
> +           !check_mask_vs_cap(&mask->daddr, &cap->daddr,
> +                              sizeof(__be32), partial_mask))
> +               return false;
> +
> +       if (mask->protocol &&
> +           !check_mask_vs_cap(&mask->protocol, &cap->protocol,
> +                              sizeof(u8), partial_mask))
> +               return false;
> +
> +       return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>                           const struct virtio_net_ff_selector *sel)
>  {
> @@ -6900,11 +6928,36 @@ static bool validate_mask(const struct virtnet_ff=
 *ff,
>         switch (sel->type) {
>         case VIRTIO_NET_FF_MASK_TYPE_ETH:
>                 return validate_eth_mask(ff, sel, sel_cap);
> +
> +       case VIRTIO_NET_FF_MASK_TYPE_IPV4:
> +               return validate_ip4_mask(ff, sel, sel_cap);
>         }
>
>         return false;
>  }
>
> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> +                     const struct ethtool_rx_flow_spec *fs)
> +{
> +       const struct ethtool_usrip4_spec *l3_mask =3D &fs->m_u.usr_ip4_sp=
ec;
> +       const struct ethtool_usrip4_spec *l3_val  =3D &fs->h_u.usr_ip4_sp=
ec;
> +
> +       mask->saddr =3D l3_mask->ip4src;
> +       mask->daddr =3D l3_mask->ip4dst;
> +       key->saddr =3D l3_val->ip4src;
> +       key->daddr =3D l3_val->ip4dst;
> +
> +       if (l3_mask->proto) {
> +               mask->protocol =3D l3_mask->proto;
> +               key->protocol =3D l3_val->proto;
> +       }
> +}
> +
> +static bool has_ipv4(u32 flow_type)
> +{
> +       return flow_type =3D=3D IP_USER_FLOW;
> +}
> +
>  static int setup_classifier(struct virtnet_ff *ff,
>                             struct virtnet_classifier **c)
>  {
> @@ -7039,6 +7092,7 @@ static bool supported_flow_type(const struct ethtoo=
l_rx_flow_spec *fs)
>  {
>         switch (fs->flow_type) {
>         case ETHER_FLOW:
> +       case IP_USER_FLOW:
>                 return true;
>         }
>
> @@ -7067,11 +7121,23 @@ static int validate_flow_input(struct virtnet_ff =
*ff,
>  }
>
>  static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
> -                                size_t *key_size, size_t *classifier_siz=
e,
> -                                int *num_hdrs)
> +                               size_t *key_size, size_t *classifier_size=
,
> +                               int *num_hdrs)
>  {
> +       size_t size =3D sizeof(struct ethhdr);
> +
>         *num_hdrs =3D 1;
>         *key_size =3D sizeof(struct ethhdr);
> +
> +       if (fs->flow_type =3D=3D ETHER_FLOW)
> +               goto done;
> +
> +       ++(*num_hdrs);
> +       if (has_ipv4(fs->flow_type))
> +               size +=3D sizeof(struct iphdr);
> +
> +done:
> +       *key_size =3D size;
>         /*
>          * The classifier size is the size of the classifier header, a se=
lector
>          * header for each type of header in the match criteria, and each=
 header
> @@ -7083,8 +7149,9 @@ static void calculate_flow_sizes(struct ethtool_rx_=
flow_spec *fs,
>  }
>
>  static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *select=
or,
> -                                  u8 *key,
> -                                  const struct ethtool_rx_flow_spec *fs)
> +                                 u8 *key,
> +                                 const struct ethtool_rx_flow_spec *fs,
> +                                 int num_hdrs)
>  {
>         struct ethhdr *eth_m =3D (struct ethhdr *)&selector->mask;
>         struct ethhdr *eth_k =3D (struct ethhdr *)key;
> @@ -7092,8 +7159,33 @@ static void setup_eth_hdr_key_mask(struct virtio_n=
et_ff_selector *selector,
>         selector->type =3D VIRTIO_NET_FF_MASK_TYPE_ETH;
>         selector->length =3D sizeof(struct ethhdr);
>
> -       memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
> -       memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
> +       if (num_hdrs > 1) {
> +               eth_m->h_proto =3D cpu_to_be16(0xffff);
> +               eth_k->h_proto =3D cpu_to_be16(ETH_P_IP);

Do we need to check IPV6 here?

Thanks

