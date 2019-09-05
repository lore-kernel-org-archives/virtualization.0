From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 05/18] Maintain count of in flight requests for VQ_REQUEST
	queue
Date: Thu,  5 Sep 2019 15:48:46 -0400
Message-ID: <20190905194859.16219-6-vgoyal__3594.40863119147$1567713144$gmane$org@redhat.com>
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

As of now we maintain this count only for VQ_HIPRIO. Maintain it for
VQ_REQUEST as well so that later it can be used to drain VQ_REQUEST
queue.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index c46dd4d284d6..5df97dfee37d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -360,6 +360,9 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 		spin_unlock(&fpq->lock);
 
 		fuse_request_end(fc, req);
+		spin_lock(&fsvq->lock);
+		fsvq->in_flight--;
+		spin_unlock(&fsvq->lock);
 	}
 }
 
@@ -769,6 +772,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 		goto out;
 	}
 
+	fsvq->in_flight++;
 	notify = virtqueue_kick_prepare(vq);
 
 	spin_unlock(&fsvq->lock);
-- 
2.20.1
