From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 2/2] virtio: document virtio_config_ops restrictions
Date: Thu,  3 Jan 2019 17:08:04 +0100
Message-ID: <20190103160804.21438-3-cohuck__37750.7380130284$1546531607$gmane$org@redhat.com>
References: <20190103160804.21438-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190103160804.21438-1-cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Some transports (e.g. virtio-ccw) implement virtio operations that
seem to be a simple read/write as something more involved that
cannot be done from an atomic context.

Give at least a hint about that.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/linux/virtio_config.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 7087ef946ba7..987b6491b946 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -12,6 +12,11 @@ struct irq_affinity;
 
 /**
  * virtio_config_ops - operations for configuring a virtio device
+ * Note: Do not assume that a transport implements all of the operations
+ *       getting/setting a value as a simple read/write! Generally speaking,
+ *       any of @get/@set, @get_status/@set_status, or @get_features/
+ *       @finalize_features are NOT safe to be called from an atomic
+ *       context.
  * @get: read the value of a configuration field
  *	vdev: the virtio_device
  *	offset: the offset of the configuration field
-- 
2.17.2
