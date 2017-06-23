From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] char: virtio_console: constify port_attribute_group
Date: Fri, 23 Jun 2017 10:26:18 +0530
Message-ID: <ff3036ff4eb284dc67c23d34d839b060abfa5a4a.1498193508.git.arvind.yadav.cs__29730.1816674464$1509078559$gmane$org@gmail.com>
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
To: arnd@arndb.de, gregkh@linuxfoundation.org, amit@kernel.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

File size before:
   text	   data	    bss	    dec	    hex	filename
  13775	    656	     88	  14519	   38b7	drivers/char/virtio_console.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  13839	    592	     88	  14519	   38b7	drivers/char/virtio_console.o

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
