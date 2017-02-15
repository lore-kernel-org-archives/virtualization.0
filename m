From: Waiman Long <longman@redhat.com>
Subject: [PATCH v3 0/2] x86/kvm: Reduce vcpu_is_preempted() overhead
Date: Wed, 15 Feb 2017 13:31:00 -0500
Message-ID: <1487183463-882-1-git-send-email-longman__34741.3798365325$1487183534$gmane$org@redhat.com>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, kvm@vger.kernel.org, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Waiman Long <longman@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

 v2->v3:
  - Provide an optimized __raw_callee_save___kvm_vcpu_is_preempted()
    in assembly as suggested by PeterZ.
  - Add a new patch to change vcpu_is_preempted() argument type to long
    to ease the writing of the assembly code.

 v1->v2:
  - Rerun the fio test on a different system on both bare-metal and a
    KVM guest. Both sockets were utilized in this test.
  - The commit log was updated with new performance numbers, but the
    patch wasn't changed.
  - Drop patch 2.

As it was found that the overhead of callee-save vcpu_is_preempted()
can have some impact on system performance on a VM guest, especially
of x86-64 guest, this patch set intends to reduce this performance
overhead by replacing the C __kvm_vcpu_is_preempted() function by
an optimized version of __raw_callee_save___kvm_vcpu_is_preempted()
written in assembly.

Waiman Long (2):
  x86/paravirt: Change vcp_is_preempted() arg type to long
  x86/kvm: Provide optimized version of vcpu_is_preempted() for x86-64

 arch/x86/include/asm/paravirt.h      |  2 +-
 arch/x86/include/asm/qspinlock.h     |  2 +-
 arch/x86/kernel/kvm.c                | 30 +++++++++++++++++++++++++++++-
 arch/x86/kernel/paravirt-spinlocks.c |  2 +-
 4 files changed, 32 insertions(+), 4 deletions(-)

-- 
1.8.3.1
