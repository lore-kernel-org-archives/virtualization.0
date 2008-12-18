From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: Re: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Thu, 18 Dec 2008 10:13:58 +0800
Message-ID: <4949B1E6.7030309__38912.3372886845$1229566570$gmane$org@intel.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<200812161523.55238.jbarnes@virtuousgeek.org>
	<0199E0D51A61344794750DC57738F58E5E29B33E3C@GVW1118EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0199E0D51A61344794750DC57738F58E5E29B33E3C@GVW1118EXC.americas.hpqcorp.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Fischer, Anna" <anna.fischer@hp.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "Chiang,
	Alexander" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "horms@verge.net.au" <horms@verge.net.au>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "mingo@elte.hu" <mingo@elte.hu>, "yinghai@kernel.org" <yinghai@kernel.org>, "Helgaas,
	Bjorn" <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

Fischer, Anna wrote:
> I have two minor comments on this topic.
> 
> 1) Currently the PF driver is called before the kernel initializes VFs and
> their resources, and the current API does not allow the PF driver to
> detect that easily if the allocation of the VFs and their resources
> has succeeded or not. It would be quite useful if the PF driver gets
> notified when the VFs have been created successfully as it might have
> to do further device-specific work *after* IOV has been enabled.

If the VF allocation fails in the PCI layer, then the SR-IOV core will 
invokes the callback again to notify the PF driver with zero VF count. 
The PF driver does not have to concern about this even the PCI layer 
code fails (and actually it's very rare).

And I'm not sure why the PF driver wants to do further work *after* the 
VF is allocated. Does this mean PF driver have to set up some internal 
resources related to SR-IOV/VF? If yes, I suggest the PF driver do it 
before VF allocation. The design philosophy of SR-IOV/VF is that VF is 
treated as hot-plug device, which means it should be immediately usable 
by VF driver (e.g. VF driver is pre-loaded) after it appears in the PCI 
subsystem. If that is not the purpose, then PF driver should handle it 
not depending on the SR-IOV, right?

If you could elaborate your SR-IOV PF/VF h/w specific requirement, it 
would be help for me to answer this question :-)

> 2) Configuration of SR-IOV: the current API allows to enable/disable
> VFs from userspace via SYSFS. At the moment I am not quite clear what
> exactly is supposed to control these capabilities. This could be
> Linux tools or, on a virtualized system, hypervisor control tools.

This depends on user application, you know, which depends on the usage 
environment (i.e. native, KVM or Xen).

> One thing I am missing though is an in-kernel API for this which I
> think might be useful. After all the PF driver controls the device,
> and, for example, when a device error occurs (e.g. a hardware failure
> which only the PF driver will be able to detect, not Linux), then the
> PF driver might have to de-allocate all resources, shut down VFs and
> reset the device, or something like that. In that case the PF driver
> needs to have a way to notify the Linux SR-IOV code about this and
> initiate cleaning up of VFs and their resources. At the moment, this
> would have to go through userspace, I believe, and I think that is not
> an optimal solution. Yu, do you have an opinion on how this would be
> realized?

Yes, the PF driver can use pci_iov_unregister to disable SR-IOV in case 
the fatal error occurs. This function also sends notification to user 
level through 'uevent' so user application can aware the change.

Thanks,
Yu
