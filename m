From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5/5] Remove now unused structs from kvm_para.h
Date: Tue,  3 Jun 2008 15:07:19 +0200
Message-ID: <1212498439-1283-6-git-send-email-kraxel@redhat.com>
References: <1212498439-1283-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1212498439-1283-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-owner@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

The kvm_* structs are obsoleted by the pvclock_* ones.
Now all users have been switched over and the old structs
can be dropped.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/asm-x86/kvm_para.h |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/include/asm-x86/kvm_para.h b/include/asm-x86/kvm_para.h
index 5098459..bfd9900 100644
--- a/include/asm-x86/kvm_para.h
+++ b/include/asm-x86/kvm_para.h
@@ -48,24 +48,6 @@ struct kvm_mmu_op_release_pt {
 #ifdef __KERNEL__
 #include <asm/processor.h>
 
-/* xen binary-compatible interface. See xen headers for details */
-struct kvm_vcpu_time_info {
-	uint32_t version;
-	uint32_t pad0;
-	uint64_t tsc_timestamp;
-	uint64_t system_time;
-	uint32_t tsc_to_system_mul;
-	int8_t   tsc_shift;
-	int8_t	 pad[3];
-} __attribute__((__packed__)); /* 32 bytes */
-
-struct kvm_wall_clock {
-	uint32_t wc_version;
-	uint32_t wc_sec;
-	uint32_t wc_nsec;
-} __attribute__((__packed__));
-
-
 extern void kvmclock_init(void);
 
 
-- 
1.5.4.1
