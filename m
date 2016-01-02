From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 2/2] virtio_balloon: Use a workqueue instead of
	"vballoon" kthread
Date: Sat, 2 Jan 2016 06:43:16 -0500
Message-ID: <20160102114316.GC3660@htj.duckdns.org>
References: <1449236271-10133-1-git-send-email-pmladek@suse.com>
	<1449236271-10133-3-git-send-email-pmladek@suse.com>
	<20160101121432-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160101121432-mutt-send-email-mst@redhat.com>
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
Cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.cz>, virtualization@lists.linux-foundation.org, Jeff Epler <jepler@unpythonic.net>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

On Fri, Jan 01, 2016 at 12:18:17PM +0200, Michael S. Tsirkin wrote:
> > My initial idea was to use a dedicated workqueue. Michael S. Tsirkin
> > suggested using a system one. Tejun Heo confirmed that the system
> > workqueue has a pretty high concurrency level (256) by default.
> > Therefore we need not be afraid of too long blocking.
> 
> Right but fill has a 1/5 second sleep on failure - *that*
> is problematic for a system queue.

Why so?  As long as the maximum concurrently used workers are not
high, 1/5 second or even a lot longer sleeps are completely fine.

> > @@ -563,7 +534,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
> >  	struct virtio_balloon *vb = vdev->priv;
> >  
> >  	unregister_oom_notifier(&vb->nb);
> > -	kthread_stop(vb->thread);
> > +	cancel_work_sync(&vb->wq_work);
> 
> OK but since job requeues itself, cancelling like this might not be enough.

As long as there's no further external queueing, cancel_work_sync() is
guaranteed to kill a self-requeueing work item.

Thanks.

-- 
tejun
