From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Thu, 28 Mar 2013 11:04:16 +0200
Message-ID: <20130328090416.GA18482@redhat.com>
References: <1363653285-23776-1-git-send-email-asias@redhat.com>
	<1363653285-23776-4-git-send-email-asias@redhat.com>
	<20130319084057.GB24393@stefanha-thinkpad.redhat.com>
	<1363744628.13070.28.camel@haakon2.linux-iscsi.org>
	<20130320095140.GA16615@redhat.com>
	<1364419887.17698.19.camel@haakon2.linux-iscsi.org>
	<20130327215625.GC10678@redhat.com>
	<1364423629.17698.25.camel@haakon2.linux-iscsi.org>
	<1364453115.17698.106.camel@haakon2.linux-iscsi.org>
	<1364456142.10253.6.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1364456142.10253.6.camel@haakon2.linux-iscsi.org>
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
Cc: Kevin O'Connor <kevin@koconnor.net>, kvm@vger.kernel.org, seabios-devel <seabios@seabios.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 28, 2013 at 12:35:42AM -0700, Nicholas A. Bellinger wrote:
> On Wed, 2013-03-27 at 23:45 -0700, Nicholas A. Bellinger wrote:
> > On Wed, 2013-03-27 at 15:33 -0700, Nicholas A. Bellinger wrote:
> > > On Wed, 2013-03-27 at 23:56 +0200, Michael S. Tsirkin wrote:
> > > > On Wed, Mar 27, 2013 at 02:31:27PM -0700, Nicholas A. Bellinger wrote:
> 
> <SNIP>
> 
> Adding a bit more detailed seabios PCI setup info, and
> make_bios_readonly_intel() debug output for Kevin & Co to review.
> 
> > >
> > > > I still do not understand how this happened.  Somehow a memory region
> > > > was deleted after vhost_dev_start but before vhost_virtqueue_start was
> > > > called?
> > > 
> > > Not sure..
> > > 
> > > To clarify, this is only happening during seabios setup+scan of
> > > virtio-scsi, and not during normal virtio_scsi LLD operation.
> > > 
> > > > Can you set a breakpoint there and see please?
> > > > 
> > > > 
> > > 
> > 
> > A bit more context here..
> > 
> > After debugging seabios this evening, I've isolated the spot where
> > things begin to go south for vhost_verify_ring_mappings check()
> > 
> > Below are logs from qemu + seabios serial output mixed to (attempt) to
> > demonstrate what's going on..  
> > 
> > root@tifa:/usr/src# qemu-system-x86_64 -enable-kvm -smp 4 -m 2048
> > -serial file:/tmp/vhost-serial.txt
> > -hda /usr/src/qemu-paolo.git/debian_squeeze_amd64_standard.qcow2 -device
> > vhost-scsi-pci,wwpn=naa.600140579ad21088
> > qemu-system-x86_64: pci_add_option_rom: failed to find romfile "efi-e1000.rom"
> > Calling ->region_add: section.size: 655360
> > vhost_set_memory: section: 0x7fff962c2580 section->size: 655360 add: 1
> > Calling ->region_add: section.size: 131072
> > Calling ->region_add: section.size: 131072
> > vhost_set_memory: section: 0x7fff962c2580 section->size: 131072 add: 1
> > Calling ->region_add: section.size: 131072
> > vhost_set_memory: section: 0x7fff962c2580 section->size: 131072 add: 1
> > Calling ->region_add: section.size: 2146435072
> > vhost_set_memory: section: 0x7fff962c2580 section->size: 2146435072 add: 1
> > Calling ->region_add: section.size: 4096
> > Calling ->region_add: section.size: 1024
> > Calling ->region_add: section.size: 1048576
> > Calling ->region_add: section.size: 262144
> > vhost_set_memory: section: 0x7fff962c2580 section->size: 262144 add: 1
> > vhost_scsi_init_pci Before virtio_init_pci
> > virtio_init_pci: size: 60
> > virtio_init_pci: new size: 64
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 131072 add: 0
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 32768 add: 1
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 98304 add: 1
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 32768 add: 0
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 98304 add: 0
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 65536 add: 1
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 65536 add: 1
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 65536 add: 0
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 65536 add: 0
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 98304 add: 1
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 32768 add: 1
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 98304 add: 0
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 32768 add: 0
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 131072 add: 1
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 131072 add: 0
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 131072 add: 0
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 163840 add: 1
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 98304 add: 1
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 163840 add: 0
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 98304 add: 0
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 196608 add: 1
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 65536 add: 1
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 196608 add: 0
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 65536 add: 0
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 2146435072 add: 0
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 2146697216 add: 1
> > vhost_set_memory: section: 0x7fe2801f29f0 section->size: 65536 add: 1
> > vhost_set_memory: section: 0x7fe2801f2ab0 section->size: 65536 add: 0
> > vhost_set_memory: section: 0x7fe2801f2a70 section->size: 8388608 add: 1
> > Entering vhost_dev_start >>>>>>>>>>>>>>>>>>>>>.
> > Before vhost_virtqueue_start >>>>>>>>>>>>>>>>>>>>>>>>>>.
> > After vhost_virtqueue_start >>>>>>>>>>>>>>>>>>>>>>>>>>.
> > 
> > <Start seabios serial output from init virtio-scsi code>
> > 
> 
> === PCI device probing ===
> PCI probe
> PCI device 00:00.0 (vd=8086:1237 c=0600)
> PCI device 00:01.0 (vd=8086:7000 c=0601)
> PCI device 00:01.1 (vd=8086:7010 c=0101)
> PCI device 00:01.3 (vd=8086:7113 c=0680)
> PCI device 00:02.0 (vd=1013:00b8 c=0300)
> PCI device 00:03.0 (vd=8086:100e c=0200)
> PCI device 00:04.0 (vd=1af4:1004 c=0100)
> Found 7 PCI devices (max PCI bus is 00)
> === PCI new allocation pass #1 ===
> PCI: check devices
> === PCI new allocation pass #2 ===
> PCI: map device bdf=00:03.0  bar 1, addr 0000c000, size 00000040 [io]
> PCI: map device bdf=00:04.0  bar 0, addr 0000c040, size 00000040 [io]
> PCI: map device bdf=00:01.1  bar 4, addr 0000c080, size 00000010 [io]
> PCI: map device bdf=00:03.0  bar 0, addr febc0000, size 00020000 [mem]
> PCI: map device bdf=00:02.0  bar 6, addr febe0000, size 00010000 [mem]
> PCI: map device bdf=00:02.0  bar 1, addr febf0000, size 00001000 [mem]
> PCI: map device bdf=00:04.0  bar 1, addr febf1000, size 00001000 [mem]
> PCI: map device bdf=00:02.0  bar 0, addr fc000000, size 02000000
> [prefmem]
> PCI: init bdf=00:00.0 id=8086:1237
> PCI: init bdf=00:01.0 id=8086:7000
> PIIX3/PIIX4 init: elcr=00 0c
> PCI: init bdf=00:01.1 id=8086:7010
> PCI: init bdf=00:01.3 id=8086:7113
> Using pmtimer, ioport 0xb008, freq 3579 kHz
> PCI: init bdf=00:02.0 id=1013:00b8
> PCI: init bdf=00:03.0 id=8086:100e
> PCI: init bdf=00:04.0 id=1af4:1004
> 
> > init virtio-scsi
> > found virtio-scsi at 0:4
> 
> init virtio-scsi
> found virtio-scsi at 0:4
> init_virtio_scsi: ioaddr: 0xc040
> 
> > Searching bootorder for: /pci@i0cf8/*@4/*@0/*@0,0
> > Entering virtio_scsi_cmd: 0x12
> > |7ffdc000| ata0-0: QEMU HARDDISK ATA-7 Hard-Disk (16384 MiBytes)
> > |7ffdc000| Searching bootorder for: /pci@i0cf8/*@1,1/drive@0/disk@0
> > |7ffdc000| Registering bootable: ata0-0: QEMU HARDDISK ATA-7 Hard-Disk (16384 MiBytes) (type:2 prio:101 data:f4ab0)
> > \7ffdc000/ End thread
> > |7ffdb000| DVD/CD [ata1-0: QEMU DVD-ROM ATAPI-4 DVD/CD]
> > |7ffdb000| Searching bootorder for: /pci@i0cf8/*@1,1/drive@1/disk@0
> > |7ffdb000| Registering bootable: DVD/CD [ata1-0: QEMU DVD-ROM ATAPI-4 DVD/CD] (type:3 prio:103 data:f4a80)
> > \7ffdb000/ End thread
> > Searching bootorder for: /pci@i0cf8/*@4/*@0/*@1,0
> > Entering virtio_scsi_cmd: 0x12
> > virtio-scsi vendor='LIO-ORG' product='RAMDISK-MCP' rev='4.0' type=0 removable=0
> > Entering virtio_scsi_cmd: 0x00
> > Entering virtio_scsi_cmd: 0x25
> > virtio-scsi blksize=512 sectors=524288
> > Registering bootable: virtio-scsi Drive LIO-ORG RAMDISK-MCP 4.0 (type:2 prio:101 data:f4ae0)
> > Searching bootorder for: /pci@i0cf8/*@4/*@0/*@2,0
> > Entering virtio_scsi_cmd: 0x12
> > 
> > <SNIP> target IDs up to 256...
> > 
> > init lsi53c895a
> > init esp
> > init megasas
> > Scan for option roms
> > Attempting to init PCI bdf 00:00.0 (vd 8086:1237)
> > Attempting to init PCI bdf 00:01.0 (vd 8086:7000)
> > Attempting to init PCI bdf 00:01.3 (vd 8086:7113)
> > Attempting to init PCI bdf 00:03.0 (vd 8086:100e)
> > Attempting to init PCI bdf 00:04.0 (vd 1af4:1004)
> > Searching bootorder for: /rom@genroms/kvmvapic.bin
> > Registering bootable: Legacy option rom (type:129 prio:101 data:c9000003)
> > Before prepareboot >>>>>>>>>>>>>>>.
> > Searching bootorder for: HALT
> > Mapping hd drive 0x000f4ab0 to 0
> > drive 0x000f4ab0: PCHS=16383/16/63 translation=lba LCHS=1024/255/63 s=33554432
> > Mapping hd drive 0x000f4ae0 to 1
> > drive 0x000f4ae0: PCHS=0/0/0 translation=lba LCHS=520/16/63 s=524288
> > Running option rom at c900:0003
> > Mapping floppy drive 0x000f4b40
> > Mapping cd drive 0x000f4a80
> > finalize PMM
> > malloc finalize
> > Space available for UMB: cb800-ec000, f4690-f4a50
> > Returned 57344 bytes of ZoneHigh
> > e820 map has 7 items:
> >   0: 0000000000000000 - 000000000009fc00 = 1 RAM
> >   1: 000000000009fc00 - 00000000000a0000 = 2 RESERVED
> >   2: 00000000000f0000 - 0000000000100000 = 2 RESERVED
> >   3: 0000000000100000 - 000000007fffe000 = 1 RAM
> >   4: 000000007fffe000 - 0000000080000000 = 2 RESERVED
> >   5: 00000000feffc000 - 00000000ff000000 = 2 RESERVED
> >   6: 00000000fffc0000 - 0000000100000000 = 2 RESERVED
> > Before make_bios_readonly >>>>>>>
> > locking shadow ram
> > Calling pci_config_writeb(0x11): bdf: 0x0000 pam: 0x0000005a
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> 
> locking shadow ram
> romend: 0x000cb800 romtop: 0x000ec000
> mem: 0x000c0000, pam: 0x0000005a
> Calling pci_config_writeb(0x11): bdf: 0x0000 pam: 0x0000005a
> 
> > <No QEMU output after pci_config_writeb(0x11) in make_bios_readonly..>
> > 
> > Calling pci_config_writeb(0x31): bdf: 0x0000 pam: 0x0000005b
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> 
> mem: 0x000c8000, pam: 0x0000005b
> romend: 0x000cb800 mem + 16*1024: 0x000cc000
> romtop: 0x000ec000 mem + 32*1024: 0x000d0000
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> romend: 0x000cb800, mem: 0x000c8000, romtop: 0x000ec000, mem + 16*1024: 0x000cc000
> Calling pci_config_writeb(0x31): bdf: 0x0000 pam: 0x0000005b
> 
> 
> > <QEMU output after pci_config_writeb(0x31) in make_bios_readonly..>
> > 
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 2146697216 add: 0
> > Before vhost_verify_ring_mappings: start_addr: c0000 size: 2146697216
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.

This is also a bug. -net always initializes VQs 0..N so this is what
vhost assumed.  Please teach vhost that it should skip uninitialized
VQs. There are more places to fix.
Basically look for if (!virtio_queue_get_num(vdev, queue_no)),
all of them need to be updated to skip uninitialized vqs.
Probably switch to a new API checking PA too.
See patch below.

> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Calling l: 5124 for start_addr: c0000 for vq 2
> > Unable to map ring buffer for ring 2
> > l: 4096 ring_size: 5124

okay so the ring address is within ROM.
Unsurprisingly it fails.
bios should stop device before write protect.

> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 32768 add: 1
> > Before vhost_verify_ring_mappings: start_addr: c0000 size: 32768
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 2 ring_phys: ed000 ring_size: 5124
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 2146664448 add: 1
> > Before vhost_verify_ring_mappings: start_addr: c8000 size: 2146664448
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Calling l: 5124 for start_addr: c8000 for vq 2
> > 
> > <Seabios output>
> > 
> > Calling pci_config_writeb(0x10): bdf: 0x0000 pam0: 0x00000059
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > <<QEMU output for the pci_config_writeb(0x10) in make_bios_readonly..>
> > 
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 32768 add: 0
> > Before vhost_verify_ring_mappings: start_addr: c0000 size: 32768
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 2 ring_phys: ed000 ring_size: 5124
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 2146664448 add: 0
> > Before vhost_verify_ring_mappings: start_addr: c8000 size: 2146664448
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Calling l: 5124 for start_addr: c8000 for vq 2
> > Unable to map ring buffer for ring 2
> > l: 0 ring_size: 5124
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 36864 add: 1
> > Before vhost_verify_ring_mappings: start_addr: c0000 size: 36864
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 2 ring_phys: ed000 ring_size: 5124
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 2146660352 add: 1
> > Before vhost_verify_ring_mappings: start_addr: c9000 size: 2146660352
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Calling l: 5124 for start_addr: c9000 for vq 2
> > 
> > <Seabios calls into StartBoot, and the last bit of QEMU output>
> > 
> > vhost_set_memory: section: 0x7fe2801f2b60 section->size: 2146660352 add: 0
> > Before vhost_verify_ring_mappings: start_addr: c9000 size: 2146660352
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Calling l: 5124 for start_addr: c9000 for vq 2
> > Unable to map ring buffer for ring 2
> > l: 0 ring_size: 5124
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 159744 add: 1
> > Before vhost_verify_ring_mappings: start_addr: c9000 size: 159744
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Calling l: 5124 for start_addr: c9000 for vq 2
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 65536 add: 1
> > Before vhost_verify_ring_mappings: start_addr: f0000 size: 65536
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 2 ring_phys: ed000 ring_size: 5124
> > vhost_set_memory: section: 0x7fe2801f2aa0 section->size: 2146435072 add: 1
> > Before vhost_verify_ring_mappings: start_addr: 100000 size: 2146435072
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ed000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 2 ring_phys: ed000 ring_size: 5124
> > 
> > So not being a seabios expert, this is as far as I've gotten..  One
> > change that does appear to avoid this behavior is when vp_reset() is
> > called right after virtio_scsi_scan_target() occurs.  (See below)
> > 
> > Obviously this prevents virtio-scsi root device operation, but it seems
> > to be a hint that some left-over PCI config space is triggering the
> > above in vhost_verify_ring_mappings().
> > 
> > WDYT..?
> > 
> > diff --git a/src/virtio-scsi.c b/src/virtio-scsi.c
> > index 4de1255..cafefff 100644
> > --- a/src/virtio-scsi.c
> > +++ b/src/virtio-scsi.c
> > @@ -153,7 +155,10 @@ init_virtio_scsi(struct pci_device *pci)
> >      int i, tot;
> >      for (tot = 0, i = 0; i < 256; i++)
> >          tot += virtio_scsi_scan_target(pci, ioaddr, vq, i);
> > -
> > +#if 1 
> > +    /* vhost-scsi-pci needs an vp_reset here, otherwise bad things happen */
> > +    vp_reset(ioaddr);
> > +#endif
> >      if (!tot)
> >          goto fail;
> > 
> > 

