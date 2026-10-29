Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264506;
	b=dbhKtKSII8LMI5R3cHq1k4MLOg8+8V8tOu/VDFhAFMkeShbN4SPsxlZzZaJDlQo28Im0
	 93eA0o+UoWgInhGuDY2f9hX6Eo546SoIqV5Ppyyc0i+wZDSO6LXRzczcNZxF0LmPl1yjW
	 IqdnUdUCIqxxVh8Pg44WIxhb6eJc/2s6sxY/TO+6e9+AXQGWem6Hf2jF8mdvoQx4dWSbi
	 F2lJ+VEJPd4tU2+lNV7khbnN/lvaNRtHRDJsEWFZBpivak1JtpQDho26roIIGVyaPvzI1
	 uwenuKmt1pV37Vjm4AwiaVY+dxuojS0F4LZHO/UErP6bzimusAgnoJ69zvVlw9Ordhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264506;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=xzym8x9efLzMKPeyyU/1JZZp8jlNuIxFa2DvUwG9gN4=;
	b=YXx6pp2F9wWiIMm0SliLQJedSf2a1b5HkmeIyyYGnHcnl7ruf7bdsyfHYQKqZrBZRCJc
	 9Cqb9groM7mo1bstMH01p3bHhBPaGR4nkTLfLKD25AAVeRMB4sAW93WhXL3i1lsvvMEHz
	 154AfqFzAV5qBlSjsCMvu1MJa8ik1TLpE6R2MTnEeOLCMs4unZH2UYCmHWNk0VOvCgnWK
	 oC0kUx3NZB6O1Z/zmV5DrtHZpwJnyKOntwZAYaTPaOuP3IqBccbD0nOxMGuY2fGZEIkpp
	 GquLG3C9X1jxZDqOzjbdDvU0G8qTVtjE+rQyPh/C4+wVOM8FREucEPTNFr4qdzwiHpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ko1jneTz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374C606A324;
	Thu, 29 Oct 2026 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ko1jneTz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E331F012E2;
	Thu, 29 Oct 2026 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793264505;
	bh=xzym8x9efLzMKPeyyU/1JZZp8jlNuIxFa2DvUwG9gN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ko1jneTz9FrmzJmQZmWE/Sa6aeIEsQDJF+BbxrKkyUw8K9X8pcwCMwTsIpEYiy86z
	 kTTu03kQC1FSgMLMp/mWEzs/60/g2w8bKMxOgS19DBJuUXtzwYY7CEZoWcRzWRUS4/
	 JY8XR77Obc4zdY3m111EzlYBxU3c//Bi4cXjR9ik=
Date: Thu, 29 Oct 2026 10:01:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Haruka Kuze <harukak@zohomail.eu>
Cc: Jens Wiklander <jenswi@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Tomas Winkler <tomas.winkler@sandisk.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	virtualization@lists.linux.dev, op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rpmb: add a virtio RPMB device driver
Message-ID: <2026102958-surface-preorder-c3c8@gregkh>
References: <20261029081317.2264887-1-harukak@zohomail.eu>
 <20261029081317.2264887-3-harukak@zohomail.eu>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261029081317.2264887-3-harukak@zohomail.eu>

