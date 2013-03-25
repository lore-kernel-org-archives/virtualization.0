From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V2 1/3] tcm_vhost: Wait for pending requests in
	vhost_scsi_flush()
Date: Mon, 25 Mar 2013 15:39:42 +0800
Message-ID: <20130325073942.GA20435@hj.localdomain>
References: <1363935329-11796-1-git-send-email-asias@redhat.com>
	<1363935329-11796-2-git-send-email-asias@redhat.com>
	<20130324151137.GA8657@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130324151137.GA8657@redhat.com>
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

On Sun, Mar 24, 2013 at 05:11:37PM +0200, Michael S. Tsirkin wrote:
> On Fri, Mar 22, 2013 at 02:55:27PM +0800, Asias He wrote:
> > This patch makes vhost_scsi_flush() wait for all the pending requests
> > issued before the flush operation to be finished.
> > 
> > Signed-off-by: Asias He <asias@redhat.com>
> > ---
> >  drivers/vhost/tcm_vhost.c | 117 ++++++++++++++++++++++++++++++++++++++--------
> >  drivers/vhost/tcm_vhost.h |   4 ++
> >  2 files changed, 101 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > index e734ead..dc0af52 100644
> > --- a/drivers/vhost/tcm_vhost.c
> > +++ b/drivers/vhost/tcm_vhost.c
> > @@ -82,6 +82,15 @@ struct vhost_scsi {
> >  
> >  	bool vs_events_dropped; /* any missed events, protected by dev.mutex */
> >  	u64 vs_events_nr; /* num of pending events, protected by dev.mutex */
> > +
> > +	/*
> > +	 * vs_inflight[0]/[1] are used to track requests issued
> > +	 * before/during the flush operation
> > +	 */
> > +	u64 vs_inflight[2];
> > +	wait_queue_head_t vs_flush_wait; /* wait queue for flush operation */
> > +	spinlock_t vs_flush_lock; /* lock to protect vs_during_flush */
> > +	int vs_during_flush; /* flag to indicate if we are in flush operation */
> 
> So this adds a spinlock on data path and I'm not sure
> I understand why this is correct (see also comment below).

vs_flush_lock is accessed in:

1) tcm_vhost_allocate_evt() and tcm_vhost_free_evt()
2) vhost_scsi_allocate_cmd() and vhost_scsi_free_cmd().

The former is not on data path. The later is always executed in the
vhost thread. So we can almost always take the lock with no contention.

And I am not seeing any real perf differences.

> And generally we should try to avoid reimplementing refcounting.  How
> about we use a kref pointer instead?  Access can use RCU (or maybe put
> it in vq->private and use the tricky vhost version of RCU).  Initialize
> it to 1.  To flush you replace the pointer, decrement then wait for
> refcount to reach 0.

This makes the code even more tricky and hard to understand. I am not
sure this is a place where kref is the right choice. 

