Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85291EB64DC
	for <virtualization@archiver.kernel.org>; Mon,  3 Jul 2023 14:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3F7582041;
	Mon,  3 Jul 2023 14:52:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3F7582041
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h4iqkmzq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AH6tZQF04Gq5; Mon,  3 Jul 2023 14:52:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6A3D582020;
	Mon,  3 Jul 2023 14:52:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A3D582020
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35D17C0072;
	Mon,  3 Jul 2023 14:52:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 859E5C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 14:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49A2482045
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 14:52:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49A2482045
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U03jokL5MBRy
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 14:52:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F208082051
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F208082051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jul 2023 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688395930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxWPFMlR4kZ1+JmDhDbo+VkKWcHB0JOfutQmGW+4K4A=;
 b=h4iqkmzqPsxbHIv1LKZSNOPPs7YARH7opbcXwO6vszNJwupLV/0hY9sskgyiUBQaSCR26+
 aehpKWfbH/+vwZO8+q9kT/LNh1b1+zrcnkEZeheCyet9IRL8XaK7aqDMcflZE+HiLgZqfr
 wpZUS93xzVIbhMWASVWLmbIsWpPVEKM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-k7DAAEVCNvCWfhhgD6Pqkg-1; Mon, 03 Jul 2023 10:52:08 -0400
X-MC-Unique: k7DAAEVCNvCWfhhgD6Pqkg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbb6675155so24876605e9.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Jul 2023 07:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688395927; x=1690987927;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxWPFMlR4kZ1+JmDhDbo+VkKWcHB0JOfutQmGW+4K4A=;
 b=PsgcZI2VcXX9uNGNbrla9Kk6xAaB8PQfDF0tdWWp3LHiNsWpnic5dgw8Vjt0iz1Vbg
 m2ya0ZWycN5ZdqFs628g8KISnGSZFXGGT2p3/00S6i249Dpkfl5FxSvx52tcFb9cnb5A
 9EO0hKP3qzHvep7ZBaAx9Y3uexKrmiwzPc7P6yJ66lwWRfdVqzAiHlaKw/6y6jhtLa3l
 /ay9mwjIkBZVlEexwFS0SyXP6WRBm5At1aHwqPOsfTb4IvokhNZ7S1xRF/MfuX7jXx9E
 ZW8OJH3rEcyJbV0qnkcGS3CVVPmnTazQFEv+SZuGayCd0rs7XkI16qk+SsH/xPvXaIoR
 o6/A==
X-Gm-Message-State: AC+VfDx0bAejv/KZ9h8vAIOtBq1212gMso3eDrHSTtsaqQG7zGHJCm9p
 l7dey4BvZg0Jv3wo8g/va90mO8MwAuVlWa04I7pcQOxhYjzF2uLI7fL3lx9bQqGkaenxCPVRFzU
 YK9uQfD2dCkr16/8o2Py1lWQQkR3Ur0vTwXaI2/lmXA==
X-Received: by 2002:a1c:7908:0:b0:3f8:fb7c:6793 with SMTP id
 l8-20020a1c7908000000b003f8fb7c6793mr7708568wme.24.1688395927802; 
 Mon, 03 Jul 2023 07:52:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47ys+l55usHyGP6AT5yJibBBM3aCFWJJsiZ8eURago1u09Y9uC8molkOyCSHZ78useV0c8hg==
X-Received: by 2002:a1c:7908:0:b0:3f8:fb7c:6793 with SMTP id
 l8-20020a1c7908000000b003f8fb7c6793mr7708551wme.24.1688395927496; 
 Mon, 03 Jul 2023 07:52:07 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 24-20020a05600c229800b003fa98908014sm21973630wmf.8.2023.07.03.07.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 07:52:07 -0700 (PDT)
Date: Mon, 3 Jul 2023 10:52:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does
 not support it
Message-ID: <20230703105022-mutt-send-email-mst@kernel.org>
References: <20230703142218.362549-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230703142218.362549-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jul 03, 2023 at 04:22:18PM +0200, Eugenio P=E9rez wrote:
> With the current code it is accepted as long as userland send it.
> =

> Although userland should not set a feature flag that has not been
> offered to it with VHOST_GET_BACKEND_FEATURES, the current code will not
> complain for it.
> =

> Since there is no specific reason for any parent to reject that backend
> feature bit when it has been proposed, let's control it at vdpa frontend
> level. Future patches may move this control to the parent driver.
> =

> Fixes: 967800d2d52e ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK=
 backend feature")
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>

Please do send v3. And again, I don't want to send "after driver ok" hack
upstream at all, I merged it in next just to give it some testing.
We want RING_ACCESS_AFTER_KICK or some such.


> ---
> Sent with Fixes: tag pointing to git.kernel.org/pub/scm/linux/kernel/git/=
mst
> commit. Please let me know if I should send a v3 of [1] instead.
> =

> [1] https://lore.kernel.org/lkml/20230609121244-mutt-send-email-mst@kerne=
l.org/T/
> ---
>  drivers/vhost/vdpa.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index e1abf29fed5b..a7e554352351 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -681,18 +681,21 @@ static long vhost_vdpa_unlocked_ioctl(struct file *=
filep,
>  {
>  	struct vhost_vdpa *v =3D filep->private_data;
>  	struct vhost_dev *d =3D &v->vdev;
> +	const struct vdpa_config_ops *ops =3D v->vdpa->config;
>  	void __user *argp =3D (void __user *)arg;
>  	u64 __user *featurep =3D argp;
> -	u64 features;
> +	u64 features, parent_features =3D 0;
>  	long r =3D 0;
>  =

>  	if (cmd =3D=3D VHOST_SET_BACKEND_FEATURES) {
>  		if (copy_from_user(&features, featurep, sizeof(features)))
>  			return -EFAULT;
> +		if (ops->get_backend_features)
> +			parent_features =3D ops->get_backend_features(v->vdpa);
>  		if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
>  				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
>  				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
> -				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
> +				 parent_features))
>  			return -EOPNOTSUPP;
>  		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
>  		     !vhost_vdpa_can_suspend(v))
> -- =

> 2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
