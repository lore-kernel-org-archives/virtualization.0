From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 03/28] ia64/xen: increase IA64_MAX_RSVD_REGIONS.
Date: Fri, 22 Feb 2008 15:02:30 +0900
Message-ID: <20080222060230.GB16685%yamahata__49792.444081004$1203660374$gmane$org@valinux.co.jp>
References: <12036570473924-git-send-email-yamahata@valinux.co.jp>
	<12036570474112-git-send-email-yamahata@valinux.co.jp>
	<20080222053316.GL11391@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080222053316.GL11391@sgi.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Robin Holt <holt@sgi.com>
Cc: virtualization@lists.linux-foundation.org, linux-ia64@vger.kernel.org, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 21, 2008 at 11:33:16PM -0600, Robin Holt wrote:
> On Fri, Feb 22, 2008 at 02:10:19PM +0900, Isaku Yamahata wrote:
> > Xenlinux/ia64 needs to reserve one more region passed from xen hypervisor
> > as start info.
> > 
> > Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
> > ---
> >  include/asm-ia64/meminit.h |    7 +++++++
> >  1 files changed, 7 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/asm-ia64/meminit.h b/include/asm-ia64/meminit.h
> > index f93308f..7c12c08 100644
> > --- a/include/asm-ia64/meminit.h
> > +++ b/include/asm-ia64/meminit.h
> > @@ -18,10 +18,17 @@
> >   * 	- crash dumping code reserved region
> >   * 	- Kernel memory map built from EFI memory map
> >   * 	- ELF core header
> > + * ifdef CONFIG_XEN
> > + *	- xen start info
> > + * endif
> >   *
> >   * More could be added if necessary
> >   */
> > +#ifdef CONFIG_XEN
> >  #define IA64_MAX_RSVD_REGIONS 8
> > +#else
> > +#define IA64_MAX_RSVD_REGIONS 9
> > +#endif
> 
> This one seems upside down to me.  You are saying there is an additional
> region when CONFIG_XEN, but you are defining it larger for !CONFIG_XEN.
> I concede the point that I know nothing about Xen, so please straighten
> me out here.

Thank you for review. You're absolutely correct.

---
ia64/xen: increase IA64_MAX_RSVD_REGIONS.

Xenlinux/ia64 needs to reserve one more region passed from xen hypervisor
as start info.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/meminit.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/asm-ia64/meminit.h b/include/asm-ia64/meminit.h
index f93308f..3de9c74 100644
--- a/include/asm-ia64/meminit.h
+++ b/include/asm-ia64/meminit.h
@@ -18,10 +18,17 @@
  * 	- crash dumping code reserved region
  * 	- Kernel memory map built from EFI memory map
  * 	- ELF core header
+ * ifdef CONFIG_XEN
+ *	- xen start info
+ * endif
  *
  * More could be added if necessary
  */
+#ifndef CONFIG_XEN
 #define IA64_MAX_RSVD_REGIONS 8
+#else
+#define IA64_MAX_RSVD_REGIONS 9
+#endif
 
 struct rsvd_region {
 	unsigned long start;	/* virtual address of beginning of element */
-- 
1.5.3



-- 
yamahata
