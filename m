From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [systemd-devel] udev virtio by-path naming
Date: Wed, 1 Mar 2017 18:44:39 +0000
Message-ID: <20170301184439.GS10160__27306.5820373178$1488393897$gmane$org@redhat.com>
References: <de55b0f4-4582-cf06-4b0d-12c2282406a8@linux.vnet.ibm.com>
	<20170220170041.68c9bf4f.cornelia.huck@de.ibm.com>
	<9cb1f5ff-0a5b-4d0a-16f6-887c7658795a@linux.vnet.ibm.com>
	<CALVzVJZhZTNbZp1EB9cT82YxUnbUZZ+ZPo7Od8CWz5C3faN1AA@mail.gmail.com>
	<14ac3e2c-180b-cb18-fd68-268dc5d85f8b@linux.vnet.ibm.com>
	<20170301033007.GG29552@in.waw.pl>
	<7de4f313-d3a6-b50d-4e53-3b01d6f0f2a0@linux.vnet.ibm.com>
	<20170301155812.GG10160@redhat.com>
	<f6dfe52a-4332-90fc-a426-712453a8c382@linux.vnet.ibm.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f6dfe52a-4332-90fc-a426-712453a8c382@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: systemd-devel <systemd-devel@lists.freedesktop.org>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Michal Sekletar <msekleta@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 01, 2017 at 07:28:46PM +0100, Viktor Mihajlovski wrote:
> On 01.03.2017 16:58, Daniel P. Berrange wrote:
> > given a basic Fedora 25 guest, with a virtio-mmio disk added as per the
> > guide above...
> > 
> >   looking at device '/devices/platform/a003e00.virtio_mmio/virtio3/block/vda':
> >     KERNEL=="vda"
> >     SUBSYSTEM=="block"
> >     DRIVER==""
> >     ATTR{alignment_offset}=="0"
> >     ATTR{badblocks}==""
> >     ATTR{cache_type}=="write back"
> >     ATTR{capability}=="50"
> >     ATTR{discard_alignment}=="0"
> >     ATTR{ext_range}=="256"
> >     ATTR{inflight}=="       0        0"
> >     ATTR{range}=="16"
> >     ATTR{removable}=="0"
> >     ATTR{ro}=="0"
> >     ATTR{serial}==""
> >     ATTR{size}=="2097152"
> >     ATTR{stat}=="      94        0     4208      285        0        0        0 
> >        0        0      100      280"
> > 
> >   looking at parent device '/devices/platform/a003e00.virtio_mmio/virtio3':
> >     KERNELS=="virtio3"
> >     SUBSYSTEMS=="virtio"
> >     DRIVERS=="virtio_blk"
> >     ATTRS{device}=="0x0002"
> >     ATTRS{features}=="0010101101110000000000000000110000000000000000000000000000
> > 000000"
> >     ATTRS{status}=="0x00000007"
> >     ATTRS{vendor}=="0x554d4551"
> > 
> >   looking at parent device '/devices/platform/a003e00.virtio_mmio':
> >     KERNELS=="a003e00.virtio_mmio"
> >     SUBSYSTEMS=="platform"
> >     DRIVERS=="virtio-mmio"
> >     ATTRS{driver_override}=="(null)"
> Since I can't do that on my box, would you be so kind to run
>  ls -l /dev/disk/by-path
> If it returns ids like
>   virtio-pci-a003e00.virtio_mmio[-partn]
> my suggested patch should be OK for ARM in that it will produce ids in
> the format
>   platform-a003e00.virtio_mmio[-partn]

Ok, my guest has 4 disks

 - sda - virtio-scsi, over virtio-pci transport
 - sdb - virtio-scsi, over virtio-mmio transport
 - vda - virtio-scsi, over virtio-pci transport
 - vdb - virtio-scsi, over virtio-mmio transport

with systemd 231 I get these links

  platform-3f000000.pcie-pci-0000:00:01.1-virtio-pci-0000:02:00.0-scsi-0:0:0:0 -> ../../sda
  platform-3f000000.pcie-pci-0000:00:01.3-virtio-pci-0000:04:00.0 -> ../../vda
  virtio-pci-a003c00.virtio_mmio -> ../../vdb
  virtio-pci-a003e00.virtio_mmio-scsi-0:0:0:0 -> ../../sdb

after applying your patch I get these links:

 platform-3f000000.pcie-pci-0000:00:01.1-virtio-pci-0000:02:00.0-scsi-0:0:0:0 -> ../../sda
 platform-3f000000.pcie-pci-0000:00:01.3-virtio-pci-0000:04:00.0 -> ../../vda
 platform-3f000000.pcie-pci-0000:02:00.0-scsi-0:0:0:0 -> ../../sda
 platform-3f000000.pcie-pci-0000:04:00.0 -> ../../vda
 platform-a003c00.virtio_mmio -> ../../vdb
 platform-a003e00.virtio_mmio-scsi-0:0:0:0 -> ../../sdb
 virtio-pci-a003c00.virtio_mmio -> ../../vdb
 virtio-pci-a003e00.virtio_mmio-scsi-0:0:0:0 -> ../../sdb

So that appears to be working as designed - the 4 backcompat symlinks are
still there, and the new symlinks all live under the platform- prefix
and don't have a bogus 'pci' in the name for mmio links

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
