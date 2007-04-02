From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 00/17] paravirt_ops updates
Date: Sun, 01 Apr 2007 22:56:52 -0700
Message-ID: <20070402055652.610711908@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Andi,

This series of patches updates paravirt_ops in various ways.  Some of the
changes are plain cleanups and improvements, and some add some interfaces
necessary for Xen.

The brief overview:

add-MAINTAINERS.patch			- obvious
remove-CONFIG_DEBUG_PARAVIRT.patch	- no longer needed
paravirt-nop.patch			- mark nop operations consistently
paravirt-pte-accessors.patch		- operations to pack/unpack ptes
paravirt-memory-init.patch		- hooks for memory/pagetable init
paravirt-fixmap.patch			- add fixmap for paravirt boot
shared-kernel-pmd.patch			- allow selectable shared kernel pmd
mm-lifetime-hooks.patch			- hooks for mm dup/activate/exit
paravirt-patch-rename-paravirt_patch.patch - rename patch structure for cla=
rity
paravirt-use-offset-site-ids.patch	- use patch-site id derived from offset
paravirt-fix-clobbers.patch		- fix register clobbers for patch sites
paravirt-patchable-call-wrappers.patch	- wrap paravirt calls for patching
paravirt-patch-machinery.patch		- common patch machinery
paravirt-flush_tlb_others.patch		- paravirt hook for cross-cpu tlb flushing
revert-map_pt_hook.patch		- back out map_pt_hook
paravirt-kmap_atomic_pte.patch		- add kmap_atomic_pte for highpte
paravirt-sched-clock.patch		- hook to measure schedulable time

Thanks,
	J

-- =
