Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181F4C4332F
	for <virtualization@archiver.kernel.org>; Tue, 31 Oct 2023 08:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 869906115B;
	Tue, 31 Oct 2023 08:09:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 869906115B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eOIX7s4y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QrP5Ix8TEIIo; Tue, 31 Oct 2023 08:09:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A1AC861166;
	Tue, 31 Oct 2023 08:09:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1AC861166
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61647C0039;
	Tue, 31 Oct 2023 08:09:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13C39C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 08:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF2EA61166
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 08:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF2EA61166
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tjLy2brg-9Qj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 08:09:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 807E46115B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 08:09:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 807E46115B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698739765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jy3I56vt9/uDV72QxxQPe8LI+zhUzBIbi4Hc8Vv7wTE=;
 b=eOIX7s4yrdOSnD6qNiUgye/qnQ1kHg2pG2dI9Xr9WthTT5EFYGrt0nXFL5x9SGPjmCI8LU
 wzp0Q8joWCKGme21TO1cdYP+sDGG27cD30KKiZZnzXnd4MGQQ3g92Nyy5HEOKDJW4hiUqx
 SMexn+Q4orVewQSlPGm+ic868ECQSQ4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-YYDoePzMPIWhOkbFXy0vFg-1; Tue, 31 Oct 2023 04:09:21 -0400
X-MC-Unique: YYDoePzMPIWhOkbFXy0vFg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c515541a25so53520391fa.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 01:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698739760; x=1699344560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jy3I56vt9/uDV72QxxQPe8LI+zhUzBIbi4Hc8Vv7wTE=;
 b=nkAoXhMFmksnAQxUxfXkPRig4jtHK7OZJb69TES4faiqYhkpvcu9/hpSC2FdhZ1mUR
 r3EKhZxc+QpXzuMskpcc5X5A+CFnzLl0RPdGYq569dT2/QXeiDO7dhIxzM6YQjVz5nol
 mVabmJm9af8uQhDlpXdT09OkfsUPVGq1FC+HMW+j96cA6mdxk9fEL9Tn+HFShml81qjt
 GfryXHOOvstnJnSApvzFTnHUPuEtkNwuJlqtei17EMacaTFmMXUT18N7+9xxpXKO4B6i
 Ct95ymOiKAGt5YDYtID2uOp5U6uD2geO9KL8kJiGkA6fdobjlZTaAZqfMRmYU+pipN74
 1d/Q==
X-Gm-Message-State: AOJu0YzaP58rn2Ptgqjt9b/gy2dNNFHVRXH3D8iE7/ntUzq/TYNrRwpQ
 EqgwzpY0E6qoyfacjkGqhqDx8Jm1jiTRrSyqCEk3hTiJivT2BTchBeu5rHUrzB1/F/pWf1bQNqj
 9TQYuXf4g/NHFfdJJ3kMtyktibIMOujYnCt4qTRlEdg==
X-Received: by 2002:a2e:3a07:0:b0:2c5:1623:66b8 with SMTP id
 h7-20020a2e3a07000000b002c5162366b8mr9030612lja.12.1698739759761; 
 Tue, 31 Oct 2023 01:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKSJXM9VJBXAsv6oq0Y/bSSa58zgIBpMoVuWC2INoZcw9Lr4oDvPtP13yAwI7ScSSrljneNg==
X-Received: by 2002:a2e:3a07:0:b0:2c5:1623:66b8 with SMTP id
 h7-20020a2e3a07000000b002c5162366b8mr9030595lja.12.1698739759360; 
 Tue, 31 Oct 2023 01:09:19 -0700 (PDT)
Received: from redhat.com ([2.52.26.150]) by smtp.gmail.com with ESMTPSA id
 bx31-20020a05651c199f00b002c0d9d83f71sm116228ljb.62.2023.10.31.01.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 01:09:18 -0700 (PDT)
Date: Tue, 31 Oct 2023 04:09:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V2 vfio 6/9] virtio-pci: Introduce APIs to execute legacy
 IO admin commands
Message-ID: <20231031040403-mutt-send-email-mst@kernel.org>
References: <20231029155952.67686-1-yishaih@nvidia.com>
 <20231029155952.67686-7-yishaih@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231029155952.67686-7-yishaih@nvidia.com>
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

