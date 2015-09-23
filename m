From: Ming Lin <mlin@kernel.org>
Subject: Re: [RFC PATCH 0/2] virtio nvme
Date: Wed, 23 Sep 2015 15:58:17 -0700
Message-ID: <1443049097.28503.13.camel@ssi>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
	<CAJSP0QUmtgoh23G3u64xRnBbJkAoO19AEi=vkyPPyg9n9jqC2Q@mail.gmail.com>
	<1441906098.18716.21.camel@ssi>
	<1442470241.23132.77.camel@haakon3.risingtidesystems.com>
	<1442532687.4750.6.camel@ssi>
	<1442537752.11959.35.camel@haakon3.risingtidesystems.com>
	<1442599957.11660.8.camel@ssi>
	<1442610544.10492.33.camel@haakon3.risingtidesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1442610544.10492.33.camel@haakon3.risingtidesystems.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: "Minturn, Dave B" <dave.b.minturn@intel.com>, linux-nvme@lists.infradead.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, target-devel <target-devel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2015-09-18 at 14:09 -0700, Nicholas A. Bellinger wrote:
> On Fri, 2015-09-18 at 11:12 -0700, Ming Lin wrote:
> > On Thu, 2015-09-17 at 17:55 -0700, Nicholas A. Bellinger wrote:
> > > On Thu, 2015-09-17 at 16:31 -0700, Ming Lin wrote:
> > > > On Wed, 2015-09-16 at 23:10 -0700, Nicholas A. Bellinger wrote:
> > > > > Hi Ming & Co,
> 
> <SNIP>
> 
> > > > > > I think the future "LIO NVMe target" only speaks NVMe protocol.
> > > > > > 
> > > > > > Nick(CCed), could you correct me if I'm wrong?
> > > > > > 
> > > > > > For SCSI stack, we have:
> > > > > > virtio-scsi(guest)
> > > > > > tcm_vhost(or vhost_scsi, host)
> > > > > > LIO-scsi-target
> > > > > > 
> > > > > > For NVMe stack, we'll have similar components:
> > > > > > virtio-nvme(guest)
> > > > > > vhost_nvme(host)
> > > > > > LIO-NVMe-target
> > > > > > 
> > > > > 
> > > > > I think it's more interesting to consider a 'vhost style' driver that
> > > > > can be used with unmodified nvme host OS drivers.
> > > > > 
> > > > > Dr. Hannes (CC'ed) had done something like this for megasas a few years
> > > > > back using specialized QEMU emulation + eventfd based LIO fabric driver,
> > > > > and got it working with Linux + MSFT guests.
> > > > > 
> > > > > Doing something similar for nvme would (potentially) be on par with
> > > > > current virtio-scsi+vhost-scsi small-block performance for scsi-mq
> > > > > guests, without the extra burden of a new command set specific virtio
> > > > > driver.
> > > > 
> > > > Trying to understand it.
> > > > Is it like below?
> > > > 
> > > >   .------------------------.   MMIO   .---------------------------------------.
> > > >   | Guest                  |--------> | Qemu                                  |
> > > >   | Unmodified NVMe driver |<-------- | NVMe device simulation(eventfd based) |
> > > >   '------------------------'          '---------------------------------------'
> > > >                                                   |          ^
> > > >                                       write NVMe  |          |  notify command
> > > >                                       command     |          |  completion
> > > >                                       to eventfd  |          |  to eventfd
> > > >                                                   v          |
> > > >                                       .--------------------------------------.
> > > >                                       | Host:                                |
> > > >                                       | eventfd based LIO NVMe fabric driver |
> > > >                                       '--------------------------------------'
> > > >                                                         |
> > > >                                                         | nvme_queue_rq()
> > > >                                                         v
> > > >                                        .--------------------------------------.
> > > >                                        | NVMe driver                          |
> > > >                                        '--------------------------------------'
> > > >                                                         |
> > > >                                                         |
> > > >                                                         v
> > > >                                        .-------------------------------------.
> > > >                                        | NVMe device                         |
> > > >                                        '-------------------------------------'
> > > > 
> > > 
> > > Correct.  The LIO driver on KVM host would be handling some amount of
> > > NVMe host interface emulation in kernel code, and would be able to
> > > decode nvme Read/Write/Flush operations and translate -> submit to
> > > existing backend drivers.
> > 
> > Let me call the "eventfd based LIO NVMe fabric driver" as
> > "tcm_eventfd_nvme"
> > 
> > Currently, LIO frontend driver(iscsi, fc, vhost-scsi etc) talk to LIO
> > backend driver(fileio, iblock etc) with SCSI commands.
> > 
> > Did you mean the "tcm_eventfd_nvme" driver need to translate NVMe
> > commands to SCSI commands and then submit to backend driver?
> > 
> 
> IBLOCK + FILEIO + RD_MCP don't speak SCSI, they simply process I/Os with
> LBA + length based on SGL memory or pass along a FLUSH with LBA +
> length.
> 
> So once the 'tcm_eventfd_nvme' driver on KVM host receives a nvme host
> hardware frame via eventfd, it would decode the frame and send along the
> Read/Write/Flush when exposing existing (non nvme native) backend
> drivers.

Learned vhost architecture:
http://blog.vmsplice.net/2011/09/qemu-internals-vhost-architecture.html

The nice thing is it is not tied to KVM in any way.

For SCSI, there are "virtio-scsi" in guest kernel and "vhost-scsi" in
host kernel.

For NVMe, there is no "virtio-nvme" in guest kernel(just unmodified NVMe
driver), but I'll do similar thing in Qemu with vhost infrastructure.
And there is "vhost_nvme" in host kernel.

For the "virtqueue" implementation in qemu-nvme, I'll possibly just
use/copy drivers/virtio/virtio_ring.c, same as what
linux/tools/virtio/virtio_test.c does.

A bit more detail graph as below. What do you think?

.-----------------------------------------.           .------------------------.
| Guest(Linux, Windows, FreeBSD, Solaris) |  NVMe     | qemu                   |
| unmodified NVMe driver                  |  command  | NVMe device emulation  |
|                                         | ------->  | vhost + virtqueue      |
'-----------------------------------------'           '------------------------'
                                                          |           |      ^
                                            passthrough   |         kick/notify
                                            NVMe command  |         via eventfd
userspace                                   via virtqueue |           |      |
                                                          v           v      |
----------------------------------------------------------------------------------
       .-----------------------------------------------------------------------.
kernel | LIO frontend driver                                                   |
       | - vhost_nvme                                                          |
       '-----------------------------------------------------------------------'
                                  |  translate       ^
                                  |  (NVMe command)  |
                                  |  to              |
                                  v  (LBA, length)   |
       .----------------------------------------------------------------------.
       | LIO backend driver                                                   |
       | - fileio (/mnt/xxx.file)                                             |
       | - iblock (/dev/sda1, /dev/nvme0n1, ...)                              |
       '----------------------------------------------------------------------'
                                  |                 ^
                                  |  submit_bio()   |
                                  v                 |
       .----------------------------------------------------------------------.
       | block layer                                                          |
       |                                                                      |
       '----------------------------------------------------------------------'
                                  |                 ^
                                  |                 |
                                  v                 |
       .----------------------------------------------------------------------.
       | block device driver                                                  |
       |                                                                      |
       '----------------------------------------------------------------------'
              |                |                  |                 |
              |                |                  |                 |
              v                v                  v                 v
       .------------.    .-----------.     .------------.   .---------------.
       | SATA       |    | SCSI      |     | NVMe       |   | ....          |
       '------------'    '-----------'     '------------'   '---------------'
