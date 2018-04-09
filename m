From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] vhost: fix vhost_vq_access_ok() log check
Date: Mon,  9 Apr 2018 21:10:21 +0800
Message-ID: <20180409131021.5132-1-stefanha__17731.5120622099$1523279312$gmane$org@redhat.com>
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
To: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, mst@redhat.com, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Commit d65026c6c62e7d9616c8ceb5a53b68bcdc050525 ("vhost: validate log
when IOTLB is enabled") introduced a regression.  The logic was
originally:

  if (vq->iotlb)
      return 1;
  return A && B;

After the patch the short-circuit logic for A was inverted:

  if (A || vq->iotlb)
      return A;
  return B;

The correct logic is:

  if (!A || vq->iotlb)
      return A;
  return B;

Reported-by: syzbot+65a84dde0214b0387ccd@syzkaller.appspotmail.com
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 5320039671b7..f6af4210679a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1246,7 +1246,7 @@ int vhost_vq_access_ok(struct vhost_virtqueue *vq)
 {
 	int ret = vq_log_access_ok(vq, vq->log_base);
 
-	if (ret || vq->iotlb)
+	if (!ret || vq->iotlb)
 		return ret;
 
 	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used);
-- 
2.14.3
