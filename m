From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 25/25] virtio-rng: refactor probe error handling
Date: Sun, 12 Oct 2014 14:48:38 +0300
Message-ID: <1413114332-626-26-git-send-email-mst__10540.8941083171$1413114460$gmane$org@redhat.com>
References: <1413114332-626-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1413114332-626-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-scsi@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, netdev@vger.kernel.org, Matt Mackall <mpm@selenic.com>, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit.shah@redhat.com>, v9fs-developer@lists.sourceforge.net, "David S. Miller" <davem@davemloft.net>, Sasha Levin <sasha.levin@oracle.com>, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: virtualization@lists.linuxfoundation.org

Code like
	vi->vq = NULL;
	kfree(vi)
does not make sense.

Clean it up, use goto error labels for cleanup.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 132c9cc..72295ea 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -109,8 +109,8 @@ static int probe_common(struct virtio_device *vdev)
 
 	vi->index = index = ida_simple_get(&rng_index_ida, 0, 0, GFP_KERNEL);
 	if (index < 0) {
-		kfree(vi);
-		return index;
+		err = index;
+		goto err_ida;
 	}
 	sprintf(vi->name, "virtio_rng.%d", index);
 	init_completion(&vi->have_data);
@@ -128,13 +128,16 @@ static int probe_common(struct virtio_device *vdev)
 	vi->vq = virtio_find_single_vq(vdev, random_recv_done, "input");
 	if (IS_ERR(vi->vq)) {
 		err = PTR_ERR(vi->vq);
-		vi->vq = NULL;
-		kfree(vi);
-		ida_simple_remove(&rng_index_ida, index);
-		return err;
+		goto err_find;
 	}
 
 	return 0;
+
+err_find:
+	ida_simple_remove(&rng_index_ida, index);
+err_ida:
+	kfree(vi);
+	return err;
 }
 
 static void remove_common(struct virtio_device *vdev)
-- 
MST
