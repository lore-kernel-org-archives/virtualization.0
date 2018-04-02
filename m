From: Vladislav Yasevich <vyasevich@gmail.com>
Subject: [PATCH net-next 4/5] tun: Add support for SCTP checksum offload
Date: Mon,  2 Apr 2018 09:40:05 -0400
Message-ID: <20180402134006.10111-5-vyasevic__17801.7520848245$1522676344$gmane$org@redhat.com>
References: <20180402134006.10111-1-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180402134006.10111-1-vyasevic@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: nhorman@tuxdriver.com, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-sctp@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Adds a new tun offload flag to allow for SCTP checksum offload.
The flag has to be set by the user and defaults to "no offload".

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 drivers/net/tun.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a1ba262..263bcbe 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2719,6 +2719,11 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
 		arg &= ~TUN_F_UFO;
 	}
 
+	if (arg & TUN_F_SCTP_CSUM) {
+		features |= NETIF_F_SCTP_CRC;
+		arg &= ~TUN_F_SCTP_CSUM;
+	}
+
 	/* This gives the user a way to test for new features in future by
 	 * trying to set them. */
 	if (arg)
-- 
2.9.5
