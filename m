Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A214472F67;
	Wed,  2 Sep 2026 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354740; cv=none; b=tuoYLrwfTp7UkUPPC3izx3TJpq8eZRKeFyK/gh2QWGIfF72xt0BLGkUAmS7+mXDbsKyzedCIb2Ermd36Cl/vmbr26EFM62APzTgl0q9ZT1uafo2PAt512W34l56dacwNoaraOYIjRmXOIL9QHSlsww8bZKYJbOz7ZEEOWRbnqhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354740; c=relaxed/simple;
	bh=w9Qa72Zf6cock+kZxk0fH2VMkWX/OPBsjyLXiXWFVj8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D5RC98xgCPdKx9Y4xB4mAs5fIH8YET5aL4G02uwRoG7vL2YTO/fqCT8E3zeiCZsUSXMhxQ8JH1YSp62VRro+bQIO/E8WJEG1n15S50gv4Bthq7re3t2WrvD++lBscEVvz0Az/A6aSr9rA+ufbdg6AuxLbP0WwWNLOUj+SMZVrqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENSTXFsx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENSTXFsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06411F000E9;
	Wed,  2 Sep 2026 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354738;
	bh=t7/W2bwLmK8ClxR5HmjVYJpSBSO9HOcgP72/3kWaTnE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ENSTXFsxtMryPYdCdbLTtWoPlI3bpsofrxaQQGSCA3nprC9Ugi+mOFcs/tgoWgE3Y
	 5mf4DpkKtht2+gUQaj/I+UCsP7Z8cmpQJ6vnEVw52fdeNQtU0NyQcAQz7Q8zq14GQ+
	 XuiLLPJjP+8ERlPKYzlah7Rb9RDa8ycPrmVIMd1pVO0LQ+8T68FI9HNJRAzxs68u11
	 ueuJgQsvsK+IikO2GpBJa1y6Qe65iwolxGSF35Or5CojjdBjOnOJpbneXwK23lYay5
	 OOAjSmSKPKQ29+FbIjyWznYJWM2rYQERkuGuznjMCj6hYkVm14cb4VutE2vRCl94s2
	 BDPxBnhA1n6kQ==
Subject: Re: [net-next,v23,02/14] virtio_pci: Fix sleeping under spinlock in
 admin command path
From: netdev-bot+sashiko@kernel.org
To: shshitrit@nvidia.com
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
Date: Wed, 02 Sep 2026 13:12:17 +0000
Message-ID: <178835473723.3394541.8002424749068111766@kernel.org>
In-Reply-To: <20260831161109.2999926-3-shshitrit@nvidia.com>
References: <20260831161109.2999926-3-shshitrit@nvidia.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 2 (2) · Medium: 2 · Low: 1

- [High] The patch adds a new `vp_dev->admin_vq.info = NULL` store in
  vp_del_vq() (drivers/virtio/virtio_pci_common.c:261) but does not…
- [High] Forward-progress regression / livelock in the -ENOSPC retry loop
  of virtqueue_exec_admin_cmd().
- [Medium] Missing `Fixes:` tag and `Cc: stable` for a live sleep-in-
  atomic defect.
- [Medium] vp_modern_avq_work() dereferences admin_vq->info at function
  entry (drivers/virtio/virtio_pci_modern.c:59) with no NULL check, but…
- [Low] vp_modern_avq_done() no longer touches the virtqueue at all - it
  only calls schedule_work() (drivers/virtio/virtio_pci_modern.c:47-52).

Pre-existing issues:
- [High] Admin-command submission, reset cleanup and queue deletion do
  not share the admin_vq lock, so teardown can run concurrently with…
- [High] The admin-queue completion path converts the device-supplied
  used length into a result size without bounding it against the…

--

virtio_pci: Fix sleeping under spinlock in admin command path

Replaces the admin virtqueue spinlock with a mutex so that
virtqueue_add_sgs() may use GFP_KERNEL, and moves the admin virtqueue
completion handling out of the interrupt callback into a work item, since a
mutex cannot be taken from interrupt context.

No Link: tags present in the commit header.

A few questions below about the new teardown/NULL handling, the -ENOSPC
retry loop, and the missing Fixes: tag.

