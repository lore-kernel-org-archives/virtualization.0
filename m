From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5/6] virtio/scsi: verify device has config space
Date: Tue, 13 Jan 2015 16:43:24 +0200
Message-ID: <1421160167-18498-6-git-send-email-mst__46002.9384973042$1421178506$gmane$org@redhat.com>
References: <1421160167-18498-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20150113194736.GM21393@redhat.com>
Resent-To: virtualization@lists.linux-foundation.org
Content-Disposition: inline
In-Reply-To: <1421160167-18498-1-git-send-email-mst@redhat.com>
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
Cc: linux-scsi@vger.kernel.org, "James E.J. Bottomley" <JBottomley@parallels.com>
List-Id: virtualization@lists.linuxfoundation.org

Some devices might not implement config space access
(e.g. remoteproc used not to - before 3.9).
virtio/scsi needs config space access so make it
fail gracefully if not there.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/scsi/virtio_scsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index c52bb5d..f164f24 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -950,6 +950,12 @@ static int virtscsi_probe(struct virtio_device *vdev)
 	u32 num_queues;
 	struct scsi_host_template *hostt;
 
+	if (!vdev->config->get) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
 	/* We need to know how many queues before we allocate. */
 	num_queues = virtscsi_config_get(vdev, num_queues) ? : 1;
 
-- 
MST
