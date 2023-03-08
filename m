Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CDBC64EC4
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 14:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F3F260FE4;
	Wed,  8 Mar 2023 14:14:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F3F260FE4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VNGqq9Mm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b0vhu5M_v68i; Wed,  8 Mar 2023 14:14:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8248160ABE;
	Wed,  8 Mar 2023 14:14:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8248160ABE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F6AAC0071;
	Wed,  8 Mar 2023 14:14:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95BAFC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61651417E5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:14:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61651417E5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VNGqq9Mm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AwLSDPb89x7e
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:14:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CAC2F41800
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CAC2F41800
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678284846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SuGUGzyvDO4F2NPZ8Oo8JDIwnK95EVehqB8FahWEx0U=;
 b=VNGqq9Mm0Hi5tNjU3Qo6X96647mnxkJGBPXOaeBi9rHcHVKoxMEikqG75IO0N5Fmz5gcy7
 IzErqgYO8JZUrC93r+ybTOVmz8yL5w3d2omfy9gMu97guF8PBViJElUuq7+1hjHVcNHkT/
 cXvVvKdpGgCBYeJxhCig3PtO2AKxPdY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-BV0KlRINPCq1_ie2GgI9Vw-1; Wed, 08 Mar 2023 09:14:05 -0500
X-MC-Unique: BV0KlRINPCq1_ie2GgI9Vw-1
Received: by mail-wm1-f71.google.com with SMTP id
 l20-20020a05600c1d1400b003e10d3e1c23so1014353wms.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Mar 2023 06:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678284843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SuGUGzyvDO4F2NPZ8Oo8JDIwnK95EVehqB8FahWEx0U=;
 b=AM8+WjFPuiI0NEfSjZCk7LAdngAjRFhp4ewl7JeU1evGv/DZcPT4wmL+Vbz716yh8k
 +qPYH7O2E5I9Q1voac1xguuvjjwJiHp8w62IZ4szuX6tNX9aNfRLOKoiNdDqyCXgkEqC
 R93fH6OvH83BBrIPtmqV4Co2kRlNrzUeZao64MvQgDlHNsOTAovXPabJWV5+Nx8L/CNl
 9o9OcqIaW+GuKFUBX4uDxnEM3AlRa9c+MmKh1OZTIlZB72NbG1ILeyQq3HRBQ6zGnJT2
 5z+gGFOTg60DxJgCcvYPp1SlShIoiElddUgKeIMI4mBLUWv2xYXi91fE+n+d14YZ7n1g
 JadQ==
X-Gm-Message-State: AO0yUKVoOwIUvdFyeRLwnPqnDeOjyT+zGtR1rUzStsbyREjG3szJ9VyO
 NQpXY3LZwjaSI5ZsFpRz3hSht0vBEAbs3Mi8mg1HU3idyYcyQlJLjh2UHMD1vz7n6nGE+YbOkoh
 DJYf8QBim5oPwpVWXheCThvGsQlHIGr4UXBGmxD3HHw==
X-Received: by 2002:a05:600c:45cd:b0:3eb:2de9:8aed with SMTP id
 s13-20020a05600c45cd00b003eb2de98aedmr15762639wmo.41.1678284843039; 
 Wed, 08 Mar 2023 06:14:03 -0800 (PST)
X-Google-Smtp-Source: AK7set/IFUVT8lR7Y5aPU4ZB2Jc/mQaAJ1lCkwgFQF8E0cR05zcXNC4oR91tloxCKnlBe8EVRgT8Dg==
X-Received: by 2002:a05:600c:45cd:b0:3eb:2de9:8aed with SMTP id
 s13-20020a05600c45cd00b003eb2de98aedmr15762615wmo.41.1678284842671; 
 Wed, 08 Mar 2023 06:14:02 -0800 (PST)
