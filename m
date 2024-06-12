Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45FC374D3
	for <virtualization@lists.linux.dev>; Wed, 12 Jun 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193845; cv=none; b=ehiKIuvOLDWNStRcffafWP6EV90WVAzW/3j4v+xGykanOCpTSJ2n11YUGxMtr+kDYgqBIwbOQIxMDzfRhH0z1kAWyZw+DLMpQ+kFOOxQ9pAkZoJ2Bx4cNpta0LPasx1qsp38eY7E/tuZtvUzyxlJeBY/5rljZR6DfYuSVY93lCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193845; c=relaxed/simple;
	bh=4LoyjeyoDfwvHeoSruKbCk6uXgi8pVAXGUk/e0uZ4TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EWbdO5aMokKaHHM3qOkIQsuYA8TuFZ0TGlrNlHrdf4QhJTeKE3fwCeZakz3setcW3HLiVME00JcgGqSagI7YuFKBjwc6E0tYuOFSwe2V8xWyJ0/APFDpQhMxMhLfsBqz1gD5fYPQdo9F0bmPCxIIJobzoaDSWLrtIhD5//5e9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4q3T1Q1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4q3T1Q1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718193842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdZzOGUOXQsmtTK3qzvWqoRN/41V4U2c03Ad49nQhc4=;
	b=C4q3T1Q1URM47tlBRAuhLgHgu50FNr9jLapUFjWuzV8eJ2DaIMfkXsIdESbly/NcJFHsYk
	7tKQd2XlhpK3dTIUe/gnDXljp1s8ZCcPIJD+5hJdaE3ZCxz0nehiw1eW+/75CPxnOQ/+od
	x7gG+0FRZri6DnmIKOGXqhO8AX+s9xA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-21klmZ4zMwSdsLgz8FJ72w-1; Wed, 12 Jun 2024 08:04:01 -0400
X-MC-Unique: 21klmZ4zMwSdsLgz8FJ72w-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ebe662e992so31150981fa.3
        for <virtualization@lists.linux.dev>; Wed, 12 Jun 2024 05:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718193839; x=1718798639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdZzOGUOXQsmtTK3qzvWqoRN/41V4U2c03Ad49nQhc4=;
        b=ZEapHakKNVx/C4T0kqju2EE5lmybciMCyHCMyPPutI7lkb5Hb9E9EtkvCgRoM7Dw52
         pwEqnPM2nD9P7s58krsuRR+bGd3y/W5C7D7OCSraFPeWMs36ILntR2K7EJTQPlznb3wX
         7JU6CifgqkMXyjDttHfhK+wq9W7pmfmI0nKkwd9299Z6FzWXV2BoL2QXVa54pjm6FYLW
         s7KTHJXDqh6voqNYqTSUL4KuorD7bqVBbfknbeTI8rV2cXSU9ufY195mT3f+FFm9x7AA
         qq+SHZ/raLAfSkqbwwF5QlqXTk4EjfZzMhujJekt4fbTP/mH0t0jNGBj7h7lCG6E/UPr
         QAyw==
X-Gm-Message-State: AOJu0YxF2BHDvav1dIkOQy1VhM4iuXdatqSEqR4DXPYJNo29fT6sZfM0
	dQKTIgeEMGFyqveLzJTAmFTUo2XnfdY1siqyCDPQ595Q5ukMXE1aLUROlIvm6jvnRwN0soOI6mV
	auuEO2u7PgL6Si+UB78qLy7VJsG4601Pkah5lIBTwINF99Zmu0UGi85nhDzO58uQsCL9bCr55
X-Received: by 2002:a2e:a7d0:0:b0:2eb:fea7:4519 with SMTP id 38308e7fff4ca-2ebfea74620mr11705801fa.11.1718193839251;
        Wed, 12 Jun 2024 05:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELk0ZC7YVdxNVnFRJDRXQiCywHTa+ozGhmUqvilNUsa/ARyvhPAS1aHavzthcYQ4YSqRmZFg==
X-Received: by 2002:a2e:a7d0:0:b0:2eb:fea7:4519 with SMTP id 38308e7fff4ca-2ebfea74620mr11705381fa.11.1718193838620;
        Wed, 12 Jun 2024 05:03:58 -0700 (PDT)
Received: from redhat.com ([2.52.131.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286ff3f4asm25571175e9.14.2024.06.12.05.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:03:57 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:03:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, vattunuru@marvell.com,
	sthotton@marvell.com, ndabilpuram@marvell.com, jerinj@marvell.com
Subject: Re: [PATCH v5] virtio: vdpa: vDPA driver for Marvell OCTEON DPU
 devices
Message-ID: <20240612032055-mutt-send-email-mst@kernel.org>
References: <20240522111946.507457-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240522111946.507457-1-schalla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2024 at 04:49:46PM +0530, Srujana Challa wrote:
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
> ---
> v2:
> * Addressed review comments
> v3:
> * Enhanced a few error logs based on the suggestions provided.
> v4:
> * Addressed kbuild failures on mips.
> v5:
> * Addressed kbuild failures for 32bit arch.
> 
>  MAINTAINERS                              |   5 +
>  drivers/vdpa/Kconfig                     |   9 +
>  drivers/vdpa/Makefile                    |   1 +
>  drivers/vdpa/octeon_ep/Makefile          |   4 +
>  drivers/vdpa/octeon_ep/octep_vdpa.h      |  94 +++
>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 517 ++++++++++++++
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c | 857 +++++++++++++++++++++++
>  7 files changed, 1487 insertions(+)
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

Weird. Why? Pls document.

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
> index 000000000000..531aba0ae988
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

is completely

> + * emulated by the device's firmware. So, the standard pci config
> + * read apis can't be used for reading the virtio capabilities.

capability 

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

Pls prefix all functions with octep_ - otherwise when reading
code one thinks these are standard pci functions.


