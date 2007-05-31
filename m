From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [kvm-devel] [PATCH 1/3] KVM paravirt_ops infrastructure
Date: Thu, 31 May 2007 12:28:11 -0500
Message-ID: <465F05AB.5040103@us.ibm.com>
References: <465D8F03.7000201@us.ibm.com>
	<200705311158.28632.ak@suse.de>	<20070531101116.GA10872@elte.hu>
	<200705311240.19794.ak@suse.de>
	<1180609951.11133.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180609951.11133.43.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.osdl.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Thu, 2007-05-31 at 12:40 +0200, Andi Kleen wrote:
>   
>> On Thursday 31 May 2007 12:11:16 Ingo Molnar wrote:
>>     
>>> * Andi Kleen <ak@suse.de> wrote:
>>>
>>>       
>>>>>> +       if (wrmsr_safe(MSR_KVM_API_MAGIC, __pa(para_state), 0)) {
>>>>>> +               printk(KERN_INFO "KVM guest: WRMSR probe failed.\n");
>>>>>> +               return -ENOENT;
>>>>>> +       }
>>>>>>             
>>>>> How about printk(KERN_INFO "I am not a KVM guest\n");?
>>>>>           
>>>> Actually paravirt probes that fail should be silent; similar like 
>>>> drivers that don't find their hardware should do the same. Otherwise 
>>>> if there are later distro kernels with various of those compiled in 
>>>> the boot log would become quite noisy
>>>>         
>>> yeah. I suspect printing that it's executing in native mode is OK.
>>>       
>> But only a single printk for that please
>>     
>
> Which already exists in paravirt.c:
>
> static void __init default_banner(void)
> {
> 	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
> 	       paravirt_ops.name);
> }
> ...
> static int __init print_banner(void)
> {
> 	paravirt_ops.banner();
> 	return 0;
> }
> core_initcall(print_banner);
>
> Hmm, this will predate your kvm initcall tho, and making that a
> pure_initcall is pretty gross...
>   

My current patch uses core_initcall() and presumably works by magic of 
linking order.

Any other suggestions over core_initcall()?

Regards,

Anthony Liguori

> Cheers,
> Rusty.
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> kvm-devel mailing list
> kvm-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kvm-devel
>
>   