On Sun, Oct 29, 2023 at 05:59:49PM +0200, Yishai Hadas wrote:
> Introduce APIs to execute legacy IO admin commands.
> 
> It includes: io_legacy_read/write for both common and the device
> registers, io_legacy_notify_info.
> 
> In addition, exposing an API to check whether the legacy IO commands are
> supported. (i.e. virtio_pci_admin_has_legacy_io()).
> 
> Those APIs will be used by the next patches from this series.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_common.c |  11 ++
>  drivers/virtio/virtio_pci_common.h |   2 +
>  drivers/virtio/virtio_pci_modern.c | 241 +++++++++++++++++++++++++++++
>  include/linux/virtio_pci_admin.h   |  21 +++
>  4 files changed, 275 insertions(+)
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
> index 9e07e556a51a..07d4f863ac44 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -156,4 +156,6 @@ static inline void virtio_pci_legacy_remove(struct virtio_pci_device *vp_dev)
>  int virtio_pci_modern_probe(struct virtio_pci_device *);
>  void virtio_pci_modern_remove(struct virtio_pci_device *);
>  
> +struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
> +
>  #endif
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 25e27aa79cab..def0f2de6091 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -15,6 +15,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/virtio_pci_admin.h>
>  #define VIRTIO_PCI_NO_LEGACY
>  #define VIRTIO_RING_NO_LEGACY
>  #include "virtio_pci_common.h"
> @@ -794,6 +795,246 @@ static void vp_modern_destroy_avq(struct virtio_device *vdev)
>  	vp_dev->del_vq(&vp_dev->admin_vq.info);
>  }
>  
> +#define VIRTIO_LEGACY_ADMIN_CMD_BITMAP \
> +	(BIT_ULL(VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE) | \
> +	 BIT_ULL(VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ) | \
> +	 BIT_ULL(VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE) | \
> +	 BIT_ULL(VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ) | \
> +	 BIT_ULL(VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO))
> +
> +/*
> + * virtio_pci_admin_has_legacy_io - Checks whether the legacy IO
> + * commands are supported
> + * @dev: VF pci_dev
> + *
> + * Returns true on success.
> + */
> +bool virtio_pci_admin_has_legacy_io(struct pci_dev *pdev)
> +{
> +	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
> +	struct virtio_pci_device *vp_dev;
> +
> +	if (!virtio_dev)
> +		return false;
> +
> +	if (!virtio_has_feature(virtio_dev, VIRTIO_F_ADMIN_VQ))
> +		return false;
> +
> +	vp_dev = to_vp_device(virtio_dev);
> +
> +	if ((vp_dev->admin_vq.supported_cmds & VIRTIO_LEGACY_ADMIN_CMD_BITMAP) ==
> +		VIRTIO_LEGACY_ADMIN_CMD_BITMAP)
> +		return true;
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(virtio_pci_admin_has_legacy_io);
> +
> +static int virtio_pci_admin_legacy_io_write(struct pci_dev *pdev, u16 opcode,
> +					    u8 offset, u8 size, u8 *buf)
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


> +
> +/*
> + * virtio_pci_admin_legacy_io_write_common - Write common legacy registers
> + * of a member device
> + * @dev: VF pci_dev
> + * @offset: starting byte offset within the registers to write to
> + * @size: size of the data to write
> + * @buf: buffer which holds the data
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int virtio_pci_admin_legacy_common_io_write(struct pci_dev *pdev, u8 offset,
> +					    u8 size, u8 *buf)
> +{
> +	return virtio_pci_admin_legacy_io_write(pdev,
> +					VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> +					offset, size, buf);
> +}
> +EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_common_io_write);

So consider this for example. You start with a PCI device of a VF.
Any number of these will access a PF in parallel. No locking
is taking place so admin vq can get corrupted.
And further, is caller expected not to invoke several of these
in parallel on the same device? If yes this needs to be
documented. I don't see where does vfio enforce this if yes.

 
> +
> +/*
> + * virtio_pci_admin_legacy_io_write_device - Write device legacy registers
> + * of a member device
> + * @dev: VF pci_dev
> + * @offset: starting byte offset within the registers to write to
> + * @size: size of the data to write
> + * @buf: buffer which holds the data
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int virtio_pci_admin_legacy_device_io_write(struct pci_dev *pdev, u8 offset,
> +					    u8 size, u8 *buf)
> +{
> +	return virtio_pci_admin_legacy_io_write(pdev,
> +					VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE,
> +					offset, size, buf);
> +}
> +EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_device_io_write);
> +
> +static int virtio_pci_admin_legacy_io_read(struct pci_dev *pdev, u16 opcode,
> +					   u8 offset, u8 size, u8 *buf)
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
> +
> +/*
> + * virtio_pci_admin_legacy_device_io_read - Read legacy device registers of
> + * a member device
> + * @dev: VF pci_dev
> + * @offset: starting byte offset within the registers to read from
> + * @size: size of the data to be read
> + * @buf: buffer to hold the returned data
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int virtio_pci_admin_legacy_device_io_read(struct pci_dev *pdev, u8 offset,
> +					   u8 size, u8 *buf)
> +{
> +	return virtio_pci_admin_legacy_io_read(pdev,
> +					VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +					offset, size, buf);
> +}
> +EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_device_io_read);
> +
> +/*
> + * virtio_pci_admin_legacy_common_io_read - Read legacy common registers of
> + * a member device
> + * @dev: VF pci_dev
> + * @offset: starting byte offset within the registers to read from
> + * @size: size of the data to be read
> + * @buf: buffer to hold the returned data
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int virtio_pci_admin_legacy_common_io_read(struct pci_dev *pdev, u8 offset,
> +					    u8 size, u8 *buf)
> +{
> +	return virtio_pci_admin_legacy_io_read(pdev,
> +					VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> +					offset, size, buf);
> +}
> +EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_common_io_read);
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
> index 000000000000..446ced8cb050
> --- /dev/null
> +++ b/include/linux/virtio_pci_admin.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_VIRTIO_PCI_ADMIN_H
> +#define _LINUX_VIRTIO_PCI_ADMIN_H
> +
> +#include <linux/types.h>
> +#include <linux/pci.h>
> +
> +bool virtio_pci_admin_has_legacy_io(struct pci_dev *pdev);
> +int virtio_pci_admin_legacy_common_io_write(struct pci_dev *pdev, u8 offset,
> +					    u8 size, u8 *buf);
> +int virtio_pci_admin_legacy_common_io_read(struct pci_dev *pdev, u8 offset,
> +					   u8 size, u8 *buf);
> +int virtio_pci_admin_legacy_device_io_write(struct pci_dev *pdev, u8 offset,
> +					    u8 size, u8 *buf);
> +int virtio_pci_admin_legacy_device_io_read(struct pci_dev *pdev, u8 offset,
> +					   u8 size, u8 *buf);
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
