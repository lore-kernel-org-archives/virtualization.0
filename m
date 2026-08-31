Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58A3D1716
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166062; cv=none; b=AlbfWLzbBn3AJGBKcTjALMEI4JKFekH8X5wa7+/sovWT2AAtY9jQjPDc3DYBZPF3ezvNCBiGc6Pj+hRABuipHqSPenKFtuHKjpi4u7At5fyrYbEJuY+p26Za0auP9h+ua88XQL4F2xJ6ajOXQFq+XV1p0jpUOKmbrMfD3EFuxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166062; c=relaxed/simple;
	bh=qO/mY1lfUtaDHpwskTKeYLSEyKzXr8YSSWgWVeTZH+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iOCiSCxJtrZKmEA52foMKNZHGPYzn2buAjpamIgNDJKR5LVCHTxf+1CWy6GAJpL/3WhXXjgAzT/1CNx4keCYnyvA7bnOhRQF8EpYQOAExBWQFgQv7n+1w1FQBu7cOMoS8q4sjoZBaKh6pPcq2hN+t7xN++Wxo1u2SD65fOn6uRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ps7e/qn7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ps7e/qn7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788166059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REKs3juXaUqDY91aw9czwxYsepaMH/aWl6qmQKLk4PU=;
	b=Ps7e/qn7eAbdKGXDslLcRoGDbe9lnjVutGXk+re6UKSF+o/LrRBWVG3TgDFhCidZA+XSil
	HRlZ4Bag4pCOUpk+IP4ugxFA+71iXI55eDFshAGAtnsmsqAouEDfJCHffcXRg84ZQdvmBp
	HFgtzeJRR2MmPQ8Bk8/wjkOJWG/pt9A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-15AiA5qgNwic3shGZIhV3A-1; Mon, 31 Aug 2026 04:47:38 -0400
X-MC-Unique: 15AiA5qgNwic3shGZIhV3A-1
X-Mimecast-MFC-AGG-ID: 15AiA5qgNwic3shGZIhV3A_1788166057
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49ccfbe060aso12313245e9.0
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 01:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788166057; x=1788770857;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REKs3juXaUqDY91aw9czwxYsepaMH/aWl6qmQKLk4PU=;
        b=qhFFulj2jDqxIsgpbvakxyAT/yr6/AabCOWd9bPFik75B4pogPIrDPzIEN59K4MUro
         nk4h0qFwdLLPF/dhwM022rBiahsrIDvLnET+ub75j0hMxPX/Gyqc4L+ne+xiG8uVecdI
         2jiBdrYss22gq5R5EeSnhs3KGhfptMiHEZ1RrwQI08g57Ywi3npJOpd1Uz7Q80BITNwX
         p8HOZIYjeObBXPhFYDprdWWuUr70mq8ENhmLinEIt3gXBUpcabwCb7HzHY6RLaGRmqlU
         01NdrtUcEsJdlcNtMoXgp9V7GqHEMQEiAprS4TbBSbVe9Ces38I7vpjmWISFXXAIwHT9
         WH2A==
X-Forwarded-Encrypted: i=1; AHgh+RoKuFhSpoqniLT+UhEHEg+OG6GAnKqNdQbmgLtB0BW/ActyTsofFvJaNKnvg0Q9K5JTa/kz67ob/dAJTAOoQA==@lists.linux.dev
X-Gm-Message-State: AFuF++lGLg323dvWHx2KFEaVt1R+ctWYlO+OBXh/RHI5WHkoiaXloAmJ
	l/cz7e/AAmxX/+KDoxWAeijV1yXmhfx0WF+x3AnG7Dz47mJy6NzThA/fmYQrlKGqdRQwbv1h+Lj
	AHyCFtKAOkoTm6+/uZfxN0OfLE2LDLavCxeAILPbWtxjyNsus63PcZLFbG1EZDXvbPFMjRDuWID
	k5
X-Gm-Gg: AR+sD11KRa00XVk7dqg7oebC0pjrPXA6c8V/lfVCZFSXTr+ofajckpJISd6s5V5n+HN
	9vIlJCnI0ditODFw1clkF6juktPQBDzXUZ9Mlv1w2R1u6TjxZsATFivZVMRbk9c35KZ6Wg865yt
	//3pslKTQUXjU3H+MhOKqI7yc9VMsP4GzGVhebDK//sX8V3HEucdLXmzMjVeRdS2MRgy6daCCHd
	8IbK74Ba+80ORiox8HJ1hYT6g9vEtqSC6rF4eV6IuTRQWLqc54eZRvzHyEG2Fjk2Hl3xeevTduf
	/KX3SPsMNFC/89I1cr7jx5h4SrY9DGW5KADsr3FBjou8LW0uPiVroCQmAqJ39NK+ZveSBy3UR9W
	cbjmlQX0RBWM/DdgMZ2CZ/xk=
X-Received: by 2002:a05:600c:1d08:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49b91c2e145mr368385105e9.1.1788166057125;
        Mon, 31 Aug 2026 01:47:37 -0700 (PDT)
X-Received: by 2002:a05:600c:1d08:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49b91c2e145mr368384105e9.1.1788166056589;
        Mon, 31 Aug 2026 01:47:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4843310ab29sm13646829f8f.0.2026.08.31.01.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 01:47:36 -0700 (PDT)
Date: Mon, 31 Aug 2026 04:47:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v22 05/14] virtio: Expose object create and
 destroy API
Message-ID: <20260831044442-mutt-send-email-mst@kernel.org>
References: <20260831075807.2891426-1-shshitrit@nvidia.com>
 <20260831075807.2891426-6-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260831075807.2891426-6-shshitrit@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QzpTwC-YhEo9xs3JUKRoyLkrt_41X3gWvEtWsGgzkLQ_1788166057
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 31, 2026 at 10:57:58AM +0300, Shahar Shitrit wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> Object create and destroy were implemented specifically for dev parts
> device objects. Create general purpose APIs for use by upper layer
> drivers.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/virtio/virtio_admin_commands.c | 77 ++++++++++++++++++++++++++
>  include/linux/virtio_admin.h           | 41 ++++++++++++++
>  2 files changed, 118 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
> index 60d92875da23..08b41f38baea 100644
> --- a/drivers/virtio/virtio_admin_commands.c
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -94,3 +94,80 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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
> +	if (check_add_overflow(data_size, obj_specific_data_size, &data_size))
> +		return -EOVERFLOW;
> +
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
> +void virtio_admin_obj_destroy(struct virtio_device *vdev,
> +			      u16 obj_type,
> +			      u32 obj_id,
> +			      u16 group_type,
> +			      u64 group_member_id)
> +{
> +	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return;
> +
> +	data = kzalloc_obj(*data);
> +	if (WARN_ON(!data))
> +		return;
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
> +	WARN_ON_ONCE(err);

Maybe pass err and let the caller do it? Some callers can't handle an error but
others (ethtool delete) actually could propagate it to userspace.

> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> index 1177c4a20e53..9095a0481495 100644
> --- a/include/linux/virtio_admin.h
> +++ b/include/linux/virtio_admin.h
> @@ -86,4 +86,45 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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
> + */
> +void virtio_admin_obj_destroy(struct virtio_device *vdev,
> +			      u16 obj_type,
> +			      u32 obj_id,
> +			      u16 group_type,
> +			      u64 group_member_id);
> +
>  #endif /* _LINUX_VIRTIO_ADMIN_H */
> -- 
> 2.49.0

