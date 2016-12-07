From: Peng Tao <bergwolf@gmail.com>
Subject: [PATCH 2/2] vhost: remove unnecessary smp_mb from vhost_work_queue
Date: Wed,  7 Dec 2016 17:52:19 +0800
Message-ID: <1481104340-77035-2-git-send-email-bergwolf__36127.9251556427$1481136644$gmane$org@gmail.com>
References: <1481104340-77035-1-git-send-email-bergwolf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481104340-77035-1-git-send-email-bergwolf@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, Peng Tao <bergwolf@gmail.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

test_and_set_bit() already implies a memory barrier.

Signed-off-by: Peng Tao <bergwolf@gmail.com>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c6f2d89..2663543 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -261,8 +261,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
 		/* We can only add the work to the list after we're
 		 * sure it was not in the list.
+		 * test_and_set_bit() implies a memory barrier.
 		 */
-		smp_mb();
 		llist_add(&work->node, &dev->work_list);
 		wake_up_process(dev->worker);
 	}
-- 
2.7.4
