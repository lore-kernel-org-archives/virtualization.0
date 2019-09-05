From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 09/18] virtiofs: Add an helper to start all the queues
Date: Thu,  5 Sep 2019 15:48:50 -0400
Message-ID: <20190905194859.16219-10-vgoyal__34108.9550567389$1567713130$gmane$org@redhat.com>
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

This just marks are the queues are connected and ready to accept the
request.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index d5730a50b303..f2936daca39c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -112,6 +112,19 @@ static void virtio_fs_drain_all_queues(struct virtio_fs *fs)
 	}
 }
 
+static void virtio_fs_start_all_queues(struct virtio_fs *fs)
+{
+	struct virtio_fs_vq *fsvq;
+	int i;
+
+	for (i = 0; i < fs->nvqs; i++) {
+		fsvq = &fs->vqs[i];
+		spin_lock(&fsvq->lock);
+		fsvq->connected = true;
+		spin_unlock(&fsvq->lock);
+	}
+}
+
 /* Add a new instance to the list or return -EEXIST if tag name exists*/
 static int virtio_fs_add_instance(struct virtio_fs *fs)
 {
@@ -483,10 +496,10 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	if (ret < 0)
 		goto out;
 
-	for (i = 0; i < fs->nvqs; i++) {
+	for (i = 0; i < fs->nvqs; i++)
 		fs->vqs[i].vq = vqs[i];
-		fs->vqs[i].connected = true;
-	}
+
+	virtio_fs_start_all_queues(fs);
 out:
 	kfree(names);
 	kfree(callbacks);
-- 
2.20.1
