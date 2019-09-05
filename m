From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 06/18] virtiofs: ->remove should not clean virtiofs fuse
	devices
Date: Thu,  5 Sep 2019 15:48:47 -0400
Message-ID: <20190905194859.16219-7-vgoyal__43779.3746170186$1567713005$gmane$org@redhat.com>
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

We maintain a fuse device per virt queue. This fuse devices are allocated
and installed during mount time and should be cleaned up when super block
is going away. Device removal should not clean it. Device removal should
stop queues and virtuques can go away.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5df97dfee37d..f68a25ca9e9d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -497,8 +497,6 @@ static void virtio_fs_remove(struct virtio_device *vdev)
 {
 	struct virtio_fs *fs = vdev->priv;
 
-	virtio_fs_free_devs(fs);
-
 	vdev->config->reset(vdev);
 	virtio_fs_cleanup_vqs(vdev, fs);
 
-- 
2.20.1
