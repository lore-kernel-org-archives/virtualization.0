Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE055208DA
	for <virtualization@lists.linux.dev>; Sun, 12 May 2024 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516244; cv=none; b=hYCEy0kFxhZ1AXlnRs1580U4Zhi7TE2EQOqdAVxPtraZAzZKQtsMwov4oZOJ6OKYh5YQx4tkobVOeB2TX4wrr7CCyCPO2uscwOAWa/RNygGGZ8xhP9G9Kg9ZumNRWVOVJrUstEB6O+Th/BRAfkCXaJ1LO5nQFGJlxQc48xri1TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516244; c=relaxed/simple;
	bh=eVV6573mcd+QZw9BswoTpG1EMI7N9x2r5EYw0uTCqrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KNR9TT6DeTk/eqv7JgPixGBZVlUeODCk+3FP8Ay8vmHG11mv8MpQjY9siRAAteqezWezSedSkdBtA0I9zUwj0Nft4ZdYFguHwTqgfdUVaQl+J/LEvG/BFAdQpJnsTQEppHEDcROXatn6wad9wX7fO7aca3clya23Gy/dbkG3YWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRo/4qMy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRo/4qMy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715516239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gb2ATDWLvuBEe5OWtmV2bcSJVP1ScPD6TUd+cQqleWU=;
	b=eRo/4qMyHXPkH1y24nglly2AfAuckVKF1icXSwqM1PvzwjrBu/Bt5i1j7RfcFNUAGQ65CZ
	9G12fijR21n72+Hx+AFmtlpQA2wXefO3DLWYEc/QxCHAxt8EPe2cDnh5iU15LMz5spTglF
	NJzMXQ8gB+cpyG8kNO+Tnwmn8k5wQoY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-P1lxgIBFNLSOxvuumvYEFA-1; Sun, 12 May 2024 08:17:17 -0400
X-MC-Unique: P1lxgIBFNLSOxvuumvYEFA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41ec8ef128fso18643085e9.0
        for <virtualization@lists.linux.dev>; Sun, 12 May 2024 05:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715516236; x=1716121036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gb2ATDWLvuBEe5OWtmV2bcSJVP1ScPD6TUd+cQqleWU=;
        b=fOJy8faPn1sBIe61o89yoPppyFZdRahRt3KNCg/QFgxT/do8ZSWyzLjpQgrx0SSnUp
         uRCff6obahDGia56MX4PPvB8EcA79gLnn3YdgXrInZQgpyB4sejY/mhfuuH2XLc7oIZu
         F2MTfKr6TGZ167gHufKXEOZXDwMg3pZ/TX6vrqCN6H8QZlt0aOVVbr/BysuqTPT7eq+8
         KbDC+oOtRAW9GiTYl5aY9vzKD/y6NmdS2jl6gGf2LrhWJnOuS/A4jWeSw8fSXF4lsTMY
         FmZniDT45coMxm+IhZG+c9EJ71d3JGTWLTA7QaPvza1LcuUKxKVoWhfhx3tyAFgNJruR
         A1zg==
X-Gm-Message-State: AOJu0YwGocwCbeZTGoiF1S4FLmXwJEIsjYymSaWT4fkXawVhayQ7LqQj
	tlmaB/lnlpstox0PUqoR9K/P6Q/7WIsvYOO7rcgYJm26+PhTQF6ChLc9+ECLhy2oq2WmjiYFQX9
	GMePdVme+36stfFbYFfV/qKxU82Uz3dOwbi5slbn5qYeAraCAlDiHjhGPI3+v4JAu
X-Received: by 2002:a05:600c:5020:b0:420:1592:da3f with SMTP id 5b1f17b1804b1-4201592e454mr5307375e9.11.1715516235451;
        Sun, 12 May 2024 05:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPWqM5hZvxzSq/eL8aE3N9QCmqmp45NgNSGaEBU/NUH6dAlgiAvWGNFOhUq6qNYajoai7Jtw==
X-Received: by 2002:a05:600c:5020:b0:420:1592:da3f with SMTP id 5b1f17b1804b1-4201592e454mr5307125e9.11.1715516234623;
        Sun, 12 May 2024 05:17:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:9577:55f5:2a79:ee3d:aeb5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfd3sm8813188f8f.84.2024.05.12.05.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 05:17:13 -0700 (PDT)
Date: Sun, 12 May 2024 08:17:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, vattunuru@marvell.com,
	sthotton@marvell.com, ndabilpuram@marvell.com, jerinj@marvell.com
Subject: Re: [PATCH v3] virtio: vdpa: vDPA driver for Marvell OCTEON DPU
 devices
Message-ID: <20240512081605-mutt-send-email-mst@kernel.org>
References: <20240425105053.8427-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240425105053.8427-1-schalla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 25, 2024 at 04:20:53PM +0530, Srujana Challa wrote:
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
> Acked-by: Jason Wang <jasowang@redhat.com>


Dropped due to kbuild failures on mips.
Pls address and repost.
Unlikely to make this merge window at this point but we'll see...

