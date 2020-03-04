From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
Date: Wed, 4 Mar 2020 10:21:36 +0100
Message-ID: <20200304092136.GI2596@hirez.programming.kicks-ass.net>
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook>
 <20200303095514.GA2596@hirez.programming.kicks-ass.net>
 <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
 <6e7e4191612460ba96567c16b4171f2d2f91b296.camel@linux.intel.com>
 <202003031314.1AFFC0E@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <202003031314.1AFFC0E@keescook>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, "VMware,
 Inc." <pv-drivers@vmware.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, virtualization@lists.linux-foundation.org, Thomas Garnier <thgarnie@chromium.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Herbert Xu <herbert@gondor.apana.org.au>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Cao jin <caoj.fnst@cn.fujitsu.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Josh
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 03, 2020 at 01:19:22PM -0800, Kees Cook wrote:
> On Tue, Mar 03, 2020 at 01:01:26PM -0800, Kristen Carlson Accardi wrote:
> > On Tue, 2020-03-03 at 07:43 -0800, Thomas Garnier wrote:
> > > On Tue, Mar 3, 2020 at 1:55 AM Peter Zijlstra <peterz@infradead.org>

> > > > But,... do we still need this in the light of that fine-grained
> > > > kaslr
> > > > stuff?
> > > > 
> > > > What is the actual value of this PIE crud in the face of that?
> > > 
> > > If I remember well, it makes it easier/better but I haven't seen a
> > > recent update on that. Is that accurate Kees?
> > 
> > I believe this patchset is valuable if people are trying to brute force
> > guess the kernel location, but not so awesome in the event of
> > infoleaks. In the case of the current fgkaslr implementation, we only
> > randomize within the existing text segment memory area - so with PIE
> > the text segment base can move around more, but within that it wouldn't
> > strengthen anything. So, if you have an infoleak, you learn the base
> > instantly, and are just left with the same extra protection you get
> > without PIE.
> 
> Right -- PIE improves both non- and fg- KASLR similarly, in the sense
> that the possible entropy for base offset is expanded. It also opens the
> door to doing even more crazy things. 

So I'm really confused. I see it increases the aslr range, but I'm still
not sure why we care in the face of fgkaslr. Current kaslr is completely
broken because the hardware leaks more bits than we currently have, even
without the kernel itself leaking an address.

But leaking a single address is not a problem with fgkaslr.

> (e.g. why keep the kernel text all
> in one contiguous chunk?)

Dear gawd, please no. Also, we're limited to 2G text, that's just not a
lot of room. I'm really going to object when people propose we introduce
direct PLT for x86.

> And generally speaking, it seems a nice improvement to me, as it gives
> the kernel greater addressing flexibility.

But at what cost; it does unspeakable ugly to the asm. And didn't a
kernel compiled with the extended PIE range produce a measurably slower
kernel due to all the ugly?

So maybe I'm slow, but please spell out the benefit, because I'm not
seeing it.
