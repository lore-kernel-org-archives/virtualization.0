From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 11:32:06 -0600
Message-ID: <45EDA596.3020607@us.ibm.com>
References: <8FFF7E42E93CC646B632AB40643802A80229779B@scsmsx412.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965373AbXCFRck@vger.kernel.org>
In-Reply-To: <8FFF7E42E93CC646B632AB40643802A80229779B@scsmsx412.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, virtualization <virtualization@lists.osdl.org>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Nakajima, Jun wrote:
> Anthony Liguori wrote:
>   
>> Ingo Molnar wrote:
>>     
>>> * Gerd Hoffmann <kraxel@suse.de> wrote:
>>>
>>>       
>>>>>> So in the end you would still have two different hypervisor ABI's,
>>>>>> the VMI ROM just hides that.
>>>>>>             
>>>>> oh, but that way i have cleverly pushed the problem out of Linux
>>>>> and into the VMI-ROM's domain ;) Which is all i care about.
>>>>>           
>>>> Fine, so lets move kvm paravirtualitzation into vmi too (proof of
>>>> concept code by Anthony Liguori exists) and kill one more item on
>>>> the (linux) QA test matrix?  (just following your arguments, not
>>>> that I'm confident it would actually help reducing QA effort).
>>>>         
>>> yes - although obviously a KVM Linux guest does not need such an
>>> interface - but it's a nice proof of concept to integrate other guest
>>> OSs into KVM.
>>>       
>> I disagree that a KVM Linux guest does not benefit from VMI.  Right
>> now, your KVM paravirt interface only covers CR3 target caching and
>> apic enhancements (neither of which I believe have made it into
>> 2.6.21). Inevitably, things like MMU batching will be added.
>>     
>
> I think a KVM Linux would benefit more from paravirt ops, rather than
> VMI. 

Functionally speaking, the only difference between using VMI and 
paravirt_ops is that with VMI you redirect the paravirt_ops to a ROM 
area.  This has the following effects:

1) you cannot call back into Linux from the op implementation
2) you can change the implementation of the op w/o rebuilding the kernel

1 & 2 are trade-offs.  For everything that KVM can do wrt 
paravirtualization, there really isn't a need for #1 at the moment.  Xen 
is much more challenging to do with VMI as there are a lot of instances 
where #1 is quite useful.  I think you pretty much have to target 
paravirt_ops for Xen.

> The higher-level interface such as the one in Xen, espeically for
> I/O, interrupt controllers, timer, SMP, etc. actually simplifies the
> implementation of the VMM,

Right, but those higher-level interfaces can certainly be implemented 
within the context of a VMI rom.  For instance, VMI already defines a 
paravirtual timer.  In the case of interrupt control, it just provides 
hooks for APIC reads/writes with the assumption (presumably) that the 
ROM will implement APIC emulation and bridge to whatever the hypervisor 
abstraction is.

>  and improve performance of the guest. Even
> for MMU, direct page tables, for example, would work better for
> hardware-based virtualization because the processor can use the native
> page tables. 
>   

Direct paging is a whole other can of worms.  Fortunately, EPT and NPT 
will eliminate the need to worry about this in the future for things 
like KVM/HVM :-)

Regards,

Anthony Liguori

>> Using paravirt_ops, this is going to require new kernels for the
>>   guests. Every new paravirtualization feature will require a new
>>   guest kernel. With VMI, one can add these features to any 2.6.21+
>> guest by just modifying the ROM (assuming a newer host).  Some
>> features will require new VMI entry points but quite a lot will fall
>> under the current entry points.
>>
>> Of all the hypervisors, KVM is the easiest to use VMI with.  QEMU
>> already supports option ROM loading and Zach just made some changes to
>> allow a native ROM to be implemented very easily.
>>
>> If we're going to use VMI for anything other than VMware, it seems to
>> be that KVM should be what we use it for.
>>
>> Regards,
>>
>> Anthony Liguori
>>
>>     
>>> 	Ingo
>>>       
>
> Jun
> ---
> Intel Open Source Technology Center
>
>   
