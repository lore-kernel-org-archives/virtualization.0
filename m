Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1097C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 10:22:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D68760E75
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 10:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D68760E75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE01781751;
	Tue, 26 Oct 2021 10:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id phrjEtW1TqfV; Tue, 26 Oct 2021 10:22:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 649608102D;
	Tue, 26 Oct 2021 10:22:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42E76C0012;
	Tue, 26 Oct 2021 10:22:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E595C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 10:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 18D9040142
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 10:22:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qhSJsyXz6Iop
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 10:22:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CD9140017
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 10:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635243721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fwG+pbc/RX0UtcP7zmAqWBtlccSZoVrnTVcmaM/OGoo=;
 b=PJm/YYiMu/vo/Ir0hLt6Ia0d+iusiWxXytz/UQYE9V7NhCacfxkRsocWiUGpVB/1mKeKGe
 03DNu7ijHUtG6XkMvO+6XVKHE6speGzh9ZNJ/IBAR5mCztqGAzJDFRf087RPNzp6HOQEMm
 QXoFIGBcXAVCDWiU5Mp/va6k7uJQZ2Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-48BHh54lNmKUS3ruPs0kSg-1; Tue, 26 Oct 2021 06:21:59 -0400
X-MC-Unique: 48BHh54lNmKUS3ruPs0kSg-1
Received: by mail-lj1-f197.google.com with SMTP id
 s5-20020a2e98c5000000b002112895b3f6so4120570ljj.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 03:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fwG+pbc/RX0UtcP7zmAqWBtlccSZoVrnTVcmaM/OGoo=;
 b=wqOE4B0fwoQhtIIJXqGd3npM4qscxbqxzZviSAQr3n/IZP5Wc3YQukxSWXc6PkJaZL
 uSjiN0viuS5kPGDuRW9oiupgdm10vqE0LdXPndZrdjGzPl76etC2siuBJg6Cwa02XkWF
 MKAYIEeJtnPKAoYUOiJq+G+EMobIsfdEIyVdhoIGyepGaC8W7L10C1cethVSzNtznGzF
 0NBSzdcvbEIMwQkVWAaAmpPY8Q4t9yUk/UfCkXwbTO443iXxt3vhDQLIH0W9D5j8vVit
 N3GbApM4M+zngM4bkqlMlvInPwQwZMqIcGjXp+aqXFJQTnjaST+ex0vszSAFwmoITEyy
 oldw==
X-Gm-Message-State: AOAM530XVeM6O7ohtht5g0C8dND/i+JWANkGebE9hGayFYAaMDX9wNt8
 6kf2jyFJj5Ni5tXCzlXik+5Y1U81fi+/U2XMPpW8etaanO72Q8BZpIFj/uRInZ+8beS3/NuYayp
 Komlhdg+hAaxJg+ZLBp8uly0hQDj2Kbatdyo5XihlgYwQa2gWF9bVjrfblw==
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr22929123lfg.498.1635243718096; 
 Tue, 26 Oct 2021 03:21:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRi7eDA7VNK2NZZvjOTAi7iKncvVwBcSyj0I/WsPXPEK8+uGW2NAe1yK0dNgSsnT1GGqJ206I8AuI2ZWl/F7w=
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr22929089lfg.498.1635243717653; 
 Tue, 26 Oct 2021 03:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211026072000.8699-1-jasowang@redhat.com>
 <20211026072000.8699-2-jasowang@redhat.com>
 <20211026053741-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211026053741-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Oct 2021 18:21:46 +0800
Message-ID: <CACGkMEv64WkTB22CTy_Y_0VPLjT+YLCx6Ea8+Lg2ZDCKOid8UQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/4] virtio_ring: validate used buffer length
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Oct 26, 2021 at 5:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 26, 2021 at 03:19:57PM +0800, Jason Wang wrote:
> > This patch validate the used buffer length provided by the device
> > before trying to use it. This is done by record the in buffer length
> > in a new field in desc_state structure during virtqueue_add(), then we
> > can fail the virtqueue_get_buf() when we find the device is trying to
> > give us a used buffer length which is greater than the in buffer
> > length.
> >
> > Since some drivers have already done the validation by themselves,
> > this patch tries to makes the core validation optional. For the driver
> > that doesn't want the validation, it can set the validate_used to be
> > true (which could be overridden by force_used_validation). To be more
>
> This description is now out of date. it's suppress_used_validation.

