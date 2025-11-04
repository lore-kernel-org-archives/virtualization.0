Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D163CF
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762230800; cv=none; b=n5ItFkMQg3z7P7PGae1zdEyJrEvgNt024QnIZSs3oV1TgR4Qo95hR2TZEtyQxd4DxCdDGXrNj71TbJ7QJ0sMVn38tw8tDCUkT6qfepw8DN9yBMgG54HtgGhq9lQrhnbdtO+TjPWvrvINaHTEkP1bTxtxDgAPllfMr4/vugIyQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762230800; c=relaxed/simple;
	bh=vE9KEonwANcOujfunwVmlyDZ1GfQBc7//BWjT3cXuMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Djpzglq/3EMwC8yT+HscF+h1IxAtcY2fk3VxEBbpVj8EeA1kxTKuPEmUnm0kukBasmr5WeBfauZ20b+pQXsoaTN4398rmkjj9wYwLvgSfzFLVy7JIBTrLQt52Y7Y0lElB1/ycRKqaWt1ZIp5LJzvbqrAHo2wKrXCTd0Mi2wfUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsjFatOO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsjFatOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762230796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iiG51rXuLmyG8LWhp52Z/M1rfzevCJpa9Kp7AkZe9O4=;
	b=fsjFatOOzJz6sEsT2o7o/WQLxSlcR/Uulc2LLyyvyA055ZqIiezuCeC/WFQry9nh8Fk8GB
	689iaEJNapW7DTQwquv19yDV2su7SXnrDrEDgQyMoH9N1IHIsIlK69lTsGccGZLLg3zfl4
	VB0IbSEuxXCLCUiEigH6K485qzZq0Ao=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-pbd4iRJ9Ni-7wy1tJun9CA-1; Mon, 03 Nov 2025 23:33:15 -0500
X-MC-Unique: pbd4iRJ9Ni-7wy1tJun9CA-1
X-Mimecast-MFC-AGG-ID: pbd4iRJ9Ni-7wy1tJun9CA_1762230794
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so4354840a91.2
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 20:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762230794; x=1762835594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiG51rXuLmyG8LWhp52Z/M1rfzevCJpa9Kp7AkZe9O4=;
        b=EdHNz8ATv/uC23iMVfK0NihdFfeMiSzjm+zIddVafXuWa7mzZuRQ2JCUznvRSrDqPl
         waLJYRjxxg70Gs8CQEoLkEbE72lNE/wROZMJIiGRBSsNEmeraSsF0YV3N9b+newUPpC9
         52W8CO4fY8jjiic6YWVixOZfro3K2jgnqOHwMEgjHHOqdPtmPS2dRLcX15TClldCF1sp
         MygM+s6EbtUcpS6UuwoOsMRKrXTL29DZ/D7mPs2cWv0HQuY7bm6AO4RHH5W6Nn2mEsrp
         ABctlZCSpqggx5Dq5InyT3OOBG44c7eCIlK35Yf8bTzjo9rBUO2dBWMCZTb6tYMMbCHx
         kuNA==
X-Forwarded-Encrypted: i=1; AJvYcCUCA7Qzl4hv0Sy/GPT1NLIuupALkBqVMjIZeiyevYiiMmWT+hXvTlcHG/8vT0AkmD5RzVi9DkaJm2+FX9n/xg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz38RiIJTiRNJA4Flw9DN3yBuow/BiNvKCHhKLUECjLoDE1UJDN
	r2bMo7D4KTj99PApV49qDfOfvoK0XpuxgICh5c2c695wJEhEfUsjOsAUqfpNjeGviivIVsmiHnf
	uf5lgTYtVcmIwX+qrRP92D1ymGoY/4IwTHGci7ERWg8Gtf42dsiK0I09FO4Ue91K7Fb7uk8IWD5
	jeywlMBi2EjzXg0UX1+0BTuXGGgG0nn6Q/TbHI5WKxZvs=
X-Gm-Gg: ASbGncsXx9xpiGi9OrLYmqbQmDdR8ddiNiTly6N82Xnn/iehI23PM6IzT9nQogbm7nm
	A88nWOUQh2Ows16Ui9y1OO4oTIia630avBHtrbIndZLoafB9t6NqELWxdaa5UVbFQe60vM8gy2n
	nZSY/doKIaMkaPglTSGTxHHXCMNq33u9Q+rX5FediCWOO9gtF924C+wdEO
