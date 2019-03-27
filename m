From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 18/68] vfs: Convert virtio_balloon to use the new mount API
Date: Wed, 27 Mar 2019 23:42:48 +0000
Message-ID: <155373016868.7602.3458742145423631498.stgit__32597.4803928815$1553730190$gmane$org@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: viro@zeniv.linux.org.uk
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Convert the virtio_balloon filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "Michael S. Tsirkin" <mst@redhat.com>
cc: Jason Wang <jasowang@redhat.com>
cc: virtualization@lists.linux-foundation.org
---

 drivers/virtio/virtio_balloon.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f19061b585a4..89d67c8aa719 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -757,21 +757,22 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 
 	return MIGRATEPAGE_SUCCESS;
 }
+#include <linux/fs_context.h>
 
-static struct dentry *balloon_mount(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *data)
-{
-	static const struct dentry_operations ops = {
-		.d_dname = simple_dname,
-	};
+static const struct dentry_operations balloon_dops = {
+	.d_dname = simple_dname,
+};
 
-	return mount_pseudo(fs_type, "balloon-kvm:", NULL, &ops,
-				BALLOON_KVM_MAGIC);
+static int balloon_init_fs_context(struct fs_context *fc)
+{
+	return vfs_init_pseudo_fs_context(fc, "balloon-kvm:",
+					  NULL, NULL,
+					  &balloon_dops, BALLOON_KVM_MAGIC);
 }
 
 static struct file_system_type balloon_fs = {
 	.name           = "balloon-kvm",
-	.mount          = balloon_mount,
+	.init_fs_context = balloon_init_fs_context,
 	.kill_sb        = kill_anon_super,
 };
