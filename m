From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC] paravirt: cleanup lazy mode handling
Date: Mon, 01 Oct 2007 23:24:24 -0700
Message-ID: <4701E418.7010603@goop.org>
References: <470186C4.5080208@goop.org> <4701DBB9.9020202@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754020AbXJBGYf@vger.kernel.org>
In-Reply-To: <4701DBB9.9020202@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Anthony Liguori <anthony@codemonkey.ws>, Glauber de Oliveira Costa <glommer@gmail.com>, "Nakajima, Jun" <jun.nakajima@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> The code doesn't support having both lazy modes active at once.  Maybe
> that's not an issue, but aren't the two modes orthogonal?

Hm, well, that's a good question.  The initial semantics of the lazy
mode calls were "what VMI wants", and they're still not really nailed
down.  VMI doesn't support having both active at once, and its a little
unclear what it would mean anyway.  For now, we don't support multiple
lazy modes active at once, and the kernel never tries to do it (in fact,
it would be a bug, since lazy mmu must be preempt disabled, and lazy cpu
is only used for context switches).

>
>> --- a/arch/i386/xen/multicalls.h
>> +++ b/arch/i386/xen/multicalls.h
>> @@ -35,7 +35,7 @@ void xen_mc_flush(void);
>>  /* Issue a multicall if we're not in a lazy mode */
>>  static inline void xen_mc_issue(unsigned mode)
>>  {
>> -    if ((xen_get_lazy_mode() & mode) == 0)
>> +    if ((paravirt_get_lazy_mode() & mode) == 0)
>>          xen_mc_flush();
>
> This snippet looks like it wants to support concurrently active lazy
> modes.

Yeah, its a little more general than it needs to be.

    J
