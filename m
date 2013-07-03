From: Antonios Motakis <a.motakis@virtualopensystems.com>
Subject: Re: RFC: vfio interface for platform devices
Date: Wed, 3 Jul 2013 12:44:06 +0200
Message-ID: <CAG8rG2zBbhTReCiPv_1ryjfVfCWuN2TcO1=hhv+WjgU35wVk0A__35024.0096021027$1372896476$gmane$org@mail.gmail.com>
References: <9F6FE96B71CF29479FF1CDC8046E15036334B4@039-SN1MPN1-004.039d.mgd.msft.net>
	<1372820839.2883.42.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1372820839.2883.42.camel@ul30vt.home>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Yoder Stuart-B08248 <B08248@freescale.com>, Bhushan Bharat-R65777 <R65777@freescale.com>, Sethi Varun-B16395 <B16395@freescale.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 3, 2013 at 5:07 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Tue, 2013-07-02 at 23:25 +0000, Yoder Stuart-B08248 wrote:
>> The write-up below is the first draft of a proposal for how the kernel can expose
>> platform devices to user space using vfio.
>>
>> In short, I'm proposing a new ioctl VFIO_DEVICE_GET_DEVTREE_INFO which
>> allows user space to correlate regions and interrupts to the corresponding
>> device tree node structure that is defined for most platform devices.
>>
>> Regards,
>> Stuart Yoder
>>
>> ------------------------------------------------------------------------------
>> VFIO for Platform Devices
>>
>> The existing infrastructure for vfio-pci is pretty close to what we need:
>>    -mechanism to create a container
>>    -add groups/devices to a container
>>    -set the IOMMU model
>>    -map DMA regions
>>    -get an fd for a specific device, which allows user space to determine
>>     info about device regions (e.g. registers) and interrupt info
>>    -support for mmapping device regions
>>    -mechanism to set how interrupts are signaled
>>
>> Platform devices can get complicated-- potentially with a tree hierarchy
>> of nodes, and links/phandles pointing to other platform
>> devices.   The kernel doesn't expose relationships between
>> devices.  The kernel just exposes mappable register regions and interrupts.
>> It's up to user space to work out relationships between devices
>> if it needs to-- this can be determined in the device tree exposed in
>> /proc/device-tree.
>>
>> I think the changes needed for vfio are around some of the device tree
>> related info that needs to be available with the device fd.
>>
>> 1.  VFIO_GROUP_GET_DEVICE_FD
>>
>>   User space has to know which device it is accessing and will call
>>   VFIO_GROUP_GET_DEVICE_FD passing a specific platform device path to
>>   get the device information:
>>
>>   fd = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, "/soc@ffe000000/usb@210000");
>>
>>   (whether the path is a device tree path or a sysfs path is up for
>>   discussion, e.g. "/sys/bus/platform/devices/ffe210000.usb")
>>
>> 2.  VFIO_DEVICE_GET_INFO
>>
>>    Don't think any changes are needed to VFIO_DEVICE_GET_INFO other
>>    than adding a new flag identifying a devices as a 'platform'
>>    device.
>>
>>    This ioctl simply returns the number of regions and number of irqs.
>>
>>    The number of regions corresponds to the number of regions
>>    that can be mapped for the device-- corresponds to the regions defined
>>    in "reg" and "ranges" in the device tree.
>>
>> 3.  VFIO_DEVICE_GET_REGION_INFO
>>
>>    No changes needed, except perhaps adding a new flag.  Freescale has some
>>    devices with regions that must be mapped cacheable.
>>
>> 3.  VFIO_DEVICE_GET_IRQ_INFO
>>
>>    No changes needed.
>>
>> 4. VFIO_DEVICE_GET_DEVTREE_INFO
>>
>>    The VFIO_DEVICE_GET_REGION_INFO and VFIO_DEVICE_GET_IRQ_INFO APIs
>>    expose device regions and interrupts, but it's not enough to know
>>    that there are X regions and Y interrupts.  User space needs to
>>    know what the resources are for-- to correlate those regions/interrupts
>>    to the device tree structure that drivers use.  The device tree
>>    structure could consist of multiple nodes and it is necessary to
>>    identify the node corresponding to the region/interrupt exposed
>>    by VFIO.
>>
>>    The following information is needed:
>>       -the device tree path to the node corresponding to the
>>        region or interrupt
>>       -for a region, whether it corresponds to a "reg" or "ranges"
>>        property
>>       -there could be multiple sub-regions per "reg" or "ranges" and
>>        the sub-index within the reg/ranges is needed
>>
>>    The VFIO_DEVICE_GET_DEVTREE_INFO operates on a device fd.
>>
>>    ioctl: VFIO_DEVICE_GET_DEVTREE_INFO
>>
>>    struct vfio_path_info {
>>         __u32   argsz;
>>         __u32   flags;
>>    #define VFIO_DEVTREE_INFO_RANGES      (1 << 3) /* the region is a "ranges" property */
>
> (1 << 0)?
>
> Having flags = 0x0 for regs and 0x1 for ranges is a bit awkward.  I'd
> suggest a bit for each.  Otherwise, what does it mean when this returns
> flags = 0x0 for an irq?
>
>>         __u32   index;          /* input: index of region or irq for which we are getting info */
>>         __u32   type;           /* input: 0 - get devtree info for a region
>>                                           1 - get devtree info for an irq
>>                                  */
>>         __u32   start;          /* output: identifies the index within the reg/ranges */
>>         __u8    path[];         /* output: Full path to associated device tree node */
>>    };
>>
>>    User space allocates enough space for the device tree path, sets
>>    the type field identifying whether this is a region, or irq,
>>    and sets argsz appropriately.
>>
>> 5.  EXAMPLE 1
>>
>>     Example, Freescale SATA controller:
>>
>>      sata@220000 {
>>          compatible = "fsl,p2041-sata", "fsl,pq-sata-v2";
>>          reg = <0x220000 0x1000>;
>>          interrupts = <0x44 0x2 0x0 0x0>;
>>      };
>>
>>     request to get device FD would look like:
>>       fd = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, "/soc@ffe000000/sata@220000");
>>
>>     The VFIO_DEVICE_GET_INFO ioctl would return:
>>       -1 region
>>       -1 interrupts
>>
>>     The VFIO_DEVICE_GET_REGION_INFO ioctl would return:
>>       -for index 0:
>>            offset=0, size=0x10000 -- allows mmap of physical 0xffe220000
>>
>>     The VFIO_DEVICE_GET_IRQ_INFO ioctl would return appropriate info
>>     for the single interrupt.
>>
>>     The VFIO_DEVICE_GET_DEVTREE_INFO ioctl would return:
>>
>>       -for region index 0:
>>           flags: 0x0     // i.e. this is a "reg" property
>>           start: 0x0     // i.e. index 0x0 in "reg"
>>           path: "/soc@ffe000000/sata@220000"
>>
>>       -for interrupt index 0:
>>           path: "/soc@ffe000000/sata@220000"
>>
>> 6.  EXAMPLE 2
>>
>>     Example, Freescale crypto device (modified to illustrate):
>>
>>      crypto@300000 {
>>         compatible = "fsl,sec-v4.2", "fsl,sec-v4.0";
>>         #address-cells = <0x1>;
>>         #size-cells = <0x1>;
>>         reg = <0x300000 0x10000>;
>>         interrupts = <0x5c 0x2 0x0 0x0>;
>>
>>         jr@1000 {
>>            compatible = "fsl,sec-v4.2-job-ring", "fsl,sec-v4.0-job-ring";
>>            interrupts = <0x58 0x2 0x0 0x0>;
>>         };
>>
>>         jr@2000 {
>>            compatible = "fsl,sec-v4.2-job-ring", "fsl,sec-v4.0-job-ring";
>>            interrupts = <0x59 0x2 0x0 0x0>;
>>         };
>>      };
>>
>>     request to get device FD would look like:
>>       fd = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, "/soc@ffe000000/crypto@300000");
>>
>>     The VFIO_DEVICE_GET_INFO ioctl would return:
>>       -1 region
>>       -3 interrupts
>>
>>     The VFIO_DEVICE_GET_REGION_INFO ioctl would return:
>>       -for index 0:
>>            offset=0, size=0x10000 -- allows mmap of physical 0xffe300000
>>
>>     The VFIO_DEVICE_GET_IRQ_INFO ioctl would return appropriate info
>>     for each of the IRQs-- indexes 0-4.
>>
>>     The VFIO_DEVICE_GET_DEVTREE_INFO ioctl would return:
>>
>>       -for region index 0:
>>           flags: 0x0     // i.e. this is a "reg" property
>>           start: 0x0     // i.e. index 0x0 in "reg"
>>           path: "/soc@ffe000000/crypto@300000"
>>
>>       -for interrupt index 0:
>>           path: "/soc@ffe000000/crypto@300000/jr@1000"
>>
>>       -for interrupt index 1:
>>           path: "/soc@ffe000000/crypto@300000/jr@2000"
>>
>> 7.  EXAMPLE 3
>>
>>     Example, Freescale DMA engine (modified to illustrate):
>>
>>     dma@101300 {
>>        cell-index = <0x1>;
>>        ranges = <0x0 0x101100 0x200>;
>>        reg = <0x101300 0x4>;
>>        compatible = "fsl,eloplus-dma";
>>        #size-cells = <0x1>;
>>        #address-cells = <0x1>;
>>        fsl,liodn = <0xc6>;
>>
>>        dma-channel@180 {
>>           interrupts = <0x23 0x2 0x0 0x0>;
>>           cell-index = <0x3>;
>>           reg = <0x180 0x80>;
>>           compatible = "fsl,eloplus-dma-channel";
>>        };
>>
>>        dma-channel@100 {
>>           interrupts = <0x22 0x2 0x0 0x0>;
>>           cell-index = <0x2>;
>>           reg = <0x100 0x80>;
>>           compatible = "fsl,eloplus-dma-channel";
>>        };
>>
>>     };
>>
>>     request to get device FD would look like:
>>       fd = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, "/soc@ffe000000/dma@101300");
>>
>>     The VFIO_DEVICE_GET_INFO ioctl would return:
>>       -2 regions
>>       -2 interrupts
>>
>>     The VFIO_DEVICE_GET_REGION_INFO ioctl would return:
>>       -for index 0:
>>            offset=0x100, size=0x200 -- allows mmap of physical 0xffe101100
>>       -for index 1:
>>            offset=0x300, size=0x4 -- allows mmap of physical 0xffe101300
>>
>>     The VFIO_DEVICE_GET_IRQ_INFO ioctl would return appropriate info
>>     for each of the IRQs-- indexes 0-3.
>>
>>     The VFIO_DEVICE_GET_DEVTREE_INFO ioctl would return:
>>
>>       -for region index 0:
>>           flags: 0x1     // i.e. this is a "ranges" property
>>           start: 0x0     // i.e. index 0x0 in "ranges"
>>           path: "/soc@ffe000000/dma@101300"
>>
>>       -for region index 1:
>>           flags: 0x0     // i.e. this is a "reg" property
>>           start: 0x0     // i.e. index 0x0 in "ranges"
>>           path: "/soc@ffe000000/dma@101300"
>>
>>       -for interrupt index 0:
>>           path: "/soc@ffe000000/dma@101300/dma-channel@180"
>>
>>       -for interrupt index 1:
>>           path: "/soc@ffe000000/dma@101300/dma-channel@100"
>>
>> 8.  Open Issues
>>
>>    -how to handle cases where VFIO is requested to handle
>>     a device where the valid, mappable range for a region
>>     is less than a page size.   See example above where an
>>     advertised region in the DMA node is 4 bytes.  If exposed
>>     to a guest VM, the guest has to be able to map a full page
>>     of I/O space which opens a potential security issue.
>
> As AlexG points out, we solve that on vfio-pci by not supporting mmap on
> those regions and only allowing read/write.  If you could make the
> platform map regions on page size boundaries and there's nothing bad a
> guest can do by accessing the empty space, you could still support mmap.
> We can't make such requirements or guarantees on PCI though.  The PCI
> spec also suggests for devices to use page size regions and high
> performance devices generally follow that request, so it has become a
> fallback for low performance devices and I/O port space, which we can't
> mmap on x86 anyway.
>
> So overall the interface and extension makes sense.  My only question is
> whether it's better to get complete reuse out of GET_REGION_INFO and
> GET_IRQ_INFO and then add another device tree specific ioctl or is it
> better to add a device tree index and path to the existing GET_*_INFO
> ioctls?  Getting some information from one ioctl and passing pieces of
> it back to another ioctl feels a little clunky.
>

