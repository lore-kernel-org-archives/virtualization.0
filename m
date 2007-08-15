From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 3/25][V3] irq_flags / halt routines
Date: Wed, 15 Aug 2007 12:09:42 -0300
Message-ID: <46C31736.2050001__41875.5182800398$1187190632$gmane$org@redhat.com>
References: <11871821854176-git-send-email-gcosta@redhat.com>
	<1187182197314-git-send-email-gcosta@redhat.com>
	<11871822062386-git-send-email-gcosta@redhat.com>
	<11871822163867-git-send-email-gcosta@redhat.com>
	<20070815135554.GE3406@bingen.suse.de>
	<5d6222a80708150718v14f26343q7467385e7919fa76@mail.gmail.com>
	<20070815154243.GH3406@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070815154243.GH3406@bingen.suse.de>
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
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen escreveu:
> On Wed, Aug 15, 2007 at 11:18:25AM -0300, Glauber de Oliveira Costa wrote:
>>> Didn't we agree this should be a pvops client?
>>>
>>> -Andi
>>>
>> No. I exposed my reasoning, asked you back, but got no answer.
>> I'll do it again:
>>
>> This operations are just manipulating bits, and are doing no
>> privileged operations at all. Nothing that can be paravirtualized, in
> 
> It's talking to a Hypervisor. That is privileged enough.
> Please do that change. If you add so many more ifdefs it's your
> duty to keep the overall number low.

Again, this is the code of such function:

static inline int raw_irqs_disabled_flags(unsigned long flags)
{
         return !(flags & X86_EFLAGS_IF);
}
so all it is doing is getting a parameter (flags), and bitmasking it. It 
is not talking to any hypervisor. I can't see your point. Unless you are
arguing that it _should_ be talking to a hypervisor. Is that your point?

If it is the case, please tell me why. My current understanding is that 
we want to keep few changes from the normal kernel. So there is not too 
much reason for it.
