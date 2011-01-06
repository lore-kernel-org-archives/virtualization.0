From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/36] VIDEO: xen-fb, switch to for_each_console
Date: Thu,  6 Jan 2011 14:22:59 -0800
Message-ID: <1294352605-31906-10-git-send-email-gregkh@suse.de>
References: <20110106215404.GA30624@kroah.com>
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20110106215404.GA30624@kroah.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@xensource.com>, Greg Kroah-Hartman <gregkh@suse.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

From: Jiri Slaby <jslaby@suse.cz>

Use newly added for_each_console for iterating consoles.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: virtualization@lists.osdl.org
Cc: xen-devel@lists.xensource.com
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
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
1.7.3.2
