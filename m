From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v18 01/10] idr: add #include <linux/bug.h>
Date: Wed, 29 Nov 2017 21:55:17 +0800
Message-ID: <1511963726-34070-2-git-send-email-wei.w.wang@intel.com>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: aarcange@redhat.com, yang.zhang.wz@gmail.com, riel@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, willy@infradead.org, amit.shah@redhat.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, nilal@redhat.com, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

The <linux/bug.h> was removed from radix-tree.h by the following commit:
f5bba9d11a256ad2a1c2f8e7fc6aabe6416b7890.

Since that commit, tools/testing/radix-tree/ couldn't pass compilation
due to: tools/testing/radix-tree/idr.c:17: undefined reference to
WARN_ON_ONCE. This patch adds the bug.h header to idr.h to solve the
issue.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
---
 include/linux/idr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 7c3a365..fa14f83 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -15,6 +15,7 @@
 #include <linux/radix-tree.h>
 #include <linux/gfp.h>
 #include <linux/percpu.h>
+#include <linux/bug.h>
 
 struct idr {
 	struct radix_tree_root	idr_rt;
-- 
2.7.4
