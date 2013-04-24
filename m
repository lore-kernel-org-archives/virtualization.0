From: Asias He <asias@redhat.com>
Subject: Re: [PATCH v8 2/3] tcm_vhost: Add hotplug/hotunplug support
Date: Wed, 24 Apr 2013 18:06:25 +0800
Message-ID: <20130424100625.GA19845@hj.localdomain>
References: <1366774344-11127-1-git-send-email-asias@redhat.com>
	<1366774344-11127-3-git-send-email-asias@redhat.com>
	<20130424091833.GB11245@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130424091833.GB11245@redhat.com>
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

On Wed, Apr 24, 2013 at 12:18:33PM +0300, Michael S. Tsirkin wrote:
> On Wed, Apr 24, 2013 at 11:32:23AM +0800, Asias He wrote:
> > In commit 365a7150094 ([SCSI] virtio-scsi: hotplug support for
> > virtio-scsi), hotplug support is added to virtio-scsi.
> > 
> > This patch adds hotplug and hotunplug support to tcm_vhost.
> > 
> > You can create or delete a LUN in targetcli to hotplug or hotunplug a
> > LUN in guest.
> > 
> > Changes in v8:
> > - Use vq->mutex for event
> > - Drop tcm_vhost: Add helper to check if endpoint is setup
> > - Rename vs_events_dropped to vs_events_missed
> > - Init lun[] explicitly
> > 
> > Changes in v7:
> > - Add vhost_work_flush for vs->vs_event_work to this series
> > 
> > Changes in v6:
> > - Pass tcm_vhost_evt to tcm_vhost_do_evt_work
> > 
> > Changes in v5:
> > - Switch to int from u64 to vs_events_nr
> > - Set s->vs_events_dropped flag in tcm_vhost_allocate_evt
> > - Do not nest dev mutex within vq mutex
> > - Use vs_events_lock to protect vs_events_dropped and vs_events_nr
> > - Rebase to target/master
> > 
> > Changes in v4:
> > - Drop tcm_vhost_check_endpoint in tcm_vhost_send_evt
> > - Add tcm_vhost_check_endpoint in vhost_scsi_evt_handle_kick
> > 
> > Changes in v3:
> > - Separate the bug fix to another thread
> > 
> > Changes in v2:
> > - Remove code duplication in tcm_vhost_{hotplug,hotunplug}
> > - Fix racing of vs_events_nr
> > - Add flush fix patch to this series
> > 
> > Signed-off-by: Asias He <asias@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  drivers/vhost/tcm_vhost.c | 203 +++++++++++++++++++++++++++++++++++++++++++++-
> >  drivers/vhost/tcm_vhost.h |  10 +++
> >  2 files changed, 209 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > index 88ebb79..def0c57 100644
> > --- a/drivers/vhost/tcm_vhost.c
> > +++ b/drivers/vhost/tcm_vhost.c
> > @@ -66,11 +66,13 @@ enum {
> >   * TODO: debug and remove the workaround.
> >   */
> >  enum {
> > -	VHOST_SCSI_FEATURES = VHOST_FEATURES & (~VIRTIO_RING_F_EVENT_IDX)
> > +	VHOST_SCSI_FEATURES = (VHOST_FEATURES & (~VIRTIO_RING_F_EVENT_IDX)) |
> > +			      (1ULL << VIRTIO_SCSI_F_HOTPLUG)
> >  };
> >  
> >  #define VHOST_SCSI_MAX_TARGET	256
> >  #define VHOST_SCSI_MAX_VQ	128
> > +#define VHOST_SCSI_MAX_EVENT	128
> >  
> >  struct vhost_scsi {
> >  	/* Protected by vhost_scsi->dev.mutex */
> > @@ -82,6 +84,12 @@ struct vhost_scsi {
> >  
> >  	struct vhost_work vs_completion_work; /* cmd completion work item */
> >  	struct llist_head vs_completion_list; /* cmd completion queue */
> > +
> > +	struct vhost_work vs_event_work; /* evt injection work item */
> > +	struct llist_head vs_event_list; /* evt injection queue */
> > +
> > +	bool vs_events_missed; /* any missed events, protected by vq->mutex */
> > +	int vs_events_nr; /* num of pending events, protected by vq->mutex */
> >  };
> >  
> >  /* Local pointer to allocated TCM configfs fabric module */
> > @@ -361,6 +369,32 @@ static int tcm_vhost_queue_tm_rsp(struct se_cmd *se_cmd)
> >  	return 0;
> >  }
> >  
> > +static void tcm_vhost_free_evt(struct vhost_scsi *vs, struct tcm_vhost_evt *evt)
> > +{
> > +	vs->vs_events_nr--;
> > +	kfree(evt);
> > +}
> > +
> > +static struct tcm_vhost_evt *tcm_vhost_allocate_evt(struct vhost_scsi *vs,
> > +	u32 event, u32 reason)
> > +{
> > +	struct tcm_vhost_evt *evt;
> > +
> > +	if (vs->vs_events_nr > VHOST_SCSI_MAX_EVENT) {
> > +		vs->vs_events_missed = true;
> > +		return NULL;
> > +	}
> > +
> > +	evt = kmalloc(sizeof(*evt), GFP_KERNEL);
> > +	if (evt) {
> 
> !evt should trigger vq_err I think.
> Please do
> 	if (!evt) {
> 		vq_err
> 		return NULL
> 	}
> 
> this way code below has less nesting.

okay.

> > +		evt->event.event = event;
> > +		evt->event.reason = reason;
> > +		vs->vs_events_nr++;
> > +	}
> > +
> > +	return evt;
> > +}
> > +
> >  static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
> >  {
> >  	struct se_cmd *se_cmd = &tv_cmd->tvc_se_cmd;
> > @@ -379,6 +413,74 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
> >  	kfree(tv_cmd);
> >  }
> >  
> > +static void tcm_vhost_do_evt_work(struct vhost_scsi *vs,
> > +	struct tcm_vhost_evt *evt)
> > +{
> > +	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> > +	struct virtio_scsi_event *event = &evt->event;
> > +	struct virtio_scsi_event __user *eventp;
> > +	unsigned out, in;
> > +	int head, ret;
> > +
> > +again:
> > +	vhost_disable_notify(&vs->dev, vq);
> > +	head = vhost_get_vq_desc(&vs->dev, vq, vq->iov,
> > +			ARRAY_SIZE(vq->iov), &out, &in,
> > +			NULL, NULL);
> > +	if (head < 0) {
> > +		vs->vs_events_missed = true;
> > +		return;
> > +	}
> > +	if (head == vq->num) {
> > +		if (vhost_enable_notify(&vs->dev, vq))
> > +			goto again;
> > +		vs->vs_events_missed = true;
> > +		return;
> > +	}
> > +
> > +	if ((vq->iov[out].iov_len != sizeof(struct virtio_scsi_event))) {
> > +		vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
> > +				vq->iov[out].iov_len);
> > +		vs->vs_events_missed = true;
> > +		return;
> > +	}
> > +
> > +	if (vs->vs_events_missed) {
> > +		event->event |= VIRTIO_SCSI_T_EVENTS_MISSED;
> > +		vs->vs_events_missed = false;
> > +	}
> > +
> > +	eventp = vq->iov[out].iov_base;
> > +	ret = __copy_to_user(eventp, event, sizeof(*event));
> > +	if (!ret)
> > +		vhost_add_used_and_signal(&vs->dev, vq, head, 0);
> > +	else
> > +		vq_err(vq, "Faulted on tcm_vhost_send_event\n");
> > +}
> > +
> > +static void tcm_vhost_evt_work(struct vhost_work *work)
> > +{
> > +	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
> > +					vs_event_work);
> > +	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> > +	struct tcm_vhost_evt *evt;
> > +	struct llist_node *llnode;
> > +
> > +	mutex_lock(&vq->mutex);
> > +	if (!vq->private_data)
> > +		goto out;
> > +
> 
> Wait a second. Once private data is NULL what will free the events?
> Apparently nothing, so it looks like this leaks memory ...
> Maybe move the private_data check within tcm_vhost_evt
> so that events are dropped?

