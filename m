Return-Path: <SRS0=1ME9=CT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF8BC43461
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 15:06:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333B52078B
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 15:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGCpMABX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333B52078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A6748871A0;
	Thu, 10 Sep 2020 15:06:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wpwsavJvvSv0; Thu, 10 Sep 2020 15:06:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B844386EBA;
	Thu, 10 Sep 2020 15:06:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FF2DC0052;
	Thu, 10 Sep 2020 15:06:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15AF3C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 15:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 04F2787530
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 15:06:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lBdt4qRooJZj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 15:06:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com
 [209.85.161.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C558087623
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 15:06:45 +0000 (UTC)
Received: by mail-oo1-f67.google.com with SMTP id o20so1526867ook.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=E8M/z3Gk8Sa5l74LlHbuoj+hzq9e3nUuKXKapEQzdbo=;
 b=FGCpMABX1xjbP76ciDMXt+fndgM/+Q3T3yt0PNXdw4jK1m9i0XLOcvIXxcNaf1XYs0
 fgC82F34gB5t1XgSg8dc3NvGhu8hnYRIWlc3/3m4/bPXbc/zLgHr37dRZeiRlPs7NaX1
 LZgmw1DjXJPgxAM4cWI+9MGHlOOAtkm7wMGfdLPLRRNXT/Ah1Q20OlqK42xMq9koaRkg
 45ahSOWHx2s3tt99tp7z5h8RENdv19nDK7d8cVnbZHgwo1+2NQEW2+efKBD/Sh2Wdahv
 xBvl/f2IzKM/Zwr0QlVDA43b/ib9J5vSgWp1PgMZVipL876xgbEd3Vyp4HbcOUooBHG+
 6aAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=E8M/z3Gk8Sa5l74LlHbuoj+hzq9e3nUuKXKapEQzdbo=;
 b=Qpdv8rbW2O5M3pR8xhrzPOMjQTyJP1MkO1yO8WSAVptQ1eRPLL5Tr8mAoxG2DTPuVE
 WDIoVJmQvFXh7WFdZX8ivS9K28nR9pCuAbZxK+v3Cheep6qPR2BT5qi/t985ci4rJuox
 x5RhlOCz3GxbUGrSx+Kh6d/CxNJYVgkZX3y4Wvm6NINFOi7PLSGmSgPgBLQEBqBpWBTl
 Gb87pbjckg/5BSjd0EnMzpiHOtu/EbJA7FFjp0osFgzvUKX6Y95BmlJ3w8zFKGQdp3Nj
 LenQ03H9wNa2LTtEVkhQm1y9Sax63aFVcEaexzZj6Xm/6A7/bp0+mfjnxbTiGUm5B8+U
 78oQ==
X-Gm-Message-State: AOAM530IA0ke7cFZsONfZvDki7jERtd8/WlEM1vrSPvCTcYWKS8R1c4W
 /eLpbz6FdyH/ybFOpVf1x18=
X-Google-Smtp-Source: ABdhPJyDtlXFIVYUBe127YbUQ6+YoEPaAzyAWY0MqiMzEsGGevl1or4lgJZEJX31A/wLBhaJAUgl3w==
X-Received: by 2002:a4a:b443:: with SMTP id h3mr4785413ooo.45.1599750404724;
 Thu, 10 Sep 2020 08:06:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id a6sm855665otf.51.2020.09.10.08.06.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Sep 2020 08:06:44 -0700 (PDT)
Date: Thu, 10 Sep 2020 08:06:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v7 1/3] virtio: add dma-buf support for exported objects
Message-ID: <20200910150640.GA148344@roeck-us.net>
References: <20200818071343.3461203-1-stevensd@chromium.org>
 <20200818071343.3461203-2-stevensd@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818071343.3461203-2-stevensd@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 virtualization@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
 Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org
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

On Tue, Aug 18, 2020 at 04:13:41PM +0900, David Stevens wrote:
> This change adds a new flavor of dma-bufs that can be used by virtio
> drivers to share exported objects. A virtio dma-buf can be queried by
> virtio drivers to obtain the UUID which identifies the underlying
> exported object.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>

This makes VIRTIO dependent on DMA_SHARED_BUFFER. That means "select
DMA_SHARED_BUFFER" will have to be added to "config VIRTIO".

Guenter

