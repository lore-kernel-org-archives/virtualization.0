From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_ring: fix packed ring event may missing
Date: Sun, 27 Oct 2019 05:12:34 -0400
Message-ID: <20191027051044-mutt-send-email-mst@kernel.org>
References: <20191021171004.18729-1-yong.liu@intel.com>
	<20191025063511-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191025063511-mutt-send-email-mst@kernel.org>
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

On Fri, Oct 25, 2019 at 06:53:55AM -0400, Michael S. Tsirkin wrote:
> On Tue, Oct 22, 2019 at 01:10:04AM +0800, Marvin Liu wrote:
> > When callback is delayed, virtio expect that vhost will kick when
> > rolling over event offset. Recheck should be taken as used index may
> > exceed event offset between status check and driver event update.
> > 
> > However, it is possible that flags was not modified if descriptors are
> > chained or in_order feature was negotiated. So flags at event offset
> > may not be valid for descriptor's status checking. Fix it by using last
> > used index as replacement. Tx queue will be stopped if there's not
> > enough freed buffers after recheck.
> > 
> > Signed-off-by: Marvin Liu <yong.liu@intel.com>
> 
> So as I wrote separately, I don't think the patch is correct.  And it
> doesn't look like it was tested properly.

I was wrong to say this: the patch is correct.

Thanks for working on this, and sorry about creating the confusion.

It might not be the
optimal thing to do but it fixes a real bug, so I think it's
a good idea to merge it for now, and implement optimizations on top.

>  However, I do think
> virtqueue_enable_cb_delayed_packed is implemented incorrectly in case of
> chained s/g and ring that is close to being full.  It's just that
> chained only happens on OOM at the moment, so it's hard to trigger.
> virtio_ring.c can be hacked to force chained to make it trigger more.
> And with napi_tx the default this function is barely used at all.
> 
> So it's hard to test, and I think in this area we really should include
> info on how patch was tested before applying.
> 
> 
> But just theoretically speaking I agree: the trick
> virtqueue_enable_cb_delayed_packed is using to check that 3/4 of the
> ring has been used just by looking at a single s/g entry can't work
> reliably.
> 
> We generally really need to scan the ring.  How much to scan?  If we
> want to implement this efficiently, I propose that we track the number
> of outstanding bufs.  Then # of s/g - # of bufs is the max number of
> entries we need to scan. For the common case of a single s/g this will
> give exactly 0.
> 
> 
> Alternatively, we can just scan the whole ring up to the index using the
> standard logic. virtqueue_enable_cb_delayed_packed is rare enough.
> 
> 
> 
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
> >  
> >  	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DISABLE) {
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
