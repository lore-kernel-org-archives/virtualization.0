Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B8CC07E9D
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 04:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 730E2818E8;
	Tue, 27 Sep 2022 04:04:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 730E2818E8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fDG87E5h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uuEaKoRND6Fk; Tue, 27 Sep 2022 04:04:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED284818D0;
	Tue, 27 Sep 2022 04:04:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED284818D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C151BC0033;
	Tue, 27 Sep 2022 04:04:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 910DBC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 78B76818E8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:04:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78B76818E8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QX7IzT0eL4jj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:04:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3AF0818D0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3AF0818D0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 04:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664251440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pkfSN/TRKZmIDvmpkOE5MQSmymUdUH4cZBtMN20qr/4=;
 b=fDG87E5hMKGeVhjvIrdSz+VZln410NjTQHAz5mwnLhqS8k6YLdwg7TQcZFvl6Z35p3Iasi
 wruo8Uy0MradJT2rz8dLQBcnTIcr/QUKZC2yzSMDYgp4nU51I6CSwY9jLWs7Tu57XLHWnR
 bub4ln/UmLUq2kVnaJDQ49TShLqmiUc=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-EZn4WRYpMR6Esa-ukN69Gg-1; Tue, 27 Sep 2022 00:03:59 -0400
X-MC-Unique: EZn4WRYpMR6Esa-ukN69Gg-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1275c2d65feso3050679fac.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 21:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=pkfSN/TRKZmIDvmpkOE5MQSmymUdUH4cZBtMN20qr/4=;
 b=JI8lfAqH6CL9oKEcsVfoBv6CCWrkUBZy9Z41nBdb6sVvSCr39EVu6+BJcLeZuw04Nu
 sLDoMoCzPwQITCjIYJH6PV7hV1k93F6oHnNh+w317H/+8kadSG+T0tYJOZptHr9P7Kug
 SHM6UQCT1GVe1/DziLq/0EDMYSvuUUM2IrIjCgvu3P9Vcx98DNcaTSoqZkW6c43sHEGl
 IJX6iPbn/TWEx4HSeLJsDscd3Vs48XvQ8+rLEGtRR0RpeZkLGQhSIWCxN6tXyWGfTKDN
 7T9F3Z8SWM3Li9hG5t+0Qd5Q8+inxtT2Ly90lrHFkREiDSpID8pzfLSl0GKeVUgSSGvU
 T5ig==
X-Gm-Message-State: ACrzQf13GLAsr4ZDCVnw3gi/Gysjc5K8J453f9VjvgfuFBfGcfbmhngP
 v4BW+TF9DZFneF+KJXZ6b52T+yUQkHcQTTc4acbkEUvdQS1oHKFlT2TJsiDJgKerQXWzRQOZC5K
 W5bcE77JZ48wdjpre0aGhX/oSeK1rTL6sHZ9MAu1kGItYQCKzGbSuu1XfYQ==
X-Received: by 2002:a05:6870:e409:b0:127:d330:c941 with SMTP id
 n9-20020a056870e40900b00127d330c941mr1052909oag.280.1664251438532; 
 Mon, 26 Sep 2022 21:03:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4lvrSywDHF9s9u0uxXwTb8OdqTgXDn/UfbtlbRiotkX1PHWPgCIdg5l270UTrYKrsHnSnY59lEaBlY0FJNOjE=
X-Received: by 2002:a05:6870:e409:b0:127:d330:c941 with SMTP id
 n9-20020a056870e40900b00127d330c941mr1052906oag.280.1664251438364; Mon, 26
 Sep 2022 21:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220926091130.9244-1-liubo03@inspur.com>
In-Reply-To: <20220926091130.9244-1-liubo03@inspur.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Sep 2022 12:03:47 +0800
Message-ID: <CACGkMEvLXFBjChrVQSXMoS9gSqi_dRwn70FdiH5dfi87H47q4Q@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq() call
To: Bo Liu <liubo03@inspur.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Mon, Sep 26, 2022 at 5:11 PM Bo Liu <liubo03@inspur.com> wrote:
>
> It passes '_vq' to vring_free(), which still calls to_vvq()
> to get 'vq', let's directly pass 'vq'. It can avoid
> unnecessary call of to_vvq() in hot path.
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 8974c34b40fd..d6d77bf58802 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -221,7 +221,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>                                                void (*callback)(struct virtqueue *),
>                                                const char *name);
>  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
> -static void vring_free(struct virtqueue *_vq);
> +static void vring_free(struct vring_virtqueue *vq);
>
>  /*
>   * Helpers.
> @@ -1140,7 +1140,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
>         if (err)
>                 goto err_state_extra;
>
> -       vring_free(&vq->vq);
> +       vring_free(vq);
>
>         virtqueue_vring_init_split(&vring_split, vq);
>
> @@ -2059,7 +2059,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
>         if (err)
>                 goto err_state_extra;
>
> -       vring_free(&vq->vq);
> +       vring_free(vq);
>
>         virtqueue_vring_init_packed(&vring_packed, !!vq->vq.callback);
>
> @@ -2649,10 +2649,8 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  }
>  EXPORT_SYMBOL_GPL(vring_new_virtqueue);
>
> -static void vring_free(struct virtqueue *_vq)
> +static void vring_free(struct vring_virtqueue *vq)
>  {
> -       struct vring_virtqueue *vq = to_vvq(_vq);
> -
>         if (vq->we_own_ring) {
>                 if (vq->packed_ring) {
>                         vring_free_queue(vq->vq.vdev,
> @@ -2693,7 +2691,7 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>         list_del(&_vq->list);
>         spin_unlock(&vq->vq.vdev->vqs_list_lock);
>
> -       vring_free(_vq);
> +       vring_free(vq);
>
>         kfree(vq);
>  }
> --
> 2.27.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
