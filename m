Return-Path: <SRS0=6YK7=MJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DC3C636CA
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 20:38:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363FE610CD
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 20:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363FE610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD312606DD;
	Sat, 17 Jul 2021 20:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UZT3CKX1fDC1; Sat, 17 Jul 2021 20:38:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6E5836061C;
	Sat, 17 Jul 2021 20:38:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41E69C0010;
	Sat, 17 Jul 2021 20:38:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23A58C000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 20:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11EE8606DD
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 20:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xFX5JwsvFeC7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 20:38:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29E696061C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 20:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626554327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8EtYCpcxRADi4LXwaivB5MA+Bu89mNzLa8P5NGTQ8a0=;
 b=Dw0IcOp+SZp+3vJyNMIyHk5GLsQiH3CsWytDGiokYbK0trybhsMg/TrNbyna4KLnyIgh6w
 GRG1Xi2dcDgICW2uMzRNSgT3y0bNIGWPfsLjxHV+tRSWhmY8x9sPqbiXQzlLbwxFOLYzfw
 WO3N0PpAyRkUq+awEDq6Qkgojxk/Udc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-57NL29yhMiWHZCjZOfsUWA-1; Sat, 17 Jul 2021 16:38:46 -0400
X-MC-Unique: 57NL29yhMiWHZCjZOfsUWA-1
Received: by mail-wr1-f71.google.com with SMTP id
 y15-20020a5d614f0000b029013cd60e9baaso6812022wrt.7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 13:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8EtYCpcxRADi4LXwaivB5MA+Bu89mNzLa8P5NGTQ8a0=;
 b=DRapbote/nxa6F1q5Zl6wsDQkv/Lp8KLyhLH+z2tZIzG7/sct9fA/52/1shtKQbDHp
 SHY/kjEGCkFpBWc8NUtMDhY0tiWWxIgL59AoXxV+vMjBMwORsO2TatDCFiLZ6jE2Vr9Y
 11soeKacTlixCL/XLQpFv2QbRmpHD8Msn+O0fuo19KuMPAmvATtvjHmFWF+ozEaonzxH
 tkluC8xgLUkcl0nL2k/epSv4WvRBa/BicvIoMMfFXkGo/SuoKA4gb5IUrDcKLuEU0TZe
 ynKWrd9FLHfEHqPwC9oVPZwOL68ZvJ+rpb/TJDwOoCp1bdaahOQ0zuvEccwWXYq9WVtl
 4FmA==
X-Gm-Message-State: AOAM5311Uby/ZszAUsnii6SIhR6qqbwp7Mn24MFBNIIdKt8iZw+T/c0U
 GB5OxoU15D7qQF5wlXZJVIlMeG1GvWbM7Cgk1PjEl9VLmgQiRz8mm6BfTi/vIEEV3j5XHE4Xc/i
 7djrF550rFVSNu6beV+ub/WO/JiDK1PkA3W6IQoXlaQ==
X-Received: by 2002:a05:600c:2e52:: with SMTP id
 q18mr18184394wmf.100.1626554325323; 
 Sat, 17 Jul 2021 13:38:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFaryQsobsMIRaLiv87bX99rwzi9+MJbPZuMi4mXsS6l5Oy4lI15w9lFcM2CQx91e8YQ7ZaA==
X-Received: by 2002:a05:600c:2e52:: with SMTP id
 q18mr18184386wmf.100.1626554325185; 
 Sat, 17 Jul 2021 13:38:45 -0700 (PDT)
Received: from redhat.com ([2.55.29.175])
 by smtp.gmail.com with ESMTPSA id p11sm14617726wrw.53.2021.07.17.13.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jul 2021 13:38:44 -0700 (PDT)
Date: Sat, 17 Jul 2021 16:38:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 1/4] virtio: Improve vq->broken access to avoid any
 compiler optimization
Message-ID: <20210717163319-mutt-send-email-mst@kernel.org>
References: <20210717074258.1463313-1-parav@nvidia.com>
 <20210717074258.1463313-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210717074258.1463313-2-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Sat, Jul 17, 2021 at 10:42:55AM +0300, Parav Pandit wrote:
> Currently vq->broken field is read by virtqueue_is_broken() in busy
> loop in one context by virtnet_send_command().
> 
> vq->broken is set to true in other process context by
> virtio_break_device(). Reader and writer are accessing it without any
> synchronization. This may lead to a compiler optimization which may
> result to optimize reading vq->broken only once.
> 
> Hence, force reading vq->broken on each invocation of
> virtqueue_is_broken() and ensure that its update is visible.
>
> Fixes: e2dcdfe95c0b ("virtio: virtio_break_device() to mark all virtqueues broken.")

This is all theoretical right?
virtqueue_get_buf is not inlined so compiler generally
assumes any vq field can change.

I'm inclined to not include a Fixes
tag then. And please do change subject to say "theoretical"
to make that clear to people.
 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  drivers/virtio/virtio_ring.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 89bfe46a8a7f..7f379fe7d78d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2373,7 +2373,7 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->broken;
> +	return READ_ONCE(vq->broken);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_is_broken);
>  
> @@ -2387,7 +2387,9 @@ void virtio_break_device(struct virtio_device *dev)
>  
>  	list_for_each_entry(_vq, &dev->vqs, list) {
>  		struct vring_virtqueue *vq = to_vvq(_vq);
> -		vq->broken = true;
> +
> +		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> +		smp_store_release(&vq->broken, true);

A bit puzzled here. Why do we need release semantics here?
IUC store_release does not generally pair with READ_ONCE - does it?

The commit log does not describe this either.

>  	}
>  }
>  EXPORT_SYMBOL_GPL(virtio_break_device);
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
