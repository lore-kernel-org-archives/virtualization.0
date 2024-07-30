Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB6198E81
	for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337507; cv=none; b=krLrFtg4hPY4cUKHLyTsbEhyyT2g5maiTfDsZS8mqqDjbrrW7AXQfeay+0oEbuXWQFUXslC5zkm+LwVDbUzwooRND9Wn+CT0AdDVWg5JF/Xbwzox18YAyIjjEk+xVvictrlOcH/34uygYGdEwIcmFFWCJ1iEgdOdXQyJ/JmtUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337507; c=relaxed/simple;
	bh=f/gw5g15wTHKr48hY+hyHzqdgUY3CrBD090e33xvywA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdNsBARCBbgLTsdfCrP0B9RhpNfdyJTPpoB235uH53hzPK+PqbZVIak7ey3wfIjq1rVbI1B8LJ1Smiz5vbGSLHjMn/qEoJOOfLU8ng1cfQAH7DqUGhFyQLUPd9RA37zz0Ag9KgUuNzoJP/K3/PUX0brK6xN6/wKlZepfclqeqAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1zR4TUC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1zR4TUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722337505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S79Mm994sEW4BvAIyVoQYJTT5VMn2Pbd/zrnW1wpgO8=;
	b=R1zR4TUCAeKPHzWsHb2rzxAkPADzUh4PFxAHDcN4UY8aLxz93HUrqQvV3upB7MaKgGIISh
	7fgdgmki5AEzSBQO0/Ki1srYEDPZ6TVyOfg5sD1ToLQbVBOTyM/fbh+WYc6lWyr5lhKpo9
	9uda2M6p7JVTcNq8jIbSU64G8WV1Uis=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-GjfoPEPLPmi0b4_GdTnGCg-1; Tue, 30 Jul 2024 07:05:02 -0400
X-MC-Unique: GjfoPEPLPmi0b4_GdTnGCg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-666010fb35cso55826307b3.0
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 04:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722337499; x=1722942299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S79Mm994sEW4BvAIyVoQYJTT5VMn2Pbd/zrnW1wpgO8=;
        b=aSiYZKCgFKaiQ6ddMdWin8F2OtPo/od5zKglFUYPahlCxQml2LmAdkdx3SIj6bOS9H
         M6pVH5w0NGD+i9OG03Ea76M2tFNB1WveGR9+ZYAz0ksLXH6vtEUwZmZOvRpTkfK39YpX
         PUDzI9WG8443EJzHM1593YnMV4z5P9VFvVv96EIJU5EImtLgwpWKyrLdFOxTFim0wVBz
         7vSmtZvHZjqFC62eWn6qoWJ8ODrB447XniGuLsoTPKdXuCiHdBL7yA2SGzmp5PTomyTt
         EMJjZ8yfCOCE/BVhVGl3D2QcGOnE+f89kcD+t7ZvDpDwdfNr+r40cyaGZlVM4064g4nV
         K2Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWfqVbmunlgSdw6O6WJoeiw2AZiDB68p1q4g7MYWJAjrEJch+r70yVFFte15Q/RRVkr9Cv8IoMwTZUxz0E3EhFdTIl8DfiPvxqrwdzYF5Q=
X-Gm-Message-State: AOJu0YzGtBn9LGFCf70fm9LHYXg/FnDl0G2NfEutp94QhFLPC3t6u0WQ
	0sRBHvLyWkT4DHP36xk6t24yPTkhQ/jkBYs8RwgVPjysopsmSi3GTJP2Klw4k3WAHpuwKRGN5Mp
	uaSSRWOZkYc1XFoPrfEFjdXxsAdzLH9PE/UF+Q/B4Kbkp9KqCQfjAQIhgImzPvGQuEDJm/2zDnS
	uQumwd48MRxu9ORU0HH9WKhLCq7qgCmtwrJIZGF2lK5bXLSqpFrg==
X-Received: by 2002:a0d:fec4:0:b0:65f:cdb7:46a7 with SMTP id 00721157ae682-6826d4349a5mr14880067b3.22.1722337499248;
        Tue, 30 Jul 2024 04:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvq5rMoFu9LqacC+P0Kfq2pQmfz3t1RdLZrFXLSzkvnEneXakdi1b8mE4ArvawUUBUj04oZUqGLTJf0qaz+K4=
X-Received: by 2002:a0d:fec4:0:b0:65f:cdb7:46a7 with SMTP id
 00721157ae682-6826d4349a5mr14879897b3.22.1722337498953; Tue, 30 Jul 2024
 04:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729124755.35719-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240729124755.35719-1-hengqi@linux.alibaba.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 30 Jul 2024 13:04:23 +0200
Message-ID: <CAJaqyWd+euHy1S_eaxTEY3v9QmAH6pCSG=CnRiZJuNE07=mMTw@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:48=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> From the virtio spec:
>
>         The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
>         feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
>         and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
>
> The driver must not send vq notification coalescing commands if
> VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> applies to vq resize.
>
> Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq re=
size")

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..eb115e807882 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3708,6 +3708,7 @@ static int virtnet_set_ringparam(struct net_device =
*dev,
>         u32 rx_pending, tx_pending;
>         struct receive_queue *rq;
>         struct send_queue *sq;
> +       u32 pkts, usecs;
>         int i, err;
>
>         if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> @@ -3740,11 +3741,13 @@ static int virtnet_set_ringparam(struct net_devic=
e *dev,
>                          * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET c=
ommand, or, if the driver
>                          * did not set any TX coalescing parameters, to 0=
.
>                          */
> -                       err =3D virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> -                                                              vi->intr_c=
oal_tx.max_usecs,
> -                                                              vi->intr_c=
oal_tx.max_packets);
> -                       if (err)
> -                               return err;
> +                       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_=
NOTF_COAL)) {
> +                               usecs =3D vi->intr_coal_tx.max_usecs;
> +                               pkts =3D vi->intr_coal_tx.max_packets;
> +                               err =3D virtnet_send_tx_ctrl_coal_vq_cmd(=
vi, i, usecs, pkts);
> +                               if (err)
> +                                       return err;
> +                       }
>                 }
>
>                 if (ring->rx_pending !=3D rx_pending) {
> @@ -3753,13 +3756,15 @@ static int virtnet_set_ringparam(struct net_devic=
e *dev,
>                                 return err;
>
>                         /* The reason is same as the transmit virtqueue r=
eset */
> -                       mutex_lock(&vi->rq[i].dim_lock);
> -                       err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
> -                                                              vi->intr_c=
oal_rx.max_usecs,
> -                                                              vi->intr_c=
oal_rx.max_packets);
> -                       mutex_unlock(&vi->rq[i].dim_lock);
> -                       if (err)
> -                               return err;
> +                       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_=
NOTF_COAL)) {
> +                               usecs =3D vi->intr_coal_rx.max_usecs;
> +                               pkts =3D vi->intr_coal_rx.max_packets;
> +                               mutex_lock(&vi->rq[i].dim_lock);
> +                               err =3D virtnet_send_rx_ctrl_coal_vq_cmd(=
vi, i, usecs, pkts);
> +                               mutex_unlock(&vi->rq[i].dim_lock);
> +                               if (err)
> +                                       return err;
> +                       }
>                 }
>         }
>
> --
> 2.32.0.3.g01195cf9f
>

