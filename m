From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 04/21] Xen-paravirt:
	===================================================================
Date: Thu, 15 Feb 2007 18:24:53 -0800
Message-ID: <20070216022530.755967483@goop.org>
References: <20070216022449.739760547@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=fix-vmi-types.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@muc.de>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

-static void vmi_set_pte_present(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
+static void vmi_set_pte_present(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pte)
 {
 	vmi_check_page_type(__pa(ptep) >> PAGE_SHIFT, VMI_PAGE_PTE);
 	vmi_ops.set_pte(pte, ptep, vmi_flags_addr_defer(mm, addr, VMI_PAGE_PT, 1));
@@ -492,7 +492,7 @@ static void vmi_set_pud(pud_t *pudp, pud
 	vmi_ops.set_pte(pte, (pte_t *)pudp, VMI_PAGE_PDP);
 }
 
-static void vmi_pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+static void vmi_pte_clear(struct mm_struct *mm, u32 addr, pte_t *ptep)
 {
 	const pte_t pte = { 0 };
 	vmi_check_page_type(__pa(ptep) >> PAGE_SHIFT, VMI_PAGE_PTE);

-- 
