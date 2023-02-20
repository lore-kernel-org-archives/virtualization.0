Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799A5C636D6
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 05:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F88340BA3;
	Mon, 20 Feb 2023 05:38:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F88340BA3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EuAz6Dxn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eDWKspXL4-7o; Mon, 20 Feb 2023 05:38:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F17440B8A;
	Mon, 20 Feb 2023 05:38:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F17440B8A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 679E7C0032;
	Mon, 20 Feb 2023 05:38:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 826F1C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 516D160AE6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 516D160AE6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EuAz6Dxn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7_cenAWxxL6W
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F389460E68
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F389460E68
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676871523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yCQzVL0m47wsQLdwtLFz4otj/LV0/YxGSvpolJZLdXc=;
 b=EuAz6Dxn8tN50ewyKoKSurlZ1cqPLYtF7HdY3fhmR4DF6vcwaF2JBR6nDqIQLQGbHVgovV
 N1pKadm714INJYHZVgu5SxKR/KpHPQbmTQ6GBHjbVF+vbO3TRWLDiMjLfhZ2icIMjyFiQL
 XBAiLZ13rqio7maeUbSOd+xcAlj5ma0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-576-ooKw_eIeMiyuoi9AJmypKw-1; Mon, 20 Feb 2023 00:38:41 -0500
X-MC-Unique: ooKw_eIeMiyuoi9AJmypKw-1
Received: by mail-oi1-f199.google.com with SMTP id
 o6-20020a0568080bc600b00363be5d9f42so51136oik.15
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Feb 2023 21:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yCQzVL0m47wsQLdwtLFz4otj/LV0/YxGSvpolJZLdXc=;
 b=7ZM4o4GRGNtMtJXYish+F/rbJdpZ+9FtdcR9v5g4n3q4e357X3kzG6VswBOo3Fp0BF
 cD8+UdjjcJPlnzoWIyxGfk5VMKJlsnlvIEoGw/l1eqZTDN13oAuZagabudUNcmjrec9Q
 a4P3VwCFA+jgoPDBm1WsFbTW6WcsfvZL/LfuzDKMvpgJyLvpMMH1qAMwDLr6jmLaCaam
 gEz06AXkfzS4uxN4V7icfWAV+xj/zu99LpAwopK1c9JE+Ft6UcznqBuZwhlgR/SOYZPX
 K5YUhFKXdIxR3QbHtUTebVOBZMNAi+Sdy0MfzGtYZVM12h0Tf+5lQ+AqkxrNJ4MiGPiK
 h0qQ==
X-Gm-Message-State: AO0yUKV+/H6FajlCVKnnl5h/MOsbMsVnsFDnGGTmnq8k+H4z+rI+/Xnc
 xD6H/CZQZ5d/E5FDw/xcsYW88HzhXgEP1nWM2zMc9zaYfggfVk3T1Zt6cGer6sraOtM8M/Y8Hrn
 eT9h/A7Jq4aDVuy4guAGIRhOxhuPkdEIlimdIWNI4pZo41CCpelJZ2glCsA==
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr920525oib.217.1676871521088; 
 Sun, 19 Feb 2023 21:38:41 -0800 (PST)
X-Google-Smtp-Source: AK7set/5DsQM4srHcu7zbJGgPz/o9Z2wXND47MvI16ZlIsKjHRjjFXe5RdPV5OPtnj9Pog7sfB0oRD8CqcXtCHIKCQc=
X-Received: by 2002:a05:6808:1812:b0:37a:3ebc:d282 with SMTP id
 bh18-20020a056808181200b0037a3ebcd282mr920522oib.217.1676871520884; Sun, 19
 Feb 2023 21:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230214072704.126660-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Feb 2023 13:38:30 +0800
Message-ID: <CACGkMEtYxLp93m25hFA=xn_kVCh6eHD92CZq=SWGgNDE3c41Jw@mail.gmail.com>
Subject: Re: [PATCH vhost 10/10] virtio_ring: introduce virtqueue_reset()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Introduce virtqueue_reset() to release all buffer inside vq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 50 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  2 ++
>  2 files changed, 52 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2ba60a14f557..2750a365439a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2930,6 +2930,56 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_resize);
>
> +/**
> + * virtqueue_reset - detach and recycle all unused buffers
> + * @_vq: the struct virtqueue we're talking about.
> + * @recycle: callback to recycle unused buffers
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error.
> + * 0: success.
> + * -EBUSY: Failed to sync with device, vq may not work properly
> + * -ENOENT: Transport or device not supported
> + * -EPERM: Operation not permitted
> + */
> +int virtqueue_reset(struct virtqueue *_vq,
> +                   void (*recycle)(struct virtqueue *vq, void *buf))
> +{
> +       struct vring_virtqueue *vq = to_vvq(_vq);
> +       struct virtio_device *vdev = vq->vq.vdev;
> +       void *buf;
> +       int err;
> +
> +       if (!vq->we_own_ring)
> +               return -EPERM;
> +
> +       if (!vdev->config->disable_vq_and_reset)
> +               return -ENOENT;
> +
> +       if (!vdev->config->enable_vq_after_reset)
> +               return -ENOENT;
> +
> +       err = vdev->config->disable_vq_and_reset(_vq);
> +       if (err)
> +               return err;
> +
> +       while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
> +               recycle(_vq, buf);
> +
> +       if (vq->packed_ring)
> +               virtqueue_reinit_packed(vq);
> +       else
> +               virtqueue_reinit_split(vq);
> +
> +       if (vdev->config->enable_vq_after_reset(_vq))
> +               return -EBUSY;
> +
> +       return 0;
> +}

I don't get why not factor the similar logic from virtqueue_resize()?

Thanks


> +EXPORT_SYMBOL_GPL(virtqueue_reset);
> +
>  /* Only available for split ring */
>  struct virtqueue *vring_new_virtqueue(unsigned int index,
>                                       unsigned int num,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index d0e707d744a0..cf4c157e4e75 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -106,6 +106,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>
>  int virtqueue_resize(struct virtqueue *vq, u32 num,
>                      void (*recycle)(struct virtqueue *vq, void *buf));
> +int virtqueue_reset(struct virtqueue *vq,
> +                   void (*recycle)(struct virtqueue *vq, void *buf));
>
>  /**
>   * struct virtio_device - representation of a device using virtio
> --
> 2.32.0.3.g01195cf9f
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
