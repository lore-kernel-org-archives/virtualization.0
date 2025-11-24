Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DB18634F
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764016267; cv=none; b=enLXBGFj2SvrH+d661EBzxjypaJD8kPBLtKgwbZg/FuT8QC/n33DZVTdFUWUCN7hM8rK0mPTeStwyOZu985iNTShm0iCtjGPX2pT03czYEhqqW89F4Fe0Q9FuOhrzKlmLj5FnK9AdFbSv30WDE10j/+zssW+LkLzhNqHquVjb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764016267; c=relaxed/simple;
	bh=fchSxyOzP25TXlOhKWqDfPOikpwASRplcfW3WbkoNjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=B17AsX8Y8mo1XyLZFjNs4Q/j//xgxTDybp3NbFsxSxazM5JQe0bbfxnBmsAEaMUgZsFse0Pi/2roJBo2rNVsjg43pRXTqeh2PVZb/1gyVaMlfl2vSkbdZX0x09wEB4+9AUb932PRVT7CKKBsKvisCG7iEbjqrZYZmE3VZF701qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hvk9NlTH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hvk9NlTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764016261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2pAhvittlmQzx3f0gLjregk5ZIv3cBZgLn95qIAE8ZI=;
	b=Hvk9NlTHQtxCLifWXM4cUkAFIg/yKLlSf+8oSMxRFlLh0jwO/mai/XiemE4bOWFmlv6+Qw
	G3ukj2Cf+R2fkAsUq5w4mI24rFB07GMvy2QDX6pttuIkmDwIEPdQX2ikhveepGHSBOUVP1
	8KQ/NinY2YNTpN2V0LvrXBKaHD42uSw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-EciViIpJPqu5-9SAyqA6Iw-1; Mon, 24 Nov 2025 15:31:00 -0500
X-MC-Unique: EciViIpJPqu5-9SAyqA6Iw-1
X-Mimecast-MFC-AGG-ID: EciViIpJPqu5-9SAyqA6Iw_1764016259
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so21806875e9.3
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 12:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764016259; x=1764621059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pAhvittlmQzx3f0gLjregk5ZIv3cBZgLn95qIAE8ZI=;
        b=VhiH0Adaqu8ieG7vrcCwqfsXcMVzcmOYM/ob5vj3xJgLI3IExgDcATuC3JnKMF9xVX
         2/tLW+CEJ586ARhX8D6zzSPZoiVH+Hij4h+5v7TrN+/bKGT4cZ7rlVFejNIg2bGB2MwT
         UN+7yfnSGi1eu9AMsiu8RCUHrNZc99493bPof9/kZzY2itPfazJIHBTGJhov75HK0KPl
         EE1f9OOX2js/5R87Gtn83TYWWJ62aFYC0aitI0K6WYEOYMB6kN+RwdGPA3lzWf2P7YPg
         vBlzd+b4wlIsxQvW0/22nwezOVIOWrw2joMkP+77Qcm5VaPMGtVew5HntjC7p9ByIUUz
         NK4w==
X-Forwarded-Encrypted: i=1; AJvYcCW6+5oGlN7V8IBIIWSa3EiLsKEBB4ffKLqUwEpBsX8x9OEZgKsk05AVSy3N4OzD/kcC5/Qg99mw1y13otx6fg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxp6NeQ0SwOOFjz1zlFzlzXv5EZbXqmHKpB1XI5uKEHYr155NPl
	PYhv9WEpFxis91PXxePQx/kJbYCzJWh4AkvfVdQThi/Rmfbbpt7JOCCfGlWA0Vv8mxYwv2FSL2K
	+0NBzjpPIS5wa+ptXkfd7BA/fULGrLYMFIYTRTTpGCUOcm7dYe7fqVDGOVlGhCFUZoMe2
X-Gm-Gg: ASbGnctCLhrpDmMR6EWwrCbVDDOrb3cqgRPEboMKwO4rbECLDBaS24vI9dUsbsvlFaP
	XTWqDqrX6eIaNzRkwgQta99PLgU1llS9HQhj5XexXGV+ALvkplMcMMInuaCnTU58QTec/X7S0oh
	p6LTZRT172rYyK7GRO1mNOwWY/for8W2MaePzDqvt5j8dzHebwLyIxUZHphrm+moUchzXZkbgLS
	PvYYEWX2/j5fitTFQ95royK00neY0fCikAbQ8Avhve0LQ8Od5Jiwu0QPtVqFufdpLvHmmRl4W/G
	lZ5sPPgMUdA547Fkq8xioXqwQlRfBFhWxqUnXzcuQ2En8u73955nGrT9XPl5IqcyoEVybhWqaqr
	/d976tnGq80DC4EvoC2kphbC+zXbWaw==
X-Received: by 2002:a05:600c:4f53:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47904b12f35mr1563275e9.16.1764016258909;
        Mon, 24 Nov 2025 12:30:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/lEpl8A5WguuB6gHGGKA9y2m2N0osP3IPKnjrOrlZgIcHz+3JrCvGBt4heE09qmmCrwPUqw==
X-Received: by 2002:a05:600c:4f53:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47904b12f35mr1562925e9.16.1764016258335;
        Mon, 24 Nov 2025 12:30:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1e868bsm206492455e9.4.2025.11.24.12.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 12:30:57 -0800 (PST)
Date: Mon, 24 Nov 2025 15:30:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 03/12] virtio: Expose generic device
 capability operations
Message-ID: <20251124152548-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-4-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251119191524.4572-4-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HBDGEMhn1NhXu1MU8RDfb1JWZxaVnD5Jte88sIosF7I_1764016259
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:15:14PM -0600, Daniel Jurgens wrote:
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
> ---
>  drivers/virtio/Makefile                |  2 +-
>  drivers/virtio/virtio_admin_commands.c | 91 ++++++++++++++++++++++++++
>  include/linux/virtio_admin.h           | 80 ++++++++++++++++++++++
>  include/uapi/linux/virtio_pci.h        |  6 +-
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
> index 000000000000..a2254e71e8dc
> --- /dev/null
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
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


I still don't get why cap_size needs to be as large as size_t.

if you don't care what's it size is, just say "unsigned".
or u8 as a hint to users it's a small value.

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

uses kzalloc without including linux/slab.h



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
> index c691ac210ce2..2e35fd8d4a95 100644
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

