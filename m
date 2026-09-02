Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FB4756D8;
	Wed,  2 Sep 2026 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354745; cv=none; b=sxlbhf7vE4qI0vu4SCcBBcEG87NcLJDAkcNroRwk4Zd4q/aoXIUnHTFtHIq8YnKBnKkHWImpM1Uo7F20Z3y+KLRkYJXnBtrtGRAgi/8xKSYi17ymvBdPxbvNKD+MC3RrSj1Uxp6tVp7ZekAshKUEte1yg0U4vx0JwHYb+C6Yhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354745; c=relaxed/simple;
	bh=GHDW5V87RElhfireO1RQ5Kl3P41kiSErCsjyy6sXuEc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rEO2YZdWr0vE7kqkpcQXyTwJe72fn94NktqKlEap+2+H2mLrk9veXLnrX4pWeHVM7gDUwlnIjn1P1SCs0O0YHYJu65u5fALsf9TuhjhN+9Rt0f+yvOd5A7F+C5ohB0DLO32A2uBZcgvoePveMw4qCE3fseNVS6cp7ljYn3wCcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEJ3UUIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEJ3UUIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0E11F00A3A;
	Wed,  2 Sep 2026 13:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354742;
	bh=jPrCT2pwRVJTNk8OU7KlxFUUZ3jAytKyZLGY54SfXAY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jEJ3UUIlZblyV6Oo8sq7d/9PllFAHPVgsPQpbxgxXMFAsAezTHJGV7zpgahi0js12
	 mDBNZxjn+1+G7dh4qlmIkkh6qaQA70OoB/wIX4cpytv0wotnh/8WgL33BeXWZMtRsE
	 KigUhNpEt1lBzf+hqySr/7cGhnVHjiZEVHWJcUMY6rN5HRpB5j9rXnVxebxMEw1EDf
	 1PQtxv60pUvmeuJKT9dZ+Sdssx3CfbyGBGuLqFosh+Iw91/owzaa0grfDhM3yf7RSC
	 meB9tH5/xthoLuV/7fDAw/bgwgFDJFmAFCQDwPJJDQlCsVO1Ro8Y9hyp63MCNKIBMJ
	 qP/9+8VCgAYog==
Subject: Re: [net-next,v23,05/14] virtio: Expose object create and destroy API
From: netdev-bot+sashiko@kernel.org
To: shshitrit@nvidia.com
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
Date: Wed, 02 Sep 2026 13:12:21 +0000
Message-ID: <178835474175.3394541.11178044243412643996@kernel.org>
In-Reply-To: <20260831161109.2999926-6-shshitrit@nvidia.com>
References: <20260831161109.2999926-6-shshitrit@nvidia.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 (1) · Low: 1

- [Low] virtio_admin_obj_create()/virtio_admin_obj_destroy()
  (drivers/virtio/virtio_admin_commands.c:98 and :142) forward a caller-…

Pre-existing issues:
- [Medium] Both new helpers kfree() the command payload (and let the
  stack-resident 'struct virtio_admin_cmd cmd' go out of scope)…

--

virtio: Expose object create and destroy API

This adds two exported helpers, virtio_admin_obj_create() and
virtio_admin_obj_destroy(), which build the resource object create/destroy
admin commands generically instead of only for dev parts objects.  The new
prototypes and kernel-doc go into include/linux/virtio_admin.h.

> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
> index 60d92875da233..24b06075d944f 100644
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

[ ... ]

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

[Severity: Medium]

This isn't a bug introduced by this patch, but is the unconditional
kfree(data) here safe for every return value of admin_cmd_exec()?

There is one path in virtqueue_exec_admin_cmd() where the descriptors have
already been published and the function returns without waiting and without
reclaiming them:

drivers/virtio/virtio_pci_modern.c:virtqueue_exec_admin_cmd() {
	...
	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
	if (ret < 0) {
		...
		goto unlock_err;
	}
	if (!virtqueue_kick(vq))
		goto unlock_err;
	mutex_unlock(&admin_vq->lock);

	wait_for_completion(&cmd->completion);

	return cmd->ret;

unlock_err:
	mutex_unlock(&admin_vq->lock);
	return -EIO;
}

On that -EIO return the buffer is still referenced by the virtqueue, and
virtio_admin_obj_create() then frees data and lets the stack-resident
struct virtio_admin_cmd cmd go out of scope.  The device-writable
va_status allocation in vp_modern_admin_cmd_exec() is freed on the same
error path:

drivers/virtio/virtio_pci_modern.c:vp_modern_admin_cmd_exec() {
	...
err_cmd_exec:
	kfree(va_hdr);
err_alloc:
	kfree(va_status);
	return ret;
}

In practice vp_notify() always returns true, so virtqueue_kick() can only
fail through the vq->broken check inside virtqueue_notify(), which returns
before notifying the device, and virtqueue_get_buf() returns NULL on a
broken vq, so vp_modern_avq_work() will not complete into the recycled
stack frame.  The same pattern exists at the baseline for
virtio_admin_cap_set(), virtio_pci_admin_mode_set() and
virtio_pci_admin_obj_create(); this patch adds two more callers of it.

Would the reclaim (a wait, or virtqueue_detach_unused_buf()) belong in
virtqueue_exec_admin_cmd() rather than in each caller?

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
> +{

[ ... ]

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

The kfree(data) note above applies here in virtio_admin_obj_destroy() as
well.

> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> index 1177c4a20e53c..ebd4106835d68 100644
> --- a/include/linux/virtio_admin.h
> +++ b/include/linux/virtio_admin.h
> @@ -86,4 +86,48 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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

[Severity: Low]

This isn't a bug, but could the kernel-doc for virtio_admin_obj_create()
and virtio_admin_obj_destroy() say who owns the obj_id space?

The pre-existing dev parts helper keeps the id space in the core:

drivers/virtio/virtio_pci_modern.c:virtio_pci_admin_obj_create() {
	...
	id = ida_alloc_range(&avq->dev_parts_ida, 0,
			     avq->max_dev_parts_objects - 1, GFP_KERNEL);
	...
}

and it still rejects any obj_type other than VIRTIO_RESOURCE_OBJ_DEV_PARTS,
so nothing in tree can currently desync that IDA through the new generic
API.  The generic helpers, though, forward obj_type/obj_id/group_type/
group_member_id straight to the device with no statement that the caller
owns the id space for a given (group_type, group_member_id, obj_type)
tuple, and no equivalent of the "caller must serialize" note carried by the
dev parts helpers.

Would adding that contract to the kernel-doc make the expectations for new
callers clearer?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831161109.2999926-1-shshitrit%40nvidia.com
