From: Yu Zhao <yu.zhao@intel.com>
Subject: Re: [PATCH 6/6 v3] PCI: document the change
Date: Tue, 14 Oct 2008 10:14:35 +0800
Message-ID: <20081014021435.GA1482__18449.9315372252$1223954053$gmane$org@yzhao12-linux.sh.intel.com>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F6@pdsmsx502.ccr.corp.intel.com>
	<20081001160706.GI13822@parisc-linux.org>
	<08DF4D958216244799FC84F3514D70F00235CC69@pdsmsx415.ccr.corp.intel.com>
	<20081014010827.GX25780@parisc-linux.org>
	<08DF4D958216244799FC84F3514D70F00235CE27@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <08DF4D958216244799FC84F3514D70F00235CE27@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Grant Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Roland Dreier <rdreier@cisco.com>, eddie.dong@intel.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 14, 2008 at 10:31:03AM +0800, Dong, Eddie wrote:
> Matthew Wilcox wrote:
> > On Tue, Oct 14, 2008 at 08:23:34AM +0800, Dong, Eddie
> > wrote:
> >> Matthew Wilcox wrote:
> >>> Wouldn't it be more useful to have the iov/N directories
> >>> be a symlink to the actual pci_dev used by the virtual
> >>> function?
> >>
> >> The main concern here is that a VF may be disabed such
> >> as when PF enter D3 state or undergo an reset and thus
> >> be plug-off, but user won't re-configure the VF in case
> >> the PF return back to working state.
> >
> > If we're relying on the user to reconfigure virtual
> > functions on return to D0 from D3, that's a very fragile
> > system.
> 
> No. that is the concern we don't put those configuration under VF nodes because it will disappear.
> Do I miss something?
> 
> >
> >>>> +For network device, there are:
> >>>> +       - /sys/bus/pci/devices/BB:DD.F/iov/N/mac
> >>>> +       - /sys/bus/pci/devices/BB:DD.F/iov/N/vlan
> >>>> +               (value update will notify PF driver)
> >>>
> >>> We already have tools to set the MAC and VLAN parameters
> >>> for network devices.
> >>
> >> Do you mean Ethtool? If yes, it is impossible for SR-IOV
> >> since the configuration has to be done in PF side,
> >> rather than VF.
> >
> > I don't think ethtool has that ability; ip(8) can set mac
> > addresses and vconfig(8) sets vlan parameters.
> >
> > The device driver already has to be aware of SR-IOV.  If
> > it's going to support the standard tools (and it damn
> > well ought to), then it should call the PF driver to set
> > these kinds of parameters.
> 
> OK, as if it has the VF parameter, will look into details.

Neither ip(8) nor vconfig(8) can set MAC and VLAN address for VF when
the VF driver is not loaded.

> BTW, the SR-IOV patch is not only for network, some other devices such as IDE will use same code base as well and we image it could have other parameter to set such as starting LBA of a IDE VF.

As Eddie said, we have two problems here:
1) User has to set device specific parameters of a VF when he wants to
use this VF with KVM (assign this device to KVM guest). In this case,
VF driver is not loaded in the host environment. So operations which
are implemented as driver callback (e.g. set_mac_address()) are not
supported.
2) For security reason, some SR-IOV devices prohibit the VF driver
configuring the VF via its own register space. Instead, the configurations
must be done through the PF which the VF is associated with. This means PF
driver has to receive parameters that are used to configure its VFs. These
parameters obviously can be passed by traditional tools, if without
modification for SR-IOV.
