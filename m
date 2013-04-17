From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 2/2] tcm_vhost: Wait for pending requests in
	vhost_scsi_flush()
Date: Wed, 17 Apr 2013 13:07:56 +0300
Message-ID: <20130417100756.GE3881@redhat.com>
References: <1365823754-27730-1-git-send-email-asias@redhat.com>
	<1366103811-21887-3-git-send-email-asias@redhat.com>
	<20130416175827.GB2844@redhat.com>
	<20130417012953.GB27589@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130417012953.GB27589@hj.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 17, 2013 at 09:29:53AM +0800, Asias He wrote:
> On Tue, Apr 16, 2013 at 08:58:27PM +0300, Michael S. Tsirkin wrote:
> > On Tue, Apr 16, 2013 at 05:16:51PM +0800, Asias He wrote:
> > > This patch makes vhost_scsi_flush() wait for all the pending requests
> > > issued before the flush operation to be finished.
> > > 
> > > Changes in v5:
> > > - Use kref and completion
> > > - Fail req if vs->vs_inflight is NULL
> > > - Rename tcm_vhost_alloc_inflight to tcm_vhost_set_inflight
> > > 
> > > Changes in v4:
> > > - Introduce vhost_scsi_inflight
> > > - Drop array to track flush
> > > - Use RCU to protect vs_inflight explicitly
> > > 
> > > Changes in v3:
> > > - Rebase
> > > - Drop 'tcm_vhost: Wait for pending requests in
> > >   vhost_scsi_clear_endpoint()' in this series, we already did that in
> > >   'tcm_vhost: Use vq->private_data to indicate if the endpoint is setup'
> > > 
> > > Changes in v2:
> > > - Increase/Decrease inflight requests in
> > >   vhost_scsi_{allocate,free}_cmd and tcm_vhost_{allocate,free}_evt
> > > 
> > > Signed-off-by: Asias He <asias@redhat.com>
> > 
> > OK looks good, except error handling needs to be fixed.

Let me be more explicit here. There are two rules that this violates:
	an ioctl should either succeed and return code >= 0,
	or fail and return code < 0. In later case it should not
	have any effect.
		This patch instead leaves the device in a bad state
		on an OOM error.

	There should be 1 way to test started/stopped state,
	and that is backend != NULL.


So how to fix this? As I said, split up tcm_vhost_set_inflight.
Have tcm_vhost_init_inflight instead, to simply init counters
without alloc and the RCU things. Now in set features ioctl,
Do allocations that can fail before you change state.
Now set features and after a barrier set inflight.


