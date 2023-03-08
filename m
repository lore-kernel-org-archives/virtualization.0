Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0430C64EC4
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 16:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A15060E4F;
	Wed,  8 Mar 2023 16:26:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A15060E4F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IIC5EPuu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U2sX-wurmRJ3; Wed,  8 Mar 2023 16:26:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4A12660E30;
	Wed,  8 Mar 2023 16:26:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A12660E30
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20588C0071;
	Wed,  8 Mar 2023 16:26:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6387BC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2BE56403E0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:26:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BE56403E0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IIC5EPuu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mAJZJa462eLW
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:26:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F24A40153
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F24A40153
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678292769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UK5jb4ASu/4BfLycJr0qWUvwx3283sTK8MJFA7rzAO8=;
 b=IIC5EPuucIuHhtGq59jDEsipBTI1DIOl354SB+lQVnYB3pUZqfDEfMJUryr1UIouZCtu1W
 97y5GlnE2T4jBhtx3yMHV6fokvGISAQ41GGvxACsj2TJ7AL5XCyqJGaij3XGPKj2KZQoMX
 fWyDehqa9YvwcpmGFng7LvXcySyhKJE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-CUOvLF1nPuiXS2BRpVwZUA-1; Wed, 08 Mar 2023 11:26:08 -0500
X-MC-Unique: CUOvLF1nPuiXS2BRpVwZUA-1
Received: by mail-ed1-f71.google.com with SMTP id
 c1-20020a0564021f8100b004acbe232c03so24248573edc.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Mar 2023 08:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678292764;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UK5jb4ASu/4BfLycJr0qWUvwx3283sTK8MJFA7rzAO8=;
 b=0DgeumraGrL7vTS2Zi9OIhMl4WLDHRuVcWe5Nn2dvCr+Go91AlDVR0U/edixgxRoWO
 vBFSxBoKxe1+IudDpTCfgHGlPAJPa0xrC3oxoRHoe3ZoXcWcmMeD9qQQ4uC49KlSdAyd
 fFrh2o9kC3Ob2JtVeUT5gQGbgwwF8H5e5e+xwEojnLYxECXg8Iricsk6VbffaOfoo7Ke
 kAsoEtJDTmHlnF/EuLK18kCSa5ECalyvORKAARoYfc7ZitqJOO+tu9j8qCBQMgKuL8nB
 WtHjle6xLbvD4tz7XiGT7ze6xJLf6o/bCXbFpLo1QaDGZTP95tUtzAFUXJgWvvuSDkmy
 ns1g==
X-Gm-Message-State: AO0yUKW2FWvVRPNdAJYnOmTs3Gpmr213DYLgsQwDqqg+toPTYLyEhVhr
 hQFy/nOlWpDgnk3QGcM4gU7FSzJf2Fh9P3OPnCFD1ofNLEKjOxK7Tvm6M4Yezu874nNPKb4oEU+
 0fA/tQHi2zfVG2uoFc3hp1MUWwVxpUfgPu1jpAdE3Nw==
X-Received: by 2002:a17:906:af67:b0:8b1:2ebf:386c with SMTP id
 os7-20020a170906af6700b008b12ebf386cmr17546549ejb.11.1678292764218; 
 Wed, 08 Mar 2023 08:26:04 -0800 (PST)
X-Google-Smtp-Source: AK7set8TxWKDwU06rCzPy2vfTJC19A6eXIsLeixV/0yiV44dqF+Z7HDR2TEVrPiS3v7JOgrm3yizbQ==
X-Received: by 2002:a17:906:af67:b0:8b1:2ebf:386c with SMTP id
 os7-20020a170906af6700b008b12ebf386cmr17546536ejb.11.1678292763904; 
 Wed, 08 Mar 2023 08:26:03 -0800 (PST)
Received: from redhat.com ([2.52.138.216]) by smtp.gmail.com with ESMTPSA id
 n8-20020a17090695c800b008c76facbbf7sm7818922ejy.171.2023.03.08.08.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Mar 2023 08:26:03 -0800 (PST)
Date: Wed, 8 Mar 2023 11:25:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
Message-ID: <20230308110235-mutt-send-email-mst@kernel.org>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
 <m2ttywzzxd.fsf@oracle.com>
 <4e8d1e89-9b32-8dcd-acd1-6957f13fcbb9@nvidia.com>
 <20230308091321-mutt-send-email-mst@kernel.org>
 <4c031230-c0ac-7809-a85e-09f07c3f7e06@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <4c031230-c0ac-7809-a85e-09f07c3f7e06@nvidia.com>
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

