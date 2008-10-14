From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 6/6 v3] PCI: document the change
Date: Mon, 13 Oct 2008 19:08:27 -0600
Message-ID: <20081014010827.GX25780__13207.8606439338$1223946751$gmane$org@parisc-linux.org>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F6@pdsmsx502.ccr.corp.intel.com>
	<20081001160706.GI13822@parisc-linux.org>
	<08DF4D958216244799FC84F3514D70F00235CC69@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <08DF4D958216244799FC84F3514D70F00235CC69@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Dong, Eddie" <eddie.dong@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Grant Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, linux-pci@vger.kernel.org, Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 14, 2008 at 08:23:34AM +0800, Dong, Eddie wrote:
> Matthew Wilcox wrote:
> > Wouldn't it be more useful to have the iov/N directories
> > be a symlink to the actual pci_dev used by the virtual
> > function? 
> 
> The main concern here is that a VF may be disabed such as when PF enter
> D3 state or undergo an reset and thus be plug-off, but user won't
> re-configure the VF in case the PF return back to working state.

If we're relying on the user to reconfigure virtual functions on return
to D0 from D3, that's a very fragile system.

> >> +For network device, there are:
> >> +       - /sys/bus/pci/devices/BB:DD.F/iov/N/mac
> >> +       - /sys/bus/pci/devices/BB:DD.F/iov/N/vlan
> >> +               (value update will notify PF driver)
> > 
> > We already have tools to set the MAC and VLAN parameters
> > for network devices.
> 
> Do you mean Ethtool? If yes, it is impossible for SR-IOV since the
> configuration has to be done in PF side, rather than VF.

I don't think ethtool has that ability; ip(8) can set mac addresses and
vconfig(8) sets vlan parameters.

The device driver already has to be aware of SR-IOV.  If it's going to
support the standard tools (and it damn well ought to), then it should
call the PF driver to set these kinds of parameters.

> > I'm not 100% convinced about this API.  The assumption
> > here is that the driver will do it, but I think it should
> > probably be in the core.  The driver probably wants to be
> 
> Our concern is that the PF driver may put an default state when it is
> loaded so that SR-IOV can work without any user level configuration, but
> of course the driver won't dynamically change it.
> Do u mean we remove this ability?
> 
> > notified that the PCI core is going to create a virtual
> > function, and would it please prepare to do so, but I'm
> > not convinced this should be triggered by the driver. 
> > How would the driver decide to create a new virtual
> > function?  

Let me try to explain this a bit better.

The user decides they want a new ethernet virtual function.  In the
scheme as you have set up:

1. User communicates to ethernet driver "I want a new VF"
2. Ethernet driver tells PCI core "create new VF".

I propose:

1. User tells PCI core "I want a new VF on PCI device 0000:01:03.0"
2. PCI core tells driver "User wants a new VF"

My scheme gives us a unified way of creating new VFs, yours requires each
driver to invent a way for the user to tell them to create a new VF.
Unless I've misunderstood your code and docs.

> > From my reading of the SR-IOV spec, this isn't how it's
> > supposed to work.  The device is supposed to be a fully
> > functional PCI device that on demand can start peeling
> > off virtual functions; it's not supposed to boot up and
> > initialise all its virtual functions at once. 
> 
> The spec defines either we enable all VFs or Disable. Per VF enabling is
> not supported.
> Is this what you concern?

I don't think that's true.  The spec requires you to enable all the
VFs from 0 to NumVFs, but NumVFs can be lower than TotalVFs.  At least,
that's how I read it.

But no, that isn't my concern.  My concern is that you've written a
driver here that seems to be a stub driver.  That doesn't seem to be
how SR-IOV is supposed to work; it's supposed to be a fully-functional
driver that has SR-IOV knowledge added to it.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
