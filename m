From: Asias He <asias@redhat.com>
Subject: Re: [PATCH] tcm_vhost: Wait for pending requests in vhost_scsi_flush()
Date: Fri, 12 Apr 2013 22:59:51 +0800
Message-ID: <20130412145951.GA18372@hj.localdomain>
References: <1365500383-10421-1-git-send-email-asias@redhat.com>
	<20130411104721.GA21922@redhat.com>
	<20130412062522.GB28500@hj.localdomain>
	<20130412113331.GD23467@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130412113331.GD23467@redhat.com>
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

On Fri, Apr 12, 2013 at 02:33:32PM +0300, Michael S. Tsirkin wrote:
> On Fri, Apr 12, 2013 at 02:25:23PM +0800, Asias He wrote:
> > On Thu, Apr 11, 2013 at 01:47:21PM +0300, Michael S. Tsirkin wrote:
> > > On Tue, Apr 09, 2013 at 05:39:43PM +0800, Asias He wrote:
> > > > This patch makes vhost_scsi_flush() wait for all the pending requests
> > > > issued before the flush operation to be finished.
> > > > 
> > > > Changes in v3:
> > > > - Rebase
> > > > - Drop 'tcm_vhost: Wait for pending requests in
> > > >   vhost_scsi_clear_endpoint()' in this series, we already did that in
> > > >   'tcm_vhost: Use vq->private_data to indicate if the endpoint is setup'
> > > > 
> > > > Changes in v2:
> > > > - Increase/Decrease inflight requests in
> > > >   vhost_scsi_{allocate,free}_cmd and tcm_vhost_{allocate,free}_evt
> > > > 
> > > > Signed-off-by: Asias He <asias@redhat.com>
> > > 
> > > Nack, let's not do this home-grown here.  Please use a kref.
> > > 
> > > The array of two trick is also too tricky for my taste.
> > > 
> > > Please replace during_flush in tcm_vhost_cmd and tcm_vhost_evt
> > > by a kref pointer, allocate a new kref when you flush.
> > > 
> > > Access can be done with RCU so we won't need any locks.
> > 
> > I do not think kref helps and the right place to use here. Also, a
> > pointer kref in tcm_vhost_cmd and tcm_vhost_evt is not enough, you need
> > a wait queue as well.
> > 
> > Do you mean something as so:
> > 
> >    struct vhost_scsi_inflight {
> >    	struct kref kref;
> >    	wait_queue_head_t wait;
> >    }
> >    
> >    vhost_scsi_allocate_cmd()
> >    	rcu_read_lock()
> >    	tv_cmd->inflight = rcu_dereference(vs->vs_inflight)
> >    	kref_get(&tv_cmd->inflight->kref)
> >    	rcu_read_unlock()
> >    
> >    vhost_scsi_free_cmd()
> >    	kref_put(&tv_cmd->inflight.kref, my_release)
> >    
> >    my_release()
> >    	wake_up(&inflight->wait)
> >    
> >    vhost_scsi_flush()
> >    	old_inflight = vs->vs_inflight;
> >    	new_inflight = kmalloc(*new_inflight, ...)
> >    	rcu_assign_pointer(vs->vs_inflight, new_inflight);
> >    	wait_event(old_inflight->wait, atomic_read(&old_inflight->kref->refcount) == 0)
> >    	synchronize_rcu();
> >    	free(old_inflight)
> > 
> > 1) The kref need to be accessed in the free cmd/evt function, you can not use
> > rcu to protect it.
> 
> No, it's vs_inflight pointer that is protected by RCU.
> But if you prefer, we can have it per-vq and
> protected by vq mutex.

No, for event, it can be allocated outside the vhost thread. And vs_inflight
is not a per queue data why make it per queue.

> 
> > 2) No need to use synchronize_rcu to wait for the reader of
> > vs->vs_inflight to finish. We need to wait on the wait queue anyway. At
> > time time, we are safe to free the old_inflight.
> 
> RCU is to avoid old vhost_scsi_allocate_cmd from using
> the old pointer. But we can use vq flush instead, that's
> often done in vhost.

> > 3) The kref is not used in a standard way. We are refcounting the evt
> > and cmd, not the vhost_scsi_inflight. A single is atomic conter is
> > enough.
> 
> Looks standard to me.

Strange ...

> > Though, I do not like the array trick too. I can change to allocate
> > vhost_scsi_inflight when we flush.
> 
> That's better but homegrown refcounting is better avoided too.

