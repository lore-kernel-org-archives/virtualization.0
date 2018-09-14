From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
	support
Date: Fri, 14 Sep 2018 15:09:27 +0200
Message-ID: <20180914130927.GK24124__34332.1856031709$1536930507$gmane$org@hirez.programming.kicks-ass.net>
References: <20180914125006.349747096@linutronix.de>
	<2f723b28-8f81-4b02-861c-42f756a8825a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <2f723b28-8f81-4b02-861c-42f756a8825a@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Florian Weimer <fweimer@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Thomas Gleixner <tglx@linutronix.de>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 14, 2018 at 02:56:46PM +0200, Florian Weimer wrote:
> On 09/14/2018 02:50 PM, Thomas Gleixner wrote:
> > Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
> > implementation, which extended the clockid switch case and added yet
> > another slightly different copy of the same code.
> > 
> > Especially the extended switch case is problematic as the compiler tends to
> > generate a jump table which then requires to use retpolines.
> 
> Does vDSO code really have to use retpolines?  It's in userspace, after all.

Userspace is equally susceptible to spectre-v2. Ideally we'd recompile
world with retpoline, but given the amount of inline asm in say things
like openssl and similar projects, validating that there are indeed no
indirect calls/jumps left is nontrivial.

There are currently pending patches to otherwise address user-user
spectre-v2 attacks.
