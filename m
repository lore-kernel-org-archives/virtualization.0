From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] lguest: barrier me harder
Date: Fri, 27 Mar 2009 10:33:39 +1030
Message-ID: <200903271033.40161.rusty__36291.159320581$1238112400$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest <lguest@ozlabs.org>
Cc: Christoph Hellwig <hch@infradead.org>, virtualization@lists.linux-foundation.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Impact: barrier correctness in example launcher

I doubt either lguest user will complain about performance.

Reported-by: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <jens.axboe@oracle.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/Documentation/lguest/lguest.c b/Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -1630,6 +1630,13 @@ static bool service_io(struct device *de
 		}
 	}
 
+	/* OK, so we noted that it was pretty poor to use an fdatasync as a
+	 * barrier.  But Christoph Hellwig points out that we need a sync
+	 * *afterwards* as well: "Barriers specify no reordering to the front
+	 * or the back."  And Jens Axboe confirmed it, so here we are: */
+	if (out->type & VIRTIO_BLK_T_BARRIER)
+		fdatasync(vblk->fd);
+
 	/* We can't trigger an IRQ, because we're not the Launcher.  It does
 	 * that when we tell it we're done. */
 	add_used(dev->vq, head, wlen);
