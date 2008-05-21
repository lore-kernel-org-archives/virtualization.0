From: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 4/5] xen pvfb: Zero unused bytes in events sent to backend
Date: Wed, 21 May 2008 10:40:31 +0200
Message-ID: <871w3wm4n4.fsf__35583.8886615404$1211359465$gmane$org@pike.pond.sub.org>
References: <87d4ngm4s4.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, dmitry.torokhov@gmail.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, Pat Campbell <plc@novell.com>, linux-input@vger.kernel.org, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This isn't a security flaw (the backend can see all our memory
anyway).  But it's the right thing to do all the same.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 drivers/video/xen-fbfront.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
index 5553e51..291eef6 100644
--- a/drivers/video/xen-fbfront.c
+++ b/drivers/video/xen-fbfront.c
@@ -61,6 +61,7 @@ static void xenfb_do_update(struct xenfb_info *info,
 	union xenfb_out_event event;
 	u32 prod;
 
+	memset(&event, 0, sizeof(event));
 	event.type = XENFB_TYPE_UPDATE;
 	event.update.x = x;
 	event.update.y = y;
-- 
1.5.3.3
