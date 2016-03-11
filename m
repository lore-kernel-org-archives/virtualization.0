From: Minchan Kim <minchan@kernel.org>
Subject: [PATCH v1 03/19] fs/anon_inodes: new interface to create new inode
Date: Fri, 11 Mar 2016 16:30:07 +0900
Message-ID: <1457681423-26664-4-git-send-email-minchan__10800.8491959938$1457682352$gmane$org@kernel.org>
References: <1457681423-26664-1-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1457681423-26664-1-git-send-email-minchan@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gurugio@hanmail.net>, koct9i@gmail.com, jlayton@poochiereds.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Gioh Kim <gurugio@hanmail.net>

The anon_inodes has already complete interfaces to create manage
many anonymous inodes but don't have interface to get
new inode. Other sub-modules can create anonymous inode
without creating and mounting it's own pseudo filesystem.

Acked-by: Rafael Aquini <aquini@redhat.com>
Signed-off-by: Gioh Kim <gurugio@hanmail.net>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 fs/anon_inodes.c            | 6 ++++++
 include/linux/anon_inodes.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 80ef38c73e5a..1d51f96acdd9 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -162,6 +162,12 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
 }
 EXPORT_SYMBOL_GPL(anon_inode_getfd);
 
+struct inode *anon_inode_new(void)
+{
+	return alloc_anon_inode(anon_inode_mnt->mnt_sb);
+}
+EXPORT_SYMBOL_GPL(anon_inode_new);
+
 static int __init anon_inode_init(void)
 {
 	anon_inode_mnt = kern_mount(&anon_inode_fs_type);
diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
index 8013a45242fe..ddbd67f8a73f 100644
--- a/include/linux/anon_inodes.h
+++ b/include/linux/anon_inodes.h
@@ -15,6 +15,7 @@ struct file *anon_inode_getfile(const char *name,
 				void *priv, int flags);
 int anon_inode_getfd(const char *name, const struct file_operations *fops,
 		     void *priv, int flags);
+struct inode *anon_inode_new(void);
 
 #endif /* _LINUX_ANON_INODES_H */
 
-- 
1.9.1
