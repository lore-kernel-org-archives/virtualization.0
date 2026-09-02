Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AB48C8AF;
	Wed,  2 Sep 2026 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354743; cv=none; b=Y2OnG7IP/TV2tSDXd/scK9Sl3RMNsQsGx0vSiX9kcWKmfMv1tT5UcXVKOawulZ6HQ5vZpctQn3nBTkIOZn/CmNlwgg4oQVSpqIxxdpej+TnHeiAXsox7wenUTCPcL/MdacoycHvz0aRlpyzL4F0sbz+0jyrqx0+7NvlnDC2RdhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354743; c=relaxed/simple;
	bh=DYmGcTX0rJP6LEkypKZo8HhSFACgpoTr1sZsK/m2ZiY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U0Q2Dwc+aIWb/xZhoswiiPBaQ8A7W5Z47zJkDPwxR2KtX8bbldLnEN4XJrOn/8WzD5GUR5pSduC6kJ6pul8yAfi7rPAlmOy3YNsVqgFtCCbbz4VFTf6xiRWBcN+YgOdYpEXkeJMuhvt9FQGjqclTunJi1R1M3r5yMmhV0A0tQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X66p4WUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X66p4WUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17C61F000E9;
	Wed,  2 Sep 2026 13:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354741;
	bh=s0QrXGekSeK3fNQa/HR1NjljTQDm/Dmb7VoeAU3WYHE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X66p4WUJ+C6vNShDzzsz6x70F+sNdToMZpIVyx6eEoTpVRh2c5XB3tgogZ1nx1bk+
	 Y46S3+djnzmovqtY3yLJcXMxILvr214PzJRbNppBKzPk3BLaMctKnMIpNO7Mrw5E8t
	 73qCTBu4zZJQapL2Lj0htNmepJKrBy8RyGPXThecV24FPyJwyeLcdtKpam1nUKvNXc
	 4R68iRzOaGJL3wmAlSoLLk/w8pfzuw1agigLhCtYVXaNwSnMlX/K/p6tJo7O9CBQHQ
	 /xVyY3yLNpMMsZRh+QW4SH2TZNR3iCGmJlDrd4gHJbO5DqLlVxhve8psnaat1umjsd
	 V6wMPqLxq0wyA==
Subject:
 Re: [net-next,v23,04/14] virtio: Expose generic device capability operations
From: netdev-bot+sashiko@kernel.org
To: shshitrit@nvidia.com
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
Date: Wed, 02 Sep 2026 13:12:20 +0000
Message-ID: <178835474020.3394541.12547777604274559228@kernel.org>
In-Reply-To: <20260831161109.2999926-5-shshitrit@nvidia.com>
References: <20260831161109.2999926-5-shshitrit@nvidia.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 3 · Low: 3

- [Medium] virtio_admin_cap_id_list_query() and virtio_admin_cap_get()
  expose a caller-owned buffer to the device as a DMA-writable result…
- [Medium] virtio_cap_in_list() (include/linux/virtio_admin.h:27-33)
  guards the array index with BUILD_BUG_ON(cap > VIRTIO_ADMIN_MAX_CAP)…
- [Medium] drivers/virtio/Makefile adds virtio_admin_commands.o directly
  to obj-$(CONFIG_VIRTIO), which makes it an independent module…
- [Low] The patch removes the macro MAX_CAP_ID from the installed uapi
  header include/uapi/linux/virtio_pci.h and replaces it with…
- [Low] The kernel-doc for virtio_admin_cap_set() states '@caps: Pointer
  to capability data structure (must be heap allocated)', but the…
- [Low] The new exported wrappers only check that
  vdev->config->admin_cmd_exec is non-NULL before issuing an admin…

Pre-existing issues:
- [High] In virtqueue_exec_admin_cmd()
  (drivers/virtio/virtio_pci_modern.c:119-129), if virtqueue_kick()…

--

virtio: Expose generic device capability operations

This adds a new virtio_admin_commands.c with exported helpers to query the
capability id list and to get/set individual capabilities, plus a new
include/linux/virtio_admin.h.  It also grows
struct virtio_admin_cmd_query_cap_id_result from 8 to 512 bytes and renames
MAX_CAP_ID.

A few questions below.

> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index eefcfe90d6b8b..2b4a204dde331 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
> +obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_admin_commands.o

[Severity: Medium]
Does this build with CONFIG_VIRTIO=m?  Adding virtio_admin_commands.o
directly to obj-$(CONFIG_VIRTIO) with no matching <name>-y makes it its own
module, and the new drivers/virtio/virtio_admin_commands.c has no
MODULE_LICENSE() (nor MODULE_DESCRIPTION()).

