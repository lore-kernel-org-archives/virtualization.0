From: "Fischer, Anna" <anna.fischer@hp.com>
Subject: RE: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Thu, 6 Nov 2008 17:38:16 +0000
Message-ID: <0199E0D51A61344794750DC57738F58E5E26F996C4__41824.8883252547$1225993320$gmane$org@GVW1118EXC.americas.hpqcorp.net>
References: <20081106154351.GA30459@kroah.com>
	<894107.30288.qm@web45108.mail.sp1.yahoo.com>
	<20081106164919.GA4099@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081106164919.GA4099@kroah.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>, H L <swdevyid@yahoo.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "Chiang,
	Alexander" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

> On Thu, Nov 06, 2008 at 08:41:53AM -0800, H L wrote:
> > I have not modified any existing drivers, but instead I threw
> together
> > a bare-bones module enabling me to make a call to pci_iov_register()
> > and then poke at an SR-IOV adapter's /sys entries for which no driver
> > was loaded.
> >
> > It appears from my perusal thus far that drivers using these new
> > SR-IOV patches will require modification; i.e. the driver associated
> > with the Physical Function (PF) will be required to make the
> > pci_iov_register() call along with the requisite notify() function.
> > Essentially this suggests to me a model for the PF driver to perform
> > any "global actions" or setup on behalf of VFs before enabling them
> > after which VF drivers could be associated.
>
> Where would the VF drivers have to be associated?  On the "pci_dev"
> level or on a higher one?

A VF appears to the Linux OS as a standard (full, additional) PCI device. The driver is associated in the same way as for a normal PCI device. Ideally, you would use SR-IOV devices on a virtualized system, for example, using Xen. A VF can then be assigned to a guest domain as a full PCI device.

> Will all drivers that want to bind to a "VF" device need to be
> rewritten?

Currently, any vendor providing a SR-IOV device needs to provide a PF driver and a VF driver that runs on their hardware. A VF driver does not necessarily need to know much about SR-IOV but just run on the presented PCI device. You might want to have a communication channel between PF and VF driver though, for various reasons, if such a channel is not provided in hardware.

> > I have so far only seen Yu Zhao's "7-patch" set.  I've not yet looked
> > at his subsequently tendered "15-patch" set so I don't know what has
> > changed.    The hardware/firmware implementation for any given SR-IOV
> > compatible device, will determine the extent of differences required
> > between a PF driver and a VF driver.
>
> Yeah, that's what I'm worried/curious about.  Without seeing the code
> for such a driver, how can we properly evaluate if this infrastructure
> is the correct one and the proper way to do all of this?

Yu's API allows a PF driver to register with the Linux PCI code and use it to activate VFs and allocate their resources. The PF driver needs to be modified to work with that API. While you can argue about how that API is supposed to look like, it is clear that such an API is required in some form. The PF driver needs to know when VFs are active as it might want to allocate further (device-specific) resources to VFs or initiate further (device-specific) configurations. While probably a lot of SR-IOV specific code has to be in the PF driver, there is also support required from the Linux PCI subsystem, which is to some extend provided by Yu's patches.

Anna