> > > ---
> > >  drivers/vhost/tcm_vhost.c | 101 +++++++++++++++++++++++++++++++++++++++++++---
> > >  drivers/vhost/tcm_vhost.h |   5 +++
> > >  2 files changed, 101 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > > index 4ae6725..ef40a8f 100644
> > > --- a/drivers/vhost/tcm_vhost.c
> > > +++ b/drivers/vhost/tcm_vhost.c
> > > @@ -74,6 +74,11 @@ enum {
> > >  #define VHOST_SCSI_MAX_VQ	128
> > >  #define VHOST_SCSI_MAX_EVENT	128
> > >  
> > > +struct vhost_scsi_inflight {
> > > +	struct completion comp; /* Wait for the flush operation to finish */
> > > +	struct kref kref; /* Refcount for the inflight reqs */
> > > +};
> > > +
> > >  struct vhost_scsi {
> > >  	/* Protected by vhost_scsi->dev.mutex */
> > >  	struct tcm_vhost_tpg **vs_tpg;
> > > @@ -91,6 +96,8 @@ struct vhost_scsi {
> > >  	struct mutex vs_events_lock; /* protect vs_events_dropped,events_nr */
> > >  	bool vs_events_dropped; /* any missed events */
> > >  	int vs_events_nr; /* num of pending events */
> > > +
> > > +	struct vhost_scsi_inflight __rcu *vs_inflight; /* track inflight reqs */
> > >  };
> > >  
> > >  /* Local pointer to allocated TCM configfs fabric module */
> > > @@ -108,6 +115,51 @@ static int iov_num_pages(struct iovec *iov)
> > >  	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
> > >  }
> > >  
> > > +static int tcm_vhost_set_inflight(struct vhost_scsi *vs)
> > > +{
> > > +	struct vhost_scsi_inflight *inflight;
> > > +	int ret = -ENOMEM;
> > > +
> > > +	inflight = kzalloc(sizeof(*inflight), GFP_KERNEL);
> > 
> > kzalloc is not needed, you initialize all fields.
> 
> okay.
> 
> > > +	if (inflight) {
> > > +		kref_init(&inflight->kref);
> > > +		init_completion(&inflight->comp);
> > > +		ret = 0;
> > > +	}
> > > +	rcu_assign_pointer(vs->vs_inflight, inflight);
> > 
> > So if allocation fails, we stop tracking inflights?
> >
> > This looks strange, and could break guests. Why not the usual
> > 	if (!inflight)
> > 		return -ENOMEM;
> 
> If allocation fails, we abort further reqs.
> No need to track.
> Why it will break guest and how?

Well if not commands succeed presumably storage does not work?
Also need to add a comment about this hack.

But isn't failing the ioctl cleaner?
There will be less code on data path and less tricks.

> > > +	synchronize_rcu();
> > 
> > open call is different:
> > 	- sync is not needed
> > 	- should use RCU_INIT_POINTER and not rcu_assign_pointer
> > 
> > So please move these out and make this function return the struct:
> > 	struct vhost_scsi_inflight *inflight
> > 	tcm_vhost_alloc_inflight(void)
> 
> synchronize_rcu is actually needed. 

It's not needed for open: there's no old inflight there.

>    tcm_vhost_inc_inflight
>    {
>    
>            rcu_read_lock();
>            inflight = rcu_dereference(vs->vs_inflight);         
>    
>           /* 
>    	   * Possible race window here:
>            * if inflight points to old inflight and
>            * wait_for_completion runs before we call kref_get here,
>            * We may free the old inflight
>            * however, there is still one in flight which should be 
>            * tracked by the old inflight.
>    	   */
>    
>            kref_get(&inflight->kref);
>            rcu_read_unlock();
>    
>            return inflight;
>    }


By the way I see a bug. vhost_scsi_set_features does smp_wmb
and that is not paired with anything. I think we need to pair
it with an rmb before get_inflight and add a comment
about pairing in both places.

> > 
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static struct vhost_scsi_inflight *
> > > +tcm_vhost_inc_inflight(struct vhost_scsi *vs)
> > 
> > And then inc will not need to return inflight pointer,
> > which is really unusual.
> 
> No you still need to return inflight. You need it for each tcm_vhost_cmd or
> tcm_vhost_evt. 

That's true. But it's a strange thing to do on increment.
Please rename inc to get and dec to put to make this
clear.

> > > +{
> > > +	struct vhost_scsi_inflight *inflight;
> > > +
> > > +	rcu_read_lock();
> > > +	inflight = rcu_dereference(vs->vs_inflight);
> > > +	if (inflight)
> > > +		kref_get(&inflight->kref);
> > > +	rcu_read_unlock();
> > > +
> > > +	return inflight;
> > > +}
> > > +
> > > +void tcm_vhost_done_inflight(struct kref *kref)
> > > +{
> > > +	struct vhost_scsi_inflight *inflight;
> > > +
> > > +	inflight = container_of(kref, struct vhost_scsi_inflight, kref);
> > > +	complete(&inflight->comp);
> > > +}
> > > +
> > > +static void tcm_vhost_dec_inflight(struct vhost_scsi_inflight *inflight)
> > > +{
> > > +	if (inflight)
> > 
> > Here as in other places, inflight must never be NULL.
> > Pls fix code so that invariant holds.
> > 
> > > +		kref_put(&inflight->kref, tcm_vhost_done_inflight);
> > > +}
> > > +
> > >  static bool tcm_vhost_check_feature(struct vhost_scsi *vs, int feature)
> > >  {
> > >  	bool ret = false;
> > > @@ -402,6 +454,7 @@ static int tcm_vhost_queue_tm_rsp(struct se_cmd *se_cmd)
> > >  static void tcm_vhost_free_evt(struct vhost_scsi *vs, struct tcm_vhost_evt *evt)
> > >  {
> > >  	mutex_lock(&vs->vs_events_lock);
> > > +	tcm_vhost_dec_inflight(evt->inflight);
> > >  	vs->vs_events_nr--;
> > >  	kfree(evt);
> > >  	mutex_unlock(&vs->vs_events_lock);
> > > @@ -413,21 +466,27 @@ static struct tcm_vhost_evt *tcm_vhost_allocate_evt(struct vhost_scsi *vs,
> > >  	struct tcm_vhost_evt *evt;
> > >  
> > >  	mutex_lock(&vs->vs_events_lock);
> > > -	if (vs->vs_events_nr > VHOST_SCSI_MAX_EVENT) {
> > > -		vs->vs_events_dropped = true;
> > > -		mutex_unlock(&vs->vs_events_lock);
> > > -		return NULL;
> > > -	}
> > > +	if (vs->vs_events_nr > VHOST_SCSI_MAX_EVENT)
> > > +		goto out;
> > >  
> > >  	evt = kzalloc(sizeof(*evt), GFP_KERNEL);
> > 
> > BTW it looks like we should replace this kzalloc with kmalloc.
> > Should be a separate patch ...
> 
> This belongs to the hotplug series. I will add to it.
>  
> > >  	if (evt) {
> > >  		evt->event.event = event;
> > >  		evt->event.reason = reason;
> > > +		evt->inflight = tcm_vhost_inc_inflight(vs);
> > > +		if (!evt->inflight) {
> > 
> > We drop an event because earlier
> > we run out of memory for allocating the inflight counter.
> > Does not make sense to me.
> 
> This tries to abort further reqs if we fail to allocate inflight.

Yes, it prevents a crash, but it's better to tell the user that
something's wrong.

> > > +			kfree(evt);
> > > +			goto out;
> > > +		}
> > >  		vs->vs_events_nr++;
> > >  	}
> > >  	mutex_unlock(&vs->vs_events_lock);
> > >  
> > >  	return evt;
> > > +out:
> > > +	vs->vs_events_dropped = true;
> > > +	mutex_unlock(&vs->vs_events_lock);
> > > +	return NULL;
> > >  }
> > >  
> > >  static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
> > > @@ -445,6 +504,8 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
> > >  		kfree(tv_cmd->tvc_sgl);
> > >  	}
> > >  
> > > +	tcm_vhost_dec_inflight(tv_cmd->inflight);
> > > +
> > >  	kfree(tv_cmd);
> > >  }
> > >  
> > > @@ -595,6 +656,9 @@ static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
> > >  	tv_cmd->tvc_data_direction = data_direction;
> > >  	tv_cmd->tvc_nexus = tv_nexus;
> > >  	tv_cmd->tvc_vhost = vs;
> > > +	tv_cmd->inflight = tcm_vhost_inc_inflight(vs);
> > > +	if (!tv_cmd->inflight)
> > > +		return ERR_PTR(-ENOMEM);
> > >  
> > >  	return tv_cmd;
> > >  }
> > > @@ -982,12 +1046,35 @@ static void vhost_scsi_flush_vq(struct vhost_scsi *vs, int index)
> > >  
> > >  static void vhost_scsi_flush(struct vhost_scsi *vs)
> > >  {
> > > +	struct vhost_scsi_inflight *inflight;
> > >  	int i;
> > >  
> > > +	/* inflight points to the old inflight */
> > > +	inflight = rcu_dereference_protected(vs->vs_inflight,
> > > +					     lockdep_is_held(&vs->dev.mutex));
> > > +
> > > +	/* Allocate a new inflight and make vs->vs_inflight points to it */
> > > +	if (tcm_vhost_set_inflight(vs) < 0)
> > > +		pr_warn("vhost_scsi_flush failed to allocate inflight\n");
> > 
> > That's unlikely to reach the application. How about we stop here,
> > and propagate the error to ioctl caller?
> 
> What user application can do in this case. Especially, the vhost_scsi_flush
> fails when user tries to shutdown the guest.

I am not sure why you walk about close. Only thing calling flush
at the moment is set features ioctl.

But let's assume you have another patch that calls flush
on close. Then this is a bug: close should not try to allocate
memory.  On close, we really should just set private data to NULL.
Then we know no new requests will be submitted.
No need to change inflight at all.

> What we are doing now is safer than just stops here. Because
> 1) we still flush all the existing reqs 
> 2) Further reqs will be aborted.


