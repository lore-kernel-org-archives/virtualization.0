From: Asias He <asias@redhat.com>
Subject: Re: [PATCH v7 3/3] tcm_vhost: Add hotplug/hotunplug support
Date: Tue, 23 Apr 2013 12:45:10 +0800
Message-ID: <20130423044510.GA30397@hj.localdomain>
References: <1366247154-3136-4-git-send-email-asias@redhat.com>
	<20130418073429.GE13787@redhat.com>
	<20130418085908.GD13554@hj.localdomain>
	<20130418082154.GA16167@redhat.com>
	<20130419023410.GA18829@hj.localdomain>
	<20130420190131.GA853@redhat.com>
	<20130422092024.GB21692@hj.localdomain>
	<20130422131704.GA5777@redhat.com>
	<20130422152226.GB23376@hj.localdomain>
	<87li89g9qs.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87li89g9qs.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 23, 2013 at 01:48:51PM +0930, Rusty Russell wrote:
> Asias He <asias@redhat.com> writes:
> > On Mon, Apr 22, 2013 at 04:17:04PM +0300, Michael S. Tsirkin wrote:
> >> > > > > > > > +	evt = kzalloc(sizeof(*evt), GFP_KERNEL);
> >> > > > > > > 
> >> > > > > > > I think kzalloc not needed here, you init all fields.
> >> > > > > > 
> >> > > > > > Not really! evt->event.lun[4-7] is not initialized. It needs to be 0.
> >> > > > > 
> >> > > > > So that is 4 bytes just init them when you set rest of lun.
> >> > > > 
> >> > > > It is not in the fast path. You can do it this way but not a must.
> >> > > 
> >> > > I think that's a bit cleaner than relying on kzalloc to zero-initialize.
> >> > 
> >> > I think it is a bit shorter, 4 lines saved. 
> >> 
> >> OTOH you don't have to think "what about the rest of the bytes?" then
> >> hunt through the code and go "ah, it's kzalloc".
> >> Looks it's a style issue but I prefer explicit initialization.
> >
> > It is just make none sense to argue about this. If you really want you
> > can make patches to remove all the lines where use kzalloc because it is
> > cleaner.
> 
> I prefer explicit initialization too, FWIW.

I do not really care. I am OK with either way.

> >> > > > > > > > +static void tcm_vhost_do_evt_work(struct vhost_scsi *vs,
> >> > > > > > > > +	struct tcm_vhost_evt *evt)
> >> > > > > > > > +{
> >> > > > > > > > +	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
> >> > > > > > > > +	struct virtio_scsi_event *event = &evt->event;
> >> > > > > > > > +	struct virtio_scsi_event __user *eventp;
> >> > > > > > > > +	unsigned out, in;
> >> > > > > > > > +	int head, ret;
> >> > > > > > > > +
> >> > > > > > > > +	if (!tcm_vhost_check_endpoint(vq))
> >> > > > > > > > +		return;
> >> > > > > > > > +
> >> > > > > > > > +	mutex_lock(&vs->vs_events_lock);
> >> > > > > > > > +	mutex_lock(&vq->mutex);
> >> > > > > > > > +again:
> >> > > > > > > > +	vhost_disable_notify(&vs->dev, vq);
> >> > > > > > > > +	head = vhost_get_vq_desc(&vs->dev, vq, vq->iov,
> >> > > > > > > > +			ARRAY_SIZE(vq->iov), &out, &in,
> >> > > > > > > > +			NULL, NULL);
> >> > > > > > > > +	if (head < 0) {
> >> > > > > > > > +		vs->vs_events_dropped = true;
> >> > > > > > > > +		goto out;
> >> > > > > > > > +	}
> >> > > > > > > > +	if (head == vq->num) {
> >> > > > > > > > +		if (vhost_enable_notify(&vs->dev, vq))
> >> > > > > > > > +			goto again;
> >> > > > > > > 
> >> > > > > > > Please write loops with while() or for().
> >> > > > > > > Not with goto. goto is for error handling.
> >> > > > > > 
> >> > > > > > This makes extra indention which is more ugly.
> >> > > > > 
> >> > > > > I don't care. No loops with goto and that's a hard rule.
> >> > > > 
> >> > > > It is not a loop.
> >> > > 
> >> > > If same code repeats, it's a loop.
> >> > 
> >> > We really need here is to call vhost_get_vq_desc once. It's not a loop
> >> > like other places to use while() or for() with vhost_get_vq_desc.
> >> 
> >> Exactly. Like a mutex for example? We only need to
> >> lock it once. See __mutex_lock_common - uses a for loop,
> >> doesn't it?
> >
> > So what?
> >
> >> So fix this please, use while or for or even until.
> >
> > I do not think it is necessary.
> 
> I tend to use again: in such corner cases, where I don't expect it to
> be invoked very often.  A do loop looks too normal.
> 
> I do exactly the same thing in virtio-net.c, for the same case.
> 
> Would you like me to review the entire thing?

Sure. Thanks Rusty!

> Cheers,
> Rusty.

-- 
Asias