I moved the check into tcm_vhost_do_evt_work?

> 
> Please add WARN_ON(s->vs_events_nr) after flush
> so that we catch  such leaks

Let's add that in flush series. The flush is broken anyway.

> 
> > +	llnode = llist_del_all(&vs->vs_event_list);
> > +	while (llnode) {
> > +		evt = llist_entry(llnode, struct tcm_vhost_evt, list);
> > +		llnode = llist_next(llnode);
> > +		tcm_vhost_do_evt_work(vs, evt);
> > +		tcm_vhost_free_evt(vs, evt);
> > +	}
> > +out:
> > +	mutex_unlock(&vq->mutex);
> > +}
> > +
> >  /* Fill in status and signal that we are done processing this command
> >   *
> >   * This is scheduled in the vhost work queue so we are called with the owner
> > @@ -789,9 +891,50 @@ static void vhost_scsi_ctl_handle_kick(struct vhost_work *work)
> >  	pr_debug("%s: The handling func for control queue.\n", __func__);
> >  }
> >  
> > +static int tcm_vhost_send_evt(struct vhost_scsi *vs, struct tcm_vhost_tpg *tpg,
> > +	struct se_lun *lun, u32 event, u32 reason)
> 
> All callers just ignore the return code.
> So make this void please.

tcm_vhost_port_link might want the return code in the future. 

> > +{
> > +	struct tcm_vhost_evt *evt;
> > +
> > +	evt = tcm_vhost_allocate_evt(vs, event, reason);
> > +	if (!evt)
> > +		return -ENOMEM;
> > +
> > +	if (tpg && lun) {
> > +		/* TODO: share lun setup code with virtio-scsi.ko */
> > +		evt->event.lun[0] = 0x01;
> > +		evt->event.lun[1] = tpg->tport_tpgt & 0xFF;
> > +		if (lun->unpacked_lun >= 256)
> > +			evt->event.lun[2] = lun->unpacked_lun >> 8 | 0x40 ;
> > +		else
> > +			evt->event.lun[2] = 0;
> > +		evt->event.lun[3] = lun->unpacked_lun & 0xFF;
> > +		evt->event.lun[4] = 0;
> > +		evt->event.lun[5] = 0;
> > +		evt->event.lun[6] = 0;
> > +		evt->event.lun[7] = 0;
> > +	}
> 
> else
> 	memset(evt->event.lun, 0, sizeof evt->event.lun)

