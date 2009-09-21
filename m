From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 5/5] lguest: don't force VIRTIO_F_NOTIFY_ON_EMPTY
Date: Mon, 21 Sep 2009 16:52:21 +0930
Message-ID: <200909210723.n8L7NtXE022139@smtp1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.osdl.org
Cc: lguest@ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org


VIRTIO_F_NOTIFY_ON_EMPTY indicates to the Guest that we will hit them with
an interrupt every time the xmit queue is emptied.

Because it results in lots of tx interrupts, modern Guests probably don't
want it, so let's only force it when they accept the option.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/lguest/lguest.c b/Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -134,6 +134,9 @@ struct device {
 	/* Is it operational */
 	bool running;
 
+	/* Does Guest want an intrrupt on empty? */
+	bool irq_on_empty;
+
 	/* Device-specific data. */
 	void *priv;
 };
@@ -624,10 +627,13 @@ static void trigger_irq(struct virtqueue
 		return;
 	vq->pending_used = 0;
 
-	/* If they don't want an interrupt, don't send one, unless empty. */
-	if ((vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)
-	    && lg_last_avail(vq) != vq->vring.avail->idx)
-		return;
+	/* If they don't want an interrupt, don't send one... */
+	if (vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT) {
+		/* ... unless they've asked us to force one on empty. */
+		if (!vq->dev->irq_on_empty
+		    || lg_last_avail(vq) != vq->vring.avail->idx)
+			return;
+	}
 
 	/* Send the Guest an interrupt tell them we used something up. */
 	if (write(lguest_fd, buf, sizeof(buf)) != 0)
@@ -1043,6 +1049,15 @@ static void create_thread(struct virtque
 	close(vq->eventfd);
 }
 
+static bool accepted_feature(struct device *dev, unsigned int bit)
+{
+	const u8 *features = get_feature_bits(dev) + dev->feature_len;
+
+	if (dev->feature_len < bit / CHAR_BIT)
+		return false;
+	return features[bit / CHAR_BIT] & (1 << (bit % CHAR_BIT));
+}
+
 static void start_device(struct device *dev)
 {
 	unsigned int i;
@@ -1056,6 +1071,8 @@ static void start_device(struct device *
 		verbose(" %02x", get_feature_bits(dev)
 			[dev->feature_len+i]);
 
+	dev->irq_on_empty = accepted_feature(dev, VIRTIO_F_NOTIFY_ON_EMPTY);
+
 	for (vq = dev->vq; vq; vq = vq->next) {
 		if (vq->service)
 			create_thread(vq);
