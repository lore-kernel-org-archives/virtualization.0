From: "G. Campana" <gcampana@quarkslab.com>
Subject: [PATCH v2] virtio_console: fix a crash in config_work_handler
Date: Mon, 16 Jan 2017 10:45:02 +0100
Message-ID: <1484559902-5346-1-git-send-email-gcampana__15203.6755964675$1484863801$gmane$org@quarkslab.com>
References: <20170116033550.GK16209@amit-lp.rh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170116033550.GK16209@amit-lp.rh>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: "G. Campana" <gcampana@quarkslab.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Using control_work instead of config_work as the 3rd argument to
container_of results in an invalid portdev pointer. Indeed, the work
structure is initialized as below:

    INIT_WORK(&portdev->config_work, &config_work_handler);

It leads to a crash when portdev->vdev is dereferenced later. This bug
is triggered when the guest uses a virtio-console without multiport
feature and receives a config_changed virtio interrupt.

Signed-off-by: G. Campana <gcampana@quarkslab.com>
---
 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 8b00e79..17857be 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1862,7 +1862,7 @@ static void config_work_handler(struct work_struct *work)
 {
 	struct ports_device *portdev;
 
-	portdev = container_of(work, struct ports_device, control_work);
+	portdev = container_of(work, struct ports_device, config_work);
 	if (!use_multiport(portdev)) {
 		struct virtio_device *vdev;
 		struct port *port;
-- 
2.7.4
