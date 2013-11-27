From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH char-misc-linus v3 1/6] misc: mic: Change mic_notify(...) to
	return true.
Date: Wed, 27 Nov 2013 08:58:38 -0800
Message-ID: <100078a1f4e7f56ef9dc1c4a51c8165a2e090de9.1385569514.git.ashutosh.dixit__38992.2918788672$1386087518$gmane$org@intel.com>
References: <cover.1385527468.git.ashutosh.dixit@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1385527468.git.ashutosh.dixit@intel.com>
In-Reply-To: <cover.1385569514.git.ashutosh.dixit@intel.com>
References: <cover.1385569514.git.ashutosh.dixit@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Siva Krishna Kumar Reddy Yerramreddy <siva.krishna.kumar.reddy.yerramreddy@intel.com>, Caz Yokoyama <Caz.Yokoyama@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Sudeep Dutt <sudeep.dutt@intel.com>

virtqueue_{kick()/notify()} methods are required to return bool due to
API changes introduced in commit 5b1bf7cb673a.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Sudeep Dutt <sudeep.dutt@intel.com>
---
 drivers/misc/mic/card/mic_virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mic/card/mic_virtio.c b/drivers/misc/mic/card/mic_virtio.c
index 8aa42e7..1ebc51c 100644
--- a/drivers/misc/mic/card/mic_virtio.c
+++ b/drivers/misc/mic/card/mic_virtio.c
@@ -187,11 +187,12 @@ static void mic_reset(struct virtio_device *vdev)
 /*
  * The virtio_ring code calls this API when it wants to notify the Host.
  */
-static void mic_notify(struct virtqueue *vq)
+static bool mic_notify(struct virtqueue *vq)
 {
 	struct mic_vdev *mvdev = vq->priv;
 
 	mic_send_intr(mvdev->mdev, mvdev->c2h_vdev_db);
+	return true;
 }
 
 static void mic_del_vq(struct virtqueue *vq, int n)
-- 
1.8.2.3
