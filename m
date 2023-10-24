Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F367C07545
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 21:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DFDC84016B;
	Tue, 24 Oct 2023 21:01:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DFDC84016B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hNnW07s4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QsWwo1wiyI6p; Tue, 24 Oct 2023 21:01:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BBD3F430E8;
	Tue, 24 Oct 2023 21:01:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBD3F430E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CCECC0039;
	Tue, 24 Oct 2023 21:01:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68F9EC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 21:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34B2C430E8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 21:01:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34B2C430E8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S8Egw0reCMw8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 21:01:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9B664016B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 21:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9B664016B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698181312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=msH1BFGDXU4Ck//kTMZ4kAjtkY8sp3CpLRtM1t2O4Bo=;
 b=hNnW07s4KrzC8tJX/46nk12droOVBzMqGB/Zhm50jyh+Iw34gH6pe6N7mlYwuHhfNlmCue
 f59v4VWd7knJLLQ6PD6AWc/rszKcJo0wK3ntJnuuMi/6HIsSCUGYQ6oy6bYBlD1pXU/HVN
 bCjVRLc8pS2xRbS1dZHEGVoNYL26yxg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-hhObJpLNPs2CEkgGxmZKQA-1; Tue, 24 Oct 2023 17:01:48 -0400
X-MC-Unique: hhObJpLNPs2CEkgGxmZKQA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507be692ce4so4952646e87.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 14:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698181307; x=1698786107;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=msH1BFGDXU4Ck//kTMZ4kAjtkY8sp3CpLRtM1t2O4Bo=;
 b=pGbv4ZbGW2s+iBeU2OJ9kbp1ZjHPaxi77LonjD7mXKfUZ9Bzm+ypIUhi/qI0WO4cmf
 ZOG/yxVWBSW6JKRtM/tK32ni4SaXp7eVIP8VrZeEZDngl/w0J19mDDG3KiInrXot09aE
 dUCLcbkLOWaQfn7ekux4m0vGm6wxTsbt8Sf8hu9zbpU1s0jU6Gj15B9OyxQNjQgV76oy
 KI5UeDVfwNNAPLFSgeubzUQcgGLWY1OITANxbgYGlrwpBHDnXLBYZnsqLXffTg9yF7Tq
 Ia7anGQZas13xiQI8Z0Kl9BjkPBv8IV0vueStrENcVeExG1ZpFj8niRx1mDwgsBWUFSL
 LnAA==
X-Gm-Message-State: AOJu0Yx7EnPBvXmrdMZeCxjyQM/jwdz29KDnkurj5GY2iTYXyqVTXmyb
 gEzBhZJ1sSXhH4R1Xet6bDezHeWD294AazB0nD7YB6YEtoeEYWK+F2cDH64Rtw2Dn3XEeT0cVBZ
 Ro2GW3Wtxk6hMxUQ1IFKa0MEg4jo+0vHBoPhj3as+ag==
X-Received: by 2002:a19:5004:0:b0:4ff:a04c:8a5b with SMTP id
 e4-20020a195004000000b004ffa04c8a5bmr8803178lfb.47.1698181307198; 
 Tue, 24 Oct 2023 14:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfYUjUKsW+pSOx7M8EZ3JWU1rj1JFpl73sVMDGoIAkc023GFWRa4uRR88z4fXgSvptmqyfbA==
X-Received: by 2002:a19:5004:0:b0:4ff:a04c:8a5b with SMTP id
 e4-20020a195004000000b004ffa04c8a5bmr8803157lfb.47.1698181306803; 
 Tue, 24 Oct 2023 14:01:46 -0700 (PDT)
Received: from redhat.com ([176.12.184.108]) by smtp.gmail.com with ESMTPSA id
 dj18-20020a0560000b1200b0032d96dd703bsm10700966wrb.70.2023.10.24.14.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 14:01:45 -0700 (PDT)
Date: Tue, 24 Oct 2023 17:01:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V1 vfio 6/9] virtio-pci: Introduce APIs to execute legacy
 IO admin commands
Message-ID: <20231024165210-mutt-send-email-mst@kernel.org>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <20231017134217.82497-7-yishaih@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231017134217.82497-7-yishaih@nvidia.com>
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

