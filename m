From: Asias He <asias@redhat.com>
Subject: [PATCH 1/3] vhost: Remove vhost_enable_zcopy in vhost.h
Date: Fri,  3 May 2013 13:34:27 +0800
Message-ID: <1367559269-8325-2-git-send-email-asias__15263.4842823774$1367559300$gmane$org@redhat.com>
References: <1367559269-8325-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367559269-8325-1-git-send-email-asias@redhat.com>
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

It is net.c specific.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/vhost.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index b58f4ae..4330209 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -191,7 +191,4 @@ static inline int vhost_has_feature(struct vhost_dev *dev, int bit)
 	acked_features = rcu_dereference_index_check(dev->acked_features, 1);
 	return acked_features & (1 << bit);
 }
-
-void vhost_enable_zcopy(int vq);
-
 #endif
-- 
1.8.1.4
