From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 3/3] xen/privcmd: remove const modifier from declaration
Date: Sat, 8 Sep 2012 12:58:08 +0300
Message-ID: <20120908095808.GC608@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andres Lagar-Cavilla <andreslc@gridcentric.ca>
Cc: kernel-janitors@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

When we use this pointer, we cast away the const modifier and modify the
data.  I think it was an accident to declare it as const.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/include/xen/privcmd.h b/include/xen/privcmd.h
index a853168..58ed953 100644
--- a/include/xen/privcmd.h
+++ b/include/xen/privcmd.h
@@ -69,7 +69,7 @@ struct privcmd_mmapbatch_v2 {
 	unsigned int num; /* number of pages to populate */
 	domid_t dom;      /* target domain */
 	__u64 addr;       /* virtual address */
-	const xen_pfn_t __user *arr; /* array of mfns */
+	xen_pfn_t __user *arr; /* array of mfns */
 	int __user *err;  /* array of error codes */
 };
 
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 0ce006a..fceb83e 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -389,7 +389,7 @@ static long privcmd_ioctl_mmap_batch(void __user *udata, int version)
 
 	if (state.global_error && (version == 1)) {
 		/* Write back errors in second pass. */
-		state.user_mfn = (xen_pfn_t *)m.arr;
+		state.user_mfn = m.arr;
 		state.err      = err_array;
 		ret = traverse_pages(m.num, sizeof(xen_pfn_t),
 				     &pagelist, mmap_return_errors_v1, &state);
