Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADF4C00140
	for <virtualization@archiver.kernel.org>; Tue,  2 Aug 2022 07:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 831DA400C7;
	Tue,  2 Aug 2022 07:08:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 831DA400C7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PVZXhmNT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aeEPkVpc7idN; Tue,  2 Aug 2022 07:08:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9581940062;
	Tue,  2 Aug 2022 07:08:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9581940062
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CE2EC0032;
	Tue,  2 Aug 2022 07:08:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30751C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 07:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0442D60A75
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 07:08:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0442D60A75
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PVZXhmNT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fi82Fg1UBCOg
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 07:08:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D3716079E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D3716079E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Aug 2022 07:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659424117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lk5fZhTJlKNzqEKorGVmO33xROpi/F0xbp6DLCxyEPg=;
 b=PVZXhmNT6ANEWQFU9Ahu46lcyohaon3MjBxV6NMHCOyHpryXv70iO0XcXfGZ1uQHZ/WCkl
 wWNVmG7iGpEijEbzs3/pwjIZqeI38fcnSOCdU1ZKBktGr9mxlPNVa7NjT1x1j0M1ER8Xmu
 6454XJDh8/bWRx+wFLDGoouF5BHIpaE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-KomzQZjGMH-cnzTLgDnnMw-1; Tue, 02 Aug 2022 03:08:36 -0400
X-MC-Unique: KomzQZjGMH-cnzTLgDnnMw-1
Received: by mail-lf1-f72.google.com with SMTP id
 f21-20020a056512229500b0048af0b6da1dso1973594lfu.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Aug 2022 00:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lk5fZhTJlKNzqEKorGVmO33xROpi/F0xbp6DLCxyEPg=;
 b=YTSoCUtwNThDiZI+Q3aUWbQU6WbvJtsgYdnfhKT0mX5ZNjc3lItEKGAazaL+3goIwJ
 sXOfaf61W8w7jVd/yahH3iGOO4hNdWBEnlVK+J9VJ4ehEQineHjxZV30nsUgPYzBMtPE
 Xd6rOUcnPBmhDH1ly3KNykEGt2pD9HO1XArBsu3250Z6M0Df/v57DD7StO9SLtaC3cxg
 TYKt/FmLSltlqrFAakUzfkUK2vX7t7SxRUnFFOAar3bbhVcPsDC0wwz58sPGVjy6lEzQ
 ooqzg4er7UbKA7gdjxe9V55h2z1V4SicLbLKAefSxc960Dst8LrIz1zNrBb2hnqU63c6
 yHZA==
X-Gm-Message-State: AJIora+4Se1DlamgM5OGwIJc5Y2/9YrCol3Kt8KIGeTfrR61eehzlf/L
 OSCXxH0ANDvNRLSuR7/Zg/xVepluoQxQGSloAn2JujwSu3seUOqOU41OP07ziHCjgqnAkB7eXGv
 sT/KEDUZGW+gpW0vrVgLcVn3Kpai2A1iCHz4eWWh2dxYWecRwUoqCwJH6+Q==
X-Received: by 2002:a19:ac09:0:b0:48a:d1b5:1791 with SMTP id
 g9-20020a19ac09000000b0048ad1b51791mr7113380lfc.397.1659424114679; 
 Tue, 02 Aug 2022 00:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t9tTifp1Bws/2DsfyiDeWIMo2y0L+F8JtPh25awuoqWTlf2NQjl6jxIlIjDgYpJJ5HisW4TjmUWlXN3MNNdv0=
X-Received: by 2002:a19:ac09:0:b0:48a:d1b5:1791 with SMTP id
 g9-20020a19ac09000000b0048ad1b51791mr7113371lfc.397.1659424114457; Tue, 02
 Aug 2022 00:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220728032000.127-1-xieyongji@bytedance.com>
 <20220728032000.127-6-xieyongji@bytedance.com>
 <CACGkMEuN0zqyLQ6vD7MvjAhtJVvmMhsn_T4b5ww0vviwq5hBrg@mail.gmail.com>
 <CACycT3uYFWvmdJ1MzQZv=L7N0WzEiFvx5wJX+OwM1ew5Z0w0jw@mail.gmail.com>
 <CACGkMEtru8qaebnTXVu94oCV21JovkjshxYxdyzeSf=FTN0=xA@mail.gmail.com>
 <CACycT3swFhETEOPNNmLbSFaYUZEJYUkPXrddQ=w0TALE=D40Lw@mail.gmail.com>
 <CACGkMEsGt4=2c20xfi-4ZYfnn9NYHQ=CQm8TrP7HSYiwwDCWag@mail.gmail.com>
 <CACycT3vJcJp6dr6XFg=v_EUv05SZRpCzWOEPnXfoLDedBufSnQ@mail.gmail.com>
In-Reply-To: <CACycT3vJcJp6dr6XFg=v_EUv05SZRpCzWOEPnXfoLDedBufSnQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 2 Aug 2022 15:08:22 +0800
Message-ID: <CACGkMEtTnwG2y4RT6E7tzkWh0rm2xJJEgV8cvjWkqt3th-4DUA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] vduse: Support querying information of IOVA regions
To: Yongji Xie <xieyongji@bytedance.com>
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

