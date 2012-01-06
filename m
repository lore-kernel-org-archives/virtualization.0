From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [Xen-devel] [PATCH 3/4] xen kconfig: add dom0 support help
 text
Date: Fri, 6 Jan 2012 10:42:07 +0000
Message-ID: <alpine.DEB.2.00.1201061039480.3150@kaball-desktop>
References: <5a67dfb3-fab0-4792-ba17-95f0934cf7af@zmail13.collab.prod.int.phx2.redhat.com>
	<1325843743.25206.438.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1325843743.25206.438.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ian Campbell <Ian.Campbell@citrix.com>
Cc: Andrew Jones <drjones@redhat.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "jeremy@goop.org" <jeremy@goop.org>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 6 Jan 2012, Ian Campbell wrote:
> On Fri, 2012-01-06 at 09:26 +0000, Andrew Jones wrote:
> > 
> > ----- Original Message -----
> > > On Fri, 2012-01-06 at 08:57 +0000, Andrew Jones wrote:
> > > > Describe dom0 support in the config menu and supply help text for
> > > > it.
> > > 
> > > This turns a non-user visible symbol into a user visible one.
> > > Previously
> > > if Xen was enabled and the other prerequisites were met you would get
> > > dom0 support automatically -- do we really want to change that?
> > > According to 6b0661a5e6fbf it was a deliberate decision to have it
> > > this
> > > way.
> > 
> > I think it's a necessary evil in order to give users the ability to
> > compile kernels without the support. I know it doesn't make much sense
> > for most users, but...
> 
> Who actually wants to do this though and why? Do you have a bug report
> requesting this change?
> 
> Almost all of the things which dom0 needs (e.g. PCI device management
> etc) is also required by a domU with passthrough enabled so the savings
> are really very slight.
> 
> We are talking less than 1k of code AFAICT, 319 bytes for
> arch/x86/xen/vga.o and 573 for drivers/xen/xenfs/xenstored.o plus
> whatever xen_register_gsi (a couple of dozen lines of code) adds to
> arch/x86/pci/xen.o. grep doesn't show CONFIG_XEN_DOM0 being used
> anywhere else. What savings do you see in practice from disabling just
> this symbol?
> 
> We need to weigh up the size change against the complexity of asking the
> user yet another question, I'm not convinced the question is worth it on
> balance.

I agree, there is nothing to gain disabling dom0 support if the
conditions it depends upon are already met.
XEN_DOM0 was meant to be a silent option since the beginning to avoid
unnecessary complexity.