Yes, do you want me to post a new version or do you want to fix it for me?

Thanks

>
> > efficient, a dedicate array is used for storing the validate used
> > length, this helps to eliminate the cache stress if validation is done
> > by the driver.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 60 ++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h       |  2 ++
> >  2 files changed, 62 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 4c0ec82cef56..a6e5a3b94337 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -14,6 +14,9 @@
> >  #include <linux/spinlock.h>
> >  #include <xen/xen.h>
> >
> > +static bool force_used_validation = false;
> > +module_param(force_used_validation, bool, 0444);
> > +
> >  #ifdef DEBUG
> >  /* For development, we want to crash whenever the ring is screwed. */
> >  #define BAD_RING(_vq, fmt, args...)                          \
> > @@ -182,6 +185,9 @@ struct vring_virtqueue {
> >               } packed;
> >       };
> >
> > +     /* Per-descriptor in buffer length */
> > +     u32 *buflen;
> > +
> >       /* How to notify other side. FIXME: commonalize hcalls! */
> >       bool (*notify)(struct virtqueue *vq);
> >
> > @@ -490,6 +496,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >       unsigned int i, n, avail, descs_used, prev, err_idx;
> >       int head;
> >       bool indirect;
> > +     u32 buflen = 0;
> >
> >       START_USE(vq);
> >
> > @@ -571,6 +578,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >                                                    VRING_DESC_F_NEXT |
> >                                                    VRING_DESC_F_WRITE,
> >                                                    indirect);
> > +                     buflen += sg->length;
> >               }
> >       }
> >       /* Last one doesn't continue. */
> > @@ -610,6 +618,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >       else
> >               vq->split.desc_state[head].indir_desc = ctx;
> >
> > +     /* Store in buffer length if necessary */
> > +     if (vq->buflen)
> > +             vq->buflen[head] = buflen;
> > +
> >       /* Put entry in available array (but don't update avail->idx until they
> >        * do sync). */
> >       avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > @@ -784,6 +796,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >               BAD_RING(vq, "id %u is not a head!\n", i);
> >               return NULL;
> >       }
> > +     if (vq->buflen && unlikely(*len > vq->buflen[i])) {
> > +             BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> > +                     *len, vq->buflen[i]);
> > +             return NULL;
> > +     }
> >
> >       /* detach_buf_split clears data, so grab it now. */
> >       ret = vq->split.desc_state[i].data;
> > @@ -1062,6 +1079,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> >       unsigned int i, n, err_idx;
> >       u16 head, id;
> >       dma_addr_t addr;
> > +     u32 buflen = 0;
> >
> >       head = vq->packed.next_avail_idx;
> >       desc = alloc_indirect_packed(total_sg, gfp);
> > @@ -1091,6 +1109,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> >                       desc[i].addr = cpu_to_le64(addr);
> >                       desc[i].len = cpu_to_le32(sg->length);
> >                       i++;
> > +                     if (n >= out_sgs)
> > +                             buflen += sg->length;
> >               }
> >       }
> >
> > @@ -1144,6 +1164,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> >       vq->packed.desc_state[id].indir_desc = desc;
> >       vq->packed.desc_state[id].last = id;
> >
> > +     /* Store in buffer length if necessary */
> > +     if (vq->buflen)
> > +             vq->buflen[id] = buflen;
> > +
> >       vq->num_added += 1;
> >
> >       pr_debug("Added buffer head %i to %p\n", head, vq);
> > @@ -1179,6 +1203,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >       __le16 head_flags, flags;
> >       u16 head, id, prev, curr, avail_used_flags;
> >       int err;
> > +     u32 buflen = 0;
> >
> >       START_USE(vq);
> >
> > @@ -1258,6 +1283,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >                                       1 << VRING_PACKED_DESC_F_AVAIL |
> >                                       1 << VRING_PACKED_DESC_F_USED;
> >                       }
> > +                     if (n >= out_sgs)
> > +                             buflen += sg->length;
> >               }
> >       }
> >
> > @@ -1277,6 +1304,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >       vq->packed.desc_state[id].indir_desc = ctx;
> >       vq->packed.desc_state[id].last = prev;
> >
> > +     /* Store in buffer length if necessary */
> > +     if (vq->buflen)
> > +             vq->buflen[id] = buflen;
> > +
> >       /*
> >        * A driver MUST NOT make the first descriptor in the list
> >        * available before all subsequent descriptors comprising
> > @@ -1463,6 +1494,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >               BAD_RING(vq, "id %u is not a head!\n", id);
> >               return NULL;
> >       }
> > +     if (vq->buflen && unlikely(*len > vq->buflen[id])) {
> > +             BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> > +                     *len, vq->buflen[id]);
> > +             return NULL;
> > +     }
> >
> >       /* detach_buf_packed clears data, so grab it now. */
> >       ret = vq->packed.desc_state[id].data;
> > @@ -1668,6 +1704,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >       struct vring_virtqueue *vq;
> >       struct vring_packed_desc *ring;
> >       struct vring_packed_desc_event *driver, *device;
> > +     struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
> >       dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
> >       size_t ring_size_in_bytes, event_size_in_bytes;
> >
> > @@ -1757,6 +1794,15 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >       if (!vq->packed.desc_extra)
> >               goto err_desc_extra;
> >
> > +     if (!drv->suppress_used_validation || force_used_validation) {
> > +             vq->buflen = kmalloc_array(num, sizeof(*vq->buflen),
> > +                                        GFP_KERNEL);
> > +             if (!vq->buflen)
> > +                     goto err_buflen;
> > +     } else {
> > +             vq->buflen = NULL;
> > +     }
> > +
> >       /* No callback?  Tell other side not to bother us. */
> >       if (!callback) {
> >               vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
> > @@ -1769,6 +1815,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >       spin_unlock(&vdev->vqs_list_lock);
> >       return &vq->vq;
> >
> > +err_buflen:
> > +     kfree(vq->packed.desc_extra);
> >  err_desc_extra:
> >       kfree(vq->packed.desc_state);
> >  err_desc_state:
> > @@ -2176,6 +2224,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >                                       void (*callback)(struct virtqueue *),
> >                                       const char *name)
> >  {
> > +     struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
> >       struct vring_virtqueue *vq;
> >
> >       if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> > @@ -2235,6 +2284,15 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >       if (!vq->split.desc_extra)
> >               goto err_extra;
> >
> > +     if (!drv->suppress_used_validation || force_used_validation) {
> > +             vq->buflen = kmalloc_array(vring.num, sizeof(*vq->buflen),
> > +                                        GFP_KERNEL);
> > +             if (!vq->buflen)
> > +                     goto err_buflen;
> > +     } else {
> > +             vq->buflen = NULL;
> > +     }
> > +
> >       /* Put everything in free lists. */
> >       vq->free_head = 0;
> >       memset(vq->split.desc_state, 0, vring.num *
> > @@ -2245,6 +2303,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >       spin_unlock(&vdev->vqs_list_lock);
> >       return &vq->vq;
> >
> > +err_buflen:
> > +     kfree(vq->split.desc_extra);
> >  err_extra:
> >       kfree(vq->split.desc_state);
> >  err_state:
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 41edbc01ffa4..44d0e09da2d9 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -152,6 +152,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
> >   * @feature_table_size: number of entries in the feature table array.
> >   * @feature_table_legacy: same as feature_table but when working in legacy mode.
> >   * @feature_table_size_legacy: number of entries in feature table legacy array.
> > + * @suppress_used_validation: set to not have core validate used length
> >   * @probe: the function to call when a device is found.  Returns 0 or -errno.
> >   * @scan: optional function to call after successful probe; intended
> >   *    for virtio-scsi to invoke a scan.
> > @@ -168,6 +169,7 @@ struct virtio_driver {
> >       unsigned int feature_table_size;
> >       const unsigned int *feature_table_legacy;
> >       unsigned int feature_table_size_legacy;
> > +     bool suppress_used_validation;
> >       int (*validate)(struct virtio_device *dev);
> >       int (*probe)(struct virtio_device *dev);
> >       void (*scan)(struct virtio_device *dev);
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
