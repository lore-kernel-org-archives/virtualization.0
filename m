Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7194C433F5
	for <virtualization@archiver.kernel.org>; Thu,  6 Jan 2022 12:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3765D405AA;
	Thu,  6 Jan 2022 12:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NryUPKLGrhw2; Thu,  6 Jan 2022 12:23:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E0391403B8;
	Thu,  6 Jan 2022 12:23:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C1DCC0030;
	Thu,  6 Jan 2022 12:23:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88973C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61A11405AA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fR5F-9YeuAeA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:23:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC893403B8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641471812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DIfBxULOavolfufOQdNG/vzCAo1esWK0a3vka0Ajyjs=;
 b=H6z8alnBOHpoSHFfpjx1TC22Hk0ABy2O491yPXJvmSTLHM7tRCwx0u4dVsi34KnjVmhs56
 RxM5DSffdej3+CCMcVNJbq5G+XggkxN5X6HzFyyoI10FjFyPi5autprQ3jSujJEDiPeQXt
 XG0s98pfWErjdHEbGq4JV2SH4pPAqxQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-yJN3QyLmM6mATyOAyMC1xw-1; Thu, 06 Jan 2022 07:23:30 -0500
X-MC-Unique: yJN3QyLmM6mATyOAyMC1xw-1
Received: by mail-wr1-f72.google.com with SMTP id
 i20-20020adfaad4000000b001a483095eafso1203396wrc.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 04:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DIfBxULOavolfufOQdNG/vzCAo1esWK0a3vka0Ajyjs=;
 b=ldroNeiQJrYfSRnz0Z6zmUhRJ0ilfiuqaUDP3HyGDZOXuX78YFCIcnpoOjPCEK8dah
 7KACmvMayX3ujZuzxQrsEmjRiHUjckaJSuxoTkOH3GZJJPypmz04vJj8LTBraxLxYrNX
 bAp8GGgb01TnTJTvjljjmXiy2I3TQJhJTcWfec83Sy/Ek5U1BcrdTftIHaOxEwOsHtyl
 v27Rv/kz3qP7NldmYlApcUm/WO8+OBTnamCLQCF5HQfdmArO+iZwtbgVIETywfNHUoFp
 i3a1TDivLi7q8tgjWMUWykdn/lt4r/wLuhH8PBxn8iDrD5xwwQmJjgl4LUMLvAJOrAE7
 R6ww==
X-Gm-Message-State: AOAM533dE/oara2QJcCSymatSGRl5k418yRuqu/+bg85B3G38hri5xJK
 Hqgl5xwHBu1FcvsN4VqQ7MV4F389jlVm8Zx4mRQ2oG4tIfMfSqwn2pYIDPgS5EHu0ldfU/6/5dW
 cDTEhdkvUE0LFgXrNadQMLqNEm1irapj3ptNi4FIKCQ==
X-Received: by 2002:a05:6000:3c8:: with SMTP id
 b8mr5369680wrg.152.1641471809678; 
 Thu, 06 Jan 2022 04:23:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCKaZ3Vwd4RKCtyVMKKYHTk+aalh3XwUj1HV3KC0ncZK7QR6PvJ9NCHxybq+bIctJq+mNlbw==
X-Received: by 2002:a05:6000:3c8:: with SMTP id
 b8mr5369670wrg.152.1641471809449; 
 Thu, 06 Jan 2022 04:23:29 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:991b:6857:5652:b903:a63b])
 by smtp.gmail.com with ESMTPSA id u15sm752186wmm.37.2022.01.06.04.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jan 2022 04:23:28 -0800 (PST)
Date: Thu, 6 Jan 2022 07:23:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cai Huoqing <caihuoqing@baidu.com>
Subject: Re: [PATCH] vhost: add vhost_test to Kconfig & Makefile
Message-ID: <20220106072056-mutt-send-email-mst@kernel.org>
References: <20210616120734.1050-1-caihuoqing@baidu.com>
MIME-Version: 1.0
In-Reply-To: <20210616120734.1050-1-caihuoqing@baidu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Wed, Jun 16, 2021 at 08:07:34PM +0800, Cai Huoqing wrote:
> When running vhost test, make it easier to config
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

I'd stick this under "Kernel Testing and Coverage"
or something like this. The point is we don't want this module
is release kernels.



> ---
>  drivers/vhost/Kconfig  | 12 ++++++++++++
>  drivers/vhost/Makefile |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 587fbae06182..c93c12843a6f 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -61,6 +61,18 @@ config VHOST_VSOCK
>         To compile this driver as a module, choose M here: the module will be called
>         vhost_vsock.
>  
> +config VHOST_TEST
> +       tristate "vhost virtio-test driver"
> +       depends on EVENTFD
> +       select VHOST
> +       default n
> +       help
> +       This kernel module can be loaded in the host kernel to test vhost function
> +       with tools/virtio-test.
> +
> +       To compile this driver as a module, choose M here: the module will be called
> +       vhost_test.
> +
>  config VHOST_VDPA
>         tristate "Vhost driver for vDPA-based backend"
>         depends on EVENTFD
> diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
> index f3e1897cce85..cf31c1f2652d 100644
> --- a/drivers/vhost/Makefile
> +++ b/drivers/vhost/Makefile
> @@ -8,6 +8,9 @@ vhost_scsi-y := scsi.o
>  obj-$(CONFIG_VHOST_VSOCK) += vhost_vsock.o
>  vhost_vsock-y := vsock.o
>  
> +obj-$(CONFIG_VHOST_TEST) += vhost_test.o
> +vhost_test-y := test.o
> +
>  obj-$(CONFIG_VHOST_RING) += vringh.o
>  
>  obj-$(CONFIG_VHOST_VDPA) += vhost_vdpa.o
> -- 
> 2.22.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