The sibling objects each carry their own license, which is what makes them
separate modules:

  drivers/virtio/virtio.c:      MODULE_LICENSE("GPL");
  drivers/virtio/virtio_ring.c: MODULE_LICENSE("GPL");

and modpost treats the missing license as an error rather than a warning:

  scripts/mod/modpost.c:check_modinfo() {
      license = get_modinfo(&info, "license");
      if (!license)
          mod_error(mod, "missing MODULE_LICENSE()\n");
  }

Was the intent to fold the file into the virtio module instead, e.g.
virtio-y := virtio.o virtio_admin_commands.o?  I did not find a later patch
in the series that adds the module metadata or changes this line.

>  obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
>  obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
>  obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
> new file mode 100644
> index 0000000000000..60d92875da233
> --- /dev/null
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_admin.h>
> +#include <linux/overflow.h>
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

[Severity: Medium]
The commit message says "Since the API does not report how much of the
result was written, callers must zero-initialize the structure before use."
The transport does know that length though:

  drivers/virtio/virtio_pci_modern.c:vp_modern_avq_work() {
      ...
      if (len < status_size)
          cmd->result_sg_size = 0;
      else
          cmd->result_sg_size = len - status_size;
      complete(&cmd->completion);
  }

Since cmd lives on the stack here, result_sg_size is discarded.  Would it be
better for these helpers, which are the only place that knows both the buffer
and its size, to memset() the result buffer themselves or to return the
written length, rather than making it a caller contract?

Related: on an error return from admin_cmd_exec() the result buffer may
already be partially DMA-written, so a caller that zeroed once cannot safely
reuse the same buffer for a retry.  Is that expectation documented anywhere?

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
> +	data = kzalloc_obj(*data);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->id = cpu_to_le16(id);
> +	sg_init_one(&data_sg, data, sizeof(*data));
> +	sg_init_one(&result_sg, caps, cap_size);

[Severity: Medium]
Same partial-write question for virtio_admin_cap_get(): a device that writes
only a prefix of cap_size leaves the tail of the caller's buffer untouched
and this returns 0.  The kernel-doc for virtio_admin_cap_id_list_query() says
"(must be zero-initialized and heap allocated)" but the kernel-doc for
virtio_admin_cap_get() only says "(must be heap allocated)".  Should the
zero-initialization requirement be stated for both, given they share the same
hazard?

> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
> +	cmd.data_sg = &data_sg;
> +	cmd.result_sg = &result_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);

[Severity: High]
This isn't a bug introduced by this patch, but the transport error path this
new exported API now feeds looks like it can leave the virtqueue holding
&cmd and the just-kfree()d buffers.

In virtqueue_exec_admin_cmd(), if virtqueue_kick() fails after
virtqueue_add_sgs() already succeeded, it neither waits for the completion
nor detaches the buffer:

  drivers/virtio/virtio_pci_modern.c:virtqueue_exec_admin_cmd() {
      ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
      ...
      if (!virtqueue_kick(vq))
              goto unlock_err;
      ...
  unlock_err:
      mutex_unlock(&admin_vq->lock);
      return -EIO;
  }

virtqueue_kick() can return false after the descriptor was added, since
virtqueue_notify() bails on a broken vq:

  drivers/virtio/virtio_ring.c:virtqueue_notify() {
      if (unlikely(vq->broken))
              return false;

and virtio_break_device() is called on surprise removal in
virtio_pci_remove(), i.e. after the virtqueue_is_broken() pre-check in
virtqueue_exec_admin_cmd().

On that return the helper here does kfree(data) and cmd goes out of scope,
while the queue still references both.  Later:

  drivers/virtio/virtio_pci_modern.c:vp_modern_avq_cleanup() {
      while ((cmd = virtqueue_detach_unused_buf(vq))) {
              cmd->ret = -EIO;
              complete(&cmd->completion);

writes through the stale token into a dead stack frame, and the device may
still DMA into the freed data buffer.  All existing callers use the same
stack-cmd pattern, so this is not new, but should the kick-failure path
detach the buffer before returning now that arbitrary virtio drivers can
reach it?

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

[ ... ]

> +	data->id = cpu_to_le16(id);
> +	memcpy(data->cap_specific_data, caps, cap_size);
> +	sg_init_one(&data_sg, data, data_size);

[Severity: Low]
This isn't a bug, but the kernel-doc for virtio_admin_cap_set() says
"@caps: Pointer to capability data structure (must be heap allocated)" while
the implementation copies caps into its own kzalloc()ed buffer and only
sg_init_one()s that private allocation.  The caller's buffer is never mapped
or retained, so a stack or static buffer works fine here.  Should the "must
be heap allocated" note be dropped for cap_set?

> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DRIVER_CAP_SET);

[ ... ]

> +EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> new file mode 100644
> index 0000000000000..1177c4a20e53c
> --- /dev/null
> +++ b/include/linux/virtio_admin.h
> @@ -0,0 +1,89 @@

[ ... ]

> +/**
> + * virtio_cap_in_list - Check if a capability is supported in the capability list
> + * @cap_list: Pointer to capability list structure containing supported_caps array
> + * @cap: Capability ID to check
> + *
> + * The cap_list contains a supported_caps array of little-endian 64-bit integers
> + * where each bit represents a capability. Bit 0 of the first element represents
> + * capability ID 0, bit 1 represents capability ID 1, and so on.
> + *
> + * Return: true if capability is supported, false otherwise
> + */
> +static inline bool virtio_cap_in_list(
> +	const struct virtio_admin_cmd_query_cap_id_result *cap_list, u16 cap)
> +{
> +	BUILD_BUG_ON(cap > VIRTIO_ADMIN_MAX_CAP);
> +	return !!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >>
> +		       (cap % 64)));
> +}

