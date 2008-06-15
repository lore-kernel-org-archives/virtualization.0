From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] virtio: Complete feature negotation before updating status
Date: Sun, 15 Jun 2008 23:20:50 +1000
Message-ID: <200806152320.51100.rusty@rustcorp.com.au>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark McLoughlin <markmc@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Mark McLoughlin <markmc@redhat.com>

lguest (in rusty's use-tun-ringfd patch) assumes that the
guest has updated its feature bits before setting its status
to VIRTIO_CONFIG_S_DRIVER_OK.

That's pretty reasonable, so let's make it so.

Signed-off-by: Mark McLoughlin <markmc@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index ab0aca7..fc85cba 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -117,9 +117,9 @@ static int virtio_dev_probe(struct device *_d)
 	if (err)
 		add_status(dev, VIRTIO_CONFIG_S_FAILED);
 	else {
-		add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
 		/* They should never have set feature bits beyond 32 */
 		dev->config->set_features(dev, dev->features[0]);
+		add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
 	}
 	return err;
 }
