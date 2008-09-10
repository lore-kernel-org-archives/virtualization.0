From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: RE: [PATCH 4/4 v2] PCI: document the change
Date: Wed, 10 Sep 2008 15:55:08 +0800
Message-ID: <7A25B56E4BE99C4283EB931CD1A40E110181CB0C__686.687840107147$1221033469$gmane$org@pdsmsx414.ccr.corp.intel.com>
References: <7A25B56E4BE99C4283EB931CD1A40E110177EB70@pdsmsx414.ccr.corp.intel.com>
	<20080901154217.GE16796@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080901154217.GE16796@ldl.fc.hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Chiang <achiang@hp.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, xen-devel@lists.xensource.com, Grant Grundler <grundler@parisc-linux.org>, kvm@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Monday, September 01, 2008 11:42 PM, Alex Chiang wrote:
>To: Zhao, Yu
>Cc: Jesse Barnes; linux-pci@vger.kernel.org; Randy Dunlap; Greg KH; Grant
>Grundler; Matthew Wilcox; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
>virtualization@lists.linux-foundation.org; xen-devel@lists.xensource.com
>Subject: Re: [PATCH 4/4 v2] PCI: document the change
>
>* Zhao, Yu <yu.zhao@intel.com>:
>> +1. Overview
>> +
>> +1.1 What is SR-IOV
>> +
>> +Single Root I/O Virtualization (SR-IOV) is a PCI Express Extended
>> +capability which makes one physical device appear as multiple virtual
>> +devices. The physical device is referred to as Physical Function while
>> +the virtual devices are referred to as Virtual Functions. Allocation
>> +of Virtual Functions can be dynamically controlled by Physical Function
>> +via registers encapsulated in the capability. By default, this feature
>> +is not enabled and the Physical Function behaves as traditional PCIe
>> +device. Once it's turned on, each Virtual Function's PCI configuration
>> +space can be accessed by its own Bus, Device and Function Number (Routing
>> +ID). And each Virtual Function also has PCI Memory Space, which is used
>> +to map its register set. Virtual Function device driver operates on the
>> +register set so it can be functional and appear as a real existing PCI
>> +device.
>> +
>> +1.2 What is ARI
>> +
>> +Alternative Routing-ID Interpretation (ARI) allows a PCI Express Endpoint
>> +to use its device number field as part of function number. Traditionally,
>> +an Endpoint can only have 8 functions, and the device number of all
>> +Endpoints is zero. With ARI enabled, an Endpoint can have up to 256
>> +functions by using device number in conjunction with function number to
>> +indicate a function in the device. This is almost transparent to the Linux
>> +kernel because the Linux kernel still can use 8-bit bus number field plus
>> +8-bit devfn number field to locate a function. ARI is managed via the ARI
>> +Forwarding bit in the Device Capabilities 2 register of the PCI Express
>> +Capability on the Root Port or the Downstream Port and a new ARI Capability
>> +on the Endpoint.
>> +
>> +
>> +2. User Guide
>> +
>> +2.1 How can I manage SR-IOV
>> +
>> +If a device supports SR-IOV, then there should be some entires under
>                                                          entries
>> +/sys/bus/pci/slots/. The names of the entires are XXXX:BB:DD.F-iov-NNNN,
>                                         entries
>> +where the first part (XXXX:BB:DD.F) is the domain, bus, device and function
>> +number of the device, and the third part (NNNN) is the index of a Virtual
>> +Function. There are three files under the entry: power, param and address.
>
>So are you saying here that you will actually create sysfs files
>named:
>
>	/sys/bus/pci/slots/XXXX:BB:DD.F-iov-NNNN
>
>We just spent some effort cleaning out this directory and getting
>human-readable names in /sys/bus/pci/slots/. The entries created
>there _should_ match the labelling on the physical chassis,
>assuming firmware tells us the right name.
>
>How will these particular slot entries be created? Do the
>individual hotplug drivers create them?

The Virtual Function is almost same as PCI function that belongs to a PCI device. I used hotplug framework as user interface to control the allocation of PCI software instance ('struct pci_dev') for Virtual Function.

After another round of consideration, I plan to remove the usage of PCI hotplug interface and create SR-IOV sysfs entries under /sys/bus/pci/devices/.../iov/. So this won't bring any confusion and also keep /sys/bus/pci/slots/ clean.

>
>Sorry, I guess I haven't read the patch series, just skimmed the
>documentation. I can go do that before asking any further dumb
>questions, but this little bit of information was a bit
>surprising to me.
>
>> +	- Writing 1 to the "power" will enable the Virtual Function,
>> +	and 0 will disable the Virtual Function; Reading it will get
>> +	status of the Virtual Function.
>> +	- Reading the "address" will get the bus, device and function
>> +	number of the Virtual Function.
>> +	- The "param" is the device specific parameters which may be
>> +	used by the Physical or Virtual Functions drivers.
>> +
>> +2.2 How can I use Virtual Functions
>> +
>> +Virtual Functions is treated as hot-plugged PCI devices in the kernel,
>> +so they should be able to work in the same way as real PCI devices.
>> +NOTE: Virtual Function device driver must be loaded to make it work.
>
>Ok, I'll go read the rest of the patch series; looks like you
>wrote a new virtual function driver.
>
>Thanks.
>
>/ac
