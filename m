From: Vladimir Murzin <murzin.v@gmail.com>
Subject: [PATCH] vhost: remove redundant vhost_virtqueue definition
Date: Mon, 25 Nov 2013 17:55:22 +0100
Message-ID: <1385398522-2216-1-git-send-email-murzin.v__32092.4481763088$1385400669$gmane$org@gmail.com>
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
Cc: Vladimir Murzin <murzin.v@gmail.com>, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Since 2839400 "vhost: move vhost-net zerocopy fields to net.c"
definition of vhost_virtqueue is redundant. Just clean it up.

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 drivers/vhost/vhost.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 4465ed5..0307365 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -54,8 +54,6 @@ struct vhost_log {
 	u64 len;
 };
 
-struct vhost_virtqueue;
-
 /* The virtqueue structure describes a queue attached to a device. */
 struct vhost_virtqueue {
 	struct vhost_dev *dev;
-- 
1.7.10.4
