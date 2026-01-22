Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF936654E
	for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769103142; cv=none; b=H8PpYRDhNJKz5IEVQ2Ll/7qWaOpKzMvBx+8WkxUIphhrB4NsZjL6cr0e7i8m6x5wOZEohv1o6A1+7k94TUu8PVSIr2eX/bj6BQ8j+3ydtQbculJWtWLpnnMcudPgnZo01Pc0GZ9vHlFrNlUC2jMp5gwYMwKY9CNopEDPgbHeELo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769103142; c=relaxed/simple;
	bh=eJv4Z7sUtZ+//02XXkVm9PDdJkYckLlGkf2WddYj4Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uVZOsFpCC4RffDZhYcUu190B+WpFRfgtmRQmYH/Y9s8D7LU4IneKQdUD1e3ReHh6C9ExGhhY5vH8Z2R4JEAVMtAGthteTOESSyN9ZIZo3HMgxWXZRz27Km4MQ4OvD2cp6mEypRxSP0Dgt5ZwLf+7XSTML7OmjJc8wQOxOCtX3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIveYHps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIveYHps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769103132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZW4eJAfrsGa1ZU20w8pncSv/+Rpog/RsPuNfrnK952k=;
	b=dIveYHpsnLC7/g+de/Syy6YDxwGONu8iJZbkkrRr6VJQgxeJE0F6Ozkw1Z5VXhH/OwFpx1
	jrCmvQifXUuSA+eoN41Vk/M/15JgcPcpCL41NbO07x3xq776Rd+9ohTJZiL+eMQcCqM5wA
	N1QT9/2KGG2EeYg+GW1FSmzlx/jVv6A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-V1VrGDSeOAWcN3ll1C_pOA-1; Thu, 22 Jan 2026 12:32:10 -0500
X-MC-Unique: V1VrGDSeOAWcN3ll1C_pOA-1
X-Mimecast-MFC-AGG-ID: V1VrGDSeOAWcN3ll1C_pOA_1769103130
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4801e2e3532so8836815e9.2
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 09:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769103129; x=1769707929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZW4eJAfrsGa1ZU20w8pncSv/+Rpog/RsPuNfrnK952k=;
        b=C+8742eAD5nrnVPproh9hyZzyuOEkvQnZGfj7vQ5gWbFldj3OdBw9YtnGQnZVU9dgG
         pdT9yxOhDlv/oh7NlxEmgPpsblgGd/UX1H+vtV8as/t8RI7yLCbg5SIwBPP8QbnSKFQe
         dDCjQTM7HUDzzC3r5PRyHE0XokzoZZuIZY5BbXwIWCvLQ1a2TBnrfs7JIoupSRDMrxlV
         5eGcLUJxVwrpiTyIXxPuXnhLK77XTNE07mz2c2/5kbCZpPL9VlUnTEaXLO3Qk5UQSQBk
         Uvjk8GCv8bpVATbSXkipjP4O8DtxtTx/eWpHwHDRgYu6GTOcdcjh+1O+Ka086f9NFn7l
         cYRw==
X-Forwarded-Encrypted: i=1; AJvYcCVh36M1wv2X9aZr9LpAZhZ+p0XUVYnjjB7Lqou38i0YIY8sSL2nWrrRJfCPzt4x2Q7lm1EF9g0G3sKoeLEYtA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3ZNb1kW2rJp3euYjgae1zuKgpQwhr3nHlPMEDGDYz0J65hfMd
	OH3VcZBTYiwGZyCzGFClLQsLm85sJhOeFtA9ZHVbQD3BAU8Fll8BkC2dCiS1KWWPQCJ62K+mJno
	2sfo9ikaCzQCnobri6xkIUjpYQibCRcDUjHtiHuGYVZudjGWN4vet1EzALE/AoWlRPm0G
X-Gm-Gg: AZuq6aJpzbA0/tbwS5y8vmAi9IQjTppL47tf3xKgvRJuBKeabe36ocXj0qhri+E2IOc
	y5UCBMPRksdBL3Sdf1fiXE2zq3Kke3lQpDIOq0Rtv59DvirLsBkq46meqCA7ceefbYW1X5DI/g3
	F3djO37ja7ZWw5DohyX1mhAh/Xcmzu3iznRM8hicPnV3vcj1Plc5HbmrqZkzSBS/RyF0CH5UnXX
	GOKIsth+N1z73mt0G+XaXd50Qxi2+CgmH2+pnP6Y8uMGdzr2tglY4JsLRUjllfWAE9EsLWAeBqL
	19oA7VKfyckq/lo9IGGIpSclMIB0Qv6L174l0gM2Nq85Z+eYYtoWafwtZ4zIVAWWPD9f46+9cHX
	knpyW/2w4fp2WuSGjWlo8fqNNzZ+Qba33WQ==
