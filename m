From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/3] lguest: implement VIRTIO_F_NOTIFY_ON_EMPTY
Date: Fri, 30 May 2008 15:13:17 +1000
Message-ID: <200805301513.17802.rusty__19920.1031392024$1212124675$gmane$org@rustcorp.com.au>
References: <200805301512.07802.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805301512.07802.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is the lguest implementation of the VIRTIO_F_NOTIFY_ON_EMPTY feature.
It is currently only published for network devices, but it is turned on for
everyone.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff -r a2e94bbd1589 Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c	Tue May 27 16:06:10 2008 +1000
+++ b/Documentation/lguest/lguest.c	Tue May 27 16:15:43 2008 +1000
@@ -157,6 +157,9 @@ struct virtqueue
 
 	/* The routine to call when the Guest pings us. */
 	void (*handle_output)(int fd, struct virtqueue *me);
+
+	/* Outstanding buffers */
+	unsigned int inflight;
 };
 
 /* Remember the arguments to the program so we can "reboot" */
@@ -702,6 +705,7 @@ static unsigned get_vq_desc(struct virtq
 			errx(1, "Looped descriptor");
 	} while ((i = next_desc(vq, i)) != vq->vring.num);
 
+	vq->inflight++;
 	return head;
 }
 
@@ -719,6 +723,7 @@ static void add_used(struct virtqueue *v
 	/* Make sure buffer is written before we update index. */
 	wmb();
 	vq->vring.used->idx++;
+	vq->inflight--;
 }
 
 /* This actually sends the interrupt for this virtqueue */
@@ -726,8 +731,9 @@ static void trigger_irq(int fd, struct v
 {
 	unsigned long buf[] = { LHREQ_IRQ, vq->config.irq };
 
-	/* If they don't want an interrupt, don't send one. */
-	if (vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)
+	/* If they don't want an interrupt, don't send one, unless empty. */
+	if ((vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)
+	    && vq->inflight)
 		return;
 
 	/* Send the Guest an interrupt tell them we used something up. */
@@ -1107,6 +1113,7 @@ static void add_virtqueue(struct device 
 	vq->next = NULL;
 	vq->last_avail_idx = 0;
 	vq->dev = dev;
+	vq->inflight = 0;
 
 	/* Initialize the configuration. */
 	vq->config.num = num_descs;
@@ -1368,6 +1375,7 @@ static void setup_tun_net(const char *ar
 
 	/* Tell Guest what MAC address to use. */
 	add_feature(dev, VIRTIO_NET_F_MAC);
+	add_feature(dev, VIRTIO_F_NOTIFY_ON_EMPTY);
 	set_config(dev, sizeof(conf), &conf);
 
 	/* We don't need the socket any more; setup is done. */