> virtqueue_exec_admin_cmd() calls virtqueue_add_sgs() with GFP_KERNEL
> while holding a spinlock. GFP_KERNEL allocations can sleep, which is
> illegal in atomic context.
>
> The issue becomes more significant with the next commit, which exposes
> vp_modern_admin_cmd_exec() through virtio_config_ops. This makes the
> admin command path available to device drivers and potentially reachable
> from userspace, increasing the likelihood of hitting the invalid sleep
> under memory pressure.

[Severity: Medium]
Should this patch carry a Fixes: tag and a stable Cc?

Both the spin_lock_irqsave(&admin_vq->lock, flags) and the
virtqueue_add_sgs(..., GFP_KERNEL) it wraps in virtqueue_exec_admin_cmd()
were added by:

  4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to
  wait on admin cmd result")

The sleep looks reachable on released kernels rather than only after the
follow-up commit: virtqueue_add_split() allocates before the -ENOSPC check,

drivers/virtio/virtio_ring.c:virtqueue_add_split() {
	...
	if (virtqueue_use_indirect(vq, total_sg))
		desc = alloc_indirect_split(vq, total_sg, gfp);
	...
}

and alloc_indirect_split() does a kmalloc(size, gfp), so any admin command
with total_sg > 1 on a device that negotiated VIRTIO_RING_F_INDIRECT_DESC
does a GFP_KERNEL kmalloc with interrupts disabled and the spinlock held.
The vfio-virtio migration ioctls already drive that path today. Would the
wording "becomes more significant with the next commit" be better phrased
as the bug being reachable now, with a Fixes: tag so backporting tooling
can pick it up?

> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 10371ecbc054c..6bc0c0f6ac503 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -256,6 +256,11 @@ static void vp_del_vq(struct virtqueue *vq, struct virtio_pci_vq_info *info)
>  		spin_unlock_irqrestore(&vp_dev->lock, flags);
>  	}
>  
> +	if (vp_is_avq(vq->vdev, vq->index)) {
> +		cancel_work_sync(&vp_dev->admin_vq.work);
> +		vp_dev->admin_vq.info = NULL;
> +	}
> +

[Severity: High]
Can this NULL store oops the next reset?

All three consumers of admin_vq.info dereference it and only test the
member, not the container pointer:

drivers/virtio/virtio_pci_modern.c:vp_modern_avq_cleanup() {
	...
	vq = vp_dev->admin_vq.info->vq;
	if (!vq)
		return;
	...
}

drivers/virtio/virtio_pci_modern.c:virtqueue_exec_admin_cmd() {
	...
	vq = admin_vq->info->vq;
	if (!vq)
		return -EIO;
	...
}

drivers/virtio/virtio_pci_modern.c:vp_modern_avq_work() {
	...
	struct virtqueue *vq = admin_vq->info->vq;
	...
}

The suspend/reset flows appear to reach the first one with info == NULL:

virtblk_freeze_priv()			(also used for .reset_prepare)
    virtio_reset_device()
    vdev->config->del_vqs()
        vp_del_vqs() -> vp_del_vq() -> admin_vq.info = NULL

then on restore/reset_done:

virtio_device_restore_priv()
    virtio_reset_device()
        vp_reset() -> vp_modern_avq_cleanup() -> admin_vq.info->vq

virtio_reset_device() only writes status 0, so vdev->features still has
VIRTIO_F_ADMIN_VQ set and the feature-bit guard at the top of
vp_modern_avq_cleanup() does not stop it. virtnet_freeze() ->
remove_vq_common() has the same shape.

Would it make sense to check info itself at every consumer, and to
publish/clear it under the same lock the readers use? Right now the store
is done with no lock at all while the completion worker and command
submitters can be reading it.

Also, the reordering of vp_synchronize_vectors() and
vp_modern_avq_cleanup() in vp_reset() is explained only in the added code
comment. Could the commit message mention that behavioural change too?

>  	vp_dev->del_vq(info);
>  	kfree(info);
>  }

[ ... ]

> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index ef4a64eb99824..dab63b044a312 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -47,13 +47,20 @@ static int vp_avq_index(struct virtio_device *vdev, u16 *index, u16 *num)
>  void vp_modern_avq_done(struct virtqueue *vq)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> -	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
> +
> +	schedule_work(&vp_dev->admin_vq.work);
> +}

