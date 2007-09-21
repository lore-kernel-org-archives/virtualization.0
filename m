From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 4/6] virtio block driver
Date: Fri, 21 Sep 2007 14:27:46 +0200
Message-ID: <20070921122746.GO2367__19120.0576410212$1190377760$gmane$org@kernel.dk>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
	<1190290369.7262.231.camel@localhost.localdomain>
	<1190290495.7262.235.camel@localhost.localdomain>
	<1190290606.7262.239.camel@localhost.localdomain>
	<20070920122713.GK2367@kernel.dk>
	<1190376007.27805.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1190376007.27805.19.camel@localhost.localdomain>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, Dor Laor <dor.laor@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 21 2007, Rusty Russell wrote:
> On Thu, 2007-09-20 at 14:27 +0200, Jens Axboe wrote:
> > On Thu, Sep 20 2007, Rusty Russell wrote:
> > > The block driver uses scatter-gather lists with sg[0] being the
> > > request information (struct virtio_blk_outhdr) with the type, sector
> > > and inbuf id.  The next N sg entries are the bio itself, then the last
> > > sg is the status byte.  Whether the N entries are in or out depends on
> > > whether it's a read or a write.
> > > 
> > > We accept the normal (SCSI) ioctls: they get handed through to the other
> > > side which can then handle it or reply that it's unsupported.  It's
> > > not clear that this actually works in general, since I don't know
> > > if blk_pc_request() requests have an accurate rq_data_dir().
> > 
> > They should, if they imply a data transfer.
> 
> OK, good.  We rely on that to mark input vs output sg elements.  I was
> wondering if there was some weird requests which did both input and
> output.

There very soon will be bidirectional requests with both in and out
elements, but they will be clearly marked as such (and the driver needs
to be marked capable). So nothing to worry about for now.

> > > Although we try to reply -ENOTTY on unsupported commands, the block
> > > layer in its infinite wisdom suppressed the error so ioctl(fd,
> > > CDROMEJECT) returns success to userspace.
> > 
> > How about ever submitting a patch for that, instead of just repeatedly
> > complaining about it?
> 
> To be fair, I've left the complaint in that same patch, you're just
> reading it repeatedly 8)

That may be the case :-)

> I shall look through the code and see if I can figure out how to fix it.
> I'm assuming from your response that there's not some strange reason to
> preserve current behaviour.

It surely sounds like a bug, if you issue ioctl(fd, CDROMEJECT), the
driver sees it and returns -ENOTTY, but userland sees a 0 retval. So if
you have time, please do poke at it a bit.

-- 
Jens Axboe
