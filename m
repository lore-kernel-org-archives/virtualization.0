From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 11/16] virtio_rng: use simplified virtqueue accessors.
Date: Tue, 19 Feb 2013 18:26:29 +1030
Message-ID: <1361260594-601-12-git-send-email-rusty__3589.02756493098$1361261162$gmane$org@rustcorp.com.au>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We never add buffers with input and output parts, so use the new accessors.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/char/hw_random/virtio-rng.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 10fd71c..842e2d5 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -47,7 +47,7 @@ static void register_buffer(u8 *buf, size_t size)
 	sg_init_one(&sg, buf, size);
 
 	/* There should always be room for one buffer. */
-	if (virtqueue_add_buf(vq, &sg, 0, 1, buf, GFP_KERNEL) < 0)
+	if (virtqueue_add_inbuf(vq, &sg, 1, buf, GFP_KERNEL) < 0)
 		BUG();
 
 	virtqueue_kick(vq);
-- 
1.7.10.4
