Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C3FC433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 17:42:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF8721D42
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 17:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF8721D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1831B86E2C;
	Mon,  7 Dec 2020 17:42:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9oPIzBTdH+Ng; Mon,  7 Dec 2020 17:42:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9661F86E19;
	Mon,  7 Dec 2020 17:42:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7756DC0893;
	Mon,  7 Dec 2020 17:42:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65510C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 17:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5F49786E57
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 17:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oFsr8gwYkS5B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 17:42:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C12C086E4C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 17:42:37 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id q16so14601162edv.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Dec 2020 09:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=mq8NM1bE2akKplJdl1Dq9pIrf37eZ1c662uiTUaXVd8=;
 b=UO0DMOXJ564lPXCQ3QeKCEYsm+qs6EWwHCdb4Dytr1pqf0oMJrE3OUfdwxiDzazbYO
 cnh+8Cpp70M0K/miVknDpbAq03n4r8scIALOPVpyP7hq2+J7B6VAq9HiNLVHTCQQXboB
 l9jBaV3UI7vTmurBackdZeUIiXje+dV/RDldpX9xd24fzlHsuBRzLpKQcO3wUoqfKRgp
 NDGtmlzThhjABfYeKslwiVA0JeyTUAafCJE6i05G6/8iAn4/B5B9gIVTuG1r69XhTXfF
 RblpTfikRFx1yCfgd7v/MOsN5zmcswXghp+OHd6mJXLtIAfqCbBSNcAMTfmgjQhTNIEv
 8tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mq8NM1bE2akKplJdl1Dq9pIrf37eZ1c662uiTUaXVd8=;
 b=mzWEK11ivANHl8ILWewZ4gON8qsx6tSOn4Z86jLM/lQwhgSot/Nj+6pm9eYUYpjiID
 rSDUSxhYQqIcKMaRhsr46okyNDh58UzTGX3wlx0qbVoyY8xeXW46w+NY5wo2YlBWBMrp
 ds5tF83nCb/j033VggD0cYuFRcPsUNtzjn+caY839cCMqFVlVasXLjKayQEz7pGGPnDM
 yx1drofvqFX7J2j1DWpTfbRUzwTl0YIwiCHFnZBT4nhW/XKWJdU/beA7Ml8Ln8Q1f5cQ
 t+YpnFdZg9ajZbQGXETHYMSq+KKAUqKhyDIc94lERsSyYb2eaX9i86zHLutTT6twEx7O
 ctfg==
X-Gm-Message-State: AOAM531bKFJtKxQUWxayUk5DdDO1JTmW6l9plZlKpSbUWoDzVeIoZdba
 uZSrVEoYGrAy+OUVmDScCI0=
X-Google-Smtp-Source: ABdhPJy7+IEKb9uzYTmTc5pViy/GvuWuhCq5qtrc08HdUt26qDDUsNUD/XGUmJoaUCOKu46EfQ8gsA==
X-Received: by 2002:a50:f299:: with SMTP id f25mr6660415edm.133.1607362955995; 
 Mon, 07 Dec 2020 09:42:35 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q4sm10802329ejc.78.2020.12.07.09.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 09:42:34 -0800 (PST)
Date: Mon, 7 Dec 2020 17:42:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 07/27] vhost: Route guest->host notification through
 qemu
Message-ID: <20201207174233.GN203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-8-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-8-eperezma@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Rob Miller <rob.miller@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Stephen Finucane <stephenfin@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jim Harford <jim.harford@broadcom.com>,
 Dmytro Kazantsev <dmytro.kazantsev@gmail.com>, Siwei Liu <loseweigh@gmail.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Michael Lilja <ml@napatech.com>,
 Max Gurtovoy <maxgu14@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============6022805275913316177=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6022805275913316177==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8MZM6zh5Bb05FW+3"
Content-Disposition: inline


