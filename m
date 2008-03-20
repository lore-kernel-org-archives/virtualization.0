From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH 4/5] lguest: ignore bad virtqueues.
Date: Thu, 20 Mar 2008 17:40:28 +1100
Message-ID: <200803201740.28991.rusty__36340.2544441216$1205995393$gmane$org@rustcorp.com.au>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<200803201722.53636.rusty@rustcorp.com.au>
	<200803201736.01883.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201736.01883.rusty@rustcorp.com.au>
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
To: virtualization@lists.linux-foundation.org
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>
List-Id: virtualization@lists.linuxfoundation.org

Currently the lguest Launcher aborts when a Guest puts something bogus
in a virtio queue.  If we want to deal with other (untrusted) Guests'
queues, that's a bad idea: simply print a warning and ignore it from
now on.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c |   45 +++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff -r 784299890d4a Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c	Thu Mar 13 23:10:14 2008 +1100
+++ b/Documentation/lguest/lguest.c	Thu Mar 13 23:21:55 2008 +1100
@@ -156,6 +156,9 @@ struct virtqueue_info
 
 	/* Last available index we saw. */
 	u16 last_avail_idx;
+
+	/* Are we broken?  If so, ignore it from now on. */
+	bool broken;
 };
 
 struct virtqueue
@@ -676,8 +679,11 @@ static unsigned next_desc(struct virtque
 	/* Make sure compiler knows to grab that: we don't want it changing! */
 	wmb();
 
-	if (next >= vqi->vring.num)
-		errx(1, "Desc next is %u", next);
+	if (next >= vqi->vring.num) {
+		warnx("Desc next is %u", next);
+		vqi->broken = true;
+		return vqi->vring.num;
+	}
 
 	return next;
 }
@@ -695,10 +701,16 @@ static int get_vq_desc(struct virtqueue_
 {
 	unsigned int i, head;
 
+	/* If the queue is broken, we just pretend there's nothing there. */
+	if (vqi->broken)
+		return -1;
+
 	/* Check it isn't doing very strange things with descriptor numbers. */
-	if ((u16)(vqi->vring.avail->idx - vqi->last_avail_idx) > vqi->vring.num)
-		errx(1, "Guest moved used index from %u to %u",
-		     vqi->last_avail_idx, vqi->vring.avail->idx);
+	if ((u16)(vqi->vring.avail->idx-vqi->last_avail_idx) > vqi->vring.num) {
+		warnx("Guest moved used index from %u to %u",
+		      vqi->last_avail_idx, vqi->vring.avail->idx);
+		goto broken;
+	}
 
 	/* If there's nothing new since last we looked, return invalid. */
 	if (vqi->vring.avail->idx == vqi->last_avail_idx)
@@ -709,8 +721,10 @@ static int get_vq_desc(struct virtqueue_
 	head = vqi->vring.avail->ring[vqi->last_avail_idx++ % vqi->vring.num];
 
 	/* If their number is silly, that's a fatal mistake. */
-	if (head >= vqi->vring.num)
-		errx(1, "Guest says index %u is available", head);
+	if (head >= vqi->vring.num) {
+		warnx("Guest says index %u is available", head);
+		goto broken;
+	}
 
 	/* When we start there are none of either input nor output. */
 	*out_num = *in_num = 0;
@@ -728,17 +742,25 @@ static int get_vq_desc(struct virtqueue_
 		else {
 			/* If it's an output descriptor, they're all supposed
 			 * to come before any input descriptors. */
-			if (*in_num)
-				errx(1, "Descriptor has out after in");
+			if (*in_num) {
+				warnx("Descriptor has out after in");
+				goto broken;
+			}
 			(*out_num)++;
 		}
 
 		/* If we've got too many, that implies a descriptor loop. */
-		if (*out_num + *in_num > vqi->vring.num)
-			errx(1, "Looped descriptor");
+		if (*out_num + *in_num > vqi->vring.num) {
+			warnx("Looped descriptor");
+			goto broken;
+		}
 	} while ((i = next_desc(vqi, i)) != vqi->vring.num);
 
 	return head;
+
+broken:
+	vqi->broken = true;
+	return -1;
 }
 
 /* After we've used one of their buffers, we tell them about it.  We'll then
@@ -1127,6 +1149,7 @@ static void add_virtqueue(struct device 
 	vq->dev = dev;
 	vq->vqi.last_avail_idx = 0;
 	vq->vqi.mem = &gmem;
+	vq->vqi.broken = false;
 
 	/* Initialize the configuration. */
 	vq->config.num = num_descs;
