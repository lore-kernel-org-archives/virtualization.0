From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH net-next 09/12] tools/virtio: switch to __ptr_ring_empty
Date: Fri, 26 Jan 2018 01:36:39 +0200
Message-ID: <1516923320-16959-12-git-send-email-mst__21079.3282989927$1516923322$gmane$org@redhat.com>
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

We don't rely on lockless guarantees, but it
seems cleaner than inverting __ptr_ring_peek.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/ringtest/ptr_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/ringtest/ptr_ring.c b/tools/virtio/ringtest/ptr_ring.c
index e6e8130..477899c 100644
--- a/tools/virtio/ringtest/ptr_ring.c
+++ b/tools/virtio/ringtest/ptr_ring.c
@@ -187,7 +187,7 @@ bool enable_kick()
 
 bool avail_empty()
 {
-	return !__ptr_ring_peek(&array);
+	return __ptr_ring_empty(&array);
 }
 
 bool use_buf(unsigned *lenp, void **bufp)
-- 
MST
