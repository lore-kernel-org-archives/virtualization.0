Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6068AC19F29
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 09:02:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5DEA83DF5;
	Thu, 28 Jul 2022 09:02:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5DEA83DF5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a67Axq3K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRP-F5kJ967B; Thu, 28 Jul 2022 09:02:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E78282ED2;
	Thu, 28 Jul 2022 09:02:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E78282ED2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7F72C0035;
	Thu, 28 Jul 2022 09:02:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C6C2C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 09:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BEFE860F3D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 09:02:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEFE860F3D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a67Axq3K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8eTxik9D9Pnc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 09:02:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AD8360F30
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AD8360F30
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 09:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658998963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KzC7zxZBrSOXts7QAnv7lFC1B1g3+eSUwjPBNTC8QDM=;
 b=a67Axq3Kr6lEcnzrG6pxSaSjP3ALohR4Bv74O2XBzKIpACC5QXH0wIMH7UxP9eFsR4pNhA
 bIbZsF62mgdcZLb+xnuWyYc0VTkwzi1U/2na2yyI4IluptSlm3vkopW2nKdDwRB/yY0BFy
 2R0SgIeeBBA6kPYANilfym2LrcBDWz8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-K6N7f2HKNjqsl7t_2SU5UQ-1; Thu, 28 Jul 2022 05:02:42 -0400
X-MC-Unique: K6N7f2HKNjqsl7t_2SU5UQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 sa19-20020a1709076d1300b0072f703aef3aso429903ejc.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KzC7zxZBrSOXts7QAnv7lFC1B1g3+eSUwjPBNTC8QDM=;
 b=Ol6fFG3+MyskzPKDFhSIe6QGbaO/B4iuGNG+nryWIBCYy4/aXOMQsdueeArJySWGCW
 mGiFyZ19cbtvFKHEHGKoDFxKaNTHBaS1IvFHgslKTRFJkw2MaAyf7vEdHQEniNFjQo7V
 DLtJPcM694eBohl7s/mjHnm6bfb5DD85sOaX6eCjR19qD2O43PdtRVd7CfhF2jR4yGqB
 jxFAST/tJ9m4wNVvFJEPrqu2Cxi7WXnUNh1hGhBT7/KztxeYrDB/qgqxzqobnQocKqk9
 r/lyQVYxwvilIAC/UFyxbnk05CnbRXBSOGkH9TT/0Q1acecz74RREs1kJhiblWkNDSKS
 M+Hw==
X-Gm-Message-State: AJIora8VBY01/AuvFiKz985ul4f80OMllgxbMF5b9XADM5I6GDMjjCHh
 rqO31X3q9+Sw+SQ+/H++UkMvhpHaRKrUObdx9QUGeN4bt15WaYdpgchnEcC33DZ11wMYThyM8GJ
 QxcE/CyK/FcFOSD8SomnXMgdJ1tJKbfWnqpySWknzwu50k8L+gBYtHjNcFg==
X-Received: by 2002:a17:907:2cf6:b0:72b:9d9b:2404 with SMTP id
 hz22-20020a1709072cf600b0072b9d9b2404mr20022931ejc.171.1658998959964; 
 Thu, 28 Jul 2022 02:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tQIqsVpahFrnYCYZvp58S9uAUE4QDiEw5xrWFlR9EOhNei8yHZPwCsR7qCe+NUhl7lSU3iC4+jdb5+ANa8Z3E=
X-Received: by 2002:a17:907:2cf6:b0:72b:9d9b:2404 with SMTP id
 hz22-20020a1709072cf600b0072b9d9b2404mr20022919ejc.171.1658998959626; Thu, 28
 Jul 2022 02:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220728032000.127-1-xieyongji@bytedance.com>
 <20220728032000.127-6-xieyongji@bytedance.com>
 <CACGkMEuN0zqyLQ6vD7MvjAhtJVvmMhsn_T4b5ww0vviwq5hBrg@mail.gmail.com>
 <CACycT3uYFWvmdJ1MzQZv=L7N0WzEiFvx5wJX+OwM1ew5Z0w0jw@mail.gmail.com>
 <CACGkMEtru8qaebnTXVu94oCV21JovkjshxYxdyzeSf=FTN0=xA@mail.gmail.com>
 <CACycT3swFhETEOPNNmLbSFaYUZEJYUkPXrddQ=w0TALE=D40Lw@mail.gmail.com>
