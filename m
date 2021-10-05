Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849F2C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 08:14:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F1461216
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 08:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38F1461216
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F168C83A66;
	Tue,  5 Oct 2021 08:14:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-TKCfvgnuKU; Tue,  5 Oct 2021 08:14:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3E46783774;
	Tue,  5 Oct 2021 08:14:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A833C0011;
	Tue,  5 Oct 2021 08:14:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2B91C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 08:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 831D58377F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 08:14:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Kpt2LlwGILM
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 08:14:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7466083774
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 08:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633421668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oXZm6oEV+vD/1t1tTcbyQqO0I6oLB2ahx3QouqITYg4=;
 b=XgRSib+FyY3PsVRJ8x6pgA3KZYOs4HdXW9fKwAJRo+5zvRqlTqk/yRXb8MGyFNYbVsWZEz
 y+CvFnRtnXxukRd1FHoS1ffYYhXRDoqrpJ5B5+kEr1hgOeRtTexLm5lGPsLTJEuKkNZ+Is
 Y3GBs9vfy/gp3Tsp6iFqB+3RBVgjl10=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-dr_5r3i7MUC-TaKQ4jwuOA-1; Tue, 05 Oct 2021 04:14:27 -0400
X-MC-Unique: dr_5r3i7MUC-TaKQ4jwuOA-1
Received: by mail-ed1-f71.google.com with SMTP id
 i7-20020a50d747000000b003db0225d219so2693373edj.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 01:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=oXZm6oEV+vD/1t1tTcbyQqO0I6oLB2ahx3QouqITYg4=;
 b=LdHxr/DT+zgF5fVhYX1UuaVB6KmVzbOmMv6iI/mkoxf4gdveWjdMy/GX7Z0G1A7KxE
 mAGYXrUfxpqt0FrVHVI8j2ax9h47ASMpMXsI4TSC6gjo9ts9k5uiJo29Nei4Chp6Bx6a
 Sr8PCgS6yTk302iUQWmOnFRa2vxTUysCi/5dUsXSjL1ctG3AG2VLY/BxyMdWoF/jSTID
 YjJP+BZP/nw8fjzMImszN6WQS09Judgoxwr/QEX1QO5vW7Di0KjXGsC5be7mwxpSO9Bx
 tu/PNvzMYD1RT89XqG5DLUHnmgN2BynzXFhlAZuPk0+kqkmKWS22HJdUt+zb6zfTezw+
 Q5Cw==
X-Gm-Message-State: AOAM531pe5Sbvg8gAFMiKScRa2SZNPEqJrgUBy2t9M6DriOMF2A8J80+
 uavUk1dhJ6Q1jcp01xecZ/AXgW1d6824eElxfUhhjs3Tjt24GoeO08mPC6cM9gIEnPakJevxvbh
 fMBCkzwpWVVl6P2r9MZ3MId8LyPXQfOUGwpixoCw3OA==
X-Received: by 2002:aa7:d397:: with SMTP id x23mr10225986edq.377.1633421665847; 
 Tue, 05 Oct 2021 01:14:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOmd0zQJQpUNAdxNT8RCXLA9X4PQWo6j+690bzzm2QgsYONYss08Fgj8S0ePbgpRzHnzw61Q==
X-Received: by 2002:aa7:d397:: with SMTP id x23mr10225961edq.377.1633421665614; 
 Tue, 05 Oct 2021 01:14:25 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id u16sm7352814ejy.14.2021.10.05.01.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 01:14:25 -0700 (PDT)
Date: Tue, 5 Oct 2021 04:14:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH 3/3] vdpa: Check for iova range at mappings changes
Message-ID: <20211005040928-mutt-send-email-mst@kernel.org>
References: <20211005080131.408506-1-eperezma@redhat.com>
 <20211005080131.408506-4-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211005080131.408506-4-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Parav Pandit <parav@mellanox.com>, qemu-devel@nongnu.org,
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

On Tue, Oct 05, 2021 at 10:01:31AM +0200, Eugenio P=E9rez wrote:
> Check vdpa device range before updating memory regions so we don't add
> any outside of it, and report the invalid change if any.
> =

> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  include/hw/virtio/vhost-vdpa.h |  2 +
>  hw/virtio/vhost-vdpa.c         | 68 ++++++++++++++++++++++++++--------
>  hw/virtio/trace-events         |  1 +
>  3 files changed, 55 insertions(+), 16 deletions(-)
> =

> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> index a8963da2d9..c288cf7ecb 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -13,6 +13,7 @@
>  #define HW_VIRTIO_VHOST_VDPA_H
>  =

>  #include "hw/virtio/virtio.h"
> +#include "standard-headers/linux/vhost_types.h"
>  =

>  typedef struct VhostVDPAHostNotifier {
>      MemoryRegion mr;
> @@ -24,6 +25,7 @@ typedef struct vhost_vdpa {
>      uint32_t msg_type;
>      bool iotlb_batch_begin_sent;
>      MemoryListener listener;
> +    struct vhost_vdpa_iova_range iova_range;
>      struct vhost_dev *dev;
>      VhostVDPAHostNotifier notifier[VIRTIO_QUEUE_MAX];
>  } VhostVDPA;
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index a1de6c7c9c..26d0258723 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -33,20 +33,34 @@ static Int128 vhost_vdpa_section_end(const MemoryRegi=
onSection *section)
>      return llend;
>  }
>  =

