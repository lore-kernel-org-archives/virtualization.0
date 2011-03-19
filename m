From: Dan Carpenter <error27@gmail.com>
Subject: [patch 1/2] xen-gntdev: return -EFAULT on copy_to_user failure
Date: Sat, 19 Mar 2011 08:44:34 +0300
Message-ID: <20110319054434.GD2008@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Cc: kernel-janitors@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

copy_to_user() returns the amount of data remaining to be copied.  We
want to return a negative error code here.  The upper layers just
call WARN_ON() if we return non-zero so this doesn't change the
behavior.  But returning -EFAULT is still cleaner.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 017ce60..b0f9e8f 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -273,7 +273,7 @@ static int __unmap_grant_pages(struct grant_map *map, int offset, int pages)
 				map->vma->vm_start + map->notify.addr;
 			err = copy_to_user(tmp, &err, 1);
 			if (err)
-				return err;
+				return -EFAULT;
 			map->notify.flags &= ~UNMAP_NOTIFY_CLEAR_BYTE;
 		} else if (pgno >= offset && pgno < offset + pages) {
 			uint8_t *tmp = kmap(map->pages[pgno]);
