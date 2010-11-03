From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/3] VIDEO: xen-fb, switch to for_each_console
Date: Wed,  3 Nov 2010 16:28:34 +0100
Message-ID: <1288798114-23206-3-git-send-email-jslaby@suse.cz>
References: <1288798114-23206-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1288798114-23206-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, jirislaby@gmail.com, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, linux-fbdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Use newly added for_each_console for iterating consoles.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: virtualization@lists.osdl.org
Cc: xen-devel@lists.xensource.com
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/xen-fbfront.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
index 428d273..4abb0b9 100644
--- a/drivers/video/xen-fbfront.c
+++ b/drivers/video/xen-fbfront.c
@@ -492,7 +492,7 @@ xenfb_make_preferred_console(void)
 		return;
 
 	acquire_console_sem();
-	for (c = console_drivers; c; c = c->next) {
+	for_each_console(c) {
 		if (!strcmp(c->name, "tty") && c->index == 0)
 			break;
 	}
-- 
1.7.3.1