I had a version which dropped the array.

From e542981a69b1088c7a170bf8e9c6e9d4df897ca4 Mon Sep 17 00:00:00 2001
From: Asias He <asias@redhat.com>
Date: Mon, 11 Mar 2013 10:57:32 +0800
Subject: [PATCH] tcm_vhost: Wait for pending requests in
 vhost_scsi_flush()

This patch makes vhost_scsi_flush() wait for all the pending requests
issued before the flush operation to be finished.

Changes in v4:
- Introduce vhost_scsi_inflight
- Drop array to track flush

Changes in v3:
- Rebase
- Drop 'tcm_vhost: Wait for pending requests in
  vhost_scsi_clear_endpoint()' in this series, we already did that in
  'tcm_vhost: Use vq->private_data to indicate if the endpoint is setup'

Changes in v2:
- Increase/Decrease inflight requests in
  vhost_scsi_{allocate,free}_cmd and tcm_vhost_{allocate,free}_evt

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 81 ++++++++++++++++++++++++++++++++++++++++++++---
 drivers/vhost/tcm_vhost.h |  3 ++
 2 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index c425605..40e2809 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -74,6 +74,11 @@ enum {
 #define VHOST_SCSI_MAX_VQ	128
 #define VHOST_SCSI_MAX_EVENT	128
 
+struct vhost_scsi_inflight {
+	atomic_t count;
+	wait_queue_head_t wait;
+};
+
 struct vhost_scsi {
 	/* Protected by vhost_scsi->dev.mutex */
 	struct tcm_vhost_tpg **vs_tpg;
@@ -91,6 +96,7 @@ struct vhost_scsi {
 	struct mutex vs_events_lock; /* protect vs_events_dropped,events_nr */
 	bool vs_events_dropped; /* any missed events */
 	int vs_events_nr; /* num of pending events */
+	struct vhost_scsi_inflight *vs_inflight;
 };
 
 /* Local pointer to allocated TCM configfs fabric module */
@@ -108,6 +114,51 @@ static int iov_num_pages(struct iovec *iov)
 	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
 }
 
+static struct vhost_scsi_inflight *tcm_vhost_alloc_inflight(struct vhost_scsi *vs)
+{
+	struct vhost_scsi_inflight *inflight;
+
+	inflight = kzalloc(sizeof(*inflight), GFP_KERNEL);
+	if (!inflight) {
+		/* Otherwize, we get dobule free of the previous inflight */
+		vs->vs_inflight = NULL;
+		return NULL;
+	}
+	atomic_set(&inflight->count, 0);
+	init_waitqueue_head(&inflight->wait);
+	vs->vs_inflight = inflight;
+
+	return inflight;
+}
+
+static void tcm_vhost_dec_inflight(struct vhost_scsi_inflight *inflight)
+{
+	/*
+	 * Wakeup the waiter when all the requests issued before the flush
+	 * operation are finished and we are during the flush operation.
+	 */
+	if (inflight && !atomic_dec_return(&inflight->count))
+		wake_up(&inflight->wait);
+}
+
+static struct vhost_scsi_inflight *tcm_vhost_inc_inflight(struct vhost_scsi *vs)
+{
+	struct vhost_scsi_inflight *inflight = ACCESS_ONCE(vs->vs_inflight);
+	/* FIXME: possible race window here, if inflight points to old value
+	 * before we set the new value in _flush, and the wait_event() runs
+	 * before we call atomic_inc(), this way we may free old_inflight
+	 * however, but there is still one in flight*/
+	if (inflight)
+		atomic_inc(&inflight->count);
+
+	return inflight;
+}
+
+static bool tcm_vhost_done_inflight(struct vhost_scsi_inflight *inflight)
+{
+	return atomic_read(&inflight->count) == 0;
+}
+
 static bool tcm_vhost_check_feature(struct vhost_scsi *vs, int feature)
 {
 	bool ret = false;
@@ -402,6 +453,7 @@ static int tcm_vhost_queue_tm_rsp(struct se_cmd *se_cmd)
 static void tcm_vhost_free_evt(struct vhost_scsi *vs, struct tcm_vhost_evt *evt)
 {
 	mutex_lock(&vs->vs_events_lock);
+	tcm_vhost_dec_inflight(evt->inflight);
 	vs->vs_events_nr--;
 	kfree(evt);
 	mutex_unlock(&vs->vs_events_lock);
@@ -423,6 +475,7 @@ static struct tcm_vhost_evt *tcm_vhost_allocate_evt(struct vhost_scsi *vs,
 	if (evt) {
 		evt->event.event = event;
 		evt->event.reason = reason;
+		evt->inflight = tcm_vhost_inc_inflight(vs);
 		vs->vs_events_nr++;
 	}
 	mutex_unlock(&vs->vs_events_lock);
@@ -445,13 +498,16 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
 		kfree(tv_cmd->tvc_sgl);
 	}
 
+	tcm_vhost_dec_inflight(tv_cmd->inflight);
+
 	kfree(tv_cmd);
 }
 
 static void tcm_vhost_do_evt_work(struct vhost_scsi *vs,
-	struct virtio_scsi_event *event)
+	struct tcm_vhost_evt *evt)
 {
 	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
+	struct virtio_scsi_event *event = &evt->event;
 	struct virtio_scsi_event __user *eventp;
 	unsigned out, in;
 	int head, ret;
@@ -511,7 +567,7 @@ static void tcm_vhost_evt_work(struct vhost_work *work)
 	while (llnode) {
 		evt = llist_entry(llnode, struct tcm_vhost_evt, list);
 		llnode = llist_next(llnode);
-		tcm_vhost_do_evt_work(vs, &evt->event);
+		tcm_vhost_do_evt_work(vs, evt);
 		tcm_vhost_free_evt(vs, evt);
 	}
 }
@@ -568,6 +624,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 }
 
 static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
