From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [RFC PATCH 0/2] virtio nvme
Date: Sat, 26 Sep 2015 22:01:56 -0700
Message-ID: <1443330116.15432.57.camel__18883.9937480681$1443330167$gmane$org@haakon3.risingtidesystems.com>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
	<CAJSP0QUmtgoh23G3u64xRnBbJkAoO19AEi=vkyPPyg9n9jqC2Q@mail.gmail.com>
	<1441906098.18716.21.camel@ssi>
	<1442470241.23132.77.camel@haakon3.risingtidesystems.com>
	<1442532687.4750.6.camel@ssi>
	<1442537752.11959.35.camel@haakon3.risingtidesystems.com>
	<1442599957.11660.8.camel@ssi>
	<1442610544.10492.33.camel@haakon3.risingtidesystems.com>
	<1443049097.28503.13.camel@ssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1443049097.28503.13.camel@ssi>
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
Cc: "Minturn, Dave B" <dave.b.minturn@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-nvme@lists.infradead.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, target-devel <target-devel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2015-09-23 at 15:58 -0700, Ming Lin wrote:
> On Fri, 2015-09-18 at 14:09 -0700, Nicholas A. Bellinger wrote:
> > On Fri, 2015-09-18 at 11:12 -0700, Ming Lin wrote:
> > > On Thu, 2015-09-17 at 17:55 -0700, Nicholas A. Bellinger wrote:

<SNIP>

> > IBLOCK + FILEIO + RD_MCP don't speak SCSI, they simply process I/Os with
> > LBA + length based on SGL memory or pass along a FLUSH with LBA +
> > length.
> > 
> > So once the 'tcm_eventfd_nvme' driver on KVM host receives a nvme host
> > hardware frame via eventfd, it would decode the frame and send along the
> > Read/Write/Flush when exposing existing (non nvme native) backend
> > drivers.
> 
> Learned vhost architecture:
> http://blog.vmsplice.net/2011/09/qemu-internals-vhost-architecture.html
> 
> The nice thing is it is not tied to KVM in any way.
> 

Yes.

There are assumptions vhost currently makes about the guest using virtio
queues however, and at least for an initial vhost_nvme prototype it's
probably easier to avoid hacking up drivers/vhost/* (for now)..

(Adding MST CC')

> For SCSI, there are "virtio-scsi" in guest kernel and "vhost-scsi" in
> host kernel.
> 
> For NVMe, there is no "virtio-nvme" in guest kernel(just unmodified NVMe
> driver), but I'll do similar thing in Qemu with vhost infrastructure.
> And there is "vhost_nvme" in host kernel.
> 
> For the "virtqueue" implementation in qemu-nvme, I'll possibly just
> use/copy drivers/virtio/virtio_ring.c, same as what
> linux/tools/virtio/virtio_test.c does.
> 
> A bit more detail graph as below. What do you think?
> 
> .-----------------------------------------.           .------------------------.
> | Guest(Linux, Windows, FreeBSD, Solaris) |  NVMe     | qemu                   |
> | unmodified NVMe driver                  |  command  | NVMe device emulation  |
> |                                         | ------->  | vhost + virtqueue      |
> '-----------------------------------------'           '------------------------'
>                                                           |           |      ^
>                                             passthrough   |         kick/notify
>                                             NVMe command  |         via eventfd
> userspace                                   via virtqueue |           |      |
>                                                           v           v      |
> ----------------------------------------------------------------------------------

This should read something like:

Passthrough of nvme hardware frames via QEMU PCI-e struct vhost_mem into
a custom vhost_nvme kernel driver ioctl using struct file + struct
eventfd_ctx primitives.

Eg: QEMU user-space is not performing the nvme command decode before
passing emulated nvme hardware frame up to host kernel driver.

>        .-----------------------------------------------------------------------.
> kernel | LIO frontend driver                                                   |
>        | - vhost_nvme                                                          |
>        '-----------------------------------------------------------------------'
>                                   |  translate       ^
>                                   |  (NVMe command)  |
>                                   |  to              |
>                                   v  (LBA, length)   |

vhost_nvme is performing host kernel level decode of user-space provided
nvme hardware frames into nvme command + LBA +length + SGL buffer for
target backend driver submission

>        .----------------------------------------------------------------------.
>        | LIO backend driver                                                   |
>        | - fileio (/mnt/xxx.file)                                             |
>        | - iblock (/dev/sda1, /dev/nvme0n1, ...)                              |
>        '----------------------------------------------------------------------'
>                                   |                 ^
>                                   |  submit_bio()   |
>                                   v                 |
>        .----------------------------------------------------------------------.
>        | block layer                                                          |
>        |                                                                      |
>        '----------------------------------------------------------------------'

For this part, HCH mentioned he is currently working on some code to
pass native NVMe commands + SGL memory via blk-mq struct request into
struct nvme_dev and/or struct nvme_queue.

>                                   |                 ^
>                                   |                 |
>                                   v                 |
>        .----------------------------------------------------------------------.
>        | block device driver                                                  |
>        |                                                                      |
>        '----------------------------------------------------------------------'
>               |                |                  |                 |
>               |                |                  |                 |
>               v                v                  v                 v
>        .------------.    .-----------.     .------------.   .---------------.
>        | SATA       |    | SCSI      |     | NVMe       |   | ....          |
>        '------------'    '-----------'     '------------'   '---------------'
> 
> 

Looks fine.

Btw, after chatting with Dr. Hannes this week at SDC here are his
original rts-megasas -v6 patches from Feb 2013.

Note they are standalone patches that require a sufficiently old enough
LIO + QEMU to actually build + function.

https://github.com/Datera/rts-megasas/blob/master/rts_megasas-qemu-v6.patch
https://github.com/Datera/rts-megasas/blob/master/rts_megasas-fabric-v6.patch

For groking purposes, they demonstrate the principle design for a host
kernel level driver, along with the megasas firmware interface (MFI)
specific emulation magic that makes up the bulk of the code.

Take a look.

--nab
