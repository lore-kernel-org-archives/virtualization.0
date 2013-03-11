From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] vhost-blk: remove unused variable
Date: Mon, 11 Mar 2013 22:39:27 +0800
Message-ID: <CAPgLHd-eRBB2xCP7-ZswjfEKXPY29G1Nv71DzGo_-=TVym8MNQ__41917.9482655183$1363012803$gmane$org@mail.gmail.com>
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
To: mst@redhat.com
Cc: netdev@vger.kernel.org, yongjun_wei@trendmicro.com.cn, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The variable vq is initialized but never used
otherwise, so remove the unused variable.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/vhost/blk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vhost/blk.c b/drivers/vhost/blk.c
index 658c5f9..d9b245b 100644
--- a/drivers/vhost/blk.c
+++ b/drivers/vhost/blk.c
@@ -419,8 +419,6 @@ static void vhost_blk_handle_guest_kick(struct vhost_work *work)
 /* Host kick us for I/O completion */
 static void vhost_blk_handle_host_kick(struct vhost_work *work)
 {
-
-	struct vhost_virtqueue *vq;
 	struct vhost_blk_req *req;
 	struct llist_node *llnode;
 	struct vhost_blk *blk;
@@ -429,7 +427,6 @@ static void vhost_blk_handle_host_kick(struct vhost_work *work)
 	int ret;
 
 	blk = container_of(work, struct vhost_blk, work);
-	vq = &blk->vq;
 
 	llnode = llist_del_all(&blk->llhead);
 	added = false;
