Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9660FC4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 04:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20E7682136;
	Fri, 16 Dec 2022 04:02:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20E7682136
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJQDS0rJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1v06Z0f1ldPp; Fri, 16 Dec 2022 04:02:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9C68F82078;
	Fri, 16 Dec 2022 04:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C68F82078
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5179AC0033;
	Fri, 16 Dec 2022 04:02:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9F14C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 04:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F4D18207E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 04:02:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F4D18207E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PtTMrpqBAv5h
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 04:02:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB18E82078
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB18E82078
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 04:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671163371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bUg7DCrpGftfeECU7OexNPwbmvxXhls2VyJtY/quv18=;
 b=WJQDS0rJwV7FlNbKEZuoxpFaZ50wJH9LI2o5GM3npjjKmYlEYepC6JpOrnm+8YHL8NUR5y
 BgFX3XUu4Rc4MwPgXnkV82xGfj/i+y9d09BeCu2KhfWBgw64g71oX6v6CaETmvsjP+zrsB
 r87944Zsgm8Z5NVE/GOu1LAhf3uoRXM=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-179-ctJ2dQ23NS2D03bPAs-d-w-1; Thu, 15 Dec 2022 23:02:50 -0500
X-MC-Unique: ctJ2dQ23NS2D03bPAs-d-w-1
Received: by mail-oi1-f197.google.com with SMTP id
 x15-20020a05680801cf00b0035e5fc05887so366627oic.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 20:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bUg7DCrpGftfeECU7OexNPwbmvxXhls2VyJtY/quv18=;
 b=aQgfqSGe0H39vqbZ+w5x1QND3Z4b2MemKHzT9VDEeGJEN1/6agpzay11jWja4pCXem
 IR/10TY6OsZ3whAZNRRXwaBFHyv84Ru7TeMMWBDZRWBNE+Sr4kWwZZEoa2sPmZpBm7T7
 QL2vcuqFVU+zRFRZA/KlDRW6i1R9phTWVEdgBDwh6pOhVWbXJlinzYZIC5wxOnH6fcC+
 EP30ACoKuB2NAH2eP7Mhc4j0Xk8rzL+LfV8kLZG1Hu0DowaaYKSOJKRrcML0ERmKamzE
 BiBfxwTAQr15FkrDojf7jprn0y+aKpwd0/furrQ3JPg1CplaNq7SpWbBY/7uo5Uxnz+K
 IuvA==
X-Gm-Message-State: ANoB5pktv8pyd1UCWqq5RWke+O0QeGMEo7SWc7mdB9I0oor0YNHsaksv
 m21Y36u5PhBtnwZq369D08ZJF7EASmeuCoPCWyYNtL7Frf2HoWiud1ePvwIpl3TkMyI4UUNFIFN
 ScgCOy6oAbGC7UgjhJUSl9dVI/NoMmL4AX0ToN2NZq0aUPpTlX52vYmZYPQ==
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr321607oab.35.1671163369629; 
 Thu, 15 Dec 2022 20:02:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5ZbwN5SVcsG0tViudVD/KQAyGrKDv3T5sIawOHS5yWS6RLlOfxyro6WW/aLtbbno06tb2xhhPHHBslw0F0D2M=
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr321604oab.35.1671163369422; Thu, 15
 Dec 2022 20:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-6-xieyongji@bytedance.com>
In-Reply-To: <20221205084127.535-6-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Dec 2022 12:02:38 +0800
Message-ID: <CACGkMEvkTJn7Hm5u=79nDNHQG_gakS3Cbvi=JpO38ndjHy_fog@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] vduse: Introduce bound workqueue for irq
 injection
To: Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, hch@lst.de, mst@redhat.com
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

On Mon, Dec 5, 2022 at 4:44 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This introduces a bound workqueue to support running
> irq callback in a specified cpu.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 37809bfcb7ef..d126f3e32a20 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -57,6 +57,7 @@ struct vduse_virtqueue {
>         struct vdpa_callback cb;
>         struct work_struct inject;
>         struct work_struct kick;
> +       int irq_effective_cpu;

I wonder why it's a cpu number instead of a cpumask. The latter seems
more flexible, e.g when using NUMA.

>  };
>
>  struct vduse_dev;
> @@ -128,6 +129,7 @@ static struct class *vduse_class;
>  static struct cdev vduse_ctrl_cdev;
>  static struct cdev vduse_cdev;
>  static struct workqueue_struct *vduse_irq_wq;
> +static struct workqueue_struct *vduse_irq_bound_wq;
>
>  static u32 allowed_device_id[] = {
>         VIRTIO_ID_BLOCK,
> @@ -917,7 +919,8 @@ static void vduse_vq_irq_inject(struct work_struct *work)
>  }
>
>  static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> -                                   struct work_struct *irq_work)
> +                                   struct work_struct *irq_work,
> +                                   int irq_effective_cpu)
>  {
>         int ret = -EINVAL;
>
> @@ -926,7 +929,11 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
>                 goto unlock;
>
>         ret = 0;
> -       queue_work(vduse_irq_wq, irq_work);
> +       if (irq_effective_cpu == -1)

Is it better to have a macro for this magic number?

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
