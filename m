From: Zengruan Ye <yezengruan@huawei.com>
Subject: [PATCH v3 1/8] KVM: arm64: Document PV-lock interface
Date: Thu, 16 Jan 2020 20:46:19 +0800
Message-ID: <20200116124626.1155-2-yezengruan@huawei.com>
References: <20200116124626.1155-1-yezengruan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20200116124626.1155-1-yezengruan@huawei.com>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: peterz@infradead.org, maz@kernel.org, daniel.lezcano@linaro.org, linux@armlinux.org.uk, steven.price@arm.com, longman@redhat.com, catalin.marinas@arm.com, will@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Introduce a paravirtualization interface for KVM/arm64 to obtain the vCPU
that is currently running or not.

The PV lock structure of the guest is allocated by user space.

A hypercall interface is provided for the guest to interrogate the
hypervisor's support for this interface and the location of the shared
memory structures.

Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
---
 Documentation/virt/kvm/arm/pvlock.rst   | 68 +++++++++++++++++++++++++
 Documentation/virt/kvm/devices/vcpu.txt | 14 +++++
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/virt/kvm/arm/pvlock.rst

diff --git a/Documentation/virt/kvm/arm/pvlock.rst b/Documentation/virt/kvm/arm/pvlock.rst
new file mode 100644
index 000000000000..11776273c0a4
--- /dev/null
+++ b/Documentation/virt/kvm/arm/pvlock.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Paravirtualized lock support for arm64
+======================================
+
+KVM/arm64 provides some hypervisor service calls to support a paravirtualized
+guest obtaining whether the vCPU is currently running or not.
+
+Two new SMCCC compatible hypercalls are defined:
+* ARM_SMCCC_VENDOR_HYP_KVM_PV_LOCK_FUNC_ID:  0x86000001
+  - KVM_PV_LOCK_FEATURES   0
+  - KVM_PV_LOCK_PREEMPTED  1
+
+The existence of the PV_LOCK hypercall should be probed using the SMCCC 1.1
+ARCH_FEATURES mechanism and the hypervisor should be KVM before calling it.
+
+KVM_PV_LOCK_FEATURES
+    ============= ========    ==========
+    Function ID:  (uint32)    0x86000001
+    PV_call_id:   (uint32)    0
+    Return value: (int64)     NOT_SUPPORTED (-1) or SUCCESS (0) if the relevant
+                              PV-lock feature is supported by the hypervisor.
+    ============= ========    ==========
+
+KVM_PV_LOCK_PREEMPTED
+    ============= ========    ==========
+    Function ID:  (uint32)    0x86000001
+    PV_call_id:   (uint32)    1
+    Return value: (int64)     IPA of the PV-lock data structure for this vCPU.
+                              On failure:
+                              NOT_SUPPORTED (-1)
+    ============= ========    ==========
+
+The IPA returned by KVM_PV_LOCK_PREEMPTED should be mapped by the guest as
+normal memory with inner and outer write back caching attributes, in the inner
+shareable domain.
+
+KVM_PV_LOCK_PREEMPTED returns the structure for the calling vCPU.
+
+PV lock state
+-------------
+
+The structure pointed to by the KVM_PV_LOCK_PREEMPTED hypercall is as follows:
+
++-----------+-------------+-------------+-----------------------------------+
+| Field     | Byte Length | Byte Offset | Description                       |
++===========+=============+=============+===================================+
+| preempted |      8      |      0      | Indicates that the vCPU that owns |
+|           |             |             | this struct is running or not.    |
+|           |             |             | Non-zero values mean the vCPU has |
+|           |             |             | been preempted. Zero means the    |
+|           |             |             | vCPU is not preempted.            |
++-----------+-------------+-------------+-----------------------------------+
+
+The preempted field will be updated to 1 by the hypervisor prior to scheduling
+a vCPU. When the vCPU is scheduled out, the preempted field will be updated
+to 0 by the hypervisor.
+
+The structure will be present within a reserved region of the normal memory
+given to the guest. The guest should not attempt to write into this memory.
+There is a structure per vCPU of the guest.
+
+It is advisable that one or more 64k pages are set aside for the purpose of
+these structures and not used for other purposes, this enables the guest to map
+the region using 64k pages and avoids conflicting attributes with other memory.
+
+For the user space interface see Documentation/virt/kvm/devices/vcpu.txt
+section "4. GROUP: KVM_ARM_VCPU_PVLOCK_CTRL".
diff --git a/Documentation/virt/kvm/devices/vcpu.txt b/Documentation/virt/kvm/devices/vcpu.txt
index 6f3bd64a05b0..2c68d9a0f644 100644
--- a/Documentation/virt/kvm/devices/vcpu.txt
+++ b/Documentation/virt/kvm/devices/vcpu.txt
@@ -74,3 +74,17 @@ Specifies the base address of the stolen time structure for this VCPU. The
 base address must be 64 byte aligned and exist within a valid guest memory
 region. See Documentation/virt/kvm/arm/pvtime.txt for more information
 including the layout of the stolen time structure.
+
+4. GROUP: KVM_ARM_VCPU_PVLOCK_CTRL
+Architectures: ARM64
+
+4.1 ATTRIBUTE: KVM_ARM_VCPU_PVLOCK_IPA
+Parameters: 64-bit base address
+Returns: -ENXIO:  PV lock not implemented
+         -EEXIST: Base address already set for this vCPU
+         -EINVAL: Base address not 64 byte aligned
+
+Specifies the base address of the PV lock structure for this vCPU. The
+base address must be 64 byte aligned and exist within a valid guest memory
+region. See Documentation/virt/kvm/arm/pvlock.rst for more information
+including the layout of the pv lock structure.
-- 
2.19.1
