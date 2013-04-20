From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 3/3] tcm_vhost: Add hotplug/hotunplug support
Date: Sat, 20 Apr 2013 22:01:31 +0300
Message-ID: <20130420190131.GA853@redhat.com>
References: <20130417131726.GA26157@redhat.com>
	<1366247154-3136-4-git-send-email-asias@redhat.com>
	<20130418073429.GE13787@redhat.com>
	<20130418085908.GD13554@hj.localdomain>
	<20130418082154.GA16167@redhat.com>
	<20130419023410.GA18829@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130419023410.GA18829@hj.localdomain>
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

On Fri, Apr 19, 2013 at 10:34:10AM +0800, Asias He wrote:
> On Thu, Apr 18, 2013 at 11:21:54AM +0300, Michael S. Tsirkin wrote:
> > On Thu, Apr 18, 2013 at 04:59:08PM +0800, Asias He wrote:
> > > On Thu, Apr 18, 2013 at 10:34:29AM +0300, Michael S. Tsirkin wrote:
> > > > On Thu, Apr 18, 2013 at 09:05:54AM +0800, Asias He wrote:
> > > > > In commit 365a7150094 ([SCSI] virtio-scsi: hotplug support for
> > > > > virtio-scsi), hotplug support is added to virtio-scsi.
> > > > > 
> > > > > This patch adds hotplug and hotunplug support to tcm_vhost.
> > > > > 
> > > > > You can create or delete a LUN in targetcli to hotplug or hotunplug a
> > > > > LUN in guest.
> > > > > 
> > > > > Changes in v7:
> > > > > - Add vhost_work_flush for vs->vs_event_work to this series
> > > > > 
> > > > > Changes in v6:
> > > > > - Pass tcm_vhost_evt to tcm_vhost_do_evt_work
> > > > > 
> > > > > Changes in v5:
> > > > > - Switch to int from u64 to vs_events_nr
> > > > > - Set s->vs_events_dropped flag in tcm_vhost_allocate_evt
> > > > > - Do not nest dev mutex within vq mutex
> > > > > - Use vs_events_lock to protect vs_events_dropped and vs_events_nr
> > > > > - Rebase to target/master
> > > > > 
> > > > > Changes in v4:
> > > > > - Drop tcm_vhost_check_endpoint in tcm_vhost_send_evt
> > > > > - Add tcm_vhost_check_endpoint in vhost_scsi_evt_handle_kick
> > > > > 
> > > > > Changes in v3:
> > > > > - Separate the bug fix to another thread
> > > > > 
> > > > > Changes in v2:
> > > > > - Remove code duplication in tcm_vhost_{hotplug,hotunplug}
> > > > > - Fix racing of vs_events_nr
> > > > > - Add flush fix patch to this series
> > > > > 
> > > > > Signed-off-by: Asias He <asias@redhat.com>
> > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > ---
> > > > >  drivers/vhost/tcm_vhost.c | 208 +++++++++++++++++++++++++++++++++++++++++++++-
> > > > >  drivers/vhost/tcm_vhost.h |  10 +++
> > > > >  2 files changed, 214 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > > > > index 8f05528..da2021b 100644
> > > > > --- a/drivers/vhost/tcm_vhost.c
> > > > > +++ b/drivers/vhost/tcm_vhost.c
> > > > > @@ -66,11 +66,13 @@ enum {
> > > > >   * TODO: debug and remove the workaround.
> > > > >   */
> > > > >  enum {
> > > > > -	VHOST_SCSI_FEATURES = VHOST_FEATURES & (~VIRTIO_RING_F_EVENT_IDX)
> > > > > +	VHOST_SCSI_FEATURES = (VHOST_FEATURES & (~VIRTIO_RING_F_EVENT_IDX)) |
> > > > > +			      (1ULL << VIRTIO_SCSI_F_HOTPLUG)
> > > > >  };
> > > > >  
> > > > >  #define VHOST_SCSI_MAX_TARGET	256
> > > > >  #define VHOST_SCSI_MAX_VQ	128
> > > > > +#define VHOST_SCSI_MAX_EVENT	128
> > > > >  
> > > > >  struct vhost_scsi {
> > > > >  	/* Protected by vhost_scsi->dev.mutex */
> > > > > @@ -82,6 +84,13 @@ struct vhost_scsi {
> > > > >  
> > > > >  	struct vhost_work vs_completion_work; /* cmd completion work item */
> > > > >  	struct llist_head vs_completion_list; /* cmd completion queue */
> > > > > +
> > > > > +	struct vhost_work vs_event_work; /* evt injection work item */
> > > > > +	struct llist_head vs_event_list; /* evt injection queue */
> > > > > +
> > > > > +	struct mutex vs_events_lock; /* protect vs_events_dropped,events_nr */
> > > > 
> > > > Looking at this code, there are just so many locks now.
> > > > This does not make me feel safe :)
> > > > At least, please document lock nesting.
> > > > 
> > > 
> > > Do you see a real problem?
> > 
> > Complexity is a real problem. My head already spins. No I don't see a
> > bug, but we need to simplify locking.
> > 
> > And I think I see a nice way to do this:
> > 1. move away from a global work to per-event work - so no list
> > 2. remove dynamic allocation of events - so no events_nr
> > 3. set/test overrun flag under the appropriate vq mutex
> > 
> > I think that's ideal.  But we can move there in small steps.  As a first
> > step - why can't we always take the vq mutex lock and drop
> > vs_events_lock?
> 
> There are really different ways to solve the same problem. You are
> welcome to implement you ideas.

I have a problem with this patch. It just seems too tricky,
while it is really trying to do a very simple thing.
There's new lock nesting.  There are new places which do lock, read
data, unlock, use data.  There's new RCU. All this feels fragile, and
will be hard to maintain even though I don't see bugs.
So I would prefer it if you tried to simplify
this code making it easier to maintain. I sent some ideas on how to
do this, but if you like, do it some other way.

I also made some comments about the coding style but these
are less important (except goto again I guess) if these
will be te only issues, I'd say we can apply.


> > > > > +	bool vs_events_dropped; /* any missed events */
> > > > > +	int vs_events_nr; /* num of pending events */
> > > > >  };
> > > > >  
> > > > >  /* Local pointer to allocated TCM configfs fabric module */
> > > > > @@ -129,6 +138,17 @@ static bool tcm_vhost_check_endpoint(struct vhost_virtqueue *vq)
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > > +static bool tcm_vhost_check_events_dropped(struct vhost_scsi *vs)
> > > > > +{
> > > > > +	bool ret;
> > > > > +
> > > > > +	mutex_lock(&vs->vs_events_lock);
> > > > > +	ret = vs->vs_events_dropped;
> > > > > +	mutex_unlock(&vs->vs_events_lock);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > >  static int tcm_vhost_check_true(struct se_portal_group *se_tpg)
> > > > >  {
> > > > >  	return 1;
> > > > > @@ -379,6 +399,37 @@ static int tcm_vhost_queue_tm_rsp(struct se_cmd *se_cmd)
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +static void tcm_vhost_free_evt(struct vhost_scsi *vs, struct tcm_vhost_evt *evt)
> > > > > +{
> > > > > +	mutex_lock(&vs->vs_events_lock);
> > > > > +	vs->vs_events_nr--;
> > > > > +	kfree(evt);
> > > > > +	mutex_unlock(&vs->vs_events_lock);
> > > > > +}
> > > > > +
> > > > > +static struct tcm_vhost_evt *tcm_vhost_allocate_evt(struct vhost_scsi *vs,
> > > > > +	u32 event, u32 reason)
> > > > > +{
> > > > > +	struct tcm_vhost_evt *evt;
> > > > > +
> > > > > +	mutex_lock(&vs->vs_events_lock);
> > > > > +	if (vs->vs_events_nr > VHOST_SCSI_MAX_EVENT) {
> > > > > +		vs->vs_events_dropped = true;
> > > > > +		mutex_unlock(&vs->vs_events_lock);
> > > > > +		return NULL;
> > > > > +	}
> > > > > +
> > > > > +	evt = kzalloc(sizeof(*evt), GFP_KERNEL);
> > > > 
> > > > I think kzalloc not needed here, you init all fields.
> > > 
> > > Not really! evt->event.lun[4-7] is not initialized. It needs to be 0.
> > 
> > So that is 4 bytes just init them when you set rest of lun.
> 
> It is not in the fast path. You can do it this way but not a must.

I think that's a bit cleaner than relying on kzalloc to zero-initialize.

> > > > Also, this basically means if backend does plug/unplug very quickly,
> > > > we start consuming kernel memory without a limit. Not good.
> > > > How about we allocate the event as part of target?
> > > > There shouldn't ever be more than one hotplug
> > > > event in flight per target, right?
> > > 
> > > It is limited by VHOST_SCSI_MAX_EVENT.
> > 
> > OK I missed that. But where does VHOST_SCSI_MAX_EVENT come from by the
> > way?  I don't see it in spec or did I miss it?  It seems it's best not
> > to lost events as long as there are descriptors in the event vq.
> 
> You wanted this.

Yes I wanted some limit on the amount of memory we use up :)

> > > > 
> > > > > +	if (evt) {
> > > > 
> > > > Let's do clean error handling here and above:
> > > > if (!evt)
> > > > 	goto err;
> > > 
> > > We can you do in err? You simply unlock and return. Why bother? How
> > > cleaner it will be.
> > 
> > There's another error above and we'll share code.
> > It's not a big issue, just a bit nicer IMHO.
> 
> Can't we focus on real issues other than this?

Yes style issues are not the most important here.

> > > > > +		evt->event.event = event;
> > > > > +		evt->event.reason = reason;
> > > > > +		vs->vs_events_nr++;
> > > > > +	}
> > > > > +	mutex_unlock(&vs->vs_events_lock);
> > > > > +
> > > > > +	return evt;
> > > > > +}
> > > > > +
> > > > >  static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
> > > > >  {
> > > > >  	struct se_cmd *se_cmd = &tv_cmd->tvc_se_cmd;
> > > > > @@ -397,6 +448,75 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
> > > > >  	kfree(tv_cmd);
> > > > >  }
> > > > >  
> > > > > +static void tcm_vhost_do_evt_work(struct vhost_scsi *vs,
> > > > > +	struct tcm_vhost_evt *evt)
> > > > > +{
> > > > > +	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> > > > > +	struct virtio_scsi_event *event = &evt->event;
> > > > > +	struct virtio_scsi_event __user *eventp;
> > > > > +	unsigned out, in;
> > > > > +	int head, ret;
> > > > > +
> > > > > +	if (!tcm_vhost_check_endpoint(vq))
> > > > > +		return;
> > > > > +
> > > > > +	mutex_lock(&vs->vs_events_lock);
> > > > > +	mutex_lock(&vq->mutex);
> > > > > +again:
> > > > > +	vhost_disable_notify(&vs->dev, vq);
> > > > > +	head = vhost_get_vq_desc(&vs->dev, vq, vq->iov,
> > > > > +			ARRAY_SIZE(vq->iov), &out, &in,
> > > > > +			NULL, NULL);
> > > > > +	if (head < 0) {
> > > > > +		vs->vs_events_dropped = true;
> > > > > +		goto out;
> > > > > +	}
> > > > > +	if (head == vq->num) {
> > > > > +		if (vhost_enable_notify(&vs->dev, vq))
> > > > > +			goto again;
> > > > 
> > > > Please write loops with while() or for().
> > > > Not with goto. goto is for error handling.
> > > 
> > > This makes extra indention which is more ugly.
> > 
> > I don't care. No loops with goto and that's a hard rule.
> 
> It is not a loop.

If same code repeats, it's a loop.

> > > > > +		vs->vs_events_dropped = true;
> > > > > +		goto out;
> > > > > +	}
> > > > > +
> > > > > +	if ((vq->iov[out].iov_len != sizeof(struct virtio_scsi_event))) {
> > > > > +		vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
> > > > > +				vq->iov[out].iov_len);
> > > > > +		vs->vs_events_dropped = true;
> > > > > +		goto out;
> > > > > +	}
> > > > > +
> > > > > +	if (vs->vs_events_dropped) {
> > > > > +		event->event |= VIRTIO_SCSI_T_EVENTS_MISSED;
> > > > > +		vs->vs_events_dropped = false;
> > > > > +	}
> > > > > +
> > > > > +	eventp = vq->iov[out].iov_base;
> > > > > +	ret = __copy_to_user(eventp, event, sizeof(*event));
> > > > > +	if (!ret)
> > > > > +		vhost_add_used_and_signal(&vs->dev, vq, head, 0);
> > > > > +	else
> > > > > +		vq_err(vq, "Faulted on tcm_vhost_send_event\n");
> > > > > +out:
> > > > > +	mutex_unlock(&vq->mutex);
> > > > > +	mutex_unlock(&vs->vs_events_lock);
> > > > > +}
> > > > > +
> > > > > +static void tcm_vhost_evt_work(struct vhost_work *work)
> > > > > +{
> > > > > +	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
> > > > > +					vs_event_work);
> > > > > +	struct tcm_vhost_evt *evt;
> > > > > +	struct llist_node *llnode;
> > > > > +
> > > > > +	llnode = llist_del_all(&vs->vs_event_list);
> > > > 
> > > > The assumption is that this is slow path thing, no need to worry about
> > > > speed, yes? so let's do simple list_add, list_del etc.
> > > 
> > > Why it is simpler?
> > 
> > simple list_ with a lock is easier to use correctly.
> 
> You need to use it correctly anyway for cmd. Why you want a lock here?
> 
> > > We are using llist for cmd. Why it is better using
> > > one for evt and the different for cmd? Similar code makes people easier
> > > to read.
> > 
> > OK fair enough. But my idea is above to use a work
> > structure instead of a list of events.
> > This way we don't need extra list at all,
> > no new locks, nothing.
> 
> Again, You are welcome to implement your ideas.

I might but I'm otherwise occupied at the moment.

> > > > > +	while (llnode) {
> > > > > +		evt = llist_entry(llnode, struct tcm_vhost_evt, list);
> > > > > +		llnode = llist_next(llnode);
> > > > > +		tcm_vhost_do_evt_work(vs, evt);
> > > > > +		tcm_vhost_free_evt(vs, evt);
> > > > > +	}
> > > > > +}
> > > > > +
> > > > >  /* Fill in status and signal that we are done processing this command
> > > > >   *
> > > > >   * This is scheduled in the vhost work queue so we are called with the owner
> > > > > @@ -807,9 +927,42 @@ static void vhost_scsi_ctl_handle_kick(struct vhost_work *work)
> > > > >  	pr_debug("%s: The handling func for control queue.\n", __func__);
> > > > >  }
> > > > >  
> > > > > +static int tcm_vhost_send_evt(struct vhost_scsi *vs, struct tcm_vhost_tpg *tpg,
> > > > > +	struct se_lun *lun, u32 event, u32 reason)
> > > > > +{
> > > > > +	struct tcm_vhost_evt *evt;
> > > > > +
> > > > > +	evt = tcm_vhost_allocate_evt(vs, event, reason);
> > > > > +	if (!evt)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	if (tpg && lun) {
> > > > > +		/* TODO: share lun setup code with virtio-scsi.ko */
> > > > > +		evt->event.lun[0] = 0x01;
> > > > > +		evt->event.lun[1] = tpg->tport_tpgt & 0xFF;
> > > > > +		if (lun->unpacked_lun >= 256)
> > > > > +			evt->event.lun[2] = lun->unpacked_lun >> 8 | 0x40 ;
> > > > > +		evt->event.lun[3] = lun->unpacked_lun & 0xFF;
> > > > > +	}
> > > > > +
> > > > > +	llist_add(&evt->list, &vs->vs_event_list);
> > > > > +	vhost_work_queue(&vs->dev, &vs->vs_event_work);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static void vhost_scsi_evt_handle_kick(struct vhost_work *work)
> > > > >  {
> > > > > -	pr_debug("%s: The handling func for event queue.\n", __func__);
> > > > > +	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
> > > > > +						poll.work);
> > > > > +	struct vhost_scsi *vs = container_of(vq->dev, struct vhost_scsi, dev);
> > > > > +
> > > > > +	if (!tcm_vhost_check_endpoint(vq))
> > > > > +		return;
> > > > 
> > > > Again just drop this check.
> > > 
> > > Why?
> > 
> > Same as above.
> > Because it's not safe to do this outside the vq mutex.
> 
> Is it also not safe to the same in -net?

