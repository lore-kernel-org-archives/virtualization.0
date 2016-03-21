From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 0/6]  Support calling functions on dedicated physical cpu
Date: Mon, 21 Mar 2016 13:24:29 +0100
Message-ID: <1458563075-30298-1-git-send-email-jgross@suse.com>
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
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, jdelvare@suse.com, konrad.wilk@oracle.com, peterz@infradead.org, hpa@zytor.com, akataria@vmware.com, x86@kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

Some hardware (e.g. Dell Studio laptops) require special functions to
be called on physical cpu 0 in order to avoid occasional hangs. When
running as dom0 under Xen this could be achieved only via special boot
parameters (vcpu pinning) limiting the hypervisor in it's scheduling
decisions.

This patch series is adding a generic function to be able to temporarily
pin a (virtual) cpu to a dedicated physical cpu for executing above
mentioned functions on that specific cpu. The drivers (dcdbas and i8k)
requiring this functionality are modified accordingly.

Changes in V2:
- instead of manipulating the allowed set of cpus use cpu specific
  workqueue as requested by Peter Zijlstra
- add include/linux/hypervisor.h to hide architecture specific stuff
  from generic kernel cod


Juergen Gross (6):
  xen: sync xen header
  smp: add function to execute a function synchronously on a physical
    cpu
  dcdbas: make use of smp_call_sync_on_phys_cpu()
  hwmon: use smp_call_sync_on_phys_cpu() for dell-smm i8k
  virt, sched: add cpu pinning to smp_call_sync_on_phys_cpu()
  xen: add xen_pin_vcpu() to support calling functions on a dedicated
    pcpu

 MAINTAINERS                       |   1 +
 arch/x86/include/asm/hypervisor.h |   9 ++++
 arch/x86/xen/enlighten.c          |  40 +++++++++++++++
 drivers/firmware/dcdbas.c         |  46 ++++++++----------
 drivers/hwmon/dell-smm-hwmon.c    |  27 +++++-----
 include/linux/hypervisor.h        |  17 +++++++
 include/linux/smp.h               |   2 +
 include/xen/interface/sched.h     | 100 +++++++++++++++++++++++++++++++-------
 kernel/smp.c                      |  50 +++++++++++++++++++
 kernel/up.c                       |  18 +++++++
 10 files changed, 251 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/hypervisor.h

-- 
2.6.2
