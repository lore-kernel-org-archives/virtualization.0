From: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/3] virtio PCI device
Date: Tue, 27 Nov 2007 11:02:32 +0200
Message-ID: <474BDD28.7050801@qumranet.com>
References: <11944899922822-git-send-email-aliguori@us.ibm.com>	<11944900141678-git-send-email-aliguori@us.ibm.com>	<11944900152750-git-send-email-aliguori@us.ibm.com>	<11944900163817-git-send-email-aliguori@us.ibm.com>	<4742F6B7.20503@qumranet.com>	<474300AD.4060509@us.ibm.com>	<4743076F.8000105@qumranet.com>
	<47435CCB.1050506@us.ibm.com>	<4743DAA4.70800@qumranet.com>
	<4747051C.3090903@us.ibm.com> <4747122F.1070905@qumranet.com>
	<474B1BF3.20901@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <474B1BF3.20901-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: Eric Van Hensbergen <ericvanhensbergen-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lguest <lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
>> Another point is that virtio still has a lot of leading zeros in its 
>> mileage counter. We need to keep things flexible and learn from 
>> others as much as possible, especially when talking about the ABI.
>
> Yes, after thinking about it over holiday, I agree that we should at 
> least introduce a virtio-pci feature bitmask.  I'm not inclined to 
> attempt to define a hypercall ABI or anything like that right now but 
> having the feature bitmask will at least make it possible to do such a 
> thing in the future.

No, definitely not define a hypercall ABI.  The feature bit should say 
"this device understands a hypervisor-specific way of kicking.  consult 
your hypervisor manual and cpuid bits for further details.  should you 
not be satisfied with this method, port io is still available".

>
>>> I'm wary of introducing the notion of hypercalls to this device 
>>> because it makes the device VMM specific.  Maybe we could have the 
>>> device provide an option ROM that was treated as the device "BIOS" 
>>> that we could use for kicking and interrupt acking?  Any idea of how 
>>> that would map to Windows?  Are there real PCI devices that use the 
>>> option ROM space to provide what's essentially firmware?  
>>> Unfortunately, I don't think an option ROM BIOS would map well to 
>>> other architectures.
>>>
>>>   
>>
>> The BIOS wouldn't work even on x86 because it isn't mapped to the 
>> guest address space (at least not consistently), and doesn't know the 
>> guest's programming model (16, 32, or 64-bits? segmented or flat?)
>>
>> Xen uses a hypercall page to abstract these details out. However, I'm 
>> not proposing that. Simply indicate that we support hypercalls, and 
>> use some layer below to actually send them. It is the responsibility 
>> of this layer to detect if hypercalls are present and how to call them.
>>
>> Hey, I think the best place for it is in paravirt_ops. We can even 
>> patch the hypercall instruction inline, and the driver doesn't need 
>> to know about it.
>
> Yes, paravirt_ops is attractive for abstracting the hypercall calling 
> mechanism but it's still necessary to figure out how hypercalls would 
> be identified.  I think it would be necessary to define a virtio 
> specific hypercall space and use the virtio device ID to claim subspaces.
>
> For instance, the hypercall number could be (virtio_devid << 16) | 
> (call number).  How that translates into a hypercall would then be 
> part of the paravirt_ops abstraction.  In KVM, we may have a single 
> virtio hypercall where we pass the virtio hypercall number as one of 
> the arguments or something like that.

If we don't call it a hypercall, but a virtio kick operation, we don't 
need to worry about the hypercall number or ABI.  It's just a function 
that takes an argument that's implemented differently by every 
hypervisor.  The default implementation can be a pio operation.

>>>> Make it appear as a pci function?  (though my feeling is that 
>>>> multiple mounts should be different devices; we can then hotplug 
>>>> mountpoints).
>>>>     
>>>
>>> We may run out of PCI slots though :-/
>>>   
>>
>> Then we can start selling virtio extension chassis.
>
> :-)  Do you know if there is a hard limit on the number of devices on 
> a PCI bus?  My concern was that it was limited by something stupid 
> like an 8-bit identifier.

IIRC pci slots are 8-bit, but you can have multiple buses, so 
effectively 16 bits of device address space (discounting functions which 
are likely not hot-pluggable).


-- 
error compiling committee.c: too many arguments to function


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
