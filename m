From: Ingo Molnar <mingo@kernel.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Mon, 8 Oct 2018 07:58:38 +0200
Message-ID: <20181008055838.GA66819__22923.9862449051$1538978204$gmane$org@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
	<20181007091805.GA30687@zn.tnic>
	<20181007132228.GJ29268@gate.crashing.org>
	<20181007141349.GD30687@zn.tnic>
	<20181007151427.GK29268@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181007151427.GK29268@gate.crashing.org>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Nadav Amit <namit@vmware.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Chris Zankel <chris@zankel.net>, Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger
List-Id: virtualization@lists.linuxfoundation.org


* Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > > More precise *size* estimates, yes.  And if the user lies he should not
> > > be surprised to get assembler errors, etc.
> > 
> > Yes.
> > 
> > Another option would be if gcc parses the inline asm directly and
> > does a more precise size estimation. Which is a lot more involved and
> > complicated solution so I guess we wanna look at the simpler ones first.
> > 
> > :-)
> 
> Which is *impossible* to do.  Inline assembler is free-form text.

"Impossible" is false: only under GCC's model and semantics of inline
asm that is, and only under the (false) assumption that the semantics
of the asm statement (which is a GCC extension to begin with) cannot
be changed like it has been changed multiple times in the past.

"Difficult", "not worth our while", perhaps.

Thanks,

	Ingo
