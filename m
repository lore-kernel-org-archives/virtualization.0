From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 0/4] make virt_spin_lock() a pvops function
Date: Tue,  5 Sep 2017 15:24:40 +0200
Message-ID: <20170905132444.7163-1-jgross@suse.com>
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
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, peterz@infradead.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, longman@redhat.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

With virt_spin_lock() being a pvops function the bare metal case can be
optimized by patching the call away completely. In case a kernel running
as a guest it can decide whether to use paravitualized spinlocks, the
current fallback to the unfair test-and-set scheme, or to mimic the
bare metal behavior.

Juergen Gross (4):
  paravirt: add generic _paravirt_false() function
  paravirt: switch vcpu_is_preempted to use _paravirt_false() on bare
    metal
  paravirt: add virt_spin_lock pvops function
  paravirt,xen: correct xen_nopvspin case

 arch/x86/include/asm/paravirt.h       |  5 ++++
 arch/x86/include/asm/paravirt_types.h |  3 +++
 arch/x86/include/asm/qspinlock.h      | 48 ++++++++++++++++++++++++-----------
 arch/x86/kernel/paravirt-spinlocks.c  | 22 ++++++++--------
 arch/x86/kernel/paravirt.c            |  7 +++++
 arch/x86/kernel/paravirt_patch_32.c   | 18 ++++++-------
 arch/x86/kernel/paravirt_patch_64.c   | 17 +++++--------
 arch/x86/kernel/smpboot.c             |  2 ++
 arch/x86/xen/spinlock.c               |  2 ++
 9 files changed, 79 insertions(+), 45 deletions(-)

-- 
2.12.3
