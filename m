Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41326C04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 06:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9DEC60EF4;
	Thu, 28 Jul 2022 06:45:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9DEC60EF4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cv6bD+vh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2PWArOU2K0Bd; Thu, 28 Jul 2022 06:45:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 311AB60EB1;
	Thu, 28 Jul 2022 06:45:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 311AB60EB1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0175EC0035;
	Thu, 28 Jul 2022 06:45:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59357C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 336FD60EF1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:45:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 336FD60EF1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W1r-Dy2ONKsW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:45:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5026460EB1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5026460EB1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658990752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dySmMr3XE6Y2DZ+UTqy4HFm8XEDkjL730Qh4ZxkIk0E=;
 b=cv6bD+vhk+0UuPQDv2bbyeLxSyd1jmJ+nUekCwY1D6oQdgA9ZobTDI4bWY52f9WMpPTdON
 ejC+rAgQuKlEGr1q6XCKdL1wmEmj2pDx0e9xOvZQlYsNstgg3aNMGj8k8850JP2N5sPcNF
 0jtKx/OTnq13EntzWiLBz3Bx+JzTMYM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-v4EwPtRcOiWGllZc-n2S1w-1; Thu, 28 Jul 2022 02:45:50 -0400
X-MC-Unique: v4EwPtRcOiWGllZc-n2S1w-1
Received: by mail-lf1-f72.google.com with SMTP id
 z1-20020a0565120c0100b0048ab2910b13so364670lfu.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 23:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dySmMr3XE6Y2DZ+UTqy4HFm8XEDkjL730Qh4ZxkIk0E=;
 b=VEPwZwDQDWkXbzvtA89Z8cjeAKpFb+dl+t+n7+gZgU833rbUiLKgBxJKubxoMZut9b
 K50qAlpcdZ0ZHCvRlHTggfWrzN43r89YvXUSMLY4hf6yQ5kQgfQ0VaB8X38uc+vG/2UR
 lmtPZFJAgMRFE3v2m+JTzybHz8nzvMNIFkCdWwQmkjR2XMQofiTX9HM8MOZAK0SEbYxK
 F8J45DAifd0afI5igJSASlDslR/Bs7Mn12evvCGgXg26xw2suFw3KFFGGdbnUYcV+PKy
 X3PrW5tdJXOME2T2dvjJnsVrcgEFbBNvBwNXIvx8yIVi/PIyZrqwDoIwTsbWGFtrQuvf
 74Kw==
X-Gm-Message-State: AJIora8XisnkTE2rPWRf0shVgUQXjwObvQ9u/+/GFS17lXf4mDdnfiVo
 Gx2uiETdVzHfZxMHGxJJnAMMMSett4Y3VVKglmT1YRgvNQ8YmTuhbp54JddIdQPDkr3lAMdYAl2
 FYrhFrIQUDW4aZaAGST/qc1zDOe4GEpCt3afxRgXB3yhfEs69RR3VJn+cPA==
X-Received: by 2002:a2e:9e1a:0:b0:25d:f9db:92f7 with SMTP id
 e26-20020a2e9e1a000000b0025df9db92f7mr8230369ljk.243.1658990749385; 
 Wed, 27 Jul 2022 23:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tH1Q7TY/ZV4QNhhL/XnK7bne/Y8apL0+dHhqk+6H2/FqgTpGY6xlOKC0cW/jXWoJCJgfKOTSmXfYi9SMA6pEs=
X-Received: by 2002:a2e:9e1a:0:b0:25d:f9db:92f7 with SMTP id
 e26-20020a2e9e1a000000b0025df9db92f7mr8230357ljk.243.1658990749155; Wed, 27
 Jul 2022 23:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220728032000.127-1-xieyongji@bytedance.com>
 <20220728032000.127-6-xieyongji@bytedance.com>
 <CACGkMEuN0zqyLQ6vD7MvjAhtJVvmMhsn_T4b5ww0vviwq5hBrg@mail.gmail.com>
 <CACycT3uYFWvmdJ1MzQZv=L7N0WzEiFvx5wJX+OwM1ew5Z0w0jw@mail.gmail.com>
In-Reply-To: <CACycT3uYFWvmdJ1MzQZv=L7N0WzEiFvx5wJX+OwM1ew5Z0w0jw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Jul 2022 14:45:38 +0800
Message-ID: <CACGkMEtru8qaebnTXVu94oCV21JovkjshxYxdyzeSf=FTN0=xA@mail.gmail.com>
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

