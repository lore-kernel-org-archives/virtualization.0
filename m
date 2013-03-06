From: Asias He <asias@redhat.com>
Subject: Re: [PATCH] tcm_vhost: Add hotplug/hotunplug support
Date: Wed, 6 Mar 2013 09:28:11 +0800
Message-ID: <20130306012811.GA20372@hj.localdomain>
References: <1362475027-12018-1-git-send-email-asias@redhat.com>
	<20130305121125.GA823@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130305121125.GA823@redhat.com>
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

On Tue, Mar 05, 2013 at 02:11:25PM +0200, Michael S. Tsirkin wrote:
> On Tue, Mar 05, 2013 at 05:17:07PM +0800, Asias He wrote:
> > In commit 365a7150094 ([SCSI] virtio-scsi: hotplug support for
> > virtio-scsi), hotplug support is added to virtio-scsi.
> > 
> > This patch adds hotplug and hotunplug support to tcm_vhost.
> > 
> > You can create or delate a LUN in targetcli to hotplug or hotplug a LUN
> > in guest.
> > 
> > Signed-off-by: Asias He <asias@redhat.com>
> > ---
> >  drivers/vhost/tcm_vhost.c | 171 ++++++++++++++++++++++++++++++++++++++++++++--
> >  drivers/vhost/tcm_vhost.h |   9 +++
> >  2 files changed, 175 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> > index 9951297..6693695 100644
> > --- a/drivers/vhost/tcm_vhost.c
> > +++ b/drivers/vhost/tcm_vhost.c
> > @@ -63,6 +63,8 @@ enum {
> >  #define VHOST_SCSI_MAX_TARGET	256
> >  #define VHOST_SCSI_MAX_VQ	128
> >  
> > +#define VHOST_SCSI_FEATURES (VHOST_FEATURES | (1ULL << VIRTIO_SCSI_F_HOTPLUG))
> > +
> >  struct vhost_scsi {
> >  	/* Protected by vhost_scsi->dev.mutex */
> >  	struct tcm_vhost_tpg *vs_tpg[VHOST_SCSI_MAX_TARGET];
> > @@ -74,6 +76,11 @@ struct vhost_scsi {
> >  
> >  	struct vhost_work vs_completion_work; /* cmd completion work item */
> >  	struct llist_head vs_completion_list; /* cmd completion queue */
> > +
> > +	struct vhost_work vs_event_work; /* evt injection work item */
> > +	struct llist_head vs_event_list; /* evt injection queue */
> > +
> > +	bool vs_events_dropped;
> 
> Documentation pls.
> Also - how is this handled during migration?
> Don't we need a way for userspace to retrieve this bit?

Yes, but migration is not supported atm.

> >  };
> >  
> >  /* Local pointer to allocated TCM configfs fabric module */
> > @@ -341,6 +348,23 @@ static int tcm_vhost_queue_tm_rsp(struct se_cmd *se_cmd)
> >  	return 0;
> >  }
> >  
> > +static void tcm_vhost_free_evt(struct tcm_vhost_evt *evt)
> > +{
> > +	kfree(evt);
> > +}
> > +
> > +static struct tcm_vhost_evt *tcm_vhost_allocate_evt(u32 event, u32 reason)
> > +{
> > +	struct tcm_vhost_evt *evt;
> > +
> > +	evt = kzalloc(sizeof(*evt), GFP_KERNEL);
> 
> And if this fails?

The check was dropped when I moving around the allocate helper. Will add it back.

> > +
> > +	evt->event.event = event;
> > +	evt->event.reason = reason;
> > +
> > +	return evt;
> > +}
> > +
> >  static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
> >  {
> >  	struct se_cmd *se_cmd = &tv_cmd->tvc_se_cmd;
> > @@ -359,6 +383,71 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
> >  	kfree(tv_cmd);
> >  }
> >  
> > +static void tcm_vhost_do_evt_work(struct vhost_scsi *vs,
> > +		struct virtio_scsi_event *event)
> > +{
> > +	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> > +	struct virtio_scsi_event __user *eventp;
> > +	unsigned out, in;
> > +	int head, ret;
> > +
> > +	if (!vs || !vs->vs_endpoint)
> > +		return;
> > +
> > +	mutex_lock(&vq->mutex);
> > +again:
> > +	vhost_disable_notify(&vs->dev, vq);
> > +	head = vhost_get_vq_desc(&vs->dev, vq, vq->iov,
> > +			ARRAY_SIZE(vq->iov), &out, &in,
> > +			NULL, NULL);
> > +	if (head < 0) {
> > +		vs->vs_events_dropped = true;
> > +		goto out;
> > +	}
> > +	if (head == vq->num) {
> > +		if (vhost_enable_notify(&vs->dev, vq))
> > +			goto again;
> 
> Could you code this up using loop, without goto please?

This is not a loop actaully. We only need to grap one buffer at a time.
IMHO, It is even uglier to user a loop: 1) you need to exit the loop
arbitary at the end. 2) Extra indention.

> > +		vs->vs_events_dropped = true;
> > +		goto out;
> > +	}
> > +
> > +	if ((vq->iov[out].iov_len != sizeof(struct virtio_scsi_event))) {
> 
> We should avoid making layout assumptions. Please don't.

Other places is doing this as well, e.g vhost_scsi_handle_vq(). Will do
the conversion to no layout assumptions mode in further patches to
convert all of them.

> > +		vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
> > +				vq->iov[out].iov_len);
> > +		goto out;
> > +	}
> > +
> > +	if (vs->vs_events_dropped) {
> > +		event->event |= VIRTIO_SCSI_T_EVENTS_MISSED;
> > +		vs->vs_events_dropped = false;
> > +	}
> > +
> > +	eventp = vq->iov[out].iov_base;
> > +	ret = __copy_to_user(eventp, event, sizeof(*event));
> > +	if (!ret)
> > +		vhost_add_used_and_signal(&vs->dev, vq, head, 0);
> > +	else
> > +		pr_err("Faulted on tcm_vhost_send_event\n");
> 
> vq_err please, this is guest triggerable.

