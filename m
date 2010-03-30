From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/4] virtio: console: Fix early_put_chars usage
Date: Tue, 30 Mar 2010 15:49:02 +1030
Message-ID: <201003301549.03101.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Francois Diakhate <fdiakh@gmail.com>

Currently early_put_chars is not used by virtio_console because it can
only be used once a port has been found, at which point it's too late
because it is no longer needed. This patch should fix it.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/char/virtio_console.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 18b1b06..f33ceaa 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -650,13 +650,13 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 {
 	struct port *port;
 
+	if (unlikely(early_put_chars))
+		return early_put_chars(vtermno, buf, count);
+
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
 		return 0;
 
-	if (unlikely(early_put_chars))
-		return early_put_chars(vtermno, buf, count);
-
 	return send_buf(port, (void *)buf, count);
 }
