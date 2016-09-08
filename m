From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH] vhost: mark vhost_process_iotlb_msg() static
Date: Thu,  8 Sep 2016 16:56:45 +0800
Message-ID: <1473325005-9423-1-git-send-email-baoyou.xie__22131.7238211215$1473325064$gmane$org@linaro.org>
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
Cc: kvm@vger.kernel.org, arnd@arndb.de, netdev@vger.kernel.org, xie.baoyou@zte.com.cn, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, baoyou.xie@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

We get 1 warning when building kernel with W=1:
drivers/vhost/vhost.c:937:5: warning: no previous prototype for 'vhost_process_iotlb_msg' [-Wmissing-prototypes]

In fact, this function is only used in the file in which it is
declared and don't need a declaration, but can be made static.
so this patch marks this function with 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/vhost/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c6f2d89..bf045ac 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -934,8 +934,8 @@ static int umem_access_ok(u64 uaddr, u64 size, int access)
 	return 0;
 }
 
-int vhost_process_iotlb_msg(struct vhost_dev *dev,
-			    struct vhost_iotlb_msg *msg)
+static int vhost_process_iotlb_msg(struct vhost_dev *dev,
+				   struct vhost_iotlb_msg *msg)
 {
 	int ret = 0;
 
-- 
2.7.4
