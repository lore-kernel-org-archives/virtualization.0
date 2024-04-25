Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13391CD2B
	for <virtualization@lists.linux.dev>; Thu, 25 Apr 2024 01:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714010252; cv=none; b=i7pRKvbwUOvrOvvoQEuGK1mF10PVsxIQdBcHlF5YE0eOyT5BDYOGzzjc2U8p/kZcXvHp9pnq1Fz3v+Q1YzkEELpb/KHYiHfrgomt1ci+59pw3X/LEMIMrFSHH2/Oc0HizFz2At9DGOWrynpaRVZqIxSx7PPd3UcoLJn1qRCi12M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714010252; c=relaxed/simple;
	bh=mKn8w7DA6P5BAx8jSP0bNARU6hil3CBLuIKMnZ/q2E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmzxBs0WOZ2zBq7oSZMqzqjkUTWdDyXzWoAT5EwSGjJp4xgjJbTmKEdCsqZJLIMq5UWh0bOvtitFVI0JbhhgCEov5aMUX2S8fMyoMdKO4UEQu2DqXtK6XrvH/V2Kvq9xRExJt9b1wAkD1+8AH7pozlaKCIQ5DJpKUHF+IXdN2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCqQcJ8/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCqQcJ8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714010248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1wXRRdNgyVVjVjPuU6IZ0zawWd1TuME/46nurUhpJo=;
	b=cCqQcJ8/5grli7DYVD7WbSVt2UzfGkLxdVNNz/Vv3nLDHDg2SiLQZngsHWIPP0QeHUdgD1
	Zj3P6gcOff4Mwg3Gk+3uCywhhzX0sJhJY3sbvcWodFUtiJEpDdcNyzy5kZ1FoIEkc7QrLz
	PaQiLAZmIeCwRuajl7urkEaul8YlIi4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-ky5JYctTOo2MmDtE4dggGQ-1; Wed, 24 Apr 2024 21:57:27 -0400
X-MC-Unique: ky5JYctTOo2MmDtE4dggGQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a49440f7b5so596614a91.1
        for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 18:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714010246; x=1714615046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1wXRRdNgyVVjVjPuU6IZ0zawWd1TuME/46nurUhpJo=;
        b=DSQZpSfcLT/AdqtRLjELINl1KODU5NdYl8l/9OctaLaBzHQSMq+30sMIA3yRoCTD9J
         ftzq2lo4mTh5UJVbn/I7VNyapGkJn1DDP1x0wDyu6cBIuximH5z+wqlePaYC9D56F0Ij
         +RrUD2SLkIF3WKSKfdwcA6Eg6FozRBFiqfK7onR6DjzixlEMkZKg+bVSXWGtxUN4TFNI
         NUsm+P+g6XmVGnuKI8ndNhQEdDym4VzLS7EtpED/IG52tmIJcwLPb3OG7H/Ew27bP8k7
         GJ0ZVYWtofzaf5A62rDEU+fH/vRjax1a0cvnfQKw988jJh5w8mmIPdIy4rjmwu6bBNLe
         K62g==
X-Gm-Message-State: AOJu0Yz/uk37L058PiSRSPz/xQE0EBbkNz1BpXdNBzR7nVqoCMtmL95L
	mSrjjlEh1gcyQn/ENEA4YLACAYoozKZw8kxHj6/xTHgCDMHv4ECKjzAuhPPwhOftbTfs5fyFvGm
	pHMeV3gyKhKXS+dpGrrxQGTd28TwHycD3KEeNKB4ZJfsKzRIzDAUbwJPlnJ3kbpOubvLbg0q+SR
	fa7o4YWvtwc1J54DWUa37qmg1o2RXIECJZRszSKnWhykCAkvb5zQ==
X-Received: by 2002:a17:90a:7347:b0:2a2:4192:dfc1 with SMTP id j7-20020a17090a734700b002a24192dfc1mr3972800pjs.14.1714010245520;
        Wed, 24 Apr 2024 18:57:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+Serw1vla4k3xJrHwuwVQqjrLtB79RGJGIK+SYESCh4mkN/i7tEcWXQ4XXmr70w4WceY4bcTQo8tfm42puu8=
X-Received: by 2002:a17:90a:7347:b0:2a2:4192:dfc1 with SMTP id
 j7-20020a17090a734700b002a24192dfc1mr3972781pjs.14.1714010245071; Wed, 24 Apr
 2024 18:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327112136.2897479-1-schalla@marvell.com> <20240424190814.2112-1-schalla@marvell.com>
