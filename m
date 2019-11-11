From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] virtiofs: Fix old-style declaration
Date: Mon, 11 Nov 2019 20:23:59 +0800
Message-ID: <20191111122359.43624-1-yuehaibing__12278.0914463632$1573475115$gmane$org@huawei.com>
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
To: vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu, mszeredi@redhat.com
Cc: linux-fsdevel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

There expect the 'static' keyword to come first in a
declaration, and we get warnings like this with "make W=1":

fs/fuse/virtio_fs.c:687:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
fs/fuse/virtio_fs.c:692:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
fs/fuse/virtio_fs.c:1029:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/fuse/virtio_fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b77acea..2ac6818 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -684,12 +684,12 @@ static int virtio_fs_restore(struct virtio_device *vdev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-const static struct virtio_device_id id_table[] = {
+static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_FS, VIRTIO_DEV_ANY_ID },
 	{},
 };
 
-const static unsigned int feature_table[] = {};
+static const unsigned int feature_table[] = {};
 
 static struct virtio_driver virtio_fs_driver = {
 	.driver.name		= KBUILD_MODNAME,
@@ -1026,7 +1026,7 @@ __releases(fiq->lock)
 	}
 }
 
-const static struct fuse_iqueue_ops virtio_fs_fiq_ops = {
+static const struct fuse_iqueue_ops virtio_fs_fiq_ops = {
 	.wake_forget_and_unlock		= virtio_fs_wake_forget_and_unlock,
 	.wake_interrupt_and_unlock	= virtio_fs_wake_interrupt_and_unlock,
 	.wake_pending_and_unlock	= virtio_fs_wake_pending_and_unlock,
-- 
2.7.4
