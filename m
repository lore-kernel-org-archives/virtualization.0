From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 1/3 v2] hvc_console: rework setup to replace irq functions with callbacks
Date: Fri, 27 Jun 2008 15:27:51 +1000
Message-ID: <200806271527.52321.rusty@rustcorp.com.au>
References: <200806031444.21945.borntraeger@de.ibm.com> <200806201524.08237.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755737AbYF0F2M@vger.kernel.org>
In-Reply-To: <200806201524.08237.borntraeger@de.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Linux PPC devel <linuxppc-dev@ozlabs.org>, Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Yajin <zyj001et@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 20 June 2008 23:24:08 Christian Borntraeger wrote:
> I also kept hvc_struct defined in hvc_console.h so that hvc_irq.c can
> access the irq_requested element.

Added this fix:

=46ix compile of hvc_rtas.c

Moving the struct definition out to the header had bad effect under one
ppc64 config that I tried:

drivers/char/hvc_console.h:59: error: field =E2=80=98kref=E2=80=99 has =
incomplete type

So move the include of kref.h too.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r f382d8f562a8 drivers/char/hvc_console.c
--- a/drivers/char/hvc_console.c	Fri Jun 27 15:17:49 2008 +1000
+++ b/drivers/char/hvc_console.c	Fri Jun 27 15:24:15 2008 +1000
@@ -27,7 +27,6 @@
 #include <linux/init.h>
 #include <linux/kbd_kern.h>
 #include <linux/kernel.h>
-#include <linux/kref.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
 #include <linux/module.h>
diff -r f382d8f562a8 drivers/char/hvc_console.h
--- a/drivers/char/hvc_console.h	Fri Jun 27 15:17:49 2008 +1000
+++ b/drivers/char/hvc_console.h	Fri Jun 27 15:24:15 2008 +1000
@@ -26,6 +26,7 @@
=20
 #ifndef HVC_CONSOLE_H
 #define HVC_CONSOLE_H
+#include <linux/kref.h>
=20
 /*
  * This is the max number of console adapters that can/will be found a=
s
