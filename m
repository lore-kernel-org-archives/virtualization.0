From: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: RFC: vfio interface for platform devices (v2)
Date: Wed, 3 Jul 2013 21:40:03 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E1503633DEF__25501.2253685438$1372887626$gmane$org@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Williamson <alex.williamson@redhat.com>, Alexander Graf <agraf@suse.de>, Wood Scott-B07421 <B07421@freescale.com>
Cc: "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, Bhushan Bharat-R65777 <R65777@freescale.com>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, Sethi Varun-B16395 <B16395@freescale.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org

Version 2
  -VFIO_GROUP_GET_DEVICE_FD-- specified that the path is a sysfs path
  -VFIO_DEVICE_GET_INFO-- defined 2 flags instead of 1
  -deleted VFIO_DEVICE_GET_DEVTREE_INFO ioctl
  -VFIO_DEVICE_GET_REGION_INFO-- updated as per AlexW's suggestion,
   defined 5 new flags and associated structs
  -VFIO_DEVICE_GET_IRQ_INFO-- updated as per AlexW's suggestion,
   defined 1 new flag and associated struct
  -removed redundant example

------------------------------------------------------------------------------
VFIO for Platform Devices

The existing kernel interface for vfio-pci is pretty close to what is needed
for platform devices:
   -mechanism to create a container
   -add groups/devices to a container
   -set the IOMMU model
   -map DMA regions
   -get an fd for a specific device, which allows user space to determine
    info about device regions (e.g. registers) and interrupt info
   -support for mmapping device regions
   -mechanism to set how interrupts are signaled

Many platform device are simple and consist of a single register
region and a single interrupt.  For these types of devices the
existing vfio interfaces should be sufficient.

However, platform devices can get complicated-- logically represented
as a device tree hierarchy of nodes.  For devices with multiple regions
and interrupts, new mechanisms are needed in vfio to correlate the
regions/interrupts with the device tree structure that drivers use
to determine the meaning of device resources.

In some cases there are relationships between device, and devices
reference other devices using phandle links.  The kernel won't expose
relationships between devices, but just exposes mappable register
regions and interrupts.

The changes needed for vfio are around some of the device tree
related info that needs to be available with the device fd.

1.  VFIO_GROUP_GET_DEVICE_FD

  User space knows by out-of-band means which device it is accessing
  and will call VFIO_GROUP_GET_DEVICE_FD passing a specific sysfs path
  to get the device information:

  fd = ioctl(group, VFIO_GROUP_GET_DEVICE_FD,
             "/sys/bus/platform/devices/ffe210000.usb"));

2.  VFIO_DEVICE_GET_INFO

   The number of regions corresponds to the regions defined
   in "reg" and "ranges" in the device tree.  

   Two new flags are added to struct vfio_device_info:

   #define VFIO_DEVICE_FLAGS_PLATFORM (1 << ?) /* A platform bus device */
   #define VFIO_DEVICE_FLAGS_DEVTREE  (1 << ?) /* device tree info available */

   It is possible that there could be platform bus devices 
   that are not in the device tree, so we use 2 flags to
   allow for that.

   If just VFIO_DEVICE_FLAGS_PLATFORM is set, it means
   that there are regions and IRQs but no device tree info
   available.

   If just VFIO_DEVICE_FLAGS_DEVTREE is set, it means
   there is device tree info available.

