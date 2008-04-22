From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 0/3] ia64/pv_ops preparation
Date: Tue, 22 Apr 2008 15:42:18 +0900
Message-ID: <12088465413472-git-send-email-yamahata__10303.5137094141$1208847514$gmane$org@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tony.luck@intel.com, linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, eddie.dong@intel.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi. This patchset is preparation patches for ia64/pv_ops support.
They are almost trivial and mainly make kernel paravirtualization friendly.

thanks,

Diffstat:
 arch/ia64/kernel/irq_ia64.c    |    1 -
 include/asm-ia64/intrinsics.h  |   11 +++++++++++
 include/asm-ia64/mmu_context.h |    6 +-----
 include/asm-ia64/smp.h         |    2 ++
 include/asm-ia64/system.h      |   10 ++++++++--
 5 files changed, 22 insertions(+), 8 deletions(-)
