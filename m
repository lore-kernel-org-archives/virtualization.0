From: Rafael Aquini <aquini@redhat.com>
Subject: [PATCH v11 2/7] mm: redefine address_space.assoc_mapping
Date: Wed,  7 Nov 2012 01:05:49 -0200
Message-ID: <b6cc6e80a47d500e23499c85adba6cd8e1246874.1352256086.git.aquini__11348.9358489916$1352257634$gmane$org@redhat.com>
References: <cover.1352256081.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1352256081.git.aquini@redhat.com>
In-Reply-To: <cover.1352256081.git.aquini@redhat.com>
References: <cover.1352256081.git.aquini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-mm@kvack.org
Cc: Rik van Riel <riel@redhat.com>, aquini@redhat.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Minchan Kim <minchan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch overhauls struct address_space.assoc_mapping renaming it to
address_space.private_data and its type is redefined to void*.
By this approach we consistently name the .private_* elements from
struct address_space as well as allow extended usage for address_space
association with other data structures through ->private_data.

Also, all users of old ->assoc_mapping element are converted to reflect
its new name and type change.

Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 fs/buffer.c        | 12 ++++++------
 fs/gfs2/glock.c    |  2 +-
 fs/inode.c         |  2 +-
 fs/nilfs2/page.c   |  2 +-
 include/linux/fs.h |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b5f0442..e0bad95 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -555,7 +555,7 @@ void emergency_thaw_all(void)
  */
 int sync_mapping_buffers(struct address_space *mapping)
 {
-	struct address_space *buffer_mapping = mapping->assoc_mapping;
+	struct address_space *buffer_mapping = mapping->private_data;
 
 	if (buffer_mapping == NULL || list_empty(&mapping->private_list))
 		return 0;
@@ -588,10 +588,10 @@ void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 	struct address_space *buffer_mapping = bh->b_page->mapping;
 
 	mark_buffer_dirty(bh);
-	if (!mapping->assoc_mapping) {
-		mapping->assoc_mapping = buffer_mapping;
+	if (!mapping->private_data) {
+		mapping->private_data = buffer_mapping;
 	} else {
-		BUG_ON(mapping->assoc_mapping != buffer_mapping);
+		BUG_ON(mapping->private_data != buffer_mapping);
 	}
 	if (!bh->b_assoc_map) {
 		spin_lock(&buffer_mapping->private_lock);
@@ -788,7 +788,7 @@ void invalidate_inode_buffers(struct inode *inode)
 	if (inode_has_buffers(inode)) {
 		struct address_space *mapping = &inode->i_data;
 		struct list_head *list = &mapping->private_list;
-		struct address_space *buffer_mapping = mapping->assoc_mapping;
+		struct address_space *buffer_mapping = mapping->private_data;
 
 		spin_lock(&buffer_mapping->private_lock);
 		while (!list_empty(list))
@@ -811,7 +811,7 @@ int remove_inode_buffers(struct inode *inode)
 	if (inode_has_buffers(inode)) {
 		struct address_space *mapping = &inode->i_data;
 		struct list_head *list = &mapping->private_list;
-		struct address_space *buffer_mapping = mapping->assoc_mapping;
+		struct address_space *buffer_mapping = mapping->private_data;
 
 		spin_lock(&buffer_mapping->private_lock);
 		while (!list_empty(list)) {
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index e6c2fd5..0f22d09 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -768,7 +768,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 		mapping->host = s->s_bdev->bd_inode;
 		mapping->flags = 0;
 		mapping_set_gfp_mask(mapping, GFP_NOFS);
-		mapping->assoc_mapping = NULL;
+		mapping->private_data = NULL;
 		mapping->backing_dev_info = s->s_bdi;
 		mapping->writeback_index = 0;
 	}
diff --git a/fs/inode.c b/fs/inode.c
index b03c719..4cac8e1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -165,7 +165,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	mapping->host = inode;
 	mapping->flags = 0;
 	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
-	mapping->assoc_mapping = NULL;
+	mapping->private_data = NULL;
 	mapping->backing_dev_info = &default_backing_dev_info;
 	mapping->writeback_index = 0;
 
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 3e7b2a0..07f76db 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -431,7 +431,7 @@ void nilfs_mapping_init(struct address_space *mapping, struct inode *inode,
 	mapping->host = inode;
 	mapping->flags = 0;
 	mapping_set_gfp_mask(mapping, GFP_NOFS);
-	mapping->assoc_mapping = NULL;
+	mapping->private_data = NULL;
 	mapping->backing_dev_info = bdi;
 	mapping->a_ops = &empty_aops;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b33cfc9..0982565 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -418,7 +418,7 @@ struct address_space {
 	struct backing_dev_info *backing_dev_info; /* device readahead, etc */
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
-	struct address_space	*assoc_mapping;	/* ditto */
+	void			*private_data;	/* ditto */
 } __attribute__((aligned(sizeof(long))));
 	/*
 	 * On most architectures that alignment is already the case; but
-- 
1.7.11.7
