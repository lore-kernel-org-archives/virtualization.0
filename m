Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECAA30DECD
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763504105; cv=none; b=kkFAIFR9NstzqlD4QXHMQ3jb9yJq14sNsT8t5/FiMDaG2vUfRN6UXzHC5lLSMR01h9kngt+cSMaprrRntNiX4L9etY51SOp9Ys7A20cXE6DDRP60ReO8JOnxpf89LXTWCzHXSHTwYcCJ5VtVY7nEFyc5STwfOB5Ezykn3KW8nWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763504105; c=relaxed/simple;
	bh=UebwBc4wvYmdjjBpC5J+/F1JyAju4zl5Jn6Kf5bKNsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tMiov5ICyk7y2Ynz1bEST1UyCM6BcdG/1XrmR6jlzrXb5E2WbsmvdRcTzLNjrAxH4bsGD/xF8F3WCTFGhn/FqZFnR2ljmNG6mP1Cls+x9cInhnLYrH2bsAkd53ry4uoWIHPUZHdWTH0KwGDuGXIhEQfZFIa9iPG8ztvpI6VL4x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdQ5cohC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdQ5cohC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763504102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RcMergSwauY/1NAWI0QqhSLEWf4nuFMROFc+j9jdmGk=;
	b=EdQ5cohCsb9dXlWB22B+/1hTfrXXtWo32gA8SqprM7suq6EzslunEdZAoi/KZZ6mJ7z9mG
	ivnexE2QOWtFmrVpXsY1zilFoQM6gXiY2ALCVn5as3u8belrGlEJRcU0pTNCzNFWiPMQnY
	M+iGc11LGrKrQxz01S4NB+V6m33GscU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-NQ9uV7RiMeSlyKv-Q3I0vQ-1; Tue, 18 Nov 2025 17:14:59 -0500
X-MC-Unique: NQ9uV7RiMeSlyKv-Q3I0vQ-1
X-Mimecast-MFC-AGG-ID: NQ9uV7RiMeSlyKv-Q3I0vQ_1763504099
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429cce847c4so2656939f8f.2
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 14:14:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763504099; x=1764108899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcMergSwauY/1NAWI0QqhSLEWf4nuFMROFc+j9jdmGk=;
        b=dugxDpGF9SNSSJ735JDElpt/nL0Seh6Vooya7gte0UXBHCQZ6cbknEMhyVjt5xZL6/
         +4+B8nbEduxUXwb+SSngaq6sLk55f9EXr7x8gYmLqAoCt0W2eJF6S1JjTj369xpHehFZ
         k7jgsWpRzm2NG5HxHqH0bej6kwXPDiY4aj01uTjTPhcXDvUbcmnDZR99lpcyqYUlNzRO
         5DTr2VRVvNn+PNOIrIOzgmINHsw94wqJnYsPxrLpH3n8Pf5FpYmRYer8dU8fxWgM1jpu
         5YOJgahn8FUH9Im3NEzm5X6D3f0e+RzjF/y6x1oHweFIamLDwilpO7nDDMw3QrAwpiAT
         2rng==
X-Forwarded-Encrypted: i=1; AJvYcCXeSHlB6qOj0JlBJxIM1fUMrbufxp4oS8G3OlX1Vc6Z/cu+kdnTNWqOKTQwuwmAdnXpC6fzyNipcF7BgYK5qg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxa1R0No0/R2y9JInD5ILHp4sLXa4IAfBGFp8GwJgytL02G9BzE
	uRvSJdj9EkHBNkN7CfPRwP+0OdrfjgSyOepwGe4YQjBVvK5AMGsYVULQ9qWZgO45yMDY6O7i4IU
	PYUVmqyXwd+tdMLxQaJpzMcdX2QF3ljc31UlDfTzgXkFCaI2xD1/AB4itKRfmJqicj/zM
X-Gm-Gg: ASbGncuoVgsTENVYpY1P14bng4tTWQ1X9TsCsTCvNUU5pNeRYfeDPmF4CySC1B4fQ5V
	73Av5aacZfxibZu0bR4EszZfL+aPtQe/ezEFjlh7gxkL1K5CsPblc01z/1er083xlpee3ZrC/RW
	R4P+vkzZPnlGJxkdtyEckRrC5IRX6S2Fuk/xpQI8lDZ6oA6qQPGO57Ue41AYGrmDGjJp2QImlLg
	DKFa5RFf3MY+IpdkxlZyHDD+w1smhO32vzCN5asLWt1feLmlPIQs6koirIcRZKquOwSXI1h667u
	Aicg4Cv/4IFXwMuz4GlCPaZCSeufyuC4Yk3UkpwJoMhu+PUX3kib0J168+cz7sD4dzoJ/WnlfEU
	57z4NbDmkAxFtt1PGuhPfxfcMKasNbg==
X-Received: by 2002:a05:6000:1786:b0:429:bc93:9d8a with SMTP id ffacd0b85a97d-42b59367879mr15687624f8f.37.1763504098572;
        Tue, 18 Nov 2025 14:14:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaQTHDLRGB+J4QEWont+WA6Rkw3ObVf6Z/E2y14Jl425BejksKFCL7rq5yLCNgi3wMzN8cog==
