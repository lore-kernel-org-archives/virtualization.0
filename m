From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 6/6] kernel: set USER_DS in kthread_use_mm
Date: Mon, 6 Apr 2020 17:49:34 -0400
Message-ID: <20200406174917-mutt-send-email-mst@kernel.org>
References: <20200404094101.672954-1-hch@lst.de>
 <20200404094101.672954-7-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200404094101.672954-7-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>, Felipe Balbi <balbi@kernel.org>, Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Apr 04, 2020 at 11:41:01AM +0200, Christoph Hellwig wrote:
> Some architectures like arm64 and s390 require USER_DS to be set for
> kernel threads to access user address space, which is the whole purpose
> of kthread_use_mm, but other like x86 don't.  That has lead to a huge
> mess where some callers are fixed up once they are tested on said
> architectures, while others linger around and yet other like io_uring
> try to do "clever" optimizations for what usually is just a trivial
> asignment to a member in the thread_struct for most architectures.
> 
> Make kthread_use_mm set USER_DS, and kthread_unuse_mm restore to the
> previous value instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I'm ok with vhost bits:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/usb/gadget/function/f_fs.c | 4 ----
>  drivers/vhost/vhost.c              | 3 ---
>  fs/io-wq.c                         | 8 ++------
>  fs/io_uring.c                      | 4 ----
>  kernel/kthread.c                   | 6 ++++++
>  5 files changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index d9e48bd7c692..a1198f4c527c 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -824,13 +824,9 @@ static void ffs_user_copy_worker(struct work_struct *work)
>  	bool kiocb_has_eventfd = io_data->kiocb->ki_flags & IOCB_EVENTFD;
>  
>  	if (io_data->read && ret > 0) {
> -		mm_segment_t oldfs = get_fs();
> -
> -		set_fs(USER_DS);
>  		kthread_use_mm(io_data->mm);
>  		ret = ffs_copy_to_iter(io_data->buf, ret, &io_data->data);
>  		kthread_unuse_mm(io_data->mm);
> -		set_fs(oldfs);
>  	}
>  
>  	io_data->kiocb->ki_complete(io_data->kiocb, ret, ret);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 1787d426a956..b5229ae01d3b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -333,9 +333,7 @@ static int vhost_worker(void *data)
>  	struct vhost_dev *dev = data;
>  	struct vhost_work *work, *work_next;
>  	struct llist_node *node;
> -	mm_segment_t oldfs = get_fs();
>  
> -	set_fs(USER_DS);
>  	kthread_use_mm(dev->mm);
>  
>  	for (;;) {
> @@ -365,7 +363,6 @@ static int vhost_worker(void *data)
>  		}
>  	}
>  	kthread_unuse_mm(dev->mm);
> -	set_fs(oldfs);
>  	return 0;
>  }
>  
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index 83c2868eff2a..75cc2f31816d 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -168,7 +168,6 @@ static bool __io_worker_unuse(struct io_wqe *wqe, struct io_worker *worker)
>  			dropped_lock = true;
>  		}
>  		__set_current_state(TASK_RUNNING);
> -		set_fs(KERNEL_DS);
>  		kthread_unuse_mm(worker->mm);
>  		mmput(worker->mm);
>  		worker->mm = NULL;
> @@ -420,14 +419,11 @@ static void io_wq_switch_mm(struct io_worker *worker, struct io_wq_work *work)
>  		mmput(worker->mm);
>  		worker->mm = NULL;
>  	}
> -	if (!work->mm) {
> -		set_fs(KERNEL_DS);
> +	if (!work->mm)
>  		return;
> -	}
> +
>  	if (mmget_not_zero(work->mm)) {
>  		kthread_use_mm(work->mm);
> -		if (!worker->mm)
> -			set_fs(USER_DS);
>  		worker->mm = work->mm;
>  		/* hang on to this mm */
>  		work->mm = NULL;
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 367406381044..c332a34e8b34 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -5871,15 +5871,12 @@ static int io_sq_thread(void *data)
>  	struct io_ring_ctx *ctx = data;
>  	struct mm_struct *cur_mm = NULL;
>  	const struct cred *old_cred;
> -	mm_segment_t old_fs;
>  	DEFINE_WAIT(wait);
>  	unsigned long timeout;
>  	int ret = 0;
>  
>  	complete(&ctx->completions[1]);
>  
> -	old_fs = get_fs();
> -	set_fs(USER_DS);
>  	old_cred = override_creds(ctx->creds);
>  
>  	timeout = jiffies + ctx->sq_thread_idle;
> @@ -5985,7 +5982,6 @@ static int io_sq_thread(void *data)
>  	if (current->task_works)
>  		task_work_run();
>  
> -	set_fs(old_fs);
>  	if (cur_mm) {
>  		kthread_unuse_mm(cur_mm);
>  		mmput(cur_mm);
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 316db17f6b4f..9e27d01b6d78 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -52,6 +52,7 @@ struct kthread {
>  	unsigned long flags;
>  	unsigned int cpu;
>  	void *data;
> +	mm_segment_t oldfs;
>  	struct completion parked;
>  	struct completion exited;
>  #ifdef CONFIG_BLK_CGROUP
> @@ -1235,6 +1236,9 @@ void kthread_use_mm(struct mm_struct *mm)
>  
>  	if (active_mm != mm)
>  		mmdrop(active_mm);
> +
> +	to_kthread(tsk)->oldfs = get_fs();
> +	set_fs(USER_DS);
>  }
>  EXPORT_SYMBOL_GPL(kthread_use_mm);
>  
> @@ -1249,6 +1253,8 @@ void kthread_unuse_mm(struct mm_struct *mm)
>  	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
>  	WARN_ON_ONCE(!tsk->mm);
>  
> +	set_fs(to_kthread(tsk)->oldfs);
> +
>  	task_lock(tsk);
>  	sync_mm_rss(mm);
>  	tsk->mm = NULL;
> -- 
> 2.25.1
