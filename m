Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F91C43334
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 08:11:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32A0760B64;
	Wed,  8 Jun 2022 08:11:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n44WcRX8iTEw; Wed,  8 Jun 2022 08:11:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C77A060B60;
	Wed,  8 Jun 2022 08:11:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A271CC0039;
	Wed,  8 Jun 2022 08:11:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27CCAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15BFB4199E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R7xuHOvBZaYf
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:11:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 453E74198D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654675905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wnBT58Y92YriRHNYFwkaJJZXg0dEepk6NxGeotGng9s=;
 b=D2+egFo65wRqPhP17WkgPqRUbQYWwT4mb2+abSgZSKq/3A9xQyePPMtL9+8i9bfnkiUhG9
 nuydjfznhybWw7VsEdSyEY4pJpXu8CM/ZEFrQ2sQYo5eY11DpBTblxyS6uiSZgq2WVxLWv
 HVEoD79c9NGeBUv75cp97/9aQzoKhW4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-vnRAtmZ-OuCkUWwtPpXkCA-1; Wed, 08 Jun 2022 04:11:44 -0400
X-MC-Unique: vnRAtmZ-OuCkUWwtPpXkCA-1
Received: by mail-lf1-f71.google.com with SMTP id
 s12-20020a056512202c00b00478f00fcb3dso9949606lfs.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Jun 2022 01:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wnBT58Y92YriRHNYFwkaJJZXg0dEepk6NxGeotGng9s=;
 b=UQMxTE2kYewAv8vqbDuELVkWq47ERkgC2aoUcKzrdSa19Poc226V3itSre8FDRG9rR
 tY+Ic0VvIRmwauXZC7L5euxl/JcUwAxjVWFOxUjOQPVWpyyyC2Awb+cUDZiP4fPUcaXL
 AsZFSjLKmmJoFiMUZ+dl6bXYDTMWVb22Jf6iVBGKtWoqlle22wiltlH0ZXRw5BcyUMJH
 +O5fD25eQLmsrKHI+t1VydpVQysGVkyCvIhO5zJEVuW8LykyUlZZWJLGvvGBDF8kvCzO
 IvEcLtnpBh3i+xcyvM7/bhw9aL6Pkc2YULclmOQUXzkJyYLo67c1MzNxZpRKTjBpzpTx
 ONIQ==
X-Gm-Message-State: AOAM530jK8jaGwFSbhsW28uXufxHaPUebeLh3apXappIOyhfSzL/EnjD
 vONtYq3aRbp7zM2wUJsqwIeFzI6K5fIW470ZWl2Yb90i5Bw+vuz7dW2rS+D9JjfhG6EiNbh+GNL
 gsCj5tZwdSshP9UErTKGzyHrCb7HVOLXFuWthbeQ4Z4zLeeKdgUjayrejLg==
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id
 b5-20020a2ebc05000000b0024b212d7521mr54616042ljf.243.1654675903266; 
 Wed, 08 Jun 2022 01:11:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFLTmBIi19ULkbHjw6TAyJpy08J0Qcv4mWpgPuSLf8SO3gP77EMGa0hPs5LddZudYxdYh1mDiNswq8UEfjRtE=
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id
 b5-20020a2ebc05000000b0024b212d7521mr54616032ljf.243.1654675903108; Wed, 08
 Jun 2022 01:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220602005542.16489-1-chengkaitao@didiglobal.com>
In-Reply-To: <20220602005542.16489-1-chengkaitao@didiglobal.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Jun 2022 16:11:31 +0800
Message-ID: <CACGkMEvrRmLZ6aqo8J8wxpuqWSbsa=oEOGS+g80bLQzDKv=bww@mail.gmail.com>
Subject: Re: [PATCH] virtio-mmio: fix missing put_device() when
 vm_cmdline_parent registration failed
To: chengkaitao <pilgrimtao@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: smcdef@gmail.com,
 virtualization <virtualization@lists.linux-foundation.org>,
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

On Thu, Jun 2, 2022 at 9:12 AM chengkaitao <pilgrimtao@gmail.com> wrote:
>
> From: chengkaitao <pilgrimtao@gmail.com>
>
> The reference must be released when device_register(&vm_cmdline_parent)
> failed. Add the corresponding 'put_device()' in the error handling path.
>
> Signed-off-by: chengkaitao <pilgrimtao@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_mmio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 56128b9c46eb..1dd396d4bebb 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -688,6 +688,7 @@ static int vm_cmdline_set(const char *device,
>         if (!vm_cmdline_parent_registered) {
>                 err = device_register(&vm_cmdline_parent);
>                 if (err) {
> +                       put_device(&vm_cmdline_parent);
>                         pr_err("Failed to register parent device!\n");
>                         return err;
>                 }
> --
> 2.14.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
