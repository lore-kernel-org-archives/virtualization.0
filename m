From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] virtiofs: remove unused variable 'fc'
Date: Wed, 23 Oct 2019 14:21:30 +0800
Message-ID: <20191023062130.23068-1-yuehaibing__36483.2079665334$1571811943$gmane$org@huawei.com>
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

fs/fuse/virtio_fs.c:983:20: warning:
 variable fc set but not used [-Wunused-but-set-variable]

It is not used since commit 7ee1e2e631db ("virtiofs:
No need to check fpq->connected state")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/fuse/virtio_fs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 2de8fc0..a5c8604 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -980,7 +980,6 @@ __releases(fiq->lock)
 {
 	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
 	struct virtio_fs *fs;
-	struct fuse_conn *fc;
 	struct fuse_req *req;
 	struct virtio_fs_vq *fsvq;
 	int ret;
@@ -993,7 +992,6 @@ __releases(fiq->lock)
 	spin_unlock(&fiq->lock);
 
 	fs = fiq->priv;
-	fc = fs->vqs[queue_id].fud->fc;
 
 	pr_debug("%s: opcode %u unique %#llx nodeid %#llx in.len %u out.len %u\n",
 		  __func__, req->in.h.opcode, req->in.h.unique,
-- 
2.7.4
