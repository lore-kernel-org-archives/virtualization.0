From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 40/41] s390: use generic memory barriers
Date: Sun, 10 Jan 2016 16:22:05 +0200
Message-ID: <1452426622-4471-41-git-send-email-mst__30899.3580438711$1452435870$gmane$org@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel
List-Id: virtualization@lists.linuxfoundation.org

The s390 kernel is SMP to 99.99%, we just didn't bother with a
non-smp variant for the memory-barriers. If the generic header
is used we'd get the non-smp version for free. It will save a
small amount of text space for CONFIG_SMP=n.

Suggested-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/s390/include/asm/barrier.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index fbd25b2..4d26fa4 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -29,9 +29,6 @@
 #define __smp_mb()			mb()
 #define __smp_rmb()			rmb()
 #define __smp_wmb()			wmb()
-#define smp_mb()			__smp_mb()
-#define smp_rmb()			__smp_rmb()
-#define smp_wmb()			__smp_wmb()
 
 #define __smp_store_release(p, v)					\
 do {									\
-- 
MST
