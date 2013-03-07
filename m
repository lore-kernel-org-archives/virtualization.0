From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 5/5] tcm_vhost: Add hotplug/hotunplug support
Date: Thu, 7 Mar 2013 09:58:04 +0100
Message-ID: <20130307085804.GA13214@stefanha-thinkpad.redhat.com>
References: <1362550590-3534-1-git-send-email-asias@redhat.com>
	<1362550590-3534-6-git-send-email-asias@redhat.com>
	<20130306092109.GB32480@stefanha-thinkpad.muc.redhat.com>
	<20130307002620.GA8785@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130307002620.GA8785@hj.localdomain>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 07, 2013 at 08:26:20AM +0800, Asias He wrote:
> On Wed, Mar 06, 2013 at 10:21:09AM +0100, Stefan Hajnoczi wrote:
> > On Wed, Mar 06, 2013 at 02:16:30PM +0800, Asias He wrote:
> > > +static struct tcm_vhost_evt *tcm_vhost_allocate_evt(struct vhost_scsi *vs,
> > > +	u32 event, u32 reason)
> > > +{
> > > +	struct tcm_vhost_evt *evt;
> > > +
> > > +	if (atomic_read(&vs->vs_events_nr) > VHOST_SCSI_MAX_EVENT)
> > > +		return NULL;
> > > +
> > > +	evt = kzalloc(sizeof(*evt), GFP_KERNEL);
> > > +
> > > +	if (evt) {
> > > +		atomic_inc(&vs->vs_events_nr);
> > 
> > This looks suspicious: checking vs_events_nr > VHOST_SCSI_MAX_EVENT
> > first and then incrementing later isn't atomic!
> 
> This does not matter. (1) and (2) are okay. In case (3), the other side
> can only decrease the number of event, the limit will not be exceeded.
> 
> (1) 
>    		   atomic_dec()
>    atomic_read() 
>    atomic_inc()
> (2)
>    atomic_read() 
>    atomic_inc()
>    		   atomic_dec()
> 
> (3)
>    atomic_read() 
>    		   atomic_dec()
>    atomic_inc()

The cases you listed are fine but I'm actually concerned about
tcm_vhost_allocate_evt() racing with itself.  There are 3 callers and
I'm not sure which lock prevents them from executing at the same time.

> > > +static int tcm_vhost_hotunplug(struct tcm_vhost_tpg *tpg, struct se_lun *lun)
> > > +{
> > > +	struct vhost_scsi *vs = tpg->vhost_scsi;
> > > +
> > > +	mutex_lock(&tpg->tv_tpg_mutex);
> > > +	vs = tpg->vhost_scsi;
> > > +	mutex_unlock(&tpg->tv_tpg_mutex);
> > > +	if (!vs)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (!tcm_vhost_check_feature(vs, VIRTIO_SCSI_F_HOTPLUG))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	return tcm_vhost_send_evt(vs, tpg, lun,
> > > +			VIRTIO_SCSI_T_TRANSPORT_RESET,
> > > +			VIRTIO_SCSI_EVT_RESET_REMOVED);
> > > +}
> > 
> > tcm_vhost_hotplug() and tcm_vhost_hotunplug() are the same function
> > except for VIRTIO_SCSI_EVT_RESET_RESCAN vs
> > VIRTIO_SCSI_EVT_RESET_REMOVED.  That can be passed in as an argument and
> > the code duplication can be eliminated.
> 
> I thought about this also. We can have a tcm_vhost_do_hotplug() helper.
> 
>    tcm_vhost_do_hotplug(tpg, lun, plug)
>    
>    tcm_vhost_hotplug() {
>    	tcm_vhost_do_hotplug(tpg, lun, true)
>    }
>    
>    tcm_vhost_hotunplug() {
>    	tcm_vhost_do_hotplug(tpg, lun, false)
>    }
> 
> The reason I did not do that is I do not like the true/false argument
> but anyway this could remove duplication. I will do it.

true/false makes the calling code hard to read, I suggest passing in
VIRTIO_SCSI_EVT_RESET_RESCAN or VIRTIO_SCSI_EVT_RESET_REMOVED as the
argument.

Stefan
