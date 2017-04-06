From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] virtio_net: tidy a couple debug statements
Date: Thu, 6 Apr 2017 12:04:47 +0300
Message-ID: <20170406090446.GA29939@mwanda>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We are printing a decimal value for truesize so we shouldn't use an "0x"
prefix.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0e6e3acf6ff1..2b5e8069d9e5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -668,7 +668,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	rcu_read_unlock();
 
 	if (unlikely(len > (unsigned long)ctx)) {
-		pr_debug("%s: rx error: len %u exceeds truesize 0x%lu\n",
+		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 			 dev->name, len, (unsigned long)ctx);
 		dev->stats.rx_length_errors++;
 		goto err_skb;
@@ -694,7 +694,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 
 		page = virt_to_head_page(buf);
 		if (unlikely(len > (unsigned long)ctx)) {
-			pr_debug("%s: rx error: len %u exceeds truesize 0x%lu\n",
+			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 				 dev->name, len, (unsigned long)ctx);
 			dev->stats.rx_length_errors++;
 			goto err_skb;
