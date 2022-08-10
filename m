Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CCCC25B0C
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 01:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A44C3410C8;
	Wed, 10 Aug 2022 01:09:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A44C3410C8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H83D/R4P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VEKlxNiglJRm; Wed, 10 Aug 2022 01:09:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9BDCC408A8;
	Wed, 10 Aug 2022 01:09:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BDCC408A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A76AC0032;
	Wed, 10 Aug 2022 01:09:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46D06C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 01:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D64681762
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 01:09:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D64681762
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=H83D/R4P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id amr0_sWM1r1F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 01:09:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E9C88149A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E9C88149A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 01:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660093783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ealoktxzQvMvoaVETXyzPEIriQf2QjBNBkFv9OiTEac=;
 b=H83D/R4Ps96JqvuwZmmzZ3usu78C7Nh7z3WUXzp4O8k9eCDp5KYVC8hKcKxGyEO+97PQ97
 YRm+HQ61Roje/FKl253ELMDyXjdO3QYbmBVqzEc71ZVkic5guMe7d9FFt5A7B2LOvYiSwu
 U7H1+8UnUTioqX0g/NE3t/vCUzGvLJs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-161-tKNe_FtZNxebeOzlY4UVmg-1; Tue, 09 Aug 2022 21:09:42 -0400
X-MC-Unique: tKNe_FtZNxebeOzlY4UVmg-1
Received: by mail-lj1-f198.google.com with SMTP id
 e25-20020a2e9e19000000b0025ff52b3c72so1090350ljk.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 18:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=ealoktxzQvMvoaVETXyzPEIriQf2QjBNBkFv9OiTEac=;
 b=DfJAWlrZVpwcn0hfD6GgZRMdeyC+wuDLBAS68QGDFK6gXI7VdyZ6FTV24WP9e3yNQk
 DJSZH2oIEBmCcVK0+skRQLq7x/QXzCqe/EGcdzEtOJ3p5VnA+LBs/RoQmpnYMOMxyR1y
 xLYxTNisCYqJZRuxXYMcL91/FShwmTavXSTJDTNTvGcFSgclqqdBGcTkpW6Ni26Yc63o
 aqFS8am8W64t40eMjX10+2oYrDZZtxUASUjygbYlLhP8oYRUNxEKPrZjLogfK87kj550
 WECOEMPpo8H3YNnTNot3mtOlUc4uPx2OpfKDe+Hm6EveggtosClef+gZO+wYCLDrcqa4
 q7rQ==
X-Gm-Message-State: ACgBeo23G2QICpIXt2HEiG5iO4/1jD34cQ+8OwKOzkmwC3kT2eH+rmFo
 kkLEQTt5NMboAk4DKd4ITMwLkob/fmT+y9/Q7EtHalkUl2NutV4YNwT81Cy2US55ytNBSSGExyJ
 QaWzEB+MZjV6pULW3vKKKSkyLCOS7NFwGMxtkHnIqkTXrpwY0ho5/ehmkRA==
X-Received: by 2002:a05:6512:1594:b0:48d:25f2:a6d5 with SMTP id
 bp20-20020a056512159400b0048d25f2a6d5mr149951lfb.238.1660093780780; 
 Tue, 09 Aug 2022 18:09:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6ZXM7tanNj9gTDHG0dFEK/yhr44bnYG5GLApfvvrxcQrT6B6gKB1dcdR8U6qr4EzRa0V7N7TmAUNPXbfbfZu8=
X-Received: by 2002:a05:6512:1594:b0:48d:25f2:a6d5 with SMTP id
 bp20-20020a056512159400b0048d25f2a6d5mr149942lfb.238.1660093780576; Tue, 09
 Aug 2022 18:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220722115309.82746-1-lingshan.zhu@intel.com>
 <20220722115309.82746-6-lingshan.zhu@intel.com>
 <PH0PR12MB5481AC83A7C7B0320D6FB44CDC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809152457-mutt-send-email-mst@kernel.org>
 <42e6d45b-4fba-1c8e-1726-3f082dd7a629@oracle.com>