I thing at this point we should clearly separate the info we need to
pass for the core functionality (assigning the device's resources),
and the information we want to pass in order to generate a guest DT.
For ARM a DT is not generated by QEMU yet, but instead a proper DTB
needs to be passed by the user (granted, this will not be the case for
ever). So I think even if we treat them the same in code, we should be
discussing them separately.

Other than that I think it is preferable to extend the existing ioctls
rather than add new ones.

> DEVICE_GET_INFO will identify the device as device tree, which gives you
> the opportunity to extend or replace vfio_region_info and vfio_irq_info.
> It seems like it could even be done in a compatible way.  For example,
> if you were to call VFIO_DEVICE_GET_REGION_INFO with argsz =
> sizeof(struct vfio_region_info), the kernel could fill in all the info
> up to that size and fill argsz with the size needed for the remaining
> info.  You could then realloc the buffer and the kernel would add the
> extra info on the next call, setting a flag for each additional field
> returned.  Userspace could also just be sloppy and call it with a lot of
> padding and get everything in one shot.
>
> We'd need to define which flags have associated structures and define
> those structures.  For instance, some require no space:
>
> #define VFIO_DEVTREE_REGION_INFO_FLAG_REG (1 << ?)
> #define VFIO_DEVTREE_REGION_INFO_FLAG_RANGE (1 << ?)
>
> Others imply a structure added to the end:
>
> #define VFIO_DEVTREE_REGION_INFO_FLAG_INDEX (1 << ?)
>
> struct vfio_devtree_region_info_index
> {
>         u32     index;
> }
>
> #define VFIO_DEVTREE_REGION_INFO_FLAG_PATH (1 << ?)
>
> struct vfio_devtree_region_info_path
> {
>         u32     len;
>         u8      path[];
> }
>
> The order of the flags indicates the order of the structures at the end.
> We'd need to have some rules about alignment, probably always dword
> aligned.  I'm not sure if it would be necessary each structure to have a
> length.  It would only be needed if we want to let userspace skip over
> structures they don't understand how to parse.
>
> Another idea is that the space after struct vfio_region/irq_info could
> be a self describing capabilities area, much like PCI config space.
> Starting immediately after the static structure we'd have:
>
> struct vfio_info_cap_header
> {
>         u16     type;
>         u16     next;
> };
>
> Where type defines the structure that follows and next indicates the
> offset of then next header (could also be len of current cap).
>
> Anyway, it seems like there are possibilities that would allow us to
> extend the info ioctls in ways that would be generic for any device
> type.  Thanks,
>
> Alex
>
