From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/3] vhost: make default mapping empty by default
Date: Sun, 20 Dec 2009 19:16:32 +0200
Message-ID: <20091220171632.GD31713@redhat.com>
References: <cover.1261329297.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1261329297.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

vhost now validates each region with access_ok in calling process
context before access.  Since this fails on a full 64 bit 1:1 mapping
that vhost had by default, we can't support such a mapping: users will
have to set up a table with real addresses that actually matches their
address space.
Make the default mapping empty.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 33e06bf..2b65d9b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -170,21 +170,14 @@ long vhost_dev_reset_owner(struct vhost_dev *dev)
 {
 	struct vhost_memory *memory;
 
-	/* Restore memory to default 1:1 mapping. */
-	memory = kmalloc(offsetof(struct vhost_memory, regions) +
-			 2 * sizeof *memory->regions, GFP_KERNEL);
+	/* Restore memory to default empty mapping. */
+	memory = kmalloc(offsetof(struct vhost_memory, regions), GFP_KERNEL);
 	if (!memory)
 		return -ENOMEM;
 
 	vhost_dev_cleanup(dev);
 
-	memory->nregions = 2;
-	memory->regions[0].guest_phys_addr = 1;
-	memory->regions[0].userspace_addr = 1;
-	memory->regions[0].memory_size = ~0ULL;
-	memory->regions[1].guest_phys_addr = 0;
-	memory->regions[1].userspace_addr = 0;
-	memory->regions[1].memory_size = 1;
+	memory->nregions = 0;
 	dev->memory = memory;
 	return 0;
 }
-- 
1.6.6.rc1.43.gf55cc
