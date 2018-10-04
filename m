From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
	support
Date: Thu, 4 Oct 2018 14:00:43 +0200
Message-ID: <1832e2af-3189-cb50-f4b6-45e74cdcf4b4__25788.7990250767$1538654370$gmane$org@redhat.com>
References: <20180914125006.349747096@linutronix.de>
	<CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
	<87sh1ne64t.fsf@vitty.brq.redhat.com> <20181003190617.GC21381@amt.cnet>
	<87k1mycfju.fsf@vitty.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87k1mycfju.fsf@vitty.brq.redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Radim Krcmar <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, devel@linuxdriverproject.org, Thomas Gleixner <tglx@linutronix.de>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On 04/10/2018 09:54, Vitaly Kuznetsov wrote:
> - Check if pure TSC can be used on SkyLake+ systems (where TSC scaling
> is supported).

Not if you want to migrate to pre-Skylake systems.

> - Check if non-masterclock mode is still needed. E.g. HyperV's TSC page
> clocksource is a single page for the whole VM, not a per-cpu thing. Can
> we think that all the buggy hardware is already gone?

No. :(  We still get reports whenever we break 2007-2008 hardware.

Paolo
