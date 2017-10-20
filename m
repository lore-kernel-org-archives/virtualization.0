From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v1 06/27] x86/entry/64: Adapt assembly for PIE support
Date: Fri, 20 Oct 2017 18:27:24 +0200
Message-ID: <1F0B8A18-092F-42AF-91B4-7A5D414ED83D__24188.0221329213$1508516902$gmane$org@amacapital.net>
References: <20171011203027.11248-1-thgarnie@google.com>
	<20171011203027.11248-7-thgarnie@google.com>
	<20171020082646.bkxrps35sb3gq2nr@gmail.com>
	<CAJcbSZFScsqOORMGXFQdsqcN5xbfHWpzSHGdxQB=45zgSDryLw@mail.gmail.com>
	<20171020152028.syq6woeet6it3z3h@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171020152028.syq6woeet6it3z3h@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Michal Hocko <mhocko@suse.com>, =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, linux-doc@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>, "=?utf-8?Q? Jan_H_._Sch=C3=B6nherr ?=" <jschoenh@amazon.de>, Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Waiman Long <longman@redhat.com>, Pavel Machek <pavel@ucw.cz>, "H . Peter Anvin" <hpa@zytor.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Christoph Lameter <cl@linux.com>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Daniel Borkmann <daniel@iogearbox.>
List-Id: virtualization@lists.linuxfoundation.org



> On Oct 20, 2017, at 5:20 PM, Ingo Molnar <mingo@kernel.org> wrote:
> 
> 
> * Thomas Garnier <thgarnie@google.com> wrote:
> 
>>>>       */
>>>> -     cmpq    $.Lentry_SYSCALL_64_after_fastpath_call, (%rsp)
>>>> +     leaq    .Lentry_SYSCALL_64_after_fastpath_call(%rip), %r11
>>>> +     cmpq    %r11, (%rsp)
>>>>      jne     1f
> 
>>> This patch seems to add extra overhead to the syscall fast-path even when PIE is
>>> disabled, right?
>> 
>> It does add extra instructions when one is not possible, I preferred
>> that over ifdefing but I can change it.
> 
> So my problem is, this pattern repeats in many other places as well, but sprinking 
> various pieces of assembly code with #ifdefs would be very bad as well.
> 
> I have no good idea how to solve this.
> 

How about:

.macro JMP_TO_LABEL ...


> Thanks,
> 
>    Ingo