[Severity: Medium]
Is BUILD_BUG_ON() the right check here?  cap is a runtime u16 parameter, and

  include/linux/build_bug.h:
  #define BUILD_BUG_ON(condition) \
      BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)

is a compile-time assertion, so it puts no runtime bound on
supported_caps[cap / 64].  That array has VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE == 64
elements, so a cap in 0x1000..0xffff would index past the 512-byte struct.

The other direction is a build issue: for any caller where the compiler cannot
constant-fold cap, the __compiletime_assert() with __attribute__((error))
survives and the build fails with "call to __compiletime_assert_NN declared
with attribute error".

The kernel-doc advertises an unrestricted "@cap: Capability ID to check" with
no mention that only compile-time constants are accepted.  All callers in this
series pass literal macros (VIRTIO_NET_FF_RESOURCE_CAP and friends), so nothing
misbehaves today.  Would a plain runtime bounds check, or documenting the
constant-only requirement, be preferable?

> +
> +/**
> + * virtio_admin_cap_id_list_query - Query the list of available capability IDs
> + * @vdev: The virtio device to query
> + * @data: Pointer to result structure (must be zero-initialized and heap allocated)
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

[Severity: Low]
Would it help to add a "Context: process context, may sleep" line to the
kernel-doc of all three new helpers?  virtio_admin_cap_get() and
virtio_admin_cap_set() allocate with GFP_KERNEL, and
virtqueue_exec_admin_cmd() takes admin_vq->lock and blocks in
wait_for_completion(), but none of the new documentation states a context
requirement and there is no might_sleep().

The in-tree callers added later in the series run from probe and under
rtnl_lock() after init_vqs()/virtio_device_ready(), so they are fine; this is
just about the exported contract.

> +
> +/**
> + * virtio_admin_cap_get - Get capability data for a specific capability ID
> + * @vdev: The virtio device
> + * @id: Capability ID to retrieve
> + * @caps: Pointer to capability data structure (must be heap allocated)
> + * @cap_size: Size of the capability data structure

[ ... ]

> +#endif /* _LINUX_VIRTIO_ADMIN_H */
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index e732e3456e275..96d097d3757e4 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -315,15 +315,17 @@ struct virtio_admin_cmd_notify_info_result {

[ ... ]

> -#define MAX_CAP_ID __KERNEL_DIV_ROUND_UP(VIRTIO_DEV_PARTS_CAP + 1, 64)
> +#define VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE __KERNEL_DIV_ROUND_UP(VIRTIO_ADMIN_MAX_CAP + 1, 64)

[Severity: Low]
This drops MAX_CAP_ID from an installed uapi header.  Nothing in the tree
uses it outside this file, so no in-tree build breaks, but out-of-tree or
userspace code that sized or iterated supported_caps[] with it will no longer
compile.

The commit message reasons only about the struct size change:

  "This changes the size of virtio_admin_cmd_query_cap_id_result. It's safe
   to do because this data is written by DMA, so a newer controller can't
   overrun the size on an older kernel."

Could the macro removal be mentioned in the changelog too, or a
#define MAX_CAP_ID VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE alias kept?

>  struct virtio_admin_cmd_query_cap_id_result {
> -	__le64 supported_caps[MAX_CAP_ID];
> +	__le64 supported_caps[VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE];
>  };

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831161109.2999926-1-shshitrit%40nvidia.com