On Thu, Jul 28, 2022 at 2:36 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Thu, Jul 28, 2022 at 1:58 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jul 28, 2022 at 11:20 AM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > This introduces a new ioctl: VDUSE_IOTLB_GET_INFO to
> > > support querying some information of IOVA regions.
> > >
> > > Now it can be used to query whether the IOVA region
> > > supports userspace memory registration.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 39 ++++++++++++++++++++++++++++++
> > >  include/uapi/linux/vduse.h         | 24 ++++++++++++++++++
> > >  2 files changed, 63 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index eedff0a3885a..e820c37dcba8 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -1228,6 +1228,45 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > >                                            umem.size);
> > >                 break;
> > >         }
> > > +       case VDUSE_IOTLB_GET_INFO: {
> > > +               struct vduse_iova_info info;
> > > +               struct vhost_iotlb_map *map;
> > > +               struct vduse_iova_domain *domain = dev->domain;
> > > +
> > > +               ret = -EFAULT;
> > > +               if (copy_from_user(&info, argp, sizeof(info)))
> > > +                       break;
> > > +
> > > +               ret = -EINVAL;
> > > +               if (info.start > info.last)
> > > +                       break;
> > > +
> > > +               if (!is_mem_zero((const char *)info.reserved,
> > > +                                sizeof(info.reserved)))
> > > +                       break;
> > > +
> > > +               spin_lock(&domain->iotlb_lock);
> > > +               map = vhost_iotlb_itree_first(domain->iotlb,
> > > +                                             info.start, info.last);
> > > +               if (map) {
> > > +                       info.start = map->start;
> > > +                       info.last = map->last;
> > > +                       info.capability = 0;
> > > +                       if (domain->bounce_map && map->start >= 0 &&
> > > +                           map->last < domain->bounce_size)
> > > +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
> > > +               }
> > > +               spin_unlock(&domain->iotlb_lock);
> > > +               if (!map)
> > > +                       break;
> > > +
> > > +               ret = -EFAULT;
> > > +               if (copy_to_user(argp, &info, sizeof(info)))
> > > +                       break;
> > > +
> > > +               ret = 0;
> > > +               break;
> > > +       }
> > >         default:
> > >                 ret = -ENOIOCTLCMD;
> > >                 break;
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index 9885e0571f09..11bd48c72c6c 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -233,6 +233,30 @@ struct vduse_iova_umem {
> > >  /* De-register the userspace memory. Caller should set iova and size field. */
> > >  #define VDUSE_IOTLB_DEREG_UMEM _IOW(VDUSE_BASE, 0x19, struct vduse_iova_umem)
> > >
> > > +/**
> > > + * struct vduse_iova_info - information of one IOVA region
> > > + * @start: start of the IOVA region
> > > + * @last: last of the IOVA region
> > > + * @capability: capability of the IOVA regsion
> > > + * @reserved: for future use, needs to be initialized to zero
> > > + *
> > > + * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> > > + * one IOVA region.
> > > + */
> > > +struct vduse_iova_info {
> > > +       __u64 start;
> > > +       __u64 last;
> > > +#define VDUSE_IOVA_CAP_UMEM (1 << 0)
> > > +       __u64 capability;
> > > +       __u64 reserved[3];
> > > +};
> > > +
> > > +/*
> > > + * Find the first IOVA region that overlaps with the range [start, last]
> >
> > So the code is actually find the IOVA region that is the super range
> > of [start, last] instead of overlap:
> >
>
> This is achieved by vhost_iotlb_itree_first(). And can't the super
> range of [start,last] be considered overlapping?

Ok, but what I want to ask is, under which condition can we hit the
following case

map->last >= domain->bounce_size ?

Thanks

>
> >
> > > +                       if (domain->bounce_map && map->start >= 0 &&
> > > +                           map->last < domain->bounce_size)
> > > +                               info.capability |= VDUSE_IOVA_CAP_UMEM;
> >
> > Which part is wrong?
> >
>
> We will first call vhost_iotlb_itree_first() which will find the first
> IOVA region that overlaps with the range [start, last]. Then the flag
> will only be set if the IOVA region is within the bounce range.
>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
