From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/3] Make IRQ handlers typesafe.
Date: Sat, 19 Jan 2008 07:25:23 +1100
Message-ID: <200801190725.24271.rusty__42362.7770426267$1200688055$gmane$org@rustcorp.com.au>
References: <200801190722.26154.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801190722.26154.rusty@rustcorp.com.au>
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

This patch lets interrupt handler functions have their natural type
(ie. exactly match the data pointer type); for transition it allows
the old irq_handler_t type as well.

To do this it uses a gcc extension, cast-to-union, which allows a type
to be cast to any type within the union.  When used in a wrapper
macro, it's a simple way of allowing one of several types.

(Some drivers now need to be cleaned up to compile, previous patch).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 include/linux/interrupt.h |   17 +++++++++++++++--
 include/linux/kernel.h    |    7 +++++++
 kernel/irq/devres.c       |   10 +++++-----
 kernel/irq/manage.c       |    6 +++---
 4 files changed, 30 insertions(+), 10 deletions(-)

diff -r 0fe1a980708b include/linux/interrupt.h
--- a/include/linux/interrupt.h	Thu Jan 17 14:48:56 2008 +1100
+++ b/include/linux/interrupt.h	Thu Jan 17 15:42:01 2008 +1100
@@ -69,13 +69,26 @@ struct irqaction {
 };
 
 extern irqreturn_t no_action(int cpl, void *dev_id);
-extern int __must_check request_irq(unsigned int, irq_handler_t handler,
+
+/* Typesafe version of request_irq.  Also takes old-style void * handlers. */
+#define request_irq(irq, handler, flags, name, dev_id)			\
+	__request_irq((irq),						\
+		      check_either_type((handler), irq_handler_t,	\
+					int (*)(int, typeof(dev_id))),	\
+		      (flags), (name), (dev_id))
+
+extern int __must_check __request_irq(unsigned int, irq_handler_t handler,
 		       unsigned long, const char *, void *);
 extern void free_irq(unsigned int, void *);
 
 struct device;
 
-extern int __must_check devm_request_irq(struct device *dev, unsigned int irq,
+#define devm_request_irq(dev, irq, handler, flags, name, dev_id)	\
+	__devm_request_irq((dev), (irq),				\
+		      check_either_type((handler), irq_handler_t,	\
+					int (*)(int, typeof(dev_id))),	\
+		      (flags), (name), (dev_id))
+extern int __must_check __devm_request_irq(struct device *dev, unsigned int irq,
 			    irq_handler_t handler, unsigned long irqflags,
 			    const char *devname, void *dev_id);
 extern void devm_free_irq(struct device *dev, unsigned int irq, void *dev_id);
diff -r 0fe1a980708b include/linux/kernel.h
--- a/include/linux/kernel.h	Thu Jan 17 14:48:56 2008 +1100
+++ b/include/linux/kernel.h	Thu Jan 17 15:42:01 2008 +1100
@@ -379,6 +379,13 @@ static inline int __attribute__ ((format
 	(void)__tmp; \
 })
 
+/*
+ * Returns var as a type1.  If it's not a type1 or type2 you'll get:
+ * "error: cast to union type from type not present in union"
+ */
+#define check_either_type(var, type1, type2) \
+	(((union { typeof(type1) _t1; typeof(type2) _t2; })var)._t1)
+
 struct sysinfo;
 extern int do_sysinfo(struct sysinfo *info);
 
diff -r 0fe1a980708b kernel/irq/devres.c
--- a/kernel/irq/devres.c	Thu Jan 17 14:48:56 2008 +1100
+++ b/kernel/irq/devres.c	Thu Jan 17 15:42:01 2008 +1100
@@ -41,9 +41,9 @@ static int devm_irq_match(struct device 
  *	If an IRQ allocated with this function needs to be freed
  *	separately, dev_free_irq() must be used.
  */
-int devm_request_irq(struct device *dev, unsigned int irq,
-		     irq_handler_t handler, unsigned long irqflags,
-		     const char *devname, void *dev_id)
+int __devm_request_irq(struct device *dev, unsigned int irq,
+		       irq_handler_t handler, unsigned long irqflags,
+		       const char *devname, void *dev_id)
 {
 	struct irq_devres *dr;
 	int rc;
@@ -53,7 +53,7 @@ int devm_request_irq(struct device *dev,
 	if (!dr)
 		return -ENOMEM;
 
-	rc = request_irq(irq, handler, irqflags, devname, dev_id);
+	rc = __request_irq(irq, handler, irqflags, devname, dev_id);
 	if (rc) {
 		devres_free(dr);
 		return rc;
@@ -65,7 +65,7 @@ int devm_request_irq(struct device *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL(devm_request_irq);
+EXPORT_SYMBOL(__devm_request_irq);
 
 /**
  *	devm_free_irq - free an interrupt
diff -r 0fe1a980708b kernel/irq/manage.c
--- a/kernel/irq/manage.c	Thu Jan 17 14:48:56 2008 +1100
+++ b/kernel/irq/manage.c	Thu Jan 17 15:42:01 2008 +1100
@@ -514,8 +514,8 @@ EXPORT_SYMBOL(free_irq);
  *	IRQF_SAMPLE_RANDOM	The interrupt can be used for entropy
  *
  */
-int request_irq(unsigned int irq, irq_handler_t handler,
-		unsigned long irqflags, const char *devname, void *dev_id)
+int __request_irq(unsigned int irq, irq_handler_t handler,
+		  unsigned long irqflags, const char *devname, void *dev_id)
 {
 	struct irqaction *action;
 	int retval;
@@ -576,4 +576,4 @@ int request_irq(unsigned int irq, irq_ha
 
 	return retval;
 }
-EXPORT_SYMBOL(request_irq);
+EXPORT_SYMBOL(__request_irq);
