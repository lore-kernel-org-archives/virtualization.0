From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [Xen-devel] [PATCH 3/4] xen kconfig: add dom0 support help
 text
Date: Fri, 6 Jan 2012 11:21:44 +0000
Message-ID: <alpine.DEB.2.00.1201061051410.3150@kaball-desktop>
References: <0872cdd4-a141-4904-8149-ff84cee00514@zmail13.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0872cdd4-a141-4904-8149-ff84cee00514@zmail13.collab.prod.int.phx2.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Jones <drjones@redhat.com>
Cc: "jeremy@goop.org" <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ian Campbell <Ian.Campbell@citrix.com>, konrad wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 6 Jan 2012, Andrew Jones wrote:
> > Almost all of the things which dom0 needs (e.g. PCI device management
> > etc) is also required by a domU with passthrough enabled so the
> > savings
> > are really very slight.
> > 
> > We are talking less than 1k of code AFAICT, 319 bytes for
> > arch/x86/xen/vga.o and 573 for drivers/xen/xenfs/xenstored.o plus
> > whatever xen_register_gsi (a couple of dozen lines of code) adds to
> > arch/x86/pci/xen.o. grep doesn't show CONFIG_XEN_DOM0 being used
> > anywhere else. What savings do you see in practice from disabling
> > just
> > this symbol?
> 
> I completely agree that the saving are near none. The savings, however,
> aren't the only reason to drive the change. It's actually the symbol
> name itself. Unfortunately configs can be perceived as a contract of
> support, i.e. if feature xyz is enabled in the distro's config, then
> the distributor must have selected, and therefore will support, said
> feature.
> 
> I didn't make this motivation clear in my initial post, because I was
> hoping to spare people some eye rolling.

I thought that in the kernel community we make decisions based on
technical merits rather than "contracts of support". 
Given that disabling the symbol saves near to nothing, the logical thing
to do is removing the symbol altogether.
