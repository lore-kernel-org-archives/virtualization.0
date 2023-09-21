Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7DBE7D0A2
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 20:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ECCE417D0;
	Thu, 21 Sep 2023 20:34:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7ECCE417D0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X1ojAtdi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kPVoGi6_Zg5G; Thu, 21 Sep 2023 20:34:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 764204179F;
	Thu, 21 Sep 2023 20:34:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 764204179F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E0ADC0071;
	Thu, 21 Sep 2023 20:34:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCFC8C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9435383CE2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:34:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9435383CE2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=X1ojAtdi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bfBkteaQYOZx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:34:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA31C83CA1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:34:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA31C83CA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695328451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A9eE/GA+11Z+74FMA8fmb32rMfa70a/qPrntg3eRsZY=;
 b=X1ojAtdi13t212a/Oih8Ryc3MLbLUsvrrbnwQOl4AUO6kVqPiUvpXm8AbhcYpp7X6TK9zH
 v+U2+xR20/HDZcseVWIJVYi5Is+E0PjWoFuVnLXlGUJ9WqxkMlH093DnGTh1xuXLfRtMB4
 tJ7hda+YP7zcQc+Yo7IbWqhYDSCxQWE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-_sUVCMZSP96TyITwH_RTeA-1; Thu, 21 Sep 2023 16:34:10 -0400
X-MC-Unique: _sUVCMZSP96TyITwH_RTeA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-503343a850aso1753834e87.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695328448; x=1695933248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9eE/GA+11Z+74FMA8fmb32rMfa70a/qPrntg3eRsZY=;
 b=Utvr/+HnQT+ZzxTHJ6VlHsTQx6M5AINo/elK3kM2UAPH41wLfuzKvPQ6HZP3ezCTDU
 0I4Wc9UAhK7FVfGCxIBdpSBuEhteRyDjIfSOzPlOxRLswBQeoekh8xPAwaZxRPGfEZLQ
 I145ytaUKlkiZeV6ZrhyvPknG4zJwfJLEe+rPgrNPQaQ5XuqgmjEqTyz/tpHdzZNCvpr
 /h1pNIZFWDfjb2zY2oM1IPM/ZMxtg8KgSFNK2Q9bbDPwgIYRpCqv9zV+fh1CZG92Uw/O
 s+QZcWGEKHxlXAPyzFL36hi8CH5OcaxONiWUgiGDRyd6ndNQjTUc8riSICKEIMFFKYFB
 n55A==
X-Gm-Message-State: AOJu0Yz+hBAcUHlMBEt+d8tdlG8358xzi43RVKyQ1PEfHOtxVhUnMnjr
 PrA4H18rp9qLuaBZyqveKg4X9m7Rq7P+dVd413nMW6+z0MikYXWxI7JqAkxOXsd6YPcVTkm8Oi+
 5TY1xUkA0KXo1DFghrU/PD0aQ2cBS0KejlQ7J+xenUA==
X-Received: by 2002:a05:6512:234f:b0:503:1be5:24ed with SMTP id
 p15-20020a056512234f00b005031be524edmr7682528lfu.44.1695328448678; 
 Thu, 21 Sep 2023 13:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9E00kH+ycaMs6Jl7ZEFt6V382jx7EdF7x/msE4CgyQbHsUjzTXEcfTs6qU4xTZBQIVdB5Rg==
X-Received: by 2002:a05:6512:234f:b0:503:1be5:24ed with SMTP id
 p15-20020a056512234f00b005031be524edmr7682504lfu.44.1695328448233; 
 Thu, 21 Sep 2023 13:34:08 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 y19-20020a056402135300b0052fdfd8870bsm1290121edw.89.2023.09.21.13.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 13:34:07 -0700 (PDT)
Date: Thu, 21 Sep 2023 16:34:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20230921162621-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-11-yishaih@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921124040.145386-11-yishaih@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

