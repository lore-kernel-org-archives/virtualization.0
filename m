From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 3/25][V3] irq_flags / halt routines
Date: Wed, 15 Aug 2007 12:17:15 -0300
Message-ID: <46C318FB.7050806__13246.4710776278$1187191060$gmane$org@redhat.com>
References: <11871821854176-git-send-email-gcosta@redhat.com>
	<1187182197314-git-send-email-gcosta@redhat.com>
	<11871822062386-git-send-email-gcosta@redhat.com>
	<11871822163867-git-send-email-gcosta@redhat.com>
	<20070815135554.GE3406@bingen.suse.de>
	<5d6222a80708150718v14f26343q7467385e7919fa76@mail.gmail.com>
	<20070815154243.GH3406@bingen.suse.de>
	<46C31736.2050001@redhat.com> <46C31813.4050404@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C31813.4050404@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity escreveu:
> Glauber de Oliveira Costa wrote:
>> Andi Kleen escreveu:
>>> On Wed, Aug 15, 2007 at 11:18:25AM -0300, Glauber de Oliveira Costa 
>>> wrote:
>>>>> Didn't we agree this should be a pvops client?
>>>>>
>>>>> -Andi
>>>>>
>>>> No. I exposed my reasoning, asked you back, but got no answer.
>>>> I'll do it again:
>>>>
>>>> This operations are just manipulating bits, and are doing no
>>>> privileged operations at all. Nothing that can be paravirtualized, in
>>>
>>> It's talking to a Hypervisor. That is privileged enough.
>>> Please do that change. If you add so many more ifdefs it's your
>>> duty to keep the overall number low.
>>
>> Again, this is the code of such function:
>>
>> static inline int raw_irqs_disabled_flags(unsigned long flags)
>> {
>>         return !(flags & X86_EFLAGS_IF);
>> }
>> so all it is doing is getting a parameter (flags), and bitmasking it. 
>> It is not talking to any hypervisor. I can't see your point. Unless 
>> you are
>> arguing that it _should_ be talking to a hypervisor. Is that your point?
> 
> It is talking to a hypervisor.  This hypervisor does full 
> virtualization, except that it allows the guest to hide eflags.IF inside 
> eflags.AC as an optimization (otherwise you need to do binary 
> translation to overcome popf silently disregarding IF on the stack).
> 
> You can regard eflags.AC as the paravirtualized eflags.IF (Xen for 
> example has a per-vcpu memory flag for the same).
> 

Thanks Avi, I understand it now.
Andi, I will update it and resend shortly.
