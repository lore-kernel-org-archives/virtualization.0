Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC7FC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 02:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D2544026E;
	Thu,  9 Dec 2021 02:12:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id foYu9K7ydn8O; Thu,  9 Dec 2021 02:12:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 17F854029B;
	Thu,  9 Dec 2021 02:12:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBCF3C001E;
	Thu,  9 Dec 2021 02:12:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A15B0C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 02:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7BAFC408C7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 02:12:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gu3C69CTQuw9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 02:12:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEECF408C4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 02:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639015939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9XApc7myklo4XiTNzNFWuXpd9KaEiqqgHRFbQFqoZcI=;
 b=EreTlwpWntRYcDqwV7XSKMOscQ+TKik0jR+FFHes7D+XHT3rhIjZ2pxekJrD7OtINZYi5K
 O0RNBZr/ci10hn0E0hwrUBWkg2fWniMj0Y6qhqz8aShEbhawfpXOts4BRaxg4JHZbZmQK+
 OjG83i8p+mBbp/RV3kZI2BNnusU9pik=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-t4Z6EPpdOZO1y6P7P5Q-9A-1; Wed, 08 Dec 2021 21:12:18 -0500
X-MC-Unique: t4Z6EPpdOZO1y6P7P5Q-9A-1
Received: by mail-lj1-f198.google.com with SMTP id
 u28-20020a2ea17c000000b0021126b5cca2so1236752ljl.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 18:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9XApc7myklo4XiTNzNFWuXpd9KaEiqqgHRFbQFqoZcI=;
 b=MPF1USutwUSTud016lQThBwHJCWXvDGvOFMqFgPyVn7Gyqx83dINteuTc86CD5nHfo
 C8LJmvhnLVIEfvzxj0TNi70nZ/HJhjlapB1oIGQCYfl3pucSMoPV75iNtAgjbW2VpyOX
 YH6KQbfLqa/XV0bdS+QEQ1OJZkWetWOPaK8bJcVrfoSZjcBvozOO1HgrUN1VIWbIV1cY
 6MsPQdDUjmXty03WLhP1d2m9IPlKiVIHvpHDrdMk2EfejdD8NlUAimM7SFAIxrqul3C5
 QkMaViM8QdcmXLvPg6evPWJDcHSlnocLR/T9WLESBLZR4m2wX5fummIjARnlM9sgYr54
 XtMA==
X-Gm-Message-State: AOAM532dB0eMQ6k8CCSDONHN8FmamczuC0ogQuLNt2GUq+iZOcchEyW5
 odkbzrkvEc2yPduk8BpnzBqlUt6ZDPRdjKiMMdnhLHeBj421G5A6FbK+9vxubYF5Ywy3wc476VO
 XjdfPBxATcj1v/mj8vXet1nNjHG0tqoTtJJx1A2pIJOrUfjl4h8A+jXJ2Og==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr3144426ljw.217.1639015937136; 
 Wed, 08 Dec 2021 18:12:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXtbHy8Cyg+6tRAm842nb/vJ73lgpw102Pjv5lFmKNXXWGIvKX2qFahpjpjLZYMuOvd2hcvsZAGKOrXszvaCU=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr3144417ljw.217.1639015936967; 
 Wed, 08 Dec 2021 18:12:16 -0800 (PST)
MIME-Version: 1.0
References: <20211208103307.GA3778@kili>
In-Reply-To: <20211208103307.GA3778@kili>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 10:12:06 +0800
Message-ID: <CACGkMEusAkdm2io4nBvDSKuoKRt9A4FqKQFZhpk+pBsqOaJ_qQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v4] vduse: fix memory corruption in vduse_dev_ioctl()
To: Dan Carpenter <dan.carpenter@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org,
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

On Wed, Dec 8, 2021 at 6:33 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "config.offset" comes from the user.  There needs to a check to
> prevent it being out of bounds.  The "config.offset" and
> "dev->config_size" variables are both type u32.  So if the offset if
> out of bounds then the "dev->config_size - config.offset" subtraction
> results in a very high u32 value.  The out of bounds offset can result
> in memory corruption.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: fix reversed if statement
> v3: fix vhost_vdpa_config_validate() as pointed out by Yongji Xie.
> v4: split the vhost_vdpa_config_validate() change into a separate path

Acked-by: Jason Wang <jasowang@redhat.com>

>
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
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
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
