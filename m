From: "Leonid Grossman" <Leonid.Grossman@neterion.com>
Subject: RE: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Sat, 8 Nov 2008 10:37:54 -0500
Message-ID: <78C9135A3D2ECE4B8162EBDCE82CAD77048C24C0__11081.7394954667$1226158938$gmane$org@nekter>
References: <20081106154351.GA30459@kroah.com>
	<894107.30288.qm@web45108.mail.sp1.yahoo.com>
	<20081106164919.GA4099@kroah.com>
	<0199E0D51A61344794750DC57738F58E5E26F996C4@GVW1118EXC.americas.hpqcorp.net>
	<20081106183630.GD11773@parisc-linux.org>
	<491371F0.7020805@codemonkey.ws>
	<20081106225854.GA15439@parisc-linux.org>
	<20081107061952.GF3860@kroah.com> <49145C14.1050409@uniscape.net>
	<20081107184825.GB2320@kroah.com>
	<0199E0D51A61344794750DC57738F58E5E26FF3237@GVW1118EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <0199E0D51A61344794750DC57738F58E5E26FF3237@GVW1118EXC.americas.hpqcorp.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Fischer, Anna" <anna.fischer@hp.com>, Greg KH <greg@kroah.com>, Yu Zhao <yu.zhao@uniscape.net>
Cc: randy.dunlap@oracle.com, grundler@parisc-linux.org, "Chiang,
	Alexander" <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, rdreier@cisco.com, eddie.dong@intel.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, keir.fraser@eu.citrix.com, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, mingo@elte.hu, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Fischer, Anna [mailto:anna.fischer@hp.com]
> Sent: Saturday, November 08, 2008 3:10 AM
> To: Greg KH; Yu Zhao
> Cc: Matthew Wilcox; Anthony Liguori; H L; randy.dunlap@oracle.com;
> grundler@parisc-linux.org; Chiang, Alexander;
linux-pci@vger.kernel.org;
> rdreier@cisco.com; linux-kernel@vger.kernel.org;
jbarnes@virtuousgeek.org;
> virtualization@lists.linux-foundation.org; kvm@vger.kernel.org;
> mingo@elte.hu; keir.fraser@eu.citrix.com; Leonid Grossman;
> eddie.dong@intel.com; jun.nakajima@intel.com; avi@redhat.com
> Subject: RE: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
> 


> > But would such an api really take advantage of the new IOV
interfaces
> > that are exposed by the new device type?
> 
> I agree with what Yu says. The idea is to have hardware capabilities
to
> virtualize a PCI device in a way that those virtual devices can
represent
> full PCI devices. The advantage of that is that those virtual device
can
> then be used like any other standard PCI device, meaning we can use
> existing
> OS tools, configuration mechanism etc. to start working with them.
Also,
> when
> using a virtualization-based system, e.g. Xen or KVM, we do not need
> to introduce new mechanisms to make use of SR-IOV, because we can
handle
> VFs as full PCI devices.
> 
> A virtual PCI device in hardware (a VF) can be as powerful or complex
as
> you like, or it can be very simple. But the big advantage of SR-IOV is
> that hardware presents a complete PCI device to the OS - as opposed to
> some resources, or queues, that need specific new configuration and
> assignment mechanisms in order to use them with a guest OS (like, for
> example, VMDq or similar technologies).
> 
> Anna


Ditto. 
Taking netdev interface as an example - a queue pair is a great way to
scale across cpu cores in a single OS image, but it is just not a good
way to share device across multiple OS images. 
The best unit of virtualization is a VF that is implemented as a
complete netdev pci device (not a subset of a pci device).
 This way, native netdev device drivers can work for direct hw access to
a VF "as is", and most/all Linux networking features (including VMQ)
will work in a guest.
Also, guest migration for netdev interfaces (both direct and virtual)
can be supported via native Linux mechanism (bonding driver), while Dom0
can retain "veto power" over any guest direct interface operation it
deems privileged (vlan, mac address, promisc mode, bandwidth allocation
between VFs, etc.).
 
Leonid
