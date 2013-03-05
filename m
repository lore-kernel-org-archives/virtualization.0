From: Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v1 00/33] accurately calculate pages managed by buddy
	system
Date: Tue,  5 Mar 2013 22:54:43 +0800
Message-ID: <1362495317-32682-1-git-send-email-jiang.liu__29875.4691532396$1362502348$gmane$org@huawei.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Aurelien Jacquiot <a-jacquiot@ti.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Tang Chen <tangchen@cn.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Sam Ravnborg <sam@ravnborg.org>, Lennox Wu <lennox.wu@gmail.com>, Maciej Rutecki <maciej.rutecki@gmail.com>, Jonas Bonn <jonas@southpole.se>, Mark Salter <msalter@redhat.com>, Michel Lespinasse <walken@google.com>, Mikael Starvik <starvik@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Ingo
List-Id: virtualization@lists.linuxfoundation.org

The original goal of this patchset is to fix the bug reported by
https://bugzilla.kernel.org/show_bug.cgi?id=53501

Now it has also been expanded to reduce common code used by memory
initializion. In total it has reduced about 550 lines of code.

Patch 1:
	Extract common help functions from free_init_mem() and
	free_initrd_mem() on different architectures.
Patch 2-27:
	Use help functions to simplify free_init_mem() and
	free_initrd_mem() on different architectures. This has reduced
	about 500 lines of code.
Patch 28:
	Introduce common help function to free highmem pages when
	initializing memory subsystem.
Patch 29-32:
	Adjust totalhigh_pages, totalram_pages and zone->managed_pages
	altogether when reserving/unreserving pages.
Patch 33:
	Change /sys/.../node/nodex/meminfo to report available pages
	within the node as "MemTotal".

We have only tested these patchset on x86 platforms, and have done basic
compliation tests using cross-compilers from ftp.kernel.org. That means
some code may not pass compilation on some architectures. So any help
to test this patchset are welcomed!

Jiang Liu (33):
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
  mm,kexec: use common help functions to free reserved pages
  mm: introduce free_highmem_page() helper to free highmem pages inti
    buddy system
  mm: accurately calculate zone->managed_pages for highmem zones
  mm: use a dedicated lock to protect totalram_pages and
    zone->managed_pages
  mm: avoid using __free_pages_bootmem() at runtime
  mm: correctly update zone->mamaged_pages
  mm: report available pages as "MemTotal" for each NUMA node

 arch/alpha/kernel/sys_nautilus.c             |    5 +-
 arch/alpha/mm/init.c                         |   24 ++-------
 arch/alpha/mm/numa.c                         |    3 +-
 arch/arm/mm/init.c                           |   46 ++++++-----------
 arch/arm64/mm/init.c                         |   26 +---------
 arch/avr32/mm/init.c                         |   24 +--------
 arch/blackfin/mm/init.c                      |   20 +-------
 arch/c6x/mm/init.c                           |   30 +----------
 arch/cris/mm/init.c                          |   16 +-----
 arch/frv/mm/init.c                           |   32 ++----------
 arch/h8300/mm/init.c                         |   28 +----------
 arch/ia64/mm/init.c                          |   23 ++-------
 arch/m32r/mm/init.c                          |   26 ++--------
 arch/m68k/mm/init.c                          |   24 +--------
 arch/microblaze/include/asm/setup.h          |    1 -
 arch/microblaze/mm/init.c                    |   33 ++----------
 arch/mips/mm/init.c                          |   36 ++++----------
 arch/mips/sgi-ip27/ip27-memory.c             |    4 +-
 arch/mn10300/mm/init.c                       |   23 +--------
 arch/openrisc/mm/init.c                      |   27 ++--------
 arch/parisc/mm/init.c                        |   24 ++-------
 arch/powerpc/kernel/crash_dump.c             |    5 +-
 arch/powerpc/kernel/fadump.c                 |    5 +-
 arch/powerpc/kernel/kvm.c                    |    7 +--
 arch/powerpc/mm/mem.c                        |   34 ++-----------
 arch/powerpc/platforms/512x/mpc512x_shared.c |    5 +-
 arch/s390/mm/init.c                          |   35 +++----------
 arch/score/mm/init.c                         |   33 ++----------
 arch/sh/mm/init.c                            |   26 ++--------
 arch/sparc/kernel/leon_smp.c                 |   15 ++----
 arch/sparc/mm/init_32.c                      |   50 +++----------------
 arch/sparc/mm/init_64.c                      |   25 ++--------
 arch/tile/mm/init.c                          |    4 +-
 arch/um/kernel/mem.c                         |   25 ++--------
 arch/unicore32/mm/init.c                     |   26 +---------
 arch/x86/mm/init.c                           |    5 +-
 arch/x86/mm/init_32.c                        |   10 +---
 arch/x86/mm/init_64.c                        |   18 +------
 arch/xtensa/mm/init.c                        |   21 ++------
 drivers/virtio/virtio_balloon.c              |    8 +--
 drivers/xen/balloon.c                        |   19 ++-----
 include/linux/mm.h                           |   36 ++++++++++++++
 include/linux/mmzone.h                       |   14 ++++--
 kernel/kexec.c                               |    8 +--
 mm/bootmem.c                                 |   16 ++----
 mm/hugetlb.c                                 |    2 +-
 mm/memory_hotplug.c                          |   31 ++----------
 mm/nobootmem.c                               |   14 ++----
 mm/page_alloc.c                              |   69 ++++++++++++++++++++++----
 49 files changed, 248 insertions(+), 793 deletions(-)

-- 
1.7.9.5
