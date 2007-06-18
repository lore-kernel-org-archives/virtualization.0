From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: Re: [PATCH 4/5] KVM: Add hypercall queue for
	paravirt_ops implementation
Date: Mon, 18 Jun 2007 10:20:52 -0500
Message-ID: <4676A2D4.2040704@codemonkey.ws>
References: <4675F462.1010708@codemonkey.ws> <4675F568.90608@codemonkey.ws>
	<46764B47.5060403@qumranet.com>
	<46767D47.1010104@codemonkey.ws> <46767F98.70109@qumranet.com>
	<46768724.3000509@codemonkey.ws> <46768A3F.2010202@qumranet.com>
	<4676905B.6000805@codemonkey.ws> <46769FFE.6040502@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46769FFE.6040502-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Anthony Liguori wrote:
>> Avi Kivity wrote:
>>>>> These numbers are pretty bad.  I'd like to improve them, even 
>>>>> without PV.
>>>>
>>>> I agree.  Do you know what's missing at this point?  There isn't a 
>>>> whole lot of state saving going on for the light weight exit paths 
>>>> for SVM.
>>>
>>> The SVM code doesn't even have a lightweight vmexit path.  
>>
>> Sure it does.  Quite a lot is deferred to vcpu_{load,put}.
>
> Ah, I forgot.  Yes, the syscall msrs are deferred.
>
>>
>>> For every vmexit, it does the entire thing, including vmload/vmsave
>>
>> I haven't had a lot of luck eliminating vmload/vmsave.
>>
>
> For x86_64, the only issue I see is with TR.  Unfortunately, I don't 
> see a way around it.
>
>
>>> , fpu switch (if needed)
>>
>> The FPU switch can really be avoided?  Is it safe to assume that the 
>> KVM code isn't going to use any FPU operations?
>
> Generally, kernel code does not use the fpu (when it does, it calls 
> kernel_fpu_begin() and kernel_fpu_end()).  The vmx code avoids the 
> switch.
>
> Of course, if the guest doesn't use the fpu, the switch is avoided 
> anyway.
>
>>>
>>> For kbuild vs. kernbench, I suspect that -j4 causes the shadow page 
>>> table cache to thrash.  1024 pages may be enough for a single 
>>> instance but not -j4.  Hopefully replacing the eviction algorithm 
>>> (currently FIFO) will help.  Otherwise we'll need to resize the 
>>> cache again.
>>
>> I naively tried to bump it to 2048 and hit a kmalloc limitation.
>>
>
> struct kvm is 22K on x86_64.  Adding 1024 pointers makes it 30K.  What 
> error did you get?

With an older kvm, on a different system, I was getting:

WARNING: "__you_cannot_kzalloc_that_much"

On the latest git though, I don't seem to get that warning on my 
development system even if I bump all the way up to 8192.  I'll see what 
bumping to 2048 does to kernbench.  4MB is actually small compared to 
other hypervisors for a shadow page table cache (Xen defaults to 8mb) so 
we may see good results.

Regards,

Anthony Liguori

> We should probably make the hashtable a pointer, and allocate vcpus 
> separately as well.
>


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
