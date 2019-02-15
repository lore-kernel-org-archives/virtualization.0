From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] vhost: correctly check the return value of
	translate_desc() in log_used()
Date: Fri, 15 Feb 2019 15:53:24 +0800
Message-ID: <20190215075324.18891-1-jasowang__5654.6760069736$1550217220$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When fail, translate_desc() returns negative value, otherwise the
number of iovs. So we should fail when the return value is negative
instead of a blindly check against zero.

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Fixes: cc5e71075947 ("vhost: log dirty page correctly")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 24a129fcdd61..a2e5dc7716e2 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1788,7 +1788,7 @@ static int log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
 
 	ret = translate_desc(vq, (uintptr_t)vq->used + used_offset,
 			     len, iov, 64, VHOST_ACCESS_WO);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	for (i = 0; i < ret; i++) {
-- 
2.17.1