Okay. Will fix other places too.

> > +out:
> > +	mutex_unlock(&vq->mutex);
> > +}
> > +
> > +static void tcm_vhost_evt_work(struct vhost_work *work)
> > +{
> > +	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
> > +					vs_event_work);
> > +	struct tcm_vhost_evt *evt;
> > +	struct llist_node *llnode;
> > +
> > +	llnode = llist_del_all(&vs->vs_event_list);
> > +	while (llnode) {
> > +		evt = llist_entry(llnode, struct tcm_vhost_evt, list);
> > +		llnode = llist_next(llnode);
> > +		tcm_vhost_do_evt_work(vs, &evt->event);
> > +		tcm_vhost_free_evt(evt);
> > +	}
> > +}
> > +
> >  /* Fill in status and signal that we are done processing this command
> >   *
> >   * This is scheduled in the vhost work queue so we are called with the owner
> > @@ -757,9 +846,41 @@ static void vhost_scsi_ctl_handle_kick(struct vhost_work *work)
> >  	pr_debug("%s: The handling func for control queue.\n", __func__);
> >  }
> >  
> > +static int tcm_vhost_send_evt(struct vhost_scsi *vs, struct tcm_vhost_tpg *tpg,
> > +		struct se_lun *lun, u32 event, u32 reason)
> 
> Align ) on ( please.

What is the preferred alignment here? Can you elaborate?

> > +{
> > +	struct tcm_vhost_evt *evt;
> > +
> > +	if (!vs->vs_endpoint)
> > +		return -EOPNOTSUPP;
> > +
> 
> Pls add a comment explaining the abive.
> Is this dereference safe without any locking?

vs->vs_endpoint is protected by vhost_scsi->dev.mutex. It is ok to use
the lock for event vq. But for the cmd vq, it is not optimal to take the
lock in the data path. We have this in 
   vhost_scsi_handle_vq ()
   {
   	/* Must use ioctl VHOST_SCSI_SET_ENDPOINT */
   	if (unlikely(!vs->vs_endpoint))
   		return;
   }