On Tue, Oct 17, 2023 at 04:42:14PM +0300, Yishai Hadas wrote:
> Introduce APIs to execute legacy IO admin commands.
> 
> It includes: list_query/use, io_legacy_read/write,
> io_legacy_notify_info.
> 
> Those APIs will be used by the next patches from this series.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_common.c |  11 ++
>  drivers/virtio/virtio_pci_common.h |   2 +
>  drivers/virtio/virtio_pci_modern.c | 206 +++++++++++++++++++++++++++++
>  include/linux/virtio_pci_admin.h   |  18 +++
>  4 files changed, 237 insertions(+)
>  create mode 100644 include/linux/virtio_pci_admin.h
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 6b4766d5abe6..212d68401d2c 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -645,6 +645,17 @@ static struct pci_driver virtio_pci_driver = {
>  	.sriov_configure = virtio_pci_sriov_configure,
>  };
>  
> +struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev)
> +{
> +	struct virtio_pci_device *pf_vp_dev;
> +
> +	pf_vp_dev = pci_iov_get_pf_drvdata(pdev, &virtio_pci_driver);
> +	if (IS_ERR(pf_vp_dev))
> +		return NULL;
> +
> +	return &pf_vp_dev->vdev;
> +}
> +
>  module_pci_driver(virtio_pci_driver);
>  
>  MODULE_AUTHOR("Anthony Liguori <aliguori@us.ibm.com>");
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index a21b9ba01a60..2785e61ed668 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -155,4 +155,6 @@ static inline void virtio_pci_legacy_remove(struct virtio_pci_device *vp_dev)
>  int virtio_pci_modern_probe(struct virtio_pci_device *);
>  void virtio_pci_modern_remove(struct virtio_pci_device *);
>  
> +struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
> +
>  #endif
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index cc159a8e6c70..00b65e20b2f5 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -719,6 +719,212 @@ static void vp_modern_destroy_avq(struct virtio_device *vdev)
>  	vp_dev->del_vq(&vp_dev->admin_vq.info);
>  }
>  
> +/*
> + * virtio_pci_admin_list_query - Provides to driver list of commands
> + * supported for the PCI VF.
> + * @dev: VF pci_dev
> + * @buf: buffer to hold the returned list
> + * @buf_size: size of the given buffer
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int virtio_pci_admin_list_query(struct pci_dev *pdev, u8 *buf, int buf_size)
> +{
> +	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist result_sg;
> +
> +	if (!virtio_dev)
> +		return -ENODEV;
> +
> +	sg_init_one(&result_sg, buf, buf_size);
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_QUERY);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
> +	cmd.result_sg = &result_sg;
> +
> +	return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
> +}
> +EXPORT_SYMBOL_GPL(virtio_pci_admin_list_query);
> +
> +/*
> + * virtio_pci_admin_list_use - Provides to device list of commands
> + * used for the PCI VF.
> + * @dev: VF pci_dev
> + * @buf: buffer which holds the list
> + * @buf_size: size of the given buffer
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int virtio_pci_admin_list_use(struct pci_dev *pdev, u8 *buf, int buf_size)
> +{
> +	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +
> +	if (!virtio_dev)
> +		return -ENODEV;
> +
> +	sg_init_one(&data_sg, buf, buf_size);
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_USE);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
> +	cmd.data_sg = &data_sg;
> +
> +	return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
> +}
> +EXPORT_SYMBOL_GPL(virtio_pci_admin_list_use);

list commands are actually for a group, not for the VF.

> +
> +/*
> + * virtio_pci_admin_legacy_io_write - Write legacy registers of a member device
> + * @dev: VF pci_dev
> + * @opcode: op code of the io write command

opcode is actually either VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
or VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE correct?

So please just add 2 APIs for this so users don't need to care.
Could be wrappers around these two things.




> + * @offset: starting byte offset within the registers to write to
> + * @size: size of the data to write
> + * @buf: buffer which holds the data
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int virtio_pci_admin_legacy_io_write(struct pci_dev *pdev, u16 opcode,
> +				     u8 offset, u8 size, u8 *buf)
> +{
> +	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
> +	struct virtio_admin_cmd_legacy_wr_data *data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	int vf_id;
> +	int ret;
> +
> +	if (!virtio_dev)
> +		return -ENODEV;
> +
> +	vf_id = pci_iov_vf_id(pdev);
> +	if (vf_id < 0)
> +		return vf_id;
> +
> +	data = kzalloc(sizeof(*data) + size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->offset = offset;
> +	memcpy(data->registers, buf, size);
> +	sg_init_one(&data_sg, data, sizeof(*data) + size);
> +	cmd.opcode = cpu_to_le16(opcode);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
> +	cmd.group_member_id = cpu_to_le64(vf_id + 1);
> +	cmd.data_sg = &data_sg;
> +	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
> +
> +	kfree(data);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_write);
> +
> +/*
> + * virtio_pci_admin_legacy_io_read - Read legacy registers of a member device
> + * @dev: VF pci_dev
> + * @opcode: op code of the io read command
> + * @offset: starting byte offset within the registers to read from
> + * @size: size of the data to be read
> + * @buf: buffer to hold the returned data
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int virtio_pci_admin_legacy_io_read(struct pci_dev *pdev, u16 opcode,
> +				    u8 offset, u8 size, u8 *buf)
> +{
> +	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
> +	struct virtio_admin_cmd_legacy_rd_data *data;
> +	struct scatterlist data_sg, result_sg;
> +	struct virtio_admin_cmd cmd = {};
> +	int vf_id;
> +	int ret;
> +
> +	if (!virtio_dev)
> +		return -ENODEV;
> +
> +	vf_id = pci_iov_vf_id(pdev);
> +	if (vf_id < 0)
> +		return vf_id;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->offset = offset;
> +	sg_init_one(&data_sg, data, sizeof(*data));
> +	sg_init_one(&result_sg, buf, size);
> +	cmd.opcode = cpu_to_le16(opcode);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
> +	cmd.group_member_id = cpu_to_le64(vf_id + 1);
> +	cmd.data_sg = &data_sg;
> +	cmd.result_sg = &result_sg;
> +	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
> +
> +	kfree(data);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_read);
> +
> +/*
> + * virtio_pci_admin_legacy_io_notify_info - Read the queue notification
> + * information for legacy interface
> + * @dev: VF pci_dev
> + * @req_bar_flags: requested bar flags
> + * @bar: on output the BAR number of the member device
> + * @bar_offset: on output the offset within bar
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int virtio_pci_admin_legacy_io_notify_info(struct pci_dev *pdev,
> +					   u8 req_bar_flags, u8 *bar,
> +					   u64 *bar_offset)
> +{
> +	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
> +	struct virtio_admin_cmd_notify_info_result *result;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist result_sg;
> +	int vf_id;
> +	int ret;
> +
> +	if (!virtio_dev)
> +		return -ENODEV;
> +
> +	vf_id = pci_iov_vf_id(pdev);
> +	if (vf_id < 0)
> +		return vf_id;
> +
> +	result = kzalloc(sizeof(*result), GFP_KERNEL);
> +	if (!result)
> +		return -ENOMEM;
> +
> +	sg_init_one(&result_sg, result, sizeof(*result));
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
> +	cmd.group_member_id = cpu_to_le64(vf_id + 1);
> +	cmd.result_sg = &result_sg;
> +	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
> +	if (!ret) {
> +		struct virtio_admin_cmd_notify_info_data *entry;
> +		int i;
> +
> +		ret = -ENOENT;
> +		for (i = 0; i < VIRTIO_ADMIN_CMD_MAX_NOTIFY_INFO; i++) {
> +			entry = &result->entries[i];
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
> +	kfree(result);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_notify_info);
> +
>  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.get		= NULL,
>  	.set		= NULL,
> diff --git a/include/linux/virtio_pci_admin.h b/include/linux/virtio_pci_admin.h
> new file mode 100644
> index 000000000000..cb916a4bc1b1
> --- /dev/null
> +++ b/include/linux/virtio_pci_admin.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_VIRTIO_PCI_ADMIN_H
> +#define _LINUX_VIRTIO_PCI_ADMIN_H
> +
> +#include <linux/types.h>
> +#include <linux/pci.h>
> +
> +int virtio_pci_admin_list_use(struct pci_dev *pdev, u8 *buf, int buf_size);
> +int virtio_pci_admin_list_query(struct pci_dev *pdev, u8 *buf, int buf_size);
> +int virtio_pci_admin_legacy_io_write(struct pci_dev *pdev, u16 opcode,
> +				     u8 offset, u8 size, u8 *buf);
> +int virtio_pci_admin_legacy_io_read(struct pci_dev *pdev, u16 opcode,
> +				    u8 offset, u8 size, u8 *buf);
> +int virtio_pci_admin_legacy_io_notify_info(struct pci_dev *pdev,
> +					   u8 req_bar_flags, u8 *bar,
> +					   u64 *bar_offset);
> +
> +#endif /* _LINUX_VIRTIO_PCI_ADMIN_H */
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
