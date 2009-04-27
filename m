From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4/8] virtio_console: add request_vqs/free_vqs calls
Date: Mon, 27 Apr 2009 15:32:37 +0300
Message-ID: <20090427123237.GA1179__18102.6022219614$1240856080$gmane$org@redhat.com>
References: <cover.1240832196.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1240832196.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Add request_vqs/free_vqs calls to virtio_console.
These will be required for MSI support.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index ff6f5a4..78c503f 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -199,13 +199,17 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
 		goto fail;
 	}
 
+	err = virtio_request_vqs(vdev, 2);
+	if (err)
+		goto free;
+
 	/* Find the input queue. */
 	/* FIXME: This is why we want to wean off hvc: we do nothing
 	 * when input comes in. */
 	in_vq = vdev->config->find_vq(vdev, 0, hvc_handle_input);
 	if (IS_ERR(in_vq)) {
 		err = PTR_ERR(in_vq);
-		goto free;
+		goto free_vqs;
 	}
 
 	out_vq = vdev->config->find_vq(vdev, 1, NULL);
@@ -244,6 +248,8 @@ free_out_vq:
 	vdev->config->del_vq(out_vq);
 free_in_vq:
 	vdev->config->del_vq(in_vq);
+free_vqs:
+	virtio_free_vqs(vdev);
 free:
 	kfree(inbuf);
 fail:
-- 
1.6.0.6
