Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100E6C433F5
	for <virtualization@archiver.kernel.org>; Thu,  6 Jan 2022 12:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4DB082EE1;
	Thu,  6 Jan 2022 12:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dp33CrcneKKX; Thu,  6 Jan 2022 12:25:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4D45981A15;
	Thu,  6 Jan 2022 12:25:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 256ECC0030;
	Thu,  6 Jan 2022 12:25:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EAC5C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C990428AA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jo75zsoY-p3p
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:24:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C485428A8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641471893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0uPOPPljcCRT5JnCSjBYTsAZ9QvLUTF6yXLYqezm/jk=;
 b=TRiXqEUxE7KuA99lKmqzrqDNxkNScZCWtrXHJ5qdEN3IgQU2/Z+45eaRWHxwO0FRXamXEj
 PJEDiNefTlhZ8x5WRkGSg6x0K8iZEBj287/POrc1Rp1+pnD8MO8YSiVLUgkGH2eNeoMF0F
 dBeTdhs5r+ovRH6e3Pg47cESHf7UNKU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-6GxfTMuhN8CRqYFpiAFC-w-1; Thu, 06 Jan 2022 07:24:52 -0500
X-MC-Unique: 6GxfTMuhN8CRqYFpiAFC-w-1
Received: by mail-wr1-f70.google.com with SMTP id
 w2-20020adfbac2000000b001a540eeb812so501559wrg.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 04:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0uPOPPljcCRT5JnCSjBYTsAZ9QvLUTF6yXLYqezm/jk=;
 b=t13kCR+Z9f+9P7ubVRMsiNIBlAFZTOnxwBm55CSN2iSLIRZdGOj7olHQi95ly2jwBA
 I7pWeb4xA5db3WLC6057KHSx3jSxEdB2PHgs4O0qpEKWIJian/A+A0jHtD/On76a0HQN
 hfGgY6kFTCdKT1NGb0tyGHsgDR1ETCRbs+G428M3IpoO2pAND5qAT7rWw5KydccQlTkX
 m477C1/UiXAOgaBT+X5gAHgeF5lAaUpu4wgmTYAtRwRexpe/G9Xt/LJB4Rnhty2mmOmZ
 83lR92AlBU9Vh8qfQOTBwmzK9X+WfZ8ylZsqEoVtcOb0whfQZgdD08dfzb2jV/Y2BNH/
 2S5g==
X-Gm-Message-State: AOAM530rtKu6jrNF0091rU51VKf5e10NoYDW/V3+jUCo0/fi1lpoqRbA
 F6bJWC9XPbnmVTMgZAIhQjhqHhYN79kGWai7BD3DZ5Z/z5wQ9LQA4pzCFJeW3XQoAUt38HVX+x4
 +R8LL6YTcOIVBKEpOvaqT3UNtq71ngPjDsYVxhc1Quw==
X-Received: by 2002:adf:f904:: with SMTP id b4mr31756836wrr.457.1641471890970; 
 Thu, 06 Jan 2022 04:24:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcnYl5f7mjbdHhw5BDaaDbej/KBrzommpeO6kEVNqKU1TlflODCHM/SPqrxpiLKr97ZxWBog==
X-Received: by 2002:adf:f904:: with SMTP id b4mr31756826wrr.457.1641471890799; 
 Thu, 06 Jan 2022 04:24:50 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:991b:6857:5652:b903:a63b])
 by smtp.gmail.com with ESMTPSA id l8sm1945393wrv.25.2022.01.06.04.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jan 2022 04:24:49 -0800 (PST)
Date: Thu, 6 Jan 2022 07:24:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cai Huoqing <caihuoqing@baidu.com>
Subject: Re: [PATCH v2] vhost: add vhost_test to Kconfig & Makefile
Message-ID: <20220106072352-mutt-send-email-mst@kernel.org>
References: <20210617033844.1107-1-caihuoqing@baidu.com>
MIME-Version: 1.0
In-Reply-To: <20210617033844.1107-1-caihuoqing@baidu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, leon@kernel.org,
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

On Thu, Jun 17, 2021 at 11:38:44AM +0800, Cai Huoqing wrote:
> When running vhost test, make it easier to config
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

I'd stick this under Kernel Testing and Coverage or something like this.
The point being we don't want this in release kernels by mistake.

> ---
>  drivers/vhost/Kconfig  | 11 +++++++++++
>  drivers/vhost/Makefile |  3 +++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 587fbae06182..ac2bffd6a501 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -61,6 +61,17 @@ config VHOST_VSOCK
>         To compile this driver as a module, choose M here: the module will be called
>         vhost_vsock.
>  
> +config VHOST_TEST
> +       tristate "vhost virtio-test driver"
> +       depends on EVENTFD
> +       select VHOST
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
