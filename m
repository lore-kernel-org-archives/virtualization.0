Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE72ECE98
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502166; cv=none; b=HAQlxPGbTDcchsuZ4ngwBUGUHqaHYoKQnUahsroOdUqRkmpiaN/B7L2WXQTzDmmL4WqZqcfgQakQtzQ39pHDXd1GG+g1yJE3fY9A8X+v7H0WSEvtI0o4lIscFryI3HszMmw+36UXUUqHk5JSPcO9MSjfxc3RZdI7dLmDYfETkGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502166; c=relaxed/simple;
	bh=2QXE63rNeCrDpSnxmMevQOzDxZ2+5tY2szdW/tRIBNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XqiUEEkK8yIcGOBygZQO2fVmBwYFnwfZ2179aqp3nfAmSdPLs4Ou0U889m8vQpPAKbzGHOZjJsLCfRKZX6ImbhuoOZdovpanEBMH6Umwo6Ayh5cSfLgvP056PYBrsYXOFshuZk9Axye0zBuRvJaBbDDxmZlwS6l6L1o2szjxHKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SrithYDI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrithYDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763502163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BYuoFBhBBajrOik2Nx4QIW18pR2RH8vTxWxjT7vI9ZU=;
	b=SrithYDIJPZrXzOwQvU9Or7qr2mHH8n2aREKDCrNe37XNWhLhiEK0DNUKmqiuELQ+S65cb
	8mB7cHdM6N8xz80sQp4AqKpVfPYIn7n+8VsqONNOzh99A30MuT+L9WII8BxaIJiLeNAvtp
	tY7hQcO9YSGgaoTUJrn4qgtOccyYc6o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-w9CWgZgbMJ2cBFEaYqQ-wg-1; Tue, 18 Nov 2025 16:42:42 -0500
X-MC-Unique: w9CWgZgbMJ2cBFEaYqQ-wg-1
X-Mimecast-MFC-AGG-ID: w9CWgZgbMJ2cBFEaYqQ-wg_1763502161
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2f79759bso4254449f8f.2
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 13:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763502161; x=1764106961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYuoFBhBBajrOik2Nx4QIW18pR2RH8vTxWxjT7vI9ZU=;
        b=olNy2oifV7C8ocvY36iAcHU74miXTaQjI6DAcDawkQPezRqg1Y5E/lISt56TA9T8jQ
         j/hKRwjks4+6jCW6VAjD6eLob4rlx8I/jZ8Tqv4ia77em+E+L9iLOxUFACawtwPb9e0x
         f0oiPcUrBdeHxCxcWYm2m3LMITgQN3w3LiDumfwIT4kyxo05MF1hKS9Y5RU4yskTn5uf
         7vffHPxHrhT2WXdBr5i6t9yxd/TFU4tApStajkOSnk/NQdlFWvtXWF46Zs/G7uimkkJd
         rc0kj+FU6Up6zv+CAd3Y48yIn3l52DxhzJUjm/6kMabP7vJSv2o+HhZmd5mzmZKvVqMD
         Nh7w==
X-Forwarded-Encrypted: i=1; AJvYcCXxElXG5ixbMxq8p3GUIGS4Ajp1r8rt3yhA8P21N6qy2Xi/r/5eYSyo9si79OjNsiEjrC0+qrxxZ4l9nHTqQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzditgHpx2lKKwh/NLgGFCUgWU7QVeIN8ApC7NdTNj9OEr/8lpX
	qmckfcIskDq1xsETP5PxDs14urE/3ZrpF+TbrZ6M5U7D/Ax4D7KBtlNLhA98veSEqnFbPfJBl/e
	vvlbhhfzEUAILb3C1qgklEVW9AiBKRbYHqRgLfZUs60ldgZ/zaITpVjrEDoplNUvf46Dh
X-Gm-Gg: ASbGncs6DHCA5IVqjXGTAcf6T4HMIWyLcrtvnVttK+rtxweR0/kESOmGGQkgFSZfuHB
	OCIxnLooi9jIbY8y1195vd8NXRhi5MmvU0oGjGZrUSYlxQCUuZDb7BwHNtG3XxEyqyfa6KHoPyx
	mwzsl4sIrqPNBqpnyRphl7ZkI7iLvH0UGQ8bnd+4lAyXupky4DjedqTTg7ov03CDJxmUlAqne5P
	8qSeubjy1BVh1sTJlWAUhdvsi0AJG5+NBQrjNklPgpqHzuoind4LxaFhzSh3PPo/LuZw7cvrHVr
	lZsThQaVjK5wbsiKB2wg2qc2YtZVP0yHcIWwJB+7oUCJ+wg778sjg3BYxfpEXkdq/R4UMcvEL46
	eXc69tdQ7Mmg3ldC4dnDjjxz1BBPQJw==