In-Reply-To: <20240424190814.2112-1-schalla@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Apr 2024 09:57:13 +0800
Message-ID: <CACGkMEti_HGUvrg3MwBVuBtjDz_Bt+beTMg09i_RJqMtN7-EcQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: vdpa: vDPA driver for Marvell OCTEON DPU devices
To: Srujana Challa <schalla@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	vattunuru@marvell.com, sthotton@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 3:08=E2=80=AFAM Srujana Challa <schalla@marvell.com=
> wrote:
>
> This commit introduces a new vDPA driver specifically designed for
> managing the virtio control plane over the vDPA bus for OCTEON DPU
> devices. The driver consists of two layers:
>
> 1. Octep HW Layer (Octeon Endpoint): Responsible for handling hardware
> operations and configurations related to the DPU device.
>
> 2. Octep Main Layer: Compliant with the vDPA bus framework, this layer
> implements device operations for the vDPA bus. It handles device
> probing, bus attachment, vring operations, and other relevant tasks.
>
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> ---
> v2:
> * Addressed review comments
>
>  MAINTAINERS                              |   5 +
>  drivers/vdpa/Kconfig                     |   9 +
>  drivers/vdpa/Makefile                    |   1 +
>  drivers/vdpa/octeon_ep/Makefile          |   4 +
>  drivers/vdpa/octeon_ep/octep_vdpa.h      |  94 +++
>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 517 ++++++++++++++
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c | 850 +++++++++++++++++++++++
>  7 files changed, 1480 insertions(+)
>  create mode 100644 drivers/vdpa/octeon_ep/Makefile
>  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa.h
>  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_hw.c
>  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_main.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cfe44a876d8a..539ce209a960 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13127,6 +13127,11 @@ S:     Supported
>  F:     Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
>  F:     drivers/mmc/host/sdhci-xenon*
>
> +MARVELL OCTEON ENDPOINT VIRTIO DATA PATH ACCELERATOR
> +R:     schalla@marvell.com
> +R:     vattunuru@marvell.com
> +F:     drivers/vdpa/octeon_ep/
> +
>  MATROX FRAMEBUFFER DRIVER
>  L:     linux-fbdev@vger.kernel.org
>  S:     Orphan
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 656c1cb541de..775149fad476 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -126,4 +126,13 @@ config PDS_VDPA
>           With this driver, the VirtIO dataplane can be
>           offloaded to an AMD/Pensando DSC device.
>
> +config OCTEONEP_VDPA
> +       tristate "vDPA driver for Octeon DPU devices"
> +       depends on m
> +       depends on PCI_MSI
> +       help
> +         vDPA driver for Marvell's Octeon DPU devices.
> +         With this driver, the VirtIO dataplane can be
> +         offloaded to a Octeon DPU device.
> +
>  endif # VDPA
> diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
> index 8f53c6f3cca7..5654d36707af 100644
> --- a/drivers/vdpa/Makefile
> +++ b/drivers/vdpa/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_VP_VDPA)    +=3D virtio_pci/
>  obj-$(CONFIG_ALIBABA_ENI_VDPA) +=3D alibaba/
>  obj-$(CONFIG_SNET_VDPA) +=3D solidrun/
>  obj-$(CONFIG_PDS_VDPA) +=3D pds/
> +obj-$(CONFIG_OCTEONEP_VDPA) +=3D octeon_ep/
> diff --git a/drivers/vdpa/octeon_ep/Makefile b/drivers/vdpa/octeon_ep/Mak=
efile
> new file mode 100644
> index 000000000000..e23e2ff14f33
> --- /dev/null
> +++ b/drivers/vdpa/octeon_ep/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_OCTEONEP_VDPA) +=3D octep_vdpa.o
> +octep_vdpa-$(CONFIG_OCTEONEP_VDPA) +=3D octep_vdpa_main.o
> +octep_vdpa-$(CONFIG_OCTEONEP_VDPA) +=3D octep_vdpa_hw.o
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep=
/octep_vdpa.h
> new file mode 100644
> index 000000000000..046710ec4d42
> --- /dev/null
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + * Copyright (C) 2024 Marvell.
> + */
> +#ifndef __OCTEP_VDPA_H__
> +#define __OCTEP_VDPA_H__
> +
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
> +#include <linux/vdpa.h>
> +#include <linux/virtio_pci_modern.h>
> +#include <uapi/linux/virtio_net.h>
> +#include <uapi/linux/virtio_blk.h>
> +#include <uapi/linux/virtio_config.h>
> +#include <uapi/linux/virtio_pci.h>
> +#include <uapi/linux/vdpa.h>
> +
> +#define OCTEP_VDPA_DEVID_CN106K_PF 0xb900
> +#define OCTEP_VDPA_DEVID_CN106K_VF 0xb903
> +#define OCTEP_VDPA_DEVID_CN105K_PF 0xba00
> +#define OCTEP_VDPA_DEVID_CN105K_VF 0xba03
> +#define OCTEP_VDPA_DEVID_CN103K_PF 0xbd00
> +#define OCTEP_VDPA_DEVID_CN103K_VF 0xbd03
> +
> +#define OCTEP_HW_MBOX_BAR 0
> +#define OCTEP_HW_CAPS_BAR 4
> +
> +#define OCTEP_DEV_READY_SIGNATURE 0xBABABABA
> +
> +#define OCTEP_EPF_RINFO(x) (0x000209f0 | ((x) << 25))
> +#define OCTEP_VF_MBOX_DATA(x) (0x00010210 | ((x) << 17))
> +#define OCTEP_PF_MBOX_DATA(x) (0x00022000 | ((x) << 4))
> +
> +#define OCTEP_EPF_RINFO_RPVF(val) (((val) >> 32) & 0xF)
> +#define OCTEP_EPF_RINFO_NVFS(val) (((val) >> 48) & 0x7F)
> +
> +#define OCTEP_FW_READY_SIGNATURE0  0xFEEDFEED
> +#define OCTEP_FW_READY_SIGNATURE1  0x3355ffaa
> +
> +enum octep_vdpa_dev_status {
> +       OCTEP_VDPA_DEV_STATUS_INVALID,
> +       OCTEP_VDPA_DEV_STATUS_ALLOC,
> +       OCTEP_VDPA_DEV_STATUS_WAIT_FOR_BAR_INIT,
> +       OCTEP_VDPA_DEV_STATUS_INIT,
> +       OCTEP_VDPA_DEV_STATUS_READY,
> +       OCTEP_VDPA_DEV_STATUS_UNINIT
> +};
> +
> +struct octep_vring_info {
> +       struct vdpa_callback cb;
> +       void __iomem *notify_addr;
> +       u32 __iomem *cb_notify_addr;
> +       phys_addr_t notify_pa;
> +       char msix_name[256];
> +};
> +
> +struct octep_hw {
> +       struct pci_dev *pdev;
> +       u8 __iomem *base[PCI_STD_NUM_BARS];
> +       struct virtio_pci_common_cfg __iomem *common_cfg;
> +       u8 __iomem *dev_cfg;
> +       u8 __iomem *isr;
> +       void __iomem *notify_base;
> +       phys_addr_t notify_base_pa;
> +       u32 notify_off_multiplier;
> +       u8 notify_bar;
> +       struct octep_vring_info *vqs;
> +       struct vdpa_callback config_cb;
> +       u64 features;
> +       u16 nr_vring;
> +       u32 config_size;
> +       int irq;
> +};
> +
> +u8 octep_hw_get_status(struct octep_hw *oct_hw);
> +void octep_hw_set_status(struct octep_hw *dev, uint8_t status);
> +void octep_hw_reset(struct octep_hw *oct_hw);
> +void octep_write_queue_select(struct octep_hw *oct_hw, u16 queue_id);
> +void octep_notify_queue(struct octep_hw *oct_hw, u16 qid);
> +void octep_read_dev_config(struct octep_hw *oct_hw, u64 offset, void *ds=
t, int length);
> +int octep_set_vq_address(struct octep_hw *oct_hw, u16 qid, u64 desc_area=
, u64 driver_area,
> +                        u64 device_area);
> +void octep_set_vq_num(struct octep_hw *oct_hw, u16 qid, u32 num);
> +void octep_set_vq_ready(struct octep_hw *oct_hw, u16 qid, bool ready);
> +bool octep_get_vq_ready(struct octep_hw *oct_hw, u16 qid);
> +int octep_set_vq_state(struct octep_hw *oct_hw, u16 qid, const struct vd=
pa_vq_state *state);
> +int octep_get_vq_state(struct octep_hw *oct_hw, u16 qid, struct vdpa_vq_=
state *state);
> +u16 octep_get_vq_size(struct octep_hw *oct_hw);
> +int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev);
> +u64 octep_hw_get_dev_features(struct octep_hw *oct_hw);
> +void octep_hw_set_drv_features(struct octep_hw *oct_hw, u64 features);
> +u64 octep_hw_get_drv_features(struct octep_hw *oct_hw);
> +int octep_verify_features(u64 features);
> +
> +#endif /* __OCTEP_VDPA_H__ */
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon=
_ep/octep_vdpa_hw.c
> new file mode 100644
> index 000000000000..6afd06ead46a
> --- /dev/null
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> @@ -0,0 +1,517 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2024 Marvell. */
> +
> +#include <linux/iopoll.h>
> +
> +#include "octep_vdpa.h"
> +
> +enum octep_mbox_ids {
> +       OCTEP_MBOX_MSG_SET_VQ_STATE =3D 1,
> +       OCTEP_MBOX_MSG_GET_VQ_STATE,
> +};
> +
> +#define OCTEP_HW_TIMEOUT       10000000
> +
> +#define MBOX_OFFSET            64
> +#define MBOX_RSP_MASK          0x00000001
> +#define MBOX_RC_MASK           0x0000FFFE
> +
> +#define MBOX_RSP_TO_ERR(val)   (-(((val) & MBOX_RC_MASK) >> 2))
> +#define MBOX_AVAIL(val)        (((val) & MBOX_RSP_MASK))
> +#define MBOX_RSP(val)          ((val) & (MBOX_RC_MASK | MBOX_RSP_MASK))
> +
> +#define DEV_RST_ACK_BIT        7
> +#define FEATURE_SEL_ACK_BIT    15
> +#define QUEUE_SEL_ACK_BIT      15
> +
> +struct octep_mbox_hdr {
> +       u8 ver;
> +       u8 rsvd1;
> +       u16 id;
> +       u16 rsvd2;
> +#define MBOX_REQ_SIG (0xdead)
> +#define MBOX_RSP_SIG (0xbeef)
> +       u16 sig;
> +};
> +
> +struct octep_mbox_sts {
> +       u16 rsp:1;
> +       u16 rc:15;
> +       u16 rsvd;
> +};
> +
> +struct octep_mbox {
> +       struct octep_mbox_hdr hdr;
> +       struct octep_mbox_sts sts;
> +       u64 rsvd;
> +       u32 data[];
> +};
> +
> +static inline struct octep_mbox __iomem *octep_get_mbox(struct octep_hw =
*oct_hw)
> +{
> +       return (struct octep_mbox __iomem *)(oct_hw->dev_cfg + MBOX_OFFSE=
T);
> +}
> +
> +static inline int octep_wait_for_mbox_avail(struct octep_mbox __iomem *m=
box)
> +{
> +       u32 val;
> +
> +       return readx_poll_timeout(ioread32, &mbox->sts, val, MBOX_AVAIL(v=
al), 10,
> +                                 OCTEP_HW_TIMEOUT);
> +}
> +
> +static inline int octep_wait_for_mbox_rsp(struct octep_mbox __iomem *mbo=
x)
> +{
> +       u32 val;
> +
> +       return readx_poll_timeout(ioread32, &mbox->sts, val, MBOX_RSP(val=
), 10,
> +                                 OCTEP_HW_TIMEOUT);
> +}
> +
> +static inline void octep_write_hdr(struct octep_mbox __iomem *mbox, u16 =
id, u16 sig)
> +{
> +       iowrite16(id, &mbox->hdr.id);
> +       iowrite16(sig, &mbox->hdr.sig);
> +}
> +
> +static inline u32 octep_read_sig(struct octep_mbox __iomem *mbox)
> +{
> +       return ioread16(&mbox->hdr.sig);
> +}
> +
> +static inline void octep_write_sts(struct octep_mbox __iomem *mbox, u32 =
sts)
> +{
> +       iowrite32(sts, &mbox->sts);
> +}
> +
> +static inline u32 octep_read_sts(struct octep_mbox __iomem *mbox)
> +{
> +       return ioread32(&mbox->sts);
> +}
> +
> +static inline u32 octep_read32_word(struct octep_mbox __iomem *mbox, u16=
 word_idx)
