From: weiping zhang <zhangweiping@didichuxing.com>
Subject: [RFC PATCH] virtio: add space for device features show
Date: Tue, 26 Dec 2017 21:35:44 +0800
Message-ID: <20171226133539.GA15965@localhost.didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: cohuck@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

make features string more readable, add space every 8bit.
example:
00101010 01110000 00000000 00001100

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 drivers/virtio/virtio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 59e36ef..d7d2db1 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -50,9 +50,12 @@ static ssize_t features_show(struct device *_d,
 
 	/* We actually represent this as a bitstring, as it could be
 	 * arbitrary length in future. */
-	for (i = 0; i < sizeof(dev->features)*8; i++)
-		len += sprintf(buf+len, "%c",
+	for (i = 0; i < sizeof(dev->features) * 8; i++) {
+		len += sprintf(buf + len, "%c",
 			       __virtio_test_bit(dev, i) ? '1' : '0');
+		if (i % 8 == 7)
+			len += sprintf(buf + len, " ");
+	}
 	len += sprintf(buf+len, "\n");
 	return len;
 }
-- 
2.9.4
