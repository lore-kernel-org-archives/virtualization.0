From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/3] xen/privcmd: return -EFAULT on error
Date: Sat, 8 Sep 2012 12:57:35 +0300
Message-ID: <20120908095735.GB608@elgon.mountain>
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

__copy_to_user() returns the number of bytes remaining to be copied but
we want to return a negative error code here.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index fdff8f9..0ce006a 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -393,8 +393,11 @@ static long privcmd_ioctl_mmap_batch(void __user *udata, int version)
 		state.err      = err_array;
 		ret = traverse_pages(m.num, sizeof(xen_pfn_t),
 				     &pagelist, mmap_return_errors_v1, &state);
-	} else if (version == 2)
+	} else if (version == 2) {
 		ret = __copy_to_user(m.err, err_array, m.num * sizeof(int));
+		if (ret)
+			ret = -EFAULT;
+	}
 
 	/* If we have not had any EFAULT-like global errors then set the global
 	 * error to -ENOENT if necessary. */
