From: Ming Lin <mlin@kernel.org>
Subject: Re: [RFC PATCH 0/2] virtio nvme
Date: Fri, 18 Sep 2015 11:12:37 -0700
Message-ID: <1442599957.11660.8.camel__19539.7930605852$1442599984$gmane$org@ssi>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
	<CAJSP0QUmtgoh23G3u64xRnBbJkAoO19AEi=vkyPPyg9n9jqC2Q@mail.gmail.com>
	<1441906098.18716.21.camel@ssi>
	<1442470241.23132.77.camel@haakon3.risingtidesystems.com>
	<1442532687.4750.6.camel@ssi>
	<1442537752.11959.35.camel@haakon3.risingtidesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1442537752.11959.35.camel@haakon3.risingtidesystems.com>
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

On Thu, 2015-09-17 at 17:55 -0700, Nicholas A. Bellinger wrote:
> On Thu, 2015-09-17 at 16:31 -0700, Ming Lin wrote:
> > On Wed, 2015-09-16 at 23:10 -0700, Nicholas A. Bellinger wrote:
> > > Hi Ming & Co,
> > > 
> > > On Thu, 2015-09-10 at 10:28 -0700, Ming Lin wrote:
> > > > On Thu, 2015-09-10 at 15:38 +0100, Stefan Hajnoczi wrote:
> > > > > On Thu, Sep 10, 2015 at 6:48 AM, Ming Lin <mlin@kernel.org> wrote:
> > > > > > These 2 patches added virtio-nvme to kernel and qemu,
> > > > > > basically modified from virtio-blk and nvme code.
> > > > > >
> > > > > > As title said, request for your comments.
> > > 
> > > <SNIP>
> > > 
> > > > > 
> > > > > At first glance it seems like the virtio_nvme guest driver is just
> > > > > another block driver like virtio_blk, so I'm not clear why a
> > > > > virtio-nvme device makes sense.
> > > > 
> > > > I think the future "LIO NVMe target" only speaks NVMe protocol.
> > > > 
> > > > Nick(CCed), could you correct me if I'm wrong?
> > > > 
> > > > For SCSI stack, we have:
> > > > virtio-scsi(guest)
> > > > tcm_vhost(or vhost_scsi, host)
> > > > LIO-scsi-target
> > > > 
> > > > For NVMe stack, we'll have similar components:
> > > > virtio-nvme(guest)
> > > > vhost_nvme(host)
> > > > LIO-NVMe-target
> > > > 
> > > 
> > > I think it's more interesting to consider a 'vhost style' driver that
> > > can be used with unmodified nvme host OS drivers.
> > > 
> > > Dr. Hannes (CC'ed) had done something like this for megasas a few years
> > > back using specialized QEMU emulation + eventfd based LIO fabric driver,
> > > and got it working with Linux + MSFT guests.
> > > 
> > > Doing something similar for nvme would (potentially) be on par with
> > > current virtio-scsi+vhost-scsi small-block performance for scsi-mq
> > > guests, without the extra burden of a new command set specific virtio
> > > driver.
> > 
> > Trying to understand it.
> > Is it like below?
> > 
> >   .------------------------.   MMIO   .---------------------------------------.
> >   | Guest                  |--------> | Qemu                                  |
> >   | Unmodified NVMe driver |<-------- | NVMe device simulation(eventfd based) |
> >   '------------------------'          '---------------------------------------'
> >                                                   |          ^
> >                                       write NVMe  |          |  notify command
> >                                       command     |          |  completion
> >                                       to eventfd  |          |  to eventfd
> >                                                   v          |
> >                                       .--------------------------------------.
> >                                       | Host:                                |
> >                                       | eventfd based LIO NVMe fabric driver |
> >                                       '--------------------------------------'
> >                                                         |
> >                                                         | nvme_queue_rq()
> >                                                         v
> >                                        .--------------------------------------.
> >                                        | NVMe driver                          |
> >                                        '--------------------------------------'
> >                                                         |
> >                                                         |
> >                                                         v
> >                                        .-------------------------------------.
> >                                        | NVMe device                         |
> >                                        '-------------------------------------'
> > 
> 
> Correct.  The LIO driver on KVM host would be handling some amount of
> NVMe host interface emulation in kernel code, and would be able to
> decode nvme Read/Write/Flush operations and translate -> submit to
> existing backend drivers.

Let me call the "eventfd based LIO NVMe fabric driver" as
"tcm_eventfd_nvme"

Currently, LIO frontend driver(iscsi, fc, vhost-scsi etc) talk to LIO
backend driver(fileio, iblock etc) with SCSI commands.

Did you mean the "tcm_eventfd_nvme" driver need to translate NVMe
commands to SCSI commands and then submit to backend driver?

But I thought the future "LIO NVMe target" can support frontend driver
talk to backend driver directly with NVMe commands without translation.

Am I wrong?

> 
> As with the nvme-over-fabric case, it would be possible to do a mapping
> between backend driver queue resources for real NVMe hardware (eg:
> target_core_nvme), but since it would still be doing close to the same
> amount of software emulation for both backend driver cases, I wouldn't
> expect there to be much performance advantage over just using normal
> submit_bio().
> 
> --nab
> 