It's safe there since we dereference the pointer.

> Why is it not safe?

Because you don't dereference the pointer.

> > > > > +
> > > > > +	if (tcm_vhost_check_events_dropped(vs))
> > > > > +		tcm_vhost_send_evt(vs, NULL, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
> > > > > +
> > > > >  }
> > > > >  
> > > > >  static void vhost_scsi_handle_kick(struct vhost_work *work)
> > > > > @@ -833,6 +986,7 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
> > > > >  	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
> > > > >  		vhost_scsi_flush_vq(vs, i);
> > > > >  	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
> > > > > +	vhost_work_flush(&vs->dev, &vs->vs_event_work);
> > > > >  }
> > > > >  
> > > > >  /*
> > > > > @@ -891,6 +1045,7 @@ static int vhost_scsi_set_endpoint(
> > > > >  				return -EEXIST;
> > > > >  			}
> > > > >  			tv_tpg->tv_tpg_vhost_count++;
> > > > > +			tv_tpg->vhost_scsi = vs;
> > > > >  			vs_tpg[tv_tpg->tport_tpgt] = tv_tpg;
> > > > >  			smp_mb__after_atomic_inc();
> > > > >  			match = true;
> > > > > @@ -974,6 +1129,7 @@ static int vhost_scsi_clear_endpoint(
> > > > >  			goto err_tpg;
> > > > >  		}
> > > > >  		tv_tpg->tv_tpg_vhost_count--;
> > > > > +		tv_tpg->vhost_scsi = NULL;
> > > > >  		vs->vs_tpg[target] = NULL;
> > > > >  		match = true;
> > > > >  		mutex_unlock(&tv_tpg->tv_tpg_mutex);
> > > > > @@ -1033,6 +1189,11 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
> > > > >  		return -ENOMEM;
> > > > >  
> > > > >  	vhost_work_init(&s->vs_completion_work, vhost_scsi_complete_cmd_work);
> > > > > +	vhost_work_init(&s->vs_event_work, tcm_vhost_evt_work);
> > > > > +
> > > > > +	s->vs_events_nr = 0;
> > > > > +	s->vs_events_dropped = false;
> > > > > +	mutex_init(&s->vs_events_lock);
> > > > >  
> > > > >  	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
> > > > >  	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
> > > > > @@ -1163,6 +1324,42 @@ static char *tcm_vhost_dump_proto_id(struct tcm_vhost_tport *tport)
> > > > >  	return "Unknown";
> > > > >  }
> > > > >  
> > > > > +static int tcm_vhost_do_plug(struct tcm_vhost_tpg *tpg,
> > > > > +	struct se_lun *lun, bool plug)
> > > > > +{
> > > > > +
> > > > > +	struct vhost_scsi *vs = tpg->vhost_scsi;
> > > > > +	u32 reason;
> > > > > +
> > > > > +	mutex_lock(&tpg->tv_tpg_mutex);
> > > > > +	vs = tpg->vhost_scsi;
> > > > > +	mutex_unlock(&tpg->tv_tpg_mutex);
> > > > > +	if (!vs)
> > > > > +		return -EOPNOTSUPP;
> > > > 
> > > > Why EOPNOTSUPP? When does this happen?
> > > 
> > > When tpg->vhost_scsi has not been setup. E.g. no one starts a vhost-scsi
> > > guest.
> > 
> > So ENODEV or something.
> 
> okay.
> 
> > > > > +
> > > > > +	if (!tcm_vhost_check_feature(vs, VIRTIO_SCSI_F_HOTPLUG))
> > > > > +		return -EOPNOTSUPP;
> > > > > +
> > > > > +	if (plug)
> > > > > +		reason = VIRTIO_SCSI_EVT_RESET_RESCAN;
> > > > > +	else
> > > > > +		reason = VIRTIO_SCSI_EVT_RESET_REMOVED;
> > > > > +
> > > > 
> > > > You have dropped the tpg lock so tpg->vhost_scsi can become
> > > > NULL now. Why is this safe?
> > > >
> > > > > +	return tcm_vhost_send_evt(vs, tpg, lun,
> > > > > +			VIRTIO_SCSI_T_TRANSPORT_RESET,
> > > > > +			reason);
> > > > > +}
> > > > > +
> > > > > +static int tcm_vhost_hotplug(struct tcm_vhost_tpg *tpg, struct se_lun *lun)
> > > > > +{
> > > > > +	return tcm_vhost_do_plug(tpg, lun, true);
> > > > > +}
> > > > > +
> > > > > +static int tcm_vhost_hotunplug(struct tcm_vhost_tpg *tpg, struct se_lun *lun)
> > > > > +{
> > > > > +	return tcm_vhost_do_plug(tpg, lun, false);
> > > > > +}
> > > > > +
> > > > 
> > > > What are these wrappers for? Seem useless ...
> > > 
> > > 
> > > It make people easier to understand what's the true and false is about
> > > in tcm_vhost_do_plug.
> > 
> > So just pass in the reason and not a bool.
> > When readers see
> > VIRTIO_SCSI_EVT_RESET_RESCAN/VIRTIO_SCSI_EVT_RESET_REMOVED
> > they will know what is going on.
> 
> How can you make the connection that VIRTIO_SCSI_EVT_RESET_RESCAN is
> hotplug and VIRTIO_SCSI_EVT_RESET_REMOVED is hot-unplug at first glance?
> 
> > > > >  static int tcm_vhost_port_link(struct se_portal_group *se_tpg,
> > > > >  	struct se_lun *lun)
> > > > >  {
> > > > > @@ -1173,18 +1370,21 @@ static int tcm_vhost_port_link(struct se_portal_group *se_tpg,
> > > > >  	tv_tpg->tv_tpg_port_count++;
> > > > >  	mutex_unlock(&tv_tpg->tv_tpg_mutex);
> > > > >  
> > > > > +	tcm_vhost_hotplug(tv_tpg, lun);
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > >  static void tcm_vhost_port_unlink(struct se_portal_group *se_tpg,
> > > > > -	struct se_lun *se_lun)
> > > > > +	struct se_lun *lun)
> > > > >  {
> > > > >  	struct tcm_vhost_tpg *tv_tpg = container_of(se_tpg,
> > > > >  				struct tcm_vhost_tpg, se_tpg);
> > > > > -
> > > > >  	mutex_lock(&tv_tpg->tv_tpg_mutex);
> > > > >  	tv_tpg->tv_tpg_port_count--;
> > > > >  	mutex_unlock(&tv_tpg->tv_tpg_mutex);
> > > > > +
> > > > > +	tcm_vhost_hotunplug(tv_tpg, lun);
> > > > >  }
> > > > >  
> > > > >  static struct se_node_acl *tcm_vhost_make_nodeacl(
> > > > > diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
> > > > > index 1d2ae7a..94e9ee53 100644
> > > > > --- a/drivers/vhost/tcm_vhost.h
> > > > > +++ b/drivers/vhost/tcm_vhost.h
> > > > > @@ -53,6 +53,7 @@ struct tcm_vhost_nacl {
> > > > >  	struct se_node_acl se_node_acl;
> > > > >  };
> > > > >  
> > > > > +struct vhost_scsi;
> > > > >  struct tcm_vhost_tpg {
> > > > >  	/* Vhost port target portal group tag for TCM */
> > > > >  	u16 tport_tpgt;
> > > > > @@ -70,6 +71,8 @@ struct tcm_vhost_tpg {
> > > > >  	struct tcm_vhost_tport *tport;
> > > > >  	/* Returned by tcm_vhost_make_tpg() */
> > > > >  	struct se_portal_group se_tpg;
> > > > > +	/* Pointer back to struct vhost_scsi, protected by tv_tpg_mutex */
> > > > > +	struct vhost_scsi *vhost_scsi;
> > > > >  };
> > > > >  
> > > > >  struct tcm_vhost_tport {
> > > > > @@ -83,6 +86,13 @@ struct tcm_vhost_tport {
> > > > >  	struct se_wwn tport_wwn;
> > > > >  };
> > > > >  
> > > > > +struct tcm_vhost_evt {
> > > > > +	/* virtio_scsi event */
> > > > > +	struct virtio_scsi_event event;
> > > > > +	/* virtio_scsi event list, serviced from vhost worker thread */
> > > > > +	struct llist_node list;
> > > > > +};
> > > > > +
> > > > >  /*
> > > > >   * As per request from MST, keep TCM_VHOST related ioctl defines out of
> > > > >   * linux/vhost.h (user-space) for now..
> > > > > -- 
> > > > > 1.8.1.4
> > > 
> > > -- 
> > > Asias
> 
> -- 
> Asias