Stop really should stop processing new requests, not cancel them.  If
you cancel on close, we will not be able to stop kernel and then restart
without errors.

> > > +
> > > +	/*
> > > +	 * The inflight->kref was initialized to 1. We decrement it here to
> > > +	 * indicate the start of the flush operation so that it will reach 0
> > > +	 * when all the reqs are finished.
> > > +	 */
> > > +	kref_put(&inflight->kref, tcm_vhost_done_inflight);
> > > +
> > > +	/* Flush both the vhost poll and vhost work */
> > >  	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
> > >  		vhost_scsi_flush_vq(vs, i);
> > >  	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
> > >  	vhost_work_flush(&vs->dev, &vs->vs_event_work);
> > > +
> > > +	/* Wait for all reqs issued before the flush to be finished */
> > > +	if (inflight) {
> > 
> > inflight should never be NULL, otherwise inflight
> > tracjing is not effective. Please fix error handling so we
> > never reach here with inflight == NULL.
> 
> It is effective. We abort the req if we can not track it.

Yes. But that's guest visible, isn't it?

> > > +		wait_for_completion(&inflight->comp);
> > > +		kfree(inflight);
> > > +	}
> > >  }
> > >  
> > >  /*
> > > @@ -1196,6 +1283,9 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
> > >  	s->vs_events_dropped = false;
> > >  	mutex_init(&s->vs_events_lock);
> > >  
> > > +	if (tcm_vhost_set_inflight(s) < 0)
> > > +		return -ENOMEM;
> > > +
> > 
> > Better propagate the return code to user.
> 
> We are returning -ENOMEM to user, no?

I mean if you call a function that returns 0 or errno,
you should do
r = tcm_vhost_set_inflight
if (r)
	return r;

then it's easier to add more error codes in
tcm_vhost_set_inflight if needed.

However this was a general comment, I think tcm_vhost_set_inflight
should be split up so it won't return int.

> > >  	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
> > >  	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
> > >  	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++)
> > > @@ -1221,6 +1311,7 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
> > >  	vhost_scsi_clear_endpoint(s, &t);
> > >  	vhost_dev_stop(&s->dev);
> > >  	vhost_dev_cleanup(&s->dev, false);
> > > +	kfree(s->vs_inflight);
> > >  	kfree(s);
> > >  	return 0;
> > >  }
> > > diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
> > > index 94e9ee53..7567767 100644
> > > --- a/drivers/vhost/tcm_vhost.h
> > > +++ b/drivers/vhost/tcm_vhost.h
> > > @@ -2,6 +2,7 @@
> > >  #define TCM_VHOST_NAMELEN 256
> > >  #define TCM_VHOST_MAX_CDB_SIZE 32
> > >  
> > > +struct vhost_scsi_inflight;
> > >  struct tcm_vhost_cmd {
> > >  	/* Descriptor from vhost_get_vq_desc() for virt_queue segment */
> > >  	int tvc_vq_desc;
> > > @@ -37,6 +38,8 @@ struct tcm_vhost_cmd {
> > >  	unsigned char tvc_sense_buf[TRANSPORT_SENSE_BUFFER];
> > >  	/* Completed commands list, serviced from vhost worker thread */
> > >  	struct llist_node tvc_completion_list;
> > > +	/* Used to track inflight req */
> > > +	struct vhost_scsi_inflight *inflight;
> > >  };
> > >  
> > >  struct tcm_vhost_nexus {
> > > @@ -91,6 +94,8 @@ struct tcm_vhost_evt {
> > >  	struct virtio_scsi_event event;
> > >  	/* virtio_scsi event list, serviced from vhost worker thread */
> > >  	struct llist_node list;
> > > +	/* Used to track inflight req */
> > > +	struct vhost_scsi_inflight *inflight;
> > >  };
> > >  
> > >  /*
> > > -- 
> > > 1.8.1.4
> 
> -- 
> Asias
