From: Borislav Petkov <bp@alien8.de>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Wed, 10 Oct 2018 10:19:06 +0200
Message-ID: <20181010081906.GA5533__9980.37137692354$1539159433$gmane$org@zn.tnic>
References: <20181003213100.189959-1-namit@vmware.com>
	<20181007091805.GA30687@zn.tnic>
	<20181007132228.GJ29268@gate.crashing.org>
	<alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
	<20181008073128.GL29268@gate.crashing.org>
	<alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
	<20181009145330.GT29268@gate.crashing.org>
	<alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
	<20181010072240.GB103159@gmail.com>
	<20181010080324.GV29268@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181010080324.GV29268@gate.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Segher Boessenkool <segher@kernel.crashing.org>, Ingo Molnar <mingo@kernel.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Nadav Amit <namit@vmware.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Chris Zankel <chris@zankel.net>, Michael Matz <matz@suse.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Philippe
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 10, 2018 at 03:03:25AM -0500, Segher Boessenkool wrote:
> The code immediately after this makes it size 1, even for things like
> asm(""), I suppose this works better for the inliner.  But that's a detail
> (and it might change); the description says "consider this asm as minimum
> length and cost for inlining decisions", which works for either 0 or 1.

Thanks for implementing this, much appreciated. If you need people to
test stuff, lemme know.

> You can think of it as meaning "we want this asm inlined always", and then
> whether that actually happens depends on if the function around it is
> inlined or not.

My only concern is how we would catch the other extremity where the
inline asm grows too big and we end up inlining it everywhere and thus
getting fat. The 0day bot already builds tinyconfigs but we should be
looking at vmlinux size growth too.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
