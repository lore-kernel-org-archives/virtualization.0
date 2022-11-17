Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAF1C4332F
	for <virtualization@archiver.kernel.org>; Thu, 17 Nov 2022 05:26:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9954B418D9;
	Thu, 17 Nov 2022 05:26:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9954B418D9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iUOpAJFN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pG70kqv5Z7Xs; Thu, 17 Nov 2022 05:26:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E76C74189E;
	Thu, 17 Nov 2022 05:26:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E76C74189E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA819C0033;
	Thu, 17 Nov 2022 05:26:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61030C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 05:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3565A8203C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 05:26:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3565A8203C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iUOpAJFN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bhiQGIjoYNUE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 05:26:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 803E68203A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 803E68203A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 05:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668662804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2aEsMuwb7hoVqQiyeKpbbKR7yeg504eUz03mBSa84AQ=;
 b=iUOpAJFN2wLSExUuqPRLKU476BtqKZ18ih8cXwB9QH0l0ZcLiHaX4GCNGKvEgaww8w3+mK
 KvDWoyFcL6AUuv491xcLdTz+7qklWhNXBFPmp0/VQn8RKWy+J5WFwFubSV6VsqpDKlmpnb
 mWaURdDAcezXHBofSMuvGnQQlIGSA8g=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-248-TJtoSvVzP2G23kEKF6DFFg-1; Thu, 17 Nov 2022 00:26:42 -0500
X-MC-Unique: TJtoSvVzP2G23kEKF6DFFg-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-13b88262940so359507fac.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 21:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2aEsMuwb7hoVqQiyeKpbbKR7yeg504eUz03mBSa84AQ=;
 b=Gx3KgrHFdJQg5LJcMLWJDNEffiIjKzSC79FqJhozdfLLJABuBsa0B0FKNrKTOZ28xC
 NWBb+BrH1ufPLXW8jUZY57BzcjHCoAsk0/wPO12kgYDsKmQ91ymzNDaXa1zbJvWBCEUc
 S8JCWpyMXCDH9ILw6Vi4ziZPlVoLk5P6/X6OCC+7nVHI+eQGsHrGbEwXC6nnfigdX9Na
 utIBTdNqMIGl7x7Txgrk7eI1K0qEgXXkz4ZFyvKs3/fjntGOJxY/nXvaIj0373C0ILQW
 kYHVItim9tOgvm7QBU3IRUxlb4EbBrQd2U8Ab3C2uBUzyoQWa+2scsanbO0sltwVZ+HG
 2G5A==
X-Gm-Message-State: ANoB5pkmqLmA1ie05wqiPOG0Hq7kevygA4TPyisHmaHXUuEy3KvYI1tV
 dALwwTz+8ZREVJ4IENqGwyZpS5xhhA653T9h3fpr1DnCKI5E9XXIuFm3GYoS4je0hYv0vTMSRGA
 9PPX/qNw5VTj0Ql/3zbowANkUwQmQV8Se5SVhSP17tf6Q/mSJSX80gfUgKg==
X-Received: by 2002:a05:6808:220b:b0:359:f5eb:82ec with SMTP id
 bd11-20020a056808220b00b00359f5eb82ecmr399480oib.280.1668662802082; 
 Wed, 16 Nov 2022 21:26:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf68e54VJ3O3P29AE2aqbo4f5fPMtnTZxdf0tZdJLRfrLfooHH0vDobITaXd8RIEmGxxZog6Utjvq5yWtZyKrpk=
X-Received: by 2002:a05:6808:220b:b0:359:f5eb:82ec with SMTP id
 bd11-20020a056808220b00b00359f5eb82ecmr399476oib.280.1668662801872; Wed, 16
 Nov 2022 21:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20221114070233.248-1-xieyongji@bytedance.com>
 <20221114070233.248-7-xieyongji@bytedance.com>
In-Reply-To: <20221114070233.248-7-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Nov 2022 13:26:30 +0800
Message-ID: <CACGkMEu2t1Y=z4tw439tT7SYBdgcyTP7CRKdZGLASHTc-4gHiw@mail.gmail.com>
Subject: Re: [PATCH 6/6] vduse: Support specifying bounce buffer size via sysfs
To: Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

On Mon, Nov 14, 2022 at 3:16 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Add sysfs interface to support specifying bounce
> buffer size in virtio-vdpa case. This is a performance
> tuning parameter for high throughput workloads.

I wonder what's the reason for not having this in VDUSE_CREATE_DEV?

Thanks

>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 45 +++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 428615093c28..3f97e2d7f7d7 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -37,8 +37,11 @@
>  #define DRV_LICENSE  "GPL v2"
>
>  #define VDUSE_DEV_MAX (1U << MINORBITS)
> +#define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> +#define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
>  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> -#define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
> +/* 128 MB reserved for virtqueue creation */
> +#define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
>  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
>
>  struct vduse_virtqueue {
> @@ -1687,8 +1690,48 @@ static ssize_t msg_timeout_store(struct device *device,
>
>  static DEVICE_ATTR_RW(msg_timeout);
>
> +static ssize_t bounce_size_show(struct device *device,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct vduse_dev *dev = dev_get_drvdata(device);
> +
> +       return sysfs_emit(buf, "%u\n", dev->bounce_size);
> +}
> +
> +static ssize_t bounce_size_store(struct device *device,
> +                                struct device_attribute *attr,
> +                                const char *buf, size_t count)
> +{
> +       struct vduse_dev *dev = dev_get_drvdata(device);
> +       unsigned int bounce_size;
> +       int ret;
> +
> +       ret = -EPERM;
> +       mutex_lock(&dev->domain_lock);
> +       if (dev->domain)
> +               goto unlock;
> +
> +       ret = kstrtouint(buf, 10, &bounce_size);
> +       if (ret < 0)
> +               goto unlock;
> +
> +       ret = -EINVAL;
> +       if (bounce_size > VDUSE_MAX_BOUNCE_SIZE ||
> +           bounce_size < VDUSE_MIN_BOUNCE_SIZE)
> +               goto unlock;
> +
> +       dev->bounce_size = bounce_size;
> +       ret = count;
> +unlock:
> +       mutex_unlock(&dev->domain_lock);
> +       return ret;
> +}
> +
> +static DEVICE_ATTR_RW(bounce_size);
> +
>  static struct attribute *vduse_dev_attrs[] = {
>         &dev_attr_msg_timeout.attr,
> +       &dev_attr_bounce_size.attr,
>         NULL
>  };
>
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
