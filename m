Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BFC3FBA2
	for <virtualization@lists.linux.dev>; Tue,  7 May 2024 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715051743; cv=none; b=cf80PmqVxii3WIrOddabOU4kP54U48+O2xdc3mCX1hktddsZB/rMKjPPdzWs1W93GKDyBs5GJLxppDmfLuNxYI5fvihAhveyuzppzrJgbE5+rIg2Qzx8+O64toGWv5dCJhqv9P7BnwC/UCYiVRHSXP8zlURFUIOV3TQG0xSri5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715051743; c=relaxed/simple;
	bh=qsMSj74a6wtKbQn4FwSltQZ5iQWMntRYCKeVSm0ggfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS1NK4YNw9+5X+jh6KkXQ3q50mortBYAo5pQfXTYvBeirVH1claKFwwTLF0PzR0LxWSfH+t6MwGNYRIRaOm2kFR8VJdl9jpyWjBXgRqG20GhbdjlqUqghGNe8AzE8NuNVMpL51Ysjwih++bHUtuoYMDLjy2BIrNK1IO6TgjJPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7xOqWDV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7xOqWDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715051740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCtYHW0NjKLB0nCSn+O1Vd5dx6sDKEmMFyLfXDFnc2s=;
	b=S7xOqWDVOlldLJk42gonPe5uKJjJBRb4XLFRYDL0Fa1O8a8whpo/5Dwm0zV2LeLjUaKyDm
	YigEci6KO1go0urJt4BdJdoIH427vTmKxzGppiq+rTRXWoZFX7cdtKFSExEq1d/zCBNzL7
	KauC0eJBZdbTRW9n2YKVo8mg6QeUmr0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-V7QTcrROOWCGkHSCouHKfg-1; Mon, 06 May 2024 23:15:35 -0400
X-MC-Unique: V7QTcrROOWCGkHSCouHKfg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6f47c380709so1324811b3a.3
        for <virtualization@lists.linux.dev>; Mon, 06 May 2024 20:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715051734; x=1715656534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCtYHW0NjKLB0nCSn+O1Vd5dx6sDKEmMFyLfXDFnc2s=;
        b=MqyO72vAKn1wZ2064HEUbW4jpqA8MHauLP77PCOIPG9zY9wKmyqEyMw0a/XgnSjnSB
         be/ZBz07yhqc9SoEGN7ZK+naW1azFxwi48BE4t8is5xRzj61PmbPb9Nrwg/xL4woi5z7
         QTmzjzm0seX1l17QHKHwavmA0pmJRnxvf31k4mRdWByG7CJTnITqHHffK2YntewSFl21
         CjC8BZMw6l8EVyP15HeSe4j7hkcALcNBjsL8lpmotSjIb2JYKNJkmXb7KcE0Ezwhys6x
         Wp0DG8XJFXXB3+KZ6FX/Ti/+cB4iXq8yuVvJFMggwV1HnR9NkGSjcRbXzHVT92jj2pfv
         zH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyZQZ54D/dyXq1LptfXvOggK6JhGExM8ZVhseoFJ06ywM/+cWNiKVOACawPV55fVtDHl2vB/oGP8fckZGzifISQhU/oQiNZZiY+9F2Ofo=
X-Gm-Message-State: AOJu0Yy0vKJsZP06AGJsQUh96H7Jc2rWRUXeam4Ax/U2RELSs3gaSLQr
	shMrGMf619hBumfOUxFWqbxoKTWwPvkRqYORO6TxpXEqVa9L4fTWn6S98F8al6Ycr8hbbnvuG9T
	xPjCHKM8iRwAJzsKhC4OyQSak0W4kdkJMxTlxpltELQkZUqVz+MsJjoHLGEPAFPhKu/E2cq1r5E
	P7cXWfDtBUFFgEYXRGR4v1YiIuiOp7oD7jPRSXuC8=
X-Received: by 2002:a05:6a20:daa0:b0:1af:3cb0:f2db with SMTP id iy32-20020a056a20daa000b001af3cb0f2dbmr12688851pzb.33.1715051734412;
        Mon, 06 May 2024 20:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX9sBdeavQCqp0GC2N3/y/+ZLxAXe4p2CEF5HWhRGx/SCiedoMN/x52vC1mUZO9m/vk0Q/ebW/v1owRqISEss=
