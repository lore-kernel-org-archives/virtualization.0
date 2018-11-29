From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Thu, 29 Nov 2018 20:46:34 +0900
Message-ID: <CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA__14951.8792205074$1543492629$gmane$org@mail.gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
	<20181007091805.GA30687@zn.tnic>
	<20181007132228.GJ29268@gate.crashing.org>
	<alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
	<20181008073128.GL29268@gate.crashing.org>
	<alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
	<20181009145330.GT29268@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181009145330.GT29268@gate.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Segher Boessenkool <segher@kernel.crashing.org>, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>, virtualization@lists.linux-foundation.org, Max Filippov <jcmvbkbc@gmail.com>, Jan Beulich <JBeulich@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>, linux-sparse@vger.kernel.org, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Chris Zankel <chris@zankel.net>, matz@suse.de, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, gcc@gcc.gnu.org, rguenther@suse.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi.


On Wed, Oct 10, 2018 at 1:14 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Mon, Oct 08, 2018 at 11:07:46AM +0200, Richard Biener wrote:
> > On Mon, 8 Oct 2018, Segher Boessenkool wrote:
> > > On Sun, Oct 07, 2018 at 03:53:26PM +0000, Michael Matz wrote:
> > > > On Sun, 7 Oct 2018, Segher Boessenkool wrote:
> > > > > On Sun, Oct 07, 2018 at 11:18:06AM +0200, Borislav Petkov wrote:
> > > > > > Now, Richard suggested doing something like:
> > > > > >
> > > > > >  1) inline asm ("...")
> > > > >
> > > > > What would the semantics of this be?
> > > >
> > > > The size of the inline asm wouldn't be counted towards the inliner size
> > > > limits (or be counted as "1").
> > >
> > > That sounds like a good option.
> >
> > Yes, I also like it for simplicity.  It also avoids the requirement
> > of translating the number (in bytes?) given by the user to
> > "number of GIMPLE instructions" as needed by the inliner.
>
> This patch implements this, for C only so far.  And the syntax is
> "asm inline", which is more in line with other syntax.
>
> How does this look?


Thank you very much for your work.


https://gcc.gnu.org/ml/gcc-patches/2018-10/msg01932.html

How is the progress of this in GCC ML?



I am really hoping the issue will be solved by compiler
instead of the in-kernel workaround.


Since commit 77b0bf55bc675233d22cd5df97605d516d64525e,
DISTCC breakage was reported.


Then, another problem showed up.

Debian linux-headers package is broken
due to missing arch/x86/kernel/macros.s

https://www.spinics.net/lists/linux-kbuild/msg20037.html

The kernel-devel RPM package is broken as well.

More fundamentally, the external module building itself is broken;
'make clean' must keep all files needed for external modules, but
*.s files are all gone.


Of course, we can fix the problems at the cost of uglifying Makefiles.
I wrote a patch to fix the external module building
and packages, and now have it in hand locally.


But, I'd like to ask if x86 people want to keep this macros.s approach.
Revert 77b0bf55bc675 right now
assuming the compiler will eventually solve the issue?

Do you have ideas? Comments?


-- 
Best Regards
Masahiro Yamada
