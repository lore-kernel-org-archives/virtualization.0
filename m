Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A17AC433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 02:51:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6065600D4
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 02:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A6065600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65E7E403A0;
	Tue, 14 Sep 2021 02:51:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GcJ2Ij2-xRvM; Tue, 14 Sep 2021 02:51:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 184E84036D;
	Tue, 14 Sep 2021 02:51:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDF40C0011;
	Tue, 14 Sep 2021 02:51:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E803C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 604314036D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZouimF6QpmvX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:51:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A385340360
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631587870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OmTulBs9q+vbNMJfsRmajckF/MOURKwD1JqRZVK9QMw=;
 b=JWUu1L9/Fz1p79LaXZ/O+jBBJK8oAn+7zwieFjlGGwwNC3WtNS9BvetZHStUUyO8aOJkJC
 wEjqPTJfVMhkuJwJ1jVoA/07Wh0TM1aCwSOzetOrAc7+XayZdhDta/jTYnXVczrRBRX1oW
 kbIdbdxEznmSDCgbMhzU9himX5n6zQw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-zN_fCpBMO56ARVIPxo672g-1; Mon, 13 Sep 2021 22:51:09 -0400
X-MC-Unique: zN_fCpBMO56ARVIPxo672g-1
Received: by mail-lj1-f198.google.com with SMTP id
 w22-20020a2e9596000000b001ba46d9e54cso5140865ljh.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 19:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OmTulBs9q+vbNMJfsRmajckF/MOURKwD1JqRZVK9QMw=;
 b=MjrVlO68VgRuF9UpsMxjHULKoXxRTrlXtQHjfI9ONDRVg7Y7C3n/pzQ7SdujIUzuL1
 4OHPWGHPmY8wRuelMiDmm/1xX8qpTf7fy3yfLFBEazNXX0kjxcozN6rAp5hep9T3e11J
 IBGUUiamlSW0DuPXuD2cm/Q0KFLXLklASLdv0+cZQ90sWcq5p+Y+HshNEyqn8ZqLOoWV
 WFsyKVswiM/bt7+0zUTsfPxTkufed5tB0rKTP1aiMdtQqSnk7N7yij10hXLJELNWoDjr
 xFOZh1kIS95JO1rvAhXNUFPIMxwwjcffjY567QRyp1B7YhIbu+yP5GdZtY9hR6VBLiY1
 1N0g==
X-Gm-Message-State: AOAM530fe3j5NaCe742v2AH7zqQexQsvgabW/eo8bgs25eVVOEYBFbeJ
 VIPHYMD1oY+Kb0kmqfbZQHHhVnyn1GRQA36rTLQ9Kwkaucb3y9mhbzGszr7wzWSsT9dVisu/OC9
 NsFxTxGCZfjfA4Ie9ZRr05JntUCpS0S3GNQY+45nsW/mH64DzoUA4uKB91g==
X-Received: by 2002:a05:651c:b09:: with SMTP id
 b9mr13170741ljr.307.1631587868083; 
 Mon, 13 Sep 2021 19:51:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWV5sVHDiv+fgIFmhN9p5nU2mmIjZkCH4nqdLdqeo+9oSfLJ5OsAZxljqxcHXz1azMI0JJSKQuMLXiwLN5i50=
X-Received: by 2002:a05:651c:b09:: with SMTP id
 b9mr13170716ljr.307.1631587867859; 
 Mon, 13 Sep 2021 19:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210913104640.85839-1-mst@redhat.com>
In-Reply-To: <20210913104640.85839-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Sep 2021 10:50:56 +0800
Message-ID: <CACGkMEsXm+v14r=+ALCsxe82+Ht8dUS9_1y3YvD-kvKraAFUoQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: don't fail on !of_device_is_compatible
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Bill Mills <bill.mills@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>
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

On Mon, Sep 13, 2021 at 6:47 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> A recent change checking of_device_is_compatible on probe broke some
> powerpc/pseries setups. Apparently there virtio devices do not have a
> "compatible" property - they are matched by PCI vendor/device ids.
>
> Let's just skip of_node setup but proceed with initialization like we
> did previously.
>
> Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Arnd could you help review this pls? Viresh is on vacation.
>
>  drivers/virtio/virtio.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index c46cc1fbc7ae..19a70a2361b4 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -347,8 +347,13 @@ static int virtio_device_of_init(struct virtio_device *dev)
>         ret = snprintf(compat, sizeof(compat), "virtio,device%x", dev->id.device);
>         BUG_ON(ret >= sizeof(compat));
>
> +       /*
> +        * On powerpc/pseries virtio devices are PCI devices so PCI
> +        * vendor/device ids play the role of the "compatible" property.
> +        * Simply don't init of_node in this case.
> +        */
>         if (!of_device_is_compatible(np, compat)) {
> -               ret = -EINVAL;
> +               ret = 0;
>                 goto out;
>         }

Acked-by: Jason Wang <jasowang@redhat.com>

>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
