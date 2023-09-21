Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5DBE7106A
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 13:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F350A80BF9;
	Thu, 21 Sep 2023 13:08:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F350A80BF9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E1y+Mmm3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sgw2p3qifqBX; Thu, 21 Sep 2023 13:08:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 49F2A80BE8;
	Thu, 21 Sep 2023 13:08:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49F2A80BE8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FA25C0039;
	Thu, 21 Sep 2023 13:08:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54FDAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20CE34002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:08:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 20CE34002B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E1y+Mmm3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l2gLqZKmbDcf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:08:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2099F40A2E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:08:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2099F40A2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695301725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xXZMggqs59z4fDzDQEy0mBNN19gcJsNuYATbYPTfKbg=;
 b=E1y+Mmm3QBIBtg2bYZonNcAAHE2wa7EBs+ls/SjLGuqHXDAPBpC8/Rjh49gQmXWAqZLmxn
 eI4ExRlLFHSoWUX/eu1rDjQgpmATbiAueeY3pGqS4QEN7+SDDgVTJNECKORtCBn1rpBXqW
 7tzY5yJPPeJI8fbcYPJnhB3EWT1cYFI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-6-x72f-HNayq1nJgNLcl-Q-1; Thu, 21 Sep 2023 09:08:42 -0400
X-MC-Unique: 6-x72f-HNayq1nJgNLcl-Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-532c1dfebe6so620665a12.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 06:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695301721; x=1695906521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXZMggqs59z4fDzDQEy0mBNN19gcJsNuYATbYPTfKbg=;
 b=ZmutmZJm+ngsLPae6nsjba0FN4lkd68eplTnxe4uohEH8zAZf4Ai3t7ck0oacCTWub
 QmjF7bzuIvVu20aLR3neS6xx03S3BAnYXfDZtWWz29zEPHlDtfVPdZ5xXZBe5wHF6g99
 y1AH53a+1LqErqqCV/3b/NKeXmo23dqZGsJI0RYKXG1BTtXGwP+mJbB5cgvEIxQnqNQ+
 0nF9TysTj6DqzkBxvqQE//TOp8MOPsN+V3Wwm+xJgIGMXmF1MaxhpyJz2JpXKKu0MxSr
 F3wWuZD+AKDaECuj6FQLAxdmthSnJMT+RQR4y7tNxAw3sAO6Y73lULIle0847Ap15pzO
 9DUQ==
X-Gm-Message-State: AOJu0YzLC1m/EUh6XSJhgootN545lwGOH4TFI7gF+T0hH+2gY89EyaHV
 wqZzMH4C+zeM2wP9vhmC5oQ85e7IOnoQ5CFst9D0xjDwOjHz2vAv8KVB25hBcNKkL1hNORYBSIP
 bBhT7twxNW2Rq/hI69fg2G7xIT/T57h83LwmjO3jrhg==
X-Received: by 2002:a05:6402:88f:b0:522:1d23:a1f8 with SMTP id
 e15-20020a056402088f00b005221d23a1f8mr4184850edy.26.1695301721313; 
 Thu, 21 Sep 2023 06:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5BehkElhUZwzt/pCYYxfas98l47+eljO8dQrZQePi2g5dU8RGzroT9XW+g1N1dFH8FOdivg==
X-Received: by 2002:a05:6402:88f:b0:522:1d23:a1f8 with SMTP id
 e15-20020a056402088f00b005221d23a1f8mr4184828edy.26.1695301720957; 
 Thu, 21 Sep 2023 06:08:40 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 j7-20020a50ed07000000b00527e7087d5dsm806498eds.15.2023.09.21.06.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 06:08:38 -0700 (PDT)
Date: Thu, 21 Sep 2023 09:08:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20230921090536-mutt-send-email-mst@kernel.org>
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


I don't get the motivation for this and the next patch.
We already have vdpa that seems to do exactly this:
drive virtio from userspace. Why do we need these extra 1000
lines of code in vfio - just because we can?
Not to talk about user confusion all this will cause.


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
> +	cmd.data_sg = &in_sg;
> +	ret = virtio_admin_cmd_exec(virtio_dev, &cmd);
> +
> +	kfree(in);
> +	return ret;
> +}
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