X-Received: by 2002:a17:90b:288f:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-34083055c46mr18888082a91.23.1762230794143;
        Mon, 03 Nov 2025 20:33:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJW09FJf6ZdAh9/nOFZPHtjYHSxEwk+JTA6Diybi4bptHFdsqJPCrVRooz78OZUmdONQyV1kajOu7/H8I4sGQ=
X-Received: by 2002:a17:90b:288f:b0:33b:b078:d6d3 with SMTP id
 98e67ed59e1d1-34083055c46mr18888056a91.23.1762230793728; Mon, 03 Nov 2025
 20:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251103225514.2185-1-danielj@nvidia.com> <20251103225514.2185-6-danielj@nvidia.com>
In-Reply-To: <20251103225514.2185-6-danielj@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Nov 2025 12:33:02 +0800
X-Gm-Features: AWmQ_blDvcYVW-zNs1zaTZY7ahVNF3tIMy2IOnLQk11qZPp1YwmGbJdhjSTajj8
Message-ID: <CACGkMEun2exfZEAwXCh1XHP-iQTTxcuBVtD9k5R9Zbkrrgsbfw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 05/12] virtio_net: Query and set flow filter caps
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, alex.williamson@redhat.com, 
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, 
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X6HmT3OE9fDe6CfmmCrziIPWjWVUkiMQdxiUWsvbMeA_1762230794
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 6:56=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com> =
wrote:
>
> When probing a virtnet device, attempt to read the flow filter
> capabilities. In order to use the feature the caps must also
> be set. For now setting what was read is sufficient.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>
> ---
> v4:
>     - Validate the length in the selector caps
>     - Removed __free usage.
>     - Removed for(int.
> v5:
>     - Remove unneed () after MAX_SEL_LEN macro (test bot)
> v6:
>     - Fix sparse warning "array of flexible structures" Jakub K/Simon H
>     - Use new variable and validate ff_mask_size before set_cap. MST
> v7:
>     - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abeni
>     - Return errors from virtnet_ff_init, -ENOTSUPP is not fatal. Xuan
> ---
>  drivers/net/virtio_net.c           | 185 +++++++++++++++++++++++++++++
>  include/linux/virtio_admin.h       |   1 +
>  include/uapi/linux/virtio_net_ff.h |  91 ++++++++++++++
>  3 files changed, 277 insertions(+)
>  create mode 100644 include/uapi/linux/virtio_net_ff.h
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..7d7390103b71 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,6 +26,9 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
> +#include <linux/virtio_admin.h>
> +#include <net/ipv6.h>
> +#include <net/ip.h>
>
>  static int napi_weight =3D NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -281,6 +284,14 @@ static const struct virtnet_stat_desc virtnet_stats_=
tx_speed_desc_qstat[] =3D {
>         VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_rat=
elimits),
>  };
>
> +struct virtnet_ff {
> +       struct virtio_device *vdev;
> +       bool ff_supported;
> +       struct virtio_net_ff_cap_data *ff_caps;
> +       struct virtio_net_ff_cap_mask_data *ff_mask;
> +       struct virtio_net_ff_actions *ff_actions;
> +};
> +
>  #define VIRTNET_Q_TYPE_RX 0
>  #define VIRTNET_Q_TYPE_TX 1
>  #define VIRTNET_Q_TYPE_CQ 2
> @@ -493,6 +504,8 @@ struct virtnet_info {
>         struct failover *failover;
>
>         u64 device_stats_cap;
> +
> +       struct virtnet_ff ff;
>  };
>
>  struct padded_vnet_hdr {
> @@ -6758,6 +6771,167 @@ static const struct xdp_metadata_ops virtnet_xdp_=
metadata_ops =3D {
>         .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
>  };
>
> +static size_t get_mask_size(u16 type)
> +{
> +       switch (type) {
> +       case VIRTIO_NET_FF_MASK_TYPE_ETH:
> +               return sizeof(struct ethhdr);
> +       case VIRTIO_NET_FF_MASK_TYPE_IPV4:
> +               return sizeof(struct iphdr);
> +       case VIRTIO_NET_FF_MASK_TYPE_IPV6:
> +               return sizeof(struct ipv6hdr);
> +       case VIRTIO_NET_FF_MASK_TYPE_TCP:
> +               return sizeof(struct tcphdr);
> +       case VIRTIO_NET_FF_MASK_TYPE_UDP:
> +               return sizeof(struct udphdr);
> +       }
> +
> +       return 0;
> +}
> +
> +#define MAX_SEL_LEN (sizeof(struct ipv6hdr))
> +
> +static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *=
vdev)
> +{
> +       size_t ff_mask_size =3D sizeof(struct virtio_net_ff_cap_mask_data=
) +
> +                             sizeof(struct virtio_net_ff_selector) *
> +                             VIRTIO_NET_FF_MASK_TYPE_MAX;
> +       struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
> +       struct virtio_net_ff_selector *sel;
> +       size_t real_ff_mask_size;
> +       int err;
> +       int i;
> +
> +       cap_id_list =3D kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
> +       if (!cap_id_list)
> +               return -ENOMEM;
> +
> +       err =3D virtio_admin_cap_id_list_query(vdev, cap_id_list);
> +       if (err)
> +               goto err_cap_list;
> +
> +       if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
> +                                VIRTIO_NET_FF_RESOURCE_CAP) &&
> +             VIRTIO_CAP_IN_LIST(cap_id_list,
> +                                VIRTIO_NET_FF_SELECTOR_CAP) &&
> +             VIRTIO_CAP_IN_LIST(cap_id_list,
> +                                VIRTIO_NET_FF_ACTION_CAP))) {
> +               err =3D -EOPNOTSUPP;
> +               goto err_cap_list;
> +       }
> +
> +       ff->ff_caps =3D kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
> +       if (!ff->ff_caps)
> +               goto err_cap_list;
> +
> +       err =3D virtio_admin_cap_get(vdev,
> +                                  VIRTIO_NET_FF_RESOURCE_CAP,
> +                                  ff->ff_caps,
> +                                  sizeof(*ff->ff_caps));
> +
> +       if (err)
> +               goto err_ff;
> +
> +       /* VIRTIO_NET_FF_MASK_TYPE start at 1 */
> +       for (i =3D 1; i <=3D VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
> +               ff_mask_size +=3D get_mask_size(i);
> +
> +       ff->ff_mask =3D kzalloc(ff_mask_size, GFP_KERNEL);
> +       if (!ff->ff_mask)
> +               goto err_ff;
> +
> +       err =3D virtio_admin_cap_get(vdev,
> +                                  VIRTIO_NET_FF_SELECTOR_CAP,
> +                                  ff->ff_mask,
> +                                  ff_mask_size);
> +
> +       if (err)
> +               goto err_ff_mask;
> +
> +       ff->ff_actions =3D kzalloc(sizeof(*ff->ff_actions) +
> +                                       VIRTIO_NET_FF_ACTION_MAX,
> +                                       GFP_KERNEL);
> +       if (!ff->ff_actions)
> +               goto err_ff_mask;
> +
> +       err =3D virtio_admin_cap_get(vdev,
> +                                  VIRTIO_NET_FF_ACTION_CAP,
> +                                  ff->ff_actions,
> +                                  sizeof(*ff->ff_actions) + VIRTIO_NET_F=
F_ACTION_MAX);
> +
> +       if (err)
> +               goto err_ff_action;
> +
> +       err =3D virtio_admin_cap_set(vdev,
> +                                  VIRTIO_NET_FF_RESOURCE_CAP,
> +                                  ff->ff_caps,
> +                                  sizeof(*ff->ff_caps));
> +       if (err)
> +               goto err_ff_action;
> +
> +       real_ff_mask_size =3D sizeof(struct virtio_net_ff_cap_mask_data);
> +       sel =3D (void *)&ff->ff_mask->selectors[0];
> +
> +       for (i =3D 0; i < ff->ff_mask->count; i++) {
> +               if (sel->length > MAX_SEL_LEN) {
> +                       err =3D -EINVAL;
> +                       goto err_ff_action;
> +               }
> +               real_ff_mask_size +=3D sizeof(struct virtio_net_ff_select=
or) + sel->length;
> +               sel =3D (void *)sel + sizeof(*sel) + sel->length;
> +       }
> +
> +       if (real_ff_mask_size > ff_mask_size) {
> +               err =3D -EINVAL;
> +               goto err_ff_action;
> +       }
> +
> +       err =3D virtio_admin_cap_set(vdev,
> +                                  VIRTIO_NET_FF_SELECTOR_CAP,
> +                                  ff->ff_mask,
> +                                  ff_mask_size);

Should this be real_ff_mask_size?

Thanks

