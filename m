From: rusty@rustcorp.com.au
Subject: [patch 24/43] lguest: Change example launcher to use unsigned long
	not u32
Date: Wed, 26 Sep 2007 16:36:42 +1000
Message-ID: <20070926063649.450909013@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lg-user-datatypes.diff
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: Jes Sorensen <jes@sgi.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Apply Clue 2x4 to lguest userland<->kernel handling code and the
lguest launcher. Pointers are not to be passed in u32's!

Basic rule of thumb: Anything passing u32's back and forth should be
passing unsigned longs to be portable to 64 bit archs.

For those who forgotten already, I repeat: NO POINTERS IN u32!

Signed-off-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 Documentation/lguest/lguest.c |   29 +++++++++++++++--------------
 drivers/lguest/lguest_user.c  |   33 +++++++++++++++++----------------
 2 files changed, 32 insertions(+), 30 deletions(-)

===================================================================
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -473,9 +473,9 @@ static unsigned long setup_pagetables(un
 				      unsigned long initrd_size,
 				      unsigned long page_offset)
 {
-	u32 *pgdir, *linear;
+	unsigned long *pgdir, *linear;
 	unsigned int mapped_pages, i, linear_pages;
-	unsigned int ptes_per_page = getpagesize()/sizeof(u32);
+	unsigned int ptes_per_page = getpagesize()/sizeof(void *);
 
 	/* Ideally we map all physical memory starting at page_offset.
 	 * However, if page_offset is 0xC0000000 we can only map 1G of physical
@@ -505,7 +505,7 @@ static unsigned long setup_pagetables(un
 	 * continue from there. */
 	for (i = 0; i < mapped_pages; i += ptes_per_page) {
 		pgdir[(i + page_offset/getpagesize())/ptes_per_page]
-			= ((to_guest_phys(linear) + i*sizeof(u32))
+			= ((to_guest_phys(linear) + i*sizeof(void *))
 			   | PAGE_PRESENT);
 	}
 
@@ -537,12 +537,13 @@ static void concat(char *dst, char *args
  * the base of guest "physical" memory, the top physical page to allow, the
  * top level pagetable, the entry point and the page_offset constant for the
  * Guest. */
-static int tell_kernel(u32 pgdir, u32 start, u32 page_offset)
-{
-	u32 args[] = { LHREQ_INITIALIZE,
-		       (unsigned long)guest_base,
-		       guest_limit / getpagesize(),
-		       pgdir, start, page_offset };
+static int tell_kernel(unsigned long pgdir, unsigned long start,
+		       unsigned long page_offset)
+{
+	unsigned long args[] = { LHREQ_INITIALIZE,
+				 (unsigned long)guest_base,
+				 guest_limit / getpagesize(),
+				 pgdir, start, page_offset };
 	int fd;
 
 	verbose("Guest: %p - %p (%#lx)\n",
@@ -586,7 +587,7 @@ static void wake_parent(int pipefd, int 
 
 	for (;;) {
 		fd_set rfds = devices->infds;
-		u32 args[] = { LHREQ_BREAK, 1 };
+		unsigned long args[] = { LHREQ_BREAK, 1 };
 
 		/* Wait until input is ready from one of the devices. */
 		select(devices->max_infd+1, &rfds, NULL, NULL, NULL);
@@ -684,7 +685,7 @@ static u32 *get_dma_buffer(int fd, void 
 static u32 *get_dma_buffer(int fd, void *key,
 			   struct iovec iov[], unsigned int *num, u32 *irq)
 {
-	u32 buf[] = { LHREQ_GETDMA, to_guest_phys(key) };
+	unsigned long buf[] = { LHREQ_GETDMA, to_guest_phys(key) };
 	unsigned long udma;
 	u32 *res;
 
@@ -705,7 +706,7 @@ static u32 *get_dma_buffer(int fd, void 
 /* This is a convenient routine to send the Guest an interrupt. */
 static void trigger_irq(int fd, u32 irq)
 {
-	u32 buf[] = { LHREQ_IRQ, irq };
+	unsigned long buf[] = { LHREQ_IRQ, irq };
 	if (write(fd, buf, sizeof(buf)) != 0)
 		err(1, "Triggering irq %i", irq);
 }
@@ -787,7 +788,7 @@ static bool handle_console_input(int fd,
 			struct timeval now;
 			gettimeofday(&now, NULL);
 			if (now.tv_sec <= abort->start.tv_sec+1) {
-				u32 args[] = { LHREQ_BREAK, 0 };
+				unsigned long args[] = { LHREQ_BREAK, 0 };
 				/* Close the fd so Waker will know it has to
 				 * exit. */
 				close(waker_fd);
@@ -1365,7 +1366,7 @@ run_guest(int lguest_fd, struct device_l
 run_guest(int lguest_fd, struct device_list *device_list)
 {
 	for (;;) {
-		u32 args[] = { LHREQ_BREAK, 0 };
+		unsigned long args[] = { LHREQ_BREAK, 0 };
 		unsigned long arr[2];
 		int readval;
 
===================================================================
--- a/drivers/lguest/lguest_user.c
+++ b/drivers/lguest/lguest_user.c
@@ -43,7 +43,7 @@ static void setup_regs(struct lguest_reg
 /*L:310 To send DMA into the Guest, the Launcher needs to be able to ask for a
  * DMA buffer.  This is done by writing LHREQ_GETDMA and the key to
  * /dev/lguest. */
-static long user_get_dma(struct lguest *lg, const u32 __user *input)
+static long user_get_dma(struct lguest *lg, const unsigned long __user *input)
 {
 	unsigned long key, udma, irq;
 
@@ -67,7 +67,7 @@ static long user_get_dma(struct lguest *
 /*L:315 To force the Guest to stop running and return to the Launcher, the
  * Waker sets writes LHREQ_BREAK and the value "1" to /dev/lguest.  The
  * Launcher then writes LHREQ_BREAK and "0" to release the Waker. */
-static int break_guest_out(struct lguest *lg, const u32 __user *input)
+static int break_guest_out(struct lguest *lg, const unsigned long __user *input)
 {
 	unsigned long on;
 
@@ -90,9 +90,9 @@ static int break_guest_out(struct lguest
 
 /*L:050 Sending an interrupt is done by writing LHREQ_IRQ and an interrupt
  * number to /dev/lguest. */
-static int user_send_irq(struct lguest *lg, const u32 __user *input)
-{
-	u32 irq;
+static int user_send_irq(struct lguest *lg, const unsigned long __user *input)
+{
+	unsigned long irq;
 
 	if (get_user(irq, input) != 0)
 		return -EFAULT;
@@ -142,8 +142,8 @@ static ssize_t read(struct file *file, c
 	return run_guest(lg, (unsigned long __user *)user);
 }
 
-/*L:020 The initialization write supplies 5 32-bit values (in addition to the
- * 32-bit LHREQ_INITIALIZE value).  These are:
+/*L:020 The initialization write supplies 5 pointer sized (32 or 64 bit)
+ * values (in addition to the LHREQ_INITIALIZE value).  These are:
  *
  * base: The start of the Guest-physical memory inside the Launcher memory.
  *
@@ -162,13 +162,13 @@ static ssize_t read(struct file *file, c
  * quickly converted from physical to virtual by adding PAGE_OFFSET.  It's
  * 0xC0000000 (3G) by default, but it's configurable at kernel build time.
  */
-static int initialize(struct file *file, const u32 __user *input)
+static int initialize(struct file *file, const unsigned long __user *input)
 {
 	/* "struct lguest" contains everything we (the Host) know about a
 	 * Guest. */
 	struct lguest *lg;
 	int err;
-	u32 args[5];
+	unsigned long args[5];
 
 	/* We grab the Big Lguest lock, which protects against multiple
 	 * simultaneous initializations. */
@@ -259,17 +259,18 @@ unlock:
  * start with a 32 bit number: for the first write this must be
  * LHREQ_INITIALIZE to set up the Guest.  After that the Launcher can use
  * writes of other values to get DMA buffers and send interrupts. */
-static ssize_t write(struct file *file, const char __user *input,
+static ssize_t write(struct file *file, const char __user *in,
 		     size_t size, loff_t *off)
 {
 	/* Once the guest is initialized, we hold the "struct lguest" in the
 	 * file private data. */
 	struct lguest *lg = file->private_data;
-	u32 req;
+	const unsigned long __user *input = (const unsigned long __user *)in;
+	unsigned long req;
 
 	if (get_user(req, input) != 0)
 		return -EFAULT;
-	input += sizeof(req);
+	input++;
 
 	/* If you haven't initialized, you must do that first. */
 	if (req != LHREQ_INITIALIZE && !lg)
@@ -285,13 +286,13 @@ static ssize_t write(struct file *file, 
 
 	switch (req) {
 	case LHREQ_INITIALIZE:
-		return initialize(file, (const u32 __user *)input);
+		return initialize(file, input);
 	case LHREQ_GETDMA:
-		return user_get_dma(lg, (const u32 __user *)input);
+		return user_get_dma(lg, input);
 	case LHREQ_IRQ:
-		return user_send_irq(lg, (const u32 __user *)input);
+		return user_send_irq(lg, input);
 	case LHREQ_BREAK:
-		return break_guest_out(lg, (const u32 __user *)input);
+		return break_guest_out(lg, input);
 	default:
 		return -EINVAL;
 	}

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
