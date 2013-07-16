From: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: RE: RFC: vfio interface for platform devices
Date: Tue, 16 Jul 2013 21:51:12 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150364E322__35859.8887375139$1374011362$gmane$org@039-SN1MPN1-004.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E15036334B4@039-SN1MPN1-004.039d.mgd.msft.net>
	(from B08248@freescale.com on Tue Jul  2 18:25:59 2013)
	<1372890695.8183.155@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1372890695.8183.155@snotra>
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
To: Wood Scott-B07421 <B07421@freescale.com>
Cc: "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, Bhushan Bharat-R65777 <R65777@freescale.com>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, Sethi Varun-B16395 <B16395@freescale.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org


> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, July 03, 2013 5:32 PM
> To: Yoder Stuart-B08248
> Cc: Alex Williamson; Alexander Graf; Wood Scott-B07421; Bhushan Bharat-R65777; Sethi Varun-B16395;
> virtualization@lists.linux-foundation.org; Antonios Motakis; kvm@vger.kernel.org list; kvm-
> ppc@vger.kernel.org; kvmarm@lists.cs.columbia.edu
> Subject: Re: RFC: vfio interface for platform devices
> 
> On 07/02/2013 06:25:59 PM, Yoder Stuart-B08248 wrote:
> > The write-up below is the first draft of a proposal for how the
> > kernel can expose
> > platform devices to user space using vfio.
> >
> > In short, I'm proposing a new ioctl VFIO_DEVICE_GET_DEVTREE_INFO which
> > allows user space to correlate regions and interrupts to the
> > corresponding
> > device tree node structure that is defined for most platform devices.
> >
> > Regards,
> > Stuart Yoder
> >
> > ------------------------------------------------------------------------------
> > VFIO for Platform Devices
> >
> > The existing infrastructure for vfio-pci is pretty close to what we
> > need:
> >    -mechanism to create a container
> >    -add groups/devices to a container
> >    -set the IOMMU model
> >    -map DMA regions
> >    -get an fd for a specific device, which allows user space to
> > determine
> >     info about device regions (e.g. registers) and interrupt info
> >    -support for mmapping device regions
> >    -mechanism to set how interrupts are signaled
> >
> > Platform devices can get complicated-- potentially with a tree
> > hierarchy
> > of nodes, and links/phandles pointing to other platform
> > devices.   The kernel doesn't expose relationships between
> > devices.  The kernel just exposes mappable register regions and
> > interrupts.
> > It's up to user space to work out relationships between devices
> > if it needs to-- this can be determined in the device tree exposed in
> > /proc/device-tree.
> >
> > I think the changes needed for vfio are around some of the device tree
> > related info that needs to be available with the device fd.
> >
> > 1.  VFIO_GROUP_GET_DEVICE_FD
> >
> >   User space has to know which device it is accessing and will call
> >   VFIO_GROUP_GET_DEVICE_FD passing a specific platform device path to
> >   get the device information:
> >
> >   fd = ioctl(group, VFIO_GROUP_GET_DEVICE_FD,
> > "/soc@ffe000000/usb@210000");
> >
> >   (whether the path is a device tree path or a sysfs path is up for
> >   discussion, e.g. "/sys/bus/platform/devices/ffe210000.usb")
> 
> Doesn't VFIO need to operate on an actual Linux device, rather than
> just an OF node?
> 
> Are we going to have a fixed assumption that you always want all the
> children of the node corresponding to the assigned device, or will it
> be possible to exclude some?

My assumption is that you always get all the children of the
node corresponding to the assigned device.