3. VFIO_DEVICE_GET_REGION_INFO

   For platform devices with multiple regions, information
   is needed to correlate the regions with the device 
   tree structure that drivers use to determine the meaning
   of device resources.
   
   The VFIO_DEVICE_GET_REGION_INFO is extended to provide
   device tree information.

   The following information is needed:
      -the device tree path to the node corresponding to the
       region
      -whether it corresponds to a "reg" or "ranges" property
      -there could be multiple sub-regions per "reg" or "ranges" and
       the sub-index within the reg/ranges is needed

   There are 5 new flags added to vfio_region_info :

   struct vfio_region_info {
        __u32   argsz;
        __u32   flags;
   #define VFIO_REGION_INFO_FLAG_CACHEABLE (1 << ?)
   #define VFIO_DEVTREE_REGION_INFO_FLAG_REG (1 << ?)
   #define VFIO_DEVTREE_REGION_INFO_FLAG_RANGE (1 << ?)
   #define VFIO_DEVTREE_REGION_INFO_FLAG_INDEX (1 << ?)
   #define VFIO_DEVTREE_REGION_INFO_FLAG_PATH (1 << ?)
        __u32   index;          /* Region index */
        __u32   resv;           /* Reserved for alignment */
        __u64   size;           /* Region size (bytes) */
        __u64   offset;         /* Region offset from start of device fd */
   };
 
   VFIO_REGION_INFO_FLAG_CACHEABLE
       -if set indicates that the region must be mapped as cacheable

   VFIO_DEVTREE_REGION_INFO_FLAG_REG
       -if set indicates that the region corresponds to a "reg" property
        in the device tree representation of the device

   VFIO_DEVTREE_REGION_INFO_FLAG_RANGE
       -if set indicates that the region corresponds to a "ranges" property
        in the device tree representation of the device

   VFIO_DEVTREE_REGION_INFO_FLAG_INDEX
       -if set indicates that there is a dword aligned struct
        struct vfio_devtree_region_info_index appended to the
        end of vfio_region_info:

        struct vfio_devtree_region_info_index
        {
	      u32 index;
        }

        A reg or ranges property may have multiple regsion.  The index
        specifies the index within the "reg" or "ranges"
        that this region corresponds to.

   VFIO_DEVTREE_REGION_INFO_FLAG_PATH
       -if set indicates that there is a dword aligned struct
        struct vfio_devtree_info_path appended to the
        end of vfio_region_info:

        struct vfio_devtree_info_path
        {
            u32 len;
            u8 path[];
        } 

        The path is the full path to the corresponding device
        tree node.  The len field specifies the length of the
        path string.

   If multiple flags are set that indicate that there is
   an appended struct, the order of the flags indicates
   the order of the structs.

   argsz is set by the kernel specifying the total size of
   struct vfio_region_info and all appended structs.

   Suggested usage:
      -call VFIO_DEVICE_GET_REGION_INFO with argsz =
       sizeof(struct vfio_region_info)
      -realloc the buffer
      -call VFIO_DEVICE_GET_REGION_INFO again, and the appended
       structs will be returned

4.  VFIO_DEVICE_GET_IRQ_INFO

   For platform devices with multiple interrupts that 
   correspond to different subnodes in the device tree,
   information is needed to correlate the interrupts
   to the the device tree structure.

   The VFIO_DEVICE_GET_REGION_INFO is extended to provide
   device tree information.

   1 new flag is added to vfio_irq_info :

   struct vfio_irq_info {
        __u32   argsz;
        __u32   flags;
   #define VFIO_DEVTREE_IRQ_INFO_FLAG_PATH (1 << ?)
        __u32   index;    /* IRQ index */
        __u32   count;    /* Number of IRQs within this index */
    };

   VFIO_DEVTREE_IRQ_INFO_FLAG_PATH 
       -if set indicates that there is a dword aligned struct
        struct vfio_devtree_info_path appended to the
        end of vfio_irq_info :

        struct vfio_devtree_info_path
        {
            u32 len;
            u8 path[];
        } 

        The path is the full path to the corresponding device
        tree node.  The len field specifies the length of the
        path string.

   argsz is set by the kernel specifying the total size of
   struct vfio_region_info and all appended structs.