X-Received: by 2002:a5d:64e9:0:b0:42b:4139:579f with SMTP id ffacd0b85a97d-42b593424d1mr19791965f8f.25.1763502160844;
        Tue, 18 Nov 2025 13:42:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc78UCL3GQDAXcX3EXM99uT858/J78Du/mitghLYnvA3gaHtjjHHR0nCI7HqJbt02/DNfiQQ==
X-Received: by 2002:a5d:64e9:0:b0:42b:4139:579f with SMTP id ffacd0b85a97d-42b593424d1mr19791936f8f.25.1763502160224;
        Tue, 18 Nov 2025 13:42:40 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm35669240f8f.26.2025.11.18.13.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:42:39 -0800 (PST)
Date: Tue, 18 Nov 2025 16:42:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 03/12] virtio: Expose generic device
 capability operations
Message-ID: <20251118163249-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-4-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-4-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NlK-hu75kOou3CBQMThB9_uafUyHlJuHRbA_oQqT_oA_1763502161
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:38:53AM -0600, Daniel Jurgens wrote:
> Currently querying and setting capabilities is restricted to a single
> capability and contained within the virtio PCI driver. However, each
> device type has generic and device specific capabilities, that may be
> queried and set. In subsequent patches virtio_net will query and set
> flow filter capabilities.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> ---
> v4: Moved this logic from virtio_pci_modern to new file
>     virtio_admin_commands.
> ---
>  drivers/virtio/Makefile                |  2 +-
>  drivers/virtio/virtio_admin_commands.c | 90 ++++++++++++++++++++++++++
>  include/linux/virtio_admin.h           | 80 +++++++++++++++++++++++
>  include/uapi/linux/virtio_pci.h        |  7 +-
>  4 files changed, 176 insertions(+), 3 deletions(-)
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
> index 000000000000..94751d16b3c4
> --- /dev/null
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_admin.h>
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
> +	data_size = sizeof(*data) + cap_size;
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
> index 000000000000..36df97b6487a
> --- /dev/null
> +++ b/include/linux/virtio_admin.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Header file for virtio admin operations
> + */
> +#include <uapi/linux/virtio_pci.h>
> +
> +#ifndef _LINUX_VIRTIO_ADMIN_H
> +#define _LINUX_VIRTIO_ADMIN_H


Guards normally come before #include - there is no
point in pulling in uapi/linux/virtio_pci.h - just
extra work for the compiler.



> +
> +struct virtio_device;
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
> +	(!!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >> cap % 64)))

while this works if cap is a variable, it will behave
unexpectedly if cap or even cap_list is an expression.

A standard practice is to put all macro arguments in brackets:
!!(1 & (le64_to_cpu((cap_list)->supported_caps[(cap) / 64]) >> (cap) % 64)))





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
> index c691ac210ce2..0d5ca0cff629 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -315,15 +315,18 @@ struct virtio_admin_cmd_notify_info_result {
>  
>  #define VIRTIO_DEV_PARTS_CAP 0x0000
>  
> +/* Update this value to largest implemented cap number. */

implemented by what?

> +#define VIRTIO_ADMIN_MAX_CAP 0x0fff
> +
>  struct virtio_dev_parts_cap {
>  	__u8 get_parts_resource_objects_limit;
>  	__u8 set_parts_resource_objects_limit;
>  };
>  
> -#define MAX_CAP_ID __KERNEL_DIV_ROUND_UP(VIRTIO_DEV_PARTS_CAP + 1, 64)
> +#define VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE __KERNEL_DIV_ROUND_UP(VIRTIO_ADMIN_MAX_CAP, 64)

Don't you mean VIRTIO_ADMIN_MAX_CAP + 1 here?
E.g. if VIRTIO_ADMIN_MAX_CAP was 0 we would need space for 1 capability,
right?

>  
>  struct virtio_admin_cmd_query_cap_id_result {
> -	__le64 supported_caps[MAX_CAP_ID];
> +	__le64 supported_caps[VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE];
>  };
>  

I feel it's worth explaining in commit log you are changing a
uapi structure, and explaining that it is safe.


>  struct virtio_admin_cmd_cap_get_data {
> -- 
> 2.50.1

