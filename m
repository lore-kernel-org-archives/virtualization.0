Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C117C9
	for <virtualization@lists.linux.dev>; Sun,  7 Apr 2024 03:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712460888; cv=none; b=CJsB+sqvL7jCsGxnmTklp+q0+2xYnlzGgpLFDOTjuBHXRH+oeOQh+EiFJOuJe4ygXDIi9eWntKld+7E8qka3PA8lI96vABGPJc/+yvlOZbVowX0UBzZUViYM4lJ/tswmO0fBlQM7+SWFvbfCP2ig0wq5kfP8B3Cuqw1R4mDD+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712460888; c=relaxed/simple;
	bh=QB8fzGs3s/BrHM+Zx5526LiPYDv6MVJabwHsqS0e0s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwX66C3jax/p0Oc9u7S/kfIWHjRrcUV+C8BiS6G/ji+wFuorgpTFBXSLvopL29lYCj+LsKyKMJnRlGyrkgqVOTQRT1yfYIINyUtrN6BCX2n9kf5ZFF4AwmBmgTfg7hkW7Pu7cGXVukJD/QuIqTvguWzkZW8MyZz9EzmVbDCEiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8MjaSD5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8MjaSD5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712460883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LewurHliKfyRtmK2eu/pZnWRXkNeSn646z3zi0yY9Qo=;
	b=B8MjaSD5FB/5s1Agm+PNZJQxtkRDthrj4JgAPAyvQ7CBbgEdhmCPLpP7nZfmm9VGM3DG90
	qd1qxZpcgWKUKuI2nys4CRRwf4bjVz5CfjppRWcUJJcH2xJyXh+PsJya/xD/uY2yv36Pgo
	Ger1N6kYoSQBJFCLySopb+dEzE4ztAg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-ZuTWTBgjNvu-qXtbUZuE7g-1; Sat, 06 Apr 2024 23:34:42 -0400
X-MC-Unique: ZuTWTBgjNvu-qXtbUZuE7g-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d8bcf739e5so2986382a12.1
        for <virtualization@lists.linux.dev>; Sat, 06 Apr 2024 20:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712460881; x=1713065681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LewurHliKfyRtmK2eu/pZnWRXkNeSn646z3zi0yY9Qo=;
        b=TPwzymFhi9ojCom4hy673t32gGKvdF/mYp7PiC+8tnjTqEW7BsjwG7dw0Zlx3XLN0s
         FXQPigBVKGmGT+OlslP03S7JgkqHZx92yY2MDddgj4Gf8m054OGEbCZzGOujDtq6uG8q
         XLPDwFylrCzNR+dzRr4M1IpmkBuCNtwS81lITby7HQeSW6SX43j+B34YBAsHRdunAudR
         kOedOmdtIuU/T2boto2R+j3zIvabiCEhjDtuusqIanUfpeG0QFPJpVvPwhfoJFtFbtmT
         kLP+sgGm4WXB1ClSWzsSYTvOOR5c66j85NnEWnMYoNsuifapqL/xqgrUoTXmaxq1jgeP
         b/qw==
X-Gm-Message-State: AOJu0YxV+b7rYqwXHfqz5lNgfos3mYRCVHd8zYiKd96yloTHHD/z8+ZV
	qQ9HGQ3BD9TCH3CevalQ1Oem0i2ou4SH3MjZJyIADTV0Qv1AapuA29GfEV1TQ5UAdCvTaL2E3DD
	TPQ7s0YvqUZ9MID0gQ3glJNJYk84Yv8i56f5b0ErRQmEq225MXCs0FhI00dvCee86PnNKsGdy2x
	fUGINQVYGOCavFHz4zm4EFEcIJdlFOnx+87dBV1Is=
X-Received: by 2002:a05:6a21:a586:b0:1a7:5c8b:da4b with SMTP id gd6-20020a056a21a58600b001a75c8bda4bmr393932pzc.7.1712460880687;
        Sat, 06 Apr 2024 20:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgiILbdpkz53LEg/sJP6zZmDSUa+7KLRwISw/cC/+Xjpy89/E8JsXfTyKVK8d+Z1SaytuUsDBXbf7n8kzQIGE=
X-Received: by 2002:a05:6a21:a586:b0:1a7:5c8b:da4b with SMTP id
 gd6-20020a056a21a58600b001a75c8bda4bmr393921pzc.7.1712460880173; Sat, 06 Apr
 2024 20:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327112136.2897479-1-schalla@marvell.com> <CACGkMEuKhKOtqYUk4Sbv1QmVSuo3AJ1-tX13ZZxdbPmSSNYk9Q@mail.gmail.com>
 <DS0PR18MB53686F5F53AF5D26B7CE37B6A03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
In-Reply-To: <DS0PR18MB53686F5F53AF5D26B7CE37B6A03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 7 Apr 2024 11:34:28 +0800
Message-ID: <CACGkMEuAEsApX0ZT=FWVgtvYwpAVhzQGh_1yrUaN5f8A8K7iCw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
To: Srujana Challa <schalla@marvell.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "mst@redhat.com" <mst@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Vamsi Krishna Attunuru <vattunuru@marvell.com>, 
	Shijith Thotton <sthotton@marvell.com>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
	Jerin Jacob <jerinj@marvell.com>, eperezma <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 8:34=E2=80=AFPM Srujana Challa <schalla@marvell.com=
