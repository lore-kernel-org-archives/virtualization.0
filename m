From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: More virtio users
Date: Tue, 12 Jun 2007 17:52:27 +1000
Message-ID: <1181634747.6237.79.camel__24470.9322847941$1181634861$gmane$org@localhost.localdomain>
References: <466BA965.6050208@qumranet.com>
	<1181463220.16428.24.camel@localhost.localdomain>
	<466BB34B.9050105@qumranet.com>
	<1181479060.16428.37.camel@localhost.localdomain>
	<20070611064107.GA7341@kernel.dk>
	<1181546953.16428.96.camel@localhost.localdomain>
	<20070611073300.GB21969@kernel.dk>
	<1181608287.16428.127.camel@localhost.localdomain>
	<20070612062451.GN18832@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070612062451.GN18832@kernel.dk>
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

On Tue, 2007-06-12 at 08:24 +0200, Jens Axboe wrote:
> On Tue, Jun 12 2007, Rusty Russell wrote:
> > On Mon, 2007-06-11 at 09:33 +0200, Jens Axboe wrote:
> > > The other main request type is blk_pc_request(). In the data setup it's
> > > indentical to blk_fs_request(), there's a bio chain off ->bio. It's a
> > > byte granularity entity though, so you should check ->data_len for the
> > > size of it. ->cmd[] holds a SCSI cdb, which is the command you are
> > > supposed to handle.
> > 
> > SCSI?  I'm even more lost now.
> > 
> > Q: So what *are* the commands?
> 
> They are SCSI commands!
> 
> > Q: Who puts them in my queue?
> 
> If you want to support SG_IO for instance, you'd have to deal with SCSI
> commands.

I do not.  If someone wants to implement a SCSI layer over virtio, I
think that's wonderful.  Fortunately, that's not the problem I'm trying
to solve.

> -o barrier=1 for ext3, it doesn't use barriers by default.

That's, um, a little disturbing.

But, it works.  Thanks!
Rusty.