Received: from redhat.com ([2.52.138.216]) by smtp.gmail.com with ESMTPSA id
 p13-20020a056000018d00b002c5691f13eesm15163894wrx.50.2023.03.08.06.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Mar 2023 06:14:02 -0800 (PST)
Date: Wed, 8 Mar 2023 09:13:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
Message-ID: <20230308091321-mutt-send-email-mst@kernel.org>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
 <m2ttywzzxd.fsf@oracle.com>
 <4e8d1e89-9b32-8dcd-acd1-6957f13fcbb9@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <4e8d1e89-9b32-8dcd-acd1-6957f13fcbb9@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "feng.liu.kernel@gmail.com" <feng.liu.kernel@gmail.com>,
 Jiri Pirko <jiri@nvidia.com>, Bodong Wang <bodong@nvidia.com>,
 Gavin Li <gavinl@nvidia.com>
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

On Tue, Mar 07, 2023 at 09:17:55PM +0000, Feng Liu wrote:
> On 2023-03-07 04:14, David Edmondson wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
> > writes:
> > 
> >> Add const to make the read-only pointer parameters clear, similar to
> >> many existing functions.
> > 
> > In many of the modified functions the local variable that is a cast of
> > the argument could also be const. Is there a reason not to do both at
> > the same time?
> > 
> 
> Hi,David
> 
> In order to prevent the content of a pointer parameter from being 
> modified and increase the readability of the function, it is recommended 
> to add the 'const' keyword to the parameter. This is not necessary for 
> local variables and non-pointer parameters, as they are only stored on 
> the stack and do not affect the original value or structure member 
> passed into the function. Therefore, in this case, the 'const' keyword 
> is only added to pointer parameters.

This makes no sense to me. If ytou cast away the const then it is
pointless.

