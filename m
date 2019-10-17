From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC 3/3] vhost, kcov: collect coverage from vhost_worker
Date: Thu, 17 Oct 2019 11:18:00 -0700
Message-ID: <20191017181800.GB1094415@kroah.com>
References: <cover.1571333592.git.andreyknvl@google.com>
	<af26317c0efd412dd660e81d548a173942f8a0ad.1571333592.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <af26317c0efd412dd660e81d548a173942f8a0ad.1571333592.git.andreyknvl@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, Elena Reshetova <elena.reshetova@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, David Windsor <dwindsor@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 17, 2019 at 07:44:15PM +0200, Andrey Konovalov wrote:
> This patch adds kcov_remote_start/kcov_remote_stop annotations to the
> vhost_worker function, which is responsible for processing vhost works.
> Since vhost_worker is spawned when a vhost device instance is created,
> the common kcov handle is used for kcov_remote_start/stop annotations.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  drivers/vhost/vhost.c | 15 +++++++++++++++
>  drivers/vhost/vhost.h |  3 +++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 36ca2cf419bf..71a349f6b352 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -357,7 +357,13 @@ static int vhost_worker(void *data)
>  		llist_for_each_entry_safe(work, work_next, node, node) {
>  			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>  			__set_current_state(TASK_RUNNING);
> +#ifdef CONFIG_KCOV
> +			kcov_remote_start(dev->kcov_handle);
> +#endif

Shouldn't you hide these #ifdefs in a .h file?  This is not a "normal"
kernel coding style at all.

>  			work->fn(work);
> +#ifdef CONFIG_KCOV
> +			kcov_remote_stop();
> +#endif
>  			if (need_resched())
>  				schedule();
>  		}
> @@ -546,6 +552,9 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  
>  	/* No owner, become one */
>  	dev->mm = get_task_mm(current);
> +#ifdef CONFIG_KCOV
> +	dev->kcov_handle = current->kcov_handle;
> +#endif
>  	worker = kthread_create(vhost_worker, dev, "vhost-%d", current->pid);
>  	if (IS_ERR(worker)) {
>  		err = PTR_ERR(worker);
> @@ -571,6 +580,9 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  	if (dev->mm)
>  		mmput(dev->mm);
>  	dev->mm = NULL;
> +#ifdef CONFIG_KCOV
> +	dev->kcov_handle = 0;
> +#endif
>  err_mm:
>  	return err;
>  }
> @@ -682,6 +694,9 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  	if (dev->worker) {
>  		kthread_stop(dev->worker);
>  		dev->worker = NULL;
> +#ifdef CONFIG_KCOV
> +		dev->kcov_handle = 0;
> +#endif
>  	}
>  	if (dev->mm)
>  		mmput(dev->mm);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index e9ed2722b633..010ca1ebcbd5 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -173,6 +173,9 @@ struct vhost_dev {
>  	int iov_limit;
>  	int weight;
>  	int byte_weight;
> +#ifdef CONFIG_KCOV
> +	u64 kcov_handle;
> +#endif

Why is this a #ifdef at all here?

thanks,

greg k-h
