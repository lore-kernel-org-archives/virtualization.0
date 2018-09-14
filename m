From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 00/11] x86/vdso: Cleanups,
	simmplifications and CLOCK_TAI support
Date: Fri, 14 Sep 2018 16:22:44 +0200
Message-ID: <CAK8P3a1QfynDxkKBLXVa5Qj_z+7ct3QB5sDYuY5QV3ht-a0cTg__44352.0775567324$1536934862$gmane$org@mail.gmail.com>
References: <20180914125006.349747096@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180914125006.349747096@linutronix.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, matt@softrans.com.au
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 14, 2018 at 2:52 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
> implementation, which extended the clockid switch case and added yet
> another slightly different copy of the same code.
>
> Especially the extended switch case is problematic as the compiler tends to
> generate a jump table which then requires to use retpolines. If jump tables
> are disabled it adds yet another conditional to the existing maze.
>
> This series takes a different approach by consolidating the almost
> identical functions into one implementation for high resolution clocks and
> one for the coarse grained clock ids by storing the base data for each
> clock id in an array which is indexed by the clock id.
>
> This completely eliminates the switch case and allows further
> simplifications of the code base, which at the end all together gain a few
> cycles performance or at least stay on par with todays code. The resulting
> performance depends heavily on the micro architecture and the compiler.

No objections from my side, just a few general remarks: Deepa
and I have discussed the vdso in the past for 2038. I have started
a patch that I'll have to redo on top of yours, but that is fine, your
cleanup is only going to help here.

More generally speaking, Deepa said that she would like to see
some generalization on the vdso before adding the time64_t
based variants. Your series probably makes x86 diverge more
from the others, which makes it harder to consolidate them again,
but we might just as well use your new implementation to base the
generic one on, and just move the other ones over to that.

A couple of architectures (s390, ia64, riscv, powerpc, arm64)
implement the vdso as assembler code at the moment, so they
won't be as easy to consolidate (other than outright replacing all
the code).

The other five:
arch/x86/entry/vdso/vclock_gettime.c
arch/sparc/vdso/vclock_gettime.c
arch/nds32/kernel/vdso/gettimeofday.c
arch/mips/vdso/gettimeofday.c
arch/arm/vdso/vgettimeofday.c

are basically all minor variations of the same code base and could be
consolidated to some degree.
Any suggestions here? Should we plan to do that consolitdation based on
your new version, or just add clock_gettime64 in arm32 and x86-32, and then
be done with it? The other ones will obviously still be fast for 32-bit time_t
and will have a working non-vdso sys_clock_getttime64().

I also wonder about clock_getres(): half the architectures seem to implement
it in vdso, but notably arm32 and x86 don't, and I had not expected it to be
performance critical given that the result is easily cached in user space.

         Arnd
