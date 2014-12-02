From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v5 09/19] s390x/css: Add a callback for when subchannel
	gets disabled
Date: Tue,  2 Dec 2014 14:00:17 +0100
Message-ID: <1417525227-14051-10-git-send-email-cornelia.huck__16720.6367863857$1417525374$gmane$org@de.ibm.com>
References: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Thomas Huth <thuth@linux.vnet.ibm.com>

We need a possibility to run code when a subchannel gets disabled.
This patch adds the necessary infrastructure.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css.c |   12 ++++++++++++
 hw/s390x/css.h |    1 +
 2 files changed, 13 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index b67c039..735ec55 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -588,6 +588,7 @@ int css_do_msch(SubchDev *sch, SCHIB *orig_schib)
 {
     SCSW *s = &sch->curr_status.scsw;
     PMCW *p = &sch->curr_status.pmcw;
+    uint16_t oldflags;
     int ret;
     SCHIB schib;
 
@@ -610,6 +611,7 @@ int css_do_msch(SubchDev *sch, SCHIB *orig_schib)
     copy_schib_from_guest(&schib, orig_schib);
     /* Only update the program-modifiable fields. */
     p->intparm = schib.pmcw.intparm;
+    oldflags = p->flags;
     p->flags &= ~(PMCW_FLAGS_MASK_ISC | PMCW_FLAGS_MASK_ENA |
                   PMCW_FLAGS_MASK_LM | PMCW_FLAGS_MASK_MME |
                   PMCW_FLAGS_MASK_MP);
@@ -625,6 +627,12 @@ int css_do_msch(SubchDev *sch, SCHIB *orig_schib)
             (PMCW_CHARS_MASK_MBFC | PMCW_CHARS_MASK_CSENSE);
     sch->curr_status.mba = schib.mba;
 
+    /* Has the channel been disabled? */
+    if (sch->disable_cb && (oldflags & PMCW_FLAGS_MASK_ENA) != 0
+        && (p->flags & PMCW_FLAGS_MASK_ENA) == 0) {
+        sch->disable_cb(sch);
+    }
+
     ret = 0;
 
 out:
@@ -1443,6 +1451,10 @@ void css_reset_sch(SubchDev *sch)
 {
     PMCW *p = &sch->curr_status.pmcw;
 
+    if ((p->flags & PMCW_FLAGS_MASK_ENA) != 0 && sch->disable_cb) {
+        sch->disable_cb(sch);
+    }
+
     p->intparm = 0;
     p->flags &= ~(PMCW_FLAGS_MASK_ISC | PMCW_FLAGS_MASK_ENA |
                   PMCW_FLAGS_MASK_LM | PMCW_FLAGS_MASK_MME |
diff --git a/hw/s390x/css.h b/hw/s390x/css.h
index 33104ac..7fa807b 100644
--- a/hw/s390x/css.h
+++ b/hw/s390x/css.h
@@ -81,6 +81,7 @@ struct SubchDev {
     uint8_t ccw_no_data_cnt;
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
+    void (*disable_cb)(SubchDev *);
     SenseId id;
     void *driver_data;
 };
-- 
1.7.9.5
