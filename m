Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D86AC4332F
	for <virtualization@archiver.kernel.org>; Thu, 24 Nov 2022 06:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC369610B7;
	Thu, 24 Nov 2022 06:34:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC369610B7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yz0K96x1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k8g9RO1kn3fi; Thu, 24 Nov 2022 06:34:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5BAB760AB2;
	Thu, 24 Nov 2022 06:34:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BAB760AB2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C8D9C0032;
	Thu, 24 Nov 2022 06:34:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A7C9C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 06:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 40DA5419CE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 06:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40DA5419CE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yz0K96x1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wGRD6HNk7dyr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 06:34:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11B77419CB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11B77419CB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 06:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669271673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XW4QocPZ/IX7iF7xzjKQbsxjhbLSPlgpn0gsT7pmGR8=;
 b=Yz0K96x1qoZd7MjSpqJDp01XhG/A/c2EEuL5pIFjpGFVmRjoRdJcK6OBTtmWdh7HtH+irQ
 jgeyL52usV7CmX8YYWHC5H+3AxoJZAs4tQHkFvSpaW9Yn4TKAuvGDtlph6Oc8RXwNif+U5
 wiBbhKKWIdrEdl06FutPEqEyYzXOLXo=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-82-7YgYTMUMNfqyf36AO4AolQ-1; Thu, 24 Nov 2022 01:34:30 -0500
X-MC-Unique: 7YgYTMUMNfqyf36AO4AolQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-14355480b19so328543fac.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 22:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XW4QocPZ/IX7iF7xzjKQbsxjhbLSPlgpn0gsT7pmGR8=;
 b=SbnFGpSLSQpxYSnoflXdglXSWLyzk8SP8VFQ3lHQjxN0X/YF3PZA30EcqoxQiedcvi
 tWklmccwaq4G+Dqm5LPHq4ir5lfOddHpB5ObJZRjlR+2ltMJ+OBhRKEK9kpFhQQtot9S
 4fwSCFnpjE23nKOtRqRbb4hJQm9UX2SXyeF1pi+JOLtw6UahhU9jhf+qwRtiUhQvWt6h
 Eidu0SROpMhlThJzBgftNQmIlQTZSdcsg8b3JUJJxe5qF8bkInHG+XQCYIQapQLL2xg0
 mWqtAk2qdeq1nCAXHbrJCH/eYbY3vVz45sjIMx+nLei4CAIUF4Wh03jmV/O1cHuzrPPu
 h0+w==
X-Gm-Message-State: ANoB5pnqMZEs+NWK99tIL509n/WdKNFYTuxtY9t2pXeGqNHH4d+0QO4f
 zJzx4jC6iII/ZDCE2xul+ZV2mkKpn3vMstSaZGFR8oLloPb9t94nzzGzCabQ+e7bMPW/dLfwHGx
 wSpVGz8XQpoSFeiWtCFOqS/wAgMmCwiyqFJcz7IKQyoms2OnDhYa2eYhE9A==
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id
 e5-20020a4ab145000000b0049f449a5f6cmr5553711ooo.93.1669271669792; 
 Wed, 23 Nov 2022 22:34:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7IyosG5Zgp1L1z/dEd/7W1lJHYNVRxsPXQn0yG8lUKOd7B4LRcDGirgFhy/2cx3irMqDkKK2cq6cTryykNnxQ=
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id
 e5-20020a4ab145000000b0049f449a5f6cmr5553705ooo.93.1669271669534; Wed, 23 Nov
 2022 22:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20221124062309.2081720-1-lulu@redhat.com>
In-Reply-To: <20221124062309.2081720-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 24 Nov 2022 14:34:18 +0800
Message-ID: <CACGkMEupFLwNFvGkU_vgDmhzY9K=b0KFC4BkWGVfO3s+GEWaKQ@mail.gmail.com>
Subject: Re: [PATCH] vhost_vdpa: fix the crash in unmap a large memory
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Thu, Nov 24, 2022 at 2:23 PM Cindy Lu <lulu@redhat.com> wrote:
>
> While testing in vIOMMU, sometimes guest will unmap very large memory,
> which will cause the crash.

Would you mind to post the calltrace?

> To fix this,Move the iommu_unmap to
> vhost_vdpa_pa_unmap/vhost_vdpa_va_unmap and only unmap the memory
> that saved in iotlb.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Let's add a fixes tag which I believe should be the first commit that
introduces vhost-vDPA. And let's cc stable as well.

> ---
>  drivers/vhost/vdpa.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 166044642fd5..c392979702cf 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -692,6 +692,8 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v,
>         struct vhost_iotlb_map *map;
>         struct page *page;
>         unsigned long pfn, pinned;
> +       struct vdpa_device *vdpa = v->vdpa;
> +       const struct vdpa_config_ops *ops = vdpa->config;
>
>         while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
>                 pinned = PFN_DOWN(map->size);
> @@ -703,6 +705,8 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v,
>                         unpin_user_page(page);
>                 }
>                 atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
> +               if ((ops->dma_map == NULL) && (ops->set_map == NULL))
> +                       iommu_unmap(v->domain, map->start, map->size);
>                 vhost_iotlb_map_free(iotlb, map);
>         }
>  }
> @@ -713,11 +717,15 @@ static void vhost_vdpa_va_unmap(struct vhost_vdpa *v,
>  {
>         struct vhost_iotlb_map *map;
>         struct vdpa_map_file *map_file;
> +       struct vdpa_device *vdpa = v->vdpa;
> +       const struct vdpa_config_ops *ops = vdpa->config;
>
>         while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
>                 map_file = (struct vdpa_map_file *)map->opaque;
>                 fput(map_file->file);
>                 kfree(map_file);
> +               if ((ops->dma_map == NULL) && (ops->set_map == NULL))
> +                       iommu_unmap(v->domain, map->start, map->size);

I wonder if it's better to move at least dma_map() here.

Thanks

>                 vhost_iotlb_map_free(iotlb, map);
>         }
>  }
> @@ -805,8 +813,6 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
>         } else if (ops->set_map) {
>                 if (!v->in_batch)
>                         ops->set_map(vdpa, asid, iotlb);
> -       } else {
> -               iommu_unmap(v->domain, iova, size);
>         }
>
>         /* If we are in the middle of batch processing, delay the free
> --
> 2.34.3
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
