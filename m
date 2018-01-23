From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net 1/2] vhost: use mutex_lock_nested() in vhost_dev_lock_vqs()
Date: Tue, 23 Jan 2018 17:27:25 +0800
Message-ID: <1516699646-7321-1-git-send-email-jasowang@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We used to call mutex_lock() in vhost_dev_lock_vqs() which tries to
hold mutexes of all virtqueues. This may confuse lockdep to report a
possible deadlock because of trying to hold locks belong to same
class. Switch to use mutex_lock_nested() to avoid false positive.

Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
Reported-by: syzbot+dbb7c1161485e61b0241@syzkaller.appspotmail.com
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 33ac2b1..549771a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -904,7 +904,7 @@ static void vhost_dev_lock_vqs(struct vhost_dev *d)
 {
 	int i = 0;
 	for (i = 0; i < d->nvqs; ++i)
-		mutex_lock(&d->vqs[i]->mutex);
+		mutex_lock_nested(&d->vqs[i]->mutex, i);
 }
 
 static void vhost_dev_unlock_vqs(struct vhost_dev *d)
-- 
2.7.4
