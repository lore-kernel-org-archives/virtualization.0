From: Asias He <asias@redhat.com>
Subject: [PATCH] vhost: Make local function static
Date: Wed,  5 Jun 2013 21:17:38 +0800
Message-ID: <1370438258-31401-1-git-send-email-asias@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

$ make C=1 M=drivers/vhost

drivers/vhost/net.c:168:5: warning: symbol 'vhost_net_set_ubuf_info' was not declared. Should it be static?
drivers/vhost/net.c:194:6: warning: symbol 'vhost_net_vq_reset' was not declared. Should it be static?
drivers/vhost/scsi.c:219:6: warning: symbol 'tcm_vhost_done_inflight' was not declared. Should it be static?

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/net.c  | 4 ++--
 drivers/vhost/scsi.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 05bdc3c..f800901 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -165,7 +165,7 @@ static void vhost_net_clear_ubuf_info(struct vhost_net *n)
 	}
 }
 
-int vhost_net_set_ubuf_info(struct vhost_net *n)
+static int vhost_net_set_ubuf_info(struct vhost_net *n)
 {
 	bool zcopy;
 	int i;
@@ -191,7 +191,7 @@ err:
 	return -ENOMEM;
 }
 
-void vhost_net_vq_reset(struct vhost_net *n)
+static void vhost_net_vq_reset(struct vhost_net *n)
 {
 	int i;
 
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index de6d817..35ab0ce 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -216,7 +216,7 @@ static int iov_num_pages(struct iovec *iov)
 	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
 }
 
-void tcm_vhost_done_inflight(struct kref *kref)
+static void tcm_vhost_done_inflight(struct kref *kref)
 {
 	struct vhost_scsi_inflight *inflight;
 
-- 
1.8.1.4
