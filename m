Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B978CC433EF
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 02:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 612146FB76;
	Wed, 12 Jan 2022 02:32:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mZUMJDDeHdch; Wed, 12 Jan 2022 02:32:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F159D6FB71;
	Wed, 12 Jan 2022 02:32:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFB9DC002F;
	Wed, 12 Jan 2022 02:32:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4952CC001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F3C440937
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:32:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3fEc7Ft8Jq8F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:32:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4789540924
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641954753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TDRQOQGXgkIHiJO2AyKEniNSDBr94TNpRwIlvxr1KG8=;
 b=gvCYXFwgkExRtk4a4isNYyFcfCVTzlCUvXSykdZrPi28vwtjOGSPSwWUEfCBoD7Kb0RSId
 vfKdiUJy1DLkIsY//ZHJGuXiIWMODHLxdMh/bWTOTggNfLlROpuZkworY8mst1xor/Ywgm
 9bAo17M8mw5H87aDsDVTxVHOWWf2TgM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-q9HBtewTNR-tiWbt-xTziw-1; Tue, 11 Jan 2022 21:32:32 -0500
X-MC-Unique: q9HBtewTNR-tiWbt-xTziw-1
Received: by mail-lf1-f69.google.com with SMTP id
 d25-20020a194f19000000b0042b469bd916so617055lfb.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 18:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TDRQOQGXgkIHiJO2AyKEniNSDBr94TNpRwIlvxr1KG8=;
 b=VQIMJgR5pfuwdUNWjhTyhB8PC9NueMeQn9p7l1PXPNf4CIwuyeocvY8m3nfyVmIpmZ
 sKqY1rbtVXTJp9CLdMhTPL7fc5FzYdy9Yp8nAmzTQS+qVUR+1SfSRZqAdjdfm7cMKWgb
 VJeFHkmO0xrRAihCJYScX/DuY0X4BA+8W0KkkryU+mX/VMai4Ad2MXcGEYIGTq53oJdg
 8PgR4qima6U56CRWGRt/Mwf+vMn42w7V1xyS1qKf23sbLz8zQxJ4LFlo5/43jmww9LQD
 4JJANV9TgSrgQmetvUFKUZ5h2TutvMtiSd23TpdqCV8ImvKzi0peZ/IhcDSv9g1nMMVH
 TT+A==
X-Gm-Message-State: AOAM533XrMjCKHd8he6o8ctKat5fvZLQcIn56bZPo9Xjj9vIiUpkrSsC
 8lvzoYP3m0uOoavrWtqc/l3ucQEIJat0VpWS6ZmRze4e4ZtrUHxcAD3ilry5+of8FYS9ktgzZSI
 FQDcHHhHNg2xLGvSAIkOcU1pLksoGSlayN3vUrZGB2a9O8iqE+qhz5325cA==
X-Received: by 2002:a05:6512:214f:: with SMTP id
 s15mr5344379lfr.199.1641954750639; 
 Tue, 11 Jan 2022 18:32:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygZze6hgTsOkRBmTgMcF1L3IiSxU5B3aXF8CWlvWSZPINrtqUyzzrqz1Y/TGBhrVhyJj0RNA73FdAy2ieujBU=
X-Received: by 2002:a05:6512:214f:: with SMTP id
 s15mr5344365lfr.199.1641954750457; 
 Tue, 11 Jan 2022 18:32:30 -0800 (PST)
MIME-Version: 1.0
References: <20220111183400.38418-1-elic@nvidia.com>
 <20220111183400.38418-2-elic@nvidia.com>
In-Reply-To: <20220111183400.38418-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jan 2022 10:32:19 +0800
Message-ID: <CACGkMEvARfUX5F7i8_wfs+PNUzN9XtptfRr0jBLSJ34ddYNLzA@mail.gmail.com>
Subject: Re: [PATCH 1/4] vdpa: Avoid taking cf_mutex lock on get status
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Wed, Jan 12, 2022 at 2:34 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Avoid the wrapper holding cf_mutex since it is not protecting anything.
> To avoid confusion and unnecessary overhead incurred by it, remove.
>
> Fixes: f489f27bc0ab ("vdpa: Sync calls set/get config/status with cf_mutex")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c  | 11 -----------
>  drivers/vhost/vdpa.c |  5 +++--
>  include/linux/vdpa.h |  1 -
>  3 files changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 4380367d00b5..9846c9de4bfa 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -21,17 +21,6 @@ static LIST_HEAD(mdev_head);
>  static DEFINE_MUTEX(vdpa_dev_mutex);
>  static DEFINE_IDA(vdpa_index_ida);
>
> -u8 vdpa_get_status(struct vdpa_device *vdev)
> -{
> -       u8 status;
> -
> -       mutex_lock(&vdev->cf_mutex);
> -       status = vdev->config->get_status(vdev);
> -       mutex_unlock(&vdev->cf_mutex);
> -       return status;
> -}
> -EXPORT_SYMBOL(vdpa_get_status);
> -
>  void vdpa_set_status(struct vdpa_device *vdev, u8 status)
>  {
>         mutex_lock(&vdev->cf_mutex);
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6e7edaf2472b..0ed6cbadb52d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -142,9 +142,10 @@ static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
>  static long vhost_vdpa_get_status(struct vhost_vdpa *v, u8 __user *statusp)
>  {
>         struct vdpa_device *vdpa = v->vdpa;
> +       const struct vdpa_config_ops *ops = vdpa->config;
>         u8 status;
>
> -       status = vdpa_get_status(vdpa);
> +       status = ops->get_status(vdpa);
>
>         if (copy_to_user(statusp, &status, sizeof(status)))
>                 return -EFAULT;
> @@ -163,7 +164,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>         if (copy_from_user(&status, statusp, sizeof(status)))
>                 return -EFAULT;
>
> -       status_old = vdpa_get_status(vdpa);
> +       status_old = ops->get_status(vdpa);
>
>         /*
>          * Userspace shouldn't remove status bits unless reset the
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index a6047fd6cf12..2de442ececae 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -421,7 +421,6 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>                      void *buf, unsigned int len);
>  void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
>                      const void *buf, unsigned int length);
> -u8 vdpa_get_status(struct vdpa_device *vdev);
>  void vdpa_set_status(struct vdpa_device *vdev, u8 status);
>
>  /**
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
