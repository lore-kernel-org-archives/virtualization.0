From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/3] char: virtio: constify attribute_group structures.
Date: Wed,  2 Aug 2017 16:51:08 +0530
Message-ID: <1501672868-3046-1-git-send-email-arvind.yadav.cs__30846.5319023982$1509078880$gmane$org@gmail.com>
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
To: arnd@arndb.de, gregkh@linuxfoundation.org, mark.gross@intel.com, amit@kernel.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

attribute_group are not supposed to change at runtime. All functions
working with attribute_group provided by <linux/sysfs.h> work with
const attribute_group. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index ad843eb..06bd635 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1308,7 +1308,7 @@ static ssize_t show_port_name(struct device *dev,
 	NULL
 };
 
-static struct attribute_group port_attribute_group = {
+static const struct attribute_group port_attribute_group = {
 	.name = NULL,		/* put in device directory */
 	.attrs = port_sysfs_entries,
 };
-- 
1.9.1
