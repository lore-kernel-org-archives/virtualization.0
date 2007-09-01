From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Fix preemptible lazy mode bug
Date: Sat, 01 Sep 2007 14:09:43 -0700
Message-ID: <46D9D517.6010201@goop.org>
References: <46CE70C8.2030005@vmware.com> <46CE8069.9070404@goop.org> <46CE81DC.90103@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758212AbXIAVJ7@vger.kernel.org>
In-Reply-To: <46CE81DC.90103@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, stable@kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andi Kleen <ak@suse.de>Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Do you agree it is better to be safe than sorry in this case?  The
> kind of bugs introduced by getting this wrong are really hard to find,
> and I would rather err on the side of an extra increment and decrement
> of preempt_count that causing a regression.

I think this patch is the direction we should go.  I this this would
work equally well for the other pv implementations; it would probably go
into the common lazy mode logic when we get around to doing it.

    J

diff -r b3fcc228c531 arch/i386/xen/enlighten.c
--- a/arch/i386/xen/enlighten.c	Mon Aug 20 14:20:15 2007 -0700
+++ b/arch/i386/xen/enlighten.c	Mon Aug 27 13:40:24 2007 -0700
@@ -250,6 +250,9 @@ static void xen_halt(void)
 
 static void xen_set_lazy_mode(enum paravirt_lazy_mode mode)
 {
+	if (preemptible() && mode == PARAVIRT_LAZY_FLUSH)
+		return;		/* nothing to flush with preempt on */
+
 	BUG_ON(preemptible());
 
 	switch (mode) {
