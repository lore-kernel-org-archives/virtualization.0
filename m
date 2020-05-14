From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 10/31] vhost/vsock: fix packet delivery order to
 monitoring devices
Date: Thu, 14 May 2020 14:53:52 -0400
Message-ID: <20200514185413.20755-10-sashal@kernel.org>
References: <20200514185413.20755-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200514185413.20755-1-sashal@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit 107bc0766b9feb5113074c753735a3f115c2141f ]

We want to deliver packets to monitoring devices before it is
put in the virtqueue, to avoid that replies can appear in the
packet capture before the transmitted packet.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vsock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index bac1365cc81b5..7891bd40ebd82 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -182,14 +182,14 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			break;
 		}
 
-		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
-		added = true;
-
-		/* Deliver to monitoring devices all correctly transmitted
-		 * packets.
+		/* Deliver to monitoring devices all packets that we
+		 * will transmit.
 		 */
 		virtio_transport_deliver_tap_pkt(pkt);
 
+		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
+		added = true;
+
 		pkt->off += payload_len;
 		total_len += payload_len;
 
-- 
2.20.1
