From: Andy Lutomirski <luto@mit.edu>
Subject: [PATCH v2 1/6] x86-64: Pad vDSO to a page boundary
Date: Wed,  3 Aug 2011 09:31:49 -0400
Message-ID: <a63380a3c58a0506a2f5a18ba1b12dbde1f25e58.1312378163.git.luto__47944.0769217492$1312378816$gmane$org@mit.edu>
References: <cover.1312378163.git.luto@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1312378163.git.luto@mit.edu>
In-Reply-To: <cover.1312378163.git.luto@mit.edu>
References: <cover.1312378163.git.luto@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xensource.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, keir.xen@gmail.com, Andy Lutomirski <luto@mit.edu>
List-Id: virtualization@lists.linuxfoundation.org

This avoids an information leak to userspace.

Signed-off-by: Andy Lutomirski <luto@mit.edu>
---
 arch/x86/vdso/vdso.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/vdso/vdso.S b/arch/x86/vdso/vdso.S
index 1b979c1..01f5e3b 100644
--- a/arch/x86/vdso/vdso.S
+++ b/arch/x86/vdso/vdso.S
@@ -9,6 +9,7 @@ __PAGE_ALIGNED_DATA
 vdso_start:
 	.incbin "arch/x86/vdso/vdso.so"
 vdso_end:
+	.align PAGE_SIZE /* extra data here leaks to userspace. */
 
 .previous
 
-- 
1.7.6