X-Received: by 2002:a05:6a20:daa0:b0:1af:3cb0:f2db with SMTP id
 iy32-20020a056a20daa000b001af3cb0f2dbmr12688838pzb.33.1715051733995; Mon, 06
 May 2024 20:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240425125855.87025-1-hengqi@linux.alibaba.com> <20240425125855.87025-2-hengqi@linux.alibaba.com>
In-Reply-To: <20240425125855.87025-2-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 May 2024 11:15:22 +0800
Message-ID: <CACGkMEtpy0ZDcGQReaPVtJy4hDcqdKQwEF2Uhf5W4+7g=jts-Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] virtio_net: enable irq for the control vq
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 8:59=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Control vq polling request results consume more CPU.
> Especially when dim issues more control requests to the device,
> it's beneficial to the guest to enable control vq's irq.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a4d3c76654a4..79a1b30c173c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -287,6 +287,12 @@ struct virtnet_info {
>         bool has_cvq;
>         struct mutex cvq_lock;
>
> +       /* Wait for the device to complete the request */
> +       struct completion completion;
> +
> +       /* Work struct for acquisition of cvq processing results. */
> +       struct work_struct get_cvq;
> +
>         /* Host can handle any s/g split between our header and packet da=
ta */
>         bool any_header_sg;
>
> @@ -520,6 +526,13 @@ static bool virtqueue_napi_complete(struct napi_stru=
ct *napi,
>         return false;
>  }
>
> +static void virtnet_cvq_done(struct virtqueue *cvq)
> +{
> +       struct virtnet_info *vi =3D cvq->vdev->priv;
> +
> +       schedule_work(&vi->get_cvq);
> +}
> +
>  static void skb_xmit_done(struct virtqueue *vq)
>  {
>         struct virtnet_info *vi =3D vq->vdev->priv;
> @@ -2036,6 +2049,20 @@ static bool try_fill_recv(struct virtnet_info *vi,=
 struct receive_queue *rq,
>         return !oom;
>  }
>
> +static void virtnet_get_cvq_work(struct work_struct *work)
> +{
> +       struct virtnet_info *vi =3D
> +               container_of(work, struct virtnet_info, get_cvq);
> +       unsigned int tmp;
> +       void *res;
> +
> +       mutex_lock(&vi->cvq_lock);
> +       res =3D virtqueue_get_buf(vi->cvq, &tmp);
> +       if (res)
> +               complete(&vi->completion);
> +       mutex_unlock(&vi->cvq_lock);
> +}
> +
>  static void skb_recv_done(struct virtqueue *rvq)
>  {
>         struct virtnet_info *vi =3D rvq->vdev->priv;
> @@ -2531,7 +2558,7 @@ static bool virtnet_send_command(struct virtnet_inf=
o *vi, u8 class, u8 cmd,
>                                  struct scatterlist *out)
>  {
>         struct scatterlist *sgs[4], hdr, stat;
> -       unsigned out_num =3D 0, tmp;
> +       unsigned out_num =3D 0;
>         int ret;
>
>         /* Caller should know better */
> @@ -2566,16 +2593,10 @@ static bool virtnet_send_command(struct virtnet_i=
nfo *vi, u8 class, u8 cmd,
>                 return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
>         }
>
> -       /* Spin for a response, the kick causes an ioport write, trapping
> -        * into the hypervisor, so the request should be handled immediat=
ely.
> -        */
> -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -              !virtqueue_is_broken(vi->cvq)) {
> -               cond_resched();
> -               cpu_relax();
> -       }
> -
>         mutex_unlock(&vi->cvq_lock);
> +
> +       wait_for_completion(&vi->completion);
> +

A question here, can multiple cvq requests be submitted to the device?
If yes, what happens if the device completes them out of order?

Thanks

>         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
>  }
>
> @@ -4433,7 +4454,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi=
)
>
>         /* Parameters for control virtqueue, if any */
>         if (vi->has_cvq) {
> -               callbacks[total_vqs - 1] =3D NULL;
> +               callbacks[total_vqs - 1] =3D virtnet_cvq_done;
>                 names[total_vqs - 1] =3D "control";
>         }
>
> @@ -4952,6 +4973,8 @@ static int virtnet_probe(struct virtio_device *vdev=
)
>         if (vi->has_rss || vi->has_rss_hash_report)
>                 virtnet_init_default_rss(vi);
>
> +       INIT_WORK(&vi->get_cvq, virtnet_get_cvq_work);
> +       init_completion(&vi->completion);
>         enable_rx_mode_work(vi);
>
>         /* serialize netdev register + virtio_device_ready() with ndo_ope=
n() */
> --
> 2.32.0.3.g01195cf9f
>

