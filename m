From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Fri, 7 Nov 2008 10:48:25 -0800
Message-ID: <20081107184825.GB2320__22065.0400653996$1226088955$gmane$org@kroah.com>
References: <20081106154351.GA30459@kroah.com>
	<894107.30288.qm@web45108.mail.sp1.yahoo.com>
	<20081106164919.GA4099@kroah.com>
	<0199E0D51A61344794750DC57738F58E5E26F996C4@GVW1118EXC.americas.hpqcorp.net>
	<20081106183630.GD11773@parisc-linux.org>
	<491371F0.7020805@codemonkey.ws>
	<20081106225854.GA15439@parisc-linux.org>
	<20081107061952.GF3860@kroah.com> <49145C14.1050409@uniscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49145C14.1050409@uniscape.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yu Zhao <yu.zhao@uniscape.net>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "Chiang,
	Alexander" <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, Leonid.Grossman@neterion.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, eddie.dong@intel.com, keir.fraser@eu.citrix.com, Anthony Liguori <anthony@codemonkey.ws>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 07, 2008 at 11:17:40PM +0800, Yu Zhao wrote:
> While we are arguing what the software model the SR-IOV should be, let me 
> ask two simple questions first:
>
> 1, What does the SR-IOV looks like?
> 2, Why do we need to support it?

I don't think we need to worry about those questions, as we can see what
the SR-IOV interface looks like by looking at the PCI spec, and we know
Linux needs to support it, as Linux needs to support everything :)

(note, community members that can not see the PCI specs at this point in
time, please know that we are working on resolving these issues,
hopefully we will have some good news within a month or so.)

> As you know the Linux kernel is the base of various virtual machine 
> monitors such as KVM, Xen, OpenVZ and VServer. We need SR-IOV support in 
> the kernel because mostly it helps high-end users (IT departments, HPC, 
> etc.) to share limited hardware resources among hundreds or even thousands 
> virtual machines and hence reduce the cost. How can we make these virtual 
> machine monitors utilize the advantage of SR-IOV without spending too much 
> effort meanwhile remaining architectural correctness? I believe making VF 
> represent as much closer as a normal PCI device (struct pci_dev) is the 
> best way in current situation, because this is not only what the hardware 
> designers expect us to do but also the usage model that KVM, Xen and other 
> VMMs have already supported.

But would such an api really take advantage of the new IOV interfaces
that are exposed by the new device type?

> I agree that API in the SR-IOV pacth is arguable and the concerns such as 
> lack of PF driver, etc. are also valid. But I personally think these stuff 
> are not essential problems to me and other SR-IOV driver developers.

How can the lack of a PF driver not be a valid concern at this point in
time?  Without such a driver written, how can we know that the SR-IOV
interface as created is sufficient, or that it even works properly?

Here's what I see we need to have before we can evaluate if the IOV core
PCI patches are acceptable:
  - a driver that uses this interface
  - a PF driver that uses this interface.

Without those, we can't determine if the infrastructure provided by the
IOV core even is sufficient, right?

Rumor has it that there is both of the above things floating around, can
someone please post them to the linux-pci list so that we can see how
this all works together?

thanks,

greg k-h
