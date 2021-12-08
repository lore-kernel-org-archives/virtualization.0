Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BAEC433F5
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 03:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A66241D9A;
	Wed,  8 Dec 2021 03:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B5a6rkfE9KXT; Wed,  8 Dec 2021 03:49:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F283541D94;
	Wed,  8 Dec 2021 03:49:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C25D4C001E;
	Wed,  8 Dec 2021 03:49:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B793C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D939E400D7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:49:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I6ggktvP2D2t
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:49:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD67A400C7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638935394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbNR4mMXoFOwRoHf96a8A/7B507xyOIch1pviY3TwBc=;
 b=PibZjfYsbDVXL6Sa0zfci8eQaMXANOD0gMdur8+O3xxX0rtFpD2+H8hGwoymILfwh7ZBzU
 x1MV/qPoOqwtuYwLoDWRo0fc0dibLIjiZFnvtOPy2p7SdTw/icMk8VveG3hm8qq/uag7Fj
 ho8ido/TWYS87cqZwiWyhiANNxV0vd4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-DltkaCAJOEiac6pAFtdmlQ-1; Tue, 07 Dec 2021 22:49:52 -0500
X-MC-Unique: DltkaCAJOEiac6pAFtdmlQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 24-20020ac25f58000000b0041799ebf529so521100lfz.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Dec 2021 19:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sbNR4mMXoFOwRoHf96a8A/7B507xyOIch1pviY3TwBc=;
 b=z217ID1Ab8z7MuxDj1WETLdXVfiK+j6+tr2KTaOCXXzqGCgIsUJbpZ7KhoWuk0IZbw
 Zqo+91SqONAppoq60jDyMx1dLhYIn+Cj6EyU8Dre/+qEIUhUubRROnKbyVr1DDP7B9Bq
 OLqSYdnYXEF+D84qr9rX/+IE/KYEydkYGv/Nckv/RTAUE4hQe7LMUO/MtJJcqSh+po6g
 YsAepH9fTGtZ2tRwAYlkaN70ZDzWUS4vYW7kj0o5JBVG838kNhD8nHVQhsJFbtKLUMpv
 ZxgkGZd7rudKSVdrnban7MEwNu2jZpZweIN4EFwT8IK8XjXDqozbbNakNcUToDH94/13
 2Htw==
X-Gm-Message-State: AOAM531Pv3ExhIdNI5hQq8kchpCOXk199ZCSAIbr5AnCFRYb0i7GScdw
 ah9JEjQjTFM/fa/w1O/dtyHWvrA1X+KaSNqLc3DZEx+7VRa6jiK1LLucJoVltiepvMP3vcNzaaP
 e69r/gVEmhrFEuyhX9FW40QHnYaxlr7li/D6+XGSaIFvo9G3gaXc0vTs0YQ==
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr45328232lfr.348.1638935390534; 
 Tue, 07 Dec 2021 19:49:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwa6tJfy966wiDD6j/h2KgfE2OUDXg7IMN1Yg8wI1nsg8xT9xj+unD7OtErbYIiNmyUA/ZWbYmapOxegrPsHxM=
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr45328210lfr.348.1638935390318; 
 Tue, 07 Dec 2021 19:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20211207024510.23292-1-michael.christie@oracle.com>
 <20211207024510.23292-2-michael.christie@oracle.com>
In-Reply-To: <20211207024510.23292-2-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Dec 2021 11:49:39 +0800
Message-ID: <CACGkMEskNm079dzOaxNOFA6_K4r-9=hAs8VXcxqi4SKDKtozsQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] vhost: get rid of vhost_poll_flush() wrapper
To: Mike Christie <michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Ryabinin <arbn@yandex-team.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mst <mst@redhat.com>
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

On Tue, Dec 7, 2021 at 10:45 AM Mike Christie
<michael.christie@oracle.com> wrote:
>
> vhost_poll_flush() is a simple wrapper around vhost_work_dev_flush().
> It gives wrong impression that we are doing some work over vhost_poll,
> while in fact it flushes vhost_poll->dev.

