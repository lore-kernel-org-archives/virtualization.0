From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 19/35 linux-next] virtio_mmio: constify of_device_id array
Date: Mon, 16 Mar 2015 20:20:35 +0100
Message-ID: <1426533651-25586-10-git-send-email-fabf__44621.5072334327$1426533881$gmane$org@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
	<1426533651-25586-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1426533651-25586-1-git-send-email-fabf@skynet.be>
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
Cc: Fabian Frederick <fabf@skynet.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/virtio/virtio_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 9c877d2..0ce8cda 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -671,7 +671,7 @@ static void vm_unregister_cmdline_devices(void)
 
 /* Platform driver */
 
-static struct of_device_id virtio_mmio_match[] = {
+static const struct of_device_id virtio_mmio_match[] = {
 	{ .compatible = "virtio,mmio", },
 	{},
 };
-- 
2.1.0
