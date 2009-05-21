From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 16:11:26 +0300
Message-ID: <20090521131126.GG25309__41781.3786458739$1242911705$gmane$org@redhat.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211301.52089.paul@codesourcery.com>
	<4A154432.1060808@redhat.com>
	<200905211329.41578.paul@codesourcery.com>
	<4A154B60.4080701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A154B60.4080701@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 21, 2009 at 03:38:56PM +0300, Avi Kivity wrote:
> Paul Brook wrote:
>>> Instead of writing directly, let's abstract it behind a qemu_set_irq().
>>> This is easier for device authors.  The default implementation of the
>>> irq callback could write to apic memory, while for kvm we can directly
>>> trigger the interrupt via the kvm APIs.
>>>     
>>
>> I'm still not convinced.
>>
>> A tight coupling between PCI devices and the APIC is just going to 
>> cause us problems later one. I'm going to come back to the fact that 
>> these are memory writes so once we get IOMMU support they will 
>> presumably be subject to remapping by that, just like any other memory 
>> access.
>>   
>
> I'm not suggesting the qemu_irq will extend all the way to the apic.   
> Think of it as connecting the device core with its interrupt unit.
>
>> Even ignoring that, qemu_irq isn't really the right interface. A MSI is a one-
>> off event, not a level state. OTOH stl_phys is exactly the right interface.
>>   
>
> The qemu_irq callback should do an stl_phys().

Actually, it seems we can't do it this way now as stl_phys
only gets a 32 bit address. So I'll use apic_deliver for now,
but yes, it will be easy to later rewrite MSI implementation this way
if that limitatiuon is lifted.


> The device is happy  
> since it's using the same API it uses for non-MSI.  The APIC is happy  
> since it isn't connected directly to the device.  stl_phys() is happy  
> since it sees more traffic and can serve more ads.  kvm is happy since  
> it can hijack the callback to throw the interrupt directly into the 
> kernel.
>
>> The KVM interface should be contained within the APIC implementation.
>>   
>
> Tricky, but doable.
>
> -- 
> error compiling committee.c: too many arguments to function

-- 
MST
