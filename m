From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 12/18] virtiofs: Use virtio_fs_free_devs() in error path
Date: Thu,  5 Sep 2019 15:48:53 -0400
Message-ID: <20190905194859.16219-13-vgoyal__3606.82158950425$1567713040$gmane$org@redhat.com>
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

We already have an helper to cleanup fuse devices. Use that instead of
duplicating the code.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index a76bd5a04521..40259368a6bd 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -999,8 +999,7 @@ static int virtio_fs_fill_super(struct super_block *sb)
 err_free_init_req:
 	fuse_request_free(init_req);
 err_free_fuse_devs:
-	for (i = 0; i < fs->nvqs; i++)
-		fuse_dev_free(fs->vqs[i].fud);
+	virtio_fs_free_devs(fs);
 err:
 	return err;
 }
-- 
2.20.1
