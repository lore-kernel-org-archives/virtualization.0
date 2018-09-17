From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Date: Mon, 17 Sep 2018 12:25:38 -0700
Message-ID: <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
References: <20180914125006.349747096@linutronix.de>
	<20180914125118.909646643@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180914125118.909646643@linutronix.de>
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
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 14, 2018 at 5:50 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> The code flow for the vclocks is convoluted as it requires the vclocks
> which can be invalidated separately from the vsyscall_gtod_data sequence to
> store the fact in a separate variable. That's inefficient.
>

>  notrace static int do_hres(clockid_t clk, struct timespec *ts)
>  {
>         struct vgtod_ts *base = &gtod->basetime[clk];
>         unsigned int seq;
> -       int mode;
> -       u64 ns;
> +       u64 cycles, ns;
>
>         do {
>                 seq = gtod_read_begin(gtod);
> -               mode = gtod->vclock_mode;
>                 ts->tv_sec = base->sec;
>                 ns = base->nsec;
> -               ns += vgetsns(&mode);
> +               cycles = vgetcyc(gtod->vclock_mode);
> +               if (unlikely((s64)cycles < 0))
> +                       return vdso_fallback_gettime(clk, ts);

i was contemplating this, and I would suggest one of two optimizations:

1. have all the helpers return a struct containing a u64 and a bool,
and use that bool.  The compiler should do okay.

2. Be sneaky.  Later in the series, you do:

                if (unlikely((s64)cycles < 0))
                        return vdso_fallback_gettime(clk, ts);
-               ns += (cycles - gtod->cycle_last) * gtod->mult;
+               if (cycles > last)
+                       ns += (cycles - last) * gtod->mult;

How about:

if (unlikely((s64)cycles <= last)) {
  if (cycles < 0) [or cycles == -1 or whatever]
    return vdso_fallback_gettime;
} else {
  ns += (cycles - last) * gtod->mult;
}

which should actually make this whole mess be essentially free.

Also, I'm not entirely convinced that this "last" thing is needed at
all.  John, what's the scenario under which we need it?

--Andy

--Andy
