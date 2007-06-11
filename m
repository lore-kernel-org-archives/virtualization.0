From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: More virtio users
Date: Mon, 11 Jun 2007 17:29:13 +1000
Message-ID: <1181546953.16428.96.camel__23164.7632121623$1181547067$gmane$org@localhost.localdomain>
References: <466BA965.6050208@qumranet.com>
	<1181463220.16428.24.camel@localhost.localdomain>
	<466BB34B.9050105@qumranet.com>
	<1181479060.16428.37.camel@localhost.localdomain>
	<20070611064107.GA7341@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070611064107.GA7341@kernel.dk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <jens.axboe@oracle.com>, Tejun Heo <htejun@gmail.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-06-11 at 08:41 +0200, Jens Axboe wrote:
> On Sun, Jun 10 2007, Rusty Russell wrote:
> > On Sun, 2007-06-10 at 11:16 +0300, Avi Kivity wrote:
> > > Rusty Russell wrote:
> > > > Lguest doesn't have a framebuffer, so maybe this is a good thing for me
> > > > to hack on, but I promised myself I'd finish NAPI for the net device,
> > > > and tag for block device first.
> > > >   
> > > 
> > > If you're touching the block device, passing a request's io priority to 
> > > the host can be useful.
> > 
> > OK, here's the interdiff.  I still don't handle non-fs requests, but I
> > haven't seen any yet.  I should probably BUG_ON() there and wait for
> > Jens to scream...
> 
> Ehm no, that would certainly cause screaming :-)
> 
> Checking for blk_fs_request() and terminating the request if you don't
> know how to handle it is the correct thing to do, a BUG() would
> definitely not be.

So the problem is that I'd like to handle all of them, but I'm not clear
what requests my device can get.  I can't see a source of any other type
of request.

> > +	blk_queue_prep_rq(vblk->disk->queue, blk_queue_start_tag);
> > +
> 
> is quite a novel way, I actually had to look that code up to check
> whether it was correct. I'd much prefer a little wrapper around that,

OK, but I got it from the blk_queue_start_tag documentation:

 *  Description:
 *    This can either be used as a stand-alone helper, or possibly be
 *    assigned as the queue &prep_rq_fn (in which case &struct request
 *    automagically gets a tag assigned). Note that this function
 *    assumes that any type of request can be queued! 

I'm unsure on the whole ordered tag idea, though.  It seems like there
are never be multiple requests in the queue with the same tag, so it
effectively forces my (userspace) virtio server to serialize and
fdatasync on every write request:

		if (outhdr->type && outhdr->tag != vblk->last_tag) {
			while (vblk->in_progress)
				handle_io_finish(fd, dev);
			fdatasync(fd);
			vblk->last_tag = outhdr->tag;
		}


In fact, AFAICT any implementation of ordered tags will be forced into
serial order.  Am I better off telling the block layer to drain and
flush instead of ordered tags?  I can then push that through to the
virtio server.

Thanks,
Rusty.