You want to set them all to zero. Current one is even more cleaner.

> > +
> > +	llist_add(&evt->list, &vs->vs_event_list);
> > +	vhost_work_queue(&vs->dev, &vs->vs_event_work);
> > +
> > +	return 0;
> > +}
> > +
> >  static void vhost_scsi_evt_handle_kick(struct vhost_work *work)
> >  {
> > -	pr_debug("%s: The handling func for event queue.\n", __func__);
> > +	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
> > +						poll.work);
> > +	struct vhost_scsi *vs = container_of(vq->dev, struct vhost_scsi, dev);
> > +
> > +	mutex_lock(&vq->mutex);
> > +	if (!vq->private_data)
> > +		goto out;
> > +
> > +	if (vs->vs_events_missed)
> > +		tcm_vhost_send_evt(vs, NULL, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
> > +out:
> > +	mutex_unlock(&vq->mutex);
> >  }
> >  
> >  static void vhost_scsi_handle_kick(struct vhost_work *work)
> > @@ -815,6 +958,7 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
> >  	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
> >  		vhost_scsi_flush_vq(vs, i);
> >  	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
> > +	vhost_work_flush(&vs->dev, &vs->vs_event_work);
> >  }
> >  
> >  /*
> > @@ -873,6 +1017,7 @@ static int vhost_scsi_set_endpoint(
> >  				return -EEXIST;
> >  			}
> >  			tv_tpg->tv_tpg_vhost_count++;
> > +			tv_tpg->vhost_scsi = vs;
> >  			vs_tpg[tv_tpg->tport_tpgt] = tv_tpg;
> >  			smp_mb__after_atomic_inc();
> >  			match = true;
> > @@ -956,6 +1101,7 @@ static int vhost_scsi_clear_endpoint(
> >  			goto err_tpg;
> >  		}
> >  		tv_tpg->tv_tpg_vhost_count--;
> > +		tv_tpg->vhost_scsi = NULL;
> >  		vs->vs_tpg[target] = NULL;
> >  		match = true;
> >  		mutex_unlock(&tv_tpg->tv_tpg_mutex);
> > @@ -1015,6 +1161,10 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
> >  		return -ENOMEM;
> >  
> >  	vhost_work_init(&s->vs_completion_work, vhost_scsi_complete_cmd_work);
> > +	vhost_work_init(&s->vs_event_work, tcm_vhost_evt_work);
> > +
> > +	s->vs_events_nr = 0;
> > +	s->vs_events_missed = false;
> 
> It's unfortunate that vs_events_missed state is lost if
> we close the device and reopen it.
> It should be possible to reattach vhost to a running guest.
> How about, a new ioctl to get and set vs_events_missed?
> This will put userspace in control.


In patch 3/3.

> >  
> >  	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
> >  	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
> > @@ -1145,6 +1295,48 @@ static char *tcm_vhost_dump_proto_id(struct tcm_vhost_tport *tport)
> >  	return "Unknown";
> >  }
> >  
> > +static int tcm_vhost_do_plug(struct tcm_vhost_tpg *tpg,
> > +	struct se_lun *lun, bool plug)
> 
> So this should be void too, and same for all callers, since
> eventually status is ignored.


> > +{
> > +
> > +	struct vhost_scsi *vs = tpg->vhost_scsi;
> > +	struct vhost_virtqueue *vq;
> > +	u32 reason;
> > +	int ret;
> > +
> > +	mutex_lock(&tpg->tv_tpg_mutex);
> > +	vs = tpg->vhost_scsi;
> > +	mutex_unlock(&tpg->tv_tpg_mutex);
> > +	if (!vs)
> > +		return -ENODEV;
> > +
> 
> What if clear_endpoint and close happen at this
> point? Can vhost_scsi go away so tcm_vhost_check_feature
> references freed memory?

There is no easy way to handle this. Probably, we need the flush
series to fix this.

> > +	if (!tcm_vhost_check_feature(vs, VIRTIO_SCSI_F_HOTPLUG))
> > +		return -EOPNOTSUPP;
> 
> I am nervious about lock read unlock use.
> Probably all right, but I would prefer this:
> 	mutex_lock(dev->mutex)
> 	check feature
> 	mutex_lock(&vq->mutex)
> 	mutex_unlock(&vq->mutex)
> 	mutex_unlock(dev->mutex)
> 
> so we know feature did not change meanwhile.

It is not necessary. I will leave this.

> > +
> > +	if (plug)
> > +		reason = VIRTIO_SCSI_EVT_RESET_RESCAN;
> > +	else
> > +		reason = VIRTIO_SCSI_EVT_RESET_REMOVED;
> > +
> > +	vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> > +	mutex_lock(&vq->mutex);
> > +	ret = tcm_vhost_send_evt(vs, tpg, lun,
> > +			VIRTIO_SCSI_T_TRANSPORT_RESET, reason);
> > +	mutex_unlock(&vq->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static int tcm_vhost_hotplug(struct tcm_vhost_tpg *tpg, struct se_lun *lun)
> > +{
> > +	return tcm_vhost_do_plug(tpg, lun, true);
> > +}
> > +
> > +static int tcm_vhost_hotunplug(struct tcm_vhost_tpg *tpg, struct se_lun *lun)
> > +{
> > +	return tcm_vhost_do_plug(tpg, lun, false);
> > +}
> > +
> >  static int tcm_vhost_port_link(struct se_portal_group *se_tpg,
> >  	struct se_lun *lun)
> >  {
> > @@ -1155,18 +1347,21 @@ static int tcm_vhost_port_link(struct se_portal_group *se_tpg,
> >  	tv_tpg->tv_tpg_port_count++;
> >  	mutex_unlock(&tv_tpg->tv_tpg_mutex);
> >  
> > +	tcm_vhost_hotplug(tv_tpg, lun);
> > +
> >  	return 0;
> >  }
> >  
> >  static void tcm_vhost_port_unlink(struct se_portal_group *se_tpg,
> > -	struct se_lun *se_lun)
> > +	struct se_lun *lun)
> >  {
> >  	struct tcm_vhost_tpg *tv_tpg = container_of(se_tpg,
> >  				struct tcm_vhost_tpg, se_tpg);
> > -
> 
> I like this empty line here, let's keep it around.
> It separates variables from code.

done.

> >  	mutex_lock(&tv_tpg->tv_tpg_mutex);
> >  	tv_tpg->tv_tpg_port_count--;
> >  	mutex_unlock(&tv_tpg->tv_tpg_mutex);
> > +
> > +	tcm_vhost_hotunplug(tv_tpg, lun);
> >  }
> >  
> >  static struct se_node_acl *tcm_vhost_make_nodeacl(
> > diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
> > index 1d2ae7a..94e9ee53 100644
> > --- a/drivers/vhost/tcm_vhost.h
> > +++ b/drivers/vhost/tcm_vhost.h
> > @@ -53,6 +53,7 @@ struct tcm_vhost_nacl {
> >  	struct se_node_acl se_node_acl;
> >  };
> >  
> > +struct vhost_scsi;
> >  struct tcm_vhost_tpg {
> >  	/* Vhost port target portal group tag for TCM */
> >  	u16 tport_tpgt;
> > @@ -70,6 +71,8 @@ struct tcm_vhost_tpg {
> >  	struct tcm_vhost_tport *tport;
> >  	/* Returned by tcm_vhost_make_tpg() */
> >  	struct se_portal_group se_tpg;
> > +	/* Pointer back to struct vhost_scsi, protected by tv_tpg_mutex */
> 
> Remove the text 'Pointer back to struct vhost_scsi'
> this repeats the type right below it.
> Would prefer a different name as well, e.g.
> vscsi.

I changed to 'Pointer back to vhost_scsi'.

> > +	struct vhost_scsi *vhost_scsi;
> >  };
> >  
> >  struct tcm_vhost_tport {
> > @@ -83,6 +86,13 @@ struct tcm_vhost_tport {
> >  	struct se_wwn tport_wwn;
> >  };
> >  
> > +struct tcm_vhost_evt {
> > +	/* virtio_scsi event */
> 
> /* event to be sent to guest */

okay.

> > +	struct virtio_scsi_event event;
> > +	/* virtio_scsi event list, serviced from vhost worker thread */
> 
> /* event list, serviced from vs_event_work handler */

okay.

> > +	struct llist_node list;
> > +};
> > +
> >  /*
> >   * As per request from MST, keep TCM_VHOST related ioctl defines out of
> >   * linux/vhost.h (user-space) for now..
> > -- 
> > 1.8.1.4

-- 
Asias