> ---
> v2:
> * Addressed review comments
> v3:
> * Enhanced a few error logs based on the suggestions provided.
> 
>  MAINTAINERS                              |   5 +
>  drivers/vdpa/Kconfig                     |   9 +
>  drivers/vdpa/Makefile                    |   1 +
>  drivers/vdpa/octeon_ep/Makefile          |   4 +
>  drivers/vdpa/octeon_ep/octep_vdpa.h      |  94 +++
>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 517 ++++++++++++++
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c | 855 +++++++++++++++++++++++
>  7 files changed, 1485 insertions(+)
>  create mode 100644 drivers/vdpa/octeon_ep/Makefile
>  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa.h
>  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_hw.c
>  create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_main.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cfe44a876d8a..539ce209a960 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13127,6 +13127,11 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
>  F:	drivers/mmc/host/sdhci-xenon*
>  
> +MARVELL OCTEON ENDPOINT VIRTIO DATA PATH ACCELERATOR
> +R:	schalla@marvell.com
> +R:	vattunuru@marvell.com
> +F:	drivers/vdpa/octeon_ep/
> +
>  MATROX FRAMEBUFFER DRIVER
>  L:	linux-fbdev@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 656c1cb541de..775149fad476 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -126,4 +126,13 @@ config PDS_VDPA
>  	  With this driver, the VirtIO dataplane can be
>  	  offloaded to an AMD/Pensando DSC device.
>  
> +config OCTEONEP_VDPA
> +	tristate "vDPA driver for Octeon DPU devices"
> +	depends on m
> +	depends on PCI_MSI
> +	help
> +	  vDPA driver for Marvell's Octeon DPU devices.
> +	  With this driver, the VirtIO dataplane can be
> +	  offloaded to a Octeon DPU device.
> +
>  endif # VDPA
> diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
> index 8f53c6f3cca7..5654d36707af 100644
> --- a/drivers/vdpa/Makefile
> +++ b/drivers/vdpa/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_VP_VDPA)    += virtio_pci/
>  obj-$(CONFIG_ALIBABA_ENI_VDPA) += alibaba/
>  obj-$(CONFIG_SNET_VDPA) += solidrun/
>  obj-$(CONFIG_PDS_VDPA) += pds/
> +obj-$(CONFIG_OCTEONEP_VDPA) += octeon_ep/
> diff --git a/drivers/vdpa/octeon_ep/Makefile b/drivers/vdpa/octeon_ep/Makefile
> new file mode 100644
> index 000000000000..e23e2ff14f33
> --- /dev/null
> +++ b/drivers/vdpa/octeon_ep/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_OCTEONEP_VDPA) += octep_vdpa.o
> +octep_vdpa-$(CONFIG_OCTEONEP_VDPA) += octep_vdpa_main.o
> +octep_vdpa-$(CONFIG_OCTEONEP_VDPA) += octep_vdpa_hw.o
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep/octep_vdpa.h
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
> +	OCTEP_VDPA_DEV_STATUS_INVALID,
> +	OCTEP_VDPA_DEV_STATUS_ALLOC,
> +	OCTEP_VDPA_DEV_STATUS_WAIT_FOR_BAR_INIT,
> +	OCTEP_VDPA_DEV_STATUS_INIT,
> +	OCTEP_VDPA_DEV_STATUS_READY,
> +	OCTEP_VDPA_DEV_STATUS_UNINIT
> +};
> +
> +struct octep_vring_info {
> +	struct vdpa_callback cb;
> +	void __iomem *notify_addr;
> +	u32 __iomem *cb_notify_addr;
> +	phys_addr_t notify_pa;
> +	char msix_name[256];
> +};
> +
> +struct octep_hw {
> +	struct pci_dev *pdev;
> +	u8 __iomem *base[PCI_STD_NUM_BARS];
> +	struct virtio_pci_common_cfg __iomem *common_cfg;
> +	u8 __iomem *dev_cfg;
> +	u8 __iomem *isr;
> +	void __iomem *notify_base;
> +	phys_addr_t notify_base_pa;
> +	u32 notify_off_multiplier;
> +	u8 notify_bar;
> +	struct octep_vring_info *vqs;
> +	struct vdpa_callback config_cb;
> +	u64 features;
> +	u16 nr_vring;
> +	u32 config_size;
> +	int irq;
> +};
> +
> +u8 octep_hw_get_status(struct octep_hw *oct_hw);
> +void octep_hw_set_status(struct octep_hw *dev, uint8_t status);
> +void octep_hw_reset(struct octep_hw *oct_hw);
> +void octep_write_queue_select(struct octep_hw *oct_hw, u16 queue_id);
> +void octep_notify_queue(struct octep_hw *oct_hw, u16 qid);
> +void octep_read_dev_config(struct octep_hw *oct_hw, u64 offset, void *dst, int length);
> +int octep_set_vq_address(struct octep_hw *oct_hw, u16 qid, u64 desc_area, u64 driver_area,
> +			 u64 device_area);
> +void octep_set_vq_num(struct octep_hw *oct_hw, u16 qid, u32 num);
> +void octep_set_vq_ready(struct octep_hw *oct_hw, u16 qid, bool ready);
> +bool octep_get_vq_ready(struct octep_hw *oct_hw, u16 qid);
> +int octep_set_vq_state(struct octep_hw *oct_hw, u16 qid, const struct vdpa_vq_state *state);
> +int octep_get_vq_state(struct octep_hw *oct_hw, u16 qid, struct vdpa_vq_state *state);
> +u16 octep_get_vq_size(struct octep_hw *oct_hw);
> +int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev);
> +u64 octep_hw_get_dev_features(struct octep_hw *oct_hw);
> +void octep_hw_set_drv_features(struct octep_hw *oct_hw, u64 features);
> +u64 octep_hw_get_drv_features(struct octep_hw *oct_hw);
> +int octep_verify_features(u64 features);
> +
> +#endif /* __OCTEP_VDPA_H__ */
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> new file mode 100644
> index 000000000000..a2975be75889
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
> +	OCTEP_MBOX_MSG_SET_VQ_STATE = 1,
> +	OCTEP_MBOX_MSG_GET_VQ_STATE,
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
> +	u8 ver;
> +	u8 rsvd1;
> +	u16 id;
> +	u16 rsvd2;
> +#define MBOX_REQ_SIG (0xdead)
> +#define MBOX_RSP_SIG (0xbeef)
> +	u16 sig;
> +};
> +
> +struct octep_mbox_sts {
> +	u16 rsp:1;
> +	u16 rc:15;
> +	u16 rsvd;
> +};
> +
> +struct octep_mbox {
> +	struct octep_mbox_hdr hdr;
> +	struct octep_mbox_sts sts;
> +	u64 rsvd;
> +	u32 data[];
> +};
> +
> +static inline struct octep_mbox __iomem *octep_get_mbox(struct octep_hw *oct_hw)
> +{
> +	return (struct octep_mbox __iomem *)(oct_hw->dev_cfg + MBOX_OFFSET);
> +}
> +
> +static inline int octep_wait_for_mbox_avail(struct octep_mbox __iomem *mbox)
> +{
> +	u32 val;
> +
> +	return readx_poll_timeout(ioread32, &mbox->sts, val, MBOX_AVAIL(val), 10,
> +				  OCTEP_HW_TIMEOUT);
> +}
> +
> +static inline int octep_wait_for_mbox_rsp(struct octep_mbox __iomem *mbox)
> +{
> +	u32 val;
> +
> +	return readx_poll_timeout(ioread32, &mbox->sts, val, MBOX_RSP(val), 10,
> +				  OCTEP_HW_TIMEOUT);
> +}
> +
> +static inline void octep_write_hdr(struct octep_mbox __iomem *mbox, u16 id, u16 sig)
> +{
> +	iowrite16(id, &mbox->hdr.id);
> +	iowrite16(sig, &mbox->hdr.sig);
> +}
> +
> +static inline u32 octep_read_sig(struct octep_mbox __iomem *mbox)
> +{
> +	return ioread16(&mbox->hdr.sig);
> +}
> +
> +static inline void octep_write_sts(struct octep_mbox __iomem *mbox, u32 sts)
> +{
> +	iowrite32(sts, &mbox->sts);
> +}
> +
> +static inline u32 octep_read_sts(struct octep_mbox __iomem *mbox)
> +{
> +	return ioread32(&mbox->sts);
> +}
> +
> +static inline u32 octep_read32_word(struct octep_mbox __iomem *mbox, u16 word_idx)
> +{
> +	return ioread32(&mbox->data[word_idx]);
> +}
> +
> +static inline void octep_write32_word(struct octep_mbox __iomem *mbox, u16 word_idx, u32 word)
> +{
> +	return iowrite32(word, &mbox->data[word_idx]);
> +}
> +
> +static int octep_process_mbox(struct octep_hw *oct_hw, u16 id, u16 qid, void *buffer,
> +			      u32 buf_size, bool write)
> +{
> +	struct octep_mbox __iomem *mbox = octep_get_mbox(oct_hw);
> +	struct pci_dev *pdev = oct_hw->pdev;
> +	u32 *p = (u32 *)buffer;
> +	u16 data_wds;
> +	int ret, i;
> +	u32 val;
> +
> +	if (!IS_ALIGNED(buf_size, 4))
> +		return -EINVAL;
> +
> +	/* Make sure mbox space is available */
> +	ret = octep_wait_for_mbox_avail(mbox);
> +	if (ret) {
> +		dev_warn(&pdev->dev, "Timeout waiting for previous mbox data to be consumed\n");
> +		return ret;
> +	}
> +	data_wds = buf_size / 4;
> +
> +	if (write) {
> +		for (i = 1; i <= data_wds; i++) {
> +			octep_write32_word(mbox, i, *p);
> +			p++;
> +		}
> +	}
> +	octep_write32_word(mbox, 0, (u32)qid);
> +	octep_write_sts(mbox, 0);
> +
> +	octep_write_hdr(mbox, id, MBOX_REQ_SIG);
> +
> +	ret = octep_wait_for_mbox_rsp(mbox);
> +	if (ret) {
> +		dev_warn(&pdev->dev, "Timeout waiting for mbox : %d response\n", id);
> +		return ret;
> +	}
> +
> +	val = octep_read_sig(mbox);
> +	if ((val & 0xFFFF) != MBOX_RSP_SIG) {
> +		dev_warn(&pdev->dev, "Invalid Signature from mbox : %d response\n", id);
> +		return ret;
> +	}
> +
> +	val = octep_read_sts(mbox);
> +	if (val & MBOX_RC_MASK) {
> +		ret = MBOX_RSP_TO_ERR(val);
> +		dev_warn(&pdev->dev, "Error while processing mbox : %d, err %d\n", id, ret);
> +		return ret;
> +	}
> +
> +	if (!write)
> +		for (i = 1; i <= data_wds; i++)
> +			*p++ = octep_read32_word(mbox, i);
> +
> +	return 0;
> +}
> +
> +static void octep_mbox_init(struct octep_mbox __iomem *mbox)
> +{
> +	iowrite32(1, &mbox->sts);
> +}
> +
> +int octep_verify_features(u64 features)
> +{
> +	/* Minimum features to expect */
> +	if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> +		return -EOPNOTSUPP;
> +
> +	if (!(features & BIT_ULL(VIRTIO_F_NOTIFICATION_DATA)))
> +		return -EOPNOTSUPP;
> +
> +	if (!(features & BIT_ULL(VIRTIO_F_RING_PACKED)))
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +u8 octep_hw_get_status(struct octep_hw *oct_hw)
> +{
> +	return ioread8(&oct_hw->common_cfg->device_status);
> +}
> +
> +void octep_hw_set_status(struct octep_hw *oct_hw, u8 status)
> +{
> +	iowrite8(status, &oct_hw->common_cfg->device_status);
> +}
> +
> +void octep_hw_reset(struct octep_hw *oct_hw)
> +{
> +	u8 val;
> +
> +	octep_hw_set_status(oct_hw, 0 | BIT(DEV_RST_ACK_BIT));
> +	if (readx_poll_timeout(ioread8, &oct_hw->common_cfg->device_status, val, !val, 10,
> +			       OCTEP_HW_TIMEOUT)) {
> +		dev_warn(&oct_hw->pdev->dev, "Octeon device reset timeout\n");
> +		return;
> +	}
> +}
> +
> +static int feature_sel_write_with_timeout(struct octep_hw *oct_hw, u32 select, void __iomem *addr)
> +{
> +	u32 val;
> +
> +	iowrite32(select | BIT(FEATURE_SEL_ACK_BIT), addr);
> +
> +	if (readx_poll_timeout(ioread32, addr, val, val == select, 10, OCTEP_HW_TIMEOUT)) {
> +		dev_warn(&oct_hw->pdev->dev, "Feature select%d write timeout\n", select);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +u64 octep_hw_get_dev_features(struct octep_hw *oct_hw)
> +{
> +	u32 features_lo, features_hi;
> +
> +	if (feature_sel_write_with_timeout(oct_hw, 0, &oct_hw->common_cfg->device_feature_select))
> +		return 0;
> +
> +	features_lo = ioread32(&oct_hw->common_cfg->device_feature);
> +
> +	if (feature_sel_write_with_timeout(oct_hw, 1, &oct_hw->common_cfg->device_feature_select))
> +		return 0;
> +
> +	features_hi = ioread32(&oct_hw->common_cfg->device_feature);
> +
> +	return ((u64)features_hi << 32) | features_lo;
> +}
> +
> +u64 octep_hw_get_drv_features(struct octep_hw *oct_hw)
> +{
> +	u32 features_lo, features_hi;
> +
> +	if (feature_sel_write_with_timeout(oct_hw, 0, &oct_hw->common_cfg->guest_feature_select))
> +		return 0;
> +
> +	features_lo = ioread32(&oct_hw->common_cfg->guest_feature);
> +
> +	if (feature_sel_write_with_timeout(oct_hw, 1, &oct_hw->common_cfg->guest_feature_select))
> +		return 0;
> +
> +	features_hi = ioread32(&oct_hw->common_cfg->guest_feature);
> +
> +	return ((u64)features_hi << 32) | features_lo;
> +}
> +
> +void octep_hw_set_drv_features(struct octep_hw *oct_hw, u64 features)
> +{
> +	if (feature_sel_write_with_timeout(oct_hw, 0, &oct_hw->common_cfg->guest_feature_select))
> +		return;
> +
> +	iowrite32(features & (BIT_ULL(32) - 1), &oct_hw->common_cfg->guest_feature);
> +
> +	if (feature_sel_write_with_timeout(oct_hw, 1, &oct_hw->common_cfg->guest_feature_select))
> +		return;
> +
> +	iowrite32(features >> 32, &oct_hw->common_cfg->guest_feature);
> +}
> +
> +void octep_write_queue_select(struct octep_hw *oct_hw, u16 queue_id)
> +{
> +	u16 val;
> +
> +	iowrite16(queue_id | BIT(QUEUE_SEL_ACK_BIT), &oct_hw->common_cfg->queue_select);
> +
> +	if (readx_poll_timeout(ioread16, &oct_hw->common_cfg->queue_select, val, val == queue_id,
> +			       10, OCTEP_HW_TIMEOUT)) {
> +		dev_warn(&oct_hw->pdev->dev, "Queue select write timeout\n");
> +		return;
> +	}
> +}
> +
> +void octep_notify_queue(struct octep_hw *oct_hw, u16 qid)
> +{
> +	iowrite16(qid, oct_hw->vqs[qid].notify_addr);
> +}
> +
> +void octep_read_dev_config(struct octep_hw *oct_hw, u64 offset, void *dst, int length)
> +{
> +	u8 old_gen, new_gen, *p;
> +	int i;
> +
> +	if (WARN_ON(offset + length > oct_hw->config_size))
> +		return;
> +
> +	do {
> +		old_gen = ioread8(&oct_hw->common_cfg->config_generation);
> +		p = dst;
> +		for (i = 0; i < length; i++)
> +			*p++ = ioread8(oct_hw->dev_cfg + offset + i);
> +
> +		new_gen = ioread8(&oct_hw->common_cfg->config_generation);
> +	} while (old_gen != new_gen);
> +}
> +
> +int octep_set_vq_address(struct octep_hw *oct_hw, u16 qid, u64 desc_area, u64 driver_area,
> +			 u64 device_area)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = oct_hw->common_cfg;
> +
> +	octep_write_queue_select(oct_hw, qid);
> +	vp_iowrite64_twopart(desc_area, &cfg->queue_desc_lo,
> +			     &cfg->queue_desc_hi);
> +	vp_iowrite64_twopart(driver_area, &cfg->queue_avail_lo,
> +			     &cfg->queue_avail_hi);
> +	vp_iowrite64_twopart(device_area, &cfg->queue_used_lo,
> +			     &cfg->queue_used_hi);
> +
> +	return 0;
> +}
> +
> +int octep_get_vq_state(struct octep_hw *oct_hw, u16 qid, struct vdpa_vq_state *state)
> +{
> +	return octep_process_mbox(oct_hw, OCTEP_MBOX_MSG_GET_VQ_STATE, qid, state,
> +				  sizeof(*state), 0);
> +}
> +
> +int octep_set_vq_state(struct octep_hw *oct_hw, u16 qid, const struct vdpa_vq_state *state)
> +{
> +	struct vdpa_vq_state q_state;
> +
> +	memcpy(&q_state, state, sizeof(struct vdpa_vq_state));
> +	return octep_process_mbox(oct_hw, OCTEP_MBOX_MSG_SET_VQ_STATE, qid, &q_state,
> +				  sizeof(*state), 1);
> +}
> +
> +void octep_set_vq_num(struct octep_hw *oct_hw, u16 qid, u32 num)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = oct_hw->common_cfg;
> +
> +	octep_write_queue_select(oct_hw, qid);
> +	iowrite16(num, &cfg->queue_size);
> +}
> +
> +void octep_set_vq_ready(struct octep_hw *oct_hw, u16 qid, bool ready)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = oct_hw->common_cfg;
> +
> +	octep_write_queue_select(oct_hw, qid);
> +	iowrite16(ready, &cfg->queue_enable);
> +}
> +
> +bool octep_get_vq_ready(struct octep_hw *oct_hw, u16 qid)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = oct_hw->common_cfg;
> +
> +	octep_write_queue_select(oct_hw, qid);
> +	return ioread16(&cfg->queue_enable);
> +}
> +
> +u16 octep_get_vq_size(struct octep_hw *oct_hw)
> +{
> +	octep_write_queue_select(oct_hw, 0);
> +	return ioread16(&oct_hw->common_cfg->queue_size);
> +}
> +
> +static u32 octep_get_config_size(struct octep_hw *oct_hw)
> +{
> +	return sizeof(struct virtio_net_config);
> +}
> +
> +static void __iomem *get_cap_addr(struct octep_hw *oct_hw, struct virtio_pci_cap *cap)
> +{
> +	struct device *dev = &oct_hw->pdev->dev;
> +	u32 length = le32_to_cpu(cap->length);
> +	u32 offset = le32_to_cpu(cap->offset);
> +	u8  bar    = cap->bar;
> +	u32 len;
> +
> +	if (bar != OCTEP_HW_CAPS_BAR) {
> +		dev_err(dev, "Invalid bar: %u\n", bar);
> +		return NULL;
> +	}
> +	if (offset + length < offset) {
> +		dev_err(dev, "offset(%u) + length(%u) overflows\n",
> +			offset, length);
> +		return NULL;
> +	}
> +	len = pci_resource_len(oct_hw->pdev, bar);
> +	if (offset + length > len) {
> +		dev_err(dev, "invalid cap: overflows bar space: %u > %u\n",
> +			offset + length, len);
> +		return NULL;
> +	}
> +	return oct_hw->base[bar] + offset;
> +}
> +
> +/* In Octeon DPU device, the virtio config space completely
> + * emulated by the device's firmware. So, the standard pci config
> + * read apis can't be used for reading the virtio capabilities.
> + */
> +static void pci_caps_read(struct octep_hw *oct_hw, void *buf, size_t len, off_t offset)
> +{
> +	u8 __iomem *bar = oct_hw->base[OCTEP_HW_CAPS_BAR];
> +	u8 *p = buf;
> +	size_t i;
> +
> +	for (i = 0; i < len; i++)
> +		*p++ = ioread8(bar + offset + i);
> +}
> +
> +static int pci_signature_verify(struct octep_hw *oct_hw)
> +{
> +	u32 signature[2];
> +
> +	pci_caps_read(oct_hw, &signature, sizeof(signature), 0);
> +
> +	if (signature[0] != OCTEP_FW_READY_SIGNATURE0)
> +		return -1;
> +
> +	if (signature[1] != OCTEP_FW_READY_SIGNATURE1)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
> +{
> +	struct octep_mbox __iomem *mbox;
> +	struct device *dev = &pdev->dev;
> +	struct virtio_pci_cap cap;
> +	u16 notify_off;
> +	int i, ret;
> +	u8 pos;
> +
> +	oct_hw->pdev = pdev;
> +	ret = pci_signature_verify(oct_hw);
> +	if (ret) {
> +		dev_err(dev, "Octeon Virtio FW is not initialized\n");
> +		return -EIO;
> +	}
> +
> +	pci_caps_read(oct_hw, &pos, 1, PCI_CAPABILITY_LIST);
> +
> +	while (pos) {
> +		pci_caps_read(oct_hw, &cap, 2, pos);
> +
> +		if (cap.cap_vndr != PCI_CAP_ID_VNDR) {
> +			dev_err(dev, "Found invalid capability vndr id: %d\n", cap.cap_vndr);
> +			break;
> +		}
> +
> +		pci_caps_read(oct_hw, &cap, sizeof(cap), pos);
> +
> +		dev_info(dev, "[%2x] cfg type: %u, bar: %u, offset: %04x, len: %u\n",
> +			 pos, cap.cfg_type, cap.bar, cap.offset, cap.length);
> +
> +		switch (cap.cfg_type) {
> +		case VIRTIO_PCI_CAP_COMMON_CFG:
> +			oct_hw->common_cfg = get_cap_addr(oct_hw, &cap);
> +			break;
> +		case VIRTIO_PCI_CAP_NOTIFY_CFG:
> +			pci_caps_read(oct_hw, &oct_hw->notify_off_multiplier,
> +				      4, pos + sizeof(cap));
> +
> +			oct_hw->notify_base = get_cap_addr(oct_hw, &cap);
> +			oct_hw->notify_bar = cap.bar;
> +			oct_hw->notify_base_pa = pci_resource_start(pdev, cap.bar) +
> +						 le32_to_cpu(cap.offset);
> +			break;
> +		case VIRTIO_PCI_CAP_DEVICE_CFG:
> +			oct_hw->dev_cfg = get_cap_addr(oct_hw, &cap);
> +			break;
> +		case VIRTIO_PCI_CAP_ISR_CFG:
> +			oct_hw->isr = get_cap_addr(oct_hw, &cap);
> +			break;
> +		}
> +
> +		pos = cap.cap_next;
> +	}
> +	if (!oct_hw->common_cfg || !oct_hw->notify_base ||
> +	    !oct_hw->dev_cfg    || !oct_hw->isr) {
> +		dev_err(dev, "Incomplete PCI capabilities");
> +		return -EIO;
> +	}
> +	dev_info(dev, "common cfg mapped at: 0x%016llx\n", (u64)oct_hw->common_cfg);
> +	dev_info(dev, "device cfg mapped at: 0x%016llx\n", (u64)oct_hw->dev_cfg);
> +	dev_info(dev, "isr cfg mapped at: 0x%016llx\n", (u64)oct_hw->isr);
> +	dev_info(dev, "notify base: 0x%016llx, notify off multiplier: %u\n",
> +		 (u64)oct_hw->notify_base, oct_hw->notify_off_multiplier);
> +
> +	oct_hw->config_size = octep_get_config_size(oct_hw);
> +	oct_hw->features = octep_hw_get_dev_features(oct_hw);
> +
> +	ret = octep_verify_features(oct_hw->features);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't read features from the device FW\n");
> +		return ret;
> +	}
> +	oct_hw->nr_vring = vp_ioread16(&oct_hw->common_cfg->num_queues);
> +
> +	oct_hw->vqs = devm_kcalloc(&pdev->dev, oct_hw->nr_vring, sizeof(*oct_hw->vqs), GFP_KERNEL);
> +	if (!oct_hw->vqs)
> +		return -ENOMEM;
> +
> +	oct_hw->irq = -1;
> +
> +	dev_info(&pdev->dev, "Device features : %llx\n", oct_hw->features);
> +	dev_info(&pdev->dev, "Maximum queues : %u\n", oct_hw->nr_vring);
> +
> +	for (i = 0; i < oct_hw->nr_vring; i++) {
> +		octep_write_queue_select(oct_hw, i);
> +		notify_off = vp_ioread16(&oct_hw->common_cfg->queue_notify_off);
> +		oct_hw->vqs[i].notify_addr = oct_hw->notify_base +
> +			notify_off * oct_hw->notify_off_multiplier;
> +		oct_hw->vqs[i].cb_notify_addr = (u32 __iomem *)oct_hw->vqs[i].notify_addr + 1;
> +		oct_hw->vqs[i].notify_pa = oct_hw->notify_base_pa +
> +			notify_off * oct_hw->notify_off_multiplier;
> +	}
> +	mbox = octep_get_mbox(oct_hw);
> +	octep_mbox_init(mbox);
> +	dev_info(dev, "mbox mapped at: 0x%016llx\n", (u64)mbox);
> +
> +	return 0;
> +}
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> new file mode 100644
> index 000000000000..e8c6c70ba919
> --- /dev/null
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -0,0 +1,855 @@
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
> +	u8 __iomem *base[PCI_STD_NUM_BARS];
> +	struct pci_dev *pdev;
> +	struct resource res;
> +	u64 vf_base;
> +	int enabled_vfs;
> +	u32 vf_stride;
> +	u16 vf_devid;
> +};
> +
> +struct octep_vdpa {
> +	struct vdpa_device vdpa;
> +	struct octep_hw *oct_hw;
> +	struct pci_dev *pdev;
> +};
> +
> +struct octep_vdpa_mgmt_dev {
> +	struct vdpa_mgmt_dev mdev;
> +	struct octep_hw oct_hw;
> +	struct pci_dev *pdev;
> +	/* Work entry to handle device setup */
> +	struct work_struct setup_task;
> +	/* Device status */
> +	atomic_t status;
> +};
> +
> +static struct octep_hw *vdpa_to_octep_hw(struct vdpa_device *vdpa_dev)
> +{
> +	struct octep_vdpa *oct_vdpa;
> +
> +	oct_vdpa = container_of(vdpa_dev, struct octep_vdpa, vdpa);
> +
> +	return oct_vdpa->oct_hw;
> +}
> +
> +static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
> +{
> +	struct octep_hw *oct_hw = data;
> +	int i;
> +
> +	for (i = 0; i < oct_hw->nr_vring; i++) {
> +		if (oct_hw->vqs[i].cb.callback && ioread32(oct_hw->vqs[i].cb_notify_addr)) {
> +			/* Acknowledge the per queue notification to the device */
> +			iowrite32(0, oct_hw->vqs[i].cb_notify_addr);
> +			oct_hw->vqs[i].cb.callback(oct_hw->vqs[i].cb.private);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void octep_free_irqs(struct octep_hw *oct_hw)
> +{
> +	struct pci_dev *pdev = oct_hw->pdev;
> +
> +	if (oct_hw->irq != -1) {
> +		devm_free_irq(&pdev->dev, oct_hw->irq, oct_hw);
> +		oct_hw->irq = -1;
> +	}
> +	pci_free_irq_vectors(pdev);
> +}
> +
> +static int octep_request_irqs(struct octep_hw *oct_hw)
> +{
> +	struct pci_dev *pdev = oct_hw->pdev;
> +	int ret, irq;
> +
> +	/* Currently HW device provisions one IRQ per VF, hence
> +	 * allocate one IRQ for all virtqueues call interface.
> +	 */
> +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to alloc msix vector");
> +		return ret;
> +	}
> +
> +	snprintf(oct_hw->vqs->msix_name, sizeof(oct_hw->vqs->msix_name),
> +		 OCTEP_VDPA_DRIVER_NAME "-vf-%d", pci_iov_vf_id(pdev));
> +
> +	irq = pci_irq_vector(pdev, 0);
> +	ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
> +			       oct_hw->vqs->msix_name, oct_hw);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register interrupt handler\n");
> +		goto free_irq_vec;
> +	}
> +	oct_hw->irq = irq;
> +
> +	return 0;
> +
> +free_irq_vec:
> +	pci_free_irq_vectors(pdev);
> +	return ret;
> +}
> +
> +static u64 octep_vdpa_get_device_features(struct vdpa_device *vdpa_dev)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	return oct_hw->features;
> +}
> +
> +static int octep_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 features)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +	int ret;
> +
> +	pr_debug("Driver Features: %llx\n", features);
> +
> +	ret = octep_verify_features(features);
> +	if (ret) {
> +		dev_warn(&oct_hw->pdev->dev,
> +			 "Must negotiate minimum features 0x%llx for this device",
> +			 BIT_ULL(VIRTIO_F_VERSION_1) | BIT_ULL(VIRTIO_F_NOTIFICATION_DATA) |
> +			 BIT_ULL(VIRTIO_F_RING_PACKED));
> +		return ret;
> +	}
> +	octep_hw_set_drv_features(oct_hw, features);
> +
> +	return 0;
> +}
> +
> +static u64 octep_vdpa_get_driver_features(struct vdpa_device *vdpa_dev)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	return octep_hw_get_drv_features(oct_hw);
> +}
> +
> +static u8 octep_vdpa_get_status(struct vdpa_device *vdpa_dev)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	return octep_hw_get_status(oct_hw);
> +}
> +
> +static void octep_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +	u8 status_old;
> +
> +	status_old = octep_hw_get_status(oct_hw);
> +
> +	if (status_old == status)
> +		return;
> +
> +	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +	    !(status_old & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +		if (octep_request_irqs(oct_hw))
> +			status = status_old | VIRTIO_CONFIG_S_FAILED;
> +	}
> +	octep_hw_set_status(oct_hw, status);
> +}
> +
> +static int octep_vdpa_reset(struct vdpa_device *vdpa_dev)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +	u8 status = octep_hw_get_status(oct_hw);
> +	u16 qid;
> +
> +	if (status == 0)
> +		return 0;
> +
> +	for (qid = 0; qid < oct_hw->nr_vring; qid++) {
> +		oct_hw->vqs[qid].cb.callback = NULL;
> +		oct_hw->vqs[qid].cb.private = NULL;
> +		oct_hw->config_cb.callback = NULL;
> +		oct_hw->config_cb.private = NULL;
> +	}
> +	octep_hw_reset(oct_hw);
> +
> +	if (status & VIRTIO_CONFIG_S_DRIVER_OK)
> +		octep_free_irqs(oct_hw);
> +
> +	return 0;
> +}
> +
> +static u16 octep_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	return octep_get_vq_size(oct_hw);
> +}
> +
> +static int octep_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
> +				   struct vdpa_vq_state *state)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	return octep_get_vq_state(oct_hw, qid, state);
> +}
> +
> +static int octep_vdpa_set_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
> +				   const struct vdpa_vq_state *state)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	return octep_set_vq_state(oct_hw, qid, state);
> +}
> +
> +static void octep_vdpa_set_vq_cb(struct vdpa_device *vdpa_dev, u16 qid, struct vdpa_callback *cb)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	oct_hw->vqs[qid].cb = *cb;
> +}
> +
> +static void octep_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16 qid, bool ready)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	octep_set_vq_ready(oct_hw, qid, ready);
> +}
> +
> +static bool octep_vdpa_get_vq_ready(struct vdpa_device *vdpa_dev, u16 qid)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	return octep_get_vq_ready(oct_hw, qid);
> +}
> +
> +static void octep_vdpa_set_vq_num(struct vdpa_device *vdpa_dev, u16 qid, u32 num)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	octep_set_vq_num(oct_hw, qid, num);
> +}
> +
> +static int octep_vdpa_set_vq_address(struct vdpa_device *vdpa_dev, u16 qid, u64 desc_area,
> +				     u64 driver_area, u64 device_area)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	pr_debug("qid[%d]: desc_area: %llx\n", qid, desc_area);
> +	pr_debug("qid[%d]: driver_area: %llx\n", qid, driver_area);
> +	pr_debug("qid[%d]: device_area: %llx\n\n", qid, device_area);
> +
> +	return octep_set_vq_address(oct_hw, qid, desc_area, driver_area, device_area);
> +}
> +
> +static void octep_vdpa_kick_vq(struct vdpa_device *vdpa_dev, u16 qid)
> +{
> +	/* Not supported */
> +}
> +
> +static void octep_vdpa_kick_vq_with_data(struct vdpa_device *vdpa_dev, u32 data)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +	u16 idx = data & 0xFFFF;
> +
> +	vp_iowrite32(data, oct_hw->vqs[idx].notify_addr);
> +}
> +
> +static u32 octep_vdpa_get_generation(struct vdpa_device *vdpa_dev)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	return vp_ioread8(&oct_hw->common_cfg->config_generation);
> +}
> +
> +static u32 octep_vdpa_get_device_id(struct vdpa_device *vdpa_dev)
> +{
> +	return VIRTIO_ID_NET;
> +}
> +
> +static u32 octep_vdpa_get_vendor_id(struct vdpa_device *vdpa_dev)
> +{
> +	return PCI_VENDOR_ID_CAVIUM;
> +}
> +
> +static u32 octep_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
> +{
> +	return PAGE_SIZE;
> +}
> +
> +static size_t octep_vdpa_get_config_size(struct vdpa_device *vdpa_dev)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	return oct_hw->config_size;
> +}
> +
> +static void octep_vdpa_get_config(struct vdpa_device *vdpa_dev, unsigned int offset, void *buf,
> +				  unsigned int len)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	octep_read_dev_config(oct_hw, offset, buf, len);
> +}
> +
> +static void octep_vdpa_set_config(struct vdpa_device *vdpa_dev, unsigned int offset,
> +				  const void *buf, unsigned int len)
> +{
> +	/* Not supported */
> +}
> +
> +static void octep_vdpa_set_config_cb(struct vdpa_device *vdpa_dev, struct vdpa_callback *cb)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +
> +	oct_hw->config_cb.callback = cb->callback;
> +	oct_hw->config_cb.private = cb->private;
> +}
> +
> +static struct vdpa_notification_area octep_get_vq_notification(struct vdpa_device *vdpa_dev,
> +							       u16 idx)
> +{
> +	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
> +	struct vdpa_notification_area area;
> +
> +	area.addr = oct_hw->vqs[idx].notify_pa;
> +	area.size = PAGE_SIZE;
> +
> +	return area;
> +}
> +
> +static struct vdpa_config_ops octep_vdpa_ops = {
> +	.get_device_features = octep_vdpa_get_device_features,
> +	.set_driver_features = octep_vdpa_set_driver_features,
> +	.get_driver_features = octep_vdpa_get_driver_features,
> +	.get_status	= octep_vdpa_get_status,
> +	.set_status	= octep_vdpa_set_status,
> +	.reset		= octep_vdpa_reset,
> +	.get_vq_num_max	= octep_vdpa_get_vq_num_max,
> +	.get_vq_state	= octep_vdpa_get_vq_state,
> +	.set_vq_state	= octep_vdpa_set_vq_state,
> +	.set_vq_cb	= octep_vdpa_set_vq_cb,
> +	.set_vq_ready	= octep_vdpa_set_vq_ready,
> +	.get_vq_ready	= octep_vdpa_get_vq_ready,
> +	.set_vq_num	= octep_vdpa_set_vq_num,
> +	.set_vq_address	= octep_vdpa_set_vq_address,
> +	.get_vq_irq	= NULL,
> +	.kick_vq	= octep_vdpa_kick_vq,
> +	.kick_vq_with_data	= octep_vdpa_kick_vq_with_data,
> +	.get_generation	= octep_vdpa_get_generation,
> +	.get_device_id	= octep_vdpa_get_device_id,
> +	.get_vendor_id	= octep_vdpa_get_vendor_id,
> +	.get_vq_align	= octep_vdpa_get_vq_align,
> +	.get_config_size	= octep_vdpa_get_config_size,
> +	.get_config	= octep_vdpa_get_config,
> +	.set_config	= octep_vdpa_set_config,
> +	.set_config_cb  = octep_vdpa_set_config_cb,
> +	.get_vq_notification = octep_get_vq_notification,
> +};
> +
> +static int octep_iomap_region(struct pci_dev *pdev, u8 __iomem **tbl, u8 bar)
> +{
> +	int ret;
> +
> +	ret = pci_request_region(pdev, bar, OCTEP_VDPA_DRIVER_NAME);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request BAR:%u region\n", bar);
> +		return ret;
> +	}
> +
> +	tbl[bar] = pci_iomap(pdev, bar, pci_resource_len(pdev, bar));
> +	if (!tbl[bar]) {
> +		dev_err(&pdev->dev, "Failed to iomap BAR:%u\n", bar);
> +		pci_release_region(pdev, bar);
> +		ret = -ENOMEM;
> +	}
> +
> +	return ret;
> +}
> +
> +static void octep_iounmap_region(struct pci_dev *pdev, u8 __iomem **tbl, u8 bar)
> +{
> +	pci_iounmap(pdev, tbl[bar]);
> +	pci_release_region(pdev, bar);
> +}
> +
> +static void octep_vdpa_pf_bar_shrink(struct octep_pf *octpf)
> +{
> +	struct pci_dev *pf_dev = octpf->pdev;
> +	struct resource *res = pf_dev->resource + PCI_STD_RESOURCES + 4;
> +	struct pci_bus_region bus_region;
> +
> +	octpf->res.start = res->start;
> +	octpf->res.end = res->end;
> +	octpf->vf_base = res->start;
> +
> +	bus_region.start = res->start;
> +	bus_region.end = res->start - 1;
> +
> +	pcibios_bus_to_resource(pf_dev->bus, res, &bus_region);
> +}
> +
> +static void octep_vdpa_pf_bar_expand(struct octep_pf *octpf)
> +{
> +	struct pci_dev *pf_dev = octpf->pdev;
> +	struct resource *res = pf_dev->resource + PCI_STD_RESOURCES + 4;
> +	struct pci_bus_region bus_region;
> +
> +	bus_region.start = octpf->res.start;
> +	bus_region.end = octpf->res.end;
> +
> +	pcibios_bus_to_resource(pf_dev->bus, res, &bus_region);
> +}
> +
> +static void octep_vdpa_remove_pf(struct pci_dev *pdev)
> +{
> +	struct octep_pf *octpf = pci_get_drvdata(pdev);
> +
> +	pci_disable_sriov(pdev);
> +
> +	if (octpf->base[OCTEP_HW_CAPS_BAR])
> +		octep_iounmap_region(pdev, octpf->base, OCTEP_HW_CAPS_BAR);
> +
> +	if (octpf->base[OCTEP_HW_MBOX_BAR])
> +		octep_iounmap_region(pdev, octpf->base, OCTEP_HW_MBOX_BAR);
> +
> +	octep_vdpa_pf_bar_expand(octpf);
> +}
> +
> +static void octep_vdpa_vf_bar_shrink(struct pci_dev *pdev)
> +{
> +	struct resource *vf_res = pdev->resource + PCI_STD_RESOURCES + 4;
> +
> +	memset(vf_res, 0, sizeof(*vf_res));
> +}
> +
> +static void octep_vdpa_remove_vf(struct pci_dev *pdev)
> +{
> +	struct octep_vdpa_mgmt_dev *mgmt_dev = pci_get_drvdata(pdev);
> +	struct octep_hw *oct_hw;
> +	int status;
> +
> +	oct_hw = &mgmt_dev->oct_hw;
> +	status = atomic_read(&mgmt_dev->status);
> +	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_UNINIT);
> +
> +	cancel_work_sync(&mgmt_dev->setup_task);
> +	if (status == OCTEP_VDPA_DEV_STATUS_READY)
> +		vdpa_mgmtdev_unregister(&mgmt_dev->mdev);
> +
> +	if (oct_hw->base[OCTEP_HW_CAPS_BAR])
> +		octep_iounmap_region(pdev, oct_hw->base, OCTEP_HW_CAPS_BAR);
> +
> +	if (oct_hw->base[OCTEP_HW_MBOX_BAR])
> +		octep_iounmap_region(pdev, oct_hw->base, OCTEP_HW_MBOX_BAR);
> +
> +	octep_vdpa_vf_bar_shrink(pdev);
> +}
> +
> +static void octep_vdpa_remove(struct pci_dev *pdev)
> +{
> +	if (pdev->is_virtfn)
> +		octep_vdpa_remove_vf(pdev);
> +	else
> +		octep_vdpa_remove_pf(pdev);
> +}
> +
> +static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> +			      const struct vdpa_dev_set_config *config)
> +{
> +	struct octep_vdpa_mgmt_dev *mgmt_dev = container_of(mdev, struct octep_vdpa_mgmt_dev, mdev);
> +	struct octep_hw *oct_hw = &mgmt_dev->oct_hw;
> +	struct pci_dev *pdev = oct_hw->pdev;
> +	struct vdpa_device *vdpa_dev;
> +	struct octep_vdpa *oct_vdpa;
> +	u64 device_features;
> +	int ret;
> +
> +	oct_vdpa = vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev->dev, &octep_vdpa_ops, 1, 1,
> +				     NULL, false);
> +	if (IS_ERR(oct_vdpa)) {
> +		dev_err(&pdev->dev, "Failed to allocate vDPA structure for octep vdpa device");
> +		return PTR_ERR(oct_vdpa);
> +	}
> +
> +	oct_vdpa->pdev = pdev;
> +	oct_vdpa->vdpa.dma_dev = &pdev->dev;
> +	oct_vdpa->vdpa.mdev = mdev;
> +	oct_vdpa->oct_hw = oct_hw;
> +	vdpa_dev = &oct_vdpa->vdpa;
> +
> +	device_features = oct_hw->features;
> +	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> +		if (config->device_features & ~device_features) {
> +			dev_err(&pdev->dev, "The provisioned features 0x%llx are not supported by this device with features 0x%llx\n",
> +				config->device_features, device_features);
> +			ret = -EINVAL;
> +			goto vdpa_dev_put;
> +		}
> +		device_features &= config->device_features;
> +	}
> +
> +	oct_hw->features = device_features;
> +	dev_info(&pdev->dev, "Vdpa management device features : %llx\n", device_features);
> +
> +	ret = octep_verify_features(device_features);
> +	if (ret) {
> +		dev_warn(mdev->device,
> +			 "Must provision minimum features 0x%llx for this device",
> +			 BIT_ULL(VIRTIO_F_VERSION_1) | BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |
> +			 BIT_ULL(VIRTIO_F_NOTIFICATION_DATA) | BIT_ULL(VIRTIO_F_RING_PACKED));
> +		goto vdpa_dev_put;
> +	}
> +	if (name)
> +		ret = dev_set_name(&vdpa_dev->dev, "%s", name);
> +	else
> +		ret = dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->index);
> +
> +	ret = _vdpa_register_device(&oct_vdpa->vdpa, oct_hw->nr_vring);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register to vDPA bus");
> +		goto vdpa_dev_put;
> +	}
> +	return 0;
> +
> +vdpa_dev_put:
> +	put_device(&oct_vdpa->vdpa.dev);
> +	return ret;
> +}
> +
> +static void octep_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *vdpa_dev)
> +{
> +	_vdpa_unregister_device(vdpa_dev);
> +}
> +
> +static const struct vdpa_mgmtdev_ops octep_vdpa_mgmt_dev_ops = {
> +	.dev_add = octep_vdpa_dev_add,
> +	.dev_del = octep_vdpa_dev_del
> +};
> +
> +static bool get_device_ready_status(u8 __iomem *addr)
> +{
> +	u64 signature = readq(addr + OCTEP_VF_MBOX_DATA(0));
> +
> +	if (signature == OCTEP_DEV_READY_SIGNATURE) {
> +		writeq(0, addr + OCTEP_VF_MBOX_DATA(0));
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static struct virtio_device_id id_table[] = {
> +	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> +static void octep_vdpa_setup_task(struct work_struct *work)
> +{
> +	struct octep_vdpa_mgmt_dev *mgmt_dev = container_of(work, struct octep_vdpa_mgmt_dev,
> +							    setup_task);
> +	struct pci_dev *pdev = mgmt_dev->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct octep_hw *oct_hw;
> +	unsigned long timeout;
> +	int ret;
> +
> +	oct_hw = &mgmt_dev->oct_hw;
> +
> +	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_WAIT_FOR_BAR_INIT);
> +
> +	/* Wait for a maximum of 5 sec */
> +	timeout = jiffies + msecs_to_jiffies(5000);
> +	while (!time_after(jiffies, timeout)) {
> +		if (get_device_ready_status(oct_hw->base[OCTEP_HW_MBOX_BAR])) {
> +			atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_INIT);
> +			break;
> +		}
> +
> +		if (atomic_read(&mgmt_dev->status) >= OCTEP_VDPA_DEV_STATUS_READY) {
> +			dev_info(dev, "Stopping vDPA setup task.\n");
> +			return;
> +		}
> +
> +		usleep_range(1000, 1500);
> +	}
> +
> +	if (atomic_read(&mgmt_dev->status) != OCTEP_VDPA_DEV_STATUS_INIT) {
> +		dev_err(dev, "BAR initialization is timed out\n");
> +		return;
> +	}
> +
> +	ret = octep_iomap_region(pdev, oct_hw->base, OCTEP_HW_CAPS_BAR);
> +	if (ret)
> +		return;
> +
> +	ret = octep_hw_caps_read(oct_hw, pdev);
> +	if (ret < 0)
> +		goto unmap_region;
> +
> +	mgmt_dev->mdev.ops = &octep_vdpa_mgmt_dev_ops;
> +	mgmt_dev->mdev.id_table = id_table;
> +	mgmt_dev->mdev.max_supported_vqs = oct_hw->nr_vring;
> +	mgmt_dev->mdev.supported_features = oct_hw->features;
> +	mgmt_dev->mdev.config_attr_mask = (1 << VDPA_ATTR_DEV_FEATURES);
> +	mgmt_dev->mdev.device = dev;
> +
> +	ret = vdpa_mgmtdev_register(&mgmt_dev->mdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register vdpa management interface\n");
> +		goto unmap_region;
> +	}
> +
> +	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_READY);
> +
> +	return;
> +
> +unmap_region:
> +	octep_iounmap_region(pdev, oct_hw->base, OCTEP_HW_CAPS_BAR);
> +	oct_hw->base[OCTEP_HW_CAPS_BAR] = NULL;
> +}
> +
> +static int octep_vdpa_probe_vf(struct pci_dev *pdev)
> +{
> +	struct octep_vdpa_mgmt_dev *mgmt_dev;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable device\n");
> +		return ret;
> +	}
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		dev_err(dev, "No usable DMA configuration\n");
> +		return ret;
> +	}
> +	pci_set_master(pdev);
> +
> +	mgmt_dev = devm_kzalloc(dev, sizeof(struct octep_vdpa_mgmt_dev), GFP_KERNEL);
> +	if (!mgmt_dev)
> +		return -ENOMEM;
> +
> +	ret = octep_iomap_region(pdev, mgmt_dev->oct_hw.base, OCTEP_HW_MBOX_BAR);
> +	if (ret)
> +		return ret;
> +
> +	mgmt_dev->pdev = pdev;
> +	pci_set_drvdata(pdev, mgmt_dev);
> +
> +	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_ALLOC);
> +	INIT_WORK(&mgmt_dev->setup_task, octep_vdpa_setup_task);
> +	schedule_work(&mgmt_dev->setup_task);
> +	dev_info(&pdev->dev, "octep vdpa mgmt device setup task is queued\n");
> +
> +	return 0;
> +}
> +
> +static void octep_vdpa_assign_barspace(struct pci_dev *vf_dev, struct pci_dev *pf_dev, u8 idx)
> +{
> +	struct resource *vf_res = vf_dev->resource + PCI_STD_RESOURCES + 4;
> +	struct resource *pf_res = pf_dev->resource + PCI_STD_RESOURCES + 4;
> +	struct octep_pf *pf = pci_get_drvdata(pf_dev);
> +	struct pci_bus_region bus_region;
> +
> +	vf_res->name = pci_name(vf_dev);
> +	vf_res->flags = pf_res->flags;
> +	vf_res->parent = (pf_dev->resource + PCI_STD_RESOURCES)->parent;
> +
> +	bus_region.start = pf->vf_base + idx * pf->vf_stride;
> +	bus_region.end = bus_region.start + pf->vf_stride - 1;
> +	pcibios_bus_to_resource(vf_dev->bus, vf_res, &bus_region);
> +}
> +
> +static int octep_sriov_enable(struct pci_dev *pdev, int num_vfs)
> +{
> +	struct octep_pf *pf = pci_get_drvdata(pdev);
> +	u8 __iomem *addr = pf->base[OCTEP_HW_MBOX_BAR];
> +	struct pci_dev *vf_pdev = NULL;
> +	bool done = false;
> +	int index = 0;
> +	int ret, i;
> +
> +	ret = pci_enable_sriov(pdev, num_vfs);
> +	if (ret)
> +		return ret;
> +
> +	pf->enabled_vfs = num_vfs;
> +
> +	while ((vf_pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, vf_pdev))) {
> +		if (vf_pdev->device != pf->vf_devid)
> +			continue;
> +
> +		octep_vdpa_assign_barspace(vf_pdev, pdev, index);
> +		if (++index == num_vfs) {
> +			done = true;
> +			break;
> +		}
> +	}
> +
> +	if (done) {
> +		for (i = 0; i < pf->enabled_vfs; i++)
> +			writeq(OCTEP_DEV_READY_SIGNATURE, addr + OCTEP_PF_MBOX_DATA(i));
> +	}
> +
> +	return num_vfs;
> +}
> +
> +static int octep_sriov_disable(struct pci_dev *pdev)
> +{
> +	struct octep_pf *pf = pci_get_drvdata(pdev);
> +
> +	if (!pci_num_vf(pdev))
> +		return 0;
> +
> +	pci_disable_sriov(pdev);
> +	pf->enabled_vfs = 0;
> +
> +	return 0;
> +}
> +
> +static int octep_vdpa_sriov_configure(struct pci_dev *pdev, int num_vfs)
> +{
> +	if (num_vfs > 0)
> +		return octep_sriov_enable(pdev, num_vfs);
> +	else
> +		return octep_sriov_disable(pdev);
> +}
> +
> +static u16 octep_get_vf_devid(struct pci_dev *pdev)
> +{
> +	u16 did;
> +
> +	switch (pdev->device) {
> +	case OCTEP_VDPA_DEVID_CN106K_PF:
> +		did = OCTEP_VDPA_DEVID_CN106K_VF;
> +		break;
> +	case OCTEP_VDPA_DEVID_CN105K_PF:
> +		did = OCTEP_VDPA_DEVID_CN105K_VF;
> +		break;
> +	case OCTEP_VDPA_DEVID_CN103K_PF:
> +		did = OCTEP_VDPA_DEVID_CN103K_VF;
> +		break;
> +	default:
> +		did = 0xFFFF;
> +		break;
> +	}
> +
> +	return did;
> +}
> +
> +static int octep_vdpa_pf_setup(struct octep_pf *octpf)
> +{
> +	u8 __iomem *addr = octpf->base[OCTEP_HW_MBOX_BAR];
> +	struct pci_dev *pdev = octpf->pdev;
> +	int totalvfs;
> +	u64 val, len;
> +
> +	totalvfs = pci_sriov_get_totalvfs(pdev);
> +	if (unlikely(!totalvfs)) {
> +		dev_info(&pdev->dev, "Total VFs are %d in PF sriov configuration\n", totalvfs);
> +		return 0;
> +	}
> +
> +	addr = octpf->base[OCTEP_HW_MBOX_BAR];
> +	val = readq(addr + OCTEP_EPF_RINFO(0));
> +	if (val == 0) {
> +		dev_err(&pdev->dev, "Invalid device configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	if (OCTEP_EPF_RINFO_RPVF(val) != BIT_ULL(0)) {
> +		val &= ~GENMASK_ULL(35, 32);
> +		val |= BIT_ULL(32);
> +		writeq(val, addr + OCTEP_EPF_RINFO(0));
> +	}
> +
> +	len = pci_resource_len(pdev, OCTEP_HW_CAPS_BAR);
> +
> +	octpf->vf_stride = len / totalvfs;
> +	octpf->vf_devid = octep_get_vf_devid(pdev);
> +
> +	octep_vdpa_pf_bar_shrink(octpf);
> +
> +	return 0;
> +}
> +
> +static int octep_vdpa_probe_pf(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct octep_pf *octpf;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable device\n");
> +		return ret;
> +	}
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		dev_err(dev, "No usable DMA configuration\n");
> +		return ret;
> +	}
> +	octpf = devm_kzalloc(dev, sizeof(*octpf), GFP_KERNEL);
> +	if (!octpf)
> +		return -ENOMEM;
> +
> +	ret = octep_iomap_region(pdev, octpf->base, OCTEP_HW_MBOX_BAR);
> +	if (ret)
> +		return ret;
> +
> +	pci_set_master(pdev);
> +	pci_set_drvdata(pdev, octpf);
> +	octpf->pdev = pdev;
> +
> +	ret = octep_vdpa_pf_setup(octpf);
> +	if (ret)
> +		goto unmap_region;
> +
> +	return 0;
> +
> +unmap_region:
> +	octep_iounmap_region(pdev, octpf->base, OCTEP_HW_MBOX_BAR);
> +	return ret;
> +}
> +
> +static int octep_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	if (pdev->is_virtfn)
> +		return octep_vdpa_probe_vf(pdev);
> +	else
> +		return octep_vdpa_probe_pf(pdev);
> +}
> +
> +static struct pci_device_id octep_pci_vdpa_map[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_VDPA_DEVID_CN106K_PF) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_VDPA_DEVID_CN106K_VF) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_VDPA_DEVID_CN105K_PF) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_VDPA_DEVID_CN105K_VF) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_VDPA_DEVID_CN103K_PF) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_VDPA_DEVID_CN103K_VF) },
> +	{ 0 },
> +};
> +
> +static struct pci_driver octep_pci_vdpa = {
> +	.name     = OCTEP_VDPA_DRIVER_NAME,
> +	.id_table = octep_pci_vdpa_map,
> +	.probe    = octep_vdpa_probe,
> +	.remove   = octep_vdpa_remove,
> +	.sriov_configure = octep_vdpa_sriov_configure
> +};
> +
> +module_pci_driver(octep_pci_vdpa);
> +
> +MODULE_AUTHOR("Marvell");
> +MODULE_DESCRIPTION("Marvell Octeon PCIe endpoint vDPA driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1

