From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
	support
Date: Fri, 14 Sep 2018 15:19:24 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809141514180.10480__41445.4454243698$1536931058$gmane$org@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de>
	<2f723b28-8f81-4b02-861c-42f756a8825a@redhat.com>
	<alpine.DEB.2.21.1809141459530.10480@nanos.tec.linutronix.de>
	<63a0f67d-fdb1-e2fc-5d4d-4f3cfbf86fd1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <63a0f67d-fdb1-e2fc-5d4d-4f3cfbf86fd1@redhat.com>
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
Cc: Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 14 Sep 2018, Florian Weimer wrote:

> On 09/14/2018 03:05 PM, Thomas Gleixner wrote:
> > On Fri, 14 Sep 2018, Florian Weimer wrote:
> > 
> > > On 09/14/2018 02:50 PM, Thomas Gleixner wrote:
> > > > Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
> > > > implementation, which extended the clockid switch case and added yet
> > > > another slightly different copy of the same code.
> > > > 
> > > > Especially the extended switch case is problematic as the compiler tends
> > > > to
> > > > generate a jump table which then requires to use retpolines.
> > > 
> > > Does vDSO code really have to use retpolines?  It's in userspace, after
> > > all.
> > 
> > Unless you have IBRS/STIPB enabled, you need user space ratpoutine as well.
> 
> I don't think this is a consensus position, and it obviously depends on the
> (sub)architecture.

It does, but we are not building kernels for specific micro architectures
nor do distros AFAIK.

But that aside, even with jump tables the generated code (ratpoutine
disabled) is not any better than with the current approach. It's even worse
and needs the same optimizations at the end and then the main difference is
that you have 3 copies of one function and 2 of the other. Not a win at
all.

Thanks,

	tglx