+	struct vhost_scsi *vs,
 	struct tcm_vhost_tpg *tv_tpg,
 	struct virtio_scsi_cmd_req *v_req,
 	u32 exp_data_len,
@@ -592,6 +649,8 @@ static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
 	tv_cmd->tvc_exp_data_len = exp_data_len;
 	tv_cmd->tvc_data_direction = data_direction;
 	tv_cmd->tvc_nexus = tv_nexus;
+	tv_cmd->tvc_vhost = vs;
+	tv_cmd->inflight = tcm_vhost_inc_inflight(vs);
 
 	return tv_cmd;
 }
@@ -847,7 +906,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 		for (i = 0; i < data_num; i++)
 			exp_data_len += vq->iov[data_first + i].iov_len;
 
-		tv_cmd = vhost_scsi_allocate_cmd(tv_tpg, &v_req,
+		tv_cmd = vhost_scsi_allocate_cmd(vs, tv_tpg, &v_req,
 					exp_data_len, data_direction);
 		if (IS_ERR(tv_cmd)) {
 			vq_err(vq, "vhost_scsi_allocate_cmd failed %ld\n",
@@ -857,7 +916,6 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 		pr_debug("Allocated tv_cmd: %p exp_data_len: %d, data_direction"
 			": %d\n", tv_cmd, exp_data_len, data_direction);
 
-		tv_cmd->tvc_vhost = vs;
 		tv_cmd->tvc_vq = vq;
 		tv_cmd->tvc_resp = vq->iov[out].iov_base;
 
@@ -981,10 +1039,21 @@ static void vhost_scsi_flush_vq(struct vhost_scsi *vs, int index)
 static void vhost_scsi_flush(struct vhost_scsi *vs)
 {
 	int i;
+	struct vhost_scsi_inflight *old_inflight;
+
+	old_inflight = ACCESS_ONCE(vs->vs_inflight);
+	if (!tcm_vhost_alloc_inflight(vs))
+		return;
 
 	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
 		vhost_scsi_flush_vq(vs, i);
 	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
+	vhost_work_flush(&vs->dev, &vs->vs_event_work);
+
+	/* Wait until all requests issued before the flush to be finished */
+	wait_event(old_inflight->wait, tcm_vhost_done_inflight(old_inflight));
+
+	kfree(old_inflight);
 }
 
 /*
@@ -1193,6 +1262,9 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	s->vs_events_dropped = false;
 	mutex_init(&s->vs_events_lock);
 
+	if(!tcm_vhost_alloc_inflight(s))
+		return -ENOMEM;
+
 	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
 	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
 	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++)
@@ -1218,6 +1290,7 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
 	vhost_scsi_clear_endpoint(s, &t);
 	vhost_dev_stop(&s->dev);
 	vhost_dev_cleanup(&s->dev, false);
+	kfree(s->vs_inflight);
 	kfree(s);
 	return 0;
 }
diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
index 94e9ee53..c36ef5f 100644
--- a/drivers/vhost/tcm_vhost.h
+++ b/drivers/vhost/tcm_vhost.h
@@ -2,6 +2,7 @@
 #define TCM_VHOST_NAMELEN 256
 #define TCM_VHOST_MAX_CDB_SIZE 32
 
+struct vhost_scsi_inflight;
 struct tcm_vhost_cmd {
 	/* Descriptor from vhost_get_vq_desc() for virt_queue segment */
 	int tvc_vq_desc;
@@ -37,6 +38,7 @@ struct tcm_vhost_cmd {
 	unsigned char tvc_sense_buf[TRANSPORT_SENSE_BUFFER];
 	/* Completed commands list, serviced from vhost worker thread */
 	struct llist_node tvc_completion_list;
+	struct vhost_scsi_inflight *inflight;
 };
 
 struct tcm_vhost_nexus {
@@ -91,6 +93,7 @@ struct tcm_vhost_evt {
 	struct virtio_scsi_event event;
 	/* virtio_scsi event list, serviced from vhost worker thread */
 	struct llist_node list;
+	struct vhost_scsi_inflight *inflight;
 };
 
 /*
-- 
1.8.1.4

> 
> > > > ---
> > > >  drivers/vhost/tcm_vhost.c | 88 ++++++++++++++++++++++++++++++++++++++++++++---
> > > >  drivers/vhost/tcm_vhost.h |  4 +++
> > > >  2 files changed, 87 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > > > index 1f9116c..719ce13 100644
> > > > --- a/drivers/vhost/tcm_vhost.c
> > > > +++ b/drivers/vhost/tcm_vhost.c
> > > > @@ -91,6 +91,15 @@ struct vhost_scsi {
> > > >  	struct mutex vs_events_lock; /* protect vs_events_dropped,events_nr */
> > > >  	bool vs_events_dropped; /* any missed events */
> > > >  	int vs_events_nr; /* num of pending events */
> > > > +
> > > > +	/*
> > > > +	 * vs_inflight[0]/[1] are used to track requests issued
> > > > +	 * before/during the flush operation
> > > > +	 */
> > > > +	u64 vs_inflight[2];
> > > > +	wait_queue_head_t vs_flush_wait; /* wait queue for flush operation */
> > > > +	spinlock_t vs_flush_lock; /* lock to protect vs_during_flush */
> > > > +	int vs_during_flush; /* flag to indicate if we are in flush operation */
> > > >  };
> > > >  
> > > >  /* Local pointer to allocated TCM configfs fabric module */
> > > > @@ -108,6 +117,46 @@ static int iov_num_pages(struct iovec *iov)
> > > >  	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
> > > >  }
> > > >  
> > > > +static int tcm_vhost_inc_inflight(struct vhost_scsi *vs)
> > > > +{
> > > > +	int during_flush;
> > > > +
> > > > +	spin_lock(&vs->vs_flush_lock);
> > > > +	during_flush = vs->vs_during_flush;
> > > > +	vs->vs_inflight[during_flush]++;
> > > > +	spin_unlock(&vs->vs_flush_lock);
> > > > +
> > > > +	return during_flush;
> > > > +}
> > > > +
> > > > +static void tcm_vhost_dec_inflight(struct vhost_scsi *vs, int during_flush)
> > > > +{
> > > > +	u64 inflight;
> > > > +
> > > > +	spin_lock(&vs->vs_flush_lock);
> > > > +	inflight = vs->vs_inflight[during_flush]--;
> > > > +	/*
> > > > +	 * Wakeup the waiter when all the requests issued before the flush
> > > > +	 * operation are finished and we are during the flush operation.
> > > > +	 */
> > > > +	if (!inflight && !during_flush && vs->vs_during_flush)
> > > > +		wake_up(&vs->vs_flush_wait);
> > > > +	spin_unlock(&vs->vs_flush_lock);
> > > > +}
> > > > +
> > > > +static bool tcm_vhost_done_inflight(struct vhost_scsi *vs)
> > > > +{
> > > > +	bool ret = false;
> > > > +
> > > > +	/* The requests issued before the flush operation are finished ? */
> > > > +	spin_lock(&vs->vs_flush_lock);
> > > > +	if (!vs->vs_inflight[0])
> > > > +		ret = true;
> > > > +	spin_unlock(&vs->vs_flush_lock);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  static bool tcm_vhost_check_feature(struct vhost_scsi *vs, int feature)
> > > >  {
> > > >  	bool ret = false;
> > > > @@ -402,6 +451,7 @@ static int tcm_vhost_queue_tm_rsp(struct se_cmd *se_cmd)
> > > >  static void tcm_vhost_free_evt(struct vhost_scsi *vs, struct tcm_vhost_evt *evt)
> > > >  {
> > > >  	mutex_lock(&vs->vs_events_lock);
> > > > +	tcm_vhost_dec_inflight(vs, evt->during_flush);
> > > >  	vs->vs_events_nr--;
> > > >  	kfree(evt);
> > > >  	mutex_unlock(&vs->vs_events_lock);
> > > > @@ -423,6 +473,7 @@ static struct tcm_vhost_evt *tcm_vhost_allocate_evt(struct vhost_scsi *vs,
> > > >  	if (evt) {
> > > >  		evt->event.event = event;
> > > >  		evt->event.reason = reason;
> > > > +		evt->during_flush = tcm_vhost_inc_inflight(vs);
> > > >  		vs->vs_events_nr++;
> > > >  	}
> > > >  	mutex_unlock(&vs->vs_events_lock);
> > > > @@ -433,6 +484,7 @@ static struct tcm_vhost_evt *tcm_vhost_allocate_evt(struct vhost_scsi *vs,
> > > >  static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
> > > >  {
> > > >  	struct se_cmd *se_cmd = &tv_cmd->tvc_se_cmd;
> > > > +	struct vhost_scsi *vs = tv_cmd->tvc_vhost;
> > > >  
> > > >  	/* TODO locking against target/backend threads? */
> > > >  	transport_generic_free_cmd(se_cmd, 1);
> > > > @@ -445,13 +497,16 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
> > > >  		kfree(tv_cmd->tvc_sgl);
> > > >  	}
> > > >  
> > > > +	tcm_vhost_dec_inflight(vs, tv_cmd->during_flush);
> > > > +
> > > >  	kfree(tv_cmd);
> > > >  }
> > > >  
> > > >  static void tcm_vhost_do_evt_work(struct vhost_scsi *vs,
> > > > -	struct virtio_scsi_event *event)
> > > > +	struct tcm_vhost_evt *evt)
> > > >  {
> > > >  	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> > > > +	struct virtio_scsi_event *event = &evt->event;
> > > >  	struct virtio_scsi_event __user *eventp;
> > > >  	unsigned out, in;
> > > >  	int head, ret;
> > > > @@ -511,7 +566,7 @@ static void tcm_vhost_evt_work(struct vhost_work *work)
> > > >  	while (llnode) {
> > > >  		evt = llist_entry(llnode, struct tcm_vhost_evt, list);
> > > >  		llnode = llist_next(llnode);
> > > > -		tcm_vhost_do_evt_work(vs, &evt->event);
> > > > +		tcm_vhost_do_evt_work(vs, evt);
> > > >  		tcm_vhost_free_evt(vs, evt);
> > > >  	}
> > > >  }
> > > > @@ -529,8 +584,8 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
> > > >  	struct virtio_scsi_cmd_resp v_rsp;
> > > >  	struct tcm_vhost_cmd *tv_cmd;
> > > >  	struct llist_node *llnode;
> > > > -	struct se_cmd *se_cmd;
> > > >  	int ret, vq;
> > > > +	struct se_cmd *se_cmd;
> > > >  
> > > >  	bitmap_zero(signal, VHOST_SCSI_MAX_VQ);
> > > >  	llnode = llist_del_all(&vs->vs_completion_list);
> > > > @@ -568,6 +623,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
> > > >  }
> > > >  
> > > >  static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
> > > > +	struct vhost_scsi *vs,
> > > >  	struct tcm_vhost_tpg *tv_tpg,
> > > >  	struct virtio_scsi_cmd_req *v_req,
> > > >  	u32 exp_data_len,
> > > > @@ -592,6 +648,8 @@ static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
> > > >  	tv_cmd->tvc_exp_data_len = exp_data_len;
> > > >  	tv_cmd->tvc_data_direction = data_direction;
> > > >  	tv_cmd->tvc_nexus = tv_nexus;
> > > > +	tv_cmd->tvc_vhost = vs;
> > > > +	tv_cmd->during_flush = tcm_vhost_inc_inflight(vs);
> > > >  
> > > >  	return tv_cmd;
> > > >  }
> > > > @@ -842,7 +900,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
> > > >  		for (i = 0; i < data_num; i++)
> > > >  			exp_data_len += vq->iov[data_first + i].iov_len;
> > > >  
> > > > -		tv_cmd = vhost_scsi_allocate_cmd(tv_tpg, &v_req,
> > > > +		tv_cmd = vhost_scsi_allocate_cmd(vs, tv_tpg, &v_req,
> > > >  					exp_data_len, data_direction);
> > > >  		if (IS_ERR(tv_cmd)) {
> > > >  			vq_err(vq, "vhost_scsi_allocate_cmd failed %ld\n",
> > > > @@ -852,7 +910,6 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
> > > >  		pr_debug("Allocated tv_cmd: %p exp_data_len: %d, data_direction"
> > > >  			": %d\n", tv_cmd, exp_data_len, data_direction);
> > > >  
> > > > -		tv_cmd->tvc_vhost = vs;
> > > >  		tv_cmd->tvc_vq = vq;
> > > >  
> > > >  		if (unlikely(vq->iov[out].iov_len !=
> > > > @@ -905,6 +962,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
> > > >  		 * tcm_vhost_queue_data_in() and tcm_vhost_queue_status()
> > > >  		 */
> > > >  		tv_cmd->tvc_vq_desc = head;
> > > > +
> > > >  		/*
> > > >  		 * Dispatch tv_cmd descriptor for cmwq execution in process
> > > >  		 * context provided by tcm_vhost_workqueue.  This also ensures
> > > > @@ -984,9 +1042,23 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
> > > >  {
> > > >  	int i;
> > > >  
> > > > +	/* Flush operation is started */
> > > > +	spin_lock(&vs->vs_flush_lock);
> > > > +	vs->vs_during_flush = 1;
> > > > +	spin_unlock(&vs->vs_flush_lock);
> > > > +
> > > >  	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
> > > >  		vhost_scsi_flush_vq(vs, i);
> > > >  	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
> > > > +	vhost_work_flush(&vs->dev, &vs->vs_event_work);
> > > > +
> > > > +	/* Wait until all requests issued before the flush to be finished */
> > > > +	wait_event(vs->vs_flush_wait, tcm_vhost_done_inflight(vs));
> > > > +
> > > > +	/* Flush operation is finished */
> > > > +	spin_lock(&vs->vs_flush_lock);
> > > > +	vs->vs_during_flush = 0;
> > > > +	spin_unlock(&vs->vs_flush_lock);
> > > >  }
> > > >  
> > > >  /*
> > > > @@ -1094,6 +1166,7 @@ static int vhost_scsi_clear_endpoint(
> > > >  	u8 target;
> > > >  
> > > >  	mutex_lock(&vs->dev.mutex);
> > > > +
> > > >  	/* Verify that ring has been setup correctly. */
> > > >  	for (index = 0; index < vs->dev.nvqs; ++index) {
> > > >  		if (!vhost_vq_access_ok(&vs->vqs[index])) {
> > > > @@ -1195,6 +1268,11 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
> > > >  	s->vs_events_dropped = false;
> > > >  	mutex_init(&s->vs_events_lock);
> > > >  
> > > > +	s->vs_inflight[0] = 0;
> > > > +	s->vs_inflight[1] = 0;
> > > > +	spin_lock_init(&s->vs_flush_lock);
> > > > +	init_waitqueue_head(&s->vs_flush_wait);
> > > > +
> > > >  	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
> > > >  	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
> > > >  	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++)
> > > > diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
> > > > index 94e9ee53..dd84622 100644
> > > > --- a/drivers/vhost/tcm_vhost.h
> > > > +++ b/drivers/vhost/tcm_vhost.h
> > > > @@ -37,6 +37,8 @@ struct tcm_vhost_cmd {
> > > >  	unsigned char tvc_sense_buf[TRANSPORT_SENSE_BUFFER];
> > > >  	/* Completed commands list, serviced from vhost worker thread */
> > > >  	struct llist_node tvc_completion_list;
> > > > +	/* Indicate this command is issued during the flush operaton */
> > > > +	int during_flush;
> > > >  };
> > > >  
> > > >  struct tcm_vhost_nexus {
> > > > @@ -91,6 +93,8 @@ struct tcm_vhost_evt {
> > > >  	struct virtio_scsi_event event;
> > > >  	/* virtio_scsi event list, serviced from vhost worker thread */
> > > >  	struct llist_node list;
> > > > +	/* Indicate this event is issued during the flush operaton */
> > > > +	int during_flush;
> > > >  };
> > > >  
> > > >  /*
> > > > -- 
> > > > 1.8.1.4
> > 
> > -- 
> > Asias

-- 
Asias
