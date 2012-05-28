From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/5] virtio ids: fix comment for virtio-rng
Date: Mon, 28 May 2012 12:18:39 +0530
Message-ID: <951d8db620592250ae1f16b7064d77c772ef11e9.1338187342.git.amit.shah@redhat.com>
References: <cover.1338187342.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1338187342.git.amit.shah@redhat.com>
In-Reply-To: <cover.1338187342.git.amit.shah@redhat.com>
References: <cover.1338187342.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

It's virtio-rng, not virtio-ring.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 include/linux/virtio_ids.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/virtio_ids.h b/include/linux/virtio_ids.h
index 7529b85..270fb22 100644
--- a/include/linux/virtio_ids.h
+++ b/include/linux/virtio_ids.h
@@ -32,7 +32,7 @@
 #define VIRTIO_ID_NET		1 /* virtio net */
 #define VIRTIO_ID_BLOCK		2 /* virtio block */
 #define VIRTIO_ID_CONSOLE	3 /* virtio console */
-#define VIRTIO_ID_RNG		4 /* virtio ring */
+#define VIRTIO_ID_RNG		4 /* virtio rng */
 #define VIRTIO_ID_BALLOON	5 /* virtio balloon */
 #define VIRTIO_ID_RPMSG		7 /* virtio remote processor messaging */
 #define VIRTIO_ID_SCSI		8 /* virtio scsi */
-- 
1.7.7.6
