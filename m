From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v2,
	part1 00/29] Use helper functions to simplify memory intialization
	code
Date: Sun, 10 Mar 2013 14:26:43 +0800
Message-ID: <1362896833-21104-1-git-send-email-jiang.liu__10847.9843162515$1362897006$gmane$org@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Aurelien Jacquiot <a-jacquiot@ti.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-snps-arc@vger.kernel.org, Tang Chen <tangchen@cn.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Sam Ravnborg <sam@ravnborg.org>, Lennox Wu <lennox.wu@gmail.com>, Maciej Rutecki <maciej.rutecki@gmail.com>, Jonas Bonn <jonas@southpole.se>, Mark Salter <msalter@redhat.com>, Michel Lespinasse <walken@google.com>, Mikael Starvik <starvik@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>
List-Id: virtualization@lists.linuxfoundation.org

The original goal of this patchset is to fix the bug reported by
https://bugzilla.kernel.org/show_bug.cgi?id=53501
Now it has also been expanded to reduce common code used by memory
initializion.

This is the first part, which applies to v3.9-rc1.

It introduces following common helper functions to simplify
free_initmem() and free_initrd_mem() on different architectures:
adjust_managed_page_count():
	will be used to adjust totalram_pages, totalhigh_pages,
	zone->managed_pages when reserving/unresering a page.
__free_reserved_page():
	free a reserved page into the buddy system without adjusting
	page statistics info
free_reserved_page():
	free a reserved page into the buddy system and adjust page
	statistics info
mark_page_reserved():
	mark a page as reserved and adjust page statistics info
free_reserved_area():
	free a continous ranges of pages by calling free_reserved_page()
free_initmem_default():
	default method to free __init pages.

We have only tested these patchset on x86 platforms, and have done basic
compliation tests using cross-compilers from ftp.kernel.org. That means
some code may not pass compilation on some architectures. So any help
to test this patchset are welcomed!

There are several other parts still under development:
Part2: introduce free_highmem_page() to simplify freeing highmem pages
Part3: refine code to manage totalram_pages, totalhigh_pages and
	zone->managed_pages
Part4: introduce helper functions to simplify mem_init() and remove the
	global variable num_physpages.

Jiang Liu (29):
  mm: introduce common help functions to deal with reserved/managed
    pages
  mm/alpha: use common help functions to free reserved pages
  mm/ARM: use common help functions to free reserved pages
  mm/avr32: use common help functions to free reserved pages
  mm/blackfin: use common help functions to free reserved pages
  mm/c6x: use common help functions to free reserved pages
  mm/cris: use common help functions to free reserved pages
  mm/FRV: use common help functions to free reserved pages
  mm/h8300: use common help functions to free reserved pages
  mm/IA64: use common help functions to free reserved pages
  mm/m32r: use common help functions to free reserved pages
  mm/m68k: use common help functions to free reserved pages
  mm/microblaze: use common help functions to free reserved pages
  mm/MIPS: use common help functions to free reserved pages
  mm/mn10300: use common help functions to free reserved pages
  mm/openrisc: use common help functions to free reserved pages
  mm/parisc: use common help functions to free reserved pages
  mm/ppc: use common help functions to free reserved pages
  mm/s390: use common help functions to free reserved pages
  mm/score: use common help functions to free reserved pages
  mm/SH: use common help functions to free reserved pages
  mm/SPARC: use common help functions to free reserved pages
  mm/um: use common help functions to free reserved pages
  mm/unicore32: use common help functions to free reserved pages
  mm/x86: use common help functions to free reserved pages
  mm/xtensa: use common help functions to free reserved pages
  mm/arc: use common help functions to free reserved pages
  mm/metag: use common help functions to free reserved pages
  mm,kexec: use common help functions to free reserved pages

 arch/alpha/kernel/sys_nautilus.c             |    5 ++-
 arch/alpha/mm/init.c                         |   24 ++-----------
 arch/alpha/mm/numa.c                         |    3 +-
 arch/arc/mm/init.c                           |   23 ++----------
 arch/arm/mm/init.c                           |   48 +++++++++-----------------
 arch/arm64/mm/init.c                         |   26 ++------------
 arch/avr32/mm/init.c                         |   24 ++-----------
 arch/blackfin/mm/init.c                      |   22 ++----------
 arch/c6x/mm/init.c                           |   30 ++--------------
 arch/cris/mm/init.c                          |   16 ++-------
 arch/frv/mm/init.c                           |   34 +++---------------
 arch/h8300/mm/init.c                         |   30 ++--------------
 arch/ia64/mm/init.c                          |   23 +++---------
 arch/m32r/mm/init.c                          |   26 ++------------
 arch/m68k/mm/init.c                          |   24 ++-----------
 arch/metag/mm/init.c                         |   21 ++---------
 arch/microblaze/include/asm/setup.h          |    1 -
 arch/microblaze/mm/init.c                    |   28 ++-------------
 arch/mips/mm/init.c                          |   31 +++++------------
 arch/mips/sgi-ip27/ip27-memory.c             |    4 +--
 arch/mn10300/mm/init.c                       |   23 ++----------
 arch/openrisc/mm/init.c                      |   27 ++-------------
 arch/parisc/mm/init.c                        |   23 ++----------
 arch/powerpc/kernel/crash_dump.c             |    5 +--
 arch/powerpc/kernel/fadump.c                 |    5 +--
 arch/powerpc/kernel/kvm.c                    |    7 +---
 arch/powerpc/mm/mem.c                        |   29 ++--------------
 arch/powerpc/platforms/512x/mpc512x_shared.c |    5 +--
 arch/s390/mm/init.c                          |   35 ++++---------------
 arch/score/mm/init.c                         |   33 +++---------------
 arch/sh/mm/init.c                            |   26 ++------------
 arch/sparc/kernel/leon_smp.c                 |   15 ++------
 arch/sparc/mm/init_32.c                      |   37 ++------------------
 arch/sparc/mm/init_64.c                      |   26 +++-----------
 arch/um/kernel/mem.c                         |   10 +-----
 arch/unicore32/mm/init.c                     |   28 ++-------------
 arch/x86/mm/init.c                           |    5 +--
 arch/x86/mm/init_64.c                        |    5 ++-
 arch/xtensa/mm/init.c                        |   21 ++---------
 include/linux/mm.h                           |   48 ++++++++++++++++++++++++++
 kernel/kexec.c                               |    8 ++---
 mm/page_alloc.c                              |   20 +++++++++++
 42 files changed, 184 insertions(+), 700 deletions(-)

-- 
1.7.9.5