X-Received: by 2002:a05:6000:1786:b0:429:bc93:9d8a with SMTP id ffacd0b85a97d-42b59367879mr15687613f8f.37.1763504098103;
        Tue, 18 Nov 2025 14:14:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae98sm33856532f8f.2.2025.11.18.14.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:14:57 -0800 (PST)
Date: Tue, 18 Nov 2025 17:14:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 04/12] virtio: Expose object create and
 destroy API
Message-ID: <20251118171338-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-5-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-5-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KXJAk994TMO8aBvsjDrrR99rqHpD0LypkxIfMY_5208_1763504099
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:38:54AM -0600, Daniel Jurgens wrote:
> Object create and destroy were implemented specifically for dev parts
> device objects. Create general purpose APIs for use by upper layer
> drivers.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> ---
> v4: Moved this logic from virtio_pci_modern to new file
>     virtio_admin_commands.
> v5: Added missing params, and synced names in comments (Alok Tiwari)
> ---
>  drivers/virtio/virtio_admin_commands.c | 75 ++++++++++++++++++++++++++
>  include/linux/virtio_admin.h           | 44 +++++++++++++++
>  2 files changed, 119 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
> index 94751d16b3c4..2b80548ba3bc 100644
> --- a/drivers/virtio/virtio_admin_commands.c
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -88,3 +88,78 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
> +
> +int virtio_admin_obj_create(struct virtio_device *vdev,
> +			    u16 obj_type,
> +			    u32 obj_id,
> +			    u16 group_type,
> +			    u64 group_member_id,
> +			    const void *obj_specific_data,
> +			    size_t obj_specific_data_size)
> +{
> +	size_t data_size = sizeof(struct virtio_admin_cmd_resource_obj_create_data);
> +	struct virtio_admin_cmd_resource_obj_create_data *obj_create_data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	void *data;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	data_size += obj_specific_data_size;
> +	data = kzalloc(data_size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	obj_create_data = data;
> +	obj_create_data->hdr.type = cpu_to_le16(obj_type);
> +	obj_create_data->hdr.id = cpu_to_le32(obj_id);
> +	memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
> +	       obj_specific_data_size);
> +	sg_init_one(&data_sg, data, data_size);
> +
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
> +	cmd.group_type = cpu_to_le16(group_type);
> +	cmd.group_member_id = cpu_to_le64(group_member_id);
> +	cmd.data_sg = &data_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_obj_create);
> +
> +int virtio_admin_obj_destroy(struct virtio_device *vdev,
> +			     u16 obj_type,
> +			     u32 obj_id,
> +			     u16 group_type,
> +			     u64 group_member_id)

what's the point of making it int when none of the callers
check the return type?

> +{
> +	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
> +	struct virtio_admin_cmd cmd = {};
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
> +	data->type = cpu_to_le16(obj_type);
> +	data->id = cpu_to_le32(obj_id);
> +	sg_init_one(&data_sg, data, sizeof(*data));
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_DESTROY);
> +	cmd.group_type = cpu_to_le16(group_type);
> +	cmd.group_member_id = cpu_to_le64(group_member_id);
> +	cmd.data_sg = &data_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> index 36df97b6487a..039b996f73ec 100644
> --- a/include/linux/virtio_admin.h
> +++ b/include/linux/virtio_admin.h
> @@ -77,4 +77,48 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
>  			 const void *caps,
>  			 size_t cap_size);
>  
> +/**
> + * virtio_admin_obj_create - Create an object on a virtio device
> + * @vdev: the virtio device
> + * @obj_type: type of object to create
> + * @obj_id: ID for the new object
> + * @group_type: administrative group type for the operation
> + * @group_member_id: member identifier within the administrative group
> + * @obj_specific_data: object-specific data for creation
> + * @obj_specific_data_size: size of the object-specific data in bytes
> + *
> + * Creates a new object on the virtio device with the specified type and ID.
> + * The object may require object-specific data for proper initialization.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or object creation, or a negative error code on other failures.
> + */
> +int virtio_admin_obj_create(struct virtio_device *vdev,
> +			    u16 obj_type,
> +			    u32 obj_id,
> +			    u16 group_type,
> +			    u64 group_member_id,
> +			    const void *obj_specific_data,
> +			    size_t obj_specific_data_size);
> +
> +/**
> + * virtio_admin_obj_destroy - Destroy an object on a virtio device
> + * @vdev: the virtio device
> + * @obj_type: type of object to destroy
> + * @obj_id: ID of the object to destroy
> + * @group_type: administrative group type for the operation
> + * @group_member_id: member identifier within the administrative group
> + *
> + * Destroys an existing object on the virtio device with the specified type
> + * and ID.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or object destruction, or a negative error code on other failures.
> + */
> +int virtio_admin_obj_destroy(struct virtio_device *vdev,
> +			     u16 obj_type,
> +			     u32 obj_id,
> +			     u16 group_type,
> +			     u64 group_member_id);
> +
>  #endif /* _LINUX_VIRTIO_ADMIN_H */
> -- 
> 2.50.1

