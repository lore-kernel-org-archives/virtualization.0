From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH V12 0/5] Paravirtualized ticket spinlocks for KVM host
Date: Tue, 06 Aug 2013 23:51:50 +0530
Message-ID: <20130806182150.2386.95104.sendpatchset@codeblue.in.ibm.com>
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
To: gleb@redhat.com, mingo@redhat.com, jeremy@goop.org, x86@kernel.org, konrad.wilk@oracle.com, hpa@zytor.com, pbonzini@redhat.com
Cc: habanero@linux.vnet.ibm.com, riel@redhat.com, srivatsa.vaddagiri@gmail.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, chegu_vinod@hp.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, drjones@redhat.com, ouyang@cs.pitt.edu, andi@firstfloor.org, avi.kivity@gmail.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


 This series forms the kvm host part of paravirtual spinlock
 based against kvm tree.
 
 Please refer https://lkml.org/lkml/2013/8/6/178 for kvm guest part
 of the series.

 Please note that:
 kvm uapi: Add KICK_CPU and PV_UNHALT definition to uapi is a common patch
 for both guest and host.

 Srivatsa Vaddagiri (1):
  kvm hypervisor : Add a hypercall to KVM hypervisor to support pv-ticketlocks

 Raghavendra K T (4):
  kvm uapi: Add KICK_CPU and PV_UNHALT definition to uapi
  kvm : Fold pv_unhalt flag into GET_MP_STATE ioctl to aid migration
  kvm hypervisor: Simplify kvm_for_each_vcpu with kvm_irq_delivery_to_apic
  Documentation/kvm : Add documentation on Hypercalls and features used for PV spinlock 
--- 
 Documentation/virtual/kvm/cpuid.txt      |  4 ++++
 Documentation/virtual/kvm/hypercalls.txt | 14 ++++++++++++++
 arch/x86/include/asm/kvm_host.h          |  5 +++++
 arch/x86/include/uapi/asm/kvm_para.h     |  1 +
 arch/x86/kvm/cpuid.c                     |  3 ++-
 arch/x86/kvm/lapic.c                     |  5 ++++-
 arch/x86/kvm/x86.c                       | 31 ++++++++++++++++++++++++++++++-
 include/uapi/linux/kvm_para.h            |  1 +
 8 files changed, 61 insertions(+), 3 deletions(-)
