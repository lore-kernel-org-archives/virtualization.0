From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 15:08:18 +0300
Message-ID: <4A154432.1060808__28129.0410006934$1242907967$gmane$org@redhat.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211134.21184.paul@codesourcery.com>
	<4A15346C.8090906@redhat.com>
	<200905211301.52089.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905211301.52089.paul@codesourcery.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Paul Brook wrote:
>>>> In any case we need some internal API for this, and qemu_irq looks like
>>>> a good choice.
>>>>         
>>> What do you expect to be using this API?
>>>       
>> virtio, emulated devices capable of supporting MSI (e1000?), device
>> assignment (not yet in qemu.git).
>>     
>
> It probably makes sense to have common infrastructure in pci.c to 
> expose/implement device side MSI functionality. However I see no need for a 
> direct API between the device and the APIC. We already have an API for memory 
> accesses and MMIO regions. I'm pretty sure a system could implement MSI by 
> pointing the device at system ram, and having the CPU periodically poll that.
>   

Instead of writing directly, let's abstract it behind a qemu_set_irq().  
This is easier for device authors.  The default implementation of the 
irq callback could write to apic memory, while for kvm we can directly 
trigger the interrupt via the kvm APIs.

-- 
error compiling committee.c: too many arguments to function
