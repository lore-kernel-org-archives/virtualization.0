From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 4/6] virtio block driver
Date: Fri, 21 Sep 2007 22:30:11 +1000
Message-ID: <1190377811.27805.39.camel__16890.06542224$1190378059$gmane$org@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
	<1190290369.7262.231.camel@localhost.localdomain>
	<1190290495.7262.235.camel@localhost.localdomain>
	<1190290606.7262.239.camel@localhost.localdomain>
	<20070920130519.GL2367@kernel.dk>
	<1190340367.19451.40.camel@localhost.localdomain>
	<20070921114703.GN2367@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070921114703.GN2367@kernel.dk>
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

On Fri, 2007-09-21 at 13:47 +0200, Jens Axboe wrote:
> On Fri, Sep 21 2007, Rusty Russell wrote:
> > On Thu, 2007-09-20 at 15:05 +0200, Jens Axboe wrote:
> > > We have end_queued_request(), lets add end_dequeued_request(). Below.
> > 
> > OK, thanks, I'll throw that in the mix and test...
> 
> I've queued it for 2.6.24 as well, so should be in mainline in that time
> frame.

OK, I'll sit it in my queue so my patches work until then.

> > > > +	vblk->sg[0].page = virt_to_page(&vbr->out_hdr);
> > > > +	vblk->sg[0].offset = offset_in_page(&vbr->out_hdr);
> > > > +	vblk->sg[0].length = sizeof(vbr->out_hdr);
> > > > +	num = blk_rq_map_sg(q, vbr->req, vblk->sg+1);
> > > 
> > > This wont work for chained sglists, but I gather (I'm so funny) that it
> > > wont be an issue for you. How large are your sglists?
> > 
> > Hmm, potentially extremely large.  What do I need to do for chained
> > sglists?
> 
> Not a lot, actually. You snipped the problematic part in your reply,
> though:
> 
>         vblk->sg[num+1].page = virt_to_page(&vbr->in_hdr);
> 
> which assumes that sg is a contigious piece of memory, for chained sg
> lists that isn't true. sg chaining will be in 2.6.24, so if you really
> do need large sglists, then that's the way to go.

I'm not sure if I need large sglists here.  Obviously I want to handle
anything the block layer can give to me (assume you're going to increase
MAX_PHYS_SEGMENTS soon?).  This might make "vblk" too big to kmalloc
easily:

        struct virtio_blk
        {
        ...
        	/* Scatterlist: can be too big for stack. */
        	struct scatterlist sg[3+MAX_PHYS_SEGMENTS];
        };

The sglist for virtio is really a scratch space to represent the request
buffers (with one element for metadata at start and one at end) which we
hand through to the virtio layer which turns it into its internal
descriptors for the host to read.

Have you thought of putting an sglist inside the req itself?  Then
instead of blk_rq_map_sg() it'd just be req->sg?  It could just be a
chain of sg's in each bio I guess.

This would allow me to just to borrow that request sg chain, rather than
doing the req -> sg -> virtio double-conversion.

> > Except "0/1" is not canonical in the kernel.  Arguably, "-errno/0" is
> > canonical.  OTOH, bool is clear.
> 
> -errno/0, then. 1 is typically used for 'failure without specific error
> number' when -Exx doesn't apply. Like the above :-)

See, I'd be absolutely sure that >= 0 is success (like all syscalls),
and I'd be appalled by code which used it as failure.

So I think you're right that we should agree to disagree :)

Thanks!
Rusty.
