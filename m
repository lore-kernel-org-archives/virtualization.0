From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 07/11] virtio_console: Rename a jump label in
	port_fops_splice_write()
Date: Wed, 14 Sep 2016 16:06:05 +0200
Message-ID: <cb8e64ec-5917-ce0d-cc95-845f8ce0fa34@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
	<020438b9-a7f8-0050-04c1-43382ba60b75@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <020438b9-a7f8-0050-04c1-43382ba60b75@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Sep 2016 15:01:51 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/char/virtio_console.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 99dc659..d8681d9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -947,17 +947,17 @@ static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
 	pipe_lock(pipe);
 	if (!pipe->nrbufs) {
 		ret = 0;
-		goto error_out;
+		goto unlock;
 	}
 
 	ret = wait_port_writable(port, filp->f_flags & O_NONBLOCK);
 	if (ret < 0)
-		goto error_out;
+		goto unlock;
 
 	buf = alloc_buf(port->out_vq, 0, pipe->nrbufs);
 	if (!buf) {
 		ret = -ENOMEM;
-		goto error_out;
+		goto unlock;
 	}
 
 	sgl.n = 0;
@@ -973,8 +973,7 @@ static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
 	if (unlikely(ret <= 0))
 		free_buf(buf, true);
 	return ret;
-
-error_out:
+ unlock:
 	pipe_unlock(pipe);
 	return ret;
 }
-- 
2.10.0
