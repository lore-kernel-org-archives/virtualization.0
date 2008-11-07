From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Fri, 07 Nov 2008 14:03:28 +0800
Message-ID: <4913DA30.3040904__45344.1903614022$1226038118$gmane$org@intel.com>
References: <20081106164919.GA4099@kroah.com>
	<392264.50990.qm@web45103.mail.sp1.yahoo.com>
	<20081106182443.GB17782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081106182443.GB17782@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Greg KH wrote:
> On Thu, Nov 06, 2008 at 10:05:39AM -0800, H L wrote:
>> --- On Thu, 11/6/08, Greg KH <greg@kroah.com> wrote:
>>  
>>> On Thu, Nov 06, 2008 at 08:41:53AM -0800, H L wrote:
>>>> I have not modified any existing drivers, but instead
>>> I threw together
>>>> a bare-bones module enabling me to make a call to
>>> pci_iov_register()
>>>> and then poke at an SR-IOV adapter's /sys entries
>>> for which no driver
>>>> was loaded.
>>>>
>>>> It appears from my perusal thus far that drivers using
>>> these new
>>>> SR-IOV patches will require modification; i.e. the
>>> driver associated
>>>> with the Physical Function (PF) will be required to
>>> make the
>>>> pci_iov_register() call along with the requisite
>>> notify() function.
>>>> Essentially this suggests to me a model for the PF
>>> driver to perform
>>>> any "global actions" or setup on behalf of
>>> VFs before enabling them
>>>> after which VF drivers could be associated.
>>> Where would the VF drivers have to be associated?  On the
>>> "pci_dev"
>>> level or on a higher one?
>>
>> I have not yet fully grocked Yu Zhao's model to answer this.  That
>> said, I would *hope* to find it on the "pci_dev" level.
> 
> Me too.

VF is kind of lightweight PCI device, and it's represented by "struct 
pci_dev". VF driver bounds to the "pci_dev" and works in the same way as 
other drivers.

> 
>>> Will all drivers that want to bind to a "VF"
>>> device need to be
>>> rewritten?
>> Not necessarily, or perhaps minimally; depends on hardware/firmware
>> and actions the driver wants to take.  An example here might assist.
>> Let's just say someone has created, oh, I don't know, maybe an SR-IOV
>> NIC.  Now, for 'general' I/O operations to pass network traffic back
>> and forth there would ideally be no difference in the actions and
>> therefore behavior of a PF driver and a VF driver.  But, what do you
>> do in the instance a VF wants to change link-speed?  As that physical
>> characteristic affects all VFs, how do you handle that?  This is where
>> the hardware/firmware implementation part comes to play.  If a VF
>> driver performs some actions to initiate the change in link speed, the
>> logic in the adapter could be anything like:
> 
> <snip>
> 
> Yes, I agree that all of this needs to be done, somehow.
> 
> It's that "somehow" that I am interested in trying to see how it works
> out.

This is device specific part. VF driver is free to do what it wants to 
do with device specific registers and resources, and wouldn't concern us 
as far as it behaves as PCI device driver.

> 
>>>> I have so far only seen Yu Zhao's
>>> "7-patch" set.  I've not yet looked
>>>> at his subsequently tendered "15-patch" set
>>> so I don't know what has
>>>> changed.    The hardware/firmware implementation for
>>> any given SR-IOV
>>>> compatible device, will determine the extent of
>>> differences required
>>>> between a PF driver and a VF driver.
>>> Yeah, that's what I'm worried/curious about. 
>>> Without seeing the code
>>> for such a driver, how can we properly evaluate if this
>>> infrastructure
>>> is the correct one and the proper way to do all of this?
>>
>> As the example above demonstrates, that's a tough question to answer.
>> Ideally, in my view, there would only be one driver written per SR-IOV
>> device and it would contain the logic to "do the right things" based
>> on whether its running as a PF or VF with that determination easily
>> accomplished by testing the existence of the SR-IOV extended
>> capability.    Then, in an effort to minimize (if not eliminate) the
>> complexities of driver-to-driver actions for fielding "global events",
>> contain as much of the logic as is possible within the adapter.
>> Minimizing the efforts required for the device driver writers in my
>> opinion paves the way to greater adoption of this technology.
> 
> Yes, making things easier is the key here.
> 
> Perhaps some of this could be hidden with a new bus type for these kinds
> of devices?  Or a "virtual" bus of pci devices that the original SR-IOV
> device creates that corrispond to the individual virtual PCI devices?
> If that were the case, then it might be a lot easier in the end.

PCI SIG only defines SR-IOV at PCI level, we can't predict what the 
hardware vendors would implement at device specific logic level.

An example of SR-IOV NIC: PF may not have network functionality, it only 
controls VFs. Because people only want to use VFs in virtual machines, 
they don't need network functionality in the environment (e.g. 
hypervisor) where PF resides.

Thanks,
Yu