> -static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *sec=
tion)
> -{
> -    return (!memory_region_is_ram(section->mr) &&
> -            !memory_region_is_iommu(section->mr)) ||
> -            memory_region_is_protected(section->mr) ||
> -           /* vhost-vDPA doesn't allow MMIO to be mapped  */
> -            memory_region_is_ram_device(section->mr) ||
> -           /*
> -            * Sizing an enabled 64-bit BAR can cause spurious mappings to
> -            * addresses in the upper part of the 64-bit address space.  =
These
> -            * are never accessed by the CPU and beyond the address width=
 of
> -            * some IOMMU hardware.  TODO: VDPA should tell us the IOMMU =
width.
> -            */
> -           section->offset_within_address_space & (1ULL << 63);
> +static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *sec=
tion,
> +                                                uint64_t iova_min,
> +                                                uint64_t iova_max)
> +{
> +    Int128 llend;
> +    bool r =3D (!memory_region_is_ram(section->mr) &&
> +              !memory_region_is_iommu(section->mr)) ||
> +              memory_region_is_protected(section->mr) ||
> +              /* vhost-vDPA doesn't allow MMIO to be mapped  */
> +              memory_region_is_ram_device(section->mr);
> +    if (r) {
> +        return true;
> +    }
> +
> +    if (section->offset_within_address_space < iova_min) {
> +        error_report("RAM section out of device range (min=3D%lu, addr=
=3D%lu)",
> +                     iova_min, section->offset_within_address_space);
> +        return true;
> +    }
> +
> +    llend =3D vhost_vdpa_section_end(section);
> +    if (int128_make64(llend) > iova_max) {

I am puzzled by this.
You are taking a Int128, converting to u64, converting
back to Int128, and comparing to u64.
Head spins. What is all this back and forth trying to achieve?

> +        error_report("RAM section out of device range (max=3D%lu, end ad=
dr=3D%lu)",
> +                     iova_max, (uint64_t)int128_make64(llend));
> +        return true;
> +    }
> +
> +    return false;
>  }
>  =

>  static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr =
size,
> @@ -158,7 +172,8 @@ static void vhost_vdpa_listener_region_add(MemoryList=
ener *listener,
>      void *vaddr;
>      int ret;
>  =

> -    if (vhost_vdpa_listener_skipped_section(section)) {
> +    if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
> +                                            v->iova_range.last)) {
>          return;
>      }
>  =

> @@ -216,7 +231,8 @@ static void vhost_vdpa_listener_region_del(MemoryList=
ener *listener,
>      Int128 llend, llsize;
>      int ret;
>  =

> -    if (vhost_vdpa_listener_skipped_section(section)) {
> +    if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
> +                                            v->iova_range.last)) {
>          return;
>      }
>  =

> @@ -284,9 +300,24 @@ static void vhost_vdpa_add_status(struct vhost_dev *=
dev, uint8_t status)
>      vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &s);
>  }
>  =

> +static int vhost_vdpa_get_iova_range(struct vhost_vdpa *v)
> +{
> +    int ret;
> +
> +    ret =3D vhost_vdpa_call(v->dev, VHOST_VDPA_GET_IOVA_RANGE, &v->iova_=
range);
> +    if (ret !=3D 0) {
> +        return ret;
> +    }
> +
> +    trace_vhost_vdpa_get_iova_range(v->dev, v->iova_range.first,
> +                                    v->iova_range.last);
> +    return ret;
> +}
> +
>  static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **=
errp)
>  {
>      struct vhost_vdpa *v;
> +    int r;
>      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA);
>      trace_vhost_vdpa_init(dev, opaque);
>  =

> @@ -296,6 +327,11 @@ static int vhost_vdpa_init(struct vhost_dev *dev, vo=
id *opaque, Error **errp)
>      v->listener =3D vhost_vdpa_memory_listener;
>      v->msg_type =3D VHOST_IOTLB_MSG_V2;
>  =

> +    r =3D vhost_vdpa_get_iova_range(v);
> +    if (unlikely(!r)) {
> +        return r;
> +    }
> +
>      vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
>                                 VIRTIO_CONFIG_S_DRIVER);
>  =

> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 8ed19e9d0c..650e521e35 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -52,6 +52,7 @@ vhost_vdpa_set_vring_call(void *dev, unsigned int index=
, int fd) "dev: %p index:
>  vhost_vdpa_get_features(void *dev, uint64_t features) "dev: %p features:=
 0x%"PRIx64
>  vhost_vdpa_set_owner(void *dev) "dev: %p"
>  vhost_vdpa_vq_get_addr(void *dev, void *vq, uint64_t desc_user_addr, uin=
t64_t avail_user_addr, uint64_t used_user_addr) "dev: %p vq: %p desc_user_a=
ddr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" used_user_addr: 0x%"PRIx64
> +vhost_vdpa_get_iova_range(void *dev, uint64_t first, uint64_t last) "dev=
: %p first: 0x%"PRIx64" last: 0x%"PRIx64
>  =

>  # virtio.c
>  virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned=
 out_num) "elem %p size %zd in_num %u out_num %u"
> -- =

> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