On Fri, Jul 29, 2022 at 11:17 AM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Thu, Jul 28, 2022 at 5:02 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jul 28, 2022 at 4:27 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Thu, Jul 28, 2022 at 2:45 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, Jul 28, 2022 at 2:36 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > On Thu, Jul 28, 2022 at 1:58 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 28, 2022 at 11:20 AM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > > > >
> > > > > > > This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> > > > > > > support querying some information of IOVA regions.
> > > > > > >
> > > > > > > Now it can be used to query whether the IOVA region
> > > > > > > supports userspace memory registration.
> > > > > > >
> > > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
> > > > > > >  include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
> > > > > > >  2 files changed, 63 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > index eedff0a3885a..e820c37dcba8 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -1228,6 +1228,45 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > > > > > >                                            umem.size);
> > > > > > >                 break;
> > > > > > >         }
> > > > > > > +       case VDUSE_IOTLB_GET_INFO: {
> > > > > > > +               struct vduse_iova_info info;
> > > > > > > +               struct vhost_iotlb_map *map;
> > > > > > > +               struct vduse_iova_domain *domain = dev->domain;
> > > > > > > +
> > > > > > > +               ret = -EFAULT;
> > > > > > > +               if (copy_from_user(&info, argp, sizeof(info)))
> > > > > > > +                       break;
> > > > > > > +
> > > > > > > +               ret = -EINVAL;
> > > > > > > +               if (info.start > info.last)
> > > > > > > +                       break;
> > > > > > > +
> > > > > > > +               if (!is_mem_zero((const char *)info.reserved,
> > > > > > > +                                sizeof(info.reserved)))
> > > > > > > +                       break;
> > > > > > > +
> > > > > > > +               spin_lock(&domain->iotlb_lock);
> > > > > > > +               map = vhost_iotlb_itree_first(domain->iotlb,
> > > > > > > +                                             info.start, info.last);
> > > > > > > +               if (map) {
> > > > > > > +                       info.start = map->start;
> > > > > > > +                       info.last = map->last;
> > > > > > > +                       info.capability = 0;
> > > > > > > +                       if (domain->bounce_map && map->start >= 0 &&
> > > > > > > +                           map->last < domain->bounce_size)
> > > > > > > +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
> > > > > > > +               }
> > > > > > > +               spin_unlock(&domain->iotlb_lock);
> > > > > > > +               if (!map)
> > > > > > > +                       break;
> > > > > > > +
> > > > > > > +               ret = -EFAULT;
> > > > > > > +               if (copy_to_user(argp, &info, sizeof(info)))
> > > > > > > +                       break;
> > > > > > > +
> > > > > > > +               ret = 0;
> > > > > > > +               break;
> > > > > > > +       }
> > > > > > >         default:
> > > > > > >                 ret = -ENOIOCTLCMD;
> > > > > > >                 break;
> > > > > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > > > > > index 9885e0571f09..11bd48c72c6c 100644
> > > > > > > --- a/include/uapi/linux/vduse.h
> > > > > > > +++ b/include/uapi/linux/vduse.h
> > > > > > > @@ -233,6 +233,30 @@ struct vduse_iova_umem {
> > > > > > >  /* De-register the userspace memory. Caller should set iova and size field. */
> > > > > > >  #define VDUSE_IOTLB_DEREG_UMEM _IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
> > > > > > >
> > > > > > > +/**
> > > > > > > + * struct vduse_iova_info - information of one IOVA region
> > > > > > > + * @start: start of the IOVA region
> > > > > > > + * @last: last of the IOVA region
> > > > > > > + * @capability: capability of the IOVA regsion
> > > > > > > + * @reserved: for future use, needs to be initialized to zero
> > > > > > > + *
> > > > > > > + * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> > > > > > > + * one IOVA region.
> > > > > > > + */
> > > > > > > +struct vduse_iova_info {
> > > > > > > +       __u64 start;
> > > > > > > +       __u64 last;
> > > > > > > +#define VDUSE_IOVA_CAP_UMEM (1 << 0)
> > > > > > > +       __u64 capability;
> > > > > > > +       __u64 reserved[3];
> > > > > > > +};
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Find the first IOVA region that overlaps with the range [start, last]
> > > > > >
> > > > > > So the code is actually find the IOVA region that is the super range
> > > > > > of [start, last] instead of overlap:
> > > > > >
> > > > >
> > > > > This is achieved by vhost_iotlb_itree_first(). And can't the super
> > > > > range of [start,last] be considered overlapping?
> > > >
> > > > Ok, but what I want to ask is, under which condition can we hit the
> > > > following case
> > > >
> > > > map->last >= domain->bounce_size ?
> > > >
> > >
> > > I think we would not hit this case currently.
> >
> > I wonder if it's worthwhile to have a WARN or just remove this check.
> >
>
> I think we can't remove the check since not only the bounce region
> will match the condition: map->start >= 0.
>
> Or changing to map->start == 0 && map->last == domain->bounce_size - 1 ?

This looks like an assumption that there should be only one single map
for bound buffer.

It should be fine.

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
