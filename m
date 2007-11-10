From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] Fix 9p virtio transport compile
Date: Sat, 10 Nov 2007 16:12:13 -0600
Message-ID: <1194732734811-git-send-email-aliguori@us.ibm.com>
References: <11947327333462-git-send-email-aliguori@us.ibm.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11947327333462-git-send-email-aliguori@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Rusty Russell <rusty@rusycorp.com.au>
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty's recent config_ops changes broke the 9p virtio transport.  This patch
fixes that.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 40b71a2..78d7946 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -236,13 +236,13 @@ static int p9_virtio_probe(struct virtio_device *dev)
 
 	/* Find the input queue. */
 	dev->priv = chan;
-	chan->in_vq = dev->config->find_vq(dev, p9_virtio_intr);
+	chan->in_vq = dev->config->find_vq(dev, 0, p9_virtio_intr);
 	if (IS_ERR(chan->in_vq)) {
 		err = PTR_ERR(chan->in_vq);
 		goto free;
 	}
 
-	chan->out_vq = dev->config->find_vq(dev, NULL);
+	chan->out_vq = dev->config->find_vq(dev, 1, NULL);
 	if (IS_ERR(chan->out_vq)) {
 		err = PTR_ERR(chan->out_vq);
 		goto free_in_vq;