--8MZM6zh5Bb05FW+3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:50:45PM +0100, Eugenio P=E9rez wrote:
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  hw/virtio/vhost-sw-lm-ring.h |  26 +++++++++
>  include/hw/virtio/vhost.h    |   3 ++
>  hw/virtio/vhost-sw-lm-ring.c |  60 +++++++++++++++++++++
>  hw/virtio/vhost.c            | 100 +++++++++++++++++++++++++++++++++--
>  hw/virtio/meson.build        |   2 +-
>  5 files changed, 187 insertions(+), 4 deletions(-)
>  create mode 100644 hw/virtio/vhost-sw-lm-ring.h
>  create mode 100644 hw/virtio/vhost-sw-lm-ring.c
>=20
> diff --git a/hw/virtio/vhost-sw-lm-ring.h b/hw/virtio/vhost-sw-lm-ring.h
> new file mode 100644
> index 0000000000..86dc081b93
> --- /dev/null
> +++ b/hw/virtio/vhost-sw-lm-ring.h
> @@ -0,0 +1,26 @@
> +/*
> + * vhost software live migration ring
> + *
> + * SPDX-FileCopyrightText: Red Hat, Inc. 2020
> + * SPDX-FileContributor: Author: Eugenio P=E9rez <eperezma@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef VHOST_SW_LM_RING_H
> +#define VHOST_SW_LM_RING_H
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/vhost.h"
> +
> +typedef struct VhostShadowVirtqueue VhostShadowVirtqueue;

Here it's called a shadow virtqueue while the file calls it a
sw-lm-ring. Please use a single name.

> +
> +bool vhost_vring_kick(VhostShadowVirtqueue *vq);

vhost_shadow_vq_kick()?

> +
> +VhostShadowVirtqueue *vhost_sw_lm_shadow_vq(struct vhost_dev *dev, int i=
dx);

vhost_dev_get_shadow_vq()? This could be in include/hw/virtio/vhost.h
with the other vhost_dev_*() functions.

> +
> +void vhost_sw_lm_shadow_vq_free(VhostShadowVirtqueue *vq);

Hmm...now I wonder what the lifecycle is. Does vhost_sw_lm_shadow_vq()
allocate it?

Please add doc comments explaining these functions either in this header
file or in vhost-sw-lm-ring.c.

> +
> +#endif
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index b5b7496537..93cc3f1ae3 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -54,6 +54,8 @@ struct vhost_iommu {
>      QLIST_ENTRY(vhost_iommu) iommu_next;
>  };
> =20
> +typedef struct VhostShadowVirtqueue VhostShadowVirtqueue;
> +
>  typedef struct VhostDevConfigOps {
>      /* Vhost device config space changed callback
>       */
> @@ -83,6 +85,7 @@ struct vhost_dev {
>      bool started;
>      bool log_enabled;
>      uint64_t log_size;
> +    VhostShadowVirtqueue *sw_lm_shadow_vq[2];

The hardcoded 2 is probably for single-queue virtio-net? I guess this
will eventually become VhostShadowVirtqueue *shadow_vqs or
VhostShadowVirtqueue **shadow_vqs, depending on whether each one should
be allocated individually.

>      VirtIOHandleOutput sw_lm_vq_handler;
>      Error *migration_blocker;
>      const VhostOps *vhost_ops;
> diff --git a/hw/virtio/vhost-sw-lm-ring.c b/hw/virtio/vhost-sw-lm-ring.c
> new file mode 100644
> index 0000000000..0192e77831
> --- /dev/null
> +++ b/hw/virtio/vhost-sw-lm-ring.c
> @@ -0,0 +1,60 @@
> +/*
> + * vhost software live migration ring
> + *
> + * SPDX-FileCopyrightText: Red Hat, Inc. 2020
> + * SPDX-FileContributor: Author: Eugenio P=E9rez <eperezma@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hw/virtio/vhost-sw-lm-ring.h"
> +#include "hw/virtio/vhost.h"
> +
> +#include "standard-headers/linux/vhost_types.h"
> +#include "standard-headers/linux/virtio_ring.h"
> +
> +#include "qemu/event_notifier.h"
> +
> +typedef struct VhostShadowVirtqueue {
> +    EventNotifier hdev_notifier;
> +    VirtQueue *vq;
> +} VhostShadowVirtqueue;
> +
> +static inline bool vhost_vring_should_kick(VhostShadowVirtqueue *vq)
> +{
> +    return virtio_queue_get_used_notify_split(vq->vq);
> +}
> +
> +bool vhost_vring_kick(VhostShadowVirtqueue *vq)
> +{
> +    return vhost_vring_should_kick(vq) ? event_notifier_set(&vq->hdev_no=
tifier)
> +                                       : true;
> +}

How is the return value used? event_notifier_set() returns -errno so
this function returns false on success, and true when notifications are
disabled or event_notifier_set() failed. I'm not sure this return value
can be used for anything.

> +
> +VhostShadowVirtqueue *vhost_sw_lm_shadow_vq(struct vhost_dev *dev, int i=
dx)

I see now that this function allocates the VhostShadowVirtqueue. Maybe
adding _new() to the name would make that clear?

> +{
> +    struct vhost_vring_file file =3D {
> +        .index =3D idx
> +    };
> +    VirtQueue *vq =3D virtio_get_queue(dev->vdev, idx);
> +    VhostShadowVirtqueue *svq;
> +    int r;
> +
> +    svq =3D g_new0(VhostShadowVirtqueue, 1);
> +    svq->vq =3D vq;
> +
> +    r =3D event_notifier_init(&svq->hdev_notifier, 0);
> +    assert(r =3D=3D 0);
> +
> +    file.fd =3D event_notifier_get_fd(&svq->hdev_notifier);
> +    r =3D dev->vhost_ops->vhost_set_vring_kick(dev, &file);
> +    assert(r =3D=3D 0);
> +
> +    return svq;
> +}

I guess there are assumptions about the status of the device? Does the
virtqueue need to be disabled when this function is called?

> +
> +void vhost_sw_lm_shadow_vq_free(VhostShadowVirtqueue *vq)
> +{
> +    event_notifier_cleanup(&vq->hdev_notifier);
> +    g_free(vq);
> +}
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 9cbd52a7f1..a55b684b5f 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -13,6 +13,8 @@
>   * GNU GPL, version 2 or (at your option) any later version.
>   */
> =20
> +#include "hw/virtio/vhost-sw-lm-ring.h"
> +
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/virtio/vhost.h"
> @@ -61,6 +63,20 @@ bool vhost_has_free_slot(void)
>      return slots_limit > used_memslots;
>  }
> =20
> +static struct vhost_dev *vhost_dev_from_virtio(const VirtIODevice *vdev)
> +{
> +    struct vhost_dev *hdev;
> +
> +    QLIST_FOREACH(hdev, &vhost_devices, entry) {
> +        if (hdev->vdev =3D=3D vdev) {
> +            return hdev;
> +        }
> +    }
> +
> +    assert(hdev);
> +    return NULL;
> +}
> +
>  static bool vhost_dev_can_log(const struct vhost_dev *hdev)
>  {
>      return hdev->features & (0x1ULL << VHOST_F_LOG_ALL);
> @@ -148,6 +164,12 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev =
*dev,
>      return 0;
>  }
> =20
> +static void vhost_log_sync_nop(MemoryListener *listener,
> +                               MemoryRegionSection *section)
> +{
> +    return;
> +}
> +
>  static void vhost_log_sync(MemoryListener *listener,
>                            MemoryRegionSection *section)
>  {
> @@ -928,6 +950,71 @@ static void vhost_log_global_stop(MemoryListener *li=
stener)
>      }
>  }
> =20
> +static void handle_sw_lm_vq(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    struct vhost_dev *hdev =3D vhost_dev_from_virtio(vdev);

If this lookup becomes a performance bottleneck there are other options
for determining the vhost_dev. For example VirtIODevice could have a
field for stashing the vhost_dev pointer.

> +    uint16_t idx =3D virtio_get_queue_index(vq);
> +
> +    VhostShadowVirtqueue *svq =3D hdev->sw_lm_shadow_vq[idx];
> +
> +    vhost_vring_kick(svq);
> +}

