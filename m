From: <yezengruan@huawei.com>
Subject: [PATCH 1/5] KVM: arm64: Document PV-lock interface
Date: Tue, 17 Dec 2019 21:55:45 +0800
Message-ID: <20191217135549.3240-2-yezengruan__36231.8060871743$1576591022$gmane$org@huawei.com>
References: <20191217135549.3240-1-yezengruan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191217135549.3240-1-yezengruan@huawei.com>
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

Introduce a paravirtualization interface for KVM/arm64 to obtain the vcpu
is currently running or not.

A hypercall interface is provided for the guest to interrogate the
hypervisor's support for this interface and the location of the shared
memory structures.

Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
---
 Documentation/virt/kvm/arm/pvlock.rst | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/virt/kvm/arm/pvlock.rst

diff --git a/Documentation/virt/kvm/arm/pvlock.rst b/Documentation/virt/kvm/arm/pvlock.rst
new file mode 100644
index 000000000000..eec0c36edf17
--- /dev/null
+++ b/Documentation/virt/kvm/arm/pvlock.rst
@@ -0,0 +1,31 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Paravirtualized lock support for arm64
+======================================
+
+KVM/arm64 provids some hypervisor service calls to support a paravirtualized
+guest obtaining the vcpu is currently running or not.
+
+Two new SMCCC compatible hypercalls are defined:
+
+* PV_LOCK_FEATURES:   0xC5000040
+* PV_LOCK_PREEMPTED:  0xC5000041
+
+The existence of the PV_LOCK hypercall should be probed using the SMCCC 1.1
+ARCH_FEATURES mechanism before calling it.
+
+PV_LOCK_FEATURES
+    ============= ========    ==========
+    Function ID:  (uint32)    0xC5000040
+    PV_call_id:   (uint32)    The function to query for support.
+    Return value: (int64)     NOT_SUPPORTED (-1) or SUCCESS (0) if the relevant
+                              PV-lock feature is supported by the hypervisor.
+    ============= ========    ==========
+
+PV_LOCK_PREEMPTED
+    ============= ========    ==========
+    Function ID:  (uint32)    0xC5000041
+    Return value: (int64)     NOT_SUPPORTED (-1) or SUCCESS (0) if the IPA of
+                              this vcpu's pv data structure is configured by
+                              the hypervisor.
+    ============= ========    ==========
-- 
2.19.1
