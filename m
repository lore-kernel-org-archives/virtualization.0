From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 17/18] virtiofs: Remove TODO to quiesce/end_requests
Date: Thu,  5 Sep 2019 15:48:58 -0400
Message-ID: <20190905194859.16219-18-vgoyal__29248.9842789777$1567713109$gmane$org@redhat.com>
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

We now stop queues and drain all the pending requests from all virtqueues.
So this is not a TODO anymore.

Got rid of incrementing fc->dev_count as well. It did not seem meaningful
for virtio_fs.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index c483482185b6..eadaea6eb8e2 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -208,7 +208,6 @@ static void virtio_fs_free_devs(struct virtio_fs *fs)
 		if (!fsvq->fud)
 			continue;
 
-		/* TODO need to quiesce/end_requests/decrement dev_count */
 		fuse_dev_free(fsvq->fud);
 		fsvq->fud = NULL;
 	}
@@ -1022,7 +1021,6 @@ static int virtio_fs_fill_super(struct super_block *sb)
 		if (i == VQ_REQUEST)
 			continue; /* already initialized */
 		fuse_dev_install(fsvq->fud, fc);
-		atomic_inc(&fc->dev_count);
 	}
 
 	/* Previous unmount will stop all queues. Start these again */
-- 
2.20.1
