From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 23/25] virtio_balloon: enable VQs early on restore
Date: Mon, 13 Oct 2014 10:51:39 +0300
Message-ID: <1413114332-626-24-git-send-email-mst-v4__22070.8268615001$1413186624$gmane$org@redhat.com>
References: <1413114332-626-1-git-send-email-mst-v4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1413114332-626-1-git-send-email-mst-v4@redhat.com>
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
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-scsi@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit.shah@redhat.com>, v9fs-developer@lists.sourceforge.net, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

virtio spec requires drivers to set DRIVER_OK before using VQs.
This is set automatically after resume returns, virtio balloon
violated this rule by adding bufs, which causes the VQ to be used
directly within restore.

To fix, call virtio_device_ready before using VQ.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 25ebe8e..9629fad 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -538,6 +538,8 @@ static int virtballoon_restore(struct virtio_device *vdev)
 	if (ret)
 		return ret;
 
+	virtio_device_ready(vdev);
+
 	fill_balloon(vb, towards_target(vb));
 	update_balloon_size(vb);
 	return 0;
-- 
MST
