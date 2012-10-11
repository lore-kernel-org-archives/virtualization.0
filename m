From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-blk: Add vhost-blk support v2
Date: Thu, 11 Oct 2012 14:41:26 +0200
Message-ID: <20121011124125.GA8074@redhat.com>
References: <1349769918-8611-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1349769918-8611-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 09, 2012 at 04:05:18PM +0800, Asias He wrote:
> vhost-blk is an in-kernel virito-blk device accelerator.
> 
> Due to lack of proper in-kernel AIO interface, this version converts
> guest's I/O request to bio and use submit_bio() to submit I/O directly.
> So this version any supports raw block device as guest's disk image,
> e.g. /dev/sda, /dev/ram0. We can add file based image support to
> vhost-blk once we have in-kernel AIO interface. There are some work in
> progress for in-kernel AIO interface from Dave Kleikamp and Zach Brown:
> 
>    http://marc.info/?l=linux-fsdevel&m=133312234313122
> 
> Performance evaluation:
> -----------------------------
> 1) LKVM
> Fio with libaio ioengine on Fusion IO device using kvm tool
> IOPS       Before       After   Improvement
> seq-read   107          121     +13.0%
> seq-write  130          179     +37.6%
> rnd-read   102          122     +19.6%
> rnd-write  125          159     +27.0%
> 
> 2) QEMU
> Fio with libaio ioengine on Fusion IO device using QEMU
> IOPS       Before       After   Improvement
> seq-read   76           123     +61.8%
> seq-write  139          173     +24.4%
> rnd-read   73           120     +64.3%
> rnd-write  75           156     +108.0%
> 
> Userspace bits:
> -----------------------------
> 1) LKVM
> The latest vhost-blk userspace bits for kvm tool can be found here:
> git@github.com:asias/linux-kvm.git blk.vhost-blk
> 
> 2) QEMU
> The latest vhost-blk userspace prototype for QEMU can be found here:
> git@github.com:asias/qemu.git blk.vhost-blk
> 
> Signed-off-by: Asias He <asias@redhat.com>
> ---
>  drivers/vhost/Kconfig     |   1 +
>  drivers/vhost/Kconfig.blk |  10 +
>  drivers/vhost/Makefile    |   2 +
>  drivers/vhost/blk.c       | 641 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/vhost/blk.h       |   8 +
>  5 files changed, 662 insertions(+)
>  create mode 100644 drivers/vhost/Kconfig.blk
>  create mode 100644 drivers/vhost/blk.c
>  create mode 100644 drivers/vhost/blk.h
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 202bba6..acd8038 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -11,4 +11,5 @@ config VHOST_NET
>  
>  if STAGING
>  source "drivers/vhost/Kconfig.tcm"
> +source "drivers/vhost/Kconfig.blk"
>  endif
> diff --git a/drivers/vhost/Kconfig.blk b/drivers/vhost/Kconfig.blk
> new file mode 100644
> index 0000000..ff8ab76
> --- /dev/null
> +++ b/drivers/vhost/Kconfig.blk
> @@ -0,0 +1,10 @@
> +config VHOST_BLK
> +	tristate "Host kernel accelerator for virtio blk (EXPERIMENTAL)"
> +	depends on BLOCK &&  EXPERIMENTAL && m
> +	---help---
> +	  This kernel module can be loaded in host kernel to accelerate
> +	  guest block with virtio_blk. Not to be confused with virtio_blk
> +	  module itself which needs to be loaded in guest kernel.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called vhost_blk.
> diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
> index a27b053..1a8a4a5 100644
> --- a/drivers/vhost/Makefile
> +++ b/drivers/vhost/Makefile
> @@ -2,3 +2,5 @@ obj-$(CONFIG_VHOST_NET) += vhost_net.o
>  vhost_net-y := vhost.o net.o
>  
>  obj-$(CONFIG_TCM_VHOST) += tcm_vhost.o
> +obj-$(CONFIG_VHOST_BLK) += vhost_blk.o
> +vhost_blk-y := blk.o
> diff --git a/drivers/vhost/blk.c b/drivers/vhost/blk.c
> new file mode 100644
> index 0000000..6b2445a
> --- /dev/null
> +++ b/drivers/vhost/blk.c
> @@ -0,0 +1,641 @@
> +/*
> + * Copyright (C) 2011 Taobao, Inc.
> + * Author: Liu Yuan <tailai.ly@taobao.com>
> + *
> + * Copyright (C) 2012 Red Hat, Inc.
> + * Author: Asias He <asias@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + *
> + * virtio-blk server in host kernel.
> + */
> +
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/vhost.h>
> +#include <linux/virtio_blk.h>
> +#include <linux/mutex.h>
> +#include <linux/file.h>
> +#include <linux/kthread.h>
> +#include <linux/blkdev.h>
> +
> +#include "vhost.c"
> +#include "vhost.h"
> +#include "blk.h"
> +
> +#define BLK_HDR	0

