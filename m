From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 net 3/3] virtio_net: sparse annotation fix
Date: Thu, 19 Apr 2018 08:30:50 +0300
Message-ID: <1524115776-334953-4-git-send-email-mst__31201.0047295646$1524115758$gmane$org@redhat.com>
References: <1524115776-334953-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1524115776-334953-1-git-send-email-mst@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org, Mikulas Patocka <mpatocka@redhat.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

offloads is a buffer in virtio format, should use
the __virtio64 tag.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f84fe04..c5b11f2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -155,7 +155,7 @@ struct control_buf {
 	u8 promisc;
 	u8 allmulti;
 	__virtio16 vid;
-	u64 offloads;
+	__virtio64 offloads;
 };
 
 struct virtnet_info {
-- 
MST
