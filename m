From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 03/11] vhost: Make vhost a separate module
Date: Mon, 6 May 2013 12:53:07 +0300
Message-ID: <20130506095307.GA16469@redhat.com>
References: <1367829509-5371-1-git-send-email-asias@redhat.com>
	<1367829509-5371-4-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1367829509-5371-4-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 06, 2013 at 04:38:21PM +0800, Asias He wrote:
> Currently, vhost-net and vhost-scsi are sharing the vhost core code.
> However, vhost-scsi shares the code by including the vhost.c file
> directly.
> 
> Making vhost a separate module makes it is easier to share code with
> other vhost devices.
> 
> Signed-off-by: Asias He <asias@redhat.com>
> ---
>  drivers/vhost/Kconfig  |  8 ++++++++
>  drivers/vhost/Makefile |  3 ++-
>  drivers/vhost/scsi.c   |  1 -
>  drivers/vhost/vhost.c  | 51 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/vhost/vhost.h  |  2 ++
>  5 files changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 8b9226d..017a1e8 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -1,6 +1,7 @@
>  config VHOST_NET
>  	tristate "Host kernel accelerator for virtio net"
>  	depends on NET && EVENTFD && (TUN || !TUN) && (MACVTAP || !MACVTAP)
> +	select VHOST
>  	select VHOST_RING
>  	---help---
>  	  This kernel module can be loaded in host kernel to accelerate
> @@ -13,6 +14,7 @@ config VHOST_NET
>  config VHOST_SCSI
>  	tristate "VHOST_SCSI TCM fabric driver"
>  	depends on TARGET_CORE && EVENTFD && m
> +	select VHOST
>  	select VHOST_RING
>  	default n
>  	---help---
> @@ -24,3 +26,9 @@ config VHOST_RING
>  	---help---
>  	  This option is selected by any driver which needs to access
>  	  the host side of a virtio ring.
> +
> +config VHOST
> +	tristate
> +	---help---
> +	  This option is selected by any driver which needs to access
> +	  the core of vhost.
> diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
> index 654e9afb..e0441c3 100644
> --- a/drivers/vhost/Makefile
> +++ b/drivers/vhost/Makefile
> @@ -1,7 +1,8 @@
>  obj-$(CONFIG_VHOST_NET) += vhost_net.o
> -vhost_net-y := vhost.o net.o
> +vhost_net-y := net.o
>  
>  obj-$(CONFIG_VHOST_SCSI) += vhost_scsi.o
>  vhost_scsi-y := scsi.o
>  
>  obj-$(CONFIG_VHOST_RING) += vringh.o
> +obj-$(CONFIG_VHOST)	+= vhost.o
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 5179f7a..2dcb94a 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -49,7 +49,6 @@
>  #include <linux/llist.h>
>  #include <linux/bitmap.h>
>  
> -#include "vhost.c"
>  #include "vhost.h"
>  
>  #define TCM_VHOST_VERSION  "v0.1"
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index de9441a..e406d5f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -25,6 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/kthread.h>
>  #include <linux/cgroup.h>
> +#include <linux/module.h>
>  
>  #include "vhost.h"
>  
> @@ -66,6 +67,7 @@ void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn)
>  	work->flushing = 0;
>  	work->queue_seq = work->done_seq = 0;
>  }
> +EXPORT_SYMBOL_GPL(vhost_work_init);
>  
>  /* Init poll structure */
>  void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
> @@ -79,6 +81,7 @@ void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
>  
>  	vhost_work_init(&poll->work, fn);
>  }
> +EXPORT_SYMBOL_GPL(vhost_poll_init);
>  
>  /* Start polling a file. We add ourselves to file's wait queue. The caller must
>   * keep a reference to a file until after vhost_poll_stop is called. */
> @@ -101,6 +104,7 @@ int vhost_poll_start(struct vhost_poll *poll, struct file *file)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(vhost_poll_start);
>  
>  /* Stop polling a file. After this function returns, it becomes safe to drop the
>   * file reference. You must also flush afterwards. */
> @@ -111,6 +115,7 @@ void vhost_poll_stop(struct vhost_poll *poll)
>  		poll->wqh = NULL;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(vhost_poll_stop);
>  
>  static bool vhost_work_seq_done(struct vhost_dev *dev, struct vhost_work *work,
>  				unsigned seq)
> @@ -123,7 +128,7 @@ static bool vhost_work_seq_done(struct vhost_dev *dev, struct vhost_work *work,
>  	return left <= 0;
>  }
>  
> -static void vhost_work_flush(struct vhost_dev *dev, struct vhost_work *work)
> +void vhost_work_flush(struct vhost_dev *dev, struct vhost_work *work)
>  {
>  	unsigned seq;
>  	int flushing;
> @@ -138,6 +143,7 @@ static void vhost_work_flush(struct vhost_dev *dev, struct vhost_work *work)
>  	spin_unlock_irq(&dev->work_lock);
>  	BUG_ON(flushing < 0);
>  }
> +EXPORT_SYMBOL_GPL(vhost_work_flush);
>  
>  /* Flush any work that has been scheduled. When calling this, don't hold any
>   * locks that are also used by the callback. */
> @@ -145,6 +151,7 @@ void vhost_poll_flush(struct vhost_poll *poll)
>  {
>  	vhost_work_flush(poll->dev, &poll->work);
>  }
> +EXPORT_SYMBOL_GPL(vhost_poll_flush);
>  
>  void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
>  {
> @@ -158,11 +165,13 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
>  	}
>  	spin_unlock_irqrestore(&dev->work_lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(vhost_work_queue);
>  
>  void vhost_poll_queue(struct vhost_poll *poll)
>  {
>  	vhost_work_queue(poll->dev, &poll->work);
>  }
> +EXPORT_SYMBOL_GPL(vhost_poll_queue);
>  
>  static void vhost_vq_reset(struct vhost_dev *dev,
>  			   struct vhost_virtqueue *vq)
> @@ -310,6 +319,7 @@ long vhost_dev_init(struct vhost_dev *dev,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(vhost_dev_init);
>  
>  /* Caller should have device mutex */
>  long vhost_dev_check_owner(struct vhost_dev *dev)
> @@ -317,6 +327,7 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
>  	/* Are you the owner? If not, I don't think you mean to do that */
>  	return dev->mm == current->mm ? 0 : -EPERM;
>  }
> +EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
>  
>  struct vhost_attach_cgroups_struct {
>  	struct vhost_work work;
> @@ -385,11 +396,13 @@ err_worker:
>  err_mm:
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
>  
>  struct vhost_memory *vhost_dev_reset_owner_prepare(void)
>  {
>  	return kmalloc(offsetof(struct vhost_memory, regions), GFP_KERNEL);
>  }
> +EXPORT_SYMBOL_GPL(vhost_dev_reset_owner_prepare);
>  
>  /* Caller should have device mutex */
>  void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_memory *memory)
> @@ -400,6 +413,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_memory *memory)
>  	memory->nregions = 0;
>  	RCU_INIT_POINTER(dev->memory, memory);
>  }
> +EXPORT_SYMBOL_GPL(vhost_dev_reset_owner);
>  
>  void vhost_dev_stop(struct vhost_dev *dev)
>  {
> @@ -412,6 +426,7 @@ void vhost_dev_stop(struct vhost_dev *dev)
>  		}
>  	}
>  }
> +EXPORT_SYMBOL_GPL(vhost_dev_stop);
>  
>  /* Caller should have device mutex if and only if locked is set */
>  void vhost_dev_cleanup(struct vhost_dev *dev, bool locked)
> @@ -452,6 +467,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev, bool locked)
>  		mmput(dev->mm);
>  	dev->mm = NULL;
>  }
> +EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
>  
>  static int log_access_ok(void __user *log_base, u64 addr, unsigned long sz)
>  {
> @@ -537,6 +553,7 @@ int vhost_log_access_ok(struct vhost_dev *dev)
>  				       lockdep_is_held(&dev->mutex));
>  	return memory_access_ok(dev, mp, 1);
>  }
> +EXPORT_SYMBOL_GPL(vhost_log_access_ok);
>  
>  /* Verify access for write logging. */
>  /* Caller should have vq mutex and device mutex */
> @@ -562,6 +579,7 @@ int vhost_vq_access_ok(struct vhost_virtqueue *vq)
>  	return vq_access_ok(vq->dev, vq->num, vq->desc, vq->avail, vq->used) &&
>  		vq_log_access_ok(vq->dev, vq, vq->log_base);
>  }
> +EXPORT_SYMBOL_GPL(vhost_vq_access_ok);
>  
>  static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
>  {
> @@ -791,6 +809,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp)
>  		vhost_poll_flush(&vq->poll);
>  	return r;
>  }
> +EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
>  
>  /* Caller must have device mutex */
>  long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> @@ -871,6 +890,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  done:
>  	return r;
>  }
> +EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
>  
>  static const struct vhost_memory_region *find_region(struct vhost_memory *mem,
>  						     __u64 addr, __u32 len)
> @@ -962,6 +982,7 @@ int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
>  	BUG();
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(vhost_log_write);
>  
>  static int vhost_update_used_flags(struct vhost_virtqueue *vq)
>  {
> @@ -1013,6 +1034,7 @@ int vhost_init_used(struct vhost_virtqueue *vq)
>  	vq->signalled_used_valid = false;
>  	return get_user(vq->last_used_idx, &vq->used->idx);
>  }
> +EXPORT_SYMBOL_GPL(vhost_init_used);
>  
>  static int translate_desc(struct vhost_dev *dev, u64 addr, u32 len,
>  			  struct iovec iov[], int iov_size)
> @@ -1289,12 +1311,14 @@ int vhost_get_vq_desc(struct vhost_dev *dev, struct vhost_virtqueue *vq,
>  	BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
>  	return head;
>  }
> +EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
>  
>  /* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
>  void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
>  {
>  	vq->last_avail_idx -= n;
>  }
> +EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
>  
>  /* After we've used one of their buffers, we tell them about it.  We'll then
>   * want to notify the guest, using eventfd. */
> @@ -1343,6 +1367,7 @@ int vhost_add_used(struct vhost_virtqueue *vq, unsigned int head, int len)
>  		vq->signalled_used_valid = false;
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(vhost_add_used);
>  
>  static int __vhost_add_used_n(struct vhost_virtqueue *vq,
>  			    struct vring_used_elem *heads,
> @@ -1412,6 +1437,7 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
>  	}
>  	return r;
>  }
> +EXPORT_SYMBOL_GPL(vhost_add_used_n);
>  
>  static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  {
> @@ -1456,6 +1482,7 @@ void vhost_signal(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  	if (vq->call_ctx && vhost_notify(dev, vq))
>  		eventfd_signal(vq->call_ctx, 1);
>  }
> +EXPORT_SYMBOL_GPL(vhost_signal);
>  
>  /* And here's the combo meal deal.  Supersize me! */
>  void vhost_add_used_and_signal(struct vhost_dev *dev,
> @@ -1465,6 +1492,7 @@ void vhost_add_used_and_signal(struct vhost_dev *dev,
>  	vhost_add_used(vq, head, len);
>  	vhost_signal(dev, vq);
>  }
> +EXPORT_SYMBOL_GPL(vhost_add_used_and_signal);
>  
>  /* multi-buffer version of vhost_add_used_and_signal */
>  void vhost_add_used_and_signal_n(struct vhost_dev *dev,
> @@ -1474,6 +1502,7 @@ void vhost_add_used_and_signal_n(struct vhost_dev *dev,
>  	vhost_add_used_n(vq, heads, count);
>  	vhost_signal(dev, vq);
>  }
> +EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
>  
>  /* OK, now we need to know about added descriptors. */
>  bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
> @@ -1511,6 +1540,7 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  
>  	return avail_idx != vq->avail_idx;
>  }
> +EXPORT_SYMBOL_GPL(vhost_enable_notify);
>  
>  /* We don't need to be notified again. */
>  void vhost_disable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
> @@ -1527,3 +1557,22 @@ void vhost_disable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  			       &vq->used->flags, r);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(vhost_disable_notify);
> +
> +static int __init vhost_init(void)
> +{
> +	return 0;
> +}
> +
> +static void __exit vhost_exit(void)
> +{
> +	return;

No need for return here.

> +}
> +
> +module_init(vhost_init);
> +module_exit(vhost_exit);
> +
> +MODULE_VERSION("0.0.1");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Michael S. Tsirkin");
> +MODULE_DESCRIPTION("Host kernel accelerator for virtio");
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 6bf81a9..94a80eb 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -46,6 +46,8 @@ int vhost_poll_start(struct vhost_poll *poll, struct file *file);
>  void vhost_poll_stop(struct vhost_poll *poll);
>  void vhost_poll_flush(struct vhost_poll *poll);
>  void vhost_poll_queue(struct vhost_poll *poll);
> +void vhost_work_flush(struct vhost_dev *dev, struct vhost_work *work);
> +long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp);
>  
>  struct vhost_log {
>  	u64 addr;
> -- 
> 1.8.1.4
