From: Scott Wood <scottwood@freescale.com>
Subject: Re: RFC: vfio interface for platform devices
Date: Tue, 16 Jul 2013 17:01:24 -0500
Message-ID: <1374012084.8183.338__33771.8634204522$1374012112$gmane$org@snotra>
References: <9F6FE96B71CF29479FF1CDC8046E150364E322@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E150364E322@039-SN1MPN1-004.039d.mgd.msft.net>
	(from B08248@freescale.com on Tue Jul 16 16:51:12 2013)
Content-Disposition: inline
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
Cc: Wood Scott-B07421 <B07421@freescale.com>, "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Bhushan Bharat-R65777 <R65777@freescale.com>, Sethi Varun-B16395 <B16395@freescale.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org

On 07/16/2013 04:51:12 PM, Yoder Stuart-B08248 wrote:
> > > 3.  VFIO_DEVICE_GET_REGION_INFO
> > >
> > >    No changes needed, except perhaps adding a new flag.  Freescale
> > > has some
> > >    devices with regions that must be mapped cacheable.
> >
> > While I don't object to making the information available to the user
> > just in case, the main thing we need here is to influence what the
> > kernel does when the user tries to map it.  At least on PPC it's  
> not up
> > to userspace to select whether a mmap is cacheable.
> 
> If user space really can't do anything with the 'cacheable'
> flag, do you think there is good reason to keep it?   Will it
> help any decision that user space makes?  Maybe we should just
> drop it.

As long as we can be sure all architectures will map things correctly  
without any flags needing to be specified, that's fine.

> > >    struct vfio_path_info {
> > >         __u32   argsz;
> > >         __u32   flags;
> > >    #define VFIO_DEVTREE_INFO_RANGES      (1 << 3) /* the region  
> is a
> > > "ranges" property */
> >
> > What about distinguishing a normal interrupt from one found in an
> > interrupt-map?
> 
> I'm not sure we need that.  The kernel needs to use the interrupt
> map to get interrupts hooked up right, but all user space needs to
> know is that there are N interrupts and possibly device tree
> paths to help user space interpret which interrupt is which.

What if the interrupt map is for devices without explicit nodes, such  
as with a PCI controller (ignore the fact that we would normally use  
vfio_pci for the indivdual PCI devices instead)?

You could say the same thing about ranges -- why expose ranges instead  
of the individual child node regs after translation?

> > In the case of both ranges and interrupt-maps, we'll also want to
> > decide what the policy is for when to expose them directly, versus  
> just
> > using them to translate regs and interrupts of child nodes
> 
> Yes, not sure the best approach there...but guess we can cross
> that bridge when we implement this.  It doesn't affect this
> interface.

It does affect the interface, because if you allow either of them to be  
mapped directly (rather than implicitly used when mapping a child  
node), you need a way to indicate which type of resource it is you're  
describing (as you already do for reg/ranges).

It also affects how vfio device binding is done, even if only to the  
point of specifying default behavior in the absence of knobs which  
change whether interrupt maps and/or ranges are mapped.

> > >         __u8    path[];         /* output: Full path to associated
> > > device tree node */
> >
> > How does the caller know what size buffer to supply for this?

Ping

-Scott