On Thu, Sep 21, 2023 at 03:40:39PM +0300, Yishai Hadas wrote:
> Expose admin commands over the virtio device, to be used by the
> vfio-virtio driver in the next patches.
> 
> It includes: list query/use, legacy write/read, read notify_info.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/vfio/pci/virtio/cmd.c | 146 ++++++++++++++++++++++++++++++++++
>  drivers/vfio/pci/virtio/cmd.h |  27 +++++++
>  2 files changed, 173 insertions(+)
>  create mode 100644 drivers/vfio/pci/virtio/cmd.c
>  create mode 100644 drivers/vfio/pci/virtio/cmd.h
> 
> diff --git a/drivers/vfio/pci/virtio/cmd.c b/drivers/vfio/pci/virtio/cmd.c
> new file mode 100644
> index 000000000000..f068239cdbb0
> --- /dev/null
> +++ b/drivers/vfio/pci/virtio/cmd.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + */
> +
> +#include "cmd.h"
> +
> +int virtiovf_cmd_list_query(struct pci_dev *pdev, u8 *buf, int buf_size)
> +{
> +	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
> +	struct scatterlist out_sg;
> +	struct virtio_admin_cmd cmd = {};
> +
> +	if (!virtio_dev)
> +		return -ENOTCONN;
> +
> +	sg_init_one(&out_sg, buf, buf_size);
> +	cmd.opcode = VIRTIO_ADMIN_CMD_LIST_QUERY;
> +	cmd.group_type = VIRTIO_ADMIN_GROUP_TYPE_SRIOV;
> +	cmd.result_sg = &out_sg;
> +
> +	return virtio_admin_cmd_exec(virtio_dev, &cmd);
> +}
> +

in/out seem all wrong here. In virtio terminology, in means from
device to driver, out means from driver to device.

> +int virtiovf_cmd_list_use(struct pci_dev *pdev, u8 *buf, int buf_size)
> +{
> +	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
> +	struct scatterlist in_sg;
> +	struct virtio_admin_cmd cmd = {};
> +
> +	if (!virtio_dev)
> +		return -ENOTCONN;
> +
> +	sg_init_one(&in_sg, buf, buf_size);
> +	cmd.opcode = VIRTIO_ADMIN_CMD_LIST_USE;
> +	cmd.group_type = VIRTIO_ADMIN_GROUP_TYPE_SRIOV;
> +	cmd.data_sg = &in_sg;
> +
> +	return virtio_admin_cmd_exec(virtio_dev, &cmd);
> +}
> +
> +int virtiovf_cmd_lr_write(struct virtiovf_pci_core_device *virtvdev, u16 opcode,


what is _lr short for?

> +			  u8 offset, u8 size, u8 *buf)
> +{
> +	struct virtio_device *virtio_dev =
> +		virtio_pci_vf_get_pf_dev(virtvdev->core_device.pdev);
> +	struct virtio_admin_cmd_data_lr_write *in;
> +	struct scatterlist in_sg;
> +	struct virtio_admin_cmd cmd = {};
> +	int ret;
> +
> +	if (!virtio_dev)
> +		return -ENOTCONN;
> +
> +	in = kzalloc(sizeof(*in) + size, GFP_KERNEL);
> +	if (!in)
> +		return -ENOMEM;
> +
> +	in->offset = offset;
> +	memcpy(in->registers, buf, size);
> +	sg_init_one(&in_sg, in, sizeof(*in) + size);
> +	cmd.opcode = opcode;
> +	cmd.group_type = VIRTIO_ADMIN_GROUP_TYPE_SRIOV;
> +	cmd.group_member_id = virtvdev->vf_id + 1;

weird. why + 1?

> +	cmd.data_sg = &in_sg;
> +	ret = virtio_admin_cmd_exec(virtio_dev, &cmd);
> +
> +	kfree(in);
> +	return ret;
> +}

How do you know it's safe to send this command, in particular at
this time? This seems to be doing zero checks, and zero synchronization
with the PF driver.