> 
> >> Signed-off-by: Feng Liu <feliu@nvidia.com>
> >> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >> Reviewed-by: Parav Pandit <parav@nvidia.com>
> >> Reviewed-by: Gavin Li <gavinl@nvidia.com>
> >> Reviewed-by: Bodong Wang <bodong@nvidia.com>
> >> ---
> >>   drivers/virtio/virtio_ring.c | 25 ++++++++++++-------------
> >>   include/linux/virtio.h       | 12 ++++++------
> >>   2 files changed, 18 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> >> index 806cc44eae64..8010fd1d2047 100644
> >> --- a/drivers/virtio/virtio_ring.c
> >> +++ b/drivers/virtio/virtio_ring.c
> >> @@ -233,7 +233,7 @@ static void vring_free(struct virtqueue *_vq);
> >>
> >>   #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
> >>
> >> -static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
> >> +static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> >>                                          unsigned int total_sg)
> >>   {
> >>        /*
> >> @@ -269,7 +269,7 @@ static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
> >>    * unconditionally on data path.
> >>    */
> >>
> >> -static bool vring_use_dma_api(struct virtio_device *vdev)
> >> +static bool vring_use_dma_api(const struct virtio_device *vdev)
> >>   {
> >>        if (!virtio_has_dma_quirk(vdev))
> >>                return true;
> >> @@ -289,7 +289,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >>        return false;
> >>   }
> >>
> >> -size_t virtio_max_dma_size(struct virtio_device *vdev)
> >> +size_t virtio_max_dma_size(const struct virtio_device *vdev)
> >>   {
> >>        size_t max_segment_size = SIZE_MAX;
> >>
> >> @@ -423,7 +423,7 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
> >>    */
> >>
> >>   static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
> >> -                                        struct vring_desc *desc)
> >> +                                        const struct vring_desc *desc)
> >>   {
> >>        u16 flags;
> >>
> >> @@ -1183,7 +1183,7 @@ static u16 packed_last_used(u16 last_used_idx)
> >>   }
> >>
> >>   static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> >> -                                  struct vring_desc_extra *extra)
> >> +                                  const struct vring_desc_extra *extra)
> >>   {
> >>        u16 flags;
> >>
> >> @@ -1206,7 +1206,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> >>   }
> >>
> >>   static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> >> -                                struct vring_packed_desc *desc)
> >> +                                 const struct vring_packed_desc *desc)
> >>   {
> >>        u16 flags;
> >>
> >> @@ -2786,7 +2786,7 @@ EXPORT_SYMBOL_GPL(vring_transport_features);
> >>    * Returns the size of the vring.  This is mainly used for boasting to
> >>    * userspace.  Unlike other operations, this need not be serialized.
> >>    */
> >> -unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
> >> +unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
> >>   {
> >>
> >>        struct vring_virtqueue *vq = to_vvq(_vq);
> >> @@ -2819,7 +2819,7 @@ void __virtqueue_unbreak(struct virtqueue *_vq)
> >>   }
> >>   EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
> >>
> >> -bool virtqueue_is_broken(struct virtqueue *_vq)
> >> +bool virtqueue_is_broken(const struct virtqueue *_vq)
> >>   {
> >>        struct vring_virtqueue *vq = to_vvq(_vq);
> >>
> >> @@ -2827,8 +2827,7 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
> >>   }
> >>   EXPORT_SYMBOL_GPL(virtqueue_is_broken);
> >>
> >> -/*
> >> - * This should prevent the device from being used, allowing drivers to
> >> +/ This should prevent the device from being used, allowing drivers to
> >>    * recover.  You may need to grab appropriate locks to flush.
> >>    */
> >>   void virtio_break_device(struct virtio_device *dev)
> >> @@ -2881,7 +2880,7 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
> >>   }
> >>   EXPORT_SYMBOL_GPL(virtqueue_get_desc_addr);
> >>
> >> -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
> >> +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *_vq)
> >>   {
> >>        struct vring_virtqueue *vq = to_vvq(_vq);
> >>
> >> @@ -2895,7 +2894,7 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
> >>   }
> >>   EXPORT_SYMBOL_GPL(virtqueue_get_avail_addr);
> >>
> >> -dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
> >> +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *_vq)
> >>   {
> >>        struct vring_virtqueue *vq = to_vvq(_vq);
> >>
> >> @@ -2910,7 +2909,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
> >>   EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
> >>
> >>   /* Only available for split ring */
> >> -const struct vring *virtqueue_get_vring(struct virtqueue *vq)
> >> +const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
> >>   {
> >>        return &to_vvq(vq)->split.vring;
> >>   }
> >> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> >> index 2b472514c49b..36a79374e735 100644
> >> --- a/include/linux/virtio.h
> >> +++ b/include/linux/virtio.h
> >> @@ -84,14 +84,14 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
> >>
> >>   void *virtqueue_detach_unused_buf(struct virtqueue *vq);
> >>
> >> -unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
> >> +unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
> >>
> >> -bool virtqueue_is_broken(struct virtqueue *vq);
> >> +bool virtqueue_is_broken(const struct virtqueue *vq);
> >>
> >> -const struct vring *virtqueue_get_vring(struct virtqueue *vq);
> >> -dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
> >> -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
> >> -dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
> >> +const struct vring *virtqueue_get_vring(const struct virtqueue *vq);
> >> +dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *vq);
> >> +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
> >> +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
> >>
> >>   int virtqueue_resize(struct virtqueue *vq, u32 num,
> >>                     void (*recycle)(struct virtqueue *vq, void *buf));
> >> --
> >> 2.34.1
> >>
> >> _______________________________________________
> >> Virtualization mailing list
> >> Virtualization@lists.linux-foundation.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.linuxfoundation.org%2Fmailman%2Flistinfo%2Fvirtualization&data=05%7C01%7Cfeliu%40nvidia.com%7C6265cc6ac03e484167ba08db1eec5428%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638137772595544505%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=74eHEHUMF89nTG6hrrdMpkl43DJWvC9xCjwqNOny%2FQE%3D&reserved=0
> > --
> > Woke up in my clothes again this morning, don't know exactly where I am.
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
