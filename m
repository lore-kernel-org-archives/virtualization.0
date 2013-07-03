From: Alexander Graf <agraf@suse.de>
Subject: Re: RFC: vfio interface for platform devices
Date: Wed, 3 Jul 2013 03:07:53 +0200
Message-ID: <9001E680-3DF3-4B9A-97B9-D4B3DEFAB97C__36444.1384598196$1372813697$gmane$org@suse.de>
References: <9F6FE96B71CF29479FF1CDC8046E15036334B4@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15036334B4@039-SN1MPN1-004.039d.mgd.msft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yoder Stuart-B08248 <B08248@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, Bhushan Bharat-R65777 <R65777@freescale.com>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, Sethi Varun-B16395 <B16395@freescale.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org


On 03.07.2013, at 01:25, Yoder Stuart-B08248 wrote:

> The write-up below is the first draft of a proposal for how the kernel can expose
> platform devices to user space using vfio.
> 
> In short, I'm proposing a new ioctl VFIO_DEVICE_GET_DEVTREE_INFO which
> allows user space to correlate regions and interrupts to the corresponding
> device tree node structure that is defined for most platform devices.
> 
> Regards,
> Stuart Yoder
> 
> ------------------------------------------------------------------------------
> VFIO for Platform Devices
> 
> The existing infrastructure for vfio-pci is pretty close to what we need:
>   -mechanism to create a container
>   -add groups/devices to a container
>   -set the IOMMU model
>   -map DMA regions
>   -get an fd for a specific device, which allows user space to determine
>    info about device regions (e.g. registers) and interrupt info
>   -support for mmapping device regions
>   -mechanism to set how interrupts are signaled
> 
> Platform devices can get complicated-- potentially with a tree hierarchy
> of nodes, and links/phandles pointing to other platform 
> devices.   The kernel doesn't expose relationships between
> devices.  The kernel just exposes mappable register regions and interrupts.
> It's up to user space to work out relationships between devices
> if it needs to-- this can be determined in the device tree exposed in
> /proc/device-tree.
> 
> I think the changes needed for vfio are around some of the device tree
> related info that needs to be available with the device fd.
> 
> 1.  VFIO_GROUP_GET_DEVICE_FD
> 
>  User space has to know which device it is accessing and will call
>  VFIO_GROUP_GET_DEVICE_FD passing a specific platform device path to
>  get the device information:
> 
>  fd = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, "/soc@ffe000000/usb@210000");
> 
>  (whether the path is a device tree path or a sysfs path is up for
>  discussion, e.g. "/sys/bus/platform/devices/ffe210000.usb")
> 
> 2.  VFIO_DEVICE_GET_INFO
> 
>   Don't think any changes are needed to VFIO_DEVICE_GET_INFO other
>   than adding a new flag identifying a devices as a 'platform'
>   device.
> 
>   This ioctl simply returns the number of regions and number of irqs.
> 
>   The number of regions corresponds to the number of regions
>   that can be mapped for the device-- corresponds to the regions defined
>   in "reg" and "ranges" in the device tree.  
> 
> 3.  VFIO_DEVICE_GET_REGION_INFO
> 
>   No changes needed, except perhaps adding a new flag.  Freescale has some
>   devices with regions that must be mapped cacheable.
> 
> 3.  VFIO_DEVICE_GET_IRQ_INFO
> 
>   No changes needed.
> 
> 4. VFIO_DEVICE_GET_DEVTREE_INFO
> 
>   The VFIO_DEVICE_GET_REGION_INFO and VFIO_DEVICE_GET_IRQ_INFO APIs
>   expose device regions and interrupts, but it's not enough to know
>   that there are X regions and Y interrupts.  User space needs to
>   know what the resources are for-- to correlate those regions/interrupts
>   to the device tree structure that drivers use.  The device tree
>   structure could consist of multiple nodes and it is necessary to
>   identify the node corresponding to the region/interrupt exposed
>   by VFIO.
> 
>   The following information is needed:
>      -the device tree path to the node corresponding to the
>       region or interrupt
>      -for a region, whether it corresponds to a "reg" or "ranges"
>       property
>      -there could be multiple sub-regions per "reg" or "ranges" and
>       the sub-index within the reg/ranges is needed
> 
>   The VFIO_DEVICE_GET_DEVTREE_INFO operates on a device fd.
> 
>   ioctl: VFIO_DEVICE_GET_DEVTREE_INFO
> 
>   struct vfio_path_info {
>        __u32   argsz;
>        __u32   flags;
>   #define VFIO_DEVTREE_INFO_RANGES      (1 << 3) /* the region is a "ranges" property */
>        __u32   index;          /* input: index of region or irq for which we are getting info */
>        __u32   type;           /* input: 0 - get devtree info for a region
>                                          1 - get devtree info for an irq
>                                 */
>        __u32   start;          /* output: identifies the index within the reg/ranges */
>        __u8    path[];         /* output: Full path to associated device tree node */
>   };
> 
>   User space allocates enough space for the device tree path, sets
>   the type field identifying whether this is a region, or irq,
>   and sets argsz appropriately.
> 
> 5.  EXAMPLE 1
> 
>    Example, Freescale SATA controller:
> 
>     sata@220000 {
>         compatible = "fsl,p2041-sata", "fsl,pq-sata-v2";
>         reg = <0x220000 0x1000>;
>         interrupts = <0x44 0x2 0x0 0x0>;
>     };
> 
>    request to get device FD would look like:
>      fd = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, "/soc@ffe000000/sata@220000");
> 
>    The VFIO_DEVICE_GET_INFO ioctl would return:
>      -1 region
>      -1 interrupts
> 
>    The VFIO_DEVICE_GET_REGION_INFO ioctl would return:
>      -for index 0:
>           offset=0, size=0x10000 -- allows mmap of physical 0xffe220000
> 
>    The VFIO_DEVICE_GET_IRQ_INFO ioctl would return appropriate info
>    for the single interrupt.
> 
>    The VFIO_DEVICE_GET_DEVTREE_INFO ioctl would return:
> 
>      -for region index 0:
>          flags: 0x0     // i.e. this is a "reg" property
>          start: 0x0     // i.e. index 0x0 in "reg"
>          path: "/soc@ffe000000/sata@220000"
> 
>      -for interrupt index 0:
>          path: "/soc@ffe000000/sata@220000"
> 
> 6.  EXAMPLE 2
> 
>    Example, Freescale crypto device (modified to illustrate):
> 
>     crypto@300000 {
>        compatible = "fsl,sec-v4.2", "fsl,sec-v4.0";
>        #address-cells = <0x1>;
>        #size-cells = <0x1>;
>        reg = <0x300000 0x10000>;
>        interrupts = <0x5c 0x2 0x0 0x0>;
> 
>        jr@1000 {
>           compatible = "fsl,sec-v4.2-job-ring", "fsl,sec-v4.0-job-ring";
>           interrupts = <0x58 0x2 0x0 0x0>;
>        };
> 
>        jr@2000 {
>           compatible = "fsl,sec-v4.2-job-ring", "fsl,sec-v4.0-job-ring";
>           interrupts = <0x59 0x2 0x0 0x0>;
>        };
>     };
> 
>    request to get device FD would look like:
>      fd = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, "/soc@ffe000000/crypto@300000");
> 
>    The VFIO_DEVICE_GET_INFO ioctl would return:
>      -1 region
>      -3 interrupts
> 
>    The VFIO_DEVICE_GET_REGION_INFO ioctl would return:
>      -for index 0:
>           offset=0, size=0x10000 -- allows mmap of physical 0xffe300000
> 
>    The VFIO_DEVICE_GET_IRQ_INFO ioctl would return appropriate info
>    for each of the IRQs-- indexes 0-4.
> 
>    The VFIO_DEVICE_GET_DEVTREE_INFO ioctl would return:
> 
>      -for region index 0:
>          flags: 0x0     // i.e. this is a "reg" property
>          start: 0x0     // i.e. index 0x0 in "reg"
>          path: "/soc@ffe000000/crypto@300000"
> 
>      -for interrupt index 0:
>          path: "/soc@ffe000000/crypto@300000/jr@1000"
> 
>      -for interrupt index 1:
>          path: "/soc@ffe000000/crypto@300000/jr@2000"
> 
> 7.  EXAMPLE 3
> 
>    Example, Freescale DMA engine (modified to illustrate):
> 
>    dma@101300 {
>       cell-index = <0x1>;
>       ranges = <0x0 0x101100 0x200>;
>       reg = <0x101300 0x4>;
>       compatible = "fsl,eloplus-dma";
>       #size-cells = <0x1>;
>       #address-cells = <0x1>;
>       fsl,liodn = <0xc6>;
> 
>       dma-channel@180 {
>          interrupts = <0x23 0x2 0x0 0x0>;
>          cell-index = <0x3>;
>          reg = <0x180 0x80>;
>          compatible = "fsl,eloplus-dma-channel";
>       };
> 
>       dma-channel@100 {
>          interrupts = <0x22 0x2 0x0 0x0>;
>          cell-index = <0x2>;
>          reg = <0x100 0x80>;
>          compatible = "fsl,eloplus-dma-channel";
>       };
> 
>    };
> 
>    request to get device FD would look like:
>      fd = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, "/soc@ffe000000/dma@101300");
> 
>    The VFIO_DEVICE_GET_INFO ioctl would return:
>      -2 regions
>      -2 interrupts
> 
>    The VFIO_DEVICE_GET_REGION_INFO ioctl would return:
>      -for index 0:
>           offset=0x100, size=0x200 -- allows mmap of physical 0xffe101100
>      -for index 1:
>           offset=0x300, size=0x4 -- allows mmap of physical 0xffe101300
> 
>    The VFIO_DEVICE_GET_IRQ_INFO ioctl would return appropriate info
>    for each of the IRQs-- indexes 0-3.
> 
>    The VFIO_DEVICE_GET_DEVTREE_INFO ioctl would return:
> 
>      -for region index 0:
>          flags: 0x1     // i.e. this is a "ranges" property
>          start: 0x0     // i.e. index 0x0 in "ranges"
>          path: "/soc@ffe000000/dma@101300"
> 
>      -for region index 1:
>          flags: 0x0     // i.e. this is a "reg" property
>          start: 0x0     // i.e. index 0x0 in "ranges"
>          path: "/soc@ffe000000/dma@101300"
> 
>      -for interrupt index 0:
>          path: "/soc@ffe000000/dma@101300/dma-channel@180"
> 
>      -for interrupt index 1:
>          path: "/soc@ffe000000/dma@101300/dma-channel@100"
> 
> 8.  Open Issues
> 
>   -how to handle cases where VFIO is requested to handle 
>    a device where the valid, mappable range for a region
>    is less than a page size.   See example above where an 
>    advertised region in the DMA node is 4 bytes.  If exposed
>    to a guest VM, the guest has to be able to map a full page
>    of I/O space which opens a potential security issue.

The way we solved this for legacy PCI device assignment was by going through QEMU for emulation and falling back to legacy read/write IIRC. We could probably do the same here. IIRC there was a way for a normal Linux mmap'ed device region to trap individual accesses too, so we could just use that one too.

The slow path emulation would then happen magically in QEMU, since MMIO writes will get reinjected into the normal QEMU MMIO handling path which will just issue a read/write on the mmap'ed region if it's not declared as emulated.


Alex
