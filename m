From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH net-next 12/12] tools/virtio: fix smp_mb on x86
Date: Fri, 26 Jan 2018 01:36:44 +0200
Message-ID: <1516923320-16959-16-git-send-email-mst__46667.4545001753$1516923340$gmane$org@redhat.com>
References: <1516923320-16959-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1516923320-16959-1-git-send-email-mst@redhat.com>
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
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Offset 128 overlaps the last word of the redzone.
Use 132 which is always beyond that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/ringtest/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index 593a328..301d59b 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -111,7 +111,7 @@ static inline void busy_wait(void)
 } 
 
 #if defined(__x86_64__) || defined(__i386__)
-#define smp_mb()     asm volatile("lock; addl $0,-128(%%rsp)" ::: "memory", "cc")
+#define smp_mb()     asm volatile("lock; addl $0,-132(%%rsp)" ::: "memory", "cc")
 #else
 /*
  * Not using __ATOMIC_SEQ_CST since gcc docs say they are only synchronized
-- 
MST
