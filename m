From: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] input: Fix interrupt enable in i8042_ctr when enabling
	interrupt fails
Date: Mon, 10 Sep 2007 14:41:34 +0200
Message-ID: <877imy7kw1.fsf__22082.5207340114$1189462670$gmane$org@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: Dmitry Torokhov <dtor@mail.ru>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When enabling interrupts fails, the interrupt enable bit remains set
in i8042_ctr.  Later writes of i8042_ctr to the hardware could
accidentally retry enabling interrupts.  Clear the bit on failure.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Steven Rostedt <rostedt@goodmis.org>

---
Some time ago Steven Rostedt and I went over this changeset:

    commit de9ce703c6b807b1dfef5942df4f2fadd0fdb67a
    Author: Dmitry Torokhov <dtor@insightbb.com>
    Date:   Sun Sep 10 21:57:21 2006 -0400

        Input: i8042 - get rid of polling timer

        Remove polling timer that was used to detect keybord/mice hotplug and
        register both IRQs right away instead of waiting for a driver to
        attach to a port.

        Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Steven pointed out to me that it changes behavior when enabling IRQ
fails.

The old code enabled IRQs this way:

	i8042_ctr |= port->irqen;

	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
		i8042_ctr &= ~port->irqen;
		return -1;
	}

i8042_ctr shadows the 8042's CTR.  So, when enabling fails, the bit is
cleared in the shadow.

The new code does not clear the bit on the error path:

static int i8042_enable_kbd_port(void)
{
	i8042_ctr &= ~I8042_CTR_KBDDIS;
	i8042_ctr |= I8042_CTR_KBDINT;

	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
		printk(KERN_ERR "i8042.c: Failed to enable KBD port.\n");
		return -EIO;
	}

	return 0;
}

Same for i8042_enable_aux_port().

This leads to the question whether there are later writes of i8042_ctr
(possibly with other bits altered) to the hardware, which could
accidentally retry enabling interrupts.

I believe this possible, but unlikely (perhaps not so unlikely on
virtual machines).  Scenarios involve enable succeeding the first
time, failing the second time, and succeeding the third time.  I can
provide details, but the point I'd like to make is not that this is
broken (although it is, strictly speaking), but that it is not
obviously correct where it easily could be: just clear the interrupt
enable bits when writing them to the hardware failed, like the old
code did.

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index db9cca3..71a7e39 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -385,6 +385,7 @@ static int i8042_enable_kbd_port(void)
 	i8042_ctr |= I8042_CTR_KBDINT;
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+		i8042_ctr &= ~I8042_CTR_KBDINT;
 		printk(KERN_ERR "i8042.c: Failed to enable KBD port.\n");
 		return -EIO;
 	}
@@ -402,6 +403,7 @@ static int i8042_enable_aux_port(void)
 	i8042_ctr |= I8042_CTR_AUXINT;
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+		i8042_ctr &= ~I8042_CTR_AUXINT;
 		printk(KERN_ERR "i8042.c: Failed to enable AUX port.\n");
 		return -EIO;
 	}