On Thu, Oct 29, 2026 at 05:13:17PM +0900, Haruka Kuze wrote:
> No driver exists for virtio-rpmb devices (virtio ID 28), so OP-TEE
> running in a guest can not use them.
> 
> This registers the virtio-rpmb devices found with the RPMB sub-system.
> Each request is done in one transfer on request queue, and for key
> programming and data writing a result read frame is appended so that
> the device can return the result.
> 
> These frames are copied since the caller's buffers are not always
> usable for DMA.
> 
> These frames follow the emmc definition, so that the device is
> registered as RPMB_TYPE_EMMC. The device has no identifier of own, so
> that a fixed dev_id is used for the key derivation for the device.
> 
> Based on the virtio-rpmb driver in Alex Bennée's RPMB series.
> 
> Link: https://lore.kernel.org/all/20220405093759.1126835-4-alex.bennee@linaro.org/
> Signed-off-by: Haruka Kuze <harukak@zohomail.eu>
> ---
>  MAINTAINERS                      |   7 +
>  drivers/misc/Kconfig             |  10 ++
>  drivers/misc/Makefile            |   1 +
>  drivers/misc/virtio_rpmb.c       | 294 +++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_rpmb.h |  56 ++++++
>  5 files changed, 368 insertions(+)
>  create mode 100644 drivers/misc/virtio_rpmb.c
>  create mode 100644 include/uapi/linux/virtio_rpmb.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 748ce4d1c6a2..488003a28534 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -29707,6 +29707,13 @@ S:	Maintained
>  F:	drivers/char/hw_random/virtio-rng.c
>  F:	include/uapi/linux/virtio_rng.h
>  
> +VIRTIO RPMB DRIVER
> +M:	Haruka Kuze <harukak@zohomail.eu>
> +L:	virtualization@lists.linux.dev
> +S:	Maintained
> +F:	drivers/misc/virtio_rpmb.c
> +F:	include/uapi/linux/virtio_rpmb.h
> +
>  VIRTIO RTC DRIVER
>  M:	Peter Hilber <peter.hilber@oss.qualcomm.com>
>  L:	virtualization@lists.linux.dev
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index c40e89cc5724..eb3518ecc8fe 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -91,6 +91,16 @@ config RPMB
>  
>  	  If unsure, select N.
>  
> +config VIRTIO_RPMB
> +	tristate "Virtio RPMB driver"
> +	depends on VIRTIO && RPMB
> +	help
> +	  Driver for virtio RPMB devices. The device is registered with the
> +	  RPMB subsystem, where in-kernel users such as OP-TEE can use it.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called virtio_rpmb.
> +
>  config TI_FPC202
>  	tristate "TI FPC202 Dual Port Controller"
>  	depends on I2C
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 7cc3d615d37a..e4390bb8bdc0 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
>  obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
>  obj-$(CONFIG_PHANTOM)		+= phantom.o
>  obj-$(CONFIG_RPMB)		+= rpmb-core.o
> +obj-$(CONFIG_VIRTIO_RPMB)	+= virtio_rpmb.o
>  obj-$(CONFIG_QCOM_COINCELL)	+= qcom-coincell.o
>  obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
>  obj-$(CONFIG_SENSORS_BH1770)	+= bh1770glc.o
> diff --git a/drivers/misc/virtio_rpmb.c b/drivers/misc/virtio_rpmb.c
> new file mode 100644
> index 000000000000..f02bdf13aa43
> --- /dev/null
> +++ b/drivers/misc/virtio_rpmb.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Virtio RPMB driver
> + *
> + * Copyright (c) 2018-2019 Intel Corporation.
> + * Copyright (c) 2021-2022 Linaro Ltd.
> + *
> + * Based on the virtio-rpmb driver in Alex Bennée's RPMB series.
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/rpmb.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_rpmb.h>
> +
> +#define VIRTIO_RPMB_FRAME_SIZE	sizeof(struct virtio_rpmb_frame)
> +static_assert(VIRTIO_RPMB_FRAME_SIZE == 512);
> +
> +/*
> + * This device has no identifier on its own.
> + * This value is used as input when OP-TEE is deriving the RPMB
> + * key, so it shall stay stable.
> + */
> +static const u8 virtio_rpmb_dev_id[16] = "virtio-rpmb";
> +
> +/**
> + * struct virtio_rpmb - virtio RPMB device state
> + * @vdev: virtio device
> + * @vq: request queue, NULL while the device is gone or frozen
> + * @lock: serializes requests and protects @vq
> + * @rdev: RPMB device
> + * @max_wr: maximum number of blocks in one write request, 0 if unlimited
> + * @max_rd: maximum number of blocks in one read request, 0 if unlimited
> + */
> +struct virtio_rpmb {
> +	struct virtio_device *vdev;
> +	struct virtqueue *vq;
> +	struct mutex lock;
> +	struct rpmb_dev *rdev;
> +	u8 max_wr;
> +	u8 max_rd;
> +};
> +
> +struct virtio_rpmb_req {
> +	struct completion done;
> +	unsigned int len;
> +};
> +
> +static void virtio_rpmb_done(struct virtqueue *vq)
> +{
> +	struct virtio_rpmb_req *req;
> +	unsigned int len;
> +
> +	while ((req = virtqueue_get_buf(vq, &len))) {
> +		req->len = len;
> +		complete(&req->done);
> +	}
> +}
> +
> +static int virtio_rpmb_xfer(struct virtio_rpmb *vr, void *out,
> +			    unsigned int out_len, void *in, unsigned int in_len)
> +{
> +	struct scatterlist out_sg, in_sg, *sgs[2] = { &out_sg, &in_sg };
> +	struct virtio_rpmb_req req;
> +	int ret;
> +
> +	sg_init_one(&out_sg, out, out_len);
> +	sg_init_one(&in_sg, in, in_len);
> +	init_completion(&req.done);
> +
> +	mutex_lock(&vr->lock);

guard()?

thanks,

greg k-h
