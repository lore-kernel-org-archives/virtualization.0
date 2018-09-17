From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
	support
Date: Mon, 17 Sep 2018 15:00:39 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809171451380.16580__38770.0525847778$1537189147$gmane$org@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de>
	<CAK8P3a1QfynDxkKBLXVa5Qj_z+7ct3QB5sDYuY5QV3ht-a0cTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAK8P3a1QfynDxkKBLXVa5Qj_z+7ct3QB5sDYuY5QV3ht-a0cTg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, matt@softrans.com.au
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 14 Sep 2018, Arnd Bergmann wrote:
> On Fri, Sep 14, 2018 at 2:52 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> A couple of architectures (s390, ia64, riscv, powerpc, arm64)
> implement the vdso as assembler code at the moment, so they
> won't be as easy to consolidate (other than outright replacing all
> the code).
> 
> The other five:
> arch/x86/entry/vdso/vclock_gettime.c
> arch/sparc/vdso/vclock_gettime.c
> arch/nds32/kernel/vdso/gettimeofday.c
> arch/mips/vdso/gettimeofday.c
> arch/arm/vdso/vgettimeofday.c
>
> are basically all minor variations of the same code base and could be
> consolidated to some degree.
> Any suggestions here? Should we plan to do that consolitdation based on
> your new version, or just add clock_gettime64 in arm32 and x86-32, and then
> be done with it? The other ones will obviously still be fast for 32-bit time_t
> and will have a working non-vdso sys_clock_getttime64().

In principle consolidating all those implementations should be possible to
some extent and probably worthwhile. What's arch specific are the actual
accessors to the hardware clocks.

> I also wonder about clock_getres(): half the architectures seem to implement
> it in vdso, but notably arm32 and x86 don't, and I had not expected it to be
> performance critical given that the result is easily cached in user space.

getres() is not really performance critical, but adding it does not create
a huge problem either.

Thanks,

	tglx
