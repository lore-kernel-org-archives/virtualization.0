From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio: (Partially) enable suspend/resume support
Date: Tue, 5 Oct 2010 17:23:19 +0200
Message-ID: <20101005152319.GA22056@redhat.com>
References: <da50daa251eb982c43fa474de8d4f1303f1ad57f.1285762305.git.amit.shah@redhat.com>
	<20101003155359.GB20285@redhat.com>
	<20101005134531.GD8207@amit-laptop.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20101005134531.GD8207@amit-laptop.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 05, 2010 at 07:15:31PM +0530, Amit Shah wrote:
> > > +
> > > +	spin_lock_irqsave(&vp_dev->lock, flags);
> > > +	list_for_each_entry(info, &vp_dev->virtqueues, node) {
> > > +		/* Select the queue we're interested in */
> > > +		iowrite16(info->queue_index,
> > > +			  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> > > +
> > > +		/* Update the last idx we sent data in */
> > > +		iowrite16(virtqueue_get_avail_idx(info->vq),
> > > +			  vp_dev->ioaddr + VIRTIO_PCI_AVAIL_IDX);
> > 
> > Interesting. Could we just reset the ring instead?
> > I think this would also solve the qemu problem you
> > outline, won't it?
> 
> The problem here is qemu doesn't "know" we went into suspend and came
> out of it.  When going to suspend, qemu could've received a kick
> notification and would've been just about to process some queue entries.
> Now when we resume and reset the ring, qemu could crash anyway seeing
> invalid index values.

Hmm, I don't completely understand this.  When there's a reset I expect
this to discard any previous kicks. No?

>  I think that's happening now anyway.

How can one reproduce this?
