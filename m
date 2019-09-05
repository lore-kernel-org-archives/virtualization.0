From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 18/18] virtiofs: Remove TODO item from virtio_fs_free_devs()
Date: Thu,  5 Sep 2019 15:48:59 -0400
Message-ID: <20190905194859.16219-19-vgoyal__15426.7425577686$1567713147$gmane$org@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, dgilbert@redhat.com, virtio-fs@redhat.com, stefanha@redhat.com, vgoyal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

virtio_fs_free_devs() is now called from ->kill_sb(). By this time
all device queues have been quiesced. I am assuming that while
->kill_sb() is in progress, another mount instance will wait for
it to finish (sb->s_umount mutex provides mutual exclusion).

W.r.t ->remove path, we should be fine as we are not touching vdev
or virtqueues. And we have reference on virtio_fs object, so we know
rest of the data structures are valid.

So I can't see the need of any additional locking yet.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index eadaea6eb8e2..61aa3eba7b22 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -200,8 +200,6 @@ static void virtio_fs_free_devs(struct virtio_fs *fs)
 {
 	unsigned int i;
 
-	/* TODO lock */
-
 	for (i = 0; i < fs->nvqs; i++) {
 		struct virtio_fs_vq *fsvq = &fs->vqs[i];
 
-- 
2.20.1
