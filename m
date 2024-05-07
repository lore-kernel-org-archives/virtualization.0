Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050E6F08B
	for <virtualization@lists.linux.dev>; Tue,  7 May 2024 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063069; cv=none; b=QTClBWHjB5Y5lcnviBs/2uY8AfvA4SH0xhNEqKB8gIomgSHbxWR96CKlgIzefkM4bOikPOANTkhQgyrlMbuoMCJN/N81nuLOnoFjI4q4IdRA2ICQtilAAU2gGCsSH5fLWiV3tfcxyLxy67xce+5fax1MBLf5GWMshxCf8qEg+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063069; c=relaxed/simple;
	bh=vUfM/NkCP8N5v/pvw9FjoT29XEqwm5fGlonlyZC4kpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lf6RM9IgRA1lPqhEvkjZ0ZL+Uacw52cX8EQpt5//f/muJViCJefOOKZELx2d+wUppjQigv7v8h332FYthTm+wxDjDmoVWzwz8NweQtDhSEMvpfAkdYRxesQhlnJaVpyYDzdU7M0L5ts39ykrRNrY2YmYms969e6Ew9iWjMfQi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGgikeYt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGgikeYt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715063067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZ+ETUzNZvss8ggWS16XFwJ2hi3V3nobv2GAVfr5owc=;
	b=JGgikeYtLXP/VeeTXjFxGjjzdBTol7RSz6MMxdqQULiekhe1sxuRwxd7ljOfLhPM4UxN/A
	BsJEuft+TBw+xz/DQxI8XBL19rzPW3kvo2kakjQGuiqHc7StbatqHbaKM0UPpfICCIFtMD
	8qtWpkUrqCdiNLvROKV1+OMpKpmorSE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-KmFkLx7uOIuH6HGb2GYodQ-1; Tue, 07 May 2024 02:24:25 -0400
X-MC-Unique: KmFkLx7uOIuH6HGb2GYodQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6f475e364b7so912143b3a.3
        for <virtualization@lists.linux.dev>; Mon, 06 May 2024 23:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715063064; x=1715667864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZ+ETUzNZvss8ggWS16XFwJ2hi3V3nobv2GAVfr5owc=;
        b=cQI0eiatGKon7MnpEo1LRxTzezZjQerfYsybOzIpFqgRtDPRJbUE+0AkE87dD84uQN
         oN11hlqhojKo5m4KJkgW31KsOYEiBrO1EJeCiAdeR7WQy4R32MuqmfwxXLfZXXWtDTxI
         yzYKbVk1S1eyl5Ca66NDlcjofr/LvwDWOSRtMhDBc1EvAhQB7ZxKpUtYxi6J7NDRgr2P
         YDqquNxds5vLrD3nN7IGoUJzupkGXaPZ5hAaWCcDKw0+8OIca13tIBbhn/tRusSxLNIX
         1BEZhwU3dm9LLShl/jzuAE/hYtINOO0YDTZgABS9oe/GZ/8TSZeNtbDKvACNc5y5SIUK
         IWDw==
X-Forwarded-Encrypted: i=1; AJvYcCVUVhQy2gK83GajjyabfGhrKtZ7d6W/nocxby7BDwtJypo+duBVTrvDW6SzPzawvBaDS9PMt7mJXIYgX1BpRV5Py6UUElpLyALjMERUFaM=
X-Gm-Message-State: AOJu0Yy+y7ggwoQr5oMmFFzgrXq7XYEfowYC1W0fuN/p/AVcf7/iDILD
	ZGFedBNv91Nf0gIrs3hQGNNqiKO2SYyi1K4q861nITlttsCKBGPwd3mkg7vTP7oHx3kfH9dxYCE
	FKmATkls0OMN8tSPTdEZ/Z1mGztdPLWHD38GvhzjL98jJL1KiYjGMlcYK4PFR371WOi7DcpmKO/
	6Nb4dkyyN/3/dzFiamhR+Mm7BFjqWsQal11BQFO7F1JWEZK6A=
X-Received: by 2002:a05:6a20:6f0e:b0:1ae:a5bf:341b with SMTP id gt14-20020a056a206f0e00b001aea5bf341bmr11876034pzb.6.1715063064174;
        Mon, 06 May 2024 23:24:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKzr00JmO2nNOhi+vF4ygtl0LFmkgSLokWL69VRVrP0t/pz3CegSzwo6TR9dRXxnkss/lGqXK3XNbsg6ffDW4=
