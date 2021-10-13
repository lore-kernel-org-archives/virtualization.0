Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E113AC433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 09:51:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A656008E
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 09:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77A656008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33F8760818;
	Wed, 13 Oct 2021 09:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bjYSMR1tB8bg; Wed, 13 Oct 2021 09:51:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B8C6A6076A;
	Wed, 13 Oct 2021 09:51:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C0F8C0011;
	Wed, 13 Oct 2021 09:51:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC869C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 09:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D70F407C3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 09:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7csDuvXf-fSR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 09:51:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 88A7140786
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634118664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2bMtuqmvFrBXvajo5ygYeexeG09umaxUpukubw0/PIg=;
 b=Tw5OPXlS+FgLn4D6k5l/9JyeseDJS6+RzZUnuIU15MmI+JjoBAvuSKIdkl4k7im7pD0RVp
 c7BOX/zxMmsY3uv4dABPIqK6IhOJE0TcfGkjTyh76a2eIluLbJfFbj1+VLibk0gVnz3xXg
 JwU8xr828JtfU5lQMaX3WKSI+n05G4g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-FTaM8P3GMPuE0Sz4jl6J1Q-1; Wed, 13 Oct 2021 05:51:01 -0400
X-MC-Unique: FTaM8P3GMPuE0Sz4jl6J1Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 r16-20020adfbb10000000b00160958ed8acso1506958wrg.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 02:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2bMtuqmvFrBXvajo5ygYeexeG09umaxUpukubw0/PIg=;
 b=tQMEmvQkVu8NgpcTgER0wVxyif/UXy1o4AG8iY14/rwYOAliVfOx9En4V5khNHmzw8
 LbSYoDDqQQ1P/KEAYU3hXias2EDIPDyupnJ3x7fumo1tRA4tirbSCw8I3JhDj/MlwUo7
 9TYWXsd6RQEfPWHsQGcA+OJYwPK/IIGtQGmK4Z0BocqXKWzVAbioTgVVgetoYkjZcJq6
 xyGYC/kg6AOfYoeyc8VwXGwBDbe71SZHV441sfWJHxMc81936OLy/r5ONGEVadTHFNbw
 N+h1e0RLk56A3+F0uEkXTARDUqrLDoWGkvlrCaGJf7cs4DxLrXo1jGNxATct2fGq6JLE
 yVsg==
X-Gm-Message-State: AOAM530DBf3yKrIDn5loneqGy2Ih0WRgH51vvZf3eQp3IjOgLmyzNKv8
 fkuhFjqLs+LJ9VYZRawJgv0Jfzw9Wahd+fdct5lrpiI5gTwTpuIm2tmqfNuOHqXwR6GHaFaZQBq
 KG8zT+dL0YY/rhEyD4xQn2He3h5O+UAVtzli1zY8maQ==
X-Received: by 2002:a7b:c14b:: with SMTP id z11mr11708567wmi.67.1634118660014; 
 Wed, 13 Oct 2021 02:51:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7UAlyix1UxhXcSJPbjy6Nzg7rV88ALGuAtobs2lkuFZgGVV2vGm8vG/ZgnqMYwvr0pTsHzA==
X-Received: by 2002:a7b:c14b:: with SMTP id z11mr11708551wmi.67.1634118659819; 
 Wed, 13 Oct 2021 02:50:59 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id l17sm12559893wrx.24.2021.10.13.02.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 02:50:59 -0700 (PDT)
Date: Wed, 13 Oct 2021 05:50:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 03/12] virtio-console: switch to use .validate()
Message-ID: <20211013054334-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-4-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211012065227.9953-4-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: f.hetzelt@tu-berlin.de, david.kaplan@amd.com, Amit Shah <amit@kernel.org>,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
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

On Tue, Oct 12, 2021 at 02:52:18PM +0800, Jason Wang wrote:
> This patch switches to use validate() to filter out the features that
> is not supported by the rproc.

are not supported

> 
> Cc: Amit Shah <amit@kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Does this have anything to do with hardening?

It seems cleaner to not negotiate features we do not use,
but given we did this for many years ... should we bother
at this point?


> ---
>  drivers/char/virtio_console.c | 41 ++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 7eaf303a7a86..daeed31df622 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1172,9 +1172,7 @@ static void resize_console(struct port *port)
>  
>  	vdev = port->portdev->vdev;
>  
> -	/* Don't test F_SIZE at all if we're rproc: not a valid feature! */
> -	if (!is_rproc_serial(vdev) &&
> -	    virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> +	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
>  		hvc_resize(port->cons.hvc, port->cons.ws);
>  }
>  
> @@ -1981,6 +1979,29 @@ static void virtcons_remove(struct virtio_device *vdev)
>  	kfree(portdev);
>  }
>  
> +static int virtcons_validate(struct virtio_device *vdev)
> +{
> +	if (is_rproc_serial(vdev)) {
> +		/* Don't test F_SIZE at all if we're rproc: not a
> +		 * valid feature! */


This comment needs to be fixed now. And the format's wrong
since you made it a multi-line comment.
Should be
	/*
	 * like
	 * this
	 */

> +		__virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_SIZE);
> +		/* Don't test MULTIPORT at all if we're rproc: not a
> +		 * valid feature! */
> +		__virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_MULTIPORT);
> +	}
> +
> +	/* We only need a config space if features are offered */
> +	if (!vdev->config->get &&
> +	    (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
> +	     || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Once we're further in boot, we get probed like any other virtio
>   * device.

This switches the order of tests around, so if an rproc device
offers VIRTIO_CONSOLE_F_SIZE or VIRTIO_CONSOLE_F_MULTIPORT
without get it will now try to work instead of failing.

Which is maybe a worthy goal, but given rproc does not support
virtio 1.0 it also risks trying to drive something completely
unreasonable.

Overall does not feel like hardening which is supposed to make
things more strict, not less.


> @@ -1996,15 +2017,6 @@ static int virtcons_probe(struct virtio_device *vdev)
>  	bool multiport;
>  	bool early = early_put_chars != NULL;
>  
> -	/* We only need a config space if features are offered */
> -	if (!vdev->config->get &&
> -	    (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
> -	     || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
> -		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> -			__func__);
> -		return -EINVAL;
> -	}
> -
>  	/* Ensure to read early_put_chars now */
>  	barrier();
>  
> @@ -2031,9 +2043,7 @@ static int virtcons_probe(struct virtio_device *vdev)
>  	multiport = false;
>  	portdev->max_nr_ports = 1;
>  
> -	/* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
> -	if (!is_rproc_serial(vdev) &&
> -	    virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
> +	if (virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
>  				 struct virtio_console_config, max_nr_ports,
>  				 &portdev->max_nr_ports) == 0) {
>  		multiport = true;
> @@ -2210,6 +2220,7 @@ static struct virtio_driver virtio_console = {
>  	.driver.name =	KBUILD_MODNAME,
>  	.driver.owner =	THIS_MODULE,
>  	.id_table =	id_table,
> +	.validate = 	virtcons_validate,
>  	.probe =	virtcons_probe,
>  	.remove =	virtcons_remove,
>  	.config_changed = config_intr,
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