> This still adds atomics on data path so maybe worth benchmarking to
> verify performance overhead is not measureable, but at least it's
> one atomic and not a full lock.
> Hmm?
> 
> 
> >  };
> >  
> >  /* Local pointer to allocated TCM configfs fabric module */
> > @@ -99,6 +108,46 @@ static int iov_num_pages(struct iovec *iov)
> >  	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
> >  }
> >  
> > +static int tcm_vhost_inc_inflight(struct vhost_scsi *vs)
> > +{
> > +	int during_flush;
> > +
> > +	spin_lock(&vs->vs_flush_lock);
> > +	during_flush = vs->vs_during_flush;
> > +	vs->vs_inflight[during_flush]++;
> > +	spin_unlock(&vs->vs_flush_lock);
> > +
> > +	return during_flush;
> > +}
> > +
> > +static void tcm_vhost_dec_inflight(struct vhost_scsi *vs, int during_flush)
> > +{
> > +	u64 inflight;
> > +
> > +	spin_lock(&vs->vs_flush_lock);
> > +	inflight = vs->vs_inflight[during_flush]--;
> > +	/*
> > +	 * Wakeup the waiter when all the requests issued before the flush
> > +	 * operation are finished and we are during the flush operation.
> > +	 */
> > +	if (!inflight && !during_flush && vs->vs_during_flush)
> > +		wake_up(&vs->vs_flush_wait);
> > +	spin_unlock(&vs->vs_flush_lock);
> > +}
> > +
> > +static bool tcm_vhost_done_inflight(struct vhost_scsi *vs)
> > +{
> > +	bool ret = false;
> > +
> > +	/* The requests issued before the flush operation are finished ? */
> > +	spin_lock(&vs->vs_flush_lock);
> > +	if (!vs->vs_inflight[0])
> > +		ret = true;
> > +	spin_unlock(&vs->vs_flush_lock);
> > +
> > +	return ret;
> > +}
> > +
> >  static bool tcm_vhost_check_feature(struct vhost_scsi *vs, int feature)
> >  {
> >  	bool ret = false;
> > @@ -391,6 +440,8 @@ static int tcm_vhost_queue_tm_rsp(struct se_cmd *se_cmd)
> >  
> >  static void tcm_vhost_free_evt(struct vhost_scsi *vs, struct tcm_vhost_evt *evt)
> >  {
> > +
> > +	tcm_vhost_dec_inflight(vs, evt->during_flush);
> >  	mutex_lock(&vs->dev.mutex);
> >  	vs->vs_events_nr--;
> >  	kfree(evt);
> > @@ -412,6 +463,7 @@ static struct tcm_vhost_evt *tcm_vhost_allocate_evt(struct vhost_scsi *vs,
> >  	if (evt) {
> >  		evt->event.event = event;
> >  		evt->event.reason = reason;
> > +		evt->during_flush = tcm_vhost_inc_inflight(vs);
> >  		vs->vs_events_nr++;
> >  	}
> >  	mutex_unlock(&vs->dev.mutex);
> > @@ -422,6 +474,7 @@ static struct tcm_vhost_evt *tcm_vhost_allocate_evt(struct vhost_scsi *vs,
> >  static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
> >  {
> >  	struct se_cmd *se_cmd = &tv_cmd->tvc_se_cmd;
> > +	struct vhost_scsi *vs = tv_cmd->tvc_vhost;
> >  
> >  	/* TODO locking against target/backend threads? */
> >  	transport_generic_free_cmd(se_cmd, 1);
> > @@ -434,13 +487,16 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
> >  		kfree(tv_cmd->tvc_sgl);
> >  	}
> >  
> > +	tcm_vhost_dec_inflight(vs, tv_cmd->during_flush);
> > +
> >  	kfree(tv_cmd);
> >  }
> >  
> >  static void tcm_vhost_do_evt_work(struct vhost_scsi *vs,
> > -	struct virtio_scsi_event *event)
> > +	struct tcm_vhost_evt *evt)
> >  {
> >  	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> > +	struct virtio_scsi_event *event = &evt->event;
> >  	struct virtio_scsi_event __user *eventp;
> >  	unsigned out, in;
> >  	int head, ret;
> > @@ -503,7 +559,7 @@ static void tcm_vhost_evt_work(struct vhost_work *work)
> >  	while (llnode) {
> >  		evt = llist_entry(llnode, struct tcm_vhost_evt, list);
> >  		llnode = llist_next(llnode);
> > -		tcm_vhost_do_evt_work(vs, &evt->event);
> > +		tcm_vhost_do_evt_work(vs, evt);
> >  		tcm_vhost_free_evt(vs, evt);
> >  	}
> >  }
> > @@ -521,8 +577,8 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
> >  	struct virtio_scsi_cmd_resp v_rsp;
> >  	struct tcm_vhost_cmd *tv_cmd;
> >  	struct llist_node *llnode;
> > -	struct se_cmd *se_cmd;
> >  	int ret, vq;
> > +	struct se_cmd *se_cmd;
> >  
> >  	bitmap_zero(signal, VHOST_SCSI_MAX_VQ);
> >  	llnode = llist_del_all(&vs->vs_completion_list);
> > @@ -560,6 +616,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
> >  }
> >  
> >  static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
> > +	struct vhost_scsi *vs,
> >  	struct tcm_vhost_tpg *tv_tpg,
> >  	struct virtio_scsi_cmd_req *v_req,
> >  	u32 exp_data_len,
> > @@ -584,6 +641,8 @@ static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
> >  	tv_cmd->tvc_exp_data_len = exp_data_len;
> >  	tv_cmd->tvc_data_direction = data_direction;
> >  	tv_cmd->tvc_nexus = tv_nexus;
> > +	tv_cmd->tvc_vhost = vs;
> > +	tv_cmd->during_flush = tcm_vhost_inc_inflight(vs);
> >  
> >  	return tv_cmd;
> >  }
> > @@ -824,7 +883,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
> >  		for (i = 0; i < data_num; i++)
> >  			exp_data_len += vq->iov[data_first + i].iov_len;
> >  
> > -		tv_cmd = vhost_scsi_allocate_cmd(tv_tpg, &v_req,
> > +		tv_cmd = vhost_scsi_allocate_cmd(vs, tv_tpg, &v_req,
> >  					exp_data_len, data_direction);
> >  		if (IS_ERR(tv_cmd)) {
> >  			vq_err(vq, "vhost_scsi_allocate_cmd failed %ld\n",
> > @@ -834,7 +893,6 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
> >  		pr_debug("Allocated tv_cmd: %p exp_data_len: %d, data_direction"
> >  			": %d\n", tv_cmd, exp_data_len, data_direction);
> >  
> > -		tv_cmd->tvc_vhost = vs;
> >  		tv_cmd->tvc_vq = vq;
> >  
> >  		if (unlikely(vq->iov[out].iov_len !=
> > @@ -887,6 +945,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
> >  		 * tcm_vhost_queue_data_in() and tcm_vhost_queue_status()
> >  		 */
> >  		tv_cmd->tvc_vq_desc = head;
> > +
> >  		/*
> >  		 * Dispatch tv_cmd descriptor for cmwq execution in process
> >  		 * context provided by tcm_vhost_workqueue.  This also ensures
> > @@ -956,6 +1015,34 @@ static void vhost_scsi_handle_kick(struct vhost_work *work)
> >  	vhost_scsi_handle_vq(vs, vq);
> >  }
> >  
> > +static void vhost_scsi_flush_vq(struct vhost_scsi *vs, int index)
> > +{
> > +	vhost_poll_flush(&vs->dev.vqs[index].poll);
> > +}
> > +
> > +static void vhost_scsi_flush(struct vhost_scsi *vs)
> > +{
> > +	int i;
> > +
> > +	/* Flush operation is started */
> > +	spin_lock(&vs->vs_flush_lock);
> > +	vs->vs_during_flush = 1;
> > +	spin_unlock(&vs->vs_flush_lock);
> > +
> > +	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
> > +		vhost_scsi_flush_vq(vs, i);
> > +	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
> > +	vhost_work_flush(&vs->dev, &vs->vs_event_work);
> > +
> > +	/* Wait until all requests issued before the flush to be finished */
> > +	wait_event(vs->vs_flush_wait, tcm_vhost_done_inflight(vs));
> > +
> > +	/* Flush operation is finished */
> > +	spin_lock(&vs->vs_flush_lock);
> > +	vs->vs_during_flush = 0;
> > +	spin_unlock(&vs->vs_flush_lock);
> > +}
> > +
> 
> Weird.
> What about requests issued during flush operation?
> When next flush starts shouldn't we flush them?
> 
> >  /*
> >   * Called from vhost_scsi_ioctl() context to walk the list of available
> >   * tcm_vhost_tpg with an active struct tcm_vhost_nexus
> > @@ -1042,6 +1129,7 @@ static int vhost_scsi_clear_endpoint(
> >  	u8 target;
> >  
> >  	mutex_lock(&vs->dev.mutex);
> > +
> >  	/* Verify that ring has been setup correctly. */
> >  	for (index = 0; index < vs->dev.nvqs; ++index) {
> >  		if (!vhost_vq_access_ok(&vs->vqs[index])) {
> > @@ -1109,6 +1197,10 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
> >  	vhost_work_init(&s->vs_event_work, tcm_vhost_evt_work);
> >  
> >  	s->vs_events_nr = 0;
> > +	s->vs_inflight[0] = 0;
> > +	s->vs_inflight[1] = 0;
> > +	spin_lock_init(&s->vs_flush_lock);
> > +	init_waitqueue_head(&s->vs_flush_wait);
> >  
> >  	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
> >  	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
> > @@ -1139,21 +1231,6 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
> >  	return 0;
> >  }
> >  
> > -static void vhost_scsi_flush_vq(struct vhost_scsi *vs, int index)
> > -{
> > -	vhost_poll_flush(&vs->dev.vqs[index].poll);
> > -}
> > -
> > -static void vhost_scsi_flush(struct vhost_scsi *vs)
> > -{
> > -	int i;
> > -
> > -	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
> > -		vhost_scsi_flush_vq(vs, i);
> > -	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
> > -	vhost_work_flush(&vs->dev, &vs->vs_event_work);
> > -}
> > -
> >  static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
> >  {
> >  	if (features & ~VHOST_SCSI_FEATURES)
> > diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
> > index 94e9ee53..dd84622 100644
> > --- a/drivers/vhost/tcm_vhost.h
> > +++ b/drivers/vhost/tcm_vhost.h
> > @@ -37,6 +37,8 @@ struct tcm_vhost_cmd {
> >  	unsigned char tvc_sense_buf[TRANSPORT_SENSE_BUFFER];
> >  	/* Completed commands list, serviced from vhost worker thread */
> >  	struct llist_node tvc_completion_list;
> > +	/* Indicate this command is issued during the flush operaton */
> > +	int during_flush;
> >  };
> >  
> >  struct tcm_vhost_nexus {
> > @@ -91,6 +93,8 @@ struct tcm_vhost_evt {
> >  	struct virtio_scsi_event event;
> >  	/* virtio_scsi event list, serviced from vhost worker thread */
> >  	struct llist_node list;
> > +	/* Indicate this event is issued during the flush operaton */
> > +	int during_flush;
> >  };
> >  
> >  /*
> > -- 
> > 1.8.1.4

-- 
Asias
