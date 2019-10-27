From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_ring: fix packed ring event may missing
Date: Sun, 27 Oct 2019 05:09:14 -0400
Message-ID: <20191027050845-mutt-send-email-mst@kernel.org>
References: <20191021171004.18729-1-yong.liu@intel.com>
	<20191025052401-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191025052401-mutt-send-email-mst@kernel.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marvin Liu <yong.liu@intel.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 25, 2019 at 05:32:49AM -0400, Michael S. Tsirkin wrote:
> On Tue, Oct 22, 2019 at 01:10:04AM +0800, Marvin Liu wrote:
> > When callback is delayed, virtio expect that vhost will kick when
> > rolling over event offset. Recheck should be taken as used index may
> > exceed event offset between status check and driver event update.
> > 
> > However, it is possible that flags was not modified if descriptors are
> > chained or in_order feature was negotiated. So flags at event offset
> 
> This mention of event offset I don't understand: your patch
> only affects code that runs when !event. So how can it
> affect event offset?
> 
> 
> 
> > may not be valid for descriptor's status checking. Fix it by using last
> > used index as replacement. Tx queue will be stopped if there's not
> > enough freed buffers after recheck.
> > 
> > Signed-off-by: Marvin Liu <yong.liu@intel.com>
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index bdc08244a648..a8041e451e9e 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1499,9 +1499,6 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> >  		 * counter first before updating event flags.
> >  		 */
> >  		virtio_wmb(vq->weak_barriers);
> > -	} else {
> > -		used_idx = vq->last_used_idx;
> > -		wrap_counter = vq->packed.used_wrap_counter;
> >  	}
> 
> 
> Is all this theorectical? Or did you actually see a problem
> and then fixed it?
> Because as far as I could see after this patch and with
> event index off, used_idx and wrap_counter will be used
> without being initialized.
> 
> OTOH the behaviour with event index on is completely unaffected.
> 
> 
> >  
> >  	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DISABLE) {
> 
> OK so trying to unpack the scenario.
> 
> First you patch only affects code running when EVENT_IDX is off, so
> legal values for flags are enable and disable.
> 
> 
> Next point, this calculates the index at which we are going
> to look for the flags to change, in other words
> it affects the line
>         if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
> below.
> 
> Without your patch, we simply look at the next descriptor.
> This is exactly what the spec says we should do:
> 
> 	Writes of device and driver descriptors can generally be
> 	reordered, but each side (driver and device) are only required to
> 	poll (or test) a single location in memory: the next device descriptor after
> 	the one they processed previously, in circular order.
> 

OK please ignore all this, I misunderstood the patch. Sorry about the
noise.


> 
> 
> 
> 
> > @@ -1518,7 +1515,9 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> >  	 */
> >  	virtio_mb(vq->weak_barriers);
> >  
> > -	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
> > +	if (is_used_desc_packed(vq,
> > +				vq->last_used_idx,
> > +				vq->packed.used_wrap_counter)) {
> >  		END_USE(vq);
> >  		return false;
> >  	}
> > -- 
> > 2.17.1
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
