From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups,
	simmplifications and CLOCK_TAI support
Date: Thu, 04 Oct 2018 09:54:45 +0200
Message-ID: <87k1mycfju.fsf__2462.30692505396$1538639573$gmane$org@vitty.brq.redhat.com>
References: <20180914125006.349747096@linutronix.de>
	<CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
	<87sh1ne64t.fsf@vitty.brq.redhat.com>
	<20181003190617.GC21381@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181003190617.GC21381@amt.cnet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Radim Krcmar <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, devel@linuxdriverproject.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Marcelo Tosatti <mtosatti@redhat.com> writes:

> On Wed, Oct 03, 2018 at 11:22:58AM +0200, Vitaly Kuznetsov wrote:
>> 
>> There is a very long history of different (hardware) issues Marcelo was
>> fighting with and the current code is the survived Frankenstein.
>
> Right, the code has to handle different TSC modes.
>
>>  E.g. it
>> is very, very unclear what "catchup", "always catchup" and
>> masterclock-less mode in general are and if we still need them.
>
> Catchup means handling exposed (to guest) TSC frequency smaller than
> HW TSC frequency.
>
> That is "frankenstein" code, could be removed.
>
>> That said I'm all for simplification. I'm not sure if we still need to
>> care about buggy hardware though.
>
> What simplification is that again? 
>

I was hoping to hear this from you :-) If I am to suggest how we can
move forward I'd propose:
- Check if pure TSC can be used on SkyLake+ systems (where TSC scaling
is supported).
- Check if non-masterclock mode is still needed. E.g. HyperV's TSC page
clocksource is a single page for the whole VM, not a per-cpu thing. Can
we think that all the buggy hardware is already gone?

-- 
Vitaly
