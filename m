From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] VSOCK: Use kvfree()
Date: Tue,  2 Aug 2016 13:50:42 +0000
Message-ID: <1470145842-17614-1-git-send-email-weiyj.lk@gmail.com>
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
To: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Use kvfree() instead of open-coding it.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/vhost/vsock.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 028ca16..0ddf3a2 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -434,10 +434,7 @@ err:
 
 static void vhost_vsock_free(struct vhost_vsock *vsock)
 {
-	if (is_vmalloc_addr(vsock))
-		vfree(vsock);
-	else
-		kfree(vsock);
+	kvfree(vsock);
 }
 
 static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
