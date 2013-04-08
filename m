From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86: make IDT read-only
Date: Mon, 8 Apr 2013 16:00:04 -0700
Message-ID: <CAGXu5jJCZh6JeFBOH5nn0uqWOic9BCBnJ5CEhAEkvesZ7BguqA@mail.gmail.com>
References: <20130408224328.GA17641@www.outflux.net>
	<alpine.LFD.2.03.1304082350540.25182@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.03.1304082350540.25182@linux-mips.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Alex Shi <alex.shi@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Will Drewry <wad@chromium.org>, Julien Tinnes <jln@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Frederic Weisbecker <fweisbec@gmail.com>, Dan Rosenberg <drosenberg@vsecurity.com>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <borislav.petkov@amd.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 8, 2013 at 3:56 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Mon, 8 Apr 2013, Kees Cook wrote:
>
>> This makes the IDT unconditionally read-only. This primarily removes
>> the IDT from being a target for arbitrary memory write attacks. It has
>> an added benefit of also not leaking (via the "sidt" instruction) the
>> kernel base offset, if it has been relocated.
> [...]
>> --- a/arch/x86/kernel/cpu/intel.c
>> +++ b/arch/x86/kernel/cpu/intel.c
>> @@ -215,7 +201,6 @@ static void __cpuinit intel_workarounds(struct cpuinfo_x86 *c)
>>
>>               c->f00f_bug = 1;
>>               if (!f00f_workaround_enabled) {
>> -                     trap_init_f00f_bug();
>>                       printk(KERN_NOTICE "Intel Pentium with F0 0F bug - workaround enabled.\n");
>>                       f00f_workaround_enabled = 1;
>>               }
>
>  FWIW the change looks reasonable to me, however given that that it makes
> the arrangement unconditional and there is no longer a workaround to
> enable I think it would make sense to remove the conditional block quoted
> above altogether, along with the f00f_workaround_enabled variable itself
> (alternatively "Intel Pentium with F0 0F bug" alone could be printed
> instead and the name of the variable adjusted to make sense with the new
> meaning -- up to you to decide).

Ah, yes, I misread this and didn't see that the ifdef ended 2 lines
further down. :) I'll just remove the entire section of code.

-Kees

--
Kees Cook
Chrome OS Security