What's this for, exactly? Please add a comment.

> +
> +static DEFINE_IDA(vhost_blk_index_ida);
> +
> +enum {
> +	VHOST_BLK_VQ_REQ = 0,
> +	VHOST_BLK_VQ_MAX = 1,
> +};
> +
> +struct req_page_list {
> +	struct page **pages;
> +	int pages_nr;
> +};
> +
> +struct vhost_blk_req {
> +	struct llist_node llnode;
> +	struct req_page_list *pl;
> +	struct vhost_blk *blk;
> +
> +	struct iovec *iov;
> +	int iov_nr;
> +
> +	struct bio **bio;
> +	atomic_t bio_nr;
> +
> +	sector_t sector;
> +	int write;
> +	u16 head;
> +	long len;
> +
> +	u8 *status;

Is this a userspace pointer? If yes it must be tagged as such.

Please run code checker - it will catch other bugs for you too.

> +};
> +
> +struct vhost_blk {
> +	struct task_struct *host_kick;
> +	struct vhost_blk_req *reqs;
> +	struct vhost_virtqueue vq;
> +	struct llist_head llhead;
> +	struct vhost_dev dev;
> +	u16 reqs_nr;
> +	int index;
> +};
> +
> +static inline int iov_num_pages(struct iovec *iov)
> +{
> +	return (PAGE_ALIGN((unsigned long)iov->iov_base + iov->iov_len) -
> +	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
> +}
> +
> +static int vhost_blk_setup(struct vhost_blk *blk)
> +{
> +	blk->reqs_nr = blk->vq.num;
> +
> +	blk->reqs = kmalloc(sizeof(struct vhost_blk_req) * blk->reqs_nr,
> +			    GFP_KERNEL);
> +	if (!blk->reqs)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static inline int vhost_blk_set_status(struct vhost_blk_req *req, u8 status)
> +{
> +	struct vhost_blk *blk = req->blk;
> +
> +	if (copy_to_user(req->status, &status, sizeof(status))) {

Does this write into guest memory, right? This write needs to be tracked in
log in case it's enabled.

Also, __copy_to_user should be enough here, right?

> +		vq_err(&blk->vq, "Failed to write status\n");
> +		vhost_discard_vq_desc(&blk->vq, 1);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static void vhost_blk_enable_vq(struct vhost_blk *blk,
> +				struct vhost_virtqueue *vq)
> +{
> +	wake_up_process(blk->host_kick);
> +}
> +
> +static void vhost_blk_req_done(struct bio *bio, int err)
> +{
> +	struct vhost_blk_req *req = bio->bi_private;
> +	struct vhost_blk *blk = req->blk;
> +
> +	if (err)
> +		req->len = err;
> +
> +	if (atomic_dec_and_test(&req->bio_nr)) {
> +		llist_add(&req->llnode, &blk->llhead);
> +		wake_up_process(blk->host_kick);
> +	}
> +
> +	bio_put(bio);
> +}
> +
> +static void vhost_blk_req_umap(struct vhost_blk_req *req)
> +{
> +	struct req_page_list *pl;
> +	int i, j;
> +
> +	if (!req->pl)
> +		return;
> +
> +	for (i = 0; i < req->iov_nr; i++) {
> +		pl = &req->pl[i];
> +		for (j = 0; j < pl->pages_nr; j++) {
> +			if (!req->write)
> +				set_page_dirty_lock(pl->pages[j]);
> +			page_cache_release(pl->pages[j]);
> +		}
> +	}
> +
> +	kfree(req->pl);
> +}
> +
> +static int vhost_blk_bio_make(struct vhost_blk_req *req,
> +			      struct block_device *bdev)
> +{
> +	int pages_nr_total, i, j, ret;
> +	struct iovec *iov = req->iov;
> +	int iov_nr = req->iov_nr;
> +	struct page **pages, *page;
> +	struct bio *bio = NULL;
> +	int bio_nr = 0;
> +
> +	req->len = 0;
> +	pages_nr_total = 0;
> +	for (i = 0; i < iov_nr; i++) {
> +		req->len += iov[i].iov_len;
> +		pages_nr_total += iov_num_pages(&iov[i]);
> +	}
> +
> +	req->pl = kmalloc((iov_nr * sizeof(struct req_page_list)) +
> +			  (pages_nr_total * sizeof(struct page *)) +
> +			  (pages_nr_total * sizeof(struct bio *)),
> +			  GFP_KERNEL);
> +	if (!req->pl)
> +		return -ENOMEM;
> +	pages = (struct page **)&req->pl[iov_nr];
> +	req->bio = (struct bio **)&pages[pages_nr_total];
> +
> +	req->iov_nr = 0;
> +	for (i = 0; i < iov_nr; i++) {
> +		int pages_nr = iov_num_pages(&iov[i]);
> +		unsigned long iov_base, iov_len;
> +		struct req_page_list *pl;
> +
> +		iov_base = (unsigned long)iov[i].iov_base;
> +		iov_len  = (unsigned long)iov[i].iov_len;
> +
> +		ret = get_user_pages_fast(iov_base, pages_nr,
> +					  !req->write, pages);
> +		if (ret != pages_nr)
> +			goto fail;
> +
> +		req->iov_nr++;
> +		pl = &req->pl[i];
> +		pl->pages_nr = pages_nr;
> +		pl->pages = pages;
> +
> +		for (j = 0; j < pages_nr; j++) {
> +			unsigned int off, len;
> +			page = pages[j];
> +			off = iov_base & ~PAGE_MASK;
> +			len = PAGE_SIZE - off;
> +			if (len > iov_len)
> +				len = iov_len;
> +
> +			while (!bio || bio_add_page(bio, page, len, off) <= 0) {
> +				bio = bio_alloc(GFP_KERNEL, pages_nr);
> +				if (!bio)
> +					goto fail;
> +				bio->bi_sector  = req->sector;
> +				bio->bi_bdev    = bdev;
> +				bio->bi_private = req;
> +				bio->bi_end_io  = vhost_blk_req_done;
> +				req->bio[bio_nr++] = bio;
> +			}
> +			req->sector	+= len >> 9;
> +			iov_base	+= len;
> +			iov_len		-= len;
> +		}
> +
> +		pages += pages_nr;
> +	}
> +	atomic_set(&req->bio_nr, bio_nr);
> +
> +	return 0;
> +
> +fail:
> +	for (i = 0; i < bio_nr; i++)
> +		bio_put(req->bio[i]);
> +	vhost_blk_req_umap(req);
> +	return -ENOMEM;
> +}
> +
> +static inline void vhost_blk_bio_send(struct vhost_blk_req *req)
> +{
> +	struct blk_plug plug;
> +	int i, bio_nr;
> +
> +	bio_nr = atomic_read(&req->bio_nr);
> +	blk_start_plug(&plug);
> +	for (i = 0; i < bio_nr; i++)
> +		submit_bio(req->write, req->bio[i]);
> +	blk_finish_plug(&plug);
> +}
> +
> +static int vhost_blk_req_submit(struct vhost_blk_req *req, struct file *file)
> +{
> +
> +	struct inode *inode = file->f_mapping->host;
> +	struct block_device *bdev = inode->i_bdev;
> +	int ret;
> +
> +	ret = vhost_blk_bio_make(req, bdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	vhost_blk_bio_send(req);
> +
> +	return ret;
> +}
> +
> +static int vhost_blk_req_done_thread(void *data)
> +{
> +	mm_segment_t oldfs = get_fs();
> +	struct vhost_blk *blk = data;
> +	struct vhost_virtqueue *vq;
> +	struct llist_node *llnode;
> +	struct vhost_blk_req *req;
> +	bool added;
> +	u8 status;
> +	int ret;
> +
> +	vq = &blk->vq;
> +	set_fs(USER_DS);
> +	use_mm(blk->dev.mm);
> +	for (;;) {
> +		llnode = llist_del_all(&blk->llhead);


Interesting, I didn't consider llist - maybe vhost.c
could switch to that too? If we do how to handle flushing?
If we do we can move some common code out here.

> +		if (!llnode) {
> +			set_current_state(TASK_INTERRUPTIBLE);
> +			schedule();
> +			if (unlikely(kthread_should_stop()))
> +				break;
> +			continue;
> +		}

I think you need to call something like
                        if (need_resched())
                                schedule();
once in a while even if the list is not empty.

> +		added = false;
> +		while (llnode) {
> +			req = llist_entry(llnode, struct vhost_blk_req, llnode);
> +			llnode = llist_next(llnode);
> +
> +			vhost_blk_req_umap(req);
> +
> +			status = req->len > 0 ?
> +				 VIRTIO_BLK_S_OK : VIRTIO_BLK_S_IOERR;
> +			ret = copy_to_user(req->status, &status,
> +					   sizeof(status));

use vhost_blk_set_status? Why not?

> +			if (unlikely(ret)) {
> +				vq_err(&blk->vq, "Failed to write status\n");
> +				return -1;

This will kill this thread. Likely not what was intended.

> +			}
> +			vhost_add_used(&blk->vq, req->head, req->len);
> +			added = true;
> +		}
> +		if (likely(added))
> +			vhost_signal(&blk->dev, &blk->vq);
> +

Pls dont add empty line here.

> +	}
> +	unuse_mm(blk->dev.mm);
> +	set_fs(oldfs);
> +	return 0;
> +}
> +
> +static void vhost_blk_flush(struct vhost_blk *blk)
> +{
> +	vhost_poll_flush(&blk->vq.poll);

Hmm but blk kthread could still be processing requests, no?
Need to flush these too I think?

> +}
> +
> +static struct file *vhost_blk_stop_vq(struct vhost_blk *blk,
> +				      struct vhost_virtqueue *vq)
> +{
> +	struct file *file;
> +
> +	mutex_lock(&vq->mutex);
> +	file = rcu_dereference_protected(vq->private_data,
> +			lockdep_is_held(&vq->mutex));
> +	rcu_assign_pointer(vq->private_data, NULL);
> +	mutex_unlock(&vq->mutex);
> +
> +	return file;
> +
> +}
> +
> +static inline void vhost_blk_stop(struct vhost_blk *blk, struct file **file)
> +{
> +
> +	*file = vhost_blk_stop_vq(blk, &blk->vq);

Is this wrapper worth it? Also maybe just return file?

> +}
> +
> +/* Handle guest request */
> +static int vhost_blk_req_handle(struct vhost_virtqueue *vq,
> +				struct virtio_blk_outhdr *hdr,
> +				u16 head, u16 out, u16 in,
> +				struct file *file)
> +{
> +	struct vhost_blk *blk = container_of(vq->dev, struct vhost_blk, dev);
> +	struct vhost_blk_req *req;
> +	int iov_nr, ret;
> +	u8 status;
> +
> +	if (hdr->type == VIRTIO_BLK_T_IN || hdr->type == VIRTIO_BLK_T_GET_ID)
> +		iov_nr = in - 1;
> +	else
> +		iov_nr = out - 1;
> +
> +	req		= &blk->reqs[head];
> +	req->head	= head;
> +	req->status	= blk->vq.iov[iov_nr + 1].iov_base;
> +	req->blk	= blk;
> +	req->iov	= &vq->iov[BLK_HDR + 1];

Lots of manual mangling of iovecs here and elsewhere is scary.
First, there should not be so many assumptions about how buffers
are laid out. Second, there seems to be no validation that iovec
is large enough. It is preferable to use memcpy_toiovecend and friends
which validate input. This applied to many places below, please
audit code for such uses. Where you find it necessary to
handle iovec directly, please add comments explaining where
it's validated and why it's safe.


> +	req->iov_nr	= iov_nr;
> +	req->sector	= hdr->sector;
> +
> +	switch (hdr->type) {
> +	case VIRTIO_BLK_T_OUT:
> +		req->write = WRITE;
> +		ret = vhost_blk_req_submit(req, file);
> +		break;
> +	case VIRTIO_BLK_T_IN:
> +		req->write = READ;
> +		ret = vhost_blk_req_submit(req, file);
> +		break;
> +	case VIRTIO_BLK_T_FLUSH:
> +		ret = vfs_fsync(file, 1);
> +		status = ret < 0 ? VIRTIO_BLK_S_IOERR : VIRTIO_BLK_S_OK;
> +		if (!vhost_blk_set_status(req, status))
> +			vhost_add_used_and_signal(&blk->dev, vq, head, ret);

This should discard on error, no? Also return error to caller?
		r = vhost_blk_set_status(req, status);
		if (r) {
			ret = r;
			break;
		}
		vhost_add_used_and_signal(&blk->dev, vq, head, ret);
		return 0;

and move discard outside switch below.

> +		break;
> +	case VIRTIO_BLK_T_GET_ID:
> +		ret = snprintf(vq->iov[BLK_HDR + 1].iov_base,
> +			       VIRTIO_BLK_ID_BYTES, "vhost-blk%d", blk->index);

snprintf into a userspace buffer? Uh oh.

> +		status = ret < 0 ? VIRTIO_BLK_S_IOERR : VIRTIO_BLK_S_OK;
> +		if (!vhost_blk_set_status(req, status))
> +			vhost_add_used_and_signal(&blk->dev, vq, head, ret);
> +		break;
> +	default:
> +		pr_warn("Unsupported request type %d\n", hdr->type);

This can be triggered by userspace so vq_err?

> +		vhost_discard_vq_desc(vq, 1);

Note this does not skip this descriptor - it gives userspace
chance to correct it and retry. Is this the intended behaviour?
Should not we fail request instead?

> +		ret = -EFAULT;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/* Guest kick us for IO request */
> +static void vhost_blk_handle_guest_kick(struct vhost_work *work)
> +{
> +	struct virtio_blk_outhdr hdr;
> +	struct vhost_virtqueue *vq;
> +	struct vhost_blk *blk;
> +	struct blk_plug plug;
> +	struct file *f;
> +	int in, out;
> +	u16 head;
> +
> +	vq = container_of(work, struct vhost_virtqueue, poll.work);
> +	blk = container_of(vq->dev, struct vhost_blk, dev);
> +
> +	/* TODO: check that we are running from vhost_worker? */
> +	f = rcu_dereference_check(vq->private_data, 1);
> +	if (!f)
> +		return;
> +
> +	vhost_disable_notify(&blk->dev, vq);
> +	blk_start_plug(&plug);
> +	for (;;) {
> +		head = vhost_get_vq_desc(&blk->dev, vq, vq->iov,
> +					 ARRAY_SIZE(vq->iov),
> +					 &out, &in, NULL, NULL);
> +		if (unlikely(head < 0))
> +			break;
> +
> +		if (unlikely(head == vq->num)) {
> +			if (unlikely(vhost_enable_notify(&blk->dev, vq))) {
> +				vhost_disable_notify(&blk->dev, vq);
> +				continue;
> +			}
> +			break;
> +		}
> +
> +		if (unlikely(copy_from_user(&hdr, vq->iov[BLK_HDR].iov_base,
> +					    sizeof(hdr)))) {
> +			vq_err(vq, "Failed to get block header!\n");
> +			vhost_discard_vq_desc(vq, 1);
> +			break;
> +		}
> +
> +		if (vhost_blk_req_handle(vq, &hdr, head, out, in, f) < 0)
> +			break;
> +	}
> +	blk_finish_plug(&plug);
> +}
> +
> +static int vhost_blk_open(struct inode *inode, struct file *file)
> +{
> +	struct vhost_blk *blk;
> +	int ret;
> +
> +	blk = kzalloc(sizeof(*blk), GFP_KERNEL);
> +	if (!blk) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret = ida_simple_get(&vhost_blk_index_ida, 0, 0, GFP_KERNEL);
> +	if (ret < 0)
> +		goto out_dev;
> +	blk->index = ret;
> +
> +	blk->vq.handle_kick = vhost_blk_handle_guest_kick;
> +
> +	ret = vhost_dev_init(&blk->dev, &blk->vq, VHOST_BLK_VQ_MAX);
> +	if (ret < 0)
> +		goto out_dev;
> +	file->private_data = blk;
> +
> +	blk->host_kick = kthread_create(vhost_blk_req_done_thread,
> +			 blk, "vhost-blk-%d", current->pid);
> +	if (IS_ERR(blk->host_kick)) {
> +		ret = PTR_ERR(blk->host_kick);
> +		goto out_dev;
> +	}
> +
> +	return ret;
> +out_dev:
> +	kfree(blk);
> +out:
> +	return ret;
> +}
> +
> +static int vhost_blk_release(struct inode *inode, struct file *f)
> +{
> +	struct vhost_blk *blk = f->private_data;
> +	struct file *file;
> +
> +	ida_simple_remove(&vhost_blk_index_ida, blk->index);
> +	vhost_blk_stop(blk, &file);
> +	vhost_blk_flush(blk);
> +	vhost_dev_cleanup(&blk->dev, false);
> +	if (file)
> +		fput(file);
> +	kthread_stop(blk->host_kick);
> +	kfree(blk->reqs);
> +	kfree(blk);
> +
> +	return 0;
> +}
> +
> +static int vhost_blk_set_features(struct vhost_blk *blk, u64 features)
> +{
> +	mutex_lock(&blk->dev.mutex);
> +	blk->dev.acked_features = features;
> +	mutex_unlock(&blk->dev.mutex);

We also need to flush outstanding requets normally.
If not needed here pls add a comment why.

> +
> +	return 0;
> +}
> +
> +static long vhost_blk_set_backend(struct vhost_blk *blk, unsigned index, int fd)
> +{
> +	struct vhost_virtqueue *vq = &blk->vq;
> +	struct file *file, *oldfile;
> +	int ret;
> +
> +	mutex_lock(&blk->dev.mutex);
> +	ret = vhost_dev_check_owner(&blk->dev);
> +	if (ret)
> +		goto out_dev;
> +
> +	if (index >= VHOST_BLK_VQ_MAX) {
> +		ret = -ENOBUFS;
> +		goto out_dev;
> +	}
> +
> +	mutex_lock(&vq->mutex);
> +
> +	if (!vhost_vq_access_ok(vq)) {
> +		ret = -EFAULT;
> +		goto out_vq;
> +	}
> +
> +	file = fget(fd);
> +	if (IS_ERR(file)) {
> +		ret = PTR_ERR(file);
> +		goto out_vq;
> +	}
> +
> +	oldfile = rcu_dereference_protected(vq->private_data,
> +			lockdep_is_held(&vq->mutex));
> +	if (file != oldfile) {
> +		rcu_assign_pointer(vq->private_data, file);
> +		vhost_blk_enable_vq(blk, vq);
> +
> +		ret = vhost_init_used(vq);
> +		if (ret)
> +			goto out_vq;
> +	}
> +
> +	mutex_unlock(&vq->mutex);
> +
> +	if (oldfile) {
> +		vhost_blk_flush(blk);
> +		fput(oldfile);
> +	}
> +
> +	mutex_unlock(&blk->dev.mutex);
> +	return 0;
> +
> +out_vq:
> +	mutex_unlock(&vq->mutex);
> +out_dev:
> +	mutex_unlock(&blk->dev.mutex);
> +	return ret;
> +}
> +
> +static long vhost_blk_reset_owner(struct vhost_blk *blk)
> +{
> +	struct file *file = NULL;
> +	int err;
> +
> +	mutex_lock(&blk->dev.mutex);
> +	err = vhost_dev_check_owner(&blk->dev);
> +	if (err)
> +		goto done;
> +	vhost_blk_stop(blk, &file);
> +	vhost_blk_flush(blk);
> +	err = vhost_dev_reset_owner(&blk->dev);
> +done:
> +	mutex_unlock(&blk->dev.mutex);
> +	if (file)
> +		fput(file);
> +	return err;
> +}
> +
> +static long vhost_blk_ioctl(struct file *f, unsigned int ioctl,
> +			    unsigned long arg)
> +{
> +	struct vhost_blk *blk = f->private_data;
> +	void __user *argp = (void __user *)arg;
> +	struct vhost_vring_file backend;
> +	u64 __user *featurep = argp;
> +	u64 features;
> +	int ret;
> +
> +	switch (ioctl) {
> +	case VHOST_BLK_SET_BACKEND:
> +		if (copy_from_user(&backend, argp, sizeof(backend)))
> +			return -EFAULT;
> +		return vhost_blk_set_backend(blk, backend.index, backend.fd);
> +	case VHOST_GET_FEATURES:
> +		features = VHOST_BLK_FEATURES;
> +		if (copy_to_user(featurep, &features, sizeof(features)))
> +			return -EFAULT;
> +		return 0;
> +	case VHOST_SET_FEATURES:
> +		if (copy_from_user(&features, featurep, sizeof(features)))
> +			return -EFAULT;
> +		if (features & ~VHOST_BLK_FEATURES)
> +			return -EOPNOTSUPP;
> +		return vhost_blk_set_features(blk, features);
> +	case VHOST_RESET_OWNER:
> +		return vhost_blk_reset_owner(blk);
> +	default:
> +		mutex_lock(&blk->dev.mutex);
> +		ret = vhost_dev_ioctl(&blk->dev, ioctl, arg);
> +		if (!ret && ioctl == VHOST_SET_VRING_NUM)
> +			ret = vhost_blk_setup(blk);
> +		vhost_blk_flush(blk);
> +		mutex_unlock(&blk->dev.mutex);
> +		return ret;
> +	}
> +}
> +
> +static const struct file_operations vhost_blk_fops = {
> +	.owner          = THIS_MODULE,
> +	.open           = vhost_blk_open,
> +	.release        = vhost_blk_release,
> +	.llseek		= noop_llseek,
> +	.unlocked_ioctl = vhost_blk_ioctl,
> +};
> +
> +static struct miscdevice vhost_blk_misc = {
> +	MISC_DYNAMIC_MINOR,
> +	"vhost-blk",
> +	&vhost_blk_fops,
> +};
> +
> +int vhost_blk_init(void)
> +{
> +	return misc_register(&vhost_blk_misc);
> +}
> +
> +void vhost_blk_exit(void)
> +{
> +	misc_deregister(&vhost_blk_misc);
> +}
> +
> +module_init(vhost_blk_init);
> +module_exit(vhost_blk_exit);
> +
> +MODULE_VERSION("0.0.3");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Asias He");
> +MODULE_DESCRIPTION("Host kernel accelerator for virtio_blk");
> diff --git a/drivers/vhost/blk.h b/drivers/vhost/blk.h
> new file mode 100644
> index 0000000..2f674f0
> --- /dev/null
> +++ b/drivers/vhost/blk.h
> @@ -0,0 +1,8 @@
> +#include <linux/vhost.h>
> +
> +enum {
> +	VHOST_BLK_FEATURES = (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
> +			     (1ULL << VIRTIO_RING_F_EVENT_IDX),
> +};
> +/* VHOST_BLK specific defines */
> +#define VHOST_BLK_SET_BACKEND _IOW(VHOST_VIRTIO, 0x50, struct vhost_vring_file)
> -- 
> 1.7.11.4
