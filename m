From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Mon, 10 Dec 2018 17:16:28 +0900
Message-ID: <CAK7LNARSRZEctnTGiB8GOC-D5Q9_d5GpNm8JQ1EJ--WioDe_DA__30183.6791485131$1544429966$gmane$org@mail.gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
	<20181007091805.GA30687@zn.tnic>
	<20181007132228.GJ29268@gate.crashing.org>
	<alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
	<20181008073128.GL29268@gate.crashing.org>
	<alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
	<20181009145330.GT29268@gate.crashing.org>
	<CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA@mail.gmail.com>
	<20181129122500.GX23873@gate.crashing.org>
	<CF26ACBE-500C-47E8-B79D-E1ABE938031D@alien8.de>
	<20181130131633.GU23873@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181130131633.GU23873@gate.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>, virtualization@lists.linux-foundation.org, Max Filippov <jcmvbkbc@gmail.com>, Nadav Amit <namit@vmware.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Chris Zankel <chris@zankel.net>, matz@suse.de, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, gcc@gcc.gnu.org, rguenther@suse.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Philippe
List-Id: virtualization@lists.linuxfoundation.org

Hi Segher,


On Sun, Dec 2, 2018 at 3:48 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Fri, Nov 30, 2018 at 10:06:02AM +0100, Boris Petkov wrote:
> > On November 29, 2018 1:25:02 PM GMT+01:00, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > >This will only be fixed from GCC 9 on, if the compiler adopts it.  The
> > >kernel wants to support ancient GCC, so it will need to have a
> > >workaround
> > >for older GCC versions anyway.
> >
> > What about backporting it, like Richard says?
>
> Let me first get it into GCC trunk :-)
>
> It should backport fine, sure; and I'll work on that.
>



Now, I can see it in the GCC trunk.  Hooray!!!



commit 6de46ad5326fc5e6b730a2feb8c62d09c1561f92
Author: segher <segher@138bc75d-0d04-0410-961f-82ee72b054a4>
Date:   Thu Dec 6 17:56:58 2018 +0000

    asm inline

    The Linux kernel people want a feature that makes GCC pretend some
    inline assembler code is tiny (while it would think it is huge), so
    that such code will be inlined essentially always instead of
    essentially never.

    This patch lets you say "asm inline" instead of just "asm", with the
    result that that inline assembler is always counted as minimum cost
    for inlining.  It implements this for C and C++, making "inline"
    another asm-qualifier (supplementing "volatile" and "goto").




-- 
Best Regards
Masahiro Yamada
