From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [RFC PATCH 0/2] virtio nvme
Date: Thu, 17 Sep 2015 14:43:43 -0700
Message-ID: <1442526223.11959.9.camel__41219.3506876521$1442526248$gmane$org@haakon3.risingtidesystems.com>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
	<CAJSP0QUmtgoh23G3u64xRnBbJkAoO19AEi=vkyPPyg9n9jqC2Q@mail.gmail.com>
	<1441906098.18716.21.camel@ssi>
	<1442470241.23132.77.camel@haakon3.risingtidesystems.com>
	<CAF1ivSaOZwjg3OEdj+miXsWwbpf-Y-tmN7wmjZooxTPDQ5r9tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAF1ivSaOZwjg3OEdj+miXsWwbpf-Y-tmN7wmjZooxTPDQ5r9tg@mail.gmail.com>
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

On Thu, 2015-09-17 at 11:18 -0700, Ming Lin wrote:
> On Wed, Sep 16, 2015 at 11:10 PM, Nicholas A. Bellinger
> <nab@linux-iscsi.org> wrote:
> > Hi Ming & Co,
> >> >
> >> > At first glance it seems like the virtio_nvme guest driver is just
> >> > another block driver like virtio_blk, so I'm not clear why a
> >> > virtio-nvme device makes sense.
> >>
> >> I think the future "LIO NVMe target" only speaks NVMe protocol.
> >>
> >> Nick(CCed), could you correct me if I'm wrong?
> >>
> >> For SCSI stack, we have:
> >> virtio-scsi(guest)
> >> tcm_vhost(or vhost_scsi, host)
> >> LIO-scsi-target
> >>
> >> For NVMe stack, we'll have similar components:
> >> virtio-nvme(guest)
> >> vhost_nvme(host)
> >> LIO-NVMe-target
> >>
> >
> > I think it's more interesting to consider a 'vhost style' driver that
> > can be used with unmodified nvme host OS drivers.
> >
> > Dr. Hannes (CC'ed) had done something like this for megasas a few years
> > back using specialized QEMU emulation + eventfd based LIO fabric driver,
> > and got it working with Linux + MSFT guests.
> 
> Are the patches already in qemu upstream and LIO upstream?
> 
> I found you played it in 2010. Is it?
> [QEMU-KVM]: Megasas + TCM_Loop + SG_IO into Windows XP guests
> https://groups.google.com/forum/#!topic/linux-iscsi-target-dev/3hdaI6H3X0A
> 

AFAIK it was never submitted for kernel/QEMU upstream inclusion.

Dr Hannes, would you be so kind to put this code in a public repo to
grok as an example for nvme host-aware emulation..?

--nab