X-Received: by 2002:a05:6a20:6f0e:b0:1ae:a5bf:341b with SMTP id
 gt14-20020a056a206f0e00b001aea5bf341bmr11876027pzb.6.1715063063837; Mon, 06
 May 2024 23:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240426065441.120710-1-hengqi@linux.alibaba.com> <20240426065441.120710-3-hengqi@linux.alibaba.com>
In-Reply-To: <20240426065441.120710-3-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 May 2024 14:24:12 +0800
Message-ID: <CACGkMEs9nrFTjLa18XN9ZAokgLsw4MtXM3O3kVmQv=ofP49coA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] virtio_net: get init coalesce value when probe
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:54=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Currently, virtio-net lacks a way to obtain the default coalesce
> values of the device during the probe phase. That is, the device
> may have default experience values, but the user uses "ethtool -c"
> to query that the values are still 0.
>
> Therefore, we reuse VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET to complete the goal=
.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 68 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 61 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3bc9b1e621db..fe0c15819dd3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4623,6 +4623,46 @@ static int virtnet_validate(struct virtio_device *=
vdev)
>         return 0;
>  }
>
> +static int virtnet_get_coal_init_value(struct virtnet_info *vi,
> +                                      u16 _vqn, bool is_tx)
> +{
> +       struct virtio_net_ctrl_coal *coal =3D &vi->ctrl->coal_vq.coal;
> +       __le16 *vqn =3D &vi->ctrl->coal_vq.vqn;
> +       struct scatterlist sgs_in, sgs_out;
> +       u32 usecs, pkts, i;
> +       bool ret;
> +
> +       *vqn =3D cpu_to_le16(_vqn);
> +
> +       sg_init_one(&sgs_out, vqn, sizeof(*vqn));
> +       sg_init_one(&sgs_in, coal, sizeof(*coal));
> +       ret =3D virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> +                                        VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET=
,
> +                                        &sgs_out, &sgs_in);
> +       if (!ret)
> +               return ret;
> +
> +       usecs =3D le32_to_cpu(coal->max_usecs);
> +       pkts =3D le32_to_cpu(coal->max_packets);
> +       if (is_tx) {
> +               vi->intr_coal_tx.max_usecs =3D usecs;
> +               vi->intr_coal_tx.max_packets =3D pkts;
> +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +                       vi->sq[i].intr_coal.max_usecs =3D usecs;
> +                       vi->sq[i].intr_coal.max_packets =3D pkts;
> +               }
> +       } else {
> +               vi->intr_coal_rx.max_usecs =3D usecs;
> +               vi->intr_coal_rx.max_packets =3D pkts;
> +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +                       vi->rq[i].intr_coal.max_usecs =3D usecs;
> +                       vi->rq[i].intr_coal.max_packets =3D pkts;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
>  {
>         return virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> @@ -4885,13 +4925,6 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>                         vi->intr_coal_tx.max_packets =3D 0;
>         }
>
> -       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> -               /* The reason is the same as VIRTIO_NET_F_NOTF_COAL. */
> -               for (i =3D 0; i < vi->max_queue_pairs; i++)
> -                       if (vi->sq[i].napi.weight)
> -                               vi->sq[i].intr_coal.max_packets =3D 1;
> -       }
> -
>  #ifdef CONFIG_SYSFS
>         if (vi->mergeable_rx_bufs)
>                 dev->sysfs_rx_queue_group =3D &virtio_net_mrg_rx_group;
> @@ -4926,6 +4959,27 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>
>         virtio_device_ready(vdev);
>
> +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> +               /* The reason is the same as VIRTIO_NET_F_NOTF_COAL. */
> +               for (i =3D 0; i < vi->max_queue_pairs; i++)
> +                       if (vi->sq[i].napi.weight)
> +                               vi->sq[i].intr_coal.max_packets =3D 1;
> +
> +               /* The loop exits if the default value from any
> +                * queue is successfully read.
> +                */

So this assumes the default values are the same. Is this something
required by the spec? If not, we probably need to iterate all the
queues.

Thanks


> +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +                       err =3D virtnet_get_coal_init_value(vi, rxq2vq(i)=
, false);
> +                       if (!err)
> +                               break;
> +               }
> +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +                       err =3D virtnet_get_coal_init_value(vi, txq2vq(i)=
, true);
> +                       if (!err)
> +                               break;
> +               }
> +       }
> +
>         _virtnet_set_queues(vi, vi->curr_queue_pairs);
>
>         /* a random MAC address has been assigned, notify the device.
> --
> 2.32.0.3.g01195cf9f
>

