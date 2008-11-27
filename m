From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Thu, 27 Nov 2008 17:43:02 +0900
Message-ID: <1227775382.7443.43.camel__7981.36887974596$1227775563$gmane$org@sebastian.kern.oss.ntt.co.jp>
References: <20081120134701.GB29306@redhat.com>
	<20081125.113359.623571555980951312.ryov@valinux.co.jp>
	<20081125162720.GH341@redhat.com>
	<20081126.214707.653026525707335397.ryov@valinux.co.jp>
	<20081126160805.GE27826@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081126160805.GE27826@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: menage@google.com, riel@redhat.com, fchecconi@gmail.com, peterz@infradead.org, paolo.valente@unimore.it, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, taka@valinux.co.jp, jmoyer@redhat.com, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, akpm@linux-foundation.org, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2008-11-26 at 11:08 -0500, Vivek Goyal wrote:
> > > > > What do you think about the solution at IO scheduler level (like BFQ) or
> > > > > may be little above that where one can try some code sharing among IO
> > > > > schedulers? 
> > > > 
> > > > I would like to support any type of block device even if I/Os issued
> > > > to the underlying device doesn't go through IO scheduler. Dm-ioband
> > > > can be made use of for the devices such as loop device.
> > > > 
> > > 
> > > What do you mean by that IO issued to underlying device does not go
> > > through IO scheduler? loop device will be associated with a file and
> > > IO will ultimately go to the IO scheduler which is serving those file
> > > blocks?
> > 
> > How about if the files is on an NFS-mounted file system?
> > 
> 
> Interesting. So on the surface it looks like contention for disk but it
> is more the contention for network and contention for disk on NFS server.
> 
> True that leaf node IO control will not help here as IO is not going to
> leaf node at all. We can make the situation better by doing resource 
> control on network IO though.

On the client side NFS does not go through the block layer so no control
is possible there. As Vivek pointed out this could be tackled at the
network layer. Though I guess we could make do with a solution that
controls just the number of dirty pages (this would work for NFS writes
since the NFS superblock has a backing_device_info structure associated
with it).

> > > What's the use case scenario of doing IO control at loop device?
> > > Ultimately the resource contention will take place on actual underlying
> > > physical device where the file blocks are. Will doing the resource control
> > > there not solve the issue for you?
> > 
> > I don't come up with any use case, but I would like to make the
> > resource controller more flexible. Actually, a certain block device
> > that I'm using does not use the I/O scheduler.
> 
> Isn't it equivalent to using No-op? If yes, then it should not be an
> issue?

No, it is not equivalent. When using devices drivers that provide their
own make_request_fn() (check for devices that invoke
blk_queue_make_request() at initialization time) bios entering the block
layer can go directly to the device driver and from there to the device.

Regards,

Fernando
