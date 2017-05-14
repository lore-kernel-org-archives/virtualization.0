From: Maciek Fijalkowski <macfij7@wp.pl>
Subject: [PATCH 3/3] Fix ERROR: code indent should use tabs where possible
Date: Sun, 14 May 2017 19:51:30 +0200
Message-ID: <20170514175130.18664-3-macfij7__7597.27398767627$1494947333$gmane$org@wp.pl>
References: <20170514175130.18664-1-macfij7@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170514175130.18664-1-macfij7@wp.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: Maciej Fijalkowski <macfij7@wp.pl>, jasonwang@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Maciej Fijalkowski <macfij7@wp.pl>

Signed-off-by: Maciej Fijalkowski <macfij7@wp.pl>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6c8170c..5d71e9f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2717,7 +2717,7 @@ static __init int virtio_net_driver_init(void)
 	if (ret)
 		goto err_dead;
 
-        ret = register_virtio_driver(&virtio_net_driver);
+	ret = register_virtio_driver(&virtio_net_driver);
 	if (ret)
 		goto err_virtio;
 	return 0;
-- 
2.4.11
