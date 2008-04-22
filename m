From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 2/3] xen: add missing definitions in
	include/xen/interface/memory.h which ia64/xen needs
Date: Tue, 22 Apr 2008 16:00:05 +0900
Message-ID: <12088476061733-git-send-email-yamahata__36289.6569808528$1208848116$gmane$org@valinux.co.jp>
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

Add xen handles realted definitions for xen memory which ia64/xen needs.
Pointer argumsnts for ia64/xen hypercall are passed in pseudo physical
address (guest physical address) so that it is required to convert
guest kernel virtual address into pseudo physical address.
The xen guest handle represents such arguments.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/xen/interface/memory.h |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/xen/interface/memory.h b/include/xen/interface/memory.h
index da76846..af36ead 100644
--- a/include/xen/interface/memory.h
+++ b/include/xen/interface/memory.h
@@ -29,7 +29,7 @@ struct xen_memory_reservation {
      *   OUT: GMFN bases of extents that were allocated
      *   (NB. This command also updates the mach_to_phys translation table)
      */
-    ulong extent_start;
+    GUEST_HANDLE(ulong) extent_start;
 
     /* Number of extents, and size/alignment of each (2^extent_order pages). */
     unsigned long  nr_extents;
@@ -50,6 +50,7 @@ struct xen_memory_reservation {
     domid_t        domid;
 
 };
+DEFINE_GUEST_HANDLE_STRUCT(xen_memory_reservation);
 
 /*
  * Returns the maximum machine frame number of mapped RAM in this system.
@@ -85,7 +86,7 @@ struct xen_machphys_mfn_list {
      * any large discontiguities in the machine address space, 2MB gaps in
      * the machphys table will be represented by an MFN base of zero.
      */
-    ulong extent_start;
+    GUEST_HANDLE(ulong) extent_start;
 
     /*
      * Number of extents written to the above array. This will be smaller
@@ -93,6 +94,7 @@ struct xen_machphys_mfn_list {
      */
     unsigned int nr_extents;
 };
+DEFINE_GUEST_HANDLE_STRUCT(xen_machphys_mfn_list);
 
 /*
  * Sets the GPFN at which a particular page appears in the specified guest's
@@ -115,6 +117,7 @@ struct xen_add_to_physmap {
     /* GPFN where the source mapping page should appear. */
     unsigned long gpfn;
 };
+DEFINE_GUEST_HANDLE_STRUCT(xen_add_to_physmap);
 
 /*
  * Translates a list of domain-specific GPFNs into MFNs. Returns a -ve error
@@ -129,13 +132,14 @@ struct xen_translate_gpfn_list {
     unsigned long nr_gpfns;
 
     /* List of GPFNs to translate. */
-    ulong gpfn_list;
+    GUEST_HANDLE(ulong) gpfn_list;
 
     /*
      * Output list to contain MFN translations. May be the same as the input
      * list (in which case each input GPFN is overwritten with the output MFN).
      */
-    ulong mfn_list;
+    GUEST_HANDLE(ulong) mfn_list;
 };
+DEFINE_GUEST_HANDLE_STRUCT(xen_translate_gpfn_list);
 
 #endif /* __XEN_PUBLIC_MEMORY_H__ */
-- 
1.5.3
