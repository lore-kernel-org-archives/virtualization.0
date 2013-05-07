From: Asias He <asias@redhat.com>
Subject: [PATCH 2/4] vhost-test: Always access vq->private_data under vq mutex
Date: Tue,  7 May 2013 14:54:34 +0800
Message-ID: <1367909676-11788-3-git-send-email-asias@redhat.com>
References: <1367909676-11788-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367909676-11788-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/test.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index dc526eb..435b911 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -48,11 +48,12 @@ static void handle_vq(struct vhost_test *n)
 	size_t len, total_len = 0;
 	void *private;
 
-	private = rcu_dereference_check(vq->private_data, 1);
-	if (!private)
-		return;
 
 	mutex_lock(&vq->mutex);
+	private = vq->private_data;
+	if (!private)
+		goto out;
+
 	vhost_disable_notify(&n->dev, vq);
 
 	for (;;) {
@@ -89,7 +90,7 @@ static void handle_vq(struct vhost_test *n)
 			break;
 		}
 	}
-
+out:
 	mutex_unlock(&vq->mutex);
 }
 
-- 
1.8.1.4
