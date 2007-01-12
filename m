From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Oops
Date: Fri, 12 Jan 2007 09:24:49 +0100
Message-ID: <45A745D1.3060709@suse.de>
References: <45A399D7.3090205@suse.de> <45A41B60.3070500@goop.org>
	<45A4A0C7.5050405@suse.de> <45A4C014.9030909@suse.de>
	<45A4E4A0.5060800@suse.de>
	<20070110235232.GE19575@sequoia.sous-sol.org>
	<45A65B7C.6050503@suse.de>
	<20070111174145.GR10475@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080807050602010902030003"
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070111174145.GR10475@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------080807050602010902030003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Chris Wright wrote:
> * Gerd Hoffmann (kraxel@suse.de) wrote:
>> Chris Wright wrote:
>>> This should not be needed, the console should be xcv0, completely decoupled
>>> from serial.
>> You've made the whole thing even more complicated with the last commit.
>> Enabling VT is possible now.  Good.  No way around that.  The kernel
>> hangs now though.  Fix is attached:  better don't try to setup the vga
>> console for xen guests which don't have the hardware.
> 
> I'm not really sure what, the last commit I did was lhype?

Oh, sorry, was jeremy, wrong line in "hg view" ...

>> Next problem:  The default for xencons (tty) conflicts with the virtual
>> consoles.  I'm tempted to drop the complete xencons=foobar stuff into
>> the waste basket and leave in xencons=xvc only.  And maybe xencons=off.
>>  xencons=tty conflicts with the VT subsystem.  xencons=ttyS conflicts
>> with the serial driver.  Disabling the offending drivers is completely
>> out of question for a kernel which is supposed to work both native and
>> paravirtualized.
> 
> Yes, all of tty ttyS xencons goes away.  Here the default is xvc.

Huh?  It's not yet in the patch paravirt patch queue.  Patch attached.

>> One more issue:  What should be the default console?  Right now it is
>> the vt console (using the dummy device).  Not very good.  vgacon doesn't
>> work.  fbcon doesn't work either (yet).  So you'll end up with a
>> non-functional console by default.  Bummer.
> 
> default console should be xvc in the guest.

Ok, then xen/ must be before char/ in drivers/.  Patch attached.

cheers,
  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>

--------------080807050602010902030003
Content-Type: text/plain;
 name="drop-xencons"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drop-xencons"

Index: paravirt-2.6.20-rc4-hg702/drivers/xen/console/console.c
===================================================================
--- paravirt-2.6.20-rc4-hg702.orig/drivers/xen/console/console.c
+++ paravirt-2.6.20-rc4-hg702/drivers/xen/console/console.c
@@ -61,20 +61,7 @@
 
 MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Modes:
- *  'xencons=off'  [XC_OFF]:     Console is disabled.
- *  'xencons=tty'  [XC_TTY]:     Console attached to '/dev/tty[0-9]+'.
- *  'xencons=ttyS' [XC_SERIAL]:  Console attached to '/dev/ttyS[0-9]+'.
- *  'xencons=xvc'  [XC_XVC]:     Console attached to '/dev/xvc0'.
- *                 [XC_DEFAULT]: DOM0 -> XC_SERIAL ; all others -> XC_TTY.
- * 
- * NB. In mode XC_TTY, we create dummy consoles for tty2-63. This suppresses
- * warnings from standard distro startup scripts.
- */
-static enum {
-	XC_OFF, XC_DEFAULT, XC_TTY, XC_SERIAL, XC_XVC
-} xc_mode = XC_DEFAULT;
+static int xc_disabled = 0;
 static int xc_num = -1;
 
 /* /dev/xvc0 device number allocated by lanana.org. */
@@ -87,27 +74,8 @@ static unsigned long sysrq_requested;
 
 static int __init xencons_setup(char *str)
 {
-	char *q;
-	int n;
-
-	if (!strncmp(str, "ttyS", 4)) {
-		xc_mode = XC_SERIAL;
-		str += 4;
-	} else if (!strncmp(str, "tty", 3)) {
-		xc_mode = XC_TTY;
-		str += 3;
-	} else if (!strncmp(str, "xvc", 3)) {
-		xc_mode = XC_XVC;
-		str += 3;
-	} else if (!strncmp(str, "off", 3)) {
-		xc_mode = XC_OFF;
-		str += 3;
-	}
-
-	n = simple_strtol(str, &q, 10);
-	if (q != str)
-		xc_num = n;
-
+	if (!strcmp(str, "off"))
+		xc_disabled = 1;
 	return 1;
 }
 __setup("xencons=", xencons_setup);