5.  EXAMPLE 1

    Example, Freescale SATA controller:

     sata@220000 {
         compatible = "fsl,p2041-sata", "fsl,pq-sata-v2";
         reg = <0x220000 0x1000>;
         interrupts = <0x44 0x2 0x0 0x0>;
     };

    request to get device FD would look like:
      fd = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, "/sys/bus/platform/devices/ffe220000.sata");

    The VFIO_DEVICE_GET_INFO ioctl would return:
      -1 region
      -1 interrupts

    The VFIO_DEVICE_GET_REGION_INFO ioctl would return:
      -for index 0:
           offset=0, size=0x10000 -- allows mmap of physical 0xffe220000
           flags = VFIO_DEVTREE_REGION_INFO_FLAG_REG |
                   VFIO_DEVTREE_REGION_INFO_FLAG_PATH
           vfio_devtree_info_path
              len = 26
              path = "/soc@ffe000000/sata@220000"

    The VFIO_DEVICE_GET_IRQ_INFO ioctl would return:
      -for index 0:
          flags = VFIO_IRQ_INFO_EVENTFD | 
                  VFIO_IRQ_INFO_MASKABLE |
                  VFIO_DEVTREE_IRQ_INFO_FLAG_PATH  
          vfio_devtree_info_path
              len = 26
              path = "/soc@ffe000000/sata@220000"

6.  EXAMPLE 2

    Example, Freescale DMA engine (modified to illustrate):

    dma@101300 {
       cell-index = <0x1>;
       ranges = <0x0 0x101100 0x200>;
       reg = <0x101300 0x4>;
       compatible = "fsl,eloplus-dma";
       #size-cells = <0x1>;
       #address-cells = <0x1>;
       fsl,liodn = <0xc6>;
    
       dma-channel@180 {
          interrupts = <0x23 0x2 0x0 0x0>;
          cell-index = <0x3>;
          reg = <0x180 0x80>;
          compatible = "fsl,eloplus-dma-channel";
       };
    
       dma-channel@100 {
          interrupts = <0x22 0x2 0x0 0x0>;
          cell-index = <0x2>;
          reg = <0x100 0x80>;
          compatible = "fsl,eloplus-dma-channel";
       };

    };

    request to get device FD would look like:
      fd = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, "/sys/bus/platform/devices/ffe101300.dma");

    The VFIO_DEVICE_GET_INFO ioctl would return:
      -2 regions
      -2 interrupts

    The VFIO_DEVICE_GET_REGION_INFO ioctl would return:
      -for index 0:
           offset=0x100, size=0x200 -- allows mmap of physical 0xffe101100
           flags = VFIO_DEVTREE_REGION_INFO_FLAG_RANGES |
                   VFIO_DEVTREE_REGION_INFO_FLAG_PATH
           vfio_devtree_info_path
              len = 25
              path = "/soc@ffe000000/dma@101300"

      -for index 1:
           offset=0x300, size=0x4 -- allows mmap of physical 0xffe101300
           flags = VFIO_DEVTREE_REGION_INFO_FLAG_REG |
                   VFIO_DEVTREE_REGION_INFO_FLAG_PATH
           vfio_devtree_info_path
              len = 25
              path = "/soc@ffe000000/dma@101300"

    The VFIO_DEVICE_GET_IRQ_INFO ioctl would return:
      -for index 0:
          flags = VFIO_IRQ_INFO_EVENTFD | 
                  VFIO_IRQ_INFO_MASKABLE |
                  VFIO_DEVTREE_IRQ_INFO_FLAG_PATH  
          vfio_devtree_info_path
              len = 41
              path = "/soc@ffe000000/dma@101300/dma-channel@180"

      -for index 0:
          flags = VFIO_IRQ_INFO_EVENTFD | 
                  VFIO_IRQ_INFO_MASKABLE |
                  VFIO_DEVTREE_IRQ_INFO_FLAG_PATH  
          vfio_devtree_info_path
              len = 41
              path = "/soc@ffe000000/dma@101300/dma-channel@100"


Regards,
Stuart
