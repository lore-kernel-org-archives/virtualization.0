From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC] kvmtool: add support for modern virtio-pci
Date: Wed, 18 Nov 2015 09:22:52 +0100
Message-ID: <1447834972.23726.92.camel__37532.4712288149$1447834994$gmane$org@redhat.com>
References: <1447823472-17047-1-git-send-email-sasha.levin@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447823472-17047-1-git-send-email-sasha.levin@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <sasha.levin@oracle.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, andre.przywara@arm.com, will.deacon@arm.com, josh@joshtriplett.org, virtualization@lists.linux-foundation.org, penberg@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mi, 2015-11-18 at 00:11 -0500, Sasha Levin wrote:
> This is a first go at adding support for the modern (based on the 1.0 virtio
> spec) virtio-pci implementation.

> To sum it up: this is a lightly tested version for feedback about the design
> and to weed out major bugs people notice. Feedback is very welcome!

/me goes undust the kvmtool patches for seabios.

(see https://www.kraxel.org/cgit/seabios/commit/?h=kvmtool,
build with CONFIG_KVMTOOL=y + CONFIG_DEBUG_LEVEL=9)

nilsson kraxel ~# ~kraxel/projects/kvmtool/lkvm run --name seabios
--firmware /home/kraxel/projects/seabios/out-bios-kvmtool/bios.bin
--disk /vmdisk/cloud/persistent/Fedora-Cloud-Base-22-20150521.x86_64.raw
  # lkvm run -k /boot/vmlinuz-3.10.0-324.el7.x86_64 -m 448 -c 4 --name
seabios
Changing serial settings was 0/0 now 3/0
SeaBIOS (version rel-1.9.0-7-g532b527)
BUILD: gcc: (GCC) 4.8.5 20150623 (Red Hat 4.8.5-4) binutils: version
2.23.52.0.1-55.el7 20130226
kvmtool: probed 448 MB RAM.
Add to e820 map: 00000000 1c000000 1
malloc preinit
Add to e820 map: 000a0000 00050000 -1
Add to e820 map: 000f0000 00010000 2
Add to e820 map: 1bfc0000 00040000 2
phys_alloc zone=0x000f78e8 size=14464 align=10 ret=1bfbc6f0
(detail=0x1bfbc6c0)
Relocating init from 0x000f40a0 to 0x1bfbc6f0 (size 14464)
malloc init
init ivt
init bda
Add to e820 map: 0009fc00 00000400 2
init bios32
init PNPBIOS table
init keyboard
init mouse
init pic
math cp init
PCI probe
phys_alloc zone=0x1bfbff38 size=32 align=10 ret=1bfbc640
(detail=0x1bfbc610)
PCI device 00:00.0 (vd=1af4:1000 c=0200)
phys_alloc zone=0x1bfbff38 size=32 align=10 ret=1bfbc5f0
(detail=0x1bfbc5c0)
PCI device 00:01.0 (vd=1af4:1001 c=0180)
Found 2 PCI devices (max PCI bus is 00)
tsc calibrate start=71959316 end=71968721 diff=9405
CPU Mhz=5
init timer
init lpt
Found 2 lpt ports
init serial
Found 4 serial ports
init virtio-blk
found virtio-blk at 0:1
phys_alloc zone=0x1bfbff40 size=80 align=10 ret=f78d0
(detail=0x1bfbc590)
pci dev 0:1 virtio cap at 0x4c type 1 bar 0 at 0xd2000800 off +0x0000
[mmio]
pci dev 0:1 virtio cap at 0x5c type 2 bar 0 at 0xd2000800 off +0x0080
[mmio]
pci dev 0:1 virtio cap at 0x70 type 3 bar 0 at 0xd2000800 off +0x0100
[mmio]
pci dev 0:1 virtio cap at 0x80 type 4 bar 0 at 0xd2000800 off +0x0180
[mmio]
pci dev 0:1 using modern (1.0) virtio mode
vp write  d2000814 (1) <- 0x0
Segmentation fault

With '--virtio-legacy' added seabios manages to load the kernel from
disk.

cheers,
  Gerd