X-Received: by 2002:a05:600c:1f84:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-4804c9cac70mr7152795e9.35.1769103129328;
        Thu, 22 Jan 2026 09:32:09 -0800 (PST)
X-Received: by 2002:a05:600c:1f84:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-4804c9cac70mr7152075e9.35.1769103128798;
        Thu, 22 Jan 2026 09:32:08 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804703b5b4sm82434125e9.5.2026.01.22.09.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:32:08 -0800 (PST)
Date: Thu, 22 Jan 2026 12:32:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v16 03/12] virtio: Expose generic device
 capability operations
Message-ID: <20260122122623-mutt-send-email-mst@kernel.org>
References: <20260121220652.894364-1-danielj@nvidia.com>
 <20260121220652.894364-4-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260121220652.894364-4-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HW5c3g7rbuXz14s1lRYCw3Q2wf1wPa9r0Kv_mLMZuk0_1769103130
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 21, 2026 at 04:06:43PM -0600, Daniel Jurgens wrote:
> Currently querying and setting capabilities is restricted to a single
> capability and contained within the virtio PCI driver. However, each
> device type has generic and device specific capabilities, that may be
> queried and set. In subsequent patches virtio_net will query and set
> flow filter capabilities.
> 
> This changes the size of virtio_admin_cmd_query_cap_id_result. It's safe
> to do because this data is written by DMA, so a newer controller can't
> overrun the size on an older kernel.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> ---
> v4: Moved this logic from virtio_pci_modern to new file
>     virtio_admin_commands.
> 
> v12:
>   - Removed uapi virtio_pci include in virtio_admin.h. MST
>   - Added virtio_pci uapi include to virtio_admin_commands.c
>   - Put () around cap in macro. MST
>   - Removed nonsense comment above VIRTIO_ADMIN_MAX_CAP. MST
>   - +1 VIRTIO_ADMIN_MAX_CAP when calculating array size. MST
>   - Updated commit message
> 
> v13:
>   - Include linux/slab.h MST
>   - Check for overflow when adding inputs. MST
> ---
>  drivers/virtio/Makefile                |  2 +-
>  drivers/virtio/virtio_admin_commands.c | 94 ++++++++++++++++++++++++++
>  include/linux/virtio_admin.h           | 80 ++++++++++++++++++++++
>  include/uapi/linux/virtio_pci.h        |  6 +-
>  4 files changed, 179 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/virtio/virtio_admin_commands.c
>  create mode 100644 include/linux/virtio_admin.h
> 
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index eefcfe90d6b8..2b4a204dde33 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
> +obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_admin_commands.o
>  obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
>  obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
>  obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
> new file mode 100644
> index 000000000000..cd000ecfc189
> --- /dev/null
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/slab.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_admin.h>
> +#include <uapi/linux/virtio_pci.h>
> +
> +int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
> +				   struct virtio_admin_cmd_query_cap_id_result *data)
> +{
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist result_sg;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	sg_init_one(&result_sg, data, sizeof(*data));
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
> +	cmd.result_sg = &result_sg;
> +
> +	return vdev->config->admin_cmd_exec(vdev, &cmd);
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_cap_id_list_query);
> +
> +int virtio_admin_cap_get(struct virtio_device *vdev,
> +			 u16 id,
> +			 void *caps,
> +			 size_t cap_size)
> +{
> +	struct virtio_admin_cmd_cap_get_data *data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist result_sg;
> +	struct scatterlist data_sg;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->id = cpu_to_le16(id);
> +	sg_init_one(&data_sg, data, sizeof(*data));
> +	sg_init_one(&result_sg, caps, cap_size);
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
> +	cmd.data_sg = &data_sg;
> +	cmd.result_sg = &result_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_cap_get);
> +
> +int virtio_admin_cap_set(struct virtio_device *vdev,
> +			 u16 id,
> +			 const void *caps,
> +			 size_t cap_size)
> +{
> +	struct virtio_admin_cmd_cap_set_data *data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	size_t data_size;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	if (check_add_overflow(sizeof(*data), cap_size, &data_size))

Nice but now you need

#include <linux/overflow.h>


> +		return -EOVERFLOW;
> +
> +	data = kzalloc(data_size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->id = cpu_to_le16(id);
> +	memcpy(data->cap_specific_data, caps, cap_size);
> +	sg_init_one(&data_sg, data, data_size);
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DRIVER_CAP_SET);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
> +	cmd.data_sg = &data_sg;
> +	cmd.result_sg = NULL;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> new file mode 100644
> index 000000000000..4ab84d53c924
> --- /dev/null
> +++ b/include/linux/virtio_admin.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Header file for virtio admin operations
> + */
> +
> +#ifndef _LINUX_VIRTIO_ADMIN_H
> +#define _LINUX_VIRTIO_ADMIN_H
> +
> +struct virtio_device;
> +struct virtio_admin_cmd_query_cap_id_result;
> +
> +/**
> + * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capability list
> + * @cap_list: Pointer to capability list structure containing supported_caps array
> + * @cap: Capability ID to check
> + *
> + * The cap_list contains a supported_caps array of little-endian 64-bit integers
> + * where each bit represents a capability. Bit 0 of the first element represents
> + * capability ID 0, bit 1 represents capability ID 1, and so on.
> + *
> + * Return: 1 if capability is supported, 0 otherwise
> + */
> +#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
> +	(!!(1 & (le64_to_cpu(cap_list->supported_caps[(cap) / 64]) >> (cap) % 64)))
> +
> +/**
> + * virtio_admin_cap_id_list_query - Query the list of available capability IDs
> + * @vdev: The virtio device to query
> + * @data: Pointer to result structure (must be heap allocated)
> + *
> + * This function queries the virtio device for the list of available capability
> + * IDs that can be used with virtio_admin_cap_get() and virtio_admin_cap_set().
> + * The result is stored in the provided data structure.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or capability queries, or a negative error code on other failures.
> + */
> +int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
> +				   struct virtio_admin_cmd_query_cap_id_result *data);
> +
> +/**
> + * virtio_admin_cap_get - Get capability data for a specific capability ID
> + * @vdev: The virtio device
> + * @id: Capability ID to retrieve
> + * @caps: Pointer to capability data structure (must be heap allocated)
> + * @cap_size: Size of the capability data structure
> + *
> + * This function retrieves a specific capability from the virtio device.
> + * The capability data is stored in the provided buffer. The caller must
> + * ensure the buffer is large enough to hold the capability data.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or capability retrieval, or a negative error code on other failures.
> + */
> +int virtio_admin_cap_get(struct virtio_device *vdev,
> +			 u16 id,
> +			 void *caps,
> +			 size_t cap_size);

