From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 07/54] Staging: hv: add a TODO file
Date: Fri, 17 Jul 2009 11:08:57 -0700
Message-ID: <20090717180916.997551681@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=staging-hv-add-a-todo-file.patch
In-Reply-To: <20090720160025.GA20249@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org
Cc: Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Greg Kroah-Hartman <gregkh@suse.de>

First cut at what needs to be done to this codebase.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/hv/TODO |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- /dev/null
+++ b/drivers/staging/hv/TODO
@@ -0,0 +1,15 @@
+TODO:
+	- fix checkpatch warnings/errors
+	- fix sparse issues
+	- remove compatibility layer
+	- fix HANDLE usage to be "real" pointers
+	- audit the vmbus to verify it is working properly with the
+	  driver model
+	- see if the vmbus can be merged with the other virtual busses
+	  in the kernel
+	- audit the network driver
+	- audit the block driver
+	- audit the scsi driver
+
+Please send patches for this code to Greg Kroah-Hartman <gregkh@suse.de>
+and Hank Janssen <hjanssen@microsoft.com>