On Wed, Mar 08, 2023 at 10:59:57AM -0500, Feng Liu wrote:
> 
> 
> On 2023-03-08 a.m.9:13, Michael S. Tsirkin wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, Mar 07, 2023 at 09:17:55PM +0000, Feng Liu wrote:
> > > On 2023-03-07 04:14, David Edmondson wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
> > > > writes:
> > > > 
> > > > > Add const to make the read-only pointer parameters clear, similar to
> > > > > many existing functions.
> > > > 
> > > > In many of the modified functions the local variable that is a cast of
> > > > the argument could also be const. Is there a reason not to do both at
> > > > the same time?
> > > > 
> > > 
> > > Hi,David
> > > 
> > > In order to prevent the content of a pointer parameter from being
> > > modified and increase the readability of the function, it is recommended
> > > to add the 'const' keyword to the parameter. This is not necessary for
> > > local variables and non-pointer parameters, as they are only stored on
> > > the stack and do not affect the original value or structure member
> > > passed into the function. Therefore, in this case, the 'const' keyword
> > > is only added to pointer parameters.
> > 
> > This makes no sense to me. If ytou cast away the const then it is
> > pointless.
> > 
> 
> Hi, Michael
> 
> I really don't quite understand your point of view.
> Is a local variable that needs to be add const? Can you help to point
> out the specific problem/point ?

I just repeated what David said.  Basically most of these functions use
to_vvq which uses container_of which in turn loses const qualifier.
So your change is poinless since rest of code accesses vq through
to_vvq.

What to do? I don't like the idea of to_vvq_const.
So I propose a version of container_of using _Generic
which preserves the const qualifier.


#define container_of(ptr, type, member) \
    ({ \
        const void *__mptr = (ptr); \
        static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
                      __same_type(*(ptr), void),                        \
                      "pointer type mismatch in container_of()");       \
        _Generic((ptr), \
                 typeof(&((const type *)0)->member): \
                 (const type *)(__mptr - offsetof(type, member)), \
                 default: \
                 (type *)(__mptr - offsetof(type, member))); \
    })


I'll hack it up in a day or two and post.




