From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 2/2] virtio_balloon: Use a workqueue instead of
	"vballoon" kthread
Date: Fri, 1 Jan 2016 12:18:17 +0200
Message-ID: <20160101121432-mutt-send-email-mst@redhat.com>
References: <1449236271-10133-1-git-send-email-pmladek@suse.com>
	<1449236271-10133-3-git-send-email-pmladek@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1449236271-10133-3-git-send-email-pmladek@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.cz>, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Jeff Epler <jepler@unpythonic.net>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 04, 2015 at 02:37:51PM +0100, Petr Mladek wrote:
> From: Petr Mladek <pmladek@suse.cz>
> 
> This patch moves the deferred work from the "vballoon" kthread into a
> system freezable workqueue.
> 
> We do not need to maintain and run a dedicated kthread. Also the event
> driven workqueues API makes the logic much easier. Especially, we do
> not longer need an own wait queue, wait function, and freeze point.
> 
> The conversion is pretty straightforward. One cycle of the main loop
> is put into a work. The work is queued instead of waking the kthread.
> 
> fill_balloon() and leak_balloon() have a limit for the amount of modified
> pages. The work re-queues itself when necessary.
> 
> My initial idea was to use a dedicated workqueue. Michael S. Tsirkin
> suggested using a system one. Tejun Heo confirmed that the system
> workqueue has a pretty high concurrency level (256) by default.
> Therefore we need not be afraid of too long blocking.

Right but fill has a 1/5 second sleep on failure - *that*
is problematic for a system queue.

There's also a race introduced on remove, see below.

I'm inclined to tread carefully with this conversion.

> 
> Signed-off-by: Petr Mladek <pmladek@suse.cz>
> ---
>  drivers/virtio/virtio_balloon.c | 82 +++++++++++++----------------------------
>  1 file changed, 26 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index d73a86db2490..960e54b1d0c1 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -22,8 +22,7 @@
>  #include <linux/virtio.h>
>  #include <linux/virtio_balloon.h>
>  #include <linux/swap.h>
> -#include <linux/kthread.h>
> -#include <linux/freezer.h>
> +#include <linux/workqueue.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -49,11 +48,8 @@ struct virtio_balloon {
>  	struct virtio_device *vdev;
>  	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq;
>  
> -	/* Where the ballooning thread waits for config to change. */
> -	wait_queue_head_t config_change;
> -
> -	/* The thread servicing the balloon. */
> -	struct task_struct *thread;
> +	/* The balloon servicing is delegated to a freezable workqueue. */
> +	struct work_struct wq_work;
>  
>  	/* Waiting for host to ack the pages we released. */
>  	wait_queue_head_t acked;
> @@ -255,14 +251,15 @@ static void update_balloon_stats(struct virtio_balloon *vb)
>   * with a single buffer.  From that point forward, all conversations consist of
>   * a hypervisor request (a call to this function) which directs us to refill
>   * the virtqueue with a fresh stats buffer.  Since stats collection can sleep,
> - * we notify our kthread which does the actual work via stats_handle_request().
> + * we delegate the job to a freezable workqueue that will do the actual work via
> + * stats_handle_request().
>   */
>  static void stats_request(struct virtqueue *vq)
>  {
>  	struct virtio_balloon *vb = vq->vdev->priv;
>  
>  	vb->need_stats_update = 1;
> -	wake_up(&vb->config_change);
> +	queue_work(system_freezable_wq, &vb->wq_work);
>  }
>  
>  static void stats_handle_request(struct virtio_balloon *vb)
> @@ -286,7 +283,7 @@ static void virtballoon_changed(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
>  
> -	wake_up(&vb->config_change);
> +	queue_work(system_freezable_wq, &vb->wq_work);
>  }
>  
>  static inline s64 towards_target(struct virtio_balloon *vb)
> @@ -349,43 +346,25 @@ static int virtballoon_oom_notify(struct notifier_block *self,
>  	return NOTIFY_OK;
>  }
>  
> -static int balloon(void *_vballoon)
> +static void balloon(struct work_struct *work)
>  {
> -	struct virtio_balloon *vb = _vballoon;
> -	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> -
> -	set_freezable();
> -	while (!kthread_should_stop()) {
> -		s64 diff;
> -
> -		try_to_freeze();
> -
> -		add_wait_queue(&vb->config_change, &wait);
> -		for (;;) {
> -			if ((diff = towards_target(vb)) != 0 ||
> -			    vb->need_stats_update ||
> -			    kthread_should_stop() ||
> -			    freezing(current))
> -				break;
> -			wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
> -		}
> -		remove_wait_queue(&vb->config_change, &wait);
> +	struct virtio_balloon *vb;
> +	s64 diff;
>  
> -		if (vb->need_stats_update)
> -			stats_handle_request(vb);
> -		if (diff > 0)
> -			fill_balloon(vb, diff);
> -		else if (diff < 0)
> -			leak_balloon(vb, -diff);
> -		update_balloon_size(vb);
> +	vb = container_of(work, struct virtio_balloon, wq_work);
> +	diff = towards_target(vb);
>  
> -		/*
> -		 * For large balloon changes, we could spend a lot of time
> -		 * and always have work to do.  Be nice if preempt disabled.
> -		 */
> -		cond_resched();
> -	}
> -	return 0;
> +	if (vb->need_stats_update)
> +		stats_handle_request(vb);
> +
> +	if (diff > 0)
> +		diff -= fill_balloon(vb, diff);
> +	else if (diff < 0)
> +		diff += leak_balloon(vb, -diff);
> +	update_balloon_size(vb);
> +
> +	if (diff)
> +		queue_work(system_freezable_wq, work);
>  }
>  
>  static int init_vqs(struct virtio_balloon *vb)
> @@ -503,9 +482,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  		goto out;
>  	}
>  
> +	INIT_WORK(&vb->wq_work, balloon);
>  	vb->num_pages = 0;
>  	mutex_init(&vb->balloon_lock);
> -	init_waitqueue_head(&vb->config_change);
>  	init_waitqueue_head(&vb->acked);
>  	vb->vdev = vdev;
>  	vb->need_stats_update = 0;
> @@ -527,16 +506,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> -	vb->thread = kthread_run(balloon, vb, "vballoon");
> -	if (IS_ERR(vb->thread)) {
> -		err = PTR_ERR(vb->thread);
> -		goto out_del_vqs;
> -	}
> -
>  	return 0;
>  
> -out_del_vqs:
> -	unregister_oom_notifier(&vb->nb);
>  out_oom_notify:
>  	vdev->config->del_vqs(vdev);
>  out_free_vb:
> @@ -563,7 +534,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  	struct virtio_balloon *vb = vdev->priv;
>  
>  	unregister_oom_notifier(&vb->nb);
> -	kthread_stop(vb->thread);
> +	cancel_work_sync(&vb->wq_work);

OK but since job requeues itself, cancelling like this might not be enough.

>  	remove_common(vb);
>  	kfree(vb);
>  }
> @@ -574,10 +545,9 @@ static int virtballoon_freeze(struct virtio_device *vdev)
>  	struct virtio_balloon *vb = vdev->priv;
>  
>  	/*
> -	 * The kthread is already frozen by the PM core before this
> +	 * The workqueue is already frozen by the PM core before this
>  	 * function is called.
>  	 */
> -
>  	remove_common(vb);
>  	return 0;
>  }
> -- 
> 1.8.5.6
