From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Mon, 14 Sep 2009 19:53:20 +0300
Message-ID: <20090914165320.GA3851__45421.2163378999$1252947407$gmane$org@redhat.com>
References: <cover.1251388414.git.mst@redhat.com>
	<20090827160750.GD23722@redhat.com>
	<20090903183945.GF28651@ovro.caltech.edu>
	<20090907101537.GH3031@redhat.com>
	<20090908172035.GB319@ovro.caltech.edu>
	<4AAA7415.5080204@gmail.com> <20090913120140.GA31218@redhat.com>
	<4AAE6A97.7090808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AAE6A97.7090808@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <gregory.haskins@gmail.com>
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 14, 2009 at 12:08:55PM -0400, Gregory Haskins wrote:
> Michael S. Tsirkin wrote:
> > On Fri, Sep 11, 2009 at 12:00:21PM -0400, Gregory Haskins wrote:
> >> FWIW: VBUS handles this situation via the "memctx" abstraction.  IOW,
> >> the memory is not assumed to be a userspace address.  Rather, it is a
> >> memctx-specific address, which can be userspace, or any other type
> >> (including hardware, dma-engine, etc).  As long as the memctx knows how
> >> to translate it, it will work.
> > 
> > How would permissions be handled?
> 
> Same as anything else, really.  Read on for details.
> 
> > it's easy to allow an app to pass in virtual addresses in its own address space.
> 
> Agreed, and this is what I do.
> 
> The guest always passes its own physical addresses (using things like
> __pa() in linux).  This address passed is memctx specific, but generally
> would fall into the category of "virtual-addresses" from the hosts
> perspective.
> 
> For a KVM/AlacrityVM guest example, the addresses are GPAs, accessed
> internally to the context via a gfn_to_hva conversion (you can see this
> occuring in the citation links I sent)
> 
> For Ira's example, the addresses would represent a physical address on
> the PCI boards, and would follow any kind of relevant rules for
> converting a "GPA" to a host accessible address (even if indirectly, via
> a dma controller).

So vbus can let an application access either its own virtual memory or a
physical memory on a PCI device.  My question is, is any application
that's allowed to do the former also granted rights to do the later?

> >  But we can't let the guest specify physical addresses.
> 
> Agreed.  Neither your proposal nor mine operate this way afaict.
> 
> HTH
> 
> Kind Regards,
> -Greg
> 