I think it's the right thing to do, but maybe not the right place
to do this, need to reset after all IO is done, before
ring memory is write protected.

> > --
> > To unsubscribe from this list: send the line "unsubscribe target-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

----

virtio: add API to check that ring is setup

virtio scsi makes it legal to only setup a subset of rings.  The only
way to detect the ring is setup seems to be to check whether PA was
written to.  Add API to do this, and teach code to use it instead of
checking hardware queue size.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

--->

diff --git a/hw/virtio.c b/hw/virtio.c
index 26fbc79..ac12c01 100644
--- a/hw/virtio.c
+++ b/hw/virtio.c
@@ -651,6 +651,11 @@ int virtio_queue_get_num(VirtIODevice *vdev, int n)
     return vdev->vq[n].vring.num;
 }
 
+bool virtio_queue_valid(VirtIODevice *vdev, int n)
+{
+    return vdev->vq[n].vring.num && vdev->vq[n].vring.pa;
+}
+
 int virtio_queue_get_id(VirtQueue *vq)
 {
     VirtIODevice *vdev = vq->vdev;
diff --git a/hw/virtio.h b/hw/virtio.h
index ca43fd7..d3f23c2 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -227,6 +227,7 @@ void virtio_config_writel(VirtIODevice *vdev, uint32_t addr, uint32_t data);
 void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr);
 hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n);
 int virtio_queue_get_num(VirtIODevice *vdev, int n);
+bool virtio_queue_valid(VirtIODevice *vdev, int n);
 void virtio_queue_notify(VirtIODevice *vdev, int n);
 uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
 void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector);
