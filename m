From: Haogang Chen <haogangchen@gmail.com>
Subject: [PATCH] XEN: xenbus: integer overflow in process_msg()
Date: Tue,  3 Jan 2012 14:42:11 -0500
Message-ID: <1325619731-13936-1-git-send-email-haogangchen__2438.21249246157$1325623494$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Ian Campbell <Ian.Campbell@citrix.com>
Cc: Haogang Chen <haogangchen@gmail.com>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

There is a potential integer overflow in process_msg() that could result
in cross-domain attack.

	body = kmalloc(msg->hdr.len + 1, GFP_NOIO | __GFP_HIGH);

When a malicious guest passes 0xffffffff in msg->hdr.len, the subsequent
call to xb_read() would write to a zero-length buffer. This causes
kernel oops in the receiving guest and hangs its xenbus kernel thread.
The patch returns -EINVAL in that case.

Signed-off-by: Haogang Chen <haogangchen@gmail.com>
---
 drivers/xen/xenbus/xenbus_xs.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index ede860f..e32aefb 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -801,6 +801,12 @@ static int process_msg(void)
 		goto out;
 	}
 
+	if (msg->hdr.len == UINT_MAX) {
+		kfree(msg);
+		err = -EINVAL;
+		goto out;
+	}
+
 	body = kmalloc(msg->hdr.len + 1, GFP_NOIO | __GFP_HIGH);
 	if (body == NULL) {
 		kfree(msg);
-- 
1.7.5.4
