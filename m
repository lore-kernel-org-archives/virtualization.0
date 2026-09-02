Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60749C4B5;
	Wed,  2 Sep 2026 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354741; cv=none; b=Jde+x2EPHlU1+Wgpa73eNG9mfgMf9OiVGUZg344nkRNq1Pq0a1PHK93OACxM8E4WazE0ax4PT6NoKhrXrsa8VHaKpMvoG0sh+6USEI+SFCtBa24f27CXi6sugybkuZpUYWpsA3XnjkL2gka28lM7KL4nVL0Ehu91bUuGHAGWBnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354741; c=relaxed/simple;
	bh=Xs28MClqFi99I3A+CFt6Z82k8ONFQwIihT+vRxCKmC4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MPVEg5WnXe2uVuVc7lYhIV084l1ZRAAANMSLj/TYBnvFOsboHTy+WZPBTuNhZ7zjifY4moKWmg95725prNXjyX19gQMxpOOueq1KMx3RrR6v0Ji7yYMoHq8aMEPby99qEkaFTcgPZ0dE3FY+sw7qr3U3YKMxWON2YYwTbyxBzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmGPLk50; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmGPLk50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277E11F00A3A;
	Wed,  2 Sep 2026 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354740;
	bh=Hq06Fk3wWuBUKOABUalTO+BrIg/zsFEo4RDO2ijSNv0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cmGPLk50vpeDnGAydAFkcfnITWty+AbZZdodVF+VuEUIoST/GZDUc0piUI+GH6sUA
	 Mv+KE4z6QQ1immv+x2GnL+2ajYtdV6s5bjC8Enryti3oGirNrEYExqRpAmx4HFPD8S
	 mXMmySH7M/IAIB6QTtzrUY9owiSl59+nFOLrYdd0DAWwY2xYVDxCadRUJOACoQE6MV
	 mmmni96ekJtLZq7VAEnamOwmicUHmxSI1WOeFgqn0X61L53vxCyTBT7adtz4TquhVO
	 jTu4yRJ9FmdzxrDzHCz8yg/2ez8xWM49xIF1q/DSUC/aQIXmqiVcytgzdiMyfYjLj1
	 q0gzHukzu5zcQ==
Subject: Re: [net-next,v23,03/14] virtio: Add config_op for admin commands
From: netdev-bot+sashiko@kernel.org
To: shshitrit@nvidia.com
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
Date: Wed, 02 Sep 2026 13:12:18 +0000
Message-ID: <178835473869.3394541.13020013369139989380@kernel.org>
In-Reply-To: <20260831161109.2999926-4-shshitrit@nvidia.com>
References: <20260831161109.2999926-4-shshitrit@nvidia.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 (3) · Medium: 1 · Low: 1

- [Medium] The newly published `->admin_cmd_exec` transport op has no
  lifecycle precondition check or documentation:…
- [Low] The kernel-doc added for `@admin_cmd_exec` in
  include/linux/virtio_config.h states no calling-context constraint,…

Pre-existing issues:
- [High] Free-while-in-flight / use-after-free on the admin-command kick-
  failure path.
- [High] The admin-command path accesses `admin_vq->info` with no
  synchronization against admin-queue teardown, and the newly published…
- [High] `struct virtio_admin_cmd::result_sg_size`, now part of the
  generic `->admin_cmd_exec` contract, is filled in…

--

virtio: Add config_op for admin commands

This adds a new optional admin_cmd_exec callback to struct
virtio_config_ops and points it at vp_modern_admin_cmd_exec() in both
modern virtio-pci config op tables, so that virtio device drivers can
issue admin commands through the transport.

No Link: tags in the commit header.

A few questions about the newly published op below.

> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index dab63b044a312..3b2515e29728a 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -1248,6 +1248,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
>  };

[Severity: Medium]
Now that any bound driver can reach this path, is there anything that keeps
admin_vq.info valid at the entry point?  virtqueue_exec_admin_cmd() starts
with:

	vq = admin_vq->info->vq;
	if (!vq)
		return -EIO;

The guard tests the inner vq pointer, so it does not catch info == NULL.
The only precondition tested by vp_modern_admin_cmd_exec() is:

	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
		return -EOPNOTSUPP;

That feature bit is set by vp_finalize_features() before the driver's probe
runs and it stays set across del_vqs(), while vp_del_vq() in
virtio_pci_common.c does:

	if (vp_is_avq(vq->vdev, vq->index)) {
		cancel_work_sync(&vp_dev->admin_vq.work);
		vp_dev->admin_vq.info = NULL;
	}

	vp_dev->del_vq(info);
	kfree(info);

So admin_vq.info is NULL before find_vqs() creates the admin queue, on the
find_vqs() error path, and after del_vqs().  Can a call made outside the
find_vqs()..del_vqs() window dereference NULL here?

The virtio_net consumers added later in this series do appear to stay inside
that window, so this may not be reachable in-tree today.  Would it still be
worth checking admin_vq->info and spelling out the required device/VQ state
in the new kernel-doc?

[Severity: High]
This isn't a bug introduced by this patch, but the kick-failure path in
virtqueue_exec_admin_cmd() looks like it leaves a descriptor in flight:

	mutex_lock(&admin_vq->lock);
	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
	...
	if (!virtqueue_kick(vq))
		goto unlock_err;
	...
unlock_err:
	mutex_unlock(&admin_vq->lock);
	return -EIO;

virtqueue_kick() returns false when the vring is broken, and
virtio_break_device() can be called asynchronously, for example from
virtio_pci_remove():

	if (!pci_device_is_present(pci_dev))
		virtio_break_device(&vp_dev->vdev);

