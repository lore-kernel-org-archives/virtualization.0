From: "Charles 'Mack' Rhinelander" <mrhinelander@gmail.com>
Subject: Fwd: BUG: Documentation/lguest/lguest.c bad paths for includes cause
	make to fail
Date: Sun, 31 May 2009 01:45:24 -0700
Message-ID: <1faf47660905310145g4bea38b0v123a9b468e950a81@mail.gmail.com>
References: <1faf47660905310128t45f1ea32ge5e1cba82ddca972@mail.gmail.com>
	<1faf47660905310139y7203bba7w39f4a5330b148f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1faf47660905310139y7203bba7w39f4a5330b148f0@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Pardon my unorganized cc:'s.

---------- Forwarded message ----------
From: Charles 'Mack' Rhinelander <mrhinelander@gmail.com>
Date: Sun, May 31, 2009 at 1:39 AM
Subject: Fwd: BUG: Documentation/lguest/lguest.c bad paths for
includes cause make to fail
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, lguest@ozlabs.org

---------- Forwarded message ----------
From: Charles 'Mack' Rhinelander <mrhinelander@gmail.com>
Date: Sun, May 31, 2009 at 1:28 AM
Subject: BUG: Documentation/lguest/lguest.c bad paths for includes
cause make to fail
To: mm-commits@vger.kernel.org, kraai@ftbfs.org,
rusty@rustcorp.com.au, Andi Kleen <ak@suse.de>, Thomas Gleixner
<tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>


2.6.28-rc2-mm1 make fails at Documentation/lguest/lguest.c =A0Two
includes have bad paths: line 34 #include <zlib.h> (maybe should be
linux/zlib.h?), and line 47 #include "asm-x86/bootparam.h"

Are incorrect paths related to this recent gitignore of lguest.c (see
first cut below)?

asm-x86 has no bootparam.h; is this related to 2007 mm-commit list
concerning "allow asm-x86 to be included from userspace?" (see second
cut below)

---BEGIN CUT ABOUT gitignore OF lguest.c---

Gitweb: =A0 =A0 http://git.kernel.org/linus/9536c26b31ae34ba6371a1b8f406028=
e9756f913
Commit: =A0 =A0 9536c26b31ae34ba6371a1b8f406028e9756f913
Parent: =A0 =A0 84a139a985300901dfad99bd93c7345d180af860
Author: =A0 =A0 Matt Kraai <kraai@ftbfs.org>
AuthorDate: Thu Apr 16 23:46:20 2009 -0700
Committer: =A0Rusty Russell <rusty@rustcorp.com.au>
CommitDate: Sun Apr 19 23:14:02 2009 +0930

=A0 =A0lguest: tell git to ignore Documentation/lguest/lguest

=A0 =A0This is the example lguest launcher binary.

=A0 =A0Signed-off-by: Matt Kraai <kraai@ftbfs.org>
=A0 =A0Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
=A0Documentation/lguest/.gitignore | =A0 =A01 +
=A01 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/lguest/.gitignore b/Documentation/lguest/.gitign=
ore
---END CUT---

---BEGIN CUT ABOUT allow x86 bootparam include from userspace---
List: =A0 =A0 =A0 linux-mm-commits
Subject: =A0 =A0- make-asm-x86-bootparamh-includable-from-userspace.patch
removed from -mm tree
From: =A0 =A0 =A0 akpm () linux-foundation ! org
Date: =A0 =A0 =A0 2007-10-18 6:05:37

The patch titled
=A0 =A0 Make asm-x86/bootparam.h includable from userspace
has been removed from the -mm tree. =A0Its filename was
=A0 =A0 make-asm-x86-bootparamh-includable-from-userspace.patch

This patch was dropped because because of rejects

------------------------------------------------------
Subject: Make asm-x86/bootparam.h includable from userspace
From: Rusty Russell <rusty@rustcorp.com.au>

To actually write a bootloader (or, say, the lguest launcher) currently
requires duplication of these structures. =A0Making them includeable from
userspace is much nicer.

We merge the common userspace-required definitions of e820_32/64.h into e82=
0.h
for export.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org
---END CUT---
