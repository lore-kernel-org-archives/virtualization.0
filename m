From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [RFC PATCH 0/2] virtio nvme
Date: Wed, 16 Sep 2015 23:10:41 -0700
Message-ID: <1442470241.23132.77.camel__21091.4322561168$1442470778$gmane$org@haakon3.risingtidesystems.com>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
	<CAJSP0QUmtgoh23G3u64xRnBbJkAoO19AEi=vkyPPyg9n9jqC2Q@mail.gmail.com>
	<1441906098.18716.21.camel@ssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1441906098.18716.21.camel@ssi>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lin <mlin@kernel.org>
Cc: "Minturn, Dave B" <dave.b.minturn@intel.com>, linux-nvme@lists.infradead.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, target-devel <target-devel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Hi Ming & Co,

On Thu, 2015-09-10 at 10:28 -0700, Ming Lin wrote:
> On Thu, 2015-09-10 at 15:38 +0100, Stefan Hajnoczi wrote:
> > On Thu, Sep 10, 2015 at 6:48 AM, Ming Lin <mlin@kernel.org> wrote:
> > > These 2 patches added virtio-nvme to kernel and qemu,
> > > basically modified from virtio-blk and nvme code.
> > >
> > > As title said, request for your comments.

<SNIP>

> > 
> > At first glance it seems like the virtio_nvme guest driver is just
> > another block driver like virtio_blk, so I'm not clear why a
> > virtio-nvme device makes sense.
> 
> I think the future "LIO NVMe target" only speaks NVMe protocol.
> 
> Nick(CCed), could you correct me if I'm wrong?
> 
> For SCSI stack, we have:
> virtio-scsi(guest)
> tcm_vhost(or vhost_scsi, host)
> LIO-scsi-target
> 
> For NVMe stack, we'll have similar components:
> virtio-nvme(guest)
> vhost_nvme(host)
> LIO-NVMe-target
> 

I think it's more interesting to consider a 'vhost style' driver that
can be used with unmodified nvme host OS drivers.

Dr. Hannes (CC'ed) had done something like this for megasas a few years
back using specialized QEMU emulation + eventfd based LIO fabric driver,
and got it working with Linux + MSFT guests.

Doing something similar for nvme would (potentially) be on par with
current virtio-scsi+vhost-scsi small-block performance for scsi-mq
guests, without the extra burden of a new command set specific virtio
driver.

> > 
> > > Now there are lots of duplicated code with linux/nvme-core.c and qemu/nvme.c.
> > > The ideal result is to have a multi level NVMe stack(similar as SCSI).
> > > So we can re-use the nvme code, for example
> > >
> > >                         .-------------------------.
> > >                         | NVMe device register    |
> > >   Upper level           | NVMe protocol process   |
> > >                         |                         |
> > >                         '-------------------------'
> > >
> > >
> > >
> > >               .-----------.    .-----------.    .------------------.
> > >  Lower level  |   PCIe    |    | VIRTIO    |    |NVMe over Fabrics |
> > >               |           |    |           |    |initiator         |
> > >               '-----------'    '-----------'    '------------------'
> > 
> > You mentioned LIO and SCSI.  How will NVMe over Fabrics be integrated
> > into LIO?  If it is mapped to SCSI then using virtio_scsi in the guest
> > and tcm_vhost should work.
> 
> I think it's not mapped to SCSI.
> 
> Nick, would you share more here?
> 

(Adding Dave M. CC')

So NVMe target code needs to function in at least two different modes:

- Direct mapping of nvme backend driver provided hw queues to nvme
  fabric driver provided hw queues.

- Decoding of NVMe command set for basic Read/Write/Flush I/O for 
  submission to existing backend drivers (eg: iblock, fileio, rd_mcp)

With the former case, it's safe to assumes there to be anywhere from a
very small amount of code involved, to no code involved for fast-path
operation.

For more involved logic like PR, ALUA, and EXTENDED_COPY, I think both
modes will still mostly likely handle some aspects of this in software,
and not entirely behind a backend nvme host hw interface.

--nab
