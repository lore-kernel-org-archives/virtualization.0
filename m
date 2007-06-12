From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: More virtio users
Date: Tue, 12 Jun 2007 10:31:27 +1000
Message-ID: <1181608287.16428.127.camel__43581.0680537999$1181608845$gmane$org@localhost.localdomain>
References: <466BA965.6050208@qumranet.com>
	<1181463220.16428.24.camel@localhost.localdomain>
	<466BB34B.9050105@qumranet.com>
	<1181479060.16428.37.camel@localhost.localdomain>
	<20070611064107.GA7341@kernel.dk>
	<1181546953.16428.96.camel@localhost.localdomain>
	<20070611073300.GB21969@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070611073300.GB21969@kernel.dk>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Tejun Heo <htejun@gmail.com>, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-06-11 at 09:33 +0200, Jens Axboe wrote:
> On Mon, Jun 11 2007, Rusty Russell wrote:
> > So the problem is that I'd like to handle all of them, but I'm not clear
> > what requests my device can get.  I can't see a source of any other type
> > of request.
> 
> The other main request type is blk_pc_request(). In the data setup it's
> indentical to blk_fs_request(), there's a bio chain off ->bio. It's a
> byte granularity entity though, so you should check ->data_len for the
> size of it. ->cmd[] holds a SCSI cdb, which is the command you are
> supposed to handle.

SCSI?  I'm even more lost now.

Q: So what *are* the commands?
Q: Who puts them in my queue?

I have *never* seen anything but an fs request come through to my
driver.

> Perhaps you are misunderstanding what the tag is? The tag is a unique
> identifier for a pending request, so you will by definition never have
> requests sharing a tag value.

Yes, I started to suspect that.

> But the tag is not to be considered as
> ordered, unless it has the barrier flag set as well. So you only need to
> serialize on the device side when blk_barrier_rq() is true.

blk_barrier_rq(req) is never true.  I put a BUG_ON(blk_barrier_rq(req))
in my code and booted.  This is using the device as a root ext3
filesystem.

I reverted all the tag changes, still no barriers.  I added
"blk_queue_ordered(vblk->disk->queue, QUEUE_ORDERED_DRAIN, NULL);",
still no barriers.

Dazed and confused,
Rusty.
