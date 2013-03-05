From: Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v1 01/33] mm: introduce common help functions to deal with
	reserved/managed pages
Date: Tue,  5 Mar 2013 22:54:44 +0800
Message-ID: <1362495317-32682-2-git-send-email-jiang.liu__35014.9527927444$1362502359$gmane$org@huawei.com>
References: <1362495317-32682-1-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362495317-32682-1-git-send-email-jiang.liu@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Aurelien Jacquiot <a-jacquiot@ti.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Tang Chen <tangchen@cn.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Sam Ravnborg <sam@ravnborg.org>, Lennox Wu <lennox.wu@gmail.com>, Maciej Rutecki <maciej.rutecki@gmail.com>, Jonas Bonn <jonas@southpole.se>, Mark Salter <msalter@redhat.com>, Michel Lespinasse <walken@google.com>, Mikael Starvik <starvik@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Ingo
List-Id: virtualization@lists.linuxfoundation.org

Code to deal with reserved/managed pages are duplicated by many
architectures, so introduce common help functions to reduce duplicated
code. These common help functions will also be used to concentrate code
to modify totalram_pages and zone->managed_pages, which makes the code
much more clear.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 include/linux/mm.h |   37 +++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c    |   20 ++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7acc9dc..881461c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1295,6 +1295,43 @@ extern void free_area_init_node(int nid, unsigned long * zones_size,
 		unsigned long zone_start_pfn, unsigned long *zholes_size);
 extern void free_initmem(void);
 
+/* Help functions to deal with reserved/managed pages. */
+extern unsigned long free_reserved_area(unsigned long start, unsigned long end,
+					int poison, char *s);
+
+static inline void adjust_managed_page_count(struct page *page, long count)
+{
+	totalram_pages += count;
+}
+
+static inline void __free_reserved_page(struct page *page)
+{
+	ClearPageReserved(page);
+	init_page_count(page);
+	__free_page(page);
+}
+
+static inline void free_reserved_page(struct page *page)
+{
+	__free_reserved_page(page);
+	adjust_managed_page_count(page, 1);
+}
+
+static inline void mark_page_reserved(struct page *page)
+{
+	SetPageReserved(page);
+	adjust_managed_page_count(page, -1);
+}
+
+static inline void free_initmem_default(int poison)
+{
+	extern char __init_begin[], __init_end[];
+
+	free_reserved_area(PAGE_ALIGN((unsigned long)&__init_begin) ,
+			   ((unsigned long)&__init_end) & PAGE_MASK,
+			   poison, "unused kernel");
+}
+
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 /*
  * With CONFIG_HAVE_MEMBLOCK_NODE_MAP set, an architecture may initialise its
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8fcced7..0fadb09 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5113,6 +5113,26 @@ early_param("movablecore", cmdline_parse_movablecore);
 
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
+unsigned long free_reserved_area(unsigned long start, unsigned long end,
+				 int poison, char *s)
+{
+	unsigned long pages, pos;
+
+	pos = start = PAGE_ALIGN(start);
+	end &= PAGE_MASK;
+	for (pages = 0; pos < end; pos += PAGE_SIZE, pages++) {
+		if (poison)
+			memset((void *)pos, poison, PAGE_SIZE);
+		free_reserved_page(virt_to_page(pos));
+	}
+
+	if (pages && s)
+		pr_info("Freeing %s memory: %ldK (%lx - %lx)\n",
+			s, pages << (PAGE_SHIFT - 10), start, end);
+
+	return pages;
+}
+
 /**
  * set_dma_reserve - set the specified number of pages reserved in the first zone
  * @new_dma_reserve: The number of pages to mark reserved
-- 
1.7.9.5
