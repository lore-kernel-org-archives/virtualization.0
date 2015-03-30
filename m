From: Joe Perches <joe@perches.com>
Subject: [PATCH 12/25] virtio_console: Use bool function return values of
	true/false not 1/0
Date: Mon, 30 Mar 2015 16:46:10 -0700
Message-ID: <aa2bc094fb872b0e30703e0ad1bbe97f98bae91d.1427759009.git.joe__949.021455790167$1427763911$gmane$org@perches.com>
References: <cover.1427759009.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1427759009.git.joe@perches.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Use the normal return values for bool functions

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 72d7028..50754d20 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -355,7 +355,7 @@ static inline bool use_multiport(struct ports_device *portdev)
 	 * early_init
 	 */
 	if (!portdev->vdev)
-		return 0;
+		return false;
 	return __virtio_test_bit(portdev->vdev, VIRTIO_CONSOLE_F_MULTIPORT);
 }
 
-- 
2.1.2