> +
> +int virtiovf_cmd_lr_read(struct virtiovf_pci_core_device *virtvdev, u16 opcode,
> +			 u8 offset, u8 size, u8 *buf)
> +{
> +	struct virtio_device *virtio_dev =
> +		virtio_pci_vf_get_pf_dev(virtvdev->core_device.pdev);
> +	struct virtio_admin_cmd_data_lr_read *in;
> +	struct scatterlist in_sg, out_sg;
> +	struct virtio_admin_cmd cmd = {};
> +	int ret;
> +
> +	if (!virtio_dev)
> +		return -ENOTCONN;
> +
> +	in = kzalloc(sizeof(*in), GFP_KERNEL);
> +	if (!in)
> +		return -ENOMEM;
> +
> +	in->offset = offset;
> +	sg_init_one(&in_sg, in, sizeof(*in));
> +	sg_init_one(&out_sg, buf, size);
> +	cmd.opcode = opcode;
> +	cmd.group_type = VIRTIO_ADMIN_GROUP_TYPE_SRIOV;
> +	cmd.data_sg = &in_sg;
> +	cmd.result_sg = &out_sg;
> +	cmd.group_member_id = virtvdev->vf_id + 1;
> +	ret = virtio_admin_cmd_exec(virtio_dev, &cmd);
> +
> +	kfree(in);
> +	return ret;
> +}
> +
> +int virtiovf_cmd_lq_read_notify(struct virtiovf_pci_core_device *virtvdev,

and what is lq short for?

> +				u8 req_bar_flags, u8 *bar, u64 *bar_offset)
> +{
> +	struct virtio_device *virtio_dev =
> +		virtio_pci_vf_get_pf_dev(virtvdev->core_device.pdev);
> +	struct virtio_admin_cmd_notify_info_result *out;
> +	struct scatterlist out_sg;
> +	struct virtio_admin_cmd cmd = {};
> +	int ret;
> +
> +	if (!virtio_dev)
> +		return -ENOTCONN;
> +
> +	out = kzalloc(sizeof(*out), GFP_KERNEL);
> +	if (!out)
> +		return -ENOMEM;
> +
> +	sg_init_one(&out_sg, out, sizeof(*out));
> +	cmd.opcode = VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO;
> +	cmd.group_type = VIRTIO_ADMIN_GROUP_TYPE_SRIOV;
> +	cmd.result_sg = &out_sg;
> +	cmd.group_member_id = virtvdev->vf_id + 1;
> +	ret = virtio_admin_cmd_exec(virtio_dev, &cmd);
> +	if (!ret) {
> +		struct virtio_admin_cmd_notify_info_data *entry;
> +		int i;
> +
> +		ret = -ENOENT;
> +		for (i = 0; i < VIRTIO_ADMIN_CMD_MAX_NOTIFY_INFO; i++) {
> +			entry = &out->entries[i];
> +			if (entry->flags == VIRTIO_ADMIN_CMD_NOTIFY_INFO_FLAGS_END)
> +				break;
> +			if (entry->flags != req_bar_flags)
> +				continue;
> +			*bar = entry->bar;
> +			*bar_offset = le64_to_cpu(entry->offset);
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	kfree(out);
> +	return ret;
> +}
> diff --git a/drivers/vfio/pci/virtio/cmd.h b/drivers/vfio/pci/virtio/cmd.h
> new file mode 100644
> index 000000000000..c2a3645f4b90
> --- /dev/null
> +++ b/drivers/vfio/pci/virtio/cmd.h
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + */
> +
> +#ifndef VIRTIO_VFIO_CMD_H
> +#define VIRTIO_VFIO_CMD_H
> +
> +#include <linux/kernel.h>
> +#include <linux/virtio.h>
> +#include <linux/vfio_pci_core.h>
> +#include <linux/virtio_pci.h>
> +
> +struct virtiovf_pci_core_device {
> +	struct vfio_pci_core_device core_device;
> +	int vf_id;
> +};
> +
> +int virtiovf_cmd_list_query(struct pci_dev *pdev, u8 *buf, int buf_size);
> +int virtiovf_cmd_list_use(struct pci_dev *pdev, u8 *buf, int buf_size);
> +int virtiovf_cmd_lr_write(struct virtiovf_pci_core_device *virtvdev, u16 opcode,
> +			  u8 offset, u8 size, u8 *buf);
> +int virtiovf_cmd_lr_read(struct virtiovf_pci_core_device *virtvdev, u16 opcode,
> +			 u8 offset, u8 size, u8 *buf);
> +int virtiovf_cmd_lq_read_notify(struct virtiovf_pci_core_device *virtvdev,
> +				u8 req_bar_flags, u8 *bar, u64 *bar_offset);
> +#endif /* VIRTIO_VFIO_CMD_H */
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
