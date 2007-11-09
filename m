From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/24] paravirt_ops for unified x86 - that's me again!
Date: Fri,  9 Nov 2007 16:42:41 -0200
Message-ID: <11946337851964-git-send-email-gcosta__47277.6611023166$1194643855$gmane$org@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Hey folks,

Here's a new spin of the pvops64 patch series.
We didn't get that many comments from the last time,
so it should be probably almost ready to get in. Heya!

From the last version, the most notable changes are:
* consolidation of system.h, merging jeremy's comments about ordering
  concerns
* consolidation of smp functions that goes through smp_ops. They're sharing
  a bunch of code now.

Other than that, just some issues that arose from the rebase.

Please, not that this patch series _does not_ apply over linus git anymore,
but rather, over tglx cleanup series.

The first patch in this series is already on linus', but not on tglx', so
I'm sending it again, because you'll need it if you want to compile it
anyway.

tglx, in the absense of any outstanding NACKs, or any very big call for
improvements, could you please pull it in your tree?

Have fun,
