From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [RFC 12/12] rpmsg: add a device ID to also bind to the ADSP device
Date: Fri, 29 May 2020 09:37:22 +0200
Message-ID: <20200529073722.8184-13-guennadi.liakhovetski@linux.intel.com>
References: <20200529073722.8184-1-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200529073722.8184-1-guennadi.liakhovetski@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: kvm@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, linux-remoteproc@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, virtualization@lists.linux-foundation.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, sound-open-firmware@alsa-project.org
List-Id: virtualization@lists.linuxfoundation.org

The ADSP device uses the RPMsg API to connect vhost and VirtIO SOF
Audio DSP drivers on KVM host and guest.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index f3bd050..ebe3f19 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -949,6 +949,7 @@ static void rpmsg_remove(struct virtio_device *vdev)
 
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_RPMSG, VIRTIO_DEV_ANY_ID },
+	{ VIRTIO_ID_ADSP, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
 
-- 
1.9.3
