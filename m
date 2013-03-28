From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Wed, 27 Mar 2013 23:45:15 -0700
Message-ID: <1364453115.17698.106.camel@haakon2.linux-iscsi.org>
References: <1363653285-23776-1-git-send-email-asias@redhat.com>
	<1363653285-23776-4-git-send-email-asias@redhat.com>
	<20130319084057.GB24393@stefanha-thinkpad.redhat.com>
	<1363744628.13070.28.camel@haakon2.linux-iscsi.org>
	<20130320095140.GA16615@redhat.com>
	<1364419887.17698.19.camel@haakon2.linux-iscsi.org>
	<20130327215625.GC10678@redhat.com>
	<1364423629.17698.25.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1364423629.17698.25.camel@haakon2.linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2013-03-27 at 15:33 -0700, Nicholas A. Bellinger wrote:
> On Wed, 2013-03-27 at 23:56 +0200, Michael S. Tsirkin wrote:
> > On Wed, Mar 27, 2013 at 02:31:27PM -0700, Nicholas A. Bellinger wrote:
> > > On Wed, 2013-03-20 at 11:51 +0200, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 19, 2013 at 06:57:08PM -0700, Nicholas A. Bellinger wrote:
> > > > > On Tue, 2013-03-19 at 09:40 +0100, Stefan Hajnoczi wrote:
> > > > > > On Tue, Mar 19, 2013 at 08:34:45AM +0800, Asias He wrote:
> > > > > > > ---
> > > > > > >  hw/vhost.c | 2 ++
> > > > > > >  1 file changed, 2 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/hw/vhost.c b/hw/vhost.c
> > > > > > > index 4d6aee3..0c52ec4 100644
> > > > > > > --- a/hw/vhost.c
> > > > > > > +++ b/hw/vhost.c
> > > > > > > @@ -421,10 +421,12 @@ static void vhost_set_memory(MemoryListener *listener,
> > > > > > >          return;
> > > > > > >      }
> > > > > > >  
> > > > > > > +#if 0
> > > > > > >      if (dev->started) {
> > > > > > >          r = vhost_verify_ring_mappings(dev, start_addr, size);
> > > > > > >          assert(r >= 0);
> > > > > > >      }
> > > > > > > +#endif
> > > > > > 
> > > > > > Please add a comment to explain why.
> > > > > > 
> > > > > 
> > > > > Btw, the output that Asias added in the failure case at the behest of
> > > > > MST is here:
> > > > > 
> > > > > http://www.spinics.net/lists/target-devel/msg04077.html
> > > > 
> > > > Yes I suspected we could get l > ring_size, but this is
> > > > not the case here.
> > > > 
> > > 
> > > Hi MST & Co,
> > > 
> > > A quick update here..
> > > 
> > > So this issue appears to be related to performing the
> > > vhost_verify_ring_mappings() call after vhost_dev_unassign_memory() has
> > > been invoked with vhost_set_memory(..., add=false).
> > > 
> > > AFAICT from the logs below, things appear to work as expected when
> > > vhost_verify_ring_mappings() is called only for the
> > > vhost_set_memory(..., add=true) case.
> > > 
> > > Calling vhost_verify_ring_mappings() when dev->started == true +
> > > vhost_set_memory(..., add=false) appears to be a bug caused by fallout
> > > from:
> > > 
> > > commit 24f4fe345c1b80bab1ee18573914123d8028a9e6
> > > Author: Michael S. Tsirkin <mst@redhat.com>
> > > Date:   Tue Dec 25 17:41:07 2012 +0200
> > > 
> > >     vhost: set started flag while start is in progress
> > > 
> > > I'm including the following patch in the forth-coming vhost-scsi series.
> > > Please let me know if you have any concerns.
> > > 
> > > diff --git a/hw/vhost.c b/hw/vhost.c
> > > index 4d6aee3..687a689 100644
> > > --- a/hw/vhost.c
> > > +++ b/hw/vhost.c
> > > @@ -421,7 +421,7 @@ static void vhost_set_memory(MemoryListener *listener,
> > >          return;
> > >      }
> > >  
> > > -    if (dev->started) {
> > > +    if (dev->started && add) {
> > >          r = vhost_verify_ring_mappings(dev, start_addr, size);
> > >          assert(r >= 0);
> > >      }
> > > 
> > > Thanks!
> > > 
> > > --nab
> > 
> > Sorry NAK,
> > I think this will shut down too much stuff:
> > the main reason to check is when we delete a region.
> > 
> 

<SNIP>

> > I still do not understand how this happened.  Somehow a memory region
> > was deleted after vhost_dev_start but before vhost_virtqueue_start was
> > called?
> 
> Not sure..
> 
> To clarify, this is only happening during seabios setup+scan of
> virtio-scsi, and not during normal virtio_scsi LLD operation.
> 
> > Can you set a breakpoint there and see please?
> > 
> > 
> 

A bit more context here..

After debugging seabios this evening, I've isolated the spot where
things begin to go south for vhost_verify_ring_mappings check()

Below are logs from qemu + seabios serial output mixed to (attempt) to
demonstrate what's going on..  

root@tifa:/usr/src# qemu-system-x86_64 -enable-kvm -smp 4 -m 2048
-serial file:/tmp/vhost-serial.txt
-hda /usr/src/qemu-paolo.git/debian_squeeze_amd64_standard.qcow2 -device
vhost-scsi-pci,wwpn=naa.600140579ad21088
qemu-system-x86_64: pci_add_option_rom: failed to find romfile "efi-e1000.rom"
Calling ->region_add: section.size: 655360
vhost_set_memory: section: 0x7fff962c2580 section->size: 655360 add: 1
Calling ->region_add: section.size: 131072
Calling ->region_add: section.size: 131072
vhost_set_memory: section: 0x7fff962c2580 section->size: 131072 add: 1
Calling ->region_add: section.size: 131072
vhost_set_memory: section: 0x7fff962c2580 section->size: 131072 add: 1
Calling ->region_add: section.size: 2146435072
vhost_set_memory: section: 0x7fff962c2580 section->size: 2146435072 add: 1
Calling ->region_add: section.size: 4096
Calling ->region_add: section.size: 1024
Calling ->region_add: section.size: 1048576
Calling ->region_add: section.size: 262144
vhost_set_memory: section: 0x7fff962c2580 section->size: 262144 add: 1
vhost_scsi_init_pci Before virtio_init_pci
virtio_init_pci: size: 60
virtio_init_pci: new size: 64
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 131072 add: 0
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 32768 add: 1
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 98304 add: 1
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 32768 add: 0
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 98304 add: 0
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 65536 add: 1
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 65536 add: 1
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 65536 add: 0
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 65536 add: 0
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 98304 add: 1
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 32768 add: 1
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 98304 add: 0
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 32768 add: 0
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 131072 add: 1
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 131072 add: 0
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 131072 add: 0
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 163840 add: 1
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 98304 add: 1
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 163840 add: 0
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 98304 add: 0
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 196608 add: 1
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 65536 add: 1
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 196608 add: 0
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 65536 add: 0
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 2146435072 add: 0
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 2146697216 add: 1
vhost_set_memory: section: 0x7fe2801f29f0 section->size: 65536 add: 1
vhost_set_memory: section: 0x7fe2801f2ab0 section->size: 65536 add: 0
vhost_set_memory: section: 0x7fe2801f2a70 section->size: 8388608 add: 1
Entering vhost_dev_start >>>>>>>>>>>>>>>>>>>>>.
Before vhost_virtqueue_start >>>>>>>>>>>>>>>>>>>>>>>>>>.
After vhost_virtqueue_start >>>>>>>>>>>>>>>>>>>>>>>>>>.

<Start seabios serial output from init virtio-scsi code>

init virtio-scsi
found virtio-scsi at 0:4
Searching bootorder for: /pci@i0cf8/*@4/*@0/*@0,0
Entering virtio_scsi_cmd: 0x12
|7ffdc000| ata0-0: QEMU HARDDISK ATA-7 Hard-Disk (16384 MiBytes)
|7ffdc000| Searching bootorder for: /pci@i0cf8/*@1,1/drive@0/disk@0
|7ffdc000| Registering bootable: ata0-0: QEMU HARDDISK ATA-7 Hard-Disk (16384 MiBytes) (type:2 prio:101 data:f4ab0)
\7ffdc000/ End thread
|7ffdb000| DVD/CD [ata1-0: QEMU DVD-ROM ATAPI-4 DVD/CD]
|7ffdb000| Searching bootorder for: /pci@i0cf8/*@1,1/drive@1/disk@0
|7ffdb000| Registering bootable: DVD/CD [ata1-0: QEMU DVD-ROM ATAPI-4 DVD/CD] (type:3 prio:103 data:f4a80)
\7ffdb000/ End thread
Searching bootorder for: /pci@i0cf8/*@4/*@0/*@1,0
Entering virtio_scsi_cmd: 0x12
virtio-scsi vendor='LIO-ORG' product='RAMDISK-MCP' rev='4.0' type=0 removable=0
Entering virtio_scsi_cmd: 0x00
Entering virtio_scsi_cmd: 0x25
virtio-scsi blksize=512 sectors=524288
Registering bootable: virtio-scsi Drive LIO-ORG RAMDISK-MCP 4.0 (type:2 prio:101 data:f4ae0)
Searching bootorder for: /pci@i0cf8/*@4/*@0/*@2,0
Entering virtio_scsi_cmd: 0x12

<SNIP> target IDs up to 256...

init lsi53c895a
init esp
init megasas
Scan for option roms
Attempting to init PCI bdf 00:00.0 (vd 8086:1237)
Attempting to init PCI bdf 00:01.0 (vd 8086:7000)
Attempting to init PCI bdf 00:01.3 (vd 8086:7113)
Attempting to init PCI bdf 00:03.0 (vd 8086:100e)
Attempting to init PCI bdf 00:04.0 (vd 1af4:1004)
Searching bootorder for: /rom@genroms/kvmvapic.bin
Registering bootable: Legacy option rom (type:129 prio:101 data:c9000003)
Before prepareboot >>>>>>>>>>>>>>>.
Searching bootorder for: HALT
Mapping hd drive 0x000f4ab0 to 0
drive 0x000f4ab0: PCHS=16383/16/63 translation=lba LCHS=1024/255/63 s=33554432
Mapping hd drive 0x000f4ae0 to 1
drive 0x000f4ae0: PCHS=0/0/0 translation=lba LCHS=520/16/63 s=524288
Running option rom at c900:0003
Mapping floppy drive 0x000f4b40
Mapping cd drive 0x000f4a80
finalize PMM
malloc finalize
Space available for UMB: cb800-ec000, f4690-f4a50
Returned 57344 bytes of ZoneHigh
e820 map has 7 items:
  0: 0000000000000000 - 000000000009fc00 = 1 RAM
  1: 000000000009fc00 - 00000000000a0000 = 2 RESERVED
  2: 00000000000f0000 - 0000000000100000 = 2 RESERVED
  3: 0000000000100000 - 000000007fffe000 = 1 RAM
  4: 000000007fffe000 - 0000000080000000 = 2 RESERVED
  5: 00000000feffc000 - 00000000ff000000 = 2 RESERVED
  6: 00000000fffc0000 - 0000000100000000 = 2 RESERVED
Before make_bios_readonly >>>>>>>
locking shadow ram
Calling pci_config_writeb(0x11): bdf: 0x0000 pam: 0x0000005a
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

<No QEMU output after pci_config_writeb(0x11) in make_bios_readonly..>

Calling pci_config_writeb(0x31): bdf: 0x0000 pam: 0x0000005b
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

<QEMU output after pci_config_writeb(0x31) in make_bios_readonly..>

vhost_set_memory: section: 0x7fe2801f2b60 section->size: 2146697216 add: 0
Before vhost_verify_ring_mappings: start_addr: c0000 size: 2146697216
Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
Calling l: 5124 for start_addr: c0000 for vq 2
Unable to map ring buffer for ring 2
l: 4096 ring_size: 5124
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 32768 add: 1
Before vhost_verify_ring_mappings: start_addr: c0000 size: 32768
Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 2 ring_phys: ed000 ring_size: 5124
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 2146664448 add: 1
Before vhost_verify_ring_mappings: start_addr: c8000 size: 2146664448
Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
Calling l: 5124 for start_addr: c8000 for vq 2

<Seabios output>

Calling pci_config_writeb(0x10): bdf: 0x0000 pam0: 0x00000059
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

<<QEMU output for the pci_config_writeb(0x10) in make_bios_readonly..>

vhost_set_memory: section: 0x7fe2801f2b60 section->size: 32768 add: 0
Before vhost_verify_ring_mappings: start_addr: c0000 size: 32768
Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 2 ring_phys: ed000 ring_size: 5124
vhost_set_memory: section: 0x7fe2801f2b60 section->size: 2146664448 add: 0
Before vhost_verify_ring_mappings: start_addr: c8000 size: 2146664448
Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
Calling l: 5124 for start_addr: c8000 for vq 2
Unable to map ring buffer for ring 2
l: 0 ring_size: 5124
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 36864 add: 1
Before vhost_verify_ring_mappings: start_addr: c0000 size: 36864
Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 2 ring_phys: ed000 ring_size: 5124
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 2146660352 add: 1
Before vhost_verify_ring_mappings: start_addr: c9000 size: 2146660352
Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
Calling l: 5124 for start_addr: c9000 for vq 2

<Seabios calls into StartBoot, and the last bit of QEMU output>

vhost_set_memory: section: 0x7fe2801f2b60 section->size: 2146660352 add: 0
Before vhost_verify_ring_mappings: start_addr: c9000 size: 2146660352
Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
Calling l: 5124 for start_addr: c9000 for vq 2
Unable to map ring buffer for ring 2
l: 0 ring_size: 5124
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 159744 add: 1
Before vhost_verify_ring_mappings: start_addr: c9000 size: 159744
Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
Calling l: 5124 for start_addr: c9000 for vq 2
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 65536 add: 1
Before vhost_verify_ring_mappings: start_addr: f0000 size: 65536
Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 2 ring_phys: ed000 ring_size: 5124
vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 2146435072 add: 1
Before vhost_verify_ring_mappings: start_addr: 100000 size: 2146435072
Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
Got ranges_overlap for vq: 2 ring_phys: ed000 ring_size: 5124

So not being a seabios expert, this is as far as I've gotten..  One
change that does appear to avoid this behavior is when vp_reset() is
called right after virtio_scsi_scan_target() occurs.  (See below)

Obviously this prevents virtio-scsi root device operation, but it seems
to be a hint that some left-over PCI config space is triggering the
above in vhost_verify_ring_mappings().

WDYT..?

diff --git a/src/virtio-scsi.c b/src/virtio-scsi.c
index 4de1255..cafefff 100644
--- a/src/virtio-scsi.c
+++ b/src/virtio-scsi.c
@@ -153,7 +155,10 @@ init_virtio_scsi(struct pci_device *pci)
     int i, tot;
     for (tot = 0, i = 0; i < 256; i++)
         tot += virtio_scsi_scan_target(pci, ioaddr, vq, i);
-
+#if 1 
+    /* vhost-scsi-pci needs an vp_reset here, otherwise bad things happen */
+    vp_reset(ioaddr);
+#endif
     if (!tot)
         goto fail;
