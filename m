From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
	support
Date: Mon, 15 Oct 2018 10:39:56 -0300
Message-ID: <20181015133952.GA2932__15698.6105874696$1539614448$gmane$org@amt.cnet>
References: <499807AB-E779-40C3-AA3F-E8C77A7770EC@amacapital.net>
	<CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
	<20181006202731.GC7129@amt.cnet>
	<CALCETrWqze2mifOdFc0GJYHtHGKiKX2Zdi5Kz87OyUogbqD15w@mail.gmail.com>
	<20181008152650.GB27822@amt.cnet>
	<CALCETrVY6VHPLs0GXZM4+VYraTa1+xs=iRJoRa++OHX9Wq+ieg@mail.gmail.com>
	<20181008193632.GA31729@amt.cnet>
	<CALCETrW6b8=dU6vkXNS-rW1GPzJTbVxuVNsU4aoD_NwwobVQcg@mail.gmail.com>
	<20181011222744.GA17955@amt.cnet>
	<CALCETrXMEqHOa-8s51gGE_gxWVzTWY5eLiZrGLhMUkWKZkfmDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXMEqHOa-8s51gGE_gxWVzTWY5eLiZrGLhMUkWKZkfmDw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Wanpeng Li <kernellwp@gmail.com>, Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Radim Krcmar <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, devel@linuxdriverproject.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 11, 2018 at 04:00:29PM -0700, Andy Lutomirski wrote:
> On Thu, Oct 11, 2018 at 3:28 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >
> > On Tue, Oct 09, 2018 at 01:09:42PM -0700, Andy Lutomirski wrote:
> > > On Tue, Oct 9, 2018 at 8:28 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > > >
> > > > On Mon, Oct 08, 2018 at 10:38:22AM -0700, Andy Lutomirski wrote:
> > > > > On Mon, Oct 8, 2018 at 8:27 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > >
> > > > > I read the comment three more times and even dug through the git
> > > > > history.  It seems like what you're saying is that, under certain
> > > > > conditions (which arguably would be bugs in the core Linux timing
> > > > > code),
> > > >
> > > > I don't see that as a bug. Its just a side effect of reading two
> > > > different clocks (one is CLOCK_MONOTONIC and the other is TSC),
> > > > and using those two clocks to as a "base + offset".
> > > >
> > > > As the comment explains, if you do that, can't guarantee monotonicity.
> > > >
> > > > > actually calling ktime_get_boot_ns() could be non-monotonic
> > > > > with respect to the kvmclock timing.  But get_kvmclock_ns() isn't used
> > > > > for VM timing as such -- it's used for the IOCTL interfaces for
> > > > > updating the time offset.  So can you explain how my patch is
> > > > > incorrect?
> > > >
> > > > ktime_get_boot_ns() has frequency correction applied, while
> > > > reading masterclock + TSC offset does not.
> > > >
> > > > So the clock reads differ.
> > > >
> > >
> > > Ah, okay, I finally think I see what's going on.  In the kvmclock data
> > > exposed to the guest, tsc_shift and tsc_to_system_mul come from
> > > tgt_tsc_khz, whereas master_kernel_ns and master_cycle_now come from
> > > CLOCK_BOOTTIME.  So the kvmclock and kernel clock drift apart at a
> > > rate given by the frequency shift and then suddenly agree again every
> > > time the pvclock data is updated.
> >
> > Yes.
> >
> > > Is there a reason to do it this way?
> >
> > Since pvclock updates which update system_timestamp are expensive (must stop all vcpus),
> > they should be avoided.
> >
> 
> Fair enough.
> 
> > So only HW TSC counts
> 
> makes sense.
> 
> >, and used as offset against vcpu's tsc_timestamp.
> >
> 
> Why don't you just expose CLOCK_MONTONIC_RAW or CLOCK_MONOTONIC_RAW
> plus suspend time, though?  Then you would actually be tracking a real
> kernel timekeeping mode, and you wouldn't need all this complicated
> offsetting work to avoid accidentally going backwards.

Can you outline how that would work ? 
