From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
Date: Tue, 3 Mar 2020 13:19:22 -0800
Message-ID: <202003031314.1AFFC0E@keescook>
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook>
 <20200303095514.GA2596@hirez.programming.kicks-ass.net>
 <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
 <6e7e4191612460ba96567c16b4171f2d2f91b296.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6e7e4191612460ba96567c16b4171f2d2f91b296.camel@linux.intel.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Thomas Garnier <thgarnie@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Juergen Gross <jgross@suse.com>, Thomas Hellstrom <thellstrom@vmware.com>, "VMware, Inc." <pv-drivers@vmware.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Will Deacon <will>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 03, 2020 at 01:01:26PM -0800, Kristen Carlson Accardi wrote:
> On Tue, 2020-03-03 at 07:43 -0800, Thomas Garnier wrote:
> > On Tue, Mar 3, 2020 at 1:55 AM Peter Zijlstra <peterz@infradead.org>
> > wrote:
> > > On Mon, Mar 02, 2020 at 09:02:15PM -0800, Kees Cook wrote:
> > > > On Thu, Feb 27, 2020 at 04:00:45PM -0800, Thomas Garnier wrote:
> > > > > Minor changes based on feedback and rebase from v10.
> > > > > 
> > > > > Splitting the previous serie in two. This part contains
> > > > > assembly code
> > > > > changes required for PIE but without any direct dependencies
> > > > > with the
> > > > > rest of the patchset.
> > > > > 
> > > > > Note: Using objtool to detect non-compliant PIE relocations is
> > > > > not yet
> > > > > possible as this patchset only includes the simplest PIE
> > > > > changes.
> > > > > Additional changes are needed in kvm, xen and percpu code.
> > > > > 
> > > > > Changes:
> > > > >  - patch v11 (assembly);
> > > > >    - Fix comments on x86/entry/64.
> > > > >    - Remove KASLR PIE explanation on all commits.
> > > > >    - Add note on objtool not being possible at this stage of
> > > > > the patchset.
> > > > 
> > > > This moves us closer to PIE in a clean first step. I think these
> > > > patches
> > > > look good to go, and unblock the work in kvm, xen, and percpu
> > > > code. Can
> > > > one of the x86 maintainers pick this series up?
> > > 
> > > But,... do we still need this in the light of that fine-grained
> > > kaslr
> > > stuff?
> > > 
> > > What is the actual value of this PIE crud in the face of that?
> > 
> > If I remember well, it makes it easier/better but I haven't seen a
> > recent update on that. Is that accurate Kees?
> 
> I believe this patchset is valuable if people are trying to brute force
> guess the kernel location, but not so awesome in the event of
> infoleaks. In the case of the current fgkaslr implementation, we only
> randomize within the existing text segment memory area - so with PIE
> the text segment base can move around more, but within that it wouldn't
> strengthen anything. So, if you have an infoleak, you learn the base
> instantly, and are just left with the same extra protection you get
> without PIE.

Right -- PIE improves both non- and fg- KASLR similarly, in the sense
that the possible entropy for base offset is expanded. It also opens the
door to doing even more crazy things. (e.g. why keep the kernel text all
in one contiguous chunk?)

And generally speaking, it seems a nice improvement to me, as it gives
the kernel greater addressing flexibility.

-- 
Kees Cook
