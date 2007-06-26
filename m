From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: Re: [PATCH 1/5] KVM paravirt_ops core infrastructure
Date: Tue, 26 Jun 2007 06:57:27 -0500
Message-ID: <4680FF27.3090907@codemonkey.ws>
References: <4675F462.1010708@codemonkey.ws> <4675F4C3.6050700@codemonkey.ws>	
	<64F9B87B6B770947A9F8391472E032160C73025E@ehost011-8.exch011.intermedia.net>
	<fdaac4d50706260145x1ebceadt432edd5b6a6ac1f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fdaac4d50706260145x1ebceadt432edd5b6a6ac1f2-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jun Koi <junkoi2004-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Jun Koi wrote:
> On 6/26/07, Dor Laor <dor.laor-atKUWr5tajBWk0Htik3J/w@public.gmane.org> wrote:
>> ...
>> +static __init struct kvm_paravirt_state *paravirt_alloc_state(void)
>> +{
>> +       struct kvm_paravirt_state *state;
>> +
>> +       state = (void *)get_zeroed_page(GFP_KERNEL);
>> +       if (!state)
>> +               goto err;
>> +
>> +       state->vmca = (void *)get_zeroed_page(GFP_KERNEL);
>> +       if (!state->vmca)
>> +               goto err;
>> +
>> +       /* FIXME: what do I need for this to be executable on 64 bit? */
>> +       state->hypercall = (void *)get_zeroed_page(GFP_KERNEL);
>>
>> Why do you alloc a page for the hypercall instead of using Ingo's code
>> below? This way it can work for 64 bit too.
>>
>> Ingo's code:
>> /*
>>  * This is the vm-syscall address - to be patched by the host to
>>  * VMCALL (Intel) or VMMCALL (AMD), depending on the CPU model:
>>  */
>> asm (
>>         "       .globl hypercall_addr                   \n"
>>         "       .align 4                                \n"
>>         "       hypercall_addr:                         \n"
>>         "               movl $-38, %eax                 \n"
>>         "               ret                             \n"
>> );
>
> The assembly code "movl $-38, %eax; \nret" is only a "reserved place",
> which is later overwritten by hypercall address from the host, isnt
> it?
>
> If so, why dont we simply put 4 NOPs there?

So if the hypervisor fails to patch it, we get a proper errno instead of 
running off into random code.

Regards,

Anthony Liguori

> Thanks,
> Jun
>


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
