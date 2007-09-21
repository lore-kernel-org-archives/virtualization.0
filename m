From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 4/6] virtio block driver
Date: Fri, 21 Sep 2007 12:06:07 +1000
Message-ID: <1190340367.19451.40.camel@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
	<1190290369.7262.231.camel@localhost.localdomain>
	<1190290495.7262.235.camel@localhost.localdomain>
	<1190290606.7262.239.camel@localhost.localdomain>
	<20070920130519.GL2367@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070920130519.GL2367@kernel.dk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, Dor Laor <dor.laor@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-09-20 at 15:05 +0200, Jens Axboe wrote:
> On Thu, Sep 20 2007, Rusty Russell wrote:
> > +static void end_dequeued_request(struct request *req,
> > +				 struct request_queue *q, int uptodate)
> > +{
> > +	/* And so the insanity of the block layer infects us here. */
> > +	int nsectors = req->hard_nr_sectors;
> > +
> > +	if (blk_pc_request(req)) {
> > +		nsectors = (req->data_len + 511) >> 9;
> > +		if (!nsectors)
> > +			nsectors = 1;
> > +	}
> > +	if (end_that_request_first(req, uptodate, nsectors))
> > +		BUG();
> > +	add_disk_randomness(req->rq_disk);
> > +	end_that_request_last(req, uptodate);
> > +}
> 
> We have end_queued_request(), lets add end_dequeued_request(). Below.

OK, thanks, I'll throw that in the mix and test...

> > +	vblk->sg[0].page = virt_to_page(&vbr->out_hdr);
> > +	vblk->sg[0].offset = offset_in_page(&vbr->out_hdr);
> > +	vblk->sg[0].length = sizeof(vbr->out_hdr);
> > +	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);
> 
> This wont work for chained sglists, but I gather (I'm so funny) that it
> wont be an issue for you. How large are your sglists?

Hmm, potentially extremely large.  What do I need to do for chained
sglists?

> > +		if (!do_req(q, vblk, req)) {
> > +			/* Queue full?  Wait. */
> > +			blk_stop_queue(q);
> > +			break;
> > +		}
> 
> Personally I think this bool stuff is foul. You return false/true, but
> still use ! to test. That is just more confusing than the canonical 0/1
> good/bad return imho.

Except "0/1" is not canonical in the kernel.  Arguably, "-errno/0" is
canonical.  OTOH, bool is clear.

if do_req() fails, we assume the queue is full.  I shall change the
comment to that effect.

Thanks!
Rusty.
