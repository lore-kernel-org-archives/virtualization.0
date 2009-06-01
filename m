From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: Fwd: BUG: Documentation/lguest/lguest.c bad paths for includes
	cause 	make to fail
Date: Mon, 01 Jun 2009 14:58:57 -0700
Message-ID: <4A244F21.3070808@oracle.com>
References: <1faf47660905310128t45f1ea32ge5e1cba82ddca972@mail.gmail.com>	<1faf47660905310139y7203bba7w39f4a5330b148f0@mail.gmail.com>
	<1faf47660905310145g4bea38b0v123a9b468e950a81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1faf47660905310145g4bea38b0v123a9b468e950a81@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Charles 'Mack' Rhinelander <mrhinelander@gmail.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Charles 'Mack' Rhinelander wrote:
> Pardon my unorganized cc:'s.
> 
> ---------- Forwarded message ----------
> From: Charles 'Mack' Rhinelander <mrhinelander@gmail.com>
> Date: Sun, May 31, 2009 at 1:39 AM
> Subject: Fwd: BUG: Documentation/lguest/lguest.c bad paths for
> includes cause make to fail
> To: linux-kernel@vger.kernel.org
> Cc: Andrew Morton <akpm@osdl.org>, lguest@ozlabs.org
> 
> ---------- Forwarded message ----------
> From: Charles 'Mack' Rhinelander <mrhinelander@gmail.com>
> Date: Sun, May 31, 2009 at 1:28 AM
> Subject: BUG: Documentation/lguest/lguest.c bad paths for includes
> cause make to fail
> To: mm-commits@vger.kernel.org, kraai@ftbfs.org,
> rusty@rustcorp.com.au, Andi Kleen <ak@suse.de>, Thomas Gleixner
> <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
> 
> 
> 2.6.28-rc2-mm1 make fails at Documentation/lguest/lguest.c  Two
> includes have bad paths: line 34 #include <zlib.h> (maybe should be
> linux/zlib.h?), and line 47 #include "asm-x86/bootparam.h"
> 
> Are incorrect paths related to this recent gitignore of lguest.c (see
> first cut below)?
> 
> asm-x86 has no bootparam.h; is this related to 2007 mm-commit list
> concerning "allow asm-x86 to be included from userspace?" (see second
> cut below)
> 
> ---BEGIN CUT ABOUT gitignore OF lguest.c---
> 
> Gitweb:     http://git.kernel.org/linus/9536c26b31ae34ba6371a1b8f406028e9756f913
> Commit:     9536c26b31ae34ba6371a1b8f406028e9756f913
> Parent:     84a139a985300901dfad99bd93c7345d180af860
> Author:     Matt Kraai <kraai@ftbfs.org>
> AuthorDate: Thu Apr 16 23:46:20 2009 -0700
> Committer:  Rusty Russell <rusty@rustcorp.com.au>
> CommitDate: Sun Apr 19 23:14:02 2009 +0930
> 
>    lguest: tell git to ignore Documentation/lguest/lguest
> 
>    This is the example lguest launcher binary.
> 
>    Signed-off-by: Matt Kraai <kraai@ftbfs.org>
>    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  Documentation/lguest/.gitignore |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/lguest/.gitignore b/Documentation/lguest/.gitignore
> ---END CUT---
> 
> ---BEGIN CUT ABOUT allow x86 bootparam include from userspace---
> List:       linux-mm-commits
> Subject:    - make-asm-x86-bootparamh-includable-from-userspace.patch
> removed from -mm tree
> From:       akpm () linux-foundation ! org
> Date:       2007-10-18 6:05:37
> 
> The patch titled
>     Make asm-x86/bootparam.h includable from userspace
> has been removed from the -mm tree.  Its filename was
>     make-asm-x86-bootparamh-includable-from-userspace.patch
> 
> This patch was dropped because because of rejects
> 
> ------------------------------------------------------
> Subject: Make asm-x86/bootparam.h includable from userspace
> From: Rusty Russell <rusty@rustcorp.com.au>
> 
> To actually write a bootloader (or, say, the lguest launcher) currently
> requires duplication of these structures.  Making them includeable from
> userspace is much nicer.
> 
> We merge the common userspace-required definitions of e820_32/64.h into e820.h
> for export.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Andi Kleen <ak@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org
> ---END CUT---


Hi,

2.6.28-rc2-mm1 isn't terribly relevant any more.
Is there a problem in some other tree/patchset?
and how do I reproduce the problem?  I can't seem to do that.

Thanks,
-- 
~Randy
LPC 2009, Sept. 23-25, Portland, Oregon
http://linuxplumbersconf.org/2009/