[Severity: Low]
This isn't a bug, but should the callback suppress further notifications
before deferring?

virtqueue_disable_cb() now runs only inside vp_modern_avq_work(), so
VRING_AVAIL_F_NO_INTERRUPT (or used_event with VIRTIO_RING_F_EVENT_IDX) is
not armed for the whole window between the device notification and the
worker being picked up. During that window every completed admin command
raises an interrupt whose only effect is a schedule_work() that returns
false because the work is already pending.

Since the admin queue normally shares the config/slow-path MSI-X vector
(vp_find_one_vq_msix() with slow_path=true uses VP_MSIX_CONFIG_VECTOR),
those extra interrupts also re-walk slow_virtqueues under vp_dev->lock with
interrupts disabled.

The usual virtio pattern is to disable the callback first, as
virtqueue_napi_schedule() does in virtio_net:

	if (napi_schedule_prep(napi)) {
		virtqueue_disable_cb(vq);
		...
	}

> +
> +static void vp_modern_avq_work(struct work_struct *work)
> +{
>  	unsigned int status_size = sizeof(struct virtio_admin_cmd_status);
> +	struct virtio_pci_admin_vq *admin_vq =
> +		container_of(work, struct virtio_pci_admin_vq, work);
> +	struct virtqueue *vq = admin_vq->info->vq;

[Severity: Medium]
Can this dereference run before admin_vq.info has been published?

vp_setup_vq() enables the queue and links it into the dispatch list before
assigning the admin info pointer:

drivers/virtio/virtio_pci_common.c:vp_setup_vq() {
	...
		if (!vp_is_slow_path_vector(msix_vec))
			list_add(&info->node, &vp_dev->virtqueues);
		else
			list_add(&info->node, &vp_dev->slow_virtqueues);
	...
	*p_info = info;
	...
}

In the shared-vector and INTx configurations the handler is registered
before any virtqueue exists, so vp_vring_interrupt() /
vp_vring_slow_path_interrupt() can call vring_interrupt() on the admin vq
inside that window if the device has advanced the used index. That runs
vp_modern_avq_done() -> schedule_work(), and the worker then reads
admin_vq->info->vq while info is still NULL (vp_dev is zero-allocated).

The old callback was immune because it received the vq as its argument and
never touched admin_vq->info. Would a NULL check on info here, or
publishing info before the queue is exposed to interrupt dispatch, be
preferable?

>  	struct virtio_admin_cmd *cmd;
> -	unsigned long flags;
>  	unsigned int len;
>  
> -	spin_lock_irqsave(&admin_vq->lock, flags);
> +	mutex_lock(&admin_vq->lock);
>  	do {
>  		virtqueue_disable_cb(vq);
>  		while ((cmd = virtqueue_get_buf(vq, &len))) {

[Severity: High]
This isn't a bug introduced by this patch, since the length handling was
moved verbatim from vp_modern_avq_done() into the new work item, but can
this leak uninitialized page contents to userspace?

The length written by the device is only checked against a lower bound, and
never against the size of the result scatterlist that was submitted:

drivers/virtio/virtio_pci_modern.c:vp_modern_avq_work() {
	...
			if (len < status_size)
				cmd->result_sg_size = 0;
			else
				cmd->result_sg_size = len - status_size;
	...
}

virtqueue_get_buf() validates the descriptor id, not the length, and
virtio_pci_admin_dev_parts_get() passes the value straight out:

	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
	if (!ret)
		*res_size = cmd.result_sg_size;

drivers/vfio/pci/virtio/migrate.c then trusts it:

virtiovf_read_device_context_chunk() {
	...
	buf->length = res_size;
	...
}

virtiovf_buf_read() {
	...
	copy_len = min_t(size_t,
			 vhca_buf->start_pos + vhca_buf->length - *pos, *len);
	...
}

and the backing pages are not zeroed:

virtiovf_add_migration_pages() {
	...
		filled = alloc_pages_bulk(GFP_KERNEL_ACCOUNT, to_fill,
					  page_list);
	...
}

So a device reporting a used length larger than what it actually wrote gets
stale kernel page contents copied to the migration fd reader; the page
lookup only fails past allocated_length, after earlier copy_to_user() calls
have already run. Should result_sg_size be clamped to the length of the
result scatterlist that was submitted?

[ ... ]

> @@ -100,11 +106,11 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>  	if (virtqueue_is_broken(vq))
>  		return -EIO;
>  
> -	spin_lock_irqsave(&admin_vq->lock, flags);
> +	mutex_lock(&admin_vq->lock);
>  	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
>  	if (ret < 0) {
>  		if (ret == -ENOSPC) {
> -			spin_unlock_irqrestore(&admin_vq->lock, flags);
> +			mutex_unlock(&admin_vq->lock);
>  			cpu_relax();
>  			goto again;
>  		}

[Severity: High]
Can this retry loop stop making progress now?

Before the patch, descriptors were reclaimed inline in the interrupt
callback, so the hard interrupt preempted the spinning task and freed ring
slots. After the patch the only remaining caller of virtqueue_get_buf() on
the admin vq is vp_modern_avq_work(), which has to be picked up by a
per-CPU bound worker on system_percpu_wq:

vp_modern_avq_done()
    schedule_work(&vp_dev->admin_vq.work)	/* system_percpu_wq */
        vp_modern_avq_work()
            virtqueue_get_buf()			/* only reclaim site */

The retry path has no guaranteed scheduling point: virtqueue_is_broken() is
a READ_ONCE, the uncontended mutex_lock()/mutex_unlock() fast paths only
reach might_sleep(), and cpu_relax() does not yield. With
CONFIG_PREEMPT_NONE=y (or PREEMPT_DYNAMIC booted with preempt=none), if the
work item is queued to the CPU running the busy loop, the bound worker
never gets to run, no descriptors are freed, and virtqueue_add_sgs() keeps
returning -ENOSPC. On a single-vCPU guest that CPU match is automatic.

The loop's only exits are success, virtqueue_is_broken() and a non-ENOSPC
error, none of which can become true without the worker running. Would a
cond_resched() here, or waiting on an event signalled by the completion
worker, or an unbound/WQ_MEM_RECLAIM workqueue, address this? Related: the
untimed wait_for_completion() below now also depends on worker
availability, and system_percpu_wq is not WQ_MEM_RECLAIM.

[ ... ]

> @@ -350,6 +356,8 @@ static void vp_modern_avq_cleanup(struct virtio_device *vdev)
>  	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
>  		return;
>  
> +	cancel_work_sync(&vp_dev->admin_vq.work);
> +
>  	vq = vp_dev->admin_vq.info->vq;
>  	if (!vq)
>  		return;

[Severity: High]
This is a pre-existing issue, as the cleanup path and vp_del_vq() ignored
the former spinlock too, but does the new cancel_work_sync() cover enough?
It serializes the completion worker only, not command submitters.

Nothing holds admin_vq->lock on the teardown side:

drivers/virtio/virtio_pci_modern.c:vp_modern_avq_cleanup() {
	...
	while ((cmd = virtqueue_detach_unused_buf(vq))) {
		cmd->ret = -EIO;
		complete(&cmd->completion);
	}
}

drivers/virtio/virtio_pci_common.c:vp_del_vq() {
	...
	vp_dev->del_vq(info);
	kfree(info);
}

while a submitter caches the queue pointer outside the lock:

drivers/virtio/virtio_pci_modern.c:virtqueue_exec_admin_cmd() {
	...
	vq = admin_vq->info->vq;
	if (!vq)
		return -EIO;
	...
	mutex_lock(&admin_vq->lock);
	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
	...
}

So a vp_reset() (suspend, FLR, unbind) on one CPU can detach descriptors
while another CPU is inside virtqueue_add_sgs() on the same vring, or free
the virtqueue and info after a submitter cached vq, or leave a command
waiting forever on a queue that was reset. The "caller must serialize
access for the given device" note on virtio_pci_admin_dev_parts_*() only
covers admin-command callers among themselves, not the PM/reset path.
Should the teardown side take admin_vq->lock as well?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831161109.2999926-1-shshitrit%40nvidia.com
