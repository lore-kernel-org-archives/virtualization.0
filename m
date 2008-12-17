From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Wed, 17 Dec 2008 10:59:34 -0800
Message-ID: <200812171059.36188.jbarnes__29265.6008656651$1229540578$gmane$org@virtuousgeek.org>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<200812161523.55238.jbarnes@virtuousgeek.org>
	<0199E0D51A61344794750DC57738F58E5E29B33E3C@GVW1118EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0199E0D51A61344794750DC57738F58E5E29B33E3C@GVW1118EXC.americas.hpqcorp.net>
Content-Disposition: inline
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
	Alexander" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "horms@verge.net.au" <horms@verge.net.au>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "mingo@elte.hu" <mingo@elte.hu>, "yinghai@kernel.org" <yinghai@kernel.org>, "Helgaas,
	Bjorn" <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday, December 17, 2008 3:42 am Fischer, Anna wrote:
> I have two minor comments on this topic.
>
> 1) Currently the PF driver is called before the kernel initializes VFs and
> their resources, and the current API does not allow the PF driver to
> detect that easily if the allocation of the VFs and their resources
> has succeeded or not. It would be quite useful if the PF driver gets
> notified when the VFs have been created successfully as it might have
> to do further device-specific work *after* IOV has been enabled.

You're thinking of after the VFs are created the VF drivers (which may or may 
not be part of the PF driver) may not be able to communicate back to the PF 
driver that something else needs to be done (I remember seeing this in the 
earlier thread, should have included it in my post, sorry)?  I'm not sure if 
it makes sense to add an interface like that to the core until we have feel 
for what the PF/VF drivers are going to want... Or do you have something 
specific in mind right now?  If/until we have something in the core, it seems 
like this could be done on a per PF/VF driver basis for now.

> 2) Configuration of SR-IOV: the current API allows to enable/disable
> VFs from userspace via SYSFS. At the moment I am not quite clear what
> exactly is supposed to control these capabilities. This could be
> Linux tools or, on a virtualized system, hypervisor control tools.
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

That's a good point, Yu?

-- 
Jesse Barnes, Intel Open Source Technology Center
