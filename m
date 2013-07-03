From: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: RE: RFC: vfio interface for platform devices
Date: Wed, 3 Jul 2013 19:08:33 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E1503633CAE@039-SN1MPN1-004.039d.mgd.msft.net>
References: <9001E680-3DF3-4B9A-97B9-D4B3DEFAB97C@suse.de> (from
	agraf@suse.de on Tue Jul 2 20:07:53 2013) <1372877510.8183.141@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1372877510.8183.141@snotra>
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
To: Wood Scott-B07421 <B07421@freescale.com>, Alexander Graf <agraf@suse.de>
Cc: "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, Bhushan Bharat-R65777 <R65777@freescale.com>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, Sethi Varun-B16395 <B16395@freescale.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, July 03, 2013 1:52 PM
> To: Alexander Graf
> Cc: Yoder Stuart-B08248; Alex Williamson; Wood Scott-B07421; Bhushan Bharat-R65777; Sethi Varun-B16395;
> virtualization@lists.linux-foundation.org; Antonios Motakis; kvm@vger.kernel.org list; kvm-
> ppc@vger.kernel.org; kvmarm@lists.cs.columbia.edu
> Subject: Re: RFC: vfio interface for platform devices
> 
> On 07/02/2013 08:07:53 PM, Alexander Graf wrote:
> >
> > On 03.07.2013, at 01:25, Yoder Stuart-B08248 wrote:
> >
> > > 8.  Open Issues
> > >
> > >   -how to handle cases where VFIO is requested to handle
> > >    a device where the valid, mappable range for a region
> > >    is less than a page size.   See example above where an
> > >    advertised region in the DMA node is 4 bytes.  If exposed
> > >    to a guest VM, the guest has to be able to map a full page
> > >    of I/O space which opens a potential security issue.
> >
> > The way we solved this for legacy PCI device assignment was by going
> > through QEMU for emulation and falling back to legacy read/write
> > IIRC. We could probably do the same here. IIRC there was a way for a
> > normal Linux mmap'ed device region to trap individual accesses too,
> > so we could just use that one too.
> >
> > The slow path emulation would then happen magically in QEMU, since
> > MMIO writes will get reinjected into the normal QEMU MMIO handling
> > path which will just issue a read/write on the mmap'ed region if it's
> > not declared as emulated.
> 
> I agree that's what should happen by default, but there should be a way
> for root to tell vfio that a device is allowed to overmap, in order to
> get the performance benefit of direct access in cases where root knows
> (or explicitly doesn't care) that it is safe.

Perhaps a sysfs mechanism like this:

echo "/sys/bus/platform/devices/ffe210000.usb" > /sys/bus/platform/drivers/vfio-platform/allow_overmap

Stuart
