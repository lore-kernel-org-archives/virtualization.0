Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C671FC433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 10:46:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8244B61528
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 10:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8244B61528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 41F8340335;
	Tue,  5 Oct 2021 10:46:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B5Mu8Nszg_XZ; Tue,  5 Oct 2021 10:46:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 53070402C4;
	Tue,  5 Oct 2021 10:46:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39585C0011;
	Tue,  5 Oct 2021 10:46:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08BBDC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 10:46:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D423E40538
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 10:46:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L4VrAAz3ytlG
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 10:46:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8DA24039E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633430806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVG2LswyQNOuElNGD4fcYX5JNPQtkil/XvOSEaqvA1w=;
 b=DfYG1BnbA6esHhHSXFA+DsyTo3cP9l81gA175e5PDEHN/w+M19qFZKld55htdELixS7F1z
 beiIX8yCmDQfkZmR1Be50L6nWHsVA5Wbtrvz+f3gpzx17Rjv9ucqyVNieGDlsGWsY2nZA9
 bRODarqNOlteeHoz3350r0Q/AX189C4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-8Xezu1NzPKGX_hgcporylg-1; Tue, 05 Oct 2021 06:46:45 -0400
X-MC-Unique: 8Xezu1NzPKGX_hgcporylg-1
Received: by mail-ed1-f69.google.com with SMTP id
 t28-20020a508d5c000000b003dad7fc5caeso10306616edt.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 03:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KVG2LswyQNOuElNGD4fcYX5JNPQtkil/XvOSEaqvA1w=;
 b=DRJBfNZw7um/RD8EvVVDWyCqh2M4bat8qh3aaexJaCA/T62i0pJJ1uzt705h58LoLk
 ZAOhKzOzx5AYt1dFncfCpRZUlggI+4CJjtKwodMab9GxsNjrhZlgJbn1xdZELYB0H8Jk
 r0AkK7Z1j0YAXQ3b4sYwKrR9bMcXJwWjQHh5ZAaIiQndZYZGF4b4C+WCw9gVv1KaWiAV
 1zJz/xgtHgiCk/fRtH0mwX+TbeKuG9c4EYbOBR9m5LE0b4+aZzQvYQn3cRWtjWWZf13P
 QARHYtLQNOdqVs2J0HFcEarJDyULPtChaEoNlFdkpL94NdcoaK/7vQ2FP+VfHcz9GDu5
 eUAg==
X-Gm-Message-State: AOAM530UKQNMFjpOYB3PpA2WR93QFyiVBezt4EhiJ7nRYxrK7eCNpjM3
 rifT+PqyPTebBey1ha0jZJ+Zs6vmPyrRj9nTERC19XhJejPzbgwVoFUkE+G/IpJbpHhrU/J766I
 GhoPVzFcQp488mZp3VZWFdznyTTZa4JeSh8JwkSjD6Q==
X-Received: by 2002:a17:906:5051:: with SMTP id
 e17mr23550220ejk.481.1633430803815; 
 Tue, 05 Oct 2021 03:46:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpUwHMeKX2P53cunQHgX/tNH3AauGbN7alhz5U5ELzrC+k5PMrrvbc1a0R4XihaoPJRfGcYA==
X-Received: by 2002:a17:906:5051:: with SMTP id
 e17mr23550184ejk.481.1633430803530; 
 Tue, 05 Oct 2021 03:46:43 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id y8sm7553618ejm.104.2021.10.05.03.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 03:46:42 -0700 (PDT)
Date: Tue, 5 Oct 2021 06:46:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH 3/3] vdpa: Check for iova range at mappings changes
Message-ID: <20211005064626-mutt-send-email-mst@kernel.org>
References: <20211005080131.408506-1-eperezma@redhat.com>
 <20211005080131.408506-4-eperezma@redhat.com>
 <20211005040928-mutt-send-email-mst@kernel.org>
 <CAJaqyWdJbpSN8q5idvaYFr7eKAyj5yD36aOMpJ21roqc2ObxHg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdJbpSN8q5idvaYFr7eKAyj5yD36aOMpJ21roqc2ObxHg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Parav Pandit <parav@mellanox.com>, qemu-level <qemu-devel@nongnu.org>,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Oct 05, 2021 at 11:58:12AM +0200, Eugenio Perez Martin wrote:
