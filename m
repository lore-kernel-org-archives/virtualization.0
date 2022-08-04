Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A29C00144
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 04:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7697E60B72;
	Thu,  4 Aug 2022 04:53:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7697E60B72
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OoRCKScc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6TlLPxUIwTww; Thu,  4 Aug 2022 04:53:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E1C8460B73;
	Thu,  4 Aug 2022 04:53:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1C8460B73
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A10DCC0032;
	Thu,  4 Aug 2022 04:53:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66B44C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 04:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D9E940338
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 04:53:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D9E940338
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OoRCKScc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FYZ_qh72O260
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 04:53:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F7FE400F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F7FE400F8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 04:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659588802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OLmka0NC3UlfBuYckPNASUIU1cERM9leULZwcp5E6j4=;
 b=OoRCKSccQaf5Rr/bScBSZNNgKNx3tDgSD2F7NI606Mg6wz7I0UPbDQvaQn5em264z6JhC7
 ZLf+6AIJwKKoiec2DZLTMnPpE+4R8XzjaWve+uLEsIvhDrg8ZAKLST+XiSSulxUjOcG5e6
 e9xpw3Wj/yJ+MuDr4ZSRKqDhdUwvhyE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-55Hi1WYrP0Kr5zd1TFZs5g-1; Thu, 04 Aug 2022 00:53:21 -0400
X-MC-Unique: 55Hi1WYrP0Kr5zd1TFZs5g-1
Received: by mail-lf1-f69.google.com with SMTP id
 k25-20020a195619000000b00489e6a6527eso5552710lfb.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Aug 2022 21:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OLmka0NC3UlfBuYckPNASUIU1cERM9leULZwcp5E6j4=;
 b=N+gWQvEmm3Uig42GaQ+G28Xkulagi1sWIx9J1xVs7a3OGUJDcWAZx58AwArktoOUKS
 K8PgnXrKdf10FTO0eVYUcwFTZv+BEMUOM+EM9oY01HN3DBa1jOReXdOFhXVa2y/cWxI1
 +95MTNyLrQsOyovRqatmtStohOT/l1C0zTQQu5V8aDRTYiLHMR0upAOjiCFapkMEX+r/
 uyhXZe4FWO7V1IE/YzmXUhHU6kk0tOEvl0t89xMsZ5SPD6T/hi61Irw1QkaoYlaCJEj7
 X2xxvu9Hw4fEYic19BEFrMTC5Ez7Q/AlbZD3A0oziRjbo5pWgdMBwB95CxN7RwnLq4vf
 xViQ==
X-Gm-Message-State: ACgBeo22NupX4witUH6HXFGQyVJKpqhXNiis2DujD7Y68jQiTkrAP8/D
 U6bk9ZD08U5+KCaZVIUi/eUEGzad+yPx199E4H4i1HdmUSxVAmQK/9pbFVO8nEdn1hwzqH0Jxh8
 L9oQxbaHu5LvExzmvF842Ob8y/5xyZ12Sm3lHUtl65B6xjLTKFquw54zwAg==
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr82489lfa.124.1659588800240; 
 Wed, 03 Aug 2022 21:53:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4E+uvfcwgkuiwuzZB+8RJjAjNJM0hEmaUlpNaRuyeUjSSQarpOIMjsof16sQtNs6Wj+6Y44uUEG5p2j1j0Q+g=
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr82481lfa.124.1659588800034; Wed, 03 Aug
 2022 21:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220803045523.23851-1-xieyongji@bytedance.com>
 <20220803045523.23851-6-xieyongji@bytedance.com>
In-Reply-To: <20220803045523.23851-6-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Aug 2022 12:53:09 +0800
Message-ID: <CACGkMEs4LxYh1K3O=ycu-r+AJjSmvrJpHZbw+i+SDM-w-pbm+A@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] vduse: Support querying information of IOVA regions
To: Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com
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

On Wed, Aug 3, 2022 at 12:56 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> support querying some information of IOVA regions.
>
> Now it can be used to query whether the IOVA region
> supports userspace memory registration.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index eedff0a3885a..41c0b29739f1 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1228,6 +1228,45 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                                            umem.size);
>                 break;
>         }
> +       case VDUSE_IOTLB_GET_INFO: {
> +               struct vduse_iova_info info;
> +               struct vhost_iotlb_map *map;
> +               struct vduse_iova_domain *domain = dev->domain;
> +
> +               ret = -EFAULT;
> +               if (copy_from_user(&info, argp, sizeof(info)))
> +                       break;
> +
> +               ret = -EINVAL;
> +               if (info.start > info.last)
> +                       break;
> +
> +               if (!is_mem_zero((const char *)info.reserved,
> +                                sizeof(info.reserved)))
> +                       break;
> +
> +               spin_lock(&domain->iotlb_lock);
> +               map = vhost_iotlb_itree_first(domain->iotlb,
> +                                             info.start, info.last);
> +               if (map) {
> +                       info.start = map->start;
> +                       info.last = map->last;
> +                       info.capability = 0;
> +                       if (domain->bounce_map && map->start == 0 &&
> +                           map->last == domain->bounce_size - 1)
> +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
> +               }
> +               spin_unlock(&domain->iotlb_lock);
> +               if (!map)
> +                       break;
> +
> +               ret = -EFAULT;
> +               if (copy_to_user(argp, &info, sizeof(info)))
> +                       break;
> +
> +               ret = 0;
> +               break;
> +       }
>         default:
>                 ret = -ENOIOCTLCMD;
>                 break;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 9885e0571f09..11bd48c72c6c 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -233,6 +233,30 @@ struct vduse_iova_umem {
>  /* De-register the userspace memory. Caller should set iova and size field. */
>  #define VDUSE_IOTLB_DEREG_UMEM _IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
>
> +/**
> + * struct vduse_iova_info - information of one IOVA region
> + * @start: start of the IOVA region
> + * @last: last of the IOVA region
> + * @capability: capability of the IOVA regsion
> + * @reserved: for future use, needs to be initialized to zero
> + *
> + * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> + * one IOVA region.
> + */
> +struct vduse_iova_info {
> +       __u64 start;
> +       __u64 last;
> +#define VDUSE_IOVA_CAP_UMEM (1 << 0)
> +       __u64 capability;
> +       __u64 reserved[3];
> +};
> +
> +/*
> + * Find the first IOVA region that overlaps with the range [start, last]
> + * and return some information on it. Caller should set start and last fields.
> + */
> +#define VDUSE_IOTLB_GET_INFO   _IOWR(VDUSE_BASE, 0x1a, struct vduse_iova_info)
> +
>  /* The control messages definition for read(2)/write(2) on /dev/vduse/$NAME */
>
>  /**
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