@@ -222,6 +190,7 @@ static struct tty_driver *kcons_device(s
 }
 
 static struct console kcons_info = {
+	.name   = "xvc",
 	.device	= kcons_device,
 	.flags	= CON_PRINTBUFFER | CON_ENABLED,
 	.index	= -1,
@@ -231,42 +200,18 @@ static int __init xen_console_init(void)
 {
 	if (!is_running_on_xen())
 		goto out;
+	if (xc_disabled)
+		goto out;
 
 	if (is_initial_xendomain()) {
-		if (xc_mode == XC_DEFAULT)
-			xc_mode = XC_SERIAL;
 		kcons_info.write = kcons_write_dom0;
 	} else {
 		if (!xen_start_info->console.domU.evtchn)
 			goto out;
-		if (xc_mode == XC_DEFAULT)
-			xc_mode = XC_TTY;
-		kcons_info.flags |= CON_ENABLED;
 		kcons_info.write = kcons_write;
 	}
-
-	switch (xc_mode) {
-	case XC_XVC:
-		strcpy(kcons_info.name, "xvc");
-		if (xc_num == -1)
-			xc_num = 0;
-		break;
-
-	case XC_SERIAL:
-		strcpy(kcons_info.name, "ttyS");
-		if (xc_num == -1)
-			xc_num = 0;
-		break;
-
-	case XC_TTY:
-		strcpy(kcons_info.name, "tty");
-		if (xc_num == -1)
-			xc_num = 1;
-		break;
-
-	default:
-		goto out;
-	}
+	if (xc_num == -1)
+		xc_num = 0;
 
 	wbuf = alloc_bootmem(wbuf_size);
 
@@ -303,11 +248,9 @@ void xencons_force_flush(void)
 /******************** User-space console driver (/dev/console) ************/
 
 #define DRV(_d)         (_d)
-#define DUMMY_TTY(_tty) ((xc_mode == XC_TTY) &&		\
-			 ((_tty)->index != (xc_num - 1)))
 
-static struct termios *xencons_termios[MAX_NR_CONSOLES];
-static struct termios *xencons_termios_locked[MAX_NR_CONSOLES];
+static struct ktermios *xencons_termios[1];
+static struct ktermios *xencons_termios_locked[1];
 static struct tty_struct *xencons_tty;
 static int xencons_priv_irq;
 static char x_char;
@@ -427,9 +370,6 @@ static void xencons_send_xchar(struct tt
 {
 	unsigned long flags;
 
-	if (DUMMY_TTY(tty))
-		return;
-
 	spin_lock_irqsave(&xencons_lock, flags);
 	x_char = ch;
 	__xencons_tx_flush();
@@ -438,18 +378,12 @@ static void xencons_send_xchar(struct tt
 
 static void xencons_throttle(struct tty_struct *tty)
 {
-	if (DUMMY_TTY(tty))
-		return;
-
 	if (I_IXOFF(tty))
 		xencons_send_xchar(tty, STOP_CHAR(tty));
 }
 
 static void xencons_unthrottle(struct tty_struct *tty)
 {
-	if (DUMMY_TTY(tty))
-		return;
-
 	if (I_IXOFF(tty)) {
 		if (x_char != 0)
 			x_char = 0;
@@ -462,9 +396,6 @@ static void xencons_flush_buffer(struct 
 {
 	unsigned long flags;
 
-	if (DUMMY_TTY(tty))
-		return;
-
 	spin_lock_irqsave(&xencons_lock, flags);
 	wc = wp = 0;
 	spin_unlock_irqrestore(&xencons_lock, flags);
@@ -487,9 +418,6 @@ static int xencons_write(
 	int i;
 	unsigned long flags;
 
-	if (DUMMY_TTY(tty))
-		return count;
-
 	spin_lock_irqsave(&xencons_lock, flags);
 
 	for (i = 0; i < count; i++)
@@ -508,9 +436,6 @@ static void xencons_put_char(struct tty_
 {
 	unsigned long flags;
 
-	if (DUMMY_TTY(tty))
-		return;
-
 	spin_lock_irqsave(&xencons_lock, flags);
 	(void)__xencons_put_char(ch);
 	spin_unlock_irqrestore(&xencons_lock, flags);
@@ -520,9 +445,6 @@ static void xencons_flush_chars(struct t
 {
 	unsigned long flags;
 
-	if (DUMMY_TTY(tty))
-		return;
-
 	spin_lock_irqsave(&xencons_lock, flags);
 	__xencons_tx_flush();
 	spin_unlock_irqrestore(&xencons_lock, flags);
@@ -532,9 +454,6 @@ static void xencons_wait_until_sent(stru
 {
 	unsigned long orig_jiffies = jiffies;
 
-	if (DUMMY_TTY(tty))
-		return;
-
 	while (DRV(tty->driver)->chars_in_buffer(tty)) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
@@ -551,9 +470,6 @@ static int xencons_open(struct tty_struc
 {
 	unsigned long flags;
 
-	if (DUMMY_TTY(tty))
-		return 0;
-
 	spin_lock_irqsave(&xencons_lock, flags);
 	tty->driver_data = NULL;
 	if (xencons_tty == NULL)
@@ -568,9 +484,6 @@ static void xencons_close(struct tty_str
 {
 	unsigned long flags;
 
-	if (DUMMY_TTY(tty))
-		return;
-
 	mutex_lock(&tty_mutex);
 
 	if (tty->count != 1) {
@@ -616,7 +529,7 @@ static int __init xencons_init(void)
 	if (!is_running_on_xen())
 		return -ENODEV;
 
-	if (xc_mode == XC_OFF)
+	if (xc_disabled)
 		return 0;
 
 	if (!is_initial_xendomain()) {
@@ -625,13 +538,14 @@ static int __init xencons_init(void)
 			return rc;
 	}
 
-	xencons_driver = alloc_tty_driver((xc_mode == XC_TTY) ?
-					  MAX_NR_CONSOLES : 1);
+	xencons_driver = alloc_tty_driver(1);
 	if (xencons_driver == NULL)
 		return -ENOMEM;
 
-	DRV(xencons_driver)->name            = "xencons";
-	DRV(xencons_driver)->major           = TTY_MAJOR;
+	DRV(xencons_driver)->name            = "xvc";
+	DRV(xencons_driver)->major           = XEN_XVC_MAJOR;
+	DRV(xencons_driver)->minor_start     = XEN_XVC_MINOR;
+	DRV(xencons_driver)->name_base       = xc_num;
 	DRV(xencons_driver)->type            = TTY_DRIVER_TYPE_SERIAL;
 	DRV(xencons_driver)->subtype         = SERIAL_TYPE_NORMAL;
 	DRV(xencons_driver)->init_termios    = tty_std_termios;
@@ -642,25 +556,6 @@ static int __init xencons_init(void)
 	DRV(xencons_driver)->termios         = xencons_termios;
 	DRV(xencons_driver)->termios_locked  = xencons_termios_locked;
 
-	switch (xc_mode) {
-	case XC_XVC:
-		DRV(xencons_driver)->name        = "xvc";
-		DRV(xencons_driver)->major       = XEN_XVC_MAJOR;
-		DRV(xencons_driver)->minor_start = XEN_XVC_MINOR;
-		DRV(xencons_driver)->name_base   = xc_num;
-		break;
-	case XC_SERIAL:
-		DRV(xencons_driver)->name        = "ttyS";
-		DRV(xencons_driver)->minor_start = 64 + xc_num;
-		DRV(xencons_driver)->name_base   = xc_num;
-		break;
-	default:
-		DRV(xencons_driver)->name        = "tty";
-		DRV(xencons_driver)->minor_start = 1;
-		DRV(xencons_driver)->name_base   = 1;
-		break;
-	}
-
 	tty_set_operations(xencons_driver, &xencons_ops);
 
 	if ((rc = tty_register_driver(DRV(xencons_driver))) != 0) {

--------------080807050602010902030003
Content-Type: text/plain;
 name="console-order"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="console-order"

Index: paravirt-2.6.20-rc4-hg702/drivers/Makefile
===================================================================
--- paravirt-2.6.20-rc4-hg702.orig/drivers/Makefile
+++ paravirt-2.6.20-rc4-hg702/drivers/Makefile
@@ -17,8 +17,8 @@ obj-$(CONFIG_ARM_AMBA)		+= amba/
 
 # char/ comes before serial/ etc so that the VT console is the boot-time
 # default.
-obj-y				+= char/
 obj-$(CONFIG_XEN)		+= xen/
+obj-y				+= char/
 
 obj-$(CONFIG_CONNECTOR)		+= connector/
 

--------------080807050602010902030003
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--------------080807050602010902030003--
