From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 01/18] virtiofs: Remove request from processing list before
	calling end
Date: Thu,  5 Sep 2019 15:48:42 -0400
Message-ID: <20190905194859.16219-2-vgoyal@redhat.com>
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

In error path we are calling fuse_request_end() but we need to clear
FR_SENT bit as well as remove request from processing queue. Otherwise
fuse_request_end() triggers a warning as well as other issues show up.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 197e79e536f9..a708ccb65662 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -826,6 +826,10 @@ __releases(fiq->waitq.lock)
 		}
 		req->out.h.error = ret;
 		pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n", ret);
+		spin_lock(&fpq->lock);
+		clear_bit(FR_SENT, &req->flags);
+		list_del_init(&req->list);
+		spin_unlock(&fpq->lock);
 		fuse_request_end(fc, req);
 		return;
 	}
-- 
2.20.1
