From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] xen-gntdev: integer overflow in gntdev_alloc_map()
Date: Fri, 4 Nov 2011 21:23:32 +0300
Message-ID: <20111104182332.GC5796__47527.8497710407$1321323107$gmane$org@elgon.mountain>
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
To: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Cc: kernel-janitors@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

The multiplications here can overflow resulting in smaller buffer
sizes than expected.  "count" comes from a copy_from_user().

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 880798a..2f3c363 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -114,11 +114,11 @@ static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count)
 	if (NULL == add)
 		return NULL;
 
-	add->grants    = kzalloc(sizeof(add->grants[0])    * count, GFP_KERNEL);
-	add->map_ops   = kzalloc(sizeof(add->map_ops[0])   * count, GFP_KERNEL);
-	add->unmap_ops = kzalloc(sizeof(add->unmap_ops[0]) * count, GFP_KERNEL);
-	add->kmap_ops  = kzalloc(sizeof(add->kmap_ops[0])  * count, GFP_KERNEL);
-	add->pages     = kzalloc(sizeof(add->pages[0])     * count, GFP_KERNEL);
+	add->grants    = kcalloc(count, sizeof(add->grants[0]), GFP_KERNEL);
+	add->map_ops   = kcalloc(count, sizeof(add->map_ops[0]), GFP_KERNEL);
+	add->unmap_ops = kcalloc(count, sizeof(add->unmap_ops[0]), GFP_KERNEL);
+	add->kmap_ops  = kcalloc(count, sizeof(add->kmap_ops[0]), GFP_KERNEL);
+	add->pages     = kcalloc(count, sizeof(add->pages[0]), GFP_KERNEL);
 	if (NULL == add->grants    ||
 	    NULL == add->map_ops   ||
 	    NULL == add->unmap_ops ||