> ---
>  drivers/virtio/Makefile         |  2 +-
>  drivers/virtio/virtio.c         |  6 +++
>  drivers/virtio/virtio_dma_buf.c | 85 +++++++++++++++++++++++++++++++++
>  include/linux/virtio.h          |  1 +
>  include/linux/virtio_dma_buf.h  | 37 ++++++++++++++
>  5 files changed, 130 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/virtio/virtio_dma_buf.c
>  create mode 100644 include/linux/virtio_dma_buf.h
> 
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 29a1386ecc03..ecdae5b596de 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
> +obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_dma_buf.o
>  obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
>  obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
>  virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index a977e32a88f2..5d46f0ded92d 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -357,6 +357,12 @@ int register_virtio_device(struct virtio_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(register_virtio_device);
>  
> +bool is_virtio_device(struct device *dev)
> +{
> +	return dev->bus == &virtio_bus;
> +}
> +EXPORT_SYMBOL_GPL(is_virtio_device);
> +
>  void unregister_virtio_device(struct virtio_device *dev)
>  {
>  	int index = dev->index; /* save for after device release */
> diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
> new file mode 100644
> index 000000000000..45d6e8647dcf
> --- /dev/null
> +++ b/drivers/virtio/virtio_dma_buf.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * dma-bufs for virtio exported objects
> + *
> + * Copyright (C) 2020 Google, Inc.
> + */
> +
> +#include <linux/virtio_dma_buf.h>
> +
> +/**
> + * virtio_dma_buf_export - Creates a new dma-buf for a virtio exported object
> + * @exp_info: [in] see dma_buf_export(). ops MUST refer to a dma_buf_ops
> + *	struct embedded in a virtio_dma_buf_ops.
> + *
> + * This wraps dma_buf_export() to allow virtio drivers to create a dma-buf
> + * for an virtio exported object that can be queried by other virtio drivers
> + * for the object's UUID.
> + */
> +struct dma_buf *virtio_dma_buf_export
> +	(const struct dma_buf_export_info *exp_info)
> +{
> +	const struct virtio_dma_buf_ops *virtio_ops =
> +		container_of(exp_info->ops,
> +			     const struct virtio_dma_buf_ops, ops);
> +
> +	if (!exp_info->ops ||
> +	    exp_info->ops->attach != &virtio_dma_buf_attach ||
> +	    !virtio_ops->get_uuid) {
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return dma_buf_export(exp_info);
> +}
> +EXPORT_SYMBOL(virtio_dma_buf_export);
> +
> +/**
> + * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
> + */
> +int virtio_dma_buf_attach(struct dma_buf *dma_buf,
> +			  struct dma_buf_attachment *attach)
> +{
> +	int ret;
> +	const struct virtio_dma_buf_ops *ops =
> +		container_of(dma_buf->ops,
> +			     const struct virtio_dma_buf_ops, ops);
> +
> +	if (ops->device_attach) {
> +		ret = ops->device_attach(dma_buf, attach);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(virtio_dma_buf_attach);
> +
> +/**
> + * is_virtio_dma_buf - returns true if the given dma-buf is a virtio dma-buf
> + * @dma_buf: buffer to query
> + */
> +bool is_virtio_dma_buf(struct dma_buf *dma_buf)
> +{
> +	return dma_buf->ops->attach == &virtio_dma_buf_attach;
> +}
> +EXPORT_SYMBOL(is_virtio_dma_buf);
> +
> +/**
> + * virtio_dma_buf_get_uuid - gets a virtio dma-buf's exported object's uuid
> + * @dma_buf: [in] buffer to query
> + * @uuid: [out] the uuid
> + *
> + * Returns: 0 on success, negative on failure.
> + */
> +int virtio_dma_buf_get_uuid(struct dma_buf *dma_buf,
> +			    uuid_t *uuid)
> +{
> +	const struct virtio_dma_buf_ops *ops =
> +		container_of(dma_buf->ops,
> +			     const struct virtio_dma_buf_ops, ops);
> +
> +	if (!is_virtio_dma_buf(dma_buf))
> +		return -EINVAL;
> +
> +	return ops->get_uuid(dma_buf, uuid);
> +}
> +EXPORT_SYMBOL(virtio_dma_buf_get_uuid);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 15f906e4a748..9397e25616c4 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -128,6 +128,7 @@ static inline struct virtio_device *dev_to_virtio(struct device *_dev)
>  void virtio_add_status(struct virtio_device *dev, unsigned int status);
>  int register_virtio_device(struct virtio_device *dev);
>  void unregister_virtio_device(struct virtio_device *dev);
> +bool is_virtio_device(struct device *dev);
>  
>  void virtio_break_device(struct virtio_device *dev);
>  
> diff --git a/include/linux/virtio_dma_buf.h b/include/linux/virtio_dma_buf.h
> new file mode 100644
> index 000000000000..a2fdf217ac62
> --- /dev/null
> +++ b/include/linux/virtio_dma_buf.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * dma-bufs for virtio exported objects
> + *
> + * Copyright (C) 2020 Google, Inc.
> + */
> +
> +#ifndef _LINUX_VIRTIO_DMA_BUF_H
> +#define _LINUX_VIRTIO_DMA_BUF_H
> +
> +#include <linux/dma-buf.h>
> +#include <linux/uuid.h>
> +#include <linux/virtio.h>
> +
> +/**
> + * struct virtio_dma_buf_ops - operations possible on exported object dma-buf
> + * @ops: the base dma_buf_ops. ops.attach MUST be virtio_dma_buf_attach.
> + * @device_attach: [optional] callback invoked by virtio_dma_buf_attach during
> + *		   all attach operations.
> + * @get_uid: [required] callback to get the uuid of the exported object.
> + */
> +struct virtio_dma_buf_ops {
> +	struct dma_buf_ops ops;
> +	int (*device_attach)(struct dma_buf *dma_buf,
> +			     struct dma_buf_attachment *attach);
> +	int (*get_uuid)(struct dma_buf *dma_buf, uuid_t *uuid);
> +};
> +
> +int virtio_dma_buf_attach(struct dma_buf *dma_buf,
> +			  struct dma_buf_attachment *attach);
> +
> +struct dma_buf *virtio_dma_buf_export
> +	(const struct dma_buf_export_info *exp_info);
> +bool is_virtio_dma_buf(struct dma_buf *dma_buf);
> +int virtio_dma_buf_get_uuid(struct dma_buf *dma_buf, uuid_t *uuid);
> +
> +#endif /* _LINUX_VIRTIO_DMA_BUF_H */
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