This "problem" is a byproduct of 7235acdb1144 ("vhost: simplify work flushing").

Before that we indeed have per poll flush flush.

> It only complicate understanding of the code and leads to mistakes
> like flushing the same vhost_dev several times in a row.
>
> Just remove vhost_poll_flush() and call vhost_work_dev_flush() directly.

Not a native speaker but since we don't have an per work flush, is it
better to rename this simply as vhost_flush()?

Thanks

>
> Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
> [merge vhost_poll_flush removal from Stefano Garzarella]
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/net.c   |  4 ++--
>  drivers/vhost/test.c  |  2 +-
>  drivers/vhost/vhost.c | 12 ++----------
>  drivers/vhost/vhost.h |  1 -
>  drivers/vhost/vsock.c |  2 +-
>  5 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 28ef323882fb..11221f6d11b8 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1375,8 +1375,8 @@ static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
>
>  static void vhost_net_flush_vq(struct vhost_net *n, int index)
>  {
> -       vhost_poll_flush(n->poll + index);
> -       vhost_poll_flush(&n->vqs[index].vq.poll);
> +       vhost_work_dev_flush(n->poll[index].dev);
> +       vhost_work_dev_flush(n->vqs[index].vq.poll.dev);
>  }
>
>  static void vhost_net_flush(struct vhost_net *n)
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index a09dedc79f68..1a8ab1d8cb1c 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -146,7 +146,7 @@ static void vhost_test_stop(struct vhost_test *n, void **privatep)
>
>  static void vhost_test_flush_vq(struct vhost_test *n, int index)
>  {
> -       vhost_poll_flush(&n->vqs[index].poll);
> +       vhost_work_dev_flush(n->vqs[index].poll.dev);
>  }
>
>  static void vhost_test_flush(struct vhost_test *n)
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 8cf259d798c0..7346fa519eb6 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -244,14 +244,6 @@ void vhost_work_dev_flush(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_work_dev_flush);
>
> -/* Flush any work that has been scheduled. When calling this, don't hold any
> - * locks that are also used by the callback. */
> -void vhost_poll_flush(struct vhost_poll *poll)
> -{
> -       vhost_work_dev_flush(poll->dev);
> -}
> -EXPORT_SYMBOL_GPL(vhost_poll_flush);
> -
>  void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
>  {
>         if (!dev->worker)
> @@ -677,7 +669,7 @@ void vhost_dev_stop(struct vhost_dev *dev)
>         for (i = 0; i < dev->nvqs; ++i) {
>                 if (dev->vqs[i]->kick && dev->vqs[i]->handle_kick) {
>                         vhost_poll_stop(&dev->vqs[i]->poll);
> -                       vhost_poll_flush(&dev->vqs[i]->poll);
> +                       vhost_work_dev_flush(dev->vqs[i]->poll.dev);
>                 }
>         }
>  }
> @@ -1721,7 +1713,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>         mutex_unlock(&vq->mutex);
>
>         if (pollstop && vq->handle_kick)
> -               vhost_poll_flush(&vq->poll);
> +               vhost_work_dev_flush(vq->poll.dev);
>         return r;
>  }
>  EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 09748694cb66..67b23e178812 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -56,7 +56,6 @@ void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
>                      __poll_t mask, struct vhost_dev *dev);
>  int vhost_poll_start(struct vhost_poll *poll, struct file *file);
>  void vhost_poll_stop(struct vhost_poll *poll);
> -void vhost_poll_flush(struct vhost_poll *poll);
>  void vhost_poll_queue(struct vhost_poll *poll);
>  void vhost_work_dev_flush(struct vhost_dev *dev);
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index d6ca1c7ad513..2339587bcd31 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -707,7 +707,7 @@ static void vhost_vsock_flush(struct vhost_vsock *vsock)
>
>         for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
>                 if (vsock->vqs[i].handle_kick)
> -                       vhost_poll_flush(&vsock->vqs[i].poll);
> +                       vhost_work_dev_flush(vsock->vqs[i].poll.dev);
>         vhost_work_dev_flush(&vsock->dev);
>  }
>
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
