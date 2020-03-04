From: Thomas Garnier <thgarnie@chromium.org>
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
Date: Wed, 4 Mar 2020 11:19:44 -0800
Message-ID: <CAJcbSZHBB1u2Vq0jZKsmd0UcRj=aichxTtbGvbWgf8-g8WPa7w@mail.gmail.com>
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook> <20200303095514.GA2596@hirez.programming.kicks-ass.net>
 <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
 <6e7e4191612460ba96567c16b4171f2d2f91b296.camel@linux.intel.com>
 <202003031314.1AFFC0E@keescook> <20200304092136.GI2596@hirez.programming.kicks-ass.net>
 <202003041019.C6386B2F7@keescook> <e60876d0-4f7d-9523-bcec-6d002f717623@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e60876d0-4f7d-9523-bcec-6d002f717623@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, the arch/x86 maintainers <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Juergen Gross <jgross@suse.com>, Thomas Hellstrom <thellstrom@vmware.com>, "VMware, Inc." <pv-drivers@vmware.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Wil
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 4, 2020 at 10:45 AM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 2020-03-04 10:21, Kees Cook wrote:
> > On Wed, Mar 04, 2020 at 10:21:36AM +0100, Peter Zijlstra wrote:
> >> But at what cost; it does unspeakable ugly to the asm. And didn't a
> >> kernel compiled with the extended PIE range produce a measurably slower
> >> kernel due to all the ugly?
> >
> > Was that true? I thought the final results were a wash and that earlier
> > benchmarks weren't accurate for some reason? I can't find the thread
> > now. Thomas, do you have numbers on that?

I have never seen a significant performance impact. Performance and
size is better on more recent versions of gcc as it has better
generation of PIE code (for example generation of switches).

> >
> > BTW, I totally agree that fgkaslr is the way to go in the future. I
> > am mostly arguing for this under the assumption that it doesn't
> > have meaningful performance impact and that it gains the kernel some
> > flexibility in the kinds of things it can do in the future. If the former
> > is not true, then I'd agree, the benefit needs to be more clear.
> >
>
> "Making the assembly really ugly" by itself is a reason not to do it, in my
> Not So Humble Opinion[TM]; but the reason the kernel and small memory models
> exist in the first place is because there is a nonzero performance impact of
> the small-PIC memory model. Having modules in separate regions would further
> add the cost of a GOT references all over the place (PLT is optional, useless
> and deprecated for eager binding) *plus* might introduce at least one new
> vector of attack: overwrite a random GOT slot, and just wait until it gets hit
> by whatever code path it happens to be in; the exact code path doesn't matter.
> From an kASLR perspective this is *very* bad, since you only need to guess the
> general region of a GOT rather than an exact address.

I agree that it would add GOT references and I can explore that more
in terms of performance impact and size. This patchset makes the GOT
readonly too so I don't think the attack vector applies.

>
> The huge memory model, required for arbitrary placement, has a very
> significant performance impact.

I assume you mean mcmodel=large, it doesn't use it. It uses -fPIE and
removes -mcmodel=kernel. It favors relative references whenever
possible.

>
> The assembly code is *very* different across memory models.
>
>         -hpa
