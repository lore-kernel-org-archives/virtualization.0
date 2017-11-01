From: Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v2 0/2] x86/paravirt: Enable users to choose PV lock type
Date: Wed,  1 Nov 2017 16:58:52 -0400
Message-ID: <1509569934-4919-1-git-send-email-longman__8277.33305418423$1509569976$gmane$org@redhat.com>
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
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, kvm@vger.kernel.org, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Waiman Long <longman@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

v1->v2:
 - Make pv_spinlock_type a bit mask for easier checking.
 - Add patch 2 to deprecate xen_nopvspin

v1 - https://lkml.org/lkml/2017/11/1/381

Patch 1 adds a new pvlock_type parameter for the administrators to
specify the type of lock to be used in a para-virtualized kernel.

Patch 2 deprecates Xen's xen_nopvspin parameter as it is no longer
needed.

Waiman Long (2):
  x86/paravirt: Add kernel parameter to choose paravirt lock type
  x86/xen: Deprecate xen_nopvspin

 Documentation/admin-guide/kernel-parameters.txt | 11 ++++---
 arch/x86/include/asm/paravirt.h                 |  9 ++++++
 arch/x86/kernel/kvm.c                           |  3 ++
 arch/x86/kernel/paravirt.c                      | 40 ++++++++++++++++++++++++-
 arch/x86/xen/spinlock.c                         | 17 +++++------
 5 files changed, 65 insertions(+), 15 deletions(-)

-- 
1.8.3.1