In-Reply-To: <42e6d45b-4fba-1c8e-1726-3f082dd7a629@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Aug 2022 09:09:29 +0800
Message-ID: <CACGkMEuSY=se+CnsiwH2BdaAv3Eu7L=-xJED-wSNiDwCP9RRXQ@mail.gmail.com>
Subject: Re: [PATCH V4 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

On Wed, Aug 10, 2022 at 8:54 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 8/9/2022 12:36 PM, Michael S. Tsirkin wrote:
> > On Fri, Jul 22, 2022 at 01:14:42PM +0000, Parav Pandit wrote:
> >>
> >>> From: Zhu Lingshan <lingshan.zhu@intel.com>
> >>> Sent: Friday, July 22, 2022 7:53 AM
> >>>
> >>> If VIRTIO_NET_F_MQ == 0, the virtio device should have one queue pair, so
> >>> when userspace querying queue pair numbers, it should return mq=1 than
> >>> zero.
> >>>
> >>> Function vdpa_dev_net_config_fill() fills the attributions of the vDPA
> >>> devices, so that it should call vdpa_dev_net_mq_config_fill() so the
> >>> parameter in vdpa_dev_net_mq_config_fill() should be feature_device than
> >>> feature_driver for the vDPA devices themselves
> >>>
> >>> Before this change, when MQ = 0, iproute2 output:
> >>> $vdpa dev config show vdpa0
> >>> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 0
> >>> mtu 1500
> >>>
> >>> After applying this commit, when MQ = 0, iproute2 output:
> >>> $vdpa dev config show vdpa0
> >>> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 1
> >>> mtu 1500
> >>>
> >> No. We do not want to diverge returning values of config space for fields which are not present as discussed in previous versions.
> >> Please drop this patch.
> >> Nack on this patch.
> > Wrt this patch as far as I'm concerned you guys are bikeshedding.
> >
> > Parav generally don't send nacks please they are not helpful.
> >
> > Zhu Lingshan please always address comments in some way.  E.g. refer to
> > them in the commit log explaining the motivation and the alternatives.
> > I know you don't agree with Parav but ghosting isn't nice.
> >
> > I still feel what we should have done is
> > not return a value, as long as we do return it we might
> > as well return something reasonable, not 0.
> Maybe I missed something but I don't get this, when VIRTIO_NET_F_MQ is
> not negotiated, the VDPA_ATTR_DEV_NET_CFG_MAX_VQP attribute is simply
> not there, but userspace (iproute) mistakenly puts a zero value there.
> This is a pattern every tool in iproute follows consistently by large. I
> don't get why kernel has to return something without seeing a very
> convincing use case?
>
> Not to mention spec doesn't give us explicit definition for when the
> field in config space becomes valid and/or the default value at first
> sights as part of feature negotiation. If we want to stick to the model
> Lingshan proposed, maybe fix the spec first then get back on the details?

So spec said

"
The following driver-read-only field, max_virtqueue_pairs only exists
if VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS is set.
"

My understanding is that the field is always valid if the device
offers the feature.

Btw, even if the spec is unclear, it would be very hard to "fix" it
without introducing a new feature bit, it means we still need to deal
with device without the new feature.

Thanks

>
> -Siwei
>
> >
> > And I like it that this fixes sparse warning actually:
> > max_virtqueue_pairs it tagged as __virtio, not __le.
> >
> > However, I am worried there is another bug here:
> > this is checking driver features. But really max vqs
> > should not depend on that, it depends on device
> > features, no?
> >
> >
> >
> >>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>> ---
> >>>   drivers/vdpa/vdpa.c | 7 ++++---
> >>>   1 file changed, 4 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> >>> d76b22b2f7ae..846dd37f3549 100644
> >>> --- a/drivers/vdpa/vdpa.c
> >>> +++ b/drivers/vdpa/vdpa.c
> >>> @@ -806,9 +806,10 @@ static int vdpa_dev_net_mq_config_fill(struct
> >>> vdpa_device *vdev,
> >>>     u16 val_u16;
> >>>
> >>>     if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0)
> >>> -           return 0;
> >>> +           val_u16 = 1;
> >>> +   else
> >>> +           val_u16 = __virtio16_to_cpu(true, config-
> >>>> max_virtqueue_pairs);
> >>> -   val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
> >>>     return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> >>> val_u16);  }
> >>>
> >>> @@ -842,7 +843,7 @@ static int vdpa_dev_net_config_fill(struct
> >>> vdpa_device *vdev, struct sk_buff *ms
> >>>                           VDPA_ATTR_PAD))
> >>>             return -EMSGSIZE;
> >>>
> >>> -   return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver,
> >>> &config);
> >>> +   return vdpa_dev_net_mq_config_fill(vdev, msg, features_device,
> >>> +&config);
> >>>   }
> >>>
> >>>   static int
> >>> --
> >>> 2.31.1
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
