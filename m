From: Scott Wood <scottwood@freescale.com>
Subject: Re: RFC: vfio interface for platform devices
Date: Tue, 16 Jul 2013 17:50:53 -0500
Message-ID: <1374015053.8183.343__4130.72948945246$1374015071$gmane$org@snotra>
References: <9F6FE96B71CF29479FF1CDC8046E150364E322@039-SN1MPN1-004.039d.mgd.msft.net>
	<1374012084.8183.338@snotra>
	<9F6FE96B71CF29479FF1CDC8046E150364E39A@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E150364E39A@039-SN1MPN1-004.039d.mgd.msft.net>
	(from B08248@freescale.com on Tue Jul 16 17:41:04 2013)
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

On 07/16/2013 05:41:04 PM, Yoder Stuart-B08248 wrote:
> 
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, July 16, 2013 5:01 PM
> > To: Yoder Stuart-B08248
> > Cc: Wood Scott-B07421; Alex Williamson; Alexander Graf; Bhushan  
> Bharat-R65777; Sethi Varun-B16395;
> > virtualization@lists.linux-foundation.org; Antonios Motakis;  
> kvm@vger.kernel.org list; kvm-
> > ppc@vger.kernel.org; kvmarm@lists.cs.columbia.edu
> > Subject: Re: RFC: vfio interface for platform devices
> >
> > What if the interrupt map is for devices without explicit nodes,  
> such
> > as with a PCI controller (ignore the fact that we would normally use
> > vfio_pci for the indivdual PCI devices instead)?
> >
> > You could say the same thing about ranges -- why expose ranges  
> instead
> > of the individual child node regs after translation?
> 
> Hmm...yes, I guess ranges and interrupt-map fall into the same
> basic type of resource category.  I'm not sure it's realistic
> to pass entire bus controllers through to user space vs
> just individual devices on a bus, but I guess it's theoretically
> possible.

Where "theoretically possible" means "we've done it before in other  
contexts". :-)

> So the question is whether we future proof by adding flags
> for both ranges and interrupt-map, or wait until there is
> an actual need for it.

We don't need to actually add a flag for it, but we should have a  
flag/type for the resources we do support, so that code written to the  
current API would recognize that it doesn't recognize an interrupt-map  
entry if it's added later.

> > > > >         __u8    path[];         /* output: Full path to  
> associated
> > > > > device tree node */
> > > >
> > > > How does the caller know what size buffer to supply for this?
> >
> > Ping
> 
> This is in the v2 RFC... the caller invokes the ioctl which returns
> the complete/full size, then re-allocs the buffer and calls the
> ioctl again.

OK.

> Or, as Alex suggested, just use a sufficiently large buffer to start  
> with.

It's fine for a user of the API to simplify things by using a large  
fixed buffer, but the API shouldn't force that approach.

-Scott
