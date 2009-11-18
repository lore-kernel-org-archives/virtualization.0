From: Alexander Graf <agraf@suse.de>
Subject: [PATCH 0/3] Split up pv-ops
Date: Wed, 18 Nov 2009 01:13:09 +0100
Message-ID: <1258503192-14246-1-git-send-email-agraf__8240.91579202122$1258503289$gmane$org@suse.de>
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
To: kvm list <kvm@vger.kernel.org>
Cc: Nick Piggin <npiggin@suse.de>, Glauber Costa <glommer@redhat.com>, Avi Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Paravirt ops is currently only capable of either replacing a lot of Linux
internal code or none at all. The are users that don't need all of the
possibilities pv-ops delivers though.

On KVM for example we're perfectly fine not using the PV MMU, thus not
touching any MMU code. That way we don't have to improve pv-ops to become
fast, we just don't compile the MMU parts in!

This patchset splits pv-ops into several smaller config options split by
feature category and then converts the KVM pv-ops code to use only the
bits that are required, lowering overhead.

Alexander Graf (3):
  Split paravirt ops by functionality
  Only export selected pv-ops feature structs
  Split the KVM pv-ops support by feature

 arch/x86/Kconfig                            |   72 +++++++++++++++++++++++++-
 arch/x86/include/asm/apic.h                 |    2 +-
 arch/x86/include/asm/desc.h                 |    4 +-
 arch/x86/include/asm/fixmap.h               |    2 +-
 arch/x86/include/asm/highmem.h              |    2 +-
 arch/x86/include/asm/io_32.h                |    4 +-
 arch/x86/include/asm/io_64.h                |    2 +-
 arch/x86/include/asm/irqflags.h             |   21 ++++++--
 arch/x86/include/asm/mmu_context.h          |    4 +-
 arch/x86/include/asm/msr.h                  |    4 +-
 arch/x86/include/asm/paravirt.h             |   44 ++++++++++++++++-
 arch/x86/include/asm/paravirt_types.h       |   12 +++++
 arch/x86/include/asm/pgalloc.h              |    2 +-
 arch/x86/include/asm/pgtable-3level_types.h |    2 +-
 arch/x86/include/asm/pgtable.h              |    2 +-
 arch/x86/include/asm/processor.h            |    2 +-
 arch/x86/include/asm/required-features.h    |    2 +-
 arch/x86/include/asm/smp.h                  |    2 +-
 arch/x86/include/asm/system.h               |   13 +++--
 arch/x86/include/asm/tlbflush.h             |    4 +-
 arch/x86/kernel/head_64.S                   |    2 +-
 arch/x86/kernel/kvm.c                       |   22 ++++++---
 arch/x86/kernel/paravirt.c                  |   37 +++++++++++--
 arch/x86/kernel/tsc.c                       |    2 +-
 arch/x86/kernel/vsmp_64.c                   |    2 +-
 arch/x86/xen/Kconfig                        |    2 +-
 26 files changed, 219 insertions(+), 50 deletions(-)