> > 2.  VFIO_DEVICE_GET_INFO
> >
> >    Don't think any changes are needed to VFIO_DEVICE_GET_INFO other
> >    than adding a new flag identifying a devices as a 'platform'
> >    device.
> >
> >    This ioctl simply returns the number of regions and number of irqs.
> >
> >    The number of regions corresponds to the number of regions
> >    that can be mapped for the device-- corresponds to the regions
> > defined
> >    in "reg" and "ranges" in the device tree.
> >
> > 3.  VFIO_DEVICE_GET_REGION_INFO
> >
> >    No changes needed, except perhaps adding a new flag.  Freescale
> > has some
> >    devices with regions that must be mapped cacheable.
> 
> While I don't object to making the information available to the user
> just in case, the main thing we need here is to influence what the
> kernel does when the user tries to map it.  At least on PPC it's not up
> to userspace to select whether a mmap is cacheable.

If user space really can't do anything with the 'cacheable'
flag, do you think there is good reason to keep it?   Will it
help any decision that user space makes?  Maybe we should just
drop it.
 
> > 4. VFIO_DEVICE_GET_DEVTREE_INFO
> >
> >    The VFIO_DEVICE_GET_REGION_INFO and VFIO_DEVICE_GET_IRQ_INFO APIs
> >    expose device regions and interrupts, but it's not enough to know
> >    that there are X regions and Y interrupts.  User space needs to
> >    know what the resources are for-- to correlate those
> > regions/interrupts
> >    to the device tree structure that drivers use.  The device tree
> >    structure could consist of multiple nodes and it is necessary to
> >    identify the node corresponding to the region/interrupt exposed
> >    by VFIO.
> >
> >    The following information is needed:
> >       -the device tree path to the node corresponding to the
> >        region or interrupt
> >       -for a region, whether it corresponds to a "reg" or "ranges"
> >        property
> >       -there could be multiple sub-regions per "reg" or "ranges" and
> >        the sub-index within the reg/ranges is needed
> >
> >    The VFIO_DEVICE_GET_DEVTREE_INFO operates on a device fd.
> >
> >    ioctl: VFIO_DEVICE_GET_DEVTREE_INFO
> >
> >    struct vfio_path_info {
> >         __u32   argsz;
> >         __u32   flags;
> >    #define VFIO_DEVTREE_INFO_RANGES      (1 << 3) /* the region is a
> > "ranges" property */
> 
> What about distinguishing a normal interrupt from one found in an
> interrupt-map?

I'm not sure we need that.  The kernel needs to use the interrupt
map to get interrupts hooked up right, but all user space needs to
know is that there are N interrupts and possibly device tree
paths to help user space interpret which interrupt is which.

> In the case of both ranges and interrupt-maps, we'll also want to
> decide what the policy is for when to expose them directly, versus just
> using them to translate regs and interrupts of child nodes

Yes, not sure the best approach there...but guess we can cross
that bridge when we implement this.  It doesn't affect this
interface.

> >         __u32   index;          /* input: index of region or irq for
> > which we are getting info */
> >         __u32   type;           /* input: 0 - get devtree info for a
> > region
> >                                           1 - get devtree info for an
> > irq
> >                                  */
> >         __u32   start;          /* output: identifies the index
> > within the reg/ranges */
> 
> "start" is an odd name for this.  I'd rename "index" to "vfio_index"
> and this to "dt_index".
> 
> >         __u8    path[];         /* output: Full path to associated
> > device tree node */
> 
> How does the caller know what size buffer to supply for this?
> 
> >     The VFIO_DEVICE_GET_DEVTREE_INFO ioctl would return:
> >
> >       -for region index 0:
> >           flags: 0x0     // i.e. this is a "reg" property
> >           start: 0x0     // i.e. index 0x0 in "reg"
> >           path: "/soc@ffe000000/crypto@300000"
> >
> >       -for interrupt index 0:
> >           path: "/soc@ffe000000/crypto@300000/jr@1000"
> >
> >       -for interrupt index 1:
> >           path: "/soc@ffe000000/crypto@300000/jr@2000"
> 
> Where is "start" for the interrupts?

v2 of the proposal made changes that got rid of that stuff.

Stuart
