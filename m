From: Vasiliy Kulikov <segooon@gmail.com>
Subject: [PATCH] xen: xenfs: privcmd: check put_user() return code
Date: Thu, 28 Oct 2010 15:39:02 +0400
Message-ID: <1288265942-12581-1-git-send-email-segooon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Ian Campbell <ian.campbell@citrix.com>, xen-devel@lists.xen.org, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

put_user() may fail.  In this case propagate error code from
privcmd_ioctl_mmap_batch().

Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
---
 Compile tested.

 drivers/xen/xenfs/privcmd.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/xenfs/privcmd.c b/drivers/xen/xenfs/privcmd.c
index f80be7f..2eb04c8 100644
--- a/drivers/xen/xenfs/privcmd.c
+++ b/drivers/xen/xenfs/privcmd.c
@@ -266,9 +266,7 @@ static int mmap_return_errors(void *data, void *state)
 	xen_pfn_t *mfnp = data;
 	struct mmap_batch_state *st = state;
 
-	put_user(*mfnp, st->user++);
-
-	return 0;
+	return put_user(*mfnp, st->user++);
 }
 
 static struct vm_operations_struct privcmd_vm_ops;
@@ -323,10 +321,8 @@ static long privcmd_ioctl_mmap_batch(void __user *udata)
 	up_write(&mm->mmap_sem);
 
 	if (state.err > 0) {
-		ret = 0;
-
 		state.user = m.arr;
-		traverse_pages(m.num, sizeof(xen_pfn_t),
+		ret = traverse_pages(m.num, sizeof(xen_pfn_t),
 			       &pagelist,
 			       mmap_return_errors, &state);
 	}
-- 
1.7.0.4
