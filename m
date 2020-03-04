From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
Date: Wed, 4 Mar 2020 10:21:48 -0800
Message-ID: <202003041019.C6386B2F7@keescook>
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook>
 <20200303095514.GA2596@hirez.programming.kicks-ass.net>
 <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
 <6e7e4191612460ba96567c16b4171f2d2f91b296.camel@linux.intel.com>
 <202003031314.1AFFC0E@keescook>
 <20200304092136.GI2596@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200304092136.GI2596@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, Thomas Garnier <thgarnie@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Juergen Gross <jgross@suse.com>, Thomas Hellstrom <thellstrom@vmware.com>, "VMware, Inc." <pv-drivers@vmware.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Will
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 04, 2020 at 10:21:36AM +0100, Peter Zijlstra wrote:
> But at what cost; it does unspeakable ugly to the asm. And didn't a
> kernel compiled with the extended PIE range produce a measurably slower
> kernel due to all the ugly?

Was that true? I thought the final results were a wash and that earlier
benchmarks weren't accurate for some reason? I can't find the thread
now. Thomas, do you have numbers on that?

BTW, I totally agree that fgkaslr is the way to go in the future. I
am mostly arguing for this under the assumption that it doesn't
have meaningful performance impact and that it gains the kernel some
flexibility in the kinds of things it can do in the future. If the former
is not true, then I'd agree, the benefit needs to be more clear.

-- 
Kees Cook
