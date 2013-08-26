From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH V13 0/4] Paravirtualized ticket spinlocks for KVM host
Date: Mon, 26 Aug 2013 14:18:32 +0530
Message-ID: <1377506916-26946-1-git-send-email-raghavendra.kt__3578.58853317357$1377506583$gmane$org@linux.vnet.ibm.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <y>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mingo@redhat.com, hpa@zytor.com, x86@kernel.org, gleb@redhat.com, pbonzini@redhat.com
Cc: habanero@linux.vnet.ibm.com, jeremy@goop.org, drjones@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, peterz@infradead.org, torvalds@linux-foundation.org, linux-doc@vger.kernel.org, ouyang@cs.pitt.edu, linux-kernel@vger.kernel.org, riel@redhat.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, andi@firstfloor.org, srivatsa.vaddagiri@gmail.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, avi.kivity@gmail.com
List-Id: virtualization@lists.linuxfoundation.org


 This series forms the kvm host part of paravirtual spinlock
 based against kvm tree.

 Please refer to https://lkml.org/lkml/2013/8/9/265 for
 kvm guest and Xen, x86 part merged to -tip spinlocks.

 Please note that:
 kvm uapi: Add KICK_CPU and PV_UNHALT definition to uapi is a common patch
 for both guest and host.

 Changes since V12:
  fold the patch 3 into patch 2 for bisection. (Eric Northup)

Raghavendra K T (3):
  kvm uapi: Add KICK_CPU and PV_UNHALT definition to uapi
  kvm hypervisor: Simplify kvm_for_each_vcpu with
    kvm_irq_delivery_to_apic
  Documentation/kvm : Add documentation on Hypercalls and features used
    for PV spinlock

Srivatsa Vaddagiri (1):
  kvm hypervisor : Add a hypercall to KVM hypervisor to support
    pv-ticketlocks

 Documentation/virtual/kvm/cpuid.txt      |  4 ++++
 Documentation/virtual/kvm/hypercalls.txt | 14 ++++++++++++++
 arch/x86/include/asm/kvm_host.h          |  5 +++++
 arch/x86/include/uapi/asm/kvm_para.h     |  1 +
 arch/x86/kvm/cpuid.c                     |  3 ++-
 arch/x86/kvm/lapic.c                     |  5 ++++-
 arch/x86/kvm/x86.c                       | 31 ++++++++++++++++++++++++++++++-
 include/uapi/linux/kvm_para.h            |  1 +
 8 files changed, 61 insertions(+), 3 deletions(-)

-- 
1.7.11.7
