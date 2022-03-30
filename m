Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AFBC433F5
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 06:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8821940B42;
	Wed, 30 Mar 2022 06:57:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Db-Avcck8129; Wed, 30 Mar 2022 06:57:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 384C7409D6;
	Wed, 30 Mar 2022 06:57:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C19AC002C;
	Wed, 30 Mar 2022 06:57:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 370C9C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3346640B3E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:57:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a7C2IIat4NlD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:57:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DC63409D6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648623419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/qKUvRRDyEZQxeQ5LJrbQhUwwlKMs3DpMfIG+d7qfFw=;
 b=hHW+lR4MOKM8e7km1YJaYHGLLKlIlYmeKXLehZ0iv+yG4cimBkju/nqJh9K7C4WeobsIaq
 hWxoshpVVln5mwfuUCCGCz6l8H9P8E/U/Il6CsbtJIsdJwtVpBlSGpSU8qnOd89UkgFF84
 NwypGBtoPSA85ydxab+xb9nS0C+gc9w=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-sE65Z8UfPXGA15fqwPb7mw-1; Wed, 30 Mar 2022 02:56:57 -0400
X-MC-Unique: sE65Z8UfPXGA15fqwPb7mw-1
Received: by mail-lj1-f197.google.com with SMTP id
 v9-20020a2e9909000000b00247ecf60956so8340892lji.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 23:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/qKUvRRDyEZQxeQ5LJrbQhUwwlKMs3DpMfIG+d7qfFw=;
 b=vIOv2S8Apc4iekT4GRmGLPb7ZsiVtkcJwlyVmXwXwbZ2MQi3M184VVqgoDOuVFpziH
 byMoi58iEVXF0PtZiJqNreLKJ2NVuwKnQiMejikotx3x9ZTwUfhQVGY49CkBci9A6Hqa
 BRY6IejhRqukZrkZmNIEM78N9/J88eVngG/Q0Lxx+tFQXovJe6Gde9kFKDEJ+1N0cdwn
 Q63aBGRePwiompHVACIJ7vsUNd1SeEyWuiNTQ3ewiuz3FE4eYLFeKTsVqGq/eH63O3Gx
 QKv07xBu3TJc+1tIeWU7j/FkzNJWcmSo+kX0l9a+/l8HQ9EyGeRSzHE8aVaJTNGMHDSJ
 I67w==
X-Gm-Message-State: AOAM532hplp/mUh3gQNNX5um10962sa11TtC2XdxOWpzq2IpJPCfSQH1
 ggX+JBLh4g/JFr7ZNsHe29ygwe8TO1FxboNvckl81LVvJjQWa4/Be+8uZlTihFJP3d8bjQ9yZSC
 LrX31r92KjexIowADo2Bjo+KtP1wspnOgDvR7F0tHxt0Amf48aVNIFsKEag==
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr5793364lfv.257.1648623416067; 
 Tue, 29 Mar 2022 23:56:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvR34KN4X2wt0BQXe0xslAEoh0cLasw/9DhLwWUYs42y4tkSy7O7S9Lma3mNvczzLnVOeM3VUuQRhtiXkaBC0=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr5793351lfv.257.1648623415897; Tue, 29
 Mar 2022 23:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220330062315.125924-1-mst@redhat.com>
In-Reply-To: <20220330062315.125924-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 30 Mar 2022 14:56:44 +0800
Message-ID: <CACGkMEth00XnrHmurhNHJ=sAs-BWdaRQ1fE638OTM9Fsq0WPzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "virtio: use virtio_device_ready() in
 virtio_device_restore()"
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Mar 30, 2022 at 2:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> This reverts commit 8d65bc9a5be3f23c5e2ab36b6b8ef40095165b18.
>
> We reverted the problematic changes, no more need for work
> arounds on restore.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 75c8d560bbd3..22f15f444f75 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -526,9 +526,8 @@ int virtio_device_restore(struct virtio_device *dev)
>                         goto err;
>         }
>
> -       /* If restore didn't do it, mark device DRIVER_OK ourselves. */
> -       if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> -               virtio_device_ready(dev);
> +       /* Finally, tell the device we're all set */
> +       virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
>
>         virtio_config_enable(dev);
>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
