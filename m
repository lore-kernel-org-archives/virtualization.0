From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio balloon: do not call blocking ops when !TASK_RUNNING
Date: Thu, 26 Feb 2015 18:41:19 +0100
Message-ID: <20150226174119.GA20674@redhat.com>
References: <20150225111318.0040536b@oc7435384737.ibm.com>
	<87y4nllb85.fsf@rustcorp.com.au>
	<20150226083031.GA24184@redhat.com>
	<20150226170849.GV21418@twins.programming.kicks-ass.net>
	<20150226172743.GA20582@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150226172743.GA20582@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 26, 2015 at 06:27:43PM +0100, Michael S. Tsirkin wrote:
> On Thu, Feb 26, 2015 at 06:08:49PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 26, 2015 at 09:30:31AM +0100, Michael S. Tsirkin wrote:
> > > On Thu, Feb 26, 2015 at 11:50:42AM +1030, Rusty Russell wrote:
> > > > Thomas Huth <thuth@linux.vnet.ibm.com> writes:
> > > > >  Hi all,
> > > > >
> > > > > with the recent kernel 3.19, I get a kernel warning when I start my
> > > > > KVM guest on s390 with virtio balloon enabled:
> > > > 
> > > > The deeper problem is that virtio_ccw_get_config just silently fails on
> > > > OOM.
> > > > 
> > > > Neither get_config nor set_config are expected to fail.
> > > > 
> > > > Cornelia, I think ccw and config_area should be allocated inside vcdev.
> > > > You could either use pointers, or simply allocate vcdev with GDP_DMA.
> > > > 
> > > > This would avoid the kmalloc inside these calls.
> > > > 
> > > > Thanks,
> > > > Rusty.
> > > 
> > > But it won't solve the problem of nested sleepers
> > > with ccw: ATM is invokes ccw_io_helper to execute
> > > commands, and that one calls wait_event
> > > to wait for an interrupt.
> > > 
> > > Might be fixable but I think my patch looks like a safer
> > > solution for 4.0/3.19, no?
> > 
> > I've no idea what your patch was since I'm not subscribed to any of the
> > lists this discussion is had on.
> 
> Oh, sorry about that.
> Here it is, below:
> 
> ----- Forwarded message from "Michael S. Tsirkin" <mst@redhat.com> -----
> 
> Date: Wed, 25 Feb 2015 15:36:02 +0100
> From: "Michael S. Tsirkin" <mst@redhat.com>
> To: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org, Thomas Huth <thuth@linux.vnet.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>,
> 	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
> Subject: [PATCH v2] virtio-balloon: do not call blocking ops when !TASK_RUNNING
> Message-ID: <1424874878-17155-1-git-send-email-mst@redhat.com>
> 
> virtio balloon has this code:
>         wait_event_interruptible(vb->config_change,
>                                  (diff = towards_target(vb)) != 0
>                                  || vb->need_stats_update
>                                  || kthread_should_stop()
>                                  || freezing(current));
> 
> Which is a problem because towards_target() call might block after
> wait_event_interruptible sets task state to TAST_INTERRUPTIBLE, causing
> the task_struct::state collision typical of nesting of sleeping
> primitives
> 
> See also http://lwn.net/Articles/628628/ or Thomas's
> bug report
> http://article.gmane.org/gmane.linux.kernel.virtualization/24846
> for a fuller explanation.
> 
> To fix, rewrite using wait_woken.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> changes from v1:
> 	remove wait_event_interruptible
> 	noticed by Cornelia Huck <cornelia.huck@de.ibm.com>
> 
>  drivers/virtio/virtio_balloon.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 0413157..5a6ad6d 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -29,6 +29,7 @@
>  #include <linux/module.h>
>  #include <linux/balloon_compaction.h>
>  #include <linux/oom.h>
> +#include <linux/wait.h>
>  
>  /*
>   * Balloon device works in 4K page units.  So each page is pointed to by
> @@ -334,17 +335,25 @@ static int virtballoon_oom_notify(struct notifier_block *self,
>  static int balloon(void *_vballoon)
>  {
>  	struct virtio_balloon *vb = _vballoon;
> +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>  
>  	set_freezable();
>  	while (!kthread_should_stop()) {
>  		s64 diff;
>  
>  		try_to_freeze();
> -		wait_event_interruptible(vb->config_change,
> -					 (diff = towards_target(vb)) != 0
> -					 || vb->need_stats_update
> -					 || kthread_should_stop()
> -					 || freezing(current));
> +
> +		add_wait_queue(&vb->config_change, &wait);
> +		for (;;) {
> +			if ((diff = towards_target(vb)) != 0 ||
> +			    vb->need_stats_update ||
> +			    kthread_should_stop() ||
> +			    freezing(current))
> +				break;
> +			wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
> +		}
> +		remove_wait_queue(&vb->config_change, &wait);
> +
>  		if (vb->need_stats_update)
>  			stats_handle_request(vb);
>  		if (diff > 0)
> -- 
> MST

WRT which, I have a question. IIUC it's OK for towards_target
in this code to call wait_event in its turn, assuming that
*that* wait_event is not not calling blocking ops.
Right?


> ----- End forwarded message -----
