From: Andy King <acking@vmware.com>
Subject: [PATCH] VMCI: Fix process-to-process DRGAMs.
Date: Thu,  7 Mar 2013 07:29:08 -0800
Message-ID: <1362670148-27238-1-git-send-email-acking@vmware.com>
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
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, Andy King <acking@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

When sending between processes, we always schedule a work item.  Our work info
struct has the message embedded in the middle, which means that we end up
overwriting subsequent fields when we copy the (variable-length) message into
it.  Move it to the end of the struct.

Acked-by: Dmitry Torokhov <dtor@vmware.com>
Signed-off-by: Andy King <acking@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_datagram.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
index ed5c433..f3cdd90 100644
--- a/drivers/misc/vmw_vmci/vmci_datagram.c
+++ b/drivers/misc/vmw_vmci/vmci_datagram.c
@@ -42,9 +42,11 @@ struct datagram_entry {
 
 struct delayed_datagram_info {
 	struct datagram_entry *entry;
-	struct vmci_datagram msg;
 	struct work_struct work;
 	bool in_dg_host_queue;
+	/* msg and msg_payload must be together. */
+	struct vmci_datagram msg;
+	u8 msg_payload[];
 };
 
 /* Number of in-flight host->host datagrams */
-- 
1.7.4.1