> wrote:
>
> > Subject: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell O=
CTEON
> > DPU devices
> >
> > Prioritize security for external emails: Confirm sender and content saf=
ety
> > before clicking links or opening attachments
> >
> > ----------------------------------------------------------------------
> > On Wed, Mar 27, 2024 at 7:22=E2=80=AFPM Srujana Challa <schalla@marvell=
.com>
> > wrote:
> > >
> > > This commit introduces a new vDPA driver specifically designed for
> > > managing the virtio control plane over the vDPA bus for OCTEON DPU
> > > devices. The driver consists of two layers:
> > >
> > > 1. Octep HW Layer (Octeon Endpoint): Responsible for handling hardwar=
e
> > > operations and configurations related to the DPU device.
> > >
> > > 2. Octep Main Layer: Compliant with the vDPA bus framework, this laye=
r
> > > implements device operations for the vDPA bus. It handles device
> > > probing, bus attachment, vring operations, and other relevant tasks.
> > >
> > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> > > Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> > > Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> > > ---
> > >  MAINTAINERS                              |   5 +
> > >  drivers/vdpa/Kconfig                     |   9 +
> > >  drivers/vdpa/Makefile                    |   1 +
> > >  drivers/vdpa/octeon_ep/Makefile          |   4 +
> > >  drivers/vdpa/octeon_ep/octep_vdpa.h      |  93 +++
> > >  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 457 ++++++++++++
> > >  drivers/vdpa/octeon_ep/octep_vdpa_main.c | 903
> > +++++++++++++++++++++++
> > >  7 files changed, 1472 insertions(+)
> > >  create mode 100644 drivers/vdpa/octeon_ep/Makefile
> > >  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa.h
> > >  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > >  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index cfe44a876d8a..539ce209a960 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -13127,6 +13127,11 @@ S:     Supported
> > >  F:     Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yam=
l
> > >  F:     drivers/mmc/host/sdhci-xenon*
> > >
> > > +MARVELL OCTEON ENDPOINT VIRTIO DATA PATH ACCELERATOR
> > > +R:     schalla@marvell.com
> > > +R:     vattunuru@marvell.com
> > > +F:     drivers/vdpa/octeon_ep/
> > > +
> > >  MATROX FRAMEBUFFER DRIVER
> > >  L:     linux-fbdev@vger.kernel.org
> > >  S:     Orphan
> > > diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> > > index 656c1cb541de..775149fad476 100644
> > > --- a/drivers/vdpa/Kconfig
> > > +++ b/drivers/vdpa/Kconfig
> > > @@ -126,4 +126,13 @@ config PDS_VDPA
> > >           With this driver, the VirtIO dataplane can be
> > >           offloaded to an AMD/Pensando DSC device.
> > >
> > > +config OCTEONEP_VDPA
> > > +       tristate "vDPA driver for Octeon DPU devices"
> > > +       depends on m
> > > +       depends on PCI_MSI
> > > +       help
> > > +         vDPA driver for Marvell's Octeon DPU devices.
> > > +         With this driver, the VirtIO dataplane can be
> > > +         offloaded to a Octeon DPU device.
> > > +
> > >  endif # VDPA
> > > diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
> > > index 8f53c6f3cca7..5654d36707af 100644
> > > --- a/drivers/vdpa/Makefile
> > > +++ b/drivers/vdpa/Makefile
> > > @@ -8,3 +8,4 @@ obj-$(CONFIG_VP_VDPA)    +=3D virtio_pci/
> > >  obj-$(CONFIG_ALIBABA_ENI_VDPA) +=3D alibaba/
> > >  obj-$(CONFIG_SNET_VDPA) +=3D solidrun/
> > >  obj-$(CONFIG_PDS_VDPA) +=3D pds/
> > > +obj-$(CONFIG_OCTEONEP_VDPA) +=3D octeon_ep/
> > > diff --git a/drivers/vdpa/octeon_ep/Makefile
> > b/drivers/vdpa/octeon_ep/Makefile
> > > new file mode 100644
> > > index 000000000000..e23e2ff14f33
> > > --- /dev/null
> > > +++ b/drivers/vdpa/octeon_ep/Makefile
> > > @@ -0,0 +1,4 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +obj-$(CONFIG_OCTEONEP_VDPA) +=3D octep_vdpa.o
> > > +octep_vdpa-$(CONFIG_OCTEONEP_VDPA) +=3D octep_vdpa_main.o
> > > +octep_vdpa-$(CONFIG_OCTEONEP_VDPA) +=3D octep_vdpa_hw.o
> > > diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h
> > b/drivers/vdpa/octeon_ep/octep_vdpa.h
> > > new file mode 100644
> > > index 000000000000..60d2efc8f8b8
> > > --- /dev/null
> > > +++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
> > > @@ -0,0 +1,93 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only
> > > + * Copyright (C) 2024 Marvell.
> > > + */
> > > +#ifndef __OCTEP_VDPA_H__
> > > +#define __OCTEP_VDPA_H__
> > > +
> > > +#include <linux/pci.h>
> > > +#include <linux/pci_regs.h>
> > > +#include <linux/vdpa.h>
> > > +#include <linux/virtio_pci_modern.h>
> > > +#include <uapi/linux/virtio_net.h>
> > > +#include <uapi/linux/virtio_blk.h>
> > > +#include <uapi/linux/virtio_config.h>
> > > +#include <uapi/linux/virtio_pci.h>
> > > +#include <uapi/linux/vdpa.h>
> > > +
> > > +#define OCTEP_VDPA_DEVID_CN106K_PF 0xb900
> > > +#define OCTEP_VDPA_DEVID_CN106K_VF 0xb903
> > > +#define OCTEP_VDPA_DEVID_CN105K_PF 0xba00
> > > +#define OCTEP_VDPA_DEVID_CN105K_VF 0xba03
> > > +#define OCTEP_VDPA_DEVID_CN103K_PF 0xbd00
> > > +#define OCTEP_VDPA_DEVID_CN103K_VF 0xbd03
> > > +
> > > +#define OCTEP_HW_MBOX_BAR 0
> > > +#define OCTEP_HW_CAPS_BAR 4
> > > +
> > > +#define OCTEP_DEV_READY_SIGNATURE 0xBABABABA
> > > +
> > > +#define OCTEP_EPF_RINFO(x) (0x000209f0 | ((x) << 25))
> > > +#define OCTEP_VF_MBOX_DATA(x) (0x00010210 | ((x) << 17))
> > > +#define OCTEP_PF_MBOX_DATA(x) (0x00022000 | ((x) << 4))
> > > +
> > > +#define OCTEP_EPF_RINFO_RPVF(val) (((val) >> 32) & 0xF)
> > > +#define OCTEP_EPF_RINFO_NVFS(val) (((val) >> 48) & 0x7F)
> > > +
> > > +#define OCTEP_FW_READY_SIGNATURE0  0xFEEDFEED
> > > +#define OCTEP_FW_READY_SIGNATURE1  0x3355ffaa
> > > +
> > > +enum octep_vdpa_dev_status {
> > > +       OCTEP_VDPA_DEV_STATUS_INVALID,
> > > +       OCTEP_VDPA_DEV_STATUS_ALLOC,
> > > +       OCTEP_VDPA_DEV_STATUS_WAIT_FOR_BAR_INIT,
> > > +       OCTEP_VDPA_DEV_STATUS_INIT,
> > > +       OCTEP_VDPA_DEV_STATUS_READY,
> > > +       OCTEP_VDPA_DEV_STATUS_UNINIT
> > > +};
> > > +
> > > +struct octep_vring_info {
> > > +       struct vdpa_callback cb;
> > > +       void __iomem *notify_addr;
> > > +       u32 __iomem *cb_notify_addr;
> > > +       phys_addr_t notify_pa;
> > > +       char msix_name[256];
> > > +};
> > > +
> > > +struct octep_hw {
> > > +       struct pci_dev *pdev;
> > > +       u8 __iomem *base[PCI_STD_NUM_BARS];
> > > +       struct virtio_pci_common_cfg __iomem *common_cfg;
> >
> > This is a hint that any chance we can reuse the modern virtio-pci
> > library (virtio_pci_modern_dev.c) instead of duplicating codes?
> Yes, the modern pci library would be a great help but in current
> Octeon DPU device, the virtio config space completely emulated
> by the device's firmware. So, the standard pci config read apis can't
> be used for probing the virtio configuration. Hence, it's not possible to
> use vp_modern_probe() here.

I see, please add a comment somewhere for this.

>
> >
> > > +       u8 __iomem *dev_cfg;
> > > +       u8 __iomem *isr;
> > > +       void __iomem *notify_base;
> > > +       phys_addr_t notify_base_pa;
> > > +       u32 notify_off_multiplier;
> > > +       u8 notify_bar;
> > > +       struct octep_vring_info *vqs;
> > > +       struct vdpa_callback config_cb;
> > > +       u64 features;
> > > +       u64 drv_features;
> > > +       u16 nr_vring;
> > > +       u32 config_size;
> > > +       int irq;
> > > +};
> > > +
> > > +u8 octep_hw_get_status(struct octep_hw *oct_hw);
> > > +void octep_hw_set_status(struct octep_hw *dev, uint8_t status);
> > > +void octep_hw_reset(struct octep_hw *oct_hw);
> > > +void octep_write_queue_select(u16 queue_id, struct octep_hw *oct_hw)=
;
> > > +void octep_notify_queue(struct octep_hw *oct_hw, u16 qid);
> > > +void octep_read_dev_config(struct octep_hw *oct_hw, u64 offset, void
> > *dst, int length);
> > > +int octep_set_vq_address(struct octep_hw *oct_hw, u16 qid, u64
> > desc_area, u64 driver_area,
> > > +                        u64 device_area);
> > > +void octep_set_vq_num(struct octep_hw *oct_hw, u16 qid, u32 num);
> > > +void octep_set_vq_ready(struct octep_hw *oct_hw, u16 qid, bool ready=
);
> > > +bool octep_get_vq_ready(struct octep_hw *oct_hw, u16 qid);
> > > +int octep_set_vq_state(struct octep_hw *oct_hw, u16 qid, const struc=
t
> > vdpa_vq_state *state);
> > > +int octep_get_vq_state(struct octep_hw *oct_hw, u16 qid, struct
> > vdpa_vq_state *state);
> > > +u16 octep_get_vq_size(struct octep_hw *oct_hw);
> > > +int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev=
);
> > > +u64 octep_hw_get_dev_features(struct octep_hw *oct_hw);
> > > +void octep_hw_set_drv_features(struct octep_hw *oct_hw, u64 features=
);
> > > +
> > > +#endif /* __OCTEP_VDPA_H__ */
> > > diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > > new file mode 100644
> > > index 000000000000..0a2f1d09c4ab
> > > --- /dev/null
> > > +++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > > @@ -0,0 +1,457 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (C) 2024 Marvell. */
> > > +
> > > +#include <linux/iopoll.h>
> > > +
> > > +#include "octep_vdpa.h"
> > > +
> > > +enum octep_mbox_ids {
> > > +       OCTEP_MBOX_MSG_SET_VQ_STATE =3D 1,
> > > +       OCTEP_MBOX_MSG_GET_VQ_STATE,
> > > +};
> > > +
> > > +#define OCTEP_HW_TIMEOUT       10000000
> > > +
> > > +#define MBOX_OFFSET            64
> > > +#define MBOX_RSP_MASK          0x00000001
> > > +#define MBOX_RC_MASK           0x0000FFFE
> > > +
> > > +#define MBOX_RSP_TO_ERR(val)   (-(((val) & MBOX_RC_MASK) >> 2))
> > > +#define MBOX_AVAIL(val)        (((val) & MBOX_RSP_MASK))
> > > +#define MBOX_RSP(val)          ((val) & (MBOX_RC_MASK |
> > MBOX_RSP_MASK))
> > > +
> > > +struct octep_mbox_hdr {
> > > +       u8 ver;
> > > +       u8 rsvd1;
> > > +       u16 id;
> > > +       u16 rsvd2;
> > > +#define MBOX_REQ_SIG (0xdead)
> > > +#define MBOX_RSP_SIG (0xbeef)
> > > +       u16 sig;
> > > +};
> > > +
> > > +struct octep_mbox_sts {
> > > +       u16 rsp:1;
> > > +       u16 rc:15;
> > > +       u16 rsvd;
> > > +};
> > > +
> > > +struct octep_mbox {
> > > +       struct octep_mbox_hdr hdr;
> > > +       struct octep_mbox_sts sts;
> > > +       u64 rsvd;
> > > +       u32 data[];
> > > +};
> > > +
> > > +static inline struct octep_mbox __iomem *octep_get_mbox(struct
> > octep_hw *oct_hw)
> > > +{
> > > +       return (struct octep_mbox __iomem *)(oct_hw->dev_cfg +
> > MBOX_OFFSET);
> > > +}
> > > +
> > > +static inline int octep_wait_for_mbox_avail(struct octep_mbox __iome=
m
> > *mbox)
> > > +{
> > > +       u32 val;
> > > +
> > > +       return readx_poll_timeout(ioread32, &mbox->sts, val,
> > MBOX_AVAIL(val), 10,
> > > +                                 OCTEP_HW_TIMEOUT);
> > > +}
> > > +
> > > +static inline int octep_wait_for_mbox_rsp(struct octep_mbox __iomem
> > *mbox)
> > > +{
> > > +       u32 val;
> > > +
> > > +       return readx_poll_timeout(ioread32, &mbox->sts, val, MBOX_RSP=
(val),
> > 10,
> > > +                                 OCTEP_HW_TIMEOUT);
> > > +}
> > > +
> > > +static inline void octep_write_hdr(struct octep_mbox __iomem *mbox, =
u16
> > id, u16 sig)
> > > +{
> > > +       iowrite16(id, &mbox->hdr.id);
> > > +       iowrite16(sig, &mbox->hdr.sig);
> > > +}
> > > +
> > > +static inline u32 octep_read_sig(struct octep_mbox __iomem *mbox)
> > > +{
> > > +       return ioread16(&mbox->hdr.sig);
> > > +}
> > > +
> > > +static inline void octep_write_sts(struct octep_mbox __iomem *mbox, =
u32
> > sts)
> > > +{
> > > +       iowrite32(sts, &mbox->sts);
> > > +}
> > > +
> > > +static inline u32 octep_read_sts(struct octep_mbox __iomem *mbox)
> > > +{
> > > +       return ioread32(&mbox->sts);
> > > +}
> > > +
> > > +static inline u32 octep_read32_word(struct octep_mbox __iomem *mbox,
> > u16 word_idx)
> > > +{
> > > +       return ioread32(&mbox->data[word_idx]);
> > > +}
> > > +
> > > +static inline void octep_write32_word(struct octep_mbox __iomem *mbo=
x,
> > u16 word_idx, u32 word)
> > > +{
> > > +       return iowrite32(word, &mbox->data[word_idx]);
> > > +}
> > > +
> > > +static int octep_process_mbox(struct octep_hw *oct_hw, u16 id, u16 q=
id,
> > void *buffer,
> > > +                             u32 buf_size, bool write)
> > > +{
> > > +       struct octep_mbox __iomem *mbox =3D octep_get_mbox(oct_hw);
> > > +       struct pci_dev *pdev =3D oct_hw->pdev;
> > > +       u32 *p =3D (u32 *)buffer;
> > > +       u16 data_wds;
> > > +       int ret, i;
> > > +       u32 val;
> > > +
> > > +       if (!IS_ALIGNED(buf_size, 4))
> > > +               return -EINVAL;
> > > +
> > > +       /* Make sure mbox space is available */
> > > +       ret =3D octep_wait_for_mbox_avail(mbox);
> > > +       if (ret) {
> > > +               dev_warn(&pdev->dev, "Timeout waiting for previous mb=
ox data to
> > be consumed\n");
> > > +               return ret;
> > > +       }
> > > +       data_wds =3D buf_size / 4;
> > > +
> > > +       if (write) {
> > > +               for (i =3D 1; i <=3D data_wds; i++) {
> > > +                       octep_write32_word(mbox, i, *p);
> > > +                       p++;
> > > +               }
> > > +       }
> > > +       octep_write32_word(mbox, 0, (u32)qid);
> > > +       octep_write_sts(mbox, 0);
> > > +
> > > +       octep_write_hdr(mbox, id, MBOX_REQ_SIG);
> > > +
> > > +       ret =3D octep_wait_for_mbox_rsp(mbox);
> > > +       if (ret) {
> > > +               dev_warn(&pdev->dev, "Timeout waiting for mbox : %d
> > response\n", id);
> > > +               return ret;
> > > +       }
> > > +
> > > +       val =3D octep_read_sig(mbox);
> > > +       if ((val & 0xFFFF) !=3D MBOX_RSP_SIG) {
> > > +               dev_warn(&pdev->dev, "Invalid Signature from mbox : %=
d
> > response\n", id);
> > > +               return ret;
> > > +       }
> > > +
> > > +       val =3D octep_read_sts(mbox);
> > > +       if (val & MBOX_RC_MASK) {
> > > +               ret =3D MBOX_RSP_TO_ERR(val);
> > > +               dev_warn(&pdev->dev, "Error while processing mbox : %=
d, err
> > %d\n", id, ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       if (!write)
> > > +               for (i =3D 1; i <=3D data_wds; i++)
> > > +                       *p++ =3D octep_read32_word(mbox, i);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void octep_mbox_init(struct octep_mbox __iomem *mbox)
> > > +{
> > > +       iowrite32(1, &mbox->sts);
> > > +}
> > > +
> > > +u8 octep_hw_get_status(struct octep_hw *oct_hw)
> > > +{
> > > +       return ioread8(&oct_hw->common_cfg->device_status);
> > > +}
> > > +
> > > +void octep_hw_set_status(struct octep_hw *oct_hw, u8 status)
> > > +{
> > > +       iowrite8(status, &oct_hw->common_cfg->device_status);
> > > +}
> > > +
> > > +void octep_hw_reset(struct octep_hw *oct_hw)
> > > +{
> > > +       u8 val;
> > > +
> > > +       octep_hw_set_status(oct_hw, 0 | BIT(7));
> >
> > Could we have macros for the magic numbers like 7 and 15 below?
> Sure, will add proper macros in next version.
>
> >
> > > +       if (readx_poll_timeout(ioread8, &oct_hw->common_cfg-
> > >device_status, val, !val, 10,
> > > +                              OCTEP_HW_TIMEOUT)) {
> > > +               dev_warn(&oct_hw->pdev->dev, "Octeon device reset tim=
eout\n");
> > > +               return;
> > > +       }
> > > +}
> > > +
> > > +u64 octep_hw_get_dev_features(struct octep_hw *oct_hw)
> > > +{
> > > +       u32 features_lo, features_hi;
> > > +       u32 val, select;
> > > +
> > > +       select =3D 0;
> > > +       iowrite32(select | BIT(15), &oct_hw->common_cfg-
> > >device_feature_select);
> >
> > Ok I see something different with virtio. For any "select" it seems to
> > require BIT(15).
> >
> > > +
> > > +       if (readx_poll_timeout(ioread32, &oct_hw->common_cfg-
> > >device_feature_select, val,
> > > +                              val =3D=3D select, 10, OCTEP_HW_TIMEOU=
T)) {
> > > +               dev_warn(&oct_hw->pdev->dev, "Feature select%d write
> > timeout\n", select);
> > > +               return 0ULL;
> > > +       }
> > > +       features_lo =3D ioread32(&oct_hw->common_cfg->device_feature)=
;
> > > +
> > > +       select =3D 1;
> > > +       iowrite32(select | BIT(15), &oct_hw->common_cfg-
> > >device_feature_select);
> > > +
> > > +       if (readx_poll_timeout(ioread32, &oct_hw->common_cfg-
> > >device_feature_select, val,
> > > +                              val =3D=3D select, 10, OCTEP_HW_TIMEOU=
T)) {
> > > +               dev_warn(&oct_hw->pdev->dev, "Feature select%d write
> > timeout\n", select);
> > > +               return 0ULL;
> > > +       }
> > > +       features_hi =3D ioread32(&oct_hw->common_cfg->device_feature)=
;
> > > +
> > > +       return ((u64)features_hi << 32) | features_lo;
> > > +}
> > > +
> > > +void octep_hw_set_drv_features(struct octep_hw *oct_hw, u64 features=
)
> > > +{
> > > +       u32 val, select;
> > > +
> > > +       select =3D 0;
> > > +       iowrite32(select | BIT(15), &oct_hw->common_cfg-
> > >guest_feature_select);
> > > +
> > > +       if (readx_poll_timeout(ioread32, &oct_hw->common_cfg-
> > >guest_feature_select, val,
> > > +                              val =3D=3D select, 10, OCTEP_HW_TIMEOU=
T)) {
> > > +               dev_warn(&oct_hw->pdev->dev, "Feature select%d write
> > timeout\n", select);
> > > +               return;
> > > +       }
> >
> > Could we introduce a helper for such write and readback && timeout
> > logic? It seems it is used in a lot of places.
> Sure, I will move repetitive ones(ioread32/iowrite32) to helper function.
>
> >
> > > +       iowrite32(features & (BIT_ULL(32) - 1), &oct_hw->common_cfg-
> > >guest_feature);
> > > +
> > > +       select =3D 1;
> > > +       iowrite32(select | BIT(15), &oct_hw->common_cfg-
> > >guest_feature_select);
> > > +
> > > +       if (readx_poll_timeout(ioread32, &oct_hw->common_cfg-
> > >guest_feature_select, val,
> > > +                              val =3D=3D select, 10, OCTEP_HW_TIMEOU=
T)) {
> > > +               dev_warn(&oct_hw->pdev->dev, "Feature select%d write
> > timeout\n", select);
> > > +               return;
> > > +       }
> > > +       iowrite32(features >> 32, &oct_hw->common_cfg->guest_feature)=
;
> > > +}
> > > +
> > > +void octep_write_queue_select(u16 queue_id, struct octep_hw *oct_hw)
> > > +{
> > > +       u16 val;
> > > +
> > > +       iowrite16(queue_id | BIT(15), &oct_hw->common_cfg->queue_sele=
ct);
> > > +
> > > +       if (readx_poll_timeout(ioread16, &oct_hw->common_cfg-
> > >queue_select, val, val =3D=3D queue_id,
> > > +                              10, OCTEP_HW_TIMEOUT)) {
> > > +               dev_warn(&oct_hw->pdev->dev, "Queue select write time=
out\n");
> > > +               return;
> > > +       }
> > > +}
> > > +
> > > +void octep_notify_queue(struct octep_hw *oct_hw, u16 qid)
> > > +{
> > > +       iowrite16(qid, oct_hw->vqs[qid].notify_addr);
> > > +}
> > > +
> > > +void octep_read_dev_config(struct octep_hw *oct_hw, u64 offset, void
> > *dst, int length)
> > > +{
> > > +       u8 old_gen, new_gen, *p;
> > > +       int i;
> > > +
> > > +       WARN_ON(offset + length > oct_hw->config_size);
> > > +       do {
> > > +               old_gen =3D ioread8(&oct_hw->common_cfg->config_gener=
ation);
> > > +               p =3D dst;
> > > +               for (i =3D 0; i < length; i++)
> > > +                       *p++ =3D ioread8(oct_hw->dev_cfg + offset + i=
);
> > > +
> > > +               new_gen =3D ioread8(&oct_hw->common_cfg->config_gener=
ation);
> > > +       } while (old_gen !=3D new_gen);
> > > +}
> >
> > This looks similar to vp_vdpa_get_config(), any chance to unify them?
> It might not be workout as we can't use vp_modern_probe().
>
> >
> > > +
> > > +int octep_set_vq_address(struct octep_hw *oct_hw, u16 qid, u64
> > desc_area, u64 driver_area,
> > > +                        u64 device_area)
> > > +{
> > > +       struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_=
cfg;
> > > +
> > > +       octep_write_queue_select(qid, oct_hw);
> > > +       vp_iowrite64_twopart(desc_area, &cfg->queue_desc_lo,
> > > +                            &cfg->queue_desc_hi);
> > > +       vp_iowrite64_twopart(driver_area, &cfg->queue_avail_lo,
> > > +                            &cfg->queue_avail_hi);
> > > +       vp_iowrite64_twopart(device_area, &cfg->queue_used_lo,
> > > +                            &cfg->queue_used_hi);
> >
> > It's kind of interesting that there's no read back for validation here.
> Read back validation is not required for these writes. Firmware takes car=
e of it.

Ok.

>
> >
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +int octep_get_vq_state(struct octep_hw *oct_hw, u16 qid, struct
> > vdpa_vq_state *state)
> > > +{
> > > +       return octep_process_mbox(oct_hw,
> > OCTEP_MBOX_MSG_GET_VQ_STATE, qid, state,
> > > +                                 sizeof(*state), 0);
> > > +}
> > > +
> > > +int octep_set_vq_state(struct octep_hw *oct_hw, u16 qid, const struc=
t
> > vdpa_vq_state *state)
> > > +{
> > > +       struct vdpa_vq_state q_state;
> > > +
> > > +       memcpy(&q_state, state, sizeof(struct vdpa_vq_state));
> > > +       return octep_process_mbox(oct_hw,
> > OCTEP_MBOX_MSG_SET_VQ_STATE, qid, &q_state,
> > > +                                 sizeof(*state), 1);
> > > +}
> > > +
> > > +void octep_set_vq_num(struct octep_hw *oct_hw, u16 qid, u32 num)
> > > +{
> > > +       struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_=
cfg;
> > > +
> > > +       octep_write_queue_select(qid, oct_hw);
> > > +       iowrite16(num, &cfg->queue_size);
> > > +}
> > > +
> > > +void octep_set_vq_ready(struct octep_hw *oct_hw, u16 qid, bool ready=
)
> > > +{
> > > +       struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_=
cfg;
> > > +
> > > +       octep_write_queue_select(qid, oct_hw);
> > > +       iowrite16(ready, &cfg->queue_enable);
> > > +}
> > > +
> > > +bool octep_get_vq_ready(struct octep_hw *oct_hw, u16 qid)
> > > +{
> > > +       struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_=
cfg;
> > > +
> > > +       octep_write_queue_select(qid, oct_hw);
> > > +       return ioread16(&cfg->queue_enable);
> > > +}
> > > +
> > > +u16 octep_get_vq_size(struct octep_hw *oct_hw)
> > > +{
> > > +       octep_write_queue_select(0, oct_hw);
> > > +       return ioread16(&oct_hw->common_cfg->queue_size);
> > > +}
> > > +
> > > +static u32 octep_get_config_size(struct octep_hw *oct_hw)
> > > +{
> > > +       return sizeof(struct virtio_net_config);
> > > +}
> > > +
> > > +static void __iomem *get_cap_addr(struct octep_hw *oct_hw, struct
> > virtio_pci_cap *cap)
> > > +{
> > > +       struct device *dev =3D &oct_hw->pdev->dev;
> > > +       u32 length =3D cap->length;
> > > +       u32 offset =3D cap->offset;
> > > +       u8  bar    =3D cap->bar;
> > > +       u32 len;
> > > +
> > > +       if (bar !=3D OCTEP_HW_CAPS_BAR) {
> > > +               dev_err(dev, "Invalid bar: %u\n", bar);
> > > +               return NULL;
> > > +       }
> > > +       if (offset + length < offset) {
> > > +               dev_err(dev, "offset(%u) + length(%u) overflows\n",
> > > +                       offset, length);
> > > +               return NULL;
> > > +       }
> > > +       len =3D pci_resource_len(oct_hw->pdev, bar);
> > > +       if (offset + length > len) {
> > > +               dev_err(dev, "invalid cap: overflows bar space: %u > =
%u\n",
> > > +                       offset + length, len);
> > > +               return NULL;
> > > +       }
> > > +       return oct_hw->base[bar] + offset;
> > > +}
> > > +
> > > +static void pci_caps_read(struct octep_hw *oct_hw, void *buf, size_t=
 len,
> > off_t offset)
> > > +{
> > > +       u8 __iomem *bar =3D oct_hw->base[OCTEP_HW_CAPS_BAR];
> > > +       u8 *p =3D buf;
> > > +       size_t i;
> > > +
> > > +       for (i =3D 0; i < len; i++)
> > > +               *p++ =3D ioread8(bar + offset + i);
> > > +}
> > > +
> > > +static int pci_signature_verify(struct octep_hw *oct_hw)
> > > +{
> > > +       u32 signature[2];
> > > +
> > > +       pci_caps_read(oct_hw, &signature, sizeof(signature), 0);
> > > +
> > > +       if (signature[0] !=3D OCTEP_FW_READY_SIGNATURE0)
> > > +               return -1;
> > > +
> > > +       if (signature[1] !=3D OCTEP_FW_READY_SIGNATURE1)
> > > +               return -1;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev=
)
> > > +{
> > > +       struct octep_mbox __iomem *mbox;
> > > +       struct device *dev =3D &pdev->dev;
> > > +       struct virtio_pci_cap cap;
> > > +       int ret;
> > > +       u8 pos;
> > > +
> > > +       oct_hw->pdev =3D pdev;
> > > +       ret =3D pci_signature_verify(oct_hw);
> > > +       if (ret) {
> > > +               dev_err(dev, "Octeon Virtio FW is not initialized\n")=
;
> > > +               return -EIO;
> > > +       }
> > > +
> > > +       pci_caps_read(oct_hw, &pos, 1, PCI_CAPABILITY_LIST);
> > > +
> > > +       while (pos) {
> > > +               pci_caps_read(oct_hw, &cap, 2, pos);
> > > +
> > > +               if (cap.cap_vndr !=3D PCI_CAP_ID_VNDR) {
> > > +                       dev_err(dev, "Found invalid capability vndr i=
d: %d\n",
> > cap.cap_vndr);
> > > +                       break;
> > > +               }
> > > +
> > > +               pci_caps_read(oct_hw, &cap, sizeof(cap), pos);
> > > +
> > > +               dev_info(dev, "[%2x] cfg type: %u, bar: %u, offset: %=
04x, len:
> > %u\n",
> > > +                        pos, cap.cfg_type, cap.bar, cap.offset, cap.=
length);
> > > +
> > > +               switch (cap.cfg_type) {
> > > +               case VIRTIO_PCI_CAP_COMMON_CFG:
> > > +                       oct_hw->common_cfg =3D get_cap_addr(oct_hw, &=
cap);
> > > +                       break;
> > > +               case VIRTIO_PCI_CAP_NOTIFY_CFG:
> > > +                       pci_caps_read(oct_hw, &oct_hw->notify_off_mul=
tiplier,
> > > +                                     4, pos + sizeof(cap));
> > > +
> > > +                       oct_hw->notify_base =3D get_cap_addr(oct_hw, =
&cap);
> > > +                       oct_hw->notify_bar =3D cap.bar;
> > > +                       oct_hw->notify_base_pa =3D pci_resource_start=
(pdev, cap.bar) +
> > cap.offset;
> > > +                       break;
> > > +               case VIRTIO_PCI_CAP_DEVICE_CFG:
> > > +                       oct_hw->dev_cfg =3D get_cap_addr(oct_hw, &cap=
);
> > > +                       break;
> > > +               case VIRTIO_PCI_CAP_ISR_CFG:
> > > +                       oct_hw->isr =3D get_cap_addr(oct_hw, &cap);
> > > +                       break;
> > > +               }
> > > +
> > > +               pos =3D cap.cap_next;
> > > +       }
> > > +       if (!oct_hw->common_cfg || !oct_hw->notify_base ||
> > > +           !oct_hw->dev_cfg    || !oct_hw->isr) {
> > > +               dev_err(dev, "Incomplete PCI capabilities");
> > > +               return -EIO;
> > > +       }
> > > +       oct_hw->config_size =3D octep_get_config_size(oct_hw);
> > > +
> > > +       mbox =3D octep_get_mbox(oct_hw);
> > > +       octep_mbox_init(mbox);
> > > +
> > > +       dev_info(dev, "common cfg mapped at: 0x%016llx\n", (u64)oct_h=
w-
> > >common_cfg);
> > > +       dev_info(dev, "device cfg mapped at: 0x%016llx\n", (u64)oct_h=
w-
> > >dev_cfg);
> > > +       dev_info(dev, "isr cfg mapped at: 0x%016llx\n", (u64)oct_hw->=
isr);
> > > +       dev_info(dev, "notify base: 0x%016llx, notify off multiplier:=
 %u\n",
> > > +                (u64)oct_hw->notify_base, oct_hw->notify_off_multipl=
ier);
> > > +       dev_info(dev, "mbox mapped at: 0x%016llx\n", (u64)mbox);
> > > +
> > > +       return 0;
> > > +}
> >
> > PDS vDPA reuses vp_modern_probe(), can we reuse it as well here?
> >
> > For example, vp_modern_probe() allows vendor specific bars and id
> > check which looks to be useful here.
> >
> > > diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > > new file mode 100644
> > > index 000000000000..845fd35368ff
> > > --- /dev/null
> > > +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > > @@ -0,0 +1,903 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (C) 2024 Marvell. */
> > > +
> > > +#include <linux/interrupt.h>
> > > +#include <linux/module.h>
> > > +#include <linux/iommu.h>
> > > +#include "octep_vdpa.h"
> > > +
> > > +#define OCTEP_VDPA_DRIVER_NAME "octep_vdpa"
> > > +
> > > +struct octep_pf {
> > > +       u8 __iomem *base[PCI_STD_NUM_BARS];
> > > +       struct pci_dev *pdev;
> > > +       struct resource res;
> > > +       u64 vf_base;
> > > +       int enabled_vfs;
> > > +       u32 vf_stride;
> > > +       u16 vf_devid;
> > > +};
> > > +
> > > +struct octep_vdpa {
> > > +       struct vdpa_device vdpa;
> > > +       struct octep_hw *oct_hw;
> > > +       struct pci_dev *pdev;
> > > +};
> > > +
> > > +struct octep_vdpa_mgmt_dev {
> > > +       struct vdpa_mgmt_dev mdev;
> > > +       struct octep_hw oct_hw;
> > > +       struct pci_dev *pdev;
> > > +       /* Work entry to handle device setup */
> > > +       struct work_struct setup_task;
> > > +       /* Device status */
> > > +       atomic_t status;
> > > +};
> > > +
> > > +static int verify_features(u64 features)
> > > +{
> > > +       /* Minimum features to expect */
> > > +       if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> > > +               return -EOPNOTSUPP;
> > > +
> > > +       if (!(features & BIT_ULL(VIRTIO_F_NOTIFICATION_DATA)))
> > > +               return -EOPNOTSUPP;
> >
> > Any reason we need to mandate the NOTIFICATION_DATA. It seems can work
> > without that becasue:
> We are only supporting with NOTIFICATION_DATA feature enabled currently.
> I will remove below op in next version.
>
> >
> > void octep_notify_queue(struct octep_hw *oct_hw, u16 qid)
> > {
> >         iowrite16(qid, oct_hw->vqs[qid].notify_addr);
> > }
> >
> > > +
> > > +       if (!(features & BIT_ULL(VIRTIO_F_RING_PACKED)))
> > > +               return -EOPNOTSUPP;
> >
> > Does this mean the packed virtqueue is mandatory?
> Yes.
>
> >
> > > +
> > > +       /* Per VIRTIO v1.1 specification, section 5.1.3.1 Feature bit
> > > +        * requirements: "VIRTIO_NET_F_MQ Requires
> > VIRTIO_NET_F_CTRL_VQ".
> > > +        */
> >
> > Right, but we have a lot of other features that depend on the CVQ, why
> > is MQ special here?
> It's not just MQ. I will check whether this condition is required or not.
>
> >
> > > +       if ((features & (BIT_ULL(VIRTIO_NET_F_MQ) |
> > BIT_ULL(VIRTIO_NET_F_CTRL_VQ))) =3D=3D
> > > +           BIT_ULL(VIRTIO_NET_F_MQ))
> > > +               return -EINVAL;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static struct octep_hw *vdpa_to_octep_hw(struct vdpa_device *vdpa_de=
v)
> > > +{
> > > +       struct octep_vdpa *oct_vdpa;
> > > +
> > > +       oct_vdpa =3D container_of(vdpa_dev, struct octep_vdpa, vdpa);
> > > +
> > > +       return oct_vdpa->oct_hw;
> > > +}
> > > +
> > > +static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
> > > +{
> > > +       struct octep_hw *oct_hw =3D data;
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < oct_hw->nr_vring; i++) {
> > > +               if (oct_hw->vqs[i].cb.callback && *oct_hw->vqs[i].cb_=
notify_addr)
> > {
> > > +                       *oct_hw->vqs[i].cb_notify_addr =3D 0;
> >
> > I didn't get how cb_notify_addr is useful here.
> We are using this as acknowledgment to the device's firmware. We will ren=
ame
> the variable.
>
> >
> > > +                       oct_hw->vqs[i].cb.callback(oct_hw->vqs[i].cb.=
private);
> > > +               }
> > > +       }
> > > +
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
> > > +static void octep_free_irqs(struct octep_hw *oct_hw)
> > > +{
> > > +       struct pci_dev *pdev =3D oct_hw->pdev;
> > > +
> > > +       if (oct_hw->irq !=3D -1) {
> > > +               devm_free_irq(&pdev->dev, oct_hw->irq, oct_hw);
> > > +               oct_hw->irq =3D -1;
> > > +       }
> > > +       pci_free_irq_vectors(pdev);
> > > +}
> > > +
> > > +static int octep_request_irqs(struct octep_hw *oct_hw)
> > > +{
> > > +       struct pci_dev *pdev =3D oct_hw->pdev;
> > > +       int ret, irq;
> > > +
> > > +       /* Use one ring/interrupt per VF for virtio call interface. *=
/
> >
> > Is this a hardware limitation? If not, it would be slow.
> Yes, it's a hardware limitation currently.

Let's add a comment or TODO here.

>
> >
> > > +       ret =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> > > +       if (ret < 0) {
> > > +               dev_err(&pdev->dev, "Failed to alloc msix vector");
> > > +               return ret;
> > > +       }
> > > +
> > > +       snprintf(oct_hw->vqs->msix_name, sizeof(oct_hw->vqs->msix_nam=
e),
> > > +                OCTEP_VDPA_DRIVER_NAME "-vf-%d", pci_iov_vf_id(pdev)=
);
> > > +
> > > +       irq =3D pci_irq_vector(pdev, 0);
> > > +       ret =3D devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_han=
dler, 0,
> > > +                              oct_hw->vqs->msix_name, oct_hw);
> > > +       if (ret) {
> > > +               dev_err(&pdev->dev, "Failed to register interrupt han=
dler\n");
> > > +               goto free_irq_vec;
> > > +       }
> > > +       oct_hw->irq =3D irq;
> > > +
> > > +       return 0;
> > > +
> > > +free_irq_vec:
> > > +       pci_free_irq_vectors(pdev);
> > > +       return ret;
> > > +}
> > > +
> > > +static u64 octep_vdpa_get_device_features(struct vdpa_device *vdpa_d=
ev)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       return oct_hw->features;
> > > +}
> > > +
> > > +static int octep_vdpa_set_driver_features(struct vdpa_device *vdpa_d=
ev,
> > u64 features)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +       int ret;
> > > +
> > > +       pr_debug("Driver Features: %llx\n", features);
> > > +       ret =3D verify_features(features);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       octep_hw_set_drv_features(oct_hw, features);
> > > +       oct_hw->drv_features =3D features;
> >
> > It is not guaranteed that the device will accept all those features or
> > it would be painful to maintain per fw feature white/blacklist.
> >
> > More below.
> >
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static u64 octep_vdpa_get_driver_features(struct vdpa_device *vdpa_d=
ev)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       return oct_hw->features & oct_hw->drv_features;
> >
> > So here, the drv_features needs to be read from the device then
> > everything is fine.
> Sure, we will change it to read from the device.
>
> >
> > > +}
> > > +
> > > +static u8 octep_vdpa_get_status(struct vdpa_device *vdpa_dev)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       return octep_hw_get_status(oct_hw);
> > > +}
> > > +
> > > +static void octep_vdpa_set_status(struct vdpa_device *vdpa_dev, u8
> > status)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +       u8 status_old;
> > > +
> > > +       status_old =3D octep_hw_get_status(oct_hw);
> > > +
> > > +       if (status_old =3D=3D status)
> > > +               return;
> > > +
> > > +       if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > > +           !(status_old & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > +               if (octep_request_irqs(oct_hw))
> > > +                       status =3D status_old | VIRTIO_CONFIG_S_FAILE=
D;
> > > +       }
> > > +       octep_hw_set_status(oct_hw, status);
> > > +}
> > > +
> > > +static int octep_vdpa_reset(struct vdpa_device *vdpa_dev)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +       u8 status =3D octep_hw_get_status(oct_hw);
> > > +       u16 qid;
> > > +
> > > +       if (status =3D=3D 0)
> > > +               return 0;
> > > +
> > > +       for (qid =3D 0; qid < oct_hw->nr_vring; qid++) {
> > > +               oct_hw->vqs[qid].cb.callback =3D NULL;
> > > +               oct_hw->vqs[qid].cb.private =3D NULL;
> > > +               oct_hw->config_cb.callback =3D NULL;
> > > +               oct_hw->config_cb.private =3D NULL;
> > > +       }
> > > +       octep_hw_reset(oct_hw);
> > > +
> > > +       if (status & VIRTIO_CONFIG_S_DRIVER_OK)
> > > +               octep_free_irqs(oct_hw);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static u16 octep_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       return octep_get_vq_size(oct_hw);
> > > +}
> > > +
> > > +static int octep_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16=
 qid,
> > > +                                  struct vdpa_vq_state *state)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       return octep_get_vq_state(oct_hw, qid, state);
> > > +}
> > > +
> > > +static int octep_vdpa_set_vq_state(struct vdpa_device *vdpa_dev, u16=
 qid,
> > > +                                  const struct vdpa_vq_state *state)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       return octep_set_vq_state(oct_hw, qid, state);
> > > +}
> > > +
> > > +static void octep_vdpa_set_vq_cb(struct vdpa_device *vdpa_dev, u16 q=
id,
> > struct vdpa_callback *cb)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       oct_hw->vqs[qid].cb =3D *cb;
> > > +}
> > > +
> > > +static void octep_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u1=
6
> > qid, bool ready)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       octep_set_vq_ready(oct_hw, qid, ready);
> > > +}
> > > +
> > > +static bool octep_vdpa_get_vq_ready(struct vdpa_device *vdpa_dev, u1=
6
> > qid)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       return octep_get_vq_ready(oct_hw, qid);
> > > +}
> > > +
> > > +static void octep_vdpa_set_vq_num(struct vdpa_device *vdpa_dev, u16
> > qid, u32 num)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       octep_set_vq_num(oct_hw, qid, num);
> > > +}
> > > +
> > > +static int octep_vdpa_set_vq_address(struct vdpa_device *vdpa_dev, u=
16
> > qid, u64 desc_area,
> > > +                                    u64 driver_area, u64 device_area=
)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       pr_debug("qid[%d]: desc_area: %llx\n", qid, desc_area);
> > > +       pr_debug("qid[%d]: driver_area: %llx\n", qid, driver_area);
> > > +       pr_debug("qid[%d]: device_area: %llx\n\n", qid, device_area);
> > > +
> > > +       return octep_set_vq_address(oct_hw, qid, desc_area, driver_ar=
ea,
> > device_area);
> > > +}
> > > +
> > > +static void octep_vdpa_kick_vq(struct vdpa_device *vdpa_dev, u16 qid=
)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       octep_notify_queue(oct_hw, qid);
> > > +}
> > > +
> > > +static void octep_vdpa_kick_vq_with_data(struct vdpa_device *vdpa_de=
v,
> > u32 data)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +       u16 idx =3D data & 0xFFFF;
> > > +
> > > +       vp_iowrite32(data, oct_hw->vqs[idx].notify_addr);
> > > +}
> > > +
> > > +static u32 octep_vdpa_get_generation(struct vdpa_device *vdpa_dev)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       return vp_ioread8(&oct_hw->common_cfg->config_generation);
> > > +}
> > > +
> > > +static u32 octep_vdpa_get_device_id(struct vdpa_device *vdpa_dev)
> > > +{
> > > +       return VIRTIO_ID_NET;
> > > +}
> > > +
> > > +static u32 octep_vdpa_get_vendor_id(struct vdpa_device *vdpa_dev)
> > > +{
> > > +       return PCI_VENDOR_ID_CAVIUM;
> > > +}
> > > +
> > > +static u32 octep_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
> > > +{
> > > +       return PAGE_SIZE;
> > > +}
> > > +
> > > +static size_t octep_vdpa_get_config_size(struct vdpa_device *vdpa_de=
v)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       return oct_hw->config_size;
> > > +}
> > > +
> > > +static void octep_vdpa_get_config(struct vdpa_device *vdpa_dev, unsi=
gned
> > int offset, void *buf,
> > > +                                 unsigned int len)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       octep_read_dev_config(oct_hw, offset, buf, len);
> > > +}
> > > +
> > > +static void octep_vdpa_set_config(struct vdpa_device *vdpa_dev, unsi=
gned
> > int offset,
> > > +                                 const void *buf, unsigned int len)
> > > +{
> > > +       /* Not supported */
> >
> > We probably need to filter out VIRTIO_NET_F_ANNOUNCE and other
> > features that depend on the config writing.
> As per modern virtio spec(v1.2), device config is read only for the drive=
r.
> Still do we need to filter out these features?
>
> >
> > > +}
> > > +
> > > +static void octep_vdpa_set_config_cb(struct vdpa_device *vdpa_dev, s=
truct
> > vdpa_callback *cb)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +
> > > +       oct_hw->config_cb.callback =3D cb->callback;
> > > +       oct_hw->config_cb.private =3D cb->private;
> > > +}
> > > +
> > > +static struct vdpa_notification_area octep_get_vq_notification(struc=
t
> > vdpa_device *vdpa_dev,
> > > +                                                              u16 id=
x)
> > > +{
> > > +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> > > +       struct vdpa_notification_area area;
> > > +
> > > +       area.addr =3D oct_hw->vqs[idx].notify_pa;
> > > +       area.size =3D PAGE_SIZE;
> > > +
> > > +       return area;
> > > +}
> > > +
> > > +static int octep_vdpa_set_map(struct vdpa_device *vdev, unsigned int=
 asid,
> > > +                             struct vhost_iotlb *iotlb)
> > > +{
> > > +       return 0;
> > > +}
> > > +
> > > +static struct vdpa_config_ops octep_vdpa_ops =3D {
> > > +       .get_device_features =3D octep_vdpa_get_device_features,
> > > +       .set_driver_features =3D octep_vdpa_set_driver_features,
> > > +       .get_driver_features =3D octep_vdpa_get_driver_features,
> > > +       .get_status     =3D octep_vdpa_get_status,
> > > +       .set_status     =3D octep_vdpa_set_status,
> > > +       .reset          =3D octep_vdpa_reset,
> > > +       .get_vq_num_max =3D octep_vdpa_get_vq_num_max,
> > > +       .get_vq_state   =3D octep_vdpa_get_vq_state,
> > > +       .set_vq_state   =3D octep_vdpa_set_vq_state,
> > > +       .set_vq_cb      =3D octep_vdpa_set_vq_cb,
> > > +       .set_vq_ready   =3D octep_vdpa_set_vq_ready,
> > > +       .get_vq_ready   =3D octep_vdpa_get_vq_ready,
> > > +       .set_vq_num     =3D octep_vdpa_set_vq_num,
> > > +       .set_vq_address =3D octep_vdpa_set_vq_address,
> > > +       .get_vq_irq     =3D NULL,
> > > +       .kick_vq        =3D octep_vdpa_kick_vq,
> > > +       .kick_vq_with_data      =3D octep_vdpa_kick_vq_with_data,
> > > +       .get_generation =3D octep_vdpa_get_generation,
> > > +       .get_device_id  =3D octep_vdpa_get_device_id,
> > > +       .get_vendor_id  =3D octep_vdpa_get_vendor_id,
> > > +       .get_vq_align   =3D octep_vdpa_get_vq_align,
> > > +       .get_config_size        =3D octep_vdpa_get_config_size,
> > > +       .get_config     =3D octep_vdpa_get_config,
> > > +       .set_config     =3D octep_vdpa_set_config,
> > > +       .set_config_cb  =3D octep_vdpa_set_config_cb,
> > > +       .get_vq_notification =3D octep_get_vq_notification,
> > > +};
> > > +
> > > +static int octep_iomap_region(struct pci_dev *pdev, u8 __iomem **tbl=
, u8
> > bar)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret =3D pci_request_region(pdev, bar, OCTEP_VDPA_DRIVER_NAME)=
;
> > > +       if (ret) {
> > > +               dev_err(&pdev->dev, "Failed to request BAR:%u region\=
n", bar);
> > > +               return ret;
> > > +       }
> > > +
> > > +       tbl[bar] =3D pci_iomap(pdev, bar, pci_resource_len(pdev, bar)=
);
> > > +       if (!tbl[bar]) {
> > > +               dev_err(&pdev->dev, "Failed to iomap BAR:%u\n", bar);
> > > +               pci_release_region(pdev, bar);
> > > +               ret =3D -ENOMEM;
> > > +       }
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static void octep_iounmap_region(struct pci_dev *pdev, u8 __iomem **=
tbl,
> > u8 bar)
> > > +{
> > > +       pci_iounmap(pdev, tbl[bar]);
> > > +       pci_release_region(pdev, bar);
> > > +}
> > > +
> > > +static void octep_vdpa_pf_bar_shrink(struct octep_pf *octpf)
> > > +{
> > > +       struct pci_dev *pf_dev =3D octpf->pdev;
> > > +       struct resource *res =3D pf_dev->resource + PCI_STD_RESOURCES=
 + 4;
> > > +       struct pci_bus_region bus_region;
> > > +
> > > +       octpf->res.start =3D res->start;
> > > +       octpf->res.end =3D res->end;
> > > +       octpf->vf_base =3D res->start;
> > > +
> > > +       bus_region.start =3D res->start;
> > > +       bus_region.end =3D res->start - 1;
> >
> > Is this inteneded?
> Yes,  it is required for emulating virtio config space.
>
> >
> > > +
> > > +       pcibios_bus_to_resource(pf_dev->bus, res, &bus_region);
> > > +}
> > > +
> > > +static void octep_vdpa_pf_bar_expand(struct octep_pf *octpf)
> > > +{
> > > +       struct pci_dev *pf_dev =3D octpf->pdev;
> > > +       struct resource *res =3D pf_dev->resource + PCI_STD_RESOURCES=
 + 4;
> > > +       struct pci_bus_region bus_region;
> > > +
> > > +       bus_region.start =3D octpf->res.start;
> > > +       bus_region.end =3D octpf->res.end;
> > > +
> > > +       pcibios_bus_to_resource(pf_dev->bus, res, &bus_region);
> > > +}
> > > +
> > > +static void octep_vdpa_remove_pf(struct pci_dev *pdev)
> > > +{
> > > +       struct octep_pf *octpf =3D pci_get_drvdata(pdev);
> > > +
> > > +       pci_disable_sriov(pdev);
> > > +
> > > +       if (octpf->base[OCTEP_HW_CAPS_BAR])
> > > +               octep_iounmap_region(pdev, octpf->base,
> > OCTEP_HW_CAPS_BAR);
> > > +
> > > +       if (octpf->base[OCTEP_HW_MBOX_BAR])
> > > +               octep_iounmap_region(pdev, octpf->base,
> > OCTEP_HW_MBOX_BAR);
> > > +
> > > +       octep_vdpa_pf_bar_expand(octpf);
> > > +}
> > > +
> > > +static void octep_vdpa_vf_bar_shrink(struct pci_dev *pdev)
> > > +{
> > > +       struct resource *vf_res =3D pdev->resource + PCI_STD_RESOURCE=
S + 4;
> > > +
> > > +       memset(vf_res, 0, sizeof(*vf_res));
> > > +}
> > > +
> > > +static void octep_vdpa_remove_vf(struct pci_dev *pdev)
> > > +{
> > > +       struct octep_vdpa_mgmt_dev *mgmt_dev =3D pci_get_drvdata(pdev=
);
> > > +       struct octep_hw *oct_hw;
> > > +       int status;
> > > +
> > > +       oct_hw =3D &mgmt_dev->oct_hw;
> > > +       status =3D atomic_read(&mgmt_dev->status);
> > > +       atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_UNINIT);
> > > +
> > > +       if (status =3D=3D OCTEP_VDPA_DEV_STATUS_WAIT_FOR_BAR_INIT) {
> > > +               cancel_work_sync(&mgmt_dev->setup_task);
> >
> > This seems to be racy, can we call cancel_work_sync() unconditionally?
> >
> > > +       } else if (status =3D=3D OCTEP_VDPA_DEV_STATUS_READY) {
> > > +               vdpa_mgmtdev_unregister(&mgmt_dev->mdev);
> > > +               kfree(mgmt_dev->oct_hw.vqs);
> > > +       }
> > > +
> > > +       if (oct_hw->base[OCTEP_HW_CAPS_BAR])
> > > +               octep_iounmap_region(pdev, oct_hw->base,
> > OCTEP_HW_CAPS_BAR);
> > > +
> > > +       if (oct_hw->base[OCTEP_HW_MBOX_BAR])
> > > +               octep_iounmap_region(pdev, oct_hw->base,
> > OCTEP_HW_MBOX_BAR);
> > > +
> > > +       octep_vdpa_vf_bar_shrink(pdev);
> > > +}
> > > +
> > > +static void octep_vdpa_remove(struct pci_dev *pdev)
> > > +{
> > > +       if (pdev->is_virtfn)
> > > +               octep_vdpa_remove_vf(pdev);
> > > +       else
> > > +               octep_vdpa_remove_pf(pdev);
> > > +}
> > > +
> > > +static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char
> > *name,
> > > +                             const struct vdpa_dev_set_config *confi=
g)
> > > +{
> > > +       struct octep_vdpa_mgmt_dev *mgmt_dev =3D container_of(mdev, s=
truct
> > octep_vdpa_mgmt_dev, mdev);
> > > +       struct octep_hw *oct_hw =3D &mgmt_dev->oct_hw;
> > > +       struct pci_dev *pdev =3D oct_hw->pdev;
> > > +       struct vdpa_device *vdpa_dev;
> > > +       struct octep_vdpa *oct_vdpa;
> > > +       u64 device_features;
> > > +       u16 notify_off;
> > > +       int i, ret;
> > > +
> > > +       oct_vdpa =3D vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev=
->dev,
> > &octep_vdpa_ops, 1, 1,
> > > +                                    NULL, false);
> > > +       if (IS_ERR(oct_vdpa)) {
> > > +               dev_err(&pdev->dev, "Failed to allocate vDPA structur=
e for octep
> > vdpa device");
> > > +               return PTR_ERR(oct_vdpa);
> > > +       }
> > > +
> > > +       oct_vdpa->pdev =3D pdev;
> > > +       oct_vdpa->vdpa.dma_dev =3D &pdev->dev;
> > > +       oct_vdpa->vdpa.mdev =3D mdev;
> > > +       oct_vdpa->oct_hw =3D oct_hw;
> > > +       vdpa_dev =3D &oct_vdpa->vdpa;
> > > +
> > > +       device_features =3D oct_hw->features;
> > > +       if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > > +               if (config->device_features & ~device_features) {
> > > +                       dev_err(&pdev->dev, "The provisioned features=
 0x%llx are not
> > supported by this device with features 0x%llx\n",
> > > +                               config->device_features, device_featu=
res);
> > > +                       return -EINVAL;
> > > +               }
> > > +               device_features &=3D config->device_features;
> > > +       }
> > > +
> > > +       oct_hw->features =3D device_features;
> > > +
> > > +       if (verify_features(device_features)) {
> > > +               dev_warn(mdev->device,
> > > +                        "Must provision minimum features 0x%llx for =
this device",
> > > +                        BIT_ULL(VIRTIO_F_VERSION_1) |
> > BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |
> > > +                        BIT_ULL(VIRTIO_F_NOTIFICATION_DATA) |
> > BIT_ULL(VIRTIO_F_IN_ORDER));
> > > +               return -EOPNOTSUPP;
> > > +       }
> > > +
> > > +       oct_hw->vqs =3D kcalloc(oct_hw->nr_vring, sizeof(*oct_hw->vqs=
),
> > GFP_KERNEL);
> > > +       if (!oct_hw->vqs)
> > > +               return -ENOMEM;
> > > +
> > > +       oct_hw->irq =3D -1;
> > > +
> > > +       dev_info(&pdev->dev, "Device features : %llx\n", oct_hw->feat=
ures);
> > > +       dev_info(&pdev->dev, "Maximum queues : %u\n", oct_hw->nr_vrin=
g);
> > > +
> > > +       for (i =3D 0; i < oct_hw->nr_vring; i++) {
> > > +               octep_write_queue_select(i, oct_hw);
> > > +               notify_off =3D vp_ioread16(&oct_hw->common_cfg-
> > >queue_notify_off);
> > > +               oct_hw->vqs[i].notify_addr =3D oct_hw->notify_base +
> > > +                       notify_off * oct_hw->notify_off_multiplier;
> > > +               oct_hw->vqs[i].cb_notify_addr =3D (u32 *)oct_hw-
> > >vqs[i].notify_addr + 1;
> > > +               oct_hw->vqs[i].notify_pa =3D oct_hw->notify_base_pa +
> > > +                       notify_off * oct_hw->notify_off_multiplier;
> > > +       }
> >
> > I think the reason we can't do the above in the probe is that we need
> > to wait for the device ready then we can get those information?
> Yes, your understanding is correct.

Comment please.

>
> >
> > > +
> > > +       if (name)
> > > +               ret =3D dev_set_name(&vdpa_dev->dev, "%s", name);
> > > +       else
> > > +               ret =3D dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_d=
ev-
> > >index);
> > > +
> > > +       ret =3D _vdpa_register_device(&oct_vdpa->vdpa, oct_hw->nr_vri=
ng);
> > > +       if (ret) {
> > > +               dev_err(&pdev->dev, "Failed to register to vDPA bus")=
;
> > > +               goto free_vqs;
> > > +       }
> > > +       return 0;
> > > +
> > > +free_vqs:
> > > +       put_device(&oct_vdpa->vdpa.dev);
> > > +       kfree(oct_hw->vqs);
> > > +       return ret;
> > > +}
> > > +
> > > +static void octep_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct
> > vdpa_device *dev)
> > > +{
> > > +       _vdpa_unregister_device(dev);
> > > +}
> > > +
> > > +static const struct vdpa_mgmtdev_ops octep_vdpa_mgmt_dev_ops =3D {
> > > +       .dev_add =3D octep_vdpa_dev_add,
> > > +       .dev_del =3D octep_vdpa_dev_del
> > > +};
> > > +
> > > +static bool get_device_ready_status(u8 __iomem *addr)
> > > +{
> > > +       u64 signature =3D readq(addr + OCTEP_VF_MBOX_DATA(0));
> > > +
> > > +       if (signature =3D=3D OCTEP_DEV_READY_SIGNATURE) {
> > > +               writeq(0, addr + OCTEP_VF_MBOX_DATA(0));
> > > +               return true;
> > > +       }
> > > +
> > > +       return false;
> > > +}
> > > +
> > > +static struct virtio_device_id id_table[] =3D {
> > > +       { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> > > +       { 0 },
> > > +};
> > > +
> > > +static void octep_vdpa_setup_task(struct work_struct *work)
> > > +{
> > > +       struct octep_vdpa_mgmt_dev *mgmt_dev =3D container_of(work, s=
truct
> > octep_vdpa_mgmt_dev,
> > > +                                                           setup_tas=
k);
> > > +       struct pci_dev *pdev =3D mgmt_dev->pdev;
> > > +       struct device *dev =3D &pdev->dev;
> > > +       struct octep_hw *oct_hw;
> > > +       unsigned long timeout;
> > > +       int ret;
> > > +
> > > +       oct_hw =3D &mgmt_dev->oct_hw;
> > > +
> > > +       atomic_set(&mgmt_dev->status,
> > OCTEP_VDPA_DEV_STATUS_WAIT_FOR_BAR_INIT);
> > > +
> > > +       /* Wait for a maximum of 5 sec */
> > > +       timeout =3D jiffies + msecs_to_jiffies(5000);
> > > +       while (!time_after(jiffies, timeout)) {
> > > +               if (get_device_ready_status(oct_hw-
> > >base[OCTEP_HW_MBOX_BAR])) {
> > > +                       atomic_set(&mgmt_dev->status,
> > OCTEP_VDPA_DEV_STATUS_INIT);
> > > +                       break;
> > > +               }
> > > +
> > > +               if (atomic_read(&mgmt_dev->status) >=3D
> > OCTEP_VDPA_DEV_STATUS_READY) {
> > > +                       dev_info(dev, "Stopping vDPA setup task.\n");
> > > +                       return;
> > > +               }
> > > +
> > > +               usleep_range(1000, 1500);
> > > +       }
> > > +
> > > +       if (atomic_read(&mgmt_dev->status) !=3D
> > OCTEP_VDPA_DEV_STATUS_INIT) {
> > > +               dev_err(dev, "BAR initialization is timed out\n");
> > > +               return;
> > > +       }
> > > +
> > > +       ret =3D octep_iomap_region(pdev, oct_hw->base,
> > OCTEP_HW_CAPS_BAR);
> > > +       if (ret)
> > > +               return;
> > > +
> > > +       ret =3D octep_hw_caps_read(oct_hw, pdev);
> > > +       if (ret < 0)
> > > +               goto unmap_region;
> > > +
> > > +       oct_hw->features =3D octep_hw_get_dev_features(oct_hw);
> > > +       ret =3D verify_features(oct_hw->features);
> > > +       if (ret) {
> > > +               dev_err(&pdev->dev, "Octeon Virtio FW is not initiali=
zed\n");
> > > +               goto unmap_region;
> > > +       }
> > > +       oct_hw->nr_vring =3D vp_ioread16(&oct_hw->common_cfg-
> > >num_queues);
> > > +
> > > +       mgmt_dev->mdev.ops =3D &octep_vdpa_mgmt_dev_ops;
> > > +       mgmt_dev->mdev.id_table =3D id_table;
> > > +       mgmt_dev->mdev.max_supported_vqs =3D oct_hw->nr_vring;
> > > +       mgmt_dev->mdev.supported_features =3D oct_hw->features;
> > > +       mgmt_dev->mdev.config_attr_mask =3D (1 <<
> > VDPA_ATTR_DEV_FEATURES);
> > > +       mgmt_dev->mdev.device =3D dev;
> > > +
> > > +       ret =3D vdpa_mgmtdev_register(&mgmt_dev->mdev);
> > > +       if (ret) {
> > > +               dev_err(dev, "Failed to register vdpa management inte=
rface\n");
> > > +               goto unmap_region;
> > > +       }
> > > +
> > > +       atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_READY);
> > > +
> > > +       return;
> > > +
> > > +unmap_region:
> > > +       octep_iounmap_region(pdev, oct_hw->base, OCTEP_HW_CAPS_BAR);
> > > +       oct_hw->base[OCTEP_HW_CAPS_BAR] =3D NULL;
> > > +}
> > > +
> > > +static int octep_vdpa_probe_vf(struct pci_dev *pdev)
> > > +{
> > > +       struct octep_vdpa_mgmt_dev *mgmt_dev;
> > > +       struct device *dev =3D &pdev->dev;
> > > +       struct iommu_domain *domain;
> > > +       int ret;
> > > +
> > > +       ret =3D pcim_enable_device(pdev);
> > > +       if (ret) {
> > > +               dev_err(dev, "Failed to enable device\n");
> > > +               return ret;
> > > +       }
> > > +
> > > +       ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > > +       if (ret) {
> > > +               dev_err(dev, "No usable DMA configuration\n");
> > > +               return ret;
> > > +       }
> > > +       pci_set_master(pdev);
> > > +
> > > +       domain =3D iommu_get_domain_for_dev(dev);
> > > +       if (!domain || domain->type =3D=3D IOMMU_DOMAIN_IDENTITY) {
> > > +               dev_info(dev, "NO-IOMMU\n");
> > > +               octep_vdpa_ops.set_map =3D octep_vdpa_set_map;
> >
> > Is this a shortcut to have get better performance? DMA API should have
> > those greacefully I think.
> When IOMMU is disabled on host and set_map/dma_map is not set,
> vhost-vdpa is reporting an error "Failed to allocate domain, device is no=
t IOMMU cache coherent capable\n".
> Hence we are doing this way to get better performance.

The problem is, assuming the device does not have any internal IOMMU.

1) If we allow it running without IOMMU, it opens a window for guest
to attack the host.
2) If you see perforamnce issue with IOMMU_DOMAIN_IDENTITY, let's
report it to DMA/IOMMU maintiner to fix that

Thanks

