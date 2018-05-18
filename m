From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 0/6] Macrofying inline assembly for better compilation
Date: Fri, 18 May 2018 09:20:40 +0000
Message-ID: <8737d8d4c7e84c47938e9b1aaeae16b9__37670.9169628613$1526635402$gmane$org@AcuMS.aculab.com>
References: <20180517161402.78089-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180517161402.78089-1-namit@vmware.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: 'Nadav Amit' <namit@vmware.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>, Josh Poimboeuf <jpoimboe@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, "nadav.amit@gmail.com" <nadav.amit@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Nadav Amit
> Sent: 17 May 2018 17:14
> This patch-set deals with an interesting yet stupid problem: kernel code
> that does not get inlined despite its simplicity. There are several
> causes for this behavior: "cold" attribute on __init, different function
> optimization levels; conditional constant computations based on
> __builtin_constant_p(); and finally large inline assembly blocks.
> 
> This patch-set deals with the inline assembly problem. I separated these
> patches from the others (that were sent in the RFC) for easier
> inclusion.
> 
> The problem with inline assembly is that inline assembly is often used
> by the kernel for things that are other than code - for example,
> assembly directives and data. GCC however is oblivious to the content of
> the blocks and assumes their cost in space and time is proportional to
> the number of the perceived assembly "instruction", according to the
> number of newlines and semicolons. Alternatives, paravirt and other
> mechanisms are affected, causing code not to be inlined, and degrading
> compilation quality in general.
> 
> The solution that this patch-set carries for this problem is to create
> an assembly macro, and then call it from the inline assembly block.  As
> a result, the compiler sees a single "instruction" and assigns the more
> appropriate cost to the code. In addition, this patch-set removes
> unneeded new-lines from common x86 inline asm's, which "confuse" GCC
> heuristics.

Can't you get the same effect by using always_inline ?

	David
