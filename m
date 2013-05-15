From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch -resend] xen/privcmd: fix condition in privcmd_close()
Date: Wed, 15 May 2013 09:56:24 +0300
Message-ID: <20130515065624.GA20381@elgon.mountain>
References: <20121105064217.GA26179@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121105064217.GA26179@elgon.mountain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The parenthesis are in the wrong place so the original code is
equivalent to:

	if (!xen_feature(0x1)) { ...
Or:
        if (!xen_feature(XENFEAT_writable_descriptor_tables)) { ...

Which obviously was not intended.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I sent this last November but it was never merged.

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index ca2b00e..2cfc24d 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -504,7 +504,7 @@ static void privcmd_close(struct vm_area_struct *vma)
 	struct page **pages = vma->vm_private_data;
 	int numpgs = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 
-	if (!xen_feature(XENFEAT_auto_translated_physmap || !numpgs || !pages))
+	if (!xen_feature(XENFEAT_auto_translated_physmap) || !numpgs || !pages)
 		return;
 
 	xen_unmap_domain_mfn_range(vma, numpgs, pages);
