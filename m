From: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: RE: RFC: vfio interface for platform devices
Date: Wed, 3 Jul 2013 17:20:01 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E1503633BEB@039-SN1MPN1-004.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E15036334B4@039-SN1MPN1-004.039d.mgd.msft.net>
	<1372820839.2883.42.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1372820839.2883.42.camel@ul30vt.home>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, Bhushan Bharat-R65777 <R65777@freescale.com>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Sethi Varun-B16395 <B16395@freescale.com>, Antonios Motakis <a.motakis@virtualopensystems.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org

[cut]

> So overall the interface and extension makes sense.  My only question is
> whether it's better to get complete reuse out of GET_REGION_INFO and
> GET_IRQ_INFO and then add another device tree specific ioctl or is it
> better to add a device tree index and path to the existing GET_*_INFO
> ioctls?  Getting some information from one ioctl and passing pieces of
> it back to another ioctl feels a little clunky.

Heh...extending region/irq info is the direction I started with, but 
because of the variable nature of the device tree data thought maybe
it was better to not add complexity to those APIs and leave them
alone.

Many or most platform devices will have 1 region and 1 interrupt, and
so it wouldn't be necessary in most cases to need device tree info at
all since there is no ambiguity.  So, was thinking that for the more
rare, complicated devices that a bit would advertise the existence of
the device tree info and the separate ioctl would be used to access it.

But, I'm completely open to extending the get region/irq info
ioctls if that direction is what you prefer...which seems to be
the case.

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
> 	u32	index;
> }
> 
> #define VFIO_DEVTREE_REGION_INFO_FLAG_PATH (1 << ?)
> 
> struct vfio_devtree_region_info_path
> {
> 	u32	len;
> 	u8	path[];
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
> 	u16	type;
> 	u16	next;
> };
> 
> Where type defines the structure that follows and next indicates the
> offset of then next header (could also be len of current cap).
> 
> Anyway, it seems like there are possibilities that would allow us to
> extend the info ioctls in ways that would be generic for any device
> type.  Thanks,

I think I like the approach using the flags and struct
extensions.

Stuart