> +{
> +       return ioread32(&mbox->data[word_idx]);
> +}
> +
> +static inline void octep_write32_word(struct octep_mbox __iomem *mbox, u=
16 word_idx, u32 word)
> +{
> +       return iowrite32(word, &mbox->data[word_idx]);
> +}
> +
> +static int octep_process_mbox(struct octep_hw *oct_hw, u16 id, u16 qid, =
void *buffer,
> +                             u32 buf_size, bool write)
> +{
> +       struct octep_mbox __iomem *mbox =3D octep_get_mbox(oct_hw);
> +       struct pci_dev *pdev =3D oct_hw->pdev;
> +       u32 *p =3D (u32 *)buffer;
> +       u16 data_wds;
> +       int ret, i;
> +       u32 val;
> +
> +       if (!IS_ALIGNED(buf_size, 4))
> +               return -EINVAL;
> +
> +       /* Make sure mbox space is available */
> +       ret =3D octep_wait_for_mbox_avail(mbox);
> +       if (ret) {
> +               dev_warn(&pdev->dev, "Timeout waiting for previous mbox d=
ata to be consumed\n");
> +               return ret;
> +       }
> +       data_wds =3D buf_size / 4;
> +
> +       if (write) {
> +               for (i =3D 1; i <=3D data_wds; i++) {
> +                       octep_write32_word(mbox, i, *p);
> +                       p++;
> +               }
> +       }
> +       octep_write32_word(mbox, 0, (u32)qid);
> +       octep_write_sts(mbox, 0);
> +
> +       octep_write_hdr(mbox, id, MBOX_REQ_SIG);
> +
> +       ret =3D octep_wait_for_mbox_rsp(mbox);
> +       if (ret) {
> +               dev_warn(&pdev->dev, "Timeout waiting for mbox : %d respo=
nse\n", id);
> +               return ret;
> +       }
> +
> +       val =3D octep_read_sig(mbox);
> +       if ((val & 0xFFFF) !=3D MBOX_RSP_SIG) {
> +               dev_warn(&pdev->dev, "Invalid Signature from mbox : %d re=
sponse\n", id);
> +               return ret;
> +       }
> +
> +       val =3D octep_read_sts(mbox);
> +       if (val & MBOX_RC_MASK) {
> +               ret =3D MBOX_RSP_TO_ERR(val);
> +               dev_warn(&pdev->dev, "Error while processing mbox : %d, e=
rr %d\n", id, ret);
> +               return ret;
> +       }
> +
> +       if (!write)
> +               for (i =3D 1; i <=3D data_wds; i++)
> +                       *p++ =3D octep_read32_word(mbox, i);
> +
> +       return 0;
> +}
> +
> +static void octep_mbox_init(struct octep_mbox __iomem *mbox)
> +{
> +       iowrite32(1, &mbox->sts);
> +}
> +
> +int octep_verify_features(u64 features)
> +{
> +       /* Minimum features to expect */
> +       if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> +               return -EOPNOTSUPP;
> +
> +       if (!(features & BIT_ULL(VIRTIO_F_NOTIFICATION_DATA)))
> +               return -EOPNOTSUPP;
> +
> +       if (!(features & BIT_ULL(VIRTIO_F_RING_PACKED)))
> +               return -EOPNOTSUPP;
> +
> +       return 0;
> +}
> +
> +u8 octep_hw_get_status(struct octep_hw *oct_hw)
> +{
> +       return ioread8(&oct_hw->common_cfg->device_status);
> +}
> +
> +void octep_hw_set_status(struct octep_hw *oct_hw, u8 status)
> +{
> +       iowrite8(status, &oct_hw->common_cfg->device_status);
> +}
> +
> +void octep_hw_reset(struct octep_hw *oct_hw)
> +{
> +       u8 val;
> +
> +       octep_hw_set_status(oct_hw, 0 | BIT(DEV_RST_ACK_BIT));
> +       if (readx_poll_timeout(ioread8, &oct_hw->common_cfg->device_statu=
s, val, !val, 10,
> +                              OCTEP_HW_TIMEOUT)) {
> +               dev_warn(&oct_hw->pdev->dev, "Octeon device reset timeout=
\n");
> +               return;
> +       }
> +}
> +
> +static int feature_sel_write_with_timeout(struct octep_hw *oct_hw, u32 s=
elect, void __iomem *addr)
> +{
> +       u32 val;
> +
> +       iowrite32(select | BIT(FEATURE_SEL_ACK_BIT), addr);
> +
> +       if (readx_poll_timeout(ioread32, addr, val, val =3D=3D select, 10=
, OCTEP_HW_TIMEOUT)) {
> +               dev_warn(&oct_hw->pdev->dev, "Feature select%d write time=
out\n", select);
> +               return -1;
> +       }
> +       return 0;
> +}
> +
> +u64 octep_hw_get_dev_features(struct octep_hw *oct_hw)
> +{
> +       u32 features_lo, features_hi;
> +
> +       if (feature_sel_write_with_timeout(oct_hw, 0, &oct_hw->common_cfg=
->device_feature_select))
> +               return 0;
> +
> +       features_lo =3D ioread32(&oct_hw->common_cfg->device_feature);
> +
> +       if (feature_sel_write_with_timeout(oct_hw, 1, &oct_hw->common_cfg=
->device_feature_select))
> +               return 0;
> +
> +       features_hi =3D ioread32(&oct_hw->common_cfg->device_feature);
> +
> +       return ((u64)features_hi << 32) | features_lo;
> +}
> +
> +u64 octep_hw_get_drv_features(struct octep_hw *oct_hw)
> +{
> +       u32 features_lo, features_hi;
> +
> +       if (feature_sel_write_with_timeout(oct_hw, 0, &oct_hw->common_cfg=
->guest_feature_select))
> +               return 0;
> +
> +       features_lo =3D ioread32(&oct_hw->common_cfg->guest_feature);
> +
> +       if (feature_sel_write_with_timeout(oct_hw, 1, &oct_hw->common_cfg=
->guest_feature_select))
> +               return 0;
> +
> +       features_hi =3D ioread32(&oct_hw->common_cfg->guest_feature);
> +
> +       return ((u64)features_hi << 32) | features_lo;
> +}
> +
> +void octep_hw_set_drv_features(struct octep_hw *oct_hw, u64 features)
> +{
> +       if (feature_sel_write_with_timeout(oct_hw, 0, &oct_hw->common_cfg=
->guest_feature_select))
> +               return;
> +
> +       iowrite32(features & (BIT_ULL(32) - 1), &oct_hw->common_cfg->gues=
t_feature);
> +
> +       if (feature_sel_write_with_timeout(oct_hw, 1, &oct_hw->common_cfg=
->guest_feature_select))
> +               return;
> +
> +       iowrite32(features >> 32, &oct_hw->common_cfg->guest_feature);
> +}
> +
> +void octep_write_queue_select(struct octep_hw *oct_hw, u16 queue_id)
> +{
> +       u16 val;
> +
> +       iowrite16(queue_id | BIT(QUEUE_SEL_ACK_BIT), &oct_hw->common_cfg-=
>queue_select);
> +
> +       if (readx_poll_timeout(ioread16, &oct_hw->common_cfg->queue_selec=
t, val, val =3D=3D queue_id,
> +                              10, OCTEP_HW_TIMEOUT)) {
> +               dev_warn(&oct_hw->pdev->dev, "Queue select write timeout\=
n");
> +               return;
> +       }
> +}
> +
> +void octep_notify_queue(struct octep_hw *oct_hw, u16 qid)
> +{
> +       iowrite16(qid, oct_hw->vqs[qid].notify_addr);
> +}
> +
> +void octep_read_dev_config(struct octep_hw *oct_hw, u64 offset, void *ds=
t, int length)
> +{
> +       u8 old_gen, new_gen, *p;
> +       int i;
> +
> +       if (WARN_ON(offset + length > oct_hw->config_size))
> +               return;
> +
> +       do {
> +               old_gen =3D ioread8(&oct_hw->common_cfg->config_generatio=
n);
> +               p =3D dst;
> +               for (i =3D 0; i < length; i++)
> +                       *p++ =3D ioread8(oct_hw->dev_cfg + offset + i);
> +
> +               new_gen =3D ioread8(&oct_hw->common_cfg->config_generatio=
n);
> +       } while (old_gen !=3D new_gen);
> +}
> +
> +int octep_set_vq_address(struct octep_hw *oct_hw, u16 qid, u64 desc_area=
, u64 driver_area,
> +                        u64 device_area)
> +{
> +       struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_cfg;
> +
> +       octep_write_queue_select(oct_hw, qid);
> +       vp_iowrite64_twopart(desc_area, &cfg->queue_desc_lo,
> +                            &cfg->queue_desc_hi);
> +       vp_iowrite64_twopart(driver_area, &cfg->queue_avail_lo,
> +                            &cfg->queue_avail_hi);
> +       vp_iowrite64_twopart(device_area, &cfg->queue_used_lo,
> +                            &cfg->queue_used_hi);
> +
> +       return 0;
> +}
> +
> +int octep_get_vq_state(struct octep_hw *oct_hw, u16 qid, struct vdpa_vq_=
state *state)
> +{
> +       return octep_process_mbox(oct_hw, OCTEP_MBOX_MSG_GET_VQ_STATE, qi=
d, state,
> +                                 sizeof(*state), 0);
> +}
> +
> +int octep_set_vq_state(struct octep_hw *oct_hw, u16 qid, const struct vd=
pa_vq_state *state)
> +{
> +       struct vdpa_vq_state q_state;
> +
> +       memcpy(&q_state, state, sizeof(struct vdpa_vq_state));
> +       return octep_process_mbox(oct_hw, OCTEP_MBOX_MSG_SET_VQ_STATE, qi=
d, &q_state,
> +                                 sizeof(*state), 1);
> +}
> +
> +void octep_set_vq_num(struct octep_hw *oct_hw, u16 qid, u32 num)
> +{
> +       struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_cfg;
> +
> +       octep_write_queue_select(oct_hw, qid);
> +       iowrite16(num, &cfg->queue_size);
> +}
> +
> +void octep_set_vq_ready(struct octep_hw *oct_hw, u16 qid, bool ready)
> +{
> +       struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_cfg;
> +
> +       octep_write_queue_select(oct_hw, qid);
> +       iowrite16(ready, &cfg->queue_enable);
> +}
> +
> +bool octep_get_vq_ready(struct octep_hw *oct_hw, u16 qid)
> +{
> +       struct virtio_pci_common_cfg __iomem *cfg =3D oct_hw->common_cfg;
> +
> +       octep_write_queue_select(oct_hw, qid);
> +       return ioread16(&cfg->queue_enable);
> +}
> +
> +u16 octep_get_vq_size(struct octep_hw *oct_hw)
> +{
> +       octep_write_queue_select(oct_hw, 0);
> +       return ioread16(&oct_hw->common_cfg->queue_size);
> +}
> +
> +static u32 octep_get_config_size(struct octep_hw *oct_hw)
> +{
> +       return sizeof(struct virtio_net_config);
> +}
> +
> +static void __iomem *get_cap_addr(struct octep_hw *oct_hw, struct virtio=
_pci_cap *cap)
> +{
> +       struct device *dev =3D &oct_hw->pdev->dev;
> +       u32 length =3D le32_to_cpu(cap->length);
> +       u32 offset =3D le32_to_cpu(cap->offset);
> +       u8  bar    =3D cap->bar;
> +       u32 len;
> +
> +       if (bar !=3D OCTEP_HW_CAPS_BAR) {
> +               dev_err(dev, "Invalid bar: %u\n", bar);
> +               return NULL;
> +       }
> +       if (offset + length < offset) {
> +               dev_err(dev, "offset(%u) + length(%u) overflows\n",
> +                       offset, length);
> +               return NULL;
> +       }
> +       len =3D pci_resource_len(oct_hw->pdev, bar);
> +       if (offset + length > len) {
> +               dev_err(dev, "invalid cap: overflows bar space: %u > %u\n=
",
> +                       offset + length, len);
> +               return NULL;
> +       }
> +       return oct_hw->base[bar] + offset;
> +}
> +
> +/* In Octeon DPU device, the virtio config space completely
> + * emulated by the device's firmware. So, the standard pci config
> + * read apis can't be used for reading the virtio capabilities.
> + */
> +static void pci_caps_read(struct octep_hw *oct_hw, void *buf, size_t len=
, off_t offset)
> +{
> +       u8 __iomem *bar =3D oct_hw->base[OCTEP_HW_CAPS_BAR];
> +       u8 *p =3D buf;
> +       size_t i;
> +
> +       for (i =3D 0; i < len; i++)
> +               *p++ =3D ioread8(bar + offset + i);
> +}
> +
> +static int pci_signature_verify(struct octep_hw *oct_hw)
> +{
> +       u32 signature[2];
> +
> +       pci_caps_read(oct_hw, &signature, sizeof(signature), 0);
> +
> +       if (signature[0] !=3D OCTEP_FW_READY_SIGNATURE0)
> +               return -1;
> +
> +       if (signature[1] !=3D OCTEP_FW_READY_SIGNATURE1)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
> +{
> +       struct octep_mbox __iomem *mbox;
> +       struct device *dev =3D &pdev->dev;
> +       struct virtio_pci_cap cap;
> +       u16 notify_off;
> +       int i, ret;
> +       u8 pos;
> +
> +       oct_hw->pdev =3D pdev;
> +       ret =3D pci_signature_verify(oct_hw);
> +       if (ret) {
> +               dev_err(dev, "Octeon Virtio FW is not initialized\n");
> +               return -EIO;
> +       }
> +
> +       pci_caps_read(oct_hw, &pos, 1, PCI_CAPABILITY_LIST);
> +
> +       while (pos) {
> +               pci_caps_read(oct_hw, &cap, 2, pos);
> +
> +               if (cap.cap_vndr !=3D PCI_CAP_ID_VNDR) {
> +                       dev_err(dev, "Found invalid capability vndr id: %=
d\n", cap.cap_vndr);
> +                       break;
> +               }
> +
> +               pci_caps_read(oct_hw, &cap, sizeof(cap), pos);
> +
> +               dev_info(dev, "[%2x] cfg type: %u, bar: %u, offset: %04x,=
 len: %u\n",
> +                        pos, cap.cfg_type, cap.bar, cap.offset, cap.leng=
th);
> +
> +               switch (cap.cfg_type) {
> +               case VIRTIO_PCI_CAP_COMMON_CFG:
> +                       oct_hw->common_cfg =3D get_cap_addr(oct_hw, &cap)=
;
> +                       break;
> +               case VIRTIO_PCI_CAP_NOTIFY_CFG:
> +                       pci_caps_read(oct_hw, &oct_hw->notify_off_multipl=
ier,
> +                                     4, pos + sizeof(cap));
> +
> +                       oct_hw->notify_base =3D get_cap_addr(oct_hw, &cap=
);
> +                       oct_hw->notify_bar =3D cap.bar;
> +                       oct_hw->notify_base_pa =3D pci_resource_start(pde=
v, cap.bar) +
> +                                                le32_to_cpu(cap.offset);
> +                       break;
> +               case VIRTIO_PCI_CAP_DEVICE_CFG:
> +                       oct_hw->dev_cfg =3D get_cap_addr(oct_hw, &cap);
> +                       break;
> +               case VIRTIO_PCI_CAP_ISR_CFG:
> +                       oct_hw->isr =3D get_cap_addr(oct_hw, &cap);
> +                       break;
> +               }
> +
> +               pos =3D cap.cap_next;
> +       }
> +       if (!oct_hw->common_cfg || !oct_hw->notify_base ||
> +           !oct_hw->dev_cfg    || !oct_hw->isr) {
> +               dev_err(dev, "Incomplete PCI capabilities");
> +               return -EIO;
> +       }
> +       dev_info(dev, "common cfg mapped at: 0x%016llx\n", (u64)oct_hw->c=
ommon_cfg);
> +       dev_info(dev, "device cfg mapped at: 0x%016llx\n", (u64)oct_hw->d=
ev_cfg);
> +       dev_info(dev, "isr cfg mapped at: 0x%016llx\n", (u64)oct_hw->isr)=
;
> +       dev_info(dev, "notify base: 0x%016llx, notify off multiplier: %u\=
n",
> +                (u64)oct_hw->notify_base, oct_hw->notify_off_multiplier)=
;
> +
> +       oct_hw->config_size =3D octep_get_config_size(oct_hw);
> +       oct_hw->features =3D octep_hw_get_dev_features(oct_hw);
> +
> +       ret =3D octep_verify_features(oct_hw->features);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Octeon Virtio FW is not initialized\=
n");

This error message seems to be misleading, I guess we should say
something like missing features in FW?

> +               return ret;
> +       }
> +       oct_hw->nr_vring =3D vp_ioread16(&oct_hw->common_cfg->num_queues)=
;
> +
> +       oct_hw->vqs =3D devm_kcalloc(&pdev->dev, oct_hw->nr_vring, sizeof=
(*oct_hw->vqs), GFP_KERNEL);
> +       if (!oct_hw->vqs)
> +               return -ENOMEM;
> +
> +       oct_hw->irq =3D -1;
> +
> +       dev_info(&pdev->dev, "Device features : %llx\n", oct_hw->features=
);
> +       dev_info(&pdev->dev, "Maximum queues : %u\n", oct_hw->nr_vring);
> +
> +       for (i =3D 0; i < oct_hw->nr_vring; i++) {
> +               octep_write_queue_select(oct_hw, i);
> +               notify_off =3D vp_ioread16(&oct_hw->common_cfg->queue_not=
ify_off);
> +               oct_hw->vqs[i].notify_addr =3D oct_hw->notify_base +
> +                       notify_off * oct_hw->notify_off_multiplier;
> +               oct_hw->vqs[i].cb_notify_addr =3D (u32 __iomem *)oct_hw->=
vqs[i].notify_addr + 1;
> +               oct_hw->vqs[i].notify_pa =3D oct_hw->notify_base_pa +
> +                       notify_off * oct_hw->notify_off_multiplier;
> +       }
> +       mbox =3D octep_get_mbox(oct_hw);
> +       octep_mbox_init(mbox);
> +       dev_info(dev, "mbox mapped at: 0x%016llx\n", (u64)mbox);
> +
> +       return 0;
> +}
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octe=
on_ep/octep_vdpa_main.c
> new file mode 100644
> index 000000000000..89860a443981
> --- /dev/null
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -0,0 +1,850 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2024 Marvell. */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/iommu.h>
> +#include "octep_vdpa.h"
> +
> +#define OCTEP_VDPA_DRIVER_NAME "octep_vdpa"
> +
> +struct octep_pf {
> +       u8 __iomem *base[PCI_STD_NUM_BARS];
> +       struct pci_dev *pdev;
> +       struct resource res;
> +       u64 vf_base;
> +       int enabled_vfs;
> +       u32 vf_stride;
> +       u16 vf_devid;
> +};
> +
> +struct octep_vdpa {
> +       struct vdpa_device vdpa;
> +       struct octep_hw *oct_hw;
> +       struct pci_dev *pdev;
> +};
> +
> +struct octep_vdpa_mgmt_dev {
> +       struct vdpa_mgmt_dev mdev;
> +       struct octep_hw oct_hw;
> +       struct pci_dev *pdev;
> +       /* Work entry to handle device setup */
> +       struct work_struct setup_task;
> +       /* Device status */
> +       atomic_t status;
> +};
> +
> +static struct octep_hw *vdpa_to_octep_hw(struct vdpa_device *vdpa_dev)
> +{
> +       struct octep_vdpa *oct_vdpa;
> +
> +       oct_vdpa =3D container_of(vdpa_dev, struct octep_vdpa, vdpa);
> +
> +       return oct_vdpa->oct_hw;
> +}
> +
> +static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
> +{
> +       struct octep_hw *oct_hw =3D data;
> +       int i;
> +
> +       for (i =3D 0; i < oct_hw->nr_vring; i++) {
> +               if (oct_hw->vqs[i].cb.callback && ioread32(oct_hw->vqs[i]=
.cb_notify_addr)) {
> +                       /* Acknowledge the per queue notification to the =
device */
> +                       iowrite32(0, oct_hw->vqs[i].cb_notify_addr);
> +                       oct_hw->vqs[i].cb.callback(oct_hw->vqs[i].cb.priv=
ate);
> +               }
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static void octep_free_irqs(struct octep_hw *oct_hw)
> +{
> +       struct pci_dev *pdev =3D oct_hw->pdev;
> +
> +       if (oct_hw->irq !=3D -1) {
> +               devm_free_irq(&pdev->dev, oct_hw->irq, oct_hw);
> +               oct_hw->irq =3D -1;
> +       }
> +       pci_free_irq_vectors(pdev);
> +}
> +
> +static int octep_request_irqs(struct octep_hw *oct_hw)
> +{
> +       struct pci_dev *pdev =3D oct_hw->pdev;
> +       int ret, irq;
> +
> +       /* Currently HW device provisions one IRQ per VF, hence
> +        * allocate one IRQ for all virtqueues call interface.
> +        */
> +       ret =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "Failed to alloc msix vector");
> +               return ret;
> +       }
> +
> +       snprintf(oct_hw->vqs->msix_name, sizeof(oct_hw->vqs->msix_name),
> +                OCTEP_VDPA_DRIVER_NAME "-vf-%d", pci_iov_vf_id(pdev));
> +
> +       irq =3D pci_irq_vector(pdev, 0);
> +       ret =3D devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler=
, 0,
> +                              oct_hw->vqs->msix_name, oct_hw);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to register interrupt handler=
\n");
> +               goto free_irq_vec;
> +       }
> +       oct_hw->irq =3D irq;
> +
> +       return 0;
> +
> +free_irq_vec:
> +       pci_free_irq_vectors(pdev);
> +       return ret;
> +}
> +
> +static u64 octep_vdpa_get_device_features(struct vdpa_device *vdpa_dev)
> +{
> +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +
> +       return oct_hw->features;
> +}
> +
> +static int octep_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, =
u64 features)
> +{
> +       struct octep_hw *oct_hw =3D vdpa_to_octep_hw(vdpa_dev);
> +       int ret;
> +
> +       pr_debug("Driver Features: %llx\n", features);
> +
> +       ret =3D octep_verify_features(features);
> +       if (ret)
> +               return ret;

Nit: I think we need a warning or something here.

Other part looks good.

With those fixed.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

