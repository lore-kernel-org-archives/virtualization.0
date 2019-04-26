From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 03/10] virtio/s390: enable packed ring
Date: Fri, 26 Apr 2019 20:32:38 +0200
Message-ID: <20190426183245.37939-4-pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190426183245.37939-1-pasic@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Nothing precludes to accepting  VIRTIO_F_RING_PACKED any more.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 42832a164546..6d989c360f38 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -773,10 +773,8 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 static void ccw_transport_features(struct virtio_device *vdev)
 {
 	/*
-	 * There shouldn't be anything that precludes supporting packed.
-	 * TODO: Remove the limitation after having another look into this.
+	 * Currently nothing to do here.
 	 */
-	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
 }
 
 static int virtio_ccw_finalize_features(struct virtio_device *vdev)
-- 
2.16.4
