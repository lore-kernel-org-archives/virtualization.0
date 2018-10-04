From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch 00/11] x86/vdso: Cleanups,
	simmplifications and CLOCK_TAI support
Date: Thu, 4 Oct 2018 13:32:51 -0700
Message-ID: <CALCETrUii1XGHhe7BN+LG0_jjyjOcHHnBgcOvh-wZXGxdMotPg@mail.gmail.com>
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
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andrew Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 14, 2018 at 5:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
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

tglx, please consider this whole series Acked-by: Andy Lutomirski
<luto@kernel.org>

Please feel free to push it top tip:x86/vdso, as long as you pull in
tip/x86/urgent first.  Once it lands, I'll email out a couple of
follow-up patches.

--Andy