> > +	evt = tcm_vhost_allocate_evt(event, reason);
> > +	if (!evt)
> > +		return -ENOMEM;
> 
> And what happens then? How about we set event missed flag too?

Okay.

> > +
> > +	if (tpg && lun) {
> > +		evt->event.lun[0] = 0x01;
> > +		evt->event.lun[1] = tpg->tport_tpgt & 0xFF;
> > +		if (lun->unpacked_lun >= 256)
> > +			evt->event.lun[2] = lun->unpacked_lun >> 8 | 0x40 ;
> > +		evt->event.lun[3] = lun->unpacked_lun & 0xFF;
> 
> I know it's not your fault but we really should share this code with
> virtio scsi. Pls add TODO now.

Ok.

> > +	}
> > +
> > +	llist_add(&evt->list, &vs->vs_event_list);
> 
> This can queue up quite a bit of memory if the handler thread
> is delayed, no? Can we limit the # of outstanding events?
> Will guest recover from a missed event?

Hmm, good point. Will limit the number. The size of 'struct
tcm_vhost_evt' is around 20 bytes. So if we limit it to 128, it is ~2.5K
of memory.

Paolo, if we limit the number of outstanding events and set
vs->vs_events_dropped, the guest will recover from a missed event, right?

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
> > +	if (vs->vs_events_dropped)
> > +		tcm_vhost_send_evt(vs, NULL, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
> > +
> >  }
> >  
> >  static void vhost_scsi_handle_kick(struct vhost_work *work)
> > @@ -815,6 +936,7 @@ static int vhost_scsi_set_endpoint(
> >  				return -EEXIST;
> >  			}
> >  			tv_tpg->tv_tpg_vhost_count++;
> > +			tv_tpg->vhost_scsi = vs;
> >  			vs->vs_tpg[tv_tpg->tport_tpgt] = tv_tpg;
> >  			smp_mb__after_atomic_inc();
> >  			match = true;
> > @@ -875,6 +997,7 @@ static int vhost_scsi_clear_endpoint(
> >  			goto err;
> >  		}
> >  		tv_tpg->tv_tpg_vhost_count--;
> > +		tv_tpg->vhost_scsi = NULL;
> >  		vs->vs_tpg[target] = NULL;
> >  		vs->vs_endpoint = false;
> >  	}
> > @@ -896,6 +1019,7 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
> >  		return -ENOMEM;
> >  
> >  	vhost_work_init(&s->vs_completion_work, vhost_scsi_complete_cmd_work);
> > +	vhost_work_init(&s->vs_event_work, tcm_vhost_evt_work);
> >  
> >  	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
> >  	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
> > @@ -941,7 +1065,7 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
> >  
> >  static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
> >  {
> > -	if (features & ~VHOST_FEATURES)
> > +	if (features & ~VHOST_SCSI_FEATURES)
> >  		return -EOPNOTSUPP;
> >  
> >  	mutex_lock(&vs->dev.mutex);
> > @@ -987,7 +1111,7 @@ static long vhost_scsi_ioctl(struct file *f, unsigned int ioctl,
> >  			return -EFAULT;
> >  		return 0;
> >  	case VHOST_GET_FEATURES:
> > -		features = VHOST_FEATURES;
> > +		features = VHOST_SCSI_FEATURES;
> >  		if (copy_to_user(featurep, &features, sizeof features))
> >  			return -EFAULT;
> >  		return 0;
> > @@ -1057,6 +1181,40 @@ static char *tcm_vhost_dump_proto_id(struct tcm_vhost_tport *tport)
> >  	return "Unknown";
> >  }
> >  
> > +static int tcm_vhost_hotplug(struct tcm_vhost_tpg *tpg, struct se_lun *lun)
> > +{
> > +	struct vhost_scsi *vs = tpg->vhost_scsi;
> > +	u64 features;
> > +
> > +	if (!vs)
> > +		return -EOPNOTSUPP;
> > +
> > +	features = vs->dev.acked_features;
> > +	if (!(features & 1ULL << VIRTIO_SCSI_F_HOTPLUG))
> > +		return -EOPNOTSUPP;
> > +
> > +	return tcm_vhost_send_evt(vs, tpg, lun,
> > +			VIRTIO_SCSI_T_TRANSPORT_RESET,
> > +			VIRTIO_SCSI_EVT_RESET_RESCAN);
> > +}
> > +
> > +static int tcm_vhost_hotunplug(struct tcm_vhost_tpg *tpg, struct se_lun *lun)
> > +{
> > +	struct vhost_scsi *vs = tpg->vhost_scsi;
> > +	u64 features;
> > +
> > +	if (!vs)
> > +		return -EOPNOTSUPP;
> > +
> 
> What are we checking for here, and why is it safe to do
> outside any lock?

tcm_vhost_hotplug and tcm_vhost_hotunplug might be called when
vhost-scsi is not opened. Will add the locking.

> > +	features = vs->dev.acked_features;
> > +	if (!(features & 1ULL << VIRTIO_SCSI_F_HOTPLUG))
> > +		return -EOPNOTSUPP;
> > +
> > +	return tcm_vhost_send_evt(vs, tpg, lun,
> > +			VIRTIO_SCSI_T_TRANSPORT_RESET,
> > +			VIRTIO_SCSI_EVT_RESET_REMOVED);
> > +}
> > +
> >  static int tcm_vhost_port_link(struct se_portal_group *se_tpg,
> >  	struct se_lun *lun)
> >  {
> > @@ -1067,18 +1225,21 @@ static int tcm_vhost_port_link(struct se_portal_group *se_tpg,
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
> >  	mutex_lock(&tv_tpg->tv_tpg_mutex);
> >  	tv_tpg->tv_tpg_port_count--;
> >  	mutex_unlock(&tv_tpg->tv_tpg_mutex);
> > +
> > +	tcm_vhost_hotunplug(tv_tpg, lun);
> >  }
> >  
> >  static struct se_node_acl *tcm_vhost_make_nodeacl(
> > diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
> > index 1d2ae7a..191a945 100644
> > --- a/drivers/vhost/tcm_vhost.h
> > +++ b/drivers/vhost/tcm_vhost.h
> > @@ -70,6 +70,8 @@ struct tcm_vhost_tpg {
> >  	struct tcm_vhost_tport *tport;
> >  	/* Returned by tcm_vhost_make_tpg() */
> >  	struct se_portal_group se_tpg;
> > +	/* Pointer back to struct vhost_scsi*/
> > +	void *vhost_scsi;
> 
> Does it have to be void? Any why?
> What lock protects this field? Please add a comment.

struct vhost_scsi is defined in tcm_vhost.c.
tv_tpg_mutex will protect it.

Does this look good?

diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
index 191a945..8941a54 100644
--- a/drivers/vhost/tcm_vhost.h
+++ b/drivers/vhost/tcm_vhost.h
@@ -53,6 +53,7 @@ struct tcm_vhost_nacl {
 	struct se_node_acl se_node_acl;
 };
 
+struct vhost_scsi;
 struct tcm_vhost_tpg {
 	/* Vhost port target portal group tag for TCM */
 	u16 tport_tpgt;
@@ -71,7 +72,7 @@ struct tcm_vhost_tpg {
 	/* Returned by tcm_vhost_make_tpg() */
 	struct se_portal_group se_tpg;
 	/* Pointer back to struct vhost_scsi*/
-	void *vhost_scsi;
+	struct vhost_scsi *vhost_scsi;
 };
 
 struct tcm_vhost_tport {


> >  };
> >  
> >  struct tcm_vhost_tport {
> > @@ -83,6 +85,13 @@ struct tcm_vhost_tport {
> >  	struct se_wwn tport_wwn;
> >  };
> >  
> > +struct tcm_vhost_evt {
> > +	/* virtio_scsi event */
> > +	struct virtio_scsi_event event;
> > +	/* virtio_scsi event list, serviced from vhost worker thread */
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
