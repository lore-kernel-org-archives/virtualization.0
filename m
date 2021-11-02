Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392DDC433F5
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 03:54:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D069260EBC
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 03:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D069260EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EF2C60727;
	Tue,  2 Nov 2021 03:54:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cYo_TMOQQpqF; Tue,  2 Nov 2021 03:54:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC5F260636;
	Tue,  2 Nov 2021 03:54:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4DF8C0012;
	Tue,  2 Nov 2021 03:54:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE89EC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFEE860655
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id okgk_IGNrHCD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:54:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 809EA60636
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635825264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZyyl0TVW5IjSjKmk16FYhpmpNrCsjekrv5/NqsRPmo=;
 b=D9SMYc+qig0vdwCkFDBdVOMccfVh9qT3heDq6tWklKjrq2gukWS9q021SIJ0I0W/4hCKyW
 0akUf3ejcSNBV6kq/acKdm4idFtP6vrMV8GSKUaQciZoszELyGyGoCNhdCso6QdBQy/yLF
 O2I4UV9zMWuyRjJtkaWQ1/y5+EzQ7Zc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-9cgLL2CVM2iMlZLxgarRjw-1; Mon, 01 Nov 2021 23:54:22 -0400
X-MC-Unique: 9cgLL2CVM2iMlZLxgarRjw-1
Received: by mail-lj1-f197.google.com with SMTP id
 f17-20020a2e9751000000b00211a1367c68so7128937ljj.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 20:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CZyyl0TVW5IjSjKmk16FYhpmpNrCsjekrv5/NqsRPmo=;
 b=F/ITbIe/78uGWlCIrTr13ioXkfCP2cQX04RAnBWKB5hpMkBrz3F+4cHfWUBHS5KWjL
 fhkuajVLlGkVYhFR2oQ6cT4icNE/Bc61gCLG30dk+YFr9m5jduXflt5ircn+Q++eQfwP
 qY36xGunY3qK5RZotvuhLfOyWda1DSdykE5WJcriQXocnVuEdGxJjg8aGMMMf4eRAGqE
 lr/l/eT97YGUyXTqKFooNB3gv1sGLTMRstEb5+pEYRhUCr2WWy9x4W3rkJSTGsdzj0Tf
 jcw99mBBirSN2wfY58TWQtGReVfdqq0Scxx6Jez1SvqLHOXZMeBIvBh8zMb8kO72qX5n
 BDwg==
X-Gm-Message-State: AOAM530ZyS7Li57QBBauY3xf9KuofPhjUeUButA4xhlz/+xPjYQlA/ly
 zYP5wSDfckrnffmddC8aVN0212QxynLsJRMpL1CiYCgrGR3DrsGqnCGYVraY/dOvSToLP5kczSF
 +XA13IxY8kM8zSxfyXJ84Wv0XraK/7YAHKgKXAbfiEBU3Pnvwzfjd6YR3hw==
X-Received: by 2002:a05:6512:1291:: with SMTP id
 u17mr32958879lfs.84.1635825260625; 
 Mon, 01 Nov 2021 20:54:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRIQ+z5bRRGv9yeZAuxUIB+7vDq/QSTl9mFm+K4uBUJvyEW3Z26FBIzcgAayLu+2xhJTS/5htZMl4mL7Lcvfw=
X-Received: by 2002:a05:6512:1291:: with SMTP id
 u17mr32958849lfs.84.1635825260308; 
 Mon, 01 Nov 2021 20:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211027022107.14357-2-jasowang@redhat.com>
 <1635823138.4631283-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1635823138.4631283-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 2 Nov 2021 11:54:09 +0800
Message-ID: <CACGkMEuTkbgWJKLb+McZRUbvu+BD+-S0HdqabyxjTrX2T5=CJA@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kaplan, david" <david.kaplan@amd.com>, mst <mst@redhat.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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

On Tue, Nov 2, 2021 at 11:22 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Wed, 27 Oct 2021 10:21:04 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > This patch validate the used buffer length provided by the device
> > before trying to use it. This is done by record the in buffer length
> > in a new field in desc_state structure during virtqueue_add(), then we
> > can fail the virtqueue_get_buf() when we find the device is trying to
> > give us a used buffer length which is greater than the in buffer
> > length.
> >
> > Since some drivers have already done the validation by themselves,
> > this patch tries to makes the core validation optional. For the driver
> > that doesn't want the validation, it can set the
> > suppress_used_validation to be true (which could be overridden by
> > force_used_validation module parameter). To be more efficient, a
> > dedicate array is used for storing the validate used length, this
> > helps to eliminate the cache stress if validation is done by the
> > driver.
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
>
> The reason for not using "struct vring_desc_state_split/ struct vring_desc_state_split"
> is to occupy less memory when turning off this function?

Less memory and less cache pressure.

Thanks

>
> Thanks.
>
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
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