So if you are using u16 and size_t you need the appropriate headers.



> +
> +/**
> + * virtio_admin_cap_set - Set capability data for a specific capability ID
> + * @vdev: The virtio device
> + * @id: Capability ID to set
> + * @caps: Pointer to capability data structure (must be heap allocated)
> + * @cap_size: Size of the capability data structure
> + *
> + * This function sets a specific capability on the virtio device.
> + * The capability data is read from the provided buffer and applied
> + * to the device. The device may validate the capability data before
> + * applying it.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or capability setting, or a negative error code on other failures.
> + */
> +int virtio_admin_cap_set(struct virtio_device *vdev,
> +			 u16 id,
> +			 const void *caps,
> +			 size_t cap_size);
> +
> +#endif /* _LINUX_VIRTIO_ADMIN_H */
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index e732e3456e27..96d097d3757e 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -315,15 +315,17 @@ struct virtio_admin_cmd_notify_info_result {
>  
>  #define VIRTIO_DEV_PARTS_CAP 0x0000
>  
> +#define VIRTIO_ADMIN_MAX_CAP 0x0fff
> +
>  struct virtio_dev_parts_cap {
>  	__u8 get_parts_resource_objects_limit;
>  	__u8 set_parts_resource_objects_limit;
>  };
>  
> -#define MAX_CAP_ID __KERNEL_DIV_ROUND_UP(VIRTIO_DEV_PARTS_CAP + 1, 64)
> +#define VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE __KERNEL_DIV_ROUND_UP(VIRTIO_ADMIN_MAX_CAP + 1, 64)
>  
>  struct virtio_admin_cmd_query_cap_id_result {
> -	__le64 supported_caps[MAX_CAP_ID];
> +	__le64 supported_caps[VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE];
>  };
>  
>  struct virtio_admin_cmd_cap_get_data {
> -- 
> 2.50.1