> > > 
> > > > > Signed-off-by: Feng Liu <feliu@nvidia.com>
> > > > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > > Reviewed-by: Gavin Li <gavinl@nvidia.com>
> > > > > Reviewed-by: Bodong Wang <bodong@nvidia.com>
> > > > > ---
> > > > >    drivers/virtio/virtio_ring.c | 25 ++++++++++++-------------
> > > > >    include/linux/virtio.h       | 12 ++++++------
> > > > >    2 files changed, 18 insertions(+), 19 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 806cc44eae64..8010fd1d2047 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -233,7 +233,7 @@ static void vring_free(struct virtqueue *_vq);
> > > > > 
> > > > >    #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
> > > > > 
> > > > > -static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
> > > > > +static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> > > > >                                           unsigned int total_sg)
> > > > >    {
> > > > >         /*
> > > > > @@ -269,7 +269,7 @@ static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
> > > > >     * unconditionally on data path.
> > > > >     */
> > > > > 
> > > > > -static bool vring_use_dma_api(struct virtio_device *vdev)
> > > > > +static bool vring_use_dma_api(const struct virtio_device *vdev)
> > > > >    {
> > > > >         if (!virtio_has_dma_quirk(vdev))
> > > > >                 return true;
> > > > > @@ -289,7 +289,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > > > >         return false;
> > > > >    }
> > > > > 
> > > > > -size_t virtio_max_dma_size(struct virtio_device *vdev)
> > > > > +size_t virtio_max_dma_size(const struct virtio_device *vdev)
> > > > >    {
> > > > >         size_t max_segment_size = SIZE_MAX;
> > > > > 
> > > > > @@ -423,7 +423,7 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
> > > > >     */
> > > > > 
> > > > >    static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
> > > > > -                                        struct vring_desc *desc)
> > > > > +                                        const struct vring_desc *desc)
> > > > >    {
> > > > >         u16 flags;
> > > > > 
> > > > > @@ -1183,7 +1183,7 @@ static u16 packed_last_used(u16 last_used_idx)
> > > > >    }
> > > > > 
> > > > >    static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> > > > > -                                  struct vring_desc_extra *extra)
> > > > > +                                  const struct vring_desc_extra *extra)
> > > > >    {
> > > > >         u16 flags;
> > > > > 
> > > > > @@ -1206,7 +1206,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> > > > >    }
> > > > > 
> > > > >    static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> > > > > -                                struct vring_packed_desc *desc)
> > > > > +                                 const struct vring_packed_desc *desc)
> > > > >    {
> > > > >         u16 flags;
> > > > > 
> > > > > @@ -2786,7 +2786,7 @@ EXPORT_SYMBOL_GPL(vring_transport_features);
> > > > >     * Returns the size of the vring.  This is mainly used for boasting to
> > > > >     * userspace.  Unlike other operations, this need not be serialized.
> > > > >     */
> > > > > -unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
> > > > > +unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
> > > > >    {
> > > > > 
> > > > >         struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > @@ -2819,7 +2819,7 @@ void __virtqueue_unbreak(struct virtqueue *_vq)
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
> > > > > 
> > > > > -bool virtqueue_is_broken(struct virtqueue *_vq)
> > > > > +bool virtqueue_is_broken(const struct virtqueue *_vq)
> > > > >    {
> > > > >         struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > 
> > > > > @@ -2827,8 +2827,7 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(virtqueue_is_broken);
> > > > > 
> > > > > -/*
> > > > > - * This should prevent the device from being used, allowing drivers to
> > > > > +/ This should prevent the device from being used, allowing drivers to
> > > > >     * recover.  You may need to grab appropriate locks to flush.
> > > > >     */
> > > > >    void virtio_break_device(struct virtio_device *dev)
> > > > > @@ -2881,7 +2880,7 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(virtqueue_get_desc_addr);
> > > > > 
> > > > > -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
> > > > > +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *_vq)
> > > > >    {
> > > > >         struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > 
> > > > > @@ -2895,7 +2894,7 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(virtqueue_get_avail_addr);
> > > > > 
> > > > > -dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
> > > > > +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *_vq)
> > > > >    {
> > > > >         struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > 
> > > > > @@ -2910,7 +2909,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
> > > > >    EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
> > > > > 
> > > > >    /* Only available for split ring */
> > > > > -const struct vring *virtqueue_get_vring(struct virtqueue *vq)
> > > > > +const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
> > > > >    {
> > > > >         return &to_vvq(vq)->split.vring;
> > > > >    }
> > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > index 2b472514c49b..36a79374e735 100644
> > > > > --- a/include/linux/virtio.h
> > > > > +++ b/include/linux/virtio.h
> > > > > @@ -84,14 +84,14 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
> > > > > 
> > > > >    void *virtqueue_detach_unused_buf(struct virtqueue *vq);
> > > > > 
> > > > > -unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
> > > > > +unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
> > > > > 
> > > > > -bool virtqueue_is_broken(struct virtqueue *vq);
> > > > > +bool virtqueue_is_broken(const struct virtqueue *vq);
> > > > > 
> > > > > -const struct vring *virtqueue_get_vring(struct virtqueue *vq);
> > > > > -dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
> > > > > -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
> > > > > -dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
> > > > > +const struct vring *virtqueue_get_vring(const struct virtqueue *vq);
> > > > > +dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *vq);
> > > > > +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
> > > > > +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
> > > > > 
> > > > >    int virtqueue_resize(struct virtqueue *vq, u32 num,
> > > > >                      void (*recycle)(struct virtqueue *vq, void *buf));
> > > > > --
> > > > > 2.34.1
> > > > > 
> > > > > _______________________________________________
> > > > > Virtualization mailing list
> > > > > Virtualization@lists.linux-foundation.org
> > > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.linuxfoundation.org%2Fmailman%2Flistinfo%2Fvirtualization&data=05%7C01%7Cfeliu%40nvidia.com%7C0f6803f1797f448823ac08db1fdf67e5%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638138816610707030%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=FxggnD7U8o%2B%2BqcYnHN6nc%2BemGVRU1ia5sA4k%2FRTDD7U%3D&reserved=0
> > > > --
> > > > Woke up in my clothes again this morning, don't know exactly where I am.
> > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