I'm a confused. Do we need to pop elements from vq and push equivalent
elements onto svq before kicking? Either a todo comment is missing or I
misunderstand how this works.

> +
> +static int vhost_sw_live_migration_stop(struct vhost_dev *dev)
> +{
> +    int idx;
> +
> +    vhost_dev_enable_notifiers(dev, dev->vdev);
> +    for (idx =3D 0; idx < dev->nvqs; ++idx) {
> +        vhost_sw_lm_shadow_vq_free(dev->sw_lm_shadow_vq[idx]);
> +    }
> +
> +    return 0;
> +}
> +
> +static int vhost_sw_live_migration_start(struct vhost_dev *dev)
> +{
> +    int idx;
> +
> +    for (idx =3D 0; idx < dev->nvqs; ++idx) {
> +        dev->sw_lm_shadow_vq[idx] =3D vhost_sw_lm_shadow_vq(dev, idx);
> +    }
> +
> +    vhost_dev_disable_notifiers(dev, dev->vdev);

There is a race condition if the guest kicks the vq while this is
happening. The shadow vq hdev_notifier needs to be set so the vhost
device checks the virtqueue for requests that slipped in during the
race window.

> +
> +    return 0;
> +}
> +
> +static int vhost_sw_live_migration_enable(struct vhost_dev *dev,
> +                                          bool enable_lm)
> +{
> +    if (enable_lm) {
> +        return vhost_sw_live_migration_start(dev);
> +    } else {
> +        return vhost_sw_live_migration_stop(dev);
> +    }
> +}
> +
> +static void vhost_sw_lm_global_start(MemoryListener *listener)
> +{
> +    int r;
> +
> +    r =3D vhost_migration_log(listener, true, vhost_sw_live_migration_en=
able);
> +    if (r < 0) {
> +        abort();
> +    }
> +}
> +
> +static void vhost_sw_lm_global_stop(MemoryListener *listener)
> +{
> +    int r;
> +
> +    r =3D vhost_migration_log(listener, false, vhost_sw_live_migration_e=
nable);
> +    if (r < 0) {
> +        abort();
> +    }
> +}
> +
>  static void vhost_log_start(MemoryListener *listener,
>                              MemoryRegionSection *section,
>                              int old, int new)
> @@ -1334,9 +1421,14 @@ int vhost_dev_init(struct vhost_dev *hdev, void *o=
paque,
>          .region_nop =3D vhost_region_addnop,
>          .log_start =3D vhost_log_start,
>          .log_stop =3D vhost_log_stop,
> -        .log_sync =3D vhost_log_sync,
> -        .log_global_start =3D vhost_log_global_start,
> -        .log_global_stop =3D vhost_log_global_stop,
> +        .log_sync =3D !vhost_dev_can_log(hdev) ?
> +                    vhost_log_sync_nop :
> +                    vhost_log_sync,

Why is this change necessary now? It's not clear to me why it was
previously okay to call vhost_log_sync().

> +        .log_global_start =3D !vhost_dev_can_log(hdev) ?
> +                            vhost_sw_lm_global_start :
> +                            vhost_log_global_start,
> +        .log_global_stop =3D !vhost_dev_can_log(hdev) ? vhost_sw_lm_glob=
al_stop :
> +                                                      vhost_log_global_s=
top,
>          .eventfd_add =3D vhost_eventfd_add,
>          .eventfd_del =3D vhost_eventfd_del,
>          .priority =3D 10
> @@ -1364,6 +1456,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>              error_free(hdev->migration_blocker);
>              goto fail_busyloop;
>          }
> +    } else {
> +        hdev->sw_lm_vq_handler =3D handle_sw_lm_vq;
>      }
> =20
>      hdev->mem =3D g_malloc0(offsetof(struct vhost_memory, regions));
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index fbff9bc9d4..17419cb13e 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -11,7 +11,7 @@ softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhos=
t-stub.c'))
> =20
>  virtio_ss =3D ss.source_set()
>  virtio_ss.add(files('virtio.c'))
> -virtio_ss.add(when: 'CONFIG_VHOST', if_true: files('vhost.c', 'vhost-bac=
kend.c'))
> +virtio_ss.add(when: 'CONFIG_VHOST', if_true: files('vhost.c', 'vhost-bac=
kend.c', 'vhost-sw-lm-ring.c'))
>  virtio_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user.c'))
>  virtio_ss.add(when: 'CONFIG_VHOST_VDPA', if_true: files('vhost-vdpa.c'))
>  virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-ball=
oon.c'))
> --=20
> 2.18.4
>=20

--8MZM6zh5Bb05FW+3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/OaYkACgkQnKSrs4Gr
c8iEswf/etvUvTrUil9p4TKYwAwjQvB7prmFUDbZsEbaAxQ86BKvb7Yfnh2rlCSM
c7vW5iFraTfx99tpn8E5OtWUGQu4Gr9eWOBt7sCPo2mv7+HnL3kwNrAPKo8Qv3JN
n149BZ9+rVcyENSo33LlveV0tp31hGZg+lVvjxq8b5pYJN9ACYh5fosDfW8l8wkN
ha6nTL90z0GpfPuXderOpMhm9aTFpM/3QS8CcweC/VEMG+ThrMbSVHMRSQdP4sVa
DOkYpMh1gY1oaDLy0LXMcU5YzD8QbB3oT9BhhPjjt1qNdwWGYwWVXsoQ0Nl5RM0w
LVKr8Uh2aFycabSOVLUsjBqa2RSSFg==
=OGl0
-----END PGP SIGNATURE-----

--8MZM6zh5Bb05FW+3--

--===============6022805275913316177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6022805275913316177==--
