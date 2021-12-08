Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EFFC4332F
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 03:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82DFA6061F;
	Wed,  8 Dec 2021 03:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JKJMr7mAs2Ty; Wed,  8 Dec 2021 03:43:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 28E80605BC;
	Wed,  8 Dec 2021 03:43:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2E1AC001E;
	Wed,  8 Dec 2021 03:43:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E5B7C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37AFE40144
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fAHi_cgcKtGZ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:43:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45333400C7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 03:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638935009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sffol2sjF3kR5DyO351++++uXmiYwv8fKQzdh/YzKIo=;
 b=aTPwa2RI9pw2qX9wpvV38MMq/mTJ/ss+v1NJS4Z66gQpeMe/xwwamGwrnjv4PASWWsP/6E
 /B0YjfYFFww2jKpBxryed8TVRy8X1PqIVaTsnSwparHFHKauuWXQYWhLyVaOgsOSGXjfcF
 V7n2GCew/iluIT04FmoaFvKZ6H9ksUY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-9SJBSd0jOPSUvEKO65CFuQ-1; Tue, 07 Dec 2021 22:43:27 -0500
X-MC-Unique: 9SJBSd0jOPSUvEKO65CFuQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 b3-20020a2ebc03000000b0021ffe75b14cso373456ljf.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Dec 2021 19:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sffol2sjF3kR5DyO351++++uXmiYwv8fKQzdh/YzKIo=;
 b=DlCcBjmw6QHtUS6QF4qB2QYbHwK0wfAYoGNrI2PLgutYLOwz6BchjJEtAEUsJ6YArJ
 F6kwlSvNpTyHdFVNDplWtLXbCKWPiwzF77MzUo15c5bML6shukwRK2t3yRDgamKq06fX
 esuHDCAuPL68rrvf+zkkUFXacrApIb3DtG/fiawEWpLOPLD7UW3ulFdREMyUPDhM7ctF
 ARghKBsz5GqPOzbLrZjI0YPDlTIP6xR1nVHktQ96ajMOBStjBar5wC4f6yU/o5mxvPKR
 41FrmapLv1jHplme2sMYpJ3uLvlFtXX8JNv/Q+85imRvXKRpmlxlM+IHMSeiRrmeyCiN
 EXdg==
X-Gm-Message-State: AOAM531Hc5E9241IsbCb5TA1wltTWzG30dbPsPBWFF8cyScBYlKAkq72
 Hwu5R2tzlWlBnK5IAD9GL+aETwirCwSgmp+jzaLRP7tbrRpgvDMNSPOhFGZAukMmO3yVNw3++le
 gJFHapw5zGpk2iPmrY79UmS14JDRCWLbCNmxEJ/8EtQzeI4fcUl5tSIyIHQ==
X-Received: by 2002:ac2:518b:: with SMTP id u11mr44956655lfi.498.1638935006234; 
 Tue, 07 Dec 2021 19:43:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwifyGeIctLq/WSdi2cAyKfVee7XdSfSCq6roNZPyfverU2yuaLd4tEDEZgqNhNbHIML6RhXCXYaXAxVT6/rSw=
X-Received: by 2002:ac2:518b:: with SMTP id u11mr44956640lfi.498.1638935006028; 
 Tue, 07 Dec 2021 19:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20211207114835.GA31153@kili>
In-Reply-To: <20211207114835.GA31153@kili>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Dec 2021 11:43:15 +0800
Message-ID: <CACGkMEsvLwSb_DexsQ8JLGF02AidOY0cMkfxuGK0QjKDkwP3UA@mail.gmail.com>
Subject: Re: [PATCH v3] vduse: vduse: check that offsets are within bounds
To: Dan Carpenter <dan.carpenter@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, Tiwei Bie <tiwei.bie@intel.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 Xie Yongji <xieyongji@bytedance.com>, Eli Cohen <elic@nvidia.com>
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

On Tue, Dec 7, 2021 at 7:49 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> In vduse_dev_ioctl(), the "config.offset" comes from the user.  There
> needs to a check to prevent it being out of bounds.  The "config.offset"
> and "dev->config_size" variables are both type u32.  So if the offset is
> out of bounds then the "dev->config_size - config.offset" subtraction
> results in a very high u32 value.
>
> The vhost_vdpa_config_validate() function has a similar issue, but there
> the "size" is long type so the subtraction works on 64bit system and
> this change only affects 32bit systems.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Stable candidate.

Patch looks good to me but I think we need to use separate patches to
ease the backporting.

Thanks

> ---
> v2: the first version had a reversed if statement
> v3: fix vhost_vdpa_config_validate() as pointed out by Yongji Xie.
>
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>  drivers/vhost/vdpa.c               | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index c9204c62f339..1a206f95d73a 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -975,7 +975,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                         break;
>
>                 ret = -EINVAL;
> -               if (config.length == 0 ||
> +               if (config.offset > dev->config_size ||
> +                   config.length == 0 ||
>                     config.length > dev->config_size - config.offset)
>                         break;
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 29cced1cd277..e3c4f059b21a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -197,7 +197,7 @@ static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
>         struct vdpa_device *vdpa = v->vdpa;
>         long size = vdpa->config->get_config_size(vdpa);
>
> -       if (c->len == 0)
> +       if (c->len == 0 || c->off > size)
>                 return -EINVAL;
>
>         if (c->len > size - c->off)
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
