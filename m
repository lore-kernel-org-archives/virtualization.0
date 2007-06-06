From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] [patch 21/33] xen: Xen SMP guest support
Date: Wed, 06 Jun 2007 01:33:18 -0700
Message-ID: <4666714E.3090506@goop.org>
References: <20070522140941.802382212@goop.org>	<20070522141252.611887616@goop.org> <46667FA3.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756724AbXFFIdi@vger.kernel.org>
In-Reply-To: <46667FA3.76E4.0078.0@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Jan Beulich wrote:
>> --- a/arch/i386/xen/time.c
>> +++ b/arch/i386/xen/time.c
>> @@ -105,17 +105,15 @@ static void get_runstate_snapshot(struct
>> 	preempt_enable();
>> }
>>
>> -static void setup_runstate_info(void)
>> +static void setup_runstate_info(int cpu)
>> {
>> 	struct vcpu_register_runstate_memory_area area;
>>
>> -	area.addr.v = &__get_cpu_var(runstate);
>> +	area.addr.v = &per_cpu(runstate, cpu);
>>
>> 	if (HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area,
>> 			       smp_processor_id(), &area))
>>     
>
> Shouldn't this be 'cpu' rather than 'smp_processor_id()'?
>   

Yes.  I'd noticed that, thought it got fixed later in the series, and
looks like I ultimately got confused.  Not sure when this crept in; it
has been correct in the past.

    J
