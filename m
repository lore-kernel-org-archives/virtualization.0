From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: More virtio users
Date: Mon, 11 Jun 2007 08:41:09 +0200
Message-ID: <20070611064107.GA7341@kernel.dk>
References: <466BA965.6050208@qumranet.com>
	<1181463220.16428.24.camel@localhost.localdomain>
	<466BB34B.9050105@qumranet.com>
	<1181479060.16428.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1181479060.16428.37.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jun 10 2007, Rusty Russell wrote:
> On Sun, 2007-06-10 at 11:16 +0300, Avi Kivity wrote:
> > Rusty Russell wrote:
> > > Lguest doesn't have a framebuffer, so maybe this is a good thing for me
> > > to hack on, but I promised myself I'd finish NAPI for the net device,
> > > and tag for block device first.
> > >   
> > 
> > If you're touching the block device, passing a request's io priority to 
> > the host can be useful.
> 
> OK, here's the interdiff.  I still don't handle non-fs requests, but I
> haven't seen any yet.  I should probably BUG_ON() there and wait for
> Jens to scream...

Ehm no, that would certainly cause screaming :-)

Checking for blk_fs_request() and terminating the request if you don't
know how to handle it is the correct thing to do, a BUG() would
definitely not be.

Patch looks good to me, though:

> +	blk_queue_prep_rq(vblk->disk->queue, blk_queue_start_tag);
> +

is quite a novel way, I actually had to look that code up to check
whether it was correct. I'd much prefer a little wrapper around that,
ala:

static int virtio_block_prep(request_queue_t *q, struct request *rq)
{
        if (!blk_queue_start_tag(q, rq))
                return BLKPREP_OK;

        return BLKPREP_DEFER;
}

That is much easier to read, and as a bonus it wont eat your request
just because you run out of tags! The fact that blk_queue_start_tag()
just happens to share the prep_rq_fn definition is by coincidence only.

-- 
Jens Axboe