so the state can change between the virtqueue_is_broken() pre-check and the
kick.  The descriptor added by virtqueue_add_sgs() is not reclaimed on that
path, and vp_modern_admin_cmd_exec() then frees the buffers it published:

err_cmd_exec:
	kfree(va_hdr);
err_alloc:
	kfree(va_status);
	return ret;

The token handed to virtqueue_add_sgs() is the caller's struct
virtio_admin_cmd, which goes out of scope when the caller returns.  When the
following reset runs vp_modern_avq_cleanup():

	while ((cmd = virtqueue_detach_unused_buf(vq))) {
		cmd->ret = -EIO;
		complete(&cmd->completion);
	}

does this write through a stale token belonging to another task's stack
frame, and can the device still DMA into the freed, device-writable
va_status?  Should the error path detach the descriptor (or defer the frees)
before this op is exposed to more drivers?

[Severity: High]
This is a pre-existing issue, but the admin queue accesses do not share a
lock with admin queue teardown, and this patch widens the set of contexts
that can submit commands without adding a serialization rule.

Reader side, with no lock held:

virtio_pci_modern.c:virtqueue_exec_admin_cmd() {
	vq = admin_vq->info->vq;
	if (!vq)
		return -EIO;
}

virtio_pci_modern.c:vp_modern_avq_cleanup() {
	vq = vp_dev->admin_vq.info->vq;
	if (!vq)
		return;

	while ((cmd = virtqueue_detach_unused_buf(vq))) {
}

vp_modern_avq_work() also reads admin_vq->info->vq before taking the mutex.

Writer side, holding only vp_dev->lock for the list removal:

virtio_pci_common.c:vp_del_vq() {
	if (vp_is_avq(vq->vdev, vq->index)) {
		cancel_work_sync(&vp_dev->admin_vq.work);
		vp_dev->admin_vq.info = NULL;
	}

	vp_dev->del_vq(info);
	kfree(info);
}

Since admin_vq->lock is not held by the cleanup or the teardown, can a
command submitted from an unrelated driver context concurrently with
del_vqs() or reset dereference NULL or the freed struct
virtio_pci_vq_info, and then operate on a destroyed vring?

The concrete unsynchronized submitter today is the existing
virtio_pci_admin_* path used by virtio-vfio-pci, which reaches a PF admin
queue while the PF's virtio driver can be unbound independently.  Should the
new kernel-doc carry an analogue of the @reset rule about not running in
parallel with virtqueues being added or removed?

> 
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -1268,6 +1269,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
>  };
>  
>  /* the PCI probing function */
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 69f84ea85d71a..e36a32e0a20c8 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -108,6 +108,10 @@ struct virtqueue_info {
>   *	Returns 0 on success or error status
>   *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
>   *	set.
> + * @admin_cmd_exec: Execute an admin VQ command (optional).
> + *	vdev: the virtio_device
> + *	cmd: the command to execute
> + *	Returns 0 on success or error status

[Severity: Low]
Could this kernel-doc also state the calling context?  The implementation
sleeps in several places: two kzalloc_obj() GFP_KERNEL allocations in
vp_modern_admin_cmd_exec(), and in virtqueue_exec_admin_cmd():

	mutex_lock(&admin_vq->lock);
	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
	...
	wait_for_completion(&cmd->completion);

The wait has no timeout and is only woken by vp_modern_avq_work() or by
vp_modern_avq_cleanup() on reset.

The header of this struct is otherwise explicit about context, for example
that @get/@set, @get_status/@set_status and @get_features/@finalize_features
are not safe from atomic context, and that a device must not be reset from
its vq or config callbacks.

No in-tree caller violates this today.  Would it help to note that
admin_cmd_exec may sleep, must be called from process context, and can block
until the device completes the command or the device is reset?

[Severity: High]
This is a pre-existing issue, but the cmd->result_sg_size field that this
contract now exposes to arbitrary drivers is filled straight from the
device-written used ring length.  In vp_modern_avq_work():

		while ((cmd = virtqueue_get_buf(vq, &len))) {
			if (len < status_size)
				cmd->result_sg_size = 0;
			else
				cmd->result_sg_size = len - status_size;

virtio_ring does not clamp that length against the posted buffer; in
virtqueue_get_buf_ctx_split() and virtqueue_get_buf_ctx_packed() only the
descriptor id is range-checked while the length is taken verbatim:

	*len = vring_read_split_used_len(vq, last_used);

Is result_sg_size therefore fully device-controlled and able to exceed the
caller's result scatterlist?  The existing consumer already trusts it:
virtio_pci_admin_dev_parts_get() does *res_size = cmd.result_sg_size; and
drivers/vfio/pci/virtio/migrate.c does buf->length = res_size; for a buffer
whose real size is ctx_size, which the migration file then reads from.

Should the transport clamp result_sg_size to the total length of the
caller's result_sg before completing the command, and should the new
kernel-doc say that this field is untrusted device input?

>   */
>  struct virtio_config_ops {
>  	void (*get)(struct virtio_device *vdev, unsigned offset,
> @@ -137,6 +141,8 @@ struct virtio_config_ops {
>  			       struct virtio_shm_region *region, u8 id);
>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
>  	int (*enable_vq_after_reset)(struct virtqueue *vq);
> +	int (*admin_cmd_exec)(struct virtio_device *vdev,
> +			      struct virtio_admin_cmd *cmd);
>  };

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831161109.2999926-1-shshitrit%40nvidia.com
