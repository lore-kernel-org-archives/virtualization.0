From: "tip-bot for Michael S. Tsirkin" <tipbot@zytor.com>
Subject: [tip:locking/core] locking/x86:
	Tweak the comment about use of wmb() for IO
Date: Fri, 29 Jan 2016 03:32:52 -0800
Message-ID: <tip-57d9b1b43433a6ba7267c80b87d8e8f6e86edceb@git.kernel.org>
References: <1453921746-16178-4-git-send-email-mst@redhat.com>
Reply-To: dvlasenk@redhat.com, bp@suse.de, luto@amacapital.net, luto@kernel.org,
	virtualization@lists.linux-foundation.org, mingo@kernel.org,
	akpm@linux-foundation.org, mst@redhat.com,
	torvalds@linux-foundation.org, brgerst@gmail.com,
	dave@stgolabs.net, paulmck@linux.vnet.ibm.com,
	peterz@infradead.org, bp@alien8.de, dbueso@suse.de,
	linux-kernel@vger.kernel.org, andreyknvl@google.com,
	hpa@zytor.com, tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1453921746-16178-4-git-send-email-mst@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-tip-commits@vger.kernel.org
Cc: dave@stgolabs.net, dvlasenk@redhat.com, akpm@linux-foundation.org, brgerst@gmail.com, dbueso@suse.de, peterz@infradead.org, andreyknvl@google.com, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, luto@amacapital.net, bp@alien8.de, bp@suse.de, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Commit-ID:  57d9b1b43433a6ba7267c80b87d8e8f6e86edceb
Gitweb:     http://git.kernel.org/tip/57d9b1b43433a6ba7267c80b87d8e8f6e86edceb
Author:     Michael S. Tsirkin <mst@redhat.com>
AuthorDate: Thu, 28 Jan 2016 19:02:44 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 29 Jan 2016 09:40:10 +0100

locking/x86: Tweak the comment about use of wmb() for IO

On x86, we *do* still use the non-NOP rmb()/wmb() for IO barriers,
but even that is generally questionable.

Leave them around as historial unless somebody can point to a
case where they care about the performance, but tweak the
comment so people don't think they are strictly required in all
cases.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: virtualization <virtualization@lists.linux-foundation.org>
Link: http://lkml.kernel.org/r/1453921746-16178-4-git-send-email-mst@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index a291745..bfb28ca 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -6,7 +6,7 @@
 
 /*
  * Force strict CPU ordering.
- * And yes, this is required on UP too when we're talking
+ * And yes, this might be required on UP too when we're talking
  * to devices.
  */
