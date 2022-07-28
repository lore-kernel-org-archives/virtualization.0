Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5824BC04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 05:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD04682CA5;
	Thu, 28 Jul 2022 05:58:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD04682CA5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZZV1ReAL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OB4bVkjvqRyy; Thu, 28 Jul 2022 05:58:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3F95B82BC4;
	Thu, 28 Jul 2022 05:58:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F95B82BC4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9DC8C0033;
	Thu, 28 Jul 2022 05:58:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7059BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 05:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 402BB82C18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 05:58:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 402BB82C18
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UAq81-Eyr5Z9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 05:58:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7727182BC4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7727182BC4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 05:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658987882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3VTL7R2ln0lyo49p8Nu+NwDtwT2nCSo+7KDiGxqDzOU=;
 b=ZZV1ReALQqg/b3wC9mmIYsQRH0EpKOm1QfAH0xdFCKNUVLhz6ChkxS+Zrgd+fSBWELdtci
 knCsW6my8BQFBLOxFgXOT9E93Q11K+1b9V8K7BCab0eWHT3fY53LwX0vKnoQvtAeWFPG/Q
 XDmZ7EPipaLrdTrSd+rhQOJT1OWCBJs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-oM6GUI_ZM5-IM8yR97QGbw-1; Thu, 28 Jul 2022 01:58:01 -0400
X-MC-Unique: oM6GUI_ZM5-IM8yR97QGbw-1
Received: by mail-lf1-f71.google.com with SMTP id
 dt17-20020a0565122a9100b0048a878a2a56so336986lfb.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 22:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3VTL7R2ln0lyo49p8Nu+NwDtwT2nCSo+7KDiGxqDzOU=;
 b=gNJtzRd2QReI84W7HaM9Lqb3lDY4MLSsVqnemYVI+GgkgPbgPIxJvOHA7P/TKHuPev
 j1PkMuVZSnWSe7uqN5etXgbu6NFsteP23xw52qOAon3VRJCtN8SiFIcVW5G7thx/2Ezg
 pDHYTd9uI7T1Eqm7VSyTSd705lDDS3Wq6aVMCsH0wJV8pTyWQ8tdw3qePgTU/vJJNbKL
 /N5azIYdIHUKNPq8lFomhSJFTSrkq8C1F511oyLGwnamnsA720HOs8/5U3Y+8bHPawOu
 Jvc71ar0pAZJeUuvaDsc7DPw+Kz05EQTdLq0gFlScsndwNQgsBpvCSOjiYrr+Zc5kYH6
 E+uA==
X-Gm-Message-State: AJIora81aeVN/mGw5eepR8one2Efg9x9CAKSiYIVFhDVUfGq4B5I3rgD
 Uj054gD4N9OwNtcN7PPOHaXhmIJoemxBGVIt1tz3q5Q9iR7rYYA9P4pg1eG7ovS3JIKPzBpY9T/
 4FkNmFbv1vWWkcs1qJzSnjOmF9cnup8IXiTESlQ7n4hXS50nyYXA712kgQQ==
X-Received: by 2002:a19:9145:0:b0:48a:7ee4:5eac with SMTP id
 y5-20020a199145000000b0048a7ee45eacmr9242774lfj.641.1658987879889; 
 Wed, 27 Jul 2022 22:57:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1syhth8cn2l/zatLNxI80Gp6fqmQbo5DpZln8RVAxOxO6ONGRzdSAPie4hIXA0VboNjtxI4vm/4CuyRBeSsTDQ=
X-Received: by 2002:a19:9145:0:b0:48a:7ee4:5eac with SMTP id
 y5-20020a199145000000b0048a7ee45eacmr9242761lfj.641.1658987879410; Wed, 27
 Jul 2022 22:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220728032000.127-1-xieyongji@bytedance.com>
 <20220728032000.127-6-xieyongji@bytedance.com>
In-Reply-To: <20220728032000.127-6-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Jul 2022 13:57:48 +0800
Message-ID: <CACGkMEuN0zqyLQ6vD7MvjAhtJVvmMhsn_T4b5ww0vviwq5hBrg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] vduse: Support querying information of IOVA regions
To: Xie Yongji <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
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

On Thu, Jul 28, 2022 at 11:20 AM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> support querying some information of IOVA regions.
>
> Now it can be used to query whether the IOVA region
> supports userspace memory registration.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index eedff0a3885a..e820c37dcba8 100644
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
> +                       if (domain->bounce_map && map->start >= 0 &&
> +                           map->last < domain->bounce_size)
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

So the code is actually find the IOVA region that is the super range
of [start, last] instead of overlap:


> +                       if (domain->bounce_map && map->start >= 0 &&
> +                           map->last < domain->bounce_size)
> +                               info.capability |= VDUSE_IOVA_CAP_UMEM;

Which part is wrong?

Thanks

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
