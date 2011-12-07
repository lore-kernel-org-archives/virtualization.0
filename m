From: Amit Shah <amit.shah@redhat.com>
Subject: Re: (resend) [PATCH v4 12/12] virtio: balloon: Add freeze, restore
	handlers to support S4
Date: Wed, 7 Dec 2011 16:09:41 +0530
Message-ID: <20111207103941.GH4651@amit-x200.redhat.com>
References: <5deccc36afa59032f0e3b10a653773bad511f303.1323199985.git.amit.shah@redhat.com>
	<20111207103448.GA20882@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111207103448.GA20882@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, levinsasha928@gmail.com, Pavel Machek <pavel@ucw.cz>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 07 Dec 2011 [12:34:48], Michael S. Tsirkin wrote:
> On Wed, Dec 07, 2011 at 01:18:50AM +0530, Amit Shah wrote:
> > Now to not race with a host issuing ballooning requests while we are in
> > the process of freezing, we just exit from the vballoon kthread when the
> > processes are asked to freeze.  Upon thaw and restore, we re-start the
> > thread.
> 
> ...
> 
> > ---
> >  drivers/virtio/virtio_balloon.c |   79 ++++++++++++++++++++++++++++++++++++++-
> >  1 files changed, 78 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 8bf99be..10ec638 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -258,7 +258,13 @@ static int balloon(void *_vballoon)
> >  	while (!kthread_should_stop()) {
> >  		s64 diff;
> >  
> > -		try_to_freeze();
> > +		/*
> > +		 * On suspend, we want to exit this thread.  We will
> > +		 * start a new thread on resume.
> > +		 */
> > +		if (freezing(current))
> > +			break;
> > +
> >  		wait_event_interruptible(vb->config_change,
> >  					 (diff = towards_target(vb)) != 0
> >  					 || vb->need_stats_update
> 
> ...
> 
> Note: this relies on kthreads being frozen before devices.
> Looking at kernel/power/hibernate.c this is the case,
> but I think we should add a comment to note this.

Yes, it does.  And for that reason, I mentioned that stopping the
thread doesn't buy us anything; I'll revert this change in the next
submission.

> Also Cc linux-pm crowd in case I got it wrong.

		Amit
