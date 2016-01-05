From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 2/2] virtio_balloon: Use a workqueue instead of
	"vballoon" kthread
Date: Tue, 5 Jan 2016 17:37:08 +0200
Message-ID: <20160105173214-mutt-send-email-mst@redhat.com>
References: <1449236271-10133-1-git-send-email-pmladek@suse.com>
	<1449236271-10133-3-git-send-email-pmladek@suse.com>
	<20160101121432-mutt-send-email-mst@redhat.com>
	<20160102114316.GC3660@htj.duckdns.org>
	<20160102213603.GA1703@redhat.com>
	<20160105144918.GF3178@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160105144918.GF3178@pathway.suse.cz>
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
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Jeff Epler <jepler@unpythonic.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 05, 2016 at 03:49:18PM +0100, Petr Mladek wrote:
> On Sat 2016-01-02 23:36:03, Michael S. Tsirkin wrote:
> > On Sat, Jan 02, 2016 at 06:43:16AM -0500, Tejun Heo wrote:
> > > On Fri, Jan 01, 2016 at 12:18:17PM +0200, Michael S. Tsirkin wrote:
> > > > > My initial idea was to use a dedicated workqueue. Michael S. Tsirkin
> > > > > @@ -563,7 +534,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
> > > > >  	struct virtio_balloon *vb = vdev->priv;
> > > > >  
> > > > >  	unregister_oom_notifier(&vb->nb);
> > > > > -	kthread_stop(vb->thread);
> > > > > +	cancel_work_sync(&vb->wq_work);
> > > > 
> > > > OK but since job requeues itself, cancelling like this might not be enough.
> > > 
> > > As long as there's no further external queueing, cancel_work_sync() is
> > > guaranteed to kill a self-requeueing work item.
> > > 
> > > Thanks.
> > 
> > I didn't realise this. Thanks!
> > 
> > Unfortunately in this case, there can be further requeueing
> > if a stats request arrives.
> 
> Please, is there any point where the stat requests are disabled for
> sure? I am not 100% sure but it might be after the reset() call:
> 
>     vb->vdev->config->reset(vb->vdev);

Yes.

> Then we could split the kthread into two works: resizing and stats.
> The resizing work still must be canceled before leaking the balloon.
> But the stats work might be canceled after the reset() call.
> 
> In fact, the solution with the two works looks even cleaner.
> 
> 
> Thanks for feedback,
> Petr

I agree - in fact, not blocking stats call while inflate is blocked
would be very nice. As things then happen in parallel, we need to be
careful with locking and stuff.

That would be a good reason to switch to wq.

-- 
MST
