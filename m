From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/3] Makes lguest's irq handler typesafe
Date: Sat, 19 Jan 2008 07:27:36 +1100
Message-ID: <200801190727.36567.rusty__48654.7276647345$1200688193$gmane$org@rustcorp.com.au>
References: <200801190722.26154.rusty@rustcorp.com.au>
	<200801190725.24271.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801190725.24271.rusty@rustcorp.com.au>
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
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, linux-pcmcia@lists.infradead.org, virtualization@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ash Willis <ashwillis@programmer.net>, Jeff Garzik <jgarzik@pobox.com>
List-Id: virtualization@lists.linuxfoundation.org

Just a trivial example.
---
 drivers/lguest/lguest_device.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -r 00ab7672f658 drivers/lguest/lguest_device.c
--- a/drivers/lguest/lguest_device.c	Thu Jan 17 16:54:00 2008 +1100
+++ b/drivers/lguest/lguest_device.c	Thu Jan 17 16:59:46 2008 +1100
@@ -179,9 +179,8 @@ static void lg_notify(struct virtqueue *
 	hcall(LHCALL_NOTIFY, lvq->config.pfn << PAGE_SHIFT, 0, 0);
 }
 
-static irqreturn_t lguest_interrupt(int irq, void *_vq)
+static irqreturn_t lguest_interrupt(int irq, struct virtqueue *vq)
 {
-	struct virtqueue *vq = _vq;
 	struct lguest_device_desc *desc = to_lgdev(vq->vdev)->desc;
 
 	if (unlikely(desc->config_change)) {
