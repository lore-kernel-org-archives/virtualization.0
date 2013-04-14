From: Asias He <asias@redhat.com>
Subject: Re: [PATCH] tcm_vhost: Wait for pending requests in vhost_scsi_flush()
Date: Sun, 14 Apr 2013 20:38:08 +0800
Message-ID: <20130414123808.GB7310@hj.localdomain>
References: <1365500383-10421-1-git-send-email-asias@redhat.com>
	<20130411104721.GA21922@redhat.com>
	<20130412062522.GB28500@hj.localdomain>
	<20130412113331.GD23467@redhat.com>
	<20130412145951.GA18372@hj.localdomain>
	<20130414100750.GD2548@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130414100750.GD2548@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Apr 14, 2013 at 01:07:51PM +0300, Michael S. Tsirkin wrote:
> On Fri, Apr 12, 2013 at 10:59:51PM +0800, Asias He wrote:
> > On Fri, Apr 12, 2013 at 02:33:32PM +0300, Michael S. Tsirkin wrote:
> > > On Fri, Apr 12, 2013 at 02:25:23PM +0800, Asias He wrote:
> > > > On Thu, Apr 11, 2013 at 01:47:21PM +0300, Michael S. Tsirkin wrote:
> > > > > On Tue, Apr 09, 2013 at 05:39:43PM +0800, Asias He wrote:
> > > > > > This patch makes vhost_scsi_flush() wait for all the pending requests
> > > > > > issued before the flush operation to be finished.
> > > > > > 
> > > > > > Changes in v3:
> > > > > > - Rebase
> > > > > > - Drop 'tcm_vhost: Wait for pending requests in
> > > > > >   vhost_scsi_clear_endpoint()' in this series, we already did that in
> > > > > >   'tcm_vhost: Use vq->private_data to indicate if the endpoint is setup'
> > > > > > 
> > > > > > Changes in v2:
> > > > > > - Increase/Decrease inflight requests in
> > > > > >   vhost_scsi_{allocate,free}_cmd and tcm_vhost_{allocate,free}_evt
> > > > > > 
> > > > > > Signed-off-by: Asias He <asias@redhat.com>
> > > > > 
> > > > > Nack, let's not do this home-grown here.  Please use a kref.
> > > > > 
> > > > > The array of two trick is also too tricky for my taste.
> > > > > 
> > > > > Please replace during_flush in tcm_vhost_cmd and tcm_vhost_evt
> > > > > by a kref pointer, allocate a new kref when you flush.
> > > > > 
> > > > > Access can be done with RCU so we won't need any locks.
> > > > 
> > > > I do not think kref helps and the right place to use here. Also, a
> > > > pointer kref in tcm_vhost_cmd and tcm_vhost_evt is not enough, you need
> > > > a wait queue as well.
> > > > 
> > > > Do you mean something as so:
> > > > 
> > > >    struct vhost_scsi_inflight {
> > > >    	struct kref kref;
> > > >    	wait_queue_head_t wait;
> > > >    }
> > > >    
> > > >    vhost_scsi_allocate_cmd()
> > > >    	rcu_read_lock()
> > > >    	tv_cmd->inflight = rcu_dereference(vs->vs_inflight)
> > > >    	kref_get(&tv_cmd->inflight->kref)
> > > >    	rcu_read_unlock()
> > > >    
> > > >    vhost_scsi_free_cmd()
> > > >    	kref_put(&tv_cmd->inflight.kref, my_release)
> > > >    
> > > >    my_release()
> > > >    	wake_up(&inflight->wait)
> > > >    
> > > >    vhost_scsi_flush()
> > > >    	old_inflight = vs->vs_inflight;
> > > >    	new_inflight = kmalloc(*new_inflight, ...)
> > > >    	rcu_assign_pointer(vs->vs_inflight, new_inflight);
> > > >    	wait_event(old_inflight->wait, atomic_read(&old_inflight->kref->refcount) == 0)
> > > >    	synchronize_rcu();
> > > >    	free(old_inflight)
> > > > 
> > > > 1) The kref need to be accessed in the free cmd/evt function, you can not use
> > > > rcu to protect it.
> > > 
> > > No, it's vs_inflight pointer that is protected by RCU.
> > > But if you prefer, we can have it per-vq and
> > > protected by vq mutex.
> > 
> > No, for event, it can be allocated outside the vhost thread. And vs_inflight
> > is not a per queue data why make it per queue.
> 
> For multiqueue, to avoid cache-line contention when multiple threads try
> to increment the same atomic value.

In each queue, you still point to the same inflight data. Unless you put
the inflight data itself per queue.

> > > 
> > > > 2) No need to use synchronize_rcu to wait for the reader of
> > > > vs->vs_inflight to finish. We need to wait on the wait queue anyway. At
> > > > time time, we are safe to free the old_inflight.
> > > 
> > > RCU is to avoid old vhost_scsi_allocate_cmd from using
> > > the old pointer. But we can use vq flush instead, that's
> > > often done in vhost.
> > 
> > > > 3) The kref is not used in a standard way. We are refcounting the evt
> > > > and cmd, not the vhost_scsi_inflight. A single is atomic conter is
> > > > enough.
> > > 
> > > Looks standard to me.
> > 
> > Strange ...
> > 
> > > > Though, I do not like the array trick too. I can change to allocate
> > > > vhost_scsi_inflight when we flush.
> > > 
> > > That's better but homegrown refcounting is better avoided too.
> > 
> > I had a version which dropped the array.
> 
> Right, that's better, except it triggers wakeups each time the queue
> becomes empty. Which is not really necessary as long as you don't flush.
> Instead init to 1, and decrement before flush.

Well, this is one way to optimize it. Another way might be adding a flag
explicitly in vhost_scsi_inflight to indicate it.

> Commented on the patch itself in a separate thread.

Thanks.

> -- 
> MST

-- 
Asias
