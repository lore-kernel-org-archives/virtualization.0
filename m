From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 3/3] xen: compilation fix to balloon driver for ia64 support.
Date: Tue, 22 Apr 2008 16:00:06 +0900
Message-ID: <12088476063546-git-send-email-yamahata__13900.1242387623$1208848115$gmane$org@valinux.co.jp>
References: <12088476062604-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12088476062604-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jeremy@goop.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, eddie.dong@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

fix compilation error of ballon driver on ia64.
extent_start member is pointer argument. On x86 pointer argument for
xen hypercall is passed as virtual address.
On the other hand, ia64 and ppc, pointer argument is passed in pseudo
physical address. (guest physicall address.)
So they must be passed as handle and convert right before issuing hypercall.

  CC      drivers/xen/balloon.o
linux-2.6-x86/drivers/xen/balloon.c: In function 'increase_reservation':
linux-2.6-x86/drivers/xen/balloon.c:228: error: incompatible types in assignment
linux-2.6-x86/drivers/xen/balloon.c: In function 'decrease_reservation':
linux-2.6-x86/drivers/xen/balloon.c:324: error: incompatible types in assignment
linux-2.6-x86/drivers/xen/balloon.c: In function 'dealloc_pte_fn':
linux-2.6-x86/drivers/xen/balloon.c:486: error: incompatible types in assignment
linux-2.6-x86/drivers/xen/balloon.c: In function 'alloc_empty_pages_and_pagevec':
linux-2.6-x86/drivers/xen/balloon.c:522: error: incompatible types in assignment
make[2]: *** [drivers/xen/balloon.o] Error 1

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 drivers/xen/balloon.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index ab25ba6..097ba02 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -225,7 +225,7 @@ static int increase_reservation(unsigned long nr_pages)
 		page = balloon_next_page(page);
 	}
 
-	reservation.extent_start = (unsigned long)frame_list;
+	set_xen_guest_handle(reservation.extent_start, frame_list);
 	reservation.nr_extents   = nr_pages;
 	rc = HYPERVISOR_memory_op(
 		XENMEM_populate_physmap, &reservation);
@@ -321,7 +321,7 @@ static int decrease_reservation(unsigned long nr_pages)
 		balloon_append(pfn_to_page(pfn));
 	}
 
-	reservation.extent_start = (unsigned long)frame_list;
+	set_xen_guest_handle(reservation.extent_start, frame_list);
 	reservation.nr_extents   = nr_pages;
 	ret = HYPERVISOR_memory_op(XENMEM_decrease_reservation, &reservation);
 	BUG_ON(ret != nr_pages);
@@ -483,7 +483,7 @@ static int dealloc_pte_fn(
 		.extent_order = 0,
 		.domid        = DOMID_SELF
 	};
-	reservation.extent_start = (unsigned long)&mfn;
+	set_xen_guest_handle(reservation.extent_start, &mfn);
 	set_pte_at(&init_mm, addr, pte, __pte_ma(0ull));
 	set_phys_to_machine(__pa(addr) >> PAGE_SHIFT, INVALID_P2M_ENTRY);
 	ret = HYPERVISOR_memory_op(XENMEM_decrease_reservation, &reservation);
@@ -519,7 +519,7 @@ static struct page **alloc_empty_pages_and_pagevec(int nr_pages)
 				.extent_order = 0,
 				.domid        = DOMID_SELF
 			};
-			reservation.extent_start = (unsigned long)&gmfn;
+			set_xen_guest_handle(reservation.extent_start, &gmfn);
 			ret = HYPERVISOR_memory_op(XENMEM_decrease_reservation,
 						   &reservation);
 			if (ret == 1)
-- 
1.5.3