> On Tue, Oct 5, 2021 at 10:14 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 05, 2021 at 10:01:31AM +0200, Eugenio P=E9rez wrote:
> > > Check vdpa device range before updating memory regions so we don't add
> > > any outside of it, and report the invalid change if any.
> > >
> > > Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> > > ---
> > >  include/hw/virtio/vhost-vdpa.h |  2 +
> > >  hw/virtio/vhost-vdpa.c         | 68 ++++++++++++++++++++++++++------=
--
> > >  hw/virtio/trace-events         |  1 +
> > >  3 files changed, 55 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost=
-vdpa.h
> > > index a8963da2d9..c288cf7ecb 100644
> > > --- a/include/hw/virtio/vhost-vdpa.h
> > > +++ b/include/hw/virtio/vhost-vdpa.h
> > > @@ -13,6 +13,7 @@
> > >  #define HW_VIRTIO_VHOST_VDPA_H
> > >
> > >  #include "hw/virtio/virtio.h"
> > > +#include "standard-headers/linux/vhost_types.h"
> > >
> > >  typedef struct VhostVDPAHostNotifier {
> > >      MemoryRegion mr;
> > > @@ -24,6 +25,7 @@ typedef struct vhost_vdpa {
> > >      uint32_t msg_type;
> > >      bool iotlb_batch_begin_sent;
> > >      MemoryListener listener;
> > > +    struct vhost_vdpa_iova_range iova_range;
> > >      struct vhost_dev *dev;
> > >      VhostVDPAHostNotifier notifier[VIRTIO_QUEUE_MAX];
> > >  } VhostVDPA;
> > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > > index a1de6c7c9c..26d0258723 100644
> > > --- a/hw/virtio/vhost-vdpa.c
> > > +++ b/hw/virtio/vhost-vdpa.c
> > > @@ -33,20 +33,34 @@ static Int128 vhost_vdpa_section_end(const Memory=
RegionSection *section)
> > >      return llend;
> > >  }
> > >
> > > -static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection =
*section)
> > > -{
> > > -    return (!memory_region_is_ram(section->mr) &&
> > > -            !memory_region_is_iommu(section->mr)) ||
> > > -            memory_region_is_protected(section->mr) ||
> > > -           /* vhost-vDPA doesn't allow MMIO to be mapped  */
> > > -            memory_region_is_ram_device(section->mr) ||
> > > -           /*
> > > -            * Sizing an enabled 64-bit BAR can cause spurious mappin=
gs to
> > > -            * addresses in the upper part of the 64-bit address spac=
e.  These
> > > -            * are never accessed by the CPU and beyond the address w=
idth of
> > > -            * some IOMMU hardware.  TODO: VDPA should tell us the IO=
MMU width.
> > > -            */
> > > -           section->offset_within_address_space & (1ULL << 63);
> > > +static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection =
*section,
> > > +                                                uint64_t iova_min,
> > > +                                                uint64_t iova_max)
> > > +{
> > > +    Int128 llend;
> > > +    bool r =3D (!memory_region_is_ram(section->mr) &&
> > > +              !memory_region_is_iommu(section->mr)) ||
> > > +              memory_region_is_protected(section->mr) ||
> > > +              /* vhost-vDPA doesn't allow MMIO to be mapped  */
> > > +              memory_region_is_ram_device(section->mr);
> > > +    if (r) {
> > > +        return true;
> > > +    }
> > > +
> > > +    if (section->offset_within_address_space < iova_min) {
> > > +        error_report("RAM section out of device range (min=3D%lu, ad=
dr=3D%lu)",
> > > +                     iova_min, section->offset_within_address_space);
> > > +        return true;
> > > +    }
> > > +
> > > +    llend =3D vhost_vdpa_section_end(section);
> > > +    if (int128_make64(llend) > iova_max) {
> >
> > I am puzzled by this.
> > You are taking a Int128, converting to u64, converting
> > back to Int128, and comparing to u64.
> > Head spins. What is all this back and forth trying to achieve?
> >
> =

> You are totally right, this series was extracted from a longer one
> where I didn't use vhost_vdpa_section_end, but raw addresses. Then I
> applied int128_make64 to the wrong variable, too fast.
> =

> To be sure we are on the same page, to do:
> =

> if (int128_ge(int128_make64(iova), llend)) {
>     // error message
>     return;
> }
> =

> The same way as vhost_vdpa_listener_region_{add,del} would be ok?
> =

> Thanks!


should be ok, yea

> > > +        error_report("RAM section out of device range (max=3D%lu, en=
d addr=3D%lu)",
> > > +                     iova_max, (uint64_t)int128_make64(llend));
> > > +        return true;
> > > +    }
> > > +
> > > +    return false;
> > >  }
> > >
> > >  static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwa=
ddr size,
> > > @@ -158,7 +172,8 @@ static void vhost_vdpa_listener_region_add(Memory=
Listener *listener,
> > >      void *vaddr;
> > >      int ret;
> > >
> > > -    if (vhost_vdpa_listener_skipped_section(section)) {
> > > +    if (vhost_vdpa_listener_skipped_section(section, v->iova_range.f=
irst,
> > > +                                            v->iova_range.last)) {
> > >          return;
> > >      }
> > >
> > > @@ -216,7 +231,8 @@ static void vhost_vdpa_listener_region_del(Memory=
Listener *listener,
> > >      Int128 llend, llsize;
> > >      int ret;
> > >
> > > -    if (vhost_vdpa_listener_skipped_section(section)) {
> > > +    if (vhost_vdpa_listener_skipped_section(section, v->iova_range.f=
irst,
> > > +                                            v->iova_range.last)) {
> > >          return;
> > >      }
> > >
> > > @@ -284,9 +300,24 @@ static void vhost_vdpa_add_status(struct vhost_d=
ev *dev, uint8_t status)
> > >      vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &s);
> > >  }
> > >
> > > +static int vhost_vdpa_get_iova_range(struct vhost_vdpa *v)
> > > +{
> > > +    int ret;
> > > +
> > > +    ret =3D vhost_vdpa_call(v->dev, VHOST_VDPA_GET_IOVA_RANGE, &v->i=
ova_range);
> > > +    if (ret !=3D 0) {
> > > +        return ret;
> > > +    }
> > > +
> > > +    trace_vhost_vdpa_get_iova_range(v->dev, v->iova_range.first,
> > > +                                    v->iova_range.last);
> > > +    return ret;
> > > +}
> > > +
> > >  static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Erro=
r **errp)
> > >  {
> > >      struct vhost_vdpa *v;
> > > +    int r;
> > >      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VD=
PA);
> > >      trace_vhost_vdpa_init(dev, opaque);
> > >
> > > @@ -296,6 +327,11 @@ static int vhost_vdpa_init(struct vhost_dev *dev=
, void *opaque, Error **errp)
> > >      v->listener =3D vhost_vdpa_memory_listener;
> > >      v->msg_type =3D VHOST_IOTLB_MSG_V2;
> > >
> > > +    r =3D vhost_vdpa_get_iova_range(v);
> > > +    if (unlikely(!r)) {
> > > +        return r;
> > > +    }
> > > +
> > >      vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> > >                                 VIRTIO_CONFIG_S_DRIVER);
> > >
> > > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > > index 8ed19e9d0c..650e521e35 100644
> > > --- a/hw/virtio/trace-events
> > > +++ b/hw/virtio/trace-events
> > > @@ -52,6 +52,7 @@ vhost_vdpa_set_vring_call(void *dev, unsigned int i=
ndex, int fd) "dev: %p index:
> > >  vhost_vdpa_get_features(void *dev, uint64_t features) "dev: %p featu=
res: 0x%"PRIx64
> > >  vhost_vdpa_set_owner(void *dev) "dev: %p"
> > >  vhost_vdpa_vq_get_addr(void *dev, void *vq, uint64_t desc_user_addr,=
 uint64_t avail_user_addr, uint64_t used_user_addr) "dev: %p vq: %p desc_us=
er_addr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" used_user_addr: 0x%"PRIx64
> > > +vhost_vdpa_get_iova_range(void *dev, uint64_t first, uint64_t last) =
"dev: %p first: 0x%"PRIx64" last: 0x%"PRIx64
> > >
> > >  # virtio.c
> > >  virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsi=
gned out_num) "elem %p size %zd in_num %u out_num %u"
> > > --
> > > 2.27.0
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
