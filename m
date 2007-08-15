From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/25][V3] pvops_64 last round (hopefully)
Date: Wed, 15 Aug 2007 09:49:20 -0300
Message-ID: <11871821854176-git-send-email-gcosta@redhat.com>
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
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This is hopefully the last iteration of the pvops64 patch.

From the last version, we have only one change, which is include/asm-x86_64/processor.h: There were still one survivor in raw asm.
Also, git screwed me up for some reason, and the 25th patch was missing the new files, paravirt.{c,h}. (although I do remember having git-add'ed it, but who knows...)

Andrew, could you please push it to -mm ?

Have fun!
