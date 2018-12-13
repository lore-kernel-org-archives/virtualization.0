From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] kbuild, x86: revert macros in extended asm workarounds
Date: Thu, 13 Dec 2018 11:51:46 +0100
Message-ID: <20181213105146.GH5289__47529.2677096606$1544698220$gmane$org@hirez.programming.kicks-ass.net>
References: <1544692661-9455-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1544692661-9455-1-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Michal Marek <michal.lkml@markovi.net>, Richard Biener <rguenther@suse.de>, Arnd Bergmann <arnd@arndb.de>, Segher Boessenkool <segher@kernel.crashing.org>, linux-kbuild@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Sedat Dilek <sedat.dilek@gmail.com>, Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, Logan Gunthorpe <logang@deltatee.com>, Alok Kataria <akataria@vmware.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 13, 2018 at 06:17:41PM +0900, Masahiro Yamada wrote:
> Revert the following commits:
> 
> - 5bdcd510c2ac9efaf55c4cbd8d46421d8e2320cd
>   ("x86/jump-labels: Macrofy inline assembly code to work around GCC inlining bugs")
> 
> - d5a581d84ae6b8a4a740464b80d8d9cf1e7947b2
>   ("x86/cpufeature: Macrofy inline assembly code to work around GCC inlining bugs")
> 
> - 0474d5d9d2f7f3b11262f7bf87d0e7314ead9200.
>   ("x86/extable: Macrofy inline assembly code to work around GCC inlining bugs")
> 
> - 494b5168f2de009eb80f198f668da374295098dd.
>   ("x86/paravirt: Work around GCC inlining bugs when compiling paravirt ops")
> 
> - f81f8ad56fd1c7b99b2ed1c314527f7d9ac447c6.
>   ("x86/bug: Macrofy the BUG table section handling, to work around GCC inlining bugs")
> 
> - 77f48ec28e4ccff94d2e5f4260a83ac27a7f3099.
>   ("x86/alternatives: Macrofy lock prefixes to work around GCC inlining bugs")
> 
> - 9e1725b410594911cc5981b6c7b4cea4ec054ca8.
>   ("x86/refcount: Work around GCC inlining bug")
>   (Conflicts: arch/x86/include/asm/refcount.h)
> 
> - c06c4d8090513f2974dfdbed2ac98634357ac475.
>   ("x86/objtool: Use asm macros to work around GCC inlining bugs")
> 
> - 77b0bf55bc675233d22cd5df97605d516d64525e.
>   ("kbuild/Makefile: Prepare for using macros in inline assembly code to work around asm() related GCC inlining bugs")
> 

I don't think we want to blindly revert all that. Some of them actually
made sense and did clean up things irrespective of the asm-inline issue.

In particular I like the jump-label one. The cpufeature one OTOh, yeah,
I'd love to get that reverted.

And as a note; the normal commit quoting style is:

  d5a581d84ae6 ("x86/cpufeature: Macrofy inline assembly code to work around GCC inlining bugs")