In-Reply-To: <CACycT3swFhETEOPNNmLbSFaYUZEJYUkPXrddQ=w0TALE=D40Lw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Jul 2022 17:02:28 +0800
Message-ID: <CACGkMEsGt4=2c20xfi-4ZYfnn9NYHQ=CQm8TrP7HSYiwwDCWag@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] vduse: Support querying information of IOVA regions
To: Yongji Xie <xieyongji@bytedance.com>
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

On Thu, Jul 28, 2022 at 4:27 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Thu, Jul 28, 2022 at 2:45 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jul 28, 2022 at 2:36 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Thu, Jul 28, 2022 at 1:58 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, Jul 28, 2022 at 11:20 AM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> > > > > support querying some information of IOVA regions.
> > > > >
> > > > > Now it can be used to query whether the IOVA region
> > > > > supports userspace memory registration.
> > > > >
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
> > > > >  include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
> > > > >  2 files changed, 63 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > index eedff0a3885a..e820c37dcba8 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -1228,6 +1228,45 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > > > >                                            umem.size);
> > > > >                 break;
> > > > >         }
> > > > > +       case VDUSE_IOTLB_GET_INFO: {
> > > > > +               struct vduse_iova_info info;
> > > > > +               struct vhost_iotlb_map *map;
> > > > > +               struct vduse_iova_domain *domain = dev->domain;
> > > > > +
> > > > > +               ret = -EFAULT;
> > > > > +               if (copy_from_user(&info, argp, sizeof(info)))
> > > > > +                       break;
> > > > > +
> > > > > +               ret = -EINVAL;
> > > > > +               if (info.start > info.last)
> > > > > +                       break;
> > > > > +
> > > > > +               if (!is_mem_zero((const char *)info.reserved,
> > > > > +                                sizeof(info.reserved)))
> > > > > +                       break;
> > > > > +
> > > > > +               spin_lock(&domain->iotlb_lock);
> > > > > +               map = vhost_iotlb_itree_first(domain->iotlb,
> > > > > +                                             info.start, info.last);
> > > > > +               if (map) {
> > > > > +                       info.start = map->start;
> > > > > +                       info.last = map->last;
> > > > > +                       info.capability = 0;
> > > > > +                       if (domain->bounce_map && map->start >= 0 &&
> > > > > +                           map->last < domain->bounce_size)
> > > > > +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
> > > > > +               }
> > > > > +               spin_unlock(&domain->iotlb_lock);
> > > > > +               if (!map)
> > > > > +                       break;
> > > > > +
> > > > > +               ret = -EFAULT;
> > > > > +               if (copy_to_user(argp, &info, sizeof(info)))
> > > > > +                       break;
> > > > > +
> > > > > +               ret = 0;
> > > > > +               break;
> > > > > +       }
> > > > >         default:
> > > > >                 ret = -ENOIOCTLCMD;
> > > > >                 break;
> > > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > > > index 9885e0571f09..11bd48c72c6c 100644
> > > > > --- a/include/uapi/linux/vduse.h
> > > > > +++ b/include/uapi/linux/vduse.h
> > > > > @@ -233,6 +233,30 @@ struct vduse_iova_umem {
> > > > >  /* De-register the userspace memory. Caller should set iova and size field. */
> > > > >  #define VDUSE_IOTLB_DEREG_UMEM _IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
> > > > >
> > > > > +/**
> > > > > + * struct vduse_iova_info - information of one IOVA region
> > > > > + * @start: start of the IOVA region
> > > > > + * @last: last of the IOVA region
> > > > > + * @capability: capability of the IOVA regsion
> > > > > + * @reserved: for future use, needs to be initialized to zero
> > > > > + *
> > > > > + * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> > > > > + * one IOVA region.
> > > > > + */
> > > > > +struct vduse_iova_info {
> > > > > +       __u64 start;
> > > > > +       __u64 last;
> > > > > +#define VDUSE_IOVA_CAP_UMEM (1 << 0)
> > > > > +       __u64 capability;
> > > > > +       __u64 reserved[3];
> > > > > +};
> > > > > +
> > > > > +/*
> > > > > + * Find the first IOVA region that overlaps with the range [start, last]
> > > >
> > > > So the code is actually find the IOVA region that is the super range
> > > > of [start, last] instead of overlap:
> > > >
> > >
> > > This is achieved by vhost_iotlb_itree_first(). And can't the super
> > > range of [start,last] be considered overlapping?
> >
> > Ok, but what I want to ask is, under which condition can we hit the
> > following case
> >
> > map->last >= domain->bounce_size ?
> >
>
> I think we would not hit this case currently.

I wonder if it's worthwhile to have a WARN or just remove this check.

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
