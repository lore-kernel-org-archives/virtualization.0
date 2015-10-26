From: Andrey Smetanin <asmetanin@virtuozzo.com>
Subject: [PATCH 0/7] Hyper-V Synthetic interrupt controller
Date: Mon, 26 Oct 2015 12:50:53 +0300
Message-ID: <1445853060-24201-1-git-send-email-asmetanin__27714.5290551291$1446420851$gmane$org@virtuozzo.com>
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
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, virtualization@lists.linux-foundation.org, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hyper-V SynIC (synthetic interrupt controller) device
implementation.

The implementation contains:
* msr's support
* irq routing setup
* irq injection
* irq ack callback registration
* event/message pages changes tracking at Hyper-V exit
* Hyper-V test device to test SynIC by kvm-unit-tests

Andrey Smetanin (7):
  standard-headers/x86: add Hyper-V SynIC constants
  target-i386/kvm: Hyper-V SynIC MSR's support
  linux-headers/kvm: add Hyper-V SynIC irq routing type and struct
  kvm: Hyper-V SynIC irq routing support
  linux-headers/kvm: KVM_EXIT_HYPERV type and struct
  target-i386/hyperv: Hyper-V SynIC SINT routing and vCPU exit
  hw/misc: Hyper-V test device 'hyperv-testdev'

 default-configs/i386-softmmu.mak          |   1 +
 default-configs/x86_64-softmmu.mak        |   1 +
 hw/misc/Makefile.objs                     |   1 +
 hw/misc/hyperv_testdev.c                  | 164 ++++++++++++++++++++++++++++++
 include/standard-headers/asm-x86/hyperv.h |  12 +++
 include/sysemu/kvm.h                      |   1 +
 kvm-all.c                                 |  33 ++++++
 linux-headers/linux/kvm.h                 |  25 +++++
 target-i386/Makefile.objs                 |   2 +-
 target-i386/cpu-qom.h                     |   1 +
 target-i386/cpu.c                         |   1 +
 target-i386/cpu.h                         |   5 +
 target-i386/hyperv.c                      | 127 +++++++++++++++++++++++
 target-i386/hyperv.h                      |  42 ++++++++
 target-i386/kvm.c                         |  66 +++++++++++-
 target-i386/machine.c                     |  39 +++++++
 16 files changed, 519 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/hyperv_testdev.c
 create mode 100644 target-i386/hyperv.c
 create mode 100644 target-i386/hyperv.h

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Roman Kagan <rkagan@virtuozzo.com>
CC: Denis V. Lunev <den@openvz.org>
CC: kvm@vger.kernel.org
CC: virtualization@lists.linux-foundation.org

-- 
2.4.3
