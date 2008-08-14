From: Greg KH <greg@kroah.com>
Subject: Re: SR-IOV: patches are available for Linux kernel [4/4]
Date: Thu, 14 Aug 2008 05:12:45 -0700
Message-ID: <20080814121245.GB31927__32493.5957360596$1218717582$gmane$org@kroah.com>
References: <7A25B56E4BE99C4283EB931CD1A40E110164BC9B@pdsmsx414.ccr.corp.intel.com>
	<20080813130916.3bf3bc0c.randy.dunlap@oracle.com>
	<20080813234620.GB32154@kroah.com>
	<7A25B56E4BE99C4283EB931CD1A40E1101686518@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <7A25B56E4BE99C4283EB931CD1A40E1101686518@pdsmsx414.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhao, Yu" <yu.zhao@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, xen-devel@lists.xensource.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 14, 2008 at 03:50:26PM +0800, Zhao, Yu wrote:
> On Thursday, August 14, 2008 7:46 AM, Greg KH <mailto:greg@kroah.com> wrote:
> > On Wed, Aug 13, 2008 at 01:09:16PM -0700, Randy Dunlap wrote:
> >> On Tue, 12 Aug 2008 16:46:39 +0800 Zhao, Yu wrote:
> >> 
> >>> [PATCH 4/4] PCI: document SR-IOV
> >>> 
> >>> SR-IOV Documentation.
> >>> 
> >>> Signed-off-by: Yu Zhao <yu.zhao@intel.com>
> >>> Signed-off-by:  Eddie Dong <eddie.dong@intel.com>
> >>> 
> >>> ---
> >>>  Documentation/ABI/testing/sysfs-bus-pci |   13 ++
> >>>  Documentation/PCI/00-INDEX              |    2
> >>>  Documentation/PCI/pci-iov-howto.txt     |  170
> > +++++++++++++++++++++++++++++++
> >>>  3 files changed, 185 insertions(+), 0 deletions(-)
> >>> 
> >>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci
> > b/Documentation/ABI/testing/sysfs-bus-pci
> >>> index ceddcff..9ada27b 100644
> >>> --- a/Documentation/ABI/testing/sysfs-bus-pci
> >>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> >>> @@ -9,3 +9,16 @@ Description:
> >>>  		that some devices may have malformatted data.  If the
> >>>  		underlying VPD has a writable section then the
> >>>  		corresponding section of this file will be writable. +
> >>> +What:		/sys/bus/pci/devices/.../iov
> >>> +Date:		August 2008
> >>> +Contact:	Yu Zhao <yu.zhao@intel.com>
> >>> +Description:
> >>> +		This file will appear when SR-IOV capability is enabled
> >>> +		by the device driver if supported. It holds number of
> >>> +		available Virtual Functions and Bus, Device, Function
> >>> +		number and status of these Virtual Functions that belong
> >>> +		to this device (Physical Function). This file can be
> >> 
> >> This one file contains available VFs, Bus:dev:Func number, and
> >> status? Sounds like a misuse (abuse) of sysfs "one value per file"
> >> mantra, but I'll read below to see how it's done.
> >> 
> >> [added GregKH to cc: list]
> > 
> > I agree, why not just display the device tree of available devices
> > like all other busses do? 
> > 
> 
> Thanks for the comments. 
> 
> Will separate this file to
> /sys/bus/pci/devices/.../iov/{NumVFs,VF1,VF2,...}. The NumVFs file
> contains number of available VFs, and each VF file contains
> "bus:dev.func=status". Sounds better?

That sounds better yes.

Please use a 'struct device' for this as well, not a "raw" kobject.

thanks,

greg k-h
