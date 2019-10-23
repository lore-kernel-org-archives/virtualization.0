From: Dmitry Vyukov via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 3/3] vhost, kcov: collect coverage from vhost_worker
Date: Wed, 23 Oct 2019 10:36:20 +0200
Message-ID: <CACT4Y+YntxT+cpESOBvbg+h=g-84ECJwQrFg7LM5tbq_zaMd3A__40405.8552974433$1571819804$gmane$org@mail.gmail.com>
References: <cover.1571762488.git.andreyknvl@google.com>
	<26e088ae3ebcaa30afe957aeabaa9f0c653df7d0.1571762488.git.andreyknvl@google.com>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <26e088ae3ebcaa30afe957aeabaa9f0c653df7d0.1571762488.git.andreyknvl@google.com>
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
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, KVM list <kvm@vger.kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Elena Reshetova <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 22, 2019 at 6:46 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patch adds kcov_remote_start()/kcov_remote_stop() annotations to the
> vhost_worker() function, which is responsible for processing vhost works.
> Since vhost_worker() threads are spawned per vhost device instance
> the common kcov handle is used for kcov_remote_start()/stop() annotations
> (see Documentation/dev-tools/kcov.rst for details). As the result kcov can
> now be used to collect coverage from vhost worker threads.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  drivers/vhost/vhost.c | 6 ++++++
>  drivers/vhost/vhost.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 36ca2cf419bf..a5a557c4b67f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -30,6 +30,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/interval_tree_generic.h>
>  #include <linux/nospec.h>
> +#include <linux/kcov.h>
>
>  #include "vhost.h"
>
> @@ -357,7 +358,9 @@ static int vhost_worker(void *data)
>                 llist_for_each_entry_safe(work, work_next, node, node) {
>                         clear_bit(VHOST_WORK_QUEUED, &work->flags);
>                         __set_current_state(TASK_RUNNING);
> +                       kcov_remote_start(dev->kcov_handle);
>                         work->fn(work);
> +                       kcov_remote_stop();
>                         if (need_resched())
>                                 schedule();
>                 }
> @@ -546,6 +549,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>
>         /* No owner, become one */
>         dev->mm = get_task_mm(current);
> +       dev->kcov_handle = current->kcov_handle;

kcov_handle is not present in task_struct if !CONFIG_KCOV

Also this does not use KCOV_SUBSYSTEM_COMMON.
We discussed something along the following lines:

u64 kcov_remote_handle(u64 subsys, u64 id)
{
  WARN_ON(subsys or id has wrong bits set).
  return ...;
}

kcov_remote_handle(KCOV_SUBSYSTEM_USB, bus);
kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, current->kcov_handle);


>         worker = kthread_create(vhost_worker, dev, "vhost-%d", current->pid);
>         if (IS_ERR(worker)) {
>                 err = PTR_ERR(worker);
> @@ -571,6 +575,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>         if (dev->mm)
>                 mmput(dev->mm);
>         dev->mm = NULL;
> +       dev->kcov_handle = 0;
>  err_mm:
>         return err;
>  }
> @@ -682,6 +687,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>         if (dev->worker) {
>                 kthread_stop(dev->worker);
>                 dev->worker = NULL;
> +               dev->kcov_handle = 0;
>         }
>         if (dev->mm)
>                 mmput(dev->mm);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index e9ed2722b633..a123fd70847e 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -173,6 +173,7 @@ struct vhost_dev {
>         int iov_limit;
>         int weight;
>         int byte_weight;
> +       u64 kcov_handle;
>  };
>
>  bool vhost_exceeds_weight(struct vhost_virtqueue *vq, int pkts, int total_len);
> --
> 2.23.0.866.gb869b98d4c-goog
>
