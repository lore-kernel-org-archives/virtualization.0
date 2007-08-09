From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 25/25] [PATCH] add paravirtualization support for x86_64
Date: Wed, 08 Aug 2007 23:53:17 -0700
Message-ID: <46BAB9DD.5030400__49615.1431151249$1186642612$gmane$org@goop.org>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<1186546847263-git-send-email-gcosta@redhat.com>
	<11865468513077-git-send-email-gcosta@redhat.com>
	<200708081200.13669.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708081200.13669.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> +	if (opfunc == NULL)
>> +		/* If there's no function, patch it with a ud2a (BUG) */
>> +		ret = paravirt_patch_insns(site, len, start_ud2a, end_ud2a);
>>     
>
> This will actually give corrupted BUGs because you don't supply
> the full inline BUG header. Perhaps another trap would be better.
>   

The BUG handler will still report it as a normal illegal instruction. 
It should never happen; the main thing is that it clearly points out
where the problem is (as opposed to jumping to a NULL pointer and
getting the unhelpful "oh, eip is zero" symptom).

>> +EXPORT_SYMBOL(paravirt_ops);
>>     
>
> Definitely _GPL at least.
>   

No, for the same reason as i386.

>> +extern struct paravirt_ops paravirt_ops;
>>     
>
> Should be native_paravirt_ops I guess
>
>   

No, because its the current set of pv_ops.  It starts all native, but it
is either completely or partially overwritten by hypervisor-specific ops.

>> +
>> + * This generates an indirect call based on the operation type number.
>>     
>
> The macros here don't
>   

Yes, PARAVIRT_CALL does: "call *(paravirt_ops+%c[paravirt_typenum]*8);"


>> +			     : "=a"(f)
>> +			     : paravirt_type(save_fl),
>> +			       paravirt_clobber(CLBR_RAX)
>> +			     : "memory", "cc");
>> +	return f;
>> +}
>> +
>> +static inline void raw_local_irq_restore(unsigned long f)
>> +{
>> +	__asm__ __volatile__(paravirt_alt(PARAVIRT_CALL)
>> +			     :
>> +			     : "D" (f),
>>     
>
> Have you investigated if a different input register generates better/smaller 
> code? I would assume rdi to be usually used already for the caller's 
> arguments so it will produce spilling
>
> Similar for the rax return in the other functions.
>   

This has to match the normal C calling convention though, doesn't it?

    J
