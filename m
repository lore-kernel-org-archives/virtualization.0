From: <yezengruan@huawei.com>
Subject: [PATCH 0/5] KVM: arm64: vcpu preempted check support
Date: Tue, 17 Dec 2019 21:55:44 +0800
Message-ID: <20191217135549.3240-1-yezengruan__20361.4575600781$1576591023$gmane$org@huawei.com>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: yezengruan@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, daniel.lezcano@linaro.org, linux@armlinux.org.uk, steven.price@arm.com, james.morse@arm.com, maz@kernel.org, will@kernel.org, julien.thierry.kdev@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

From: Zengruan Ye <yezengruan@huawei.com>

This patch set aims to support the vcpu_is_preempted() functionality
under KVM/arm64, which allowing the guest to obtain the vcpu is
currently running or not. This will enhance lock performance on
overcommitted hosts (more runnable vcpus than physical cpus in the
system) as doing busy waits for preempted vcpus will hurt system
performance far worse than early yielding.

We have observed some performace improvements in uninx benchmark tests.

unix benchmark result:
  host:  kernel 5.5.0-rc1, HiSilicon Kunpeng920, 8 cpus
  guest: kernel 5.5.0-rc1, 16 vcpus

               test-case                |    after-patch    |   before-patch
----------------------------------------+-------------------+------------------
 Dhrystone 2 using register variables   | 334600751.0 lps   | 335319028.3 lps
 Double-Precision Whetstone             |     32856.1 MWIPS |   32849.6 MWIPS
 Execl Throughput                       |      3662.1 lps   |    2718.0 lps
 File Copy 1024 bufsize 2000 maxblocks  |    432906.4 KBps  |  158011.8 KBps
 File Copy 256 bufsize 500 maxblocks    |    116023.0 KBps  |   37664.0 KBps
 File Copy 4096 bufsize 8000 maxblocks  |   1432769.8 KBps  |  441108.8 KBps
 Pipe Throughput                        |   6405029.6 lps   | 6021457.6 lps
 Pipe-based Context Switching           |    185872.7 lps   |  184255.3 lps
 Process Creation                       |      4025.7 lps   |    3706.6 lps
 Shell Scripts (1 concurrent)           |      6745.6 lpm   |    6436.1 lpm
 Shell Scripts (8 concurrent)           |       998.7 lpm   |     931.1 lpm
 System Call Overhead                   |   3913363.1 lps   | 3883287.8 lps
----------------------------------------+-------------------+------------------
 System Benchmarks Index Score          |      1835.1       |    1327.6

Zengruan Ye (5):
  KVM: arm64: Document PV-lock interface
  KVM: arm64: Implement PV_LOCK_FEATURES call
  KVM: arm64: Support pvlock preempted via shared structure
  KVM: arm64: Add interface to support vcpu preempted check
  KVM: arm64: Support the vcpu preemption check

 Documentation/virt/kvm/arm/pvlock.rst  | 31 +++++++++
 arch/arm/include/asm/kvm_host.h        | 13 ++++
 arch/arm64/include/asm/kvm_host.h      | 17 +++++
 arch/arm64/include/asm/paravirt.h      | 15 ++++
 arch/arm64/include/asm/pvlock-abi.h    | 16 +++++
 arch/arm64/include/asm/spinlock.h      |  7 ++
 arch/arm64/kernel/Makefile             |  2 +-
 arch/arm64/kernel/paravirt-spinlocks.c | 13 ++++
 arch/arm64/kernel/paravirt.c           | 95 +++++++++++++++++++++++++-
 arch/arm64/kernel/setup.c              |  2 +
 arch/arm64/kvm/Makefile                |  1 +
 include/linux/arm-smccc.h              | 13 ++++
 include/linux/cpuhotplug.h             |  1 +
 virt/kvm/arm/arm.c                     |  8 +++
 virt/kvm/arm/hypercalls.c              |  7 ++
 virt/kvm/arm/pvlock.c                  | 21 ++++++
 16 files changed, 260 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/virt/kvm/arm/pvlock.rst
 create mode 100644 arch/arm64/include/asm/pvlock-abi.h
 create mode 100644 arch/arm64/kernel/paravirt-spinlocks.c
 create mode 100644 virt/kvm/arm/pvlock.c

-- 
2.19.1
