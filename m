Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7522CC433F5
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 06:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DF1F6105F;
	Wed, 30 Mar 2022 06:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sunPvPpGWV_q; Wed, 30 Mar 2022 06:57:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B29BF60D4E;
	Wed, 30 Mar 2022 06:57:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77F59C002C;
	Wed, 30 Mar 2022 06:57:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB52DC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D90DE4186C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:57:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zEoGoCKX5Zzl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:57:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E38D5417C0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648623436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BlGn54gkEq56ZEq4yxxp6UGaagJu669pehgEVDXqc+s=;
 b=Z32x/2+kvSbZjVyewEGEPpg/B/NduBwvmQXwILyInYMnVfCFKwC9czmWoIxfuyPkedIJd7
 gurJ+Mov3h7EEJu4oRvU/GLuy7TH4Q8CzQ7mgY7v9lTZTStH++NmB6hqvWIvWxDh3wBLD9
 sYvZWckHpxNUUdvRmy3C5wNUEAGy4j0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-zsspWqocPKyw2i3jhie6bg-1; Wed, 30 Mar 2022 02:57:14 -0400
X-MC-Unique: zsspWqocPKyw2i3jhie6bg-1
Received: by mail-lj1-f198.google.com with SMTP id
 v6-20020a2e9246000000b002497a227e15so8330053ljg.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 23:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BlGn54gkEq56ZEq4yxxp6UGaagJu669pehgEVDXqc+s=;
 b=2Uh6+YxrY15utzeiofAZyBohq2g3Kc0uXa0re0Fh8M6nh2fdOzxaQupNwGmKgTV+bZ
 Oz8SYGo2deO5qzu/+HajEQYx/NAVc9/HPb2uSk35Nbz89JGa7GiMlfQTs2U1BQwXZ5sc
 9a5snd5lAS5mXMoW/d6v1UrmsX4o56D6oGoDWHnMD2zl64lAWumIhfiw6Y+T+RQbs30Z
 hnQnNCMrR+v0DAmQae+rG54PIRREiTIm5YfkqkrUvSu7bKXjBr7zdbpLa1fy/gaN06pK
 Vsq3sRT98cJOJ0CQzfZzPPM6IwodRAapo6lpJntJwLS/WByOV4qn7Kz3dB92jkhrr0a7
 +7wg==
X-Gm-Message-State: AOAM532m1kWfihJTP7qr79RvplxVfMv0SG4K/prkfU5LId5IqXgOERR1
 4v6DU9ZlxUWe8SvE2/iFuXK03N969bqyOS3158pOCpVbOD0M3mK+g+yvnBdxjmm7f2PWrwuF3N/
 IbO7bhoQ1xrdta+dyA2oID8m4vLWnkPVsHYQgJeaP9Vp9YjaGOOmvgffpsw==
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr5802732lfd.190.1648623433274; 
 Tue, 29 Mar 2022 23:57:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxgBMDOOCDdXaX9T2w++d+QTu7fkFTESyY1gxiCdJXf/23pMTqhJyEoQUM51UXvHb14nmZ7AXVi9wIgw55ET0=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr5802717lfd.190.1648623432982; Tue, 29
 Mar 2022 23:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220330062315.125924-1-mst@redhat.com>
 <20220330062315.125924-2-mst@redhat.com>
In-Reply-To: <20220330062315.125924-2-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 30 Mar 2022 14:57:02 +0800
Message-ID: <CACGkMEvWDQWOWqM6xvxSHkXqGf5_kPR6-enrLUvhA4WW=p0ZYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "virtio_config: introduce a new .enable_cbs
 method"
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
> This reverts commit d50497eb4e554e1f0351e1836ee7241c059592e6.
>
> The new callback ended up not being used, and it's asymmetrical:
> just enable, no disable.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  include/linux/virtio_config.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index dafdc7f48c01..b341dd62aa4d 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -23,8 +23,6 @@ struct virtio_shm_region {
>   *       any of @get/@set, @get_status/@set_status, or @get_features/
>   *       @finalize_features are NOT safe to be called from an atomic
>   *       context.
> - * @enable_cbs: enable the callbacks
> - *      vdev: the virtio_device
>   * @get: read the value of a configuration field
>   *     vdev: the virtio_device
>   *     offset: the offset of the configuration field
> @@ -78,7 +76,6 @@ struct virtio_shm_region {
>   */
>  typedef void vq_callback_t(struct virtqueue *);
>  struct virtio_config_ops {
> -       void (*enable_cbs)(struct virtio_device *vdev);
>         void (*get)(struct virtio_device *vdev, unsigned offset,
>                     void *buf, unsigned len);
>         void (*set)(struct virtio_device *vdev, unsigned offset,
> @@ -233,9 +230,6 @@ void virtio_device_ready(struct virtio_device *dev)
>  {
>         unsigned status = dev->config->get_status(dev);
>
> -       if (dev->config->enable_cbs)
> -                  dev->config->enable_cbs(dev);
> -
>         BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>         dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>  }
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
