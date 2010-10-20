From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: xen PV on HVM and initial domain merge in linux-next
Date: Wed, 20 Oct 2010 16:47:51 +0100
Message-ID: <alpine.DEB.2.00.1010201644380.10348@kaball-desktop>
References: <alpine.DEB.2.00.1010191254460.2423@kaball-desktop> <alpine.DEB.2.00.1010191847290.10348@kaball-desktop> <20101020113256.3647b1d9.sfr@canb.auug.org.au> <alpine.DEB.2.00.1010201455160.10348@kaball-desktop> <20101020152808.GA22328@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101020152808.GA22328@dumpdata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jeremy Fitzhardinge <Jeremy.Fitzhardinge@citrix.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 20 Oct 2010, Konrad Rzeszutek Wilk wrote:
> The patches touch the Xen PCI components, so:
> 
> Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> And yeah, we need to update the MAINTAINERS file. Let me spin one out
> with the folks who are currently involved in this.
> 

Thanks

> > All right.
> > I merged Jeremy's and Konrad's branches (the ones you just merged on
> > linux-next) on top of linux 2.6.36 rc8, then I rebased my series on top
> > of the result.
> > Please checkout this branch:
> > 
> > git://xenbits.xen.org/people/sstabellini/linux-pvhvm.git 2.6.36-rc8-initial-domain-v5
> 
> Just as a note, you might want to create a branch titled
> 
> #linux-next in your git tree and link the reviewed/acked/tested branch to it. That way
> Stephen does not have to change his entries in the linux-next tree every release.
> 

Good idea, I have created a link called linux-next to
2.6.36-rc8-initial-domain-v5 so the following should also work:

git://xenbits.xen.org/people/sstabellini/linux-pvhvm.git linux-next

> > 
> > and let me know if it is suitable, it shouldn't have any merge
> > conflicts.
> 
> /me nods. Works nicely. Thank you for doing this on such a short-time frame.
> 

Great, thanks!
