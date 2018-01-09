From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Subject: [PATCH v2] vhost: Remove the unused variable.
Date: Tue,  9 Jan 2018 07:38:22 -0800
Message-ID: <1515512302-20894-1-git-send-email-xiangxia.m.yue@gmail.com>
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
To: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

The patch (7235acdb1) changed the way of the work
flushing in which the queued seq, done seq, and the
flushing are not used anymore. Then remove them now.

Fixes: 7235acdb1 ("vhost: simplify work flushing")
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 1 -
 drivers/vhost/vhost.h | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 33ac2b186b85..9b04cad91d65 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -181,7 +181,6 @@ void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn)
 {
 	clear_bit(VHOST_WORK_QUEUED, &work->flags);
 	work->fn = fn;
-	init_waitqueue_head(&work->done);
 }
 EXPORT_SYMBOL_GPL(vhost_work_init);
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 79c6e7a60a5e..749fe13e061c 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -20,10 +20,6 @@ typedef void (*vhost_work_fn_t)(struct vhost_work *work);
 struct vhost_work {
 	struct llist_node	  node;
 	vhost_work_fn_t		  fn;
-	wait_queue_head_t	  done;
-	int			  flushing;
-	unsigned		  queue_seq;
-	unsigned		  done_seq;
 	unsigned long		  flags;
 };
 
-- 
2.13.6
