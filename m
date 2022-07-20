Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE682CCA482
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 09:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89AA860B30;
	Wed, 20 Jul 2022 09:15:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89AA860B30
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PFmxlj0B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CCZ44EX1q9Ba; Wed, 20 Jul 2022 09:15:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EAB1D60C01;
	Wed, 20 Jul 2022 09:15:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EAB1D60C01
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B17D8C0035;
	Wed, 20 Jul 2022 09:15:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B59FEC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 09:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8AF7C82681
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 09:15:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8AF7C82681
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PFmxlj0B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qXLUQF8uftBo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 09:15:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C17208267C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C17208267C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 09:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658308551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HUKMXc9f07k4+gnbLTE/RnwIyWTnBgFirv7Xpt5z1go=;
 b=PFmxlj0BGhslptbey/qPnFQTRK9GdNRRj95QWI4iO2gpsJYXmgRSQPZF3FiE3X/OHMBpb4
 bX5DYnXEYOSzbfZNNCEaMDzmQ7tlqhPrhv850IegDfGczcBfg3NLFrw+IzY0C3/Q5AhjOV
 RepxESt8hDBdE3zjpgC720u8i3PxnHk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-IS-4msj9MlyXyE-aD52xEQ-1; Wed, 20 Jul 2022 05:15:50 -0400
X-MC-Unique: IS-4msj9MlyXyE-aD52xEQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 k25-20020a195619000000b00489e6a6527eso6449902lfb.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 02:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HUKMXc9f07k4+gnbLTE/RnwIyWTnBgFirv7Xpt5z1go=;
 b=RaO5oQr0aWZ+rf1QF1N6PzDX1MqBbDyRoUBRgPddF3wTDjv8k2FupsA3te7RdtI9hu
 BfC6RwS6bJOk73yDP8d0aKkm9NL4axLKVf64rpRc2isA9moAce3V/grRuEHZdjfrG591
 f6iOcOCzbFEXrbQZtOsSgF2S+OSZg7ae3Q76bR0RNOpOwq1xZNgEtB58hLLs3oSIUxu0
 unTiYuwUHQl0+kRQWCU4OuhoJfZwl/EpUP2abc8NY0AYQme377p0X5jiNPVoD0x4BtEA
 zdvpSmmgCxZrAtsG/O8QYlpH10Pu9T+jj2t2ReUTjT4C/T1fURFPWZbCULpe2MMic2W6
 4L1g==
X-Gm-Message-State: AJIora8gY6xgFpn9lJuyup2kyZBVAA1ocfiILw9pkf0rx50XEo6LxKTp
 r0K2HCYh78f2/VOpr+X2K1rP6q0UwiLtEx0Y0wgjX4RIzeKrJe1RfNkdnYO0+s4uTXGkC/bq5lr
 CIE/BkyTwOOSs3D/roIjf+8TRSLKMb52h0X7DIZqGSMQGkCd5+hLLlAHdGg==
X-Received: by 2002:a2e:a9a6:0:b0:25d:601a:d3d8 with SMTP id
 x38-20020a2ea9a6000000b0025d601ad3d8mr16223616ljq.141.1658308548701; 
 Wed, 20 Jul 2022 02:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1symoo6IBmz/51GUPD/ME1iQ6e+R4xCZyOT9QTN8UBI0jSLGRhu9Br2wlQUp+NdSgKVe3ykxwoy05dNkTJEYSI=
X-Received: by 2002:a2e:a9a6:0:b0:25d:601a:d3d8 with SMTP id
 x38-20020a2ea9a6000000b0025d601ad3d8mr16223602ljq.141.1658308548487; Wed, 20
 Jul 2022 02:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220720044144.90-1-xieyongji@bytedance.com>
 <20220720044144.90-6-xieyongji@bytedance.com>
In-Reply-To: <20220720044144.90-6-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Jul 2022 17:15:36 +0800
Message-ID: <CACGkMEti0LLi8s7V_9oCvSgj=-nNAEHLipnnwtH0_RTF75-XrQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] vduse: Support querying information of IOVA regions
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

On Wed, Jul 20, 2022 at 12:42 PM Xie Yongji <xieyongji@bytedance.com> wrote:
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
>  include/uapi/linux/vduse.h         | 25 +++++++++++++++++++
>  2 files changed, 64 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index eedff0a3885a..cc4a9a700c24 100644
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

We don't check map->start and map->last in GET_FD, any reason for
those checks here?

> +                               info.capability |= VDUSE_IOVA_CAP_UMEM_SUPPORT;

Not a native speaker, but I think CAP is duplicated with SUPPORT.

Something like VDUSE_IOVA_CAP_UMEM might be better.

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
> index 9885e0571f09..720fb0b6d8ff 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -233,6 +233,31 @@ struct vduse_iova_umem {
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
> +#define VDUSE_IOVA_CAP_UMEM_SUPPORT (1 << 0)
> +       __u64 capability;
> +       __u64 reserved[3];
> +};
> +
> +/*
> + * Find the first IOVA region that overlaps with the range [start, last]
> + * and return some information on it. Caller should set start and last fields.
> + */
> +#define VDUSE_IOTLB_GET_INFO   _IOW(VDUSE_BASE, 0x1a, struct vduse_iova_info)

This should be _IOWR() ?

Thanks

> +
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
