From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-balloon: do not call blocking ops when
	!TASK_RUNNING
Date: Wed, 25 Feb 2015 15:33:53 +0100
Message-ID: <20150225143353.GA17142@redhat.com>
References: <1424873603-16386-1-git-send-email-mst@redhat.com>
	<20150225153208.341b230f.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150225153208.341b230f.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 25, 2015 at 03:32:08PM +0100, Cornelia Huck wrote:
> On Wed, 25 Feb 2015 15:14:36 +0100
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > virtio balloon has this code:
> >         wait_event_interruptible(vb->config_change,
> >                                  (diff = towards_target(vb)) != 0
> >                                  || vb->need_stats_update
> >                                  || kthread_should_stop()
> >                                  || freezing(current));
> > 
> > Which is a problem because towards_target() call might block after
> > wait_event_interruptible sets task state to TAST_INTERRUPTIBLE, causing
> > the task_struct::state collision typical of nesting of sleeping
> > primitives
> > 
> > See also http://lwn.net/Articles/628628/ or Thomas's
> > bug report
> > http://article.gmane.org/gmane.linux.kernel.virtualization/24846
> > for a fuller explanation.
> > 
> > To fix, rewrite using wait_woken.
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/virtio/virtio_balloon.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 0413157..2f19f65 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/module.h>
> >  #include <linux/balloon_compaction.h>
> >  #include <linux/oom.h>
> > +#include <linux/wait.h>
> >  
> >  /*
> >   * Balloon device works in 4K page units.  So each page is pointed to by
> > @@ -334,12 +335,25 @@ static int virtballoon_oom_notify(struct notifier_block *self,
> >  static int balloon(void *_vballoon)
> >  {
> >  	struct virtio_balloon *vb = _vballoon;
> > +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> >  
> >  	set_freezable();
> >  	while (!kthread_should_stop()) {
> >  		s64 diff;
> >  
> >  		try_to_freeze();
> > +
> > +		add_wait_queue(&vb->config_change, &wait);
> > +		for (;;) {
> > +			if ((diff = towards_target(vb)) != 0 ||
> > +			    vb->need_stats_update ||
> > +			    kthread_should_stop() ||
> > +			    freezing(current))
> > +				break;
> > +			wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
> > +		}
> > +		remove_wait_queue(&vb->config_change, &wait);
> > +
> >  		wait_event_interruptible(vb->config_change,
> >  					 (diff = towards_target(vb)) != 0
> >  					 || vb->need_stats_update
> 
> Forgot to remove the wait_event_interruptible()?

Ugh. Forgot to commit :(
Will resend.
