From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 0/5] x86: faster smp_mb()+documentation tweaks
Date: Thu, 28 Jan 2016 19:02:23 +0200
Message-ID: <1453921746-16178-1-git-send-email-mst__8548.962386749$1454000567$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

mb() typically uses mfence on modern x86, but a micro-benchmark shows that it's
2 to 3 times slower than lock; addl that we use on older CPUs.

So we really should use the locked variant everywhere, except that intel manual
says that clflush is only ordered by mfence, so we can't.
Note: some callers of clflush seems to assume sfence will
order it, so there could be existing bugs around this code.

Fortunately no callers of clflush (except one) order it using smp_mb(), so
after fixing that one caller, it seems safe to override smp_mb straight away.

Down the road, it might make sense to introduce clflush_mb() and switch
to that for clflush callers.

While I was at it, I found some inconsistencies in comments in
arch/x86/include/asm/barrier.h

The documentation fixes are included first - I verified that
they do not change the generated code at all. Borislav Petkov
said they will appear in tip eventually, included here for
completeness.

The last patch changes __smp_mb() to lock addl. I was unable to
measure a speed difference on a macro benchmark,
but I noted that even doing
	#define mb() barrier()
seems to make no difference for most benchmarks
(it causes hangs sometimes, of course).

Lightly tested on my laptop.

HPA asked that the last patch is deferred until we hear back from
intel, which makes sense of course. So it needs HPA's ack.

Changes from v4:
	Fix up the 64 bit version.

Changes from v3:
	Leave mb() alone for now since it's used to order
	clflush, which requires mfence. Optimize smp_mb instead.

Changes from v2:
	add patch adding cc clobber for addl
	tweak commit log for patch 2
	use addl at SP-4 (as opposed to SP) to reduce data dependencies

Michael S. Tsirkin (5):
  x86: add cc clobber for addl
  x86: drop a comment left over from X86_OOSTORE
  x86: tweak the comment about use of wmb for IO
  x86: use mb() around clflush
  x86: drop mfence in favor of lock+addl

 arch/x86/include/asm/barrier.h | 21 ++++++++++++---------
 arch/x86/kernel/process.c      |  4 ++--
 2 files changed, 14 insertions(+), 11 deletions(-)

-- 
MST
