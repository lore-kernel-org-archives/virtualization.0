From: Liang Li <liang.z.li@intel.com>
Subject: [RFC qemu 1/4] pc: Add code to get the lowmem form PCMachineState
Date: Thu,  3 Mar 2016 18:44:25 +0800
Message-ID: <1457001868-15949-2-git-send-email-liang.z.li__15925.2577148893$1457019650$gmane$org@intel.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: quintela@redhat.com, amit.shah@redhat.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, Liang Li <liang.z.li@intel.com>, dgilbert@redhat.com, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, rth@twiddle.net
List-Id: virtualization@lists.linuxfoundation.org

The lowmem will be used by the following patch to get
a correct free pages bitmap.

Signed-off-by: Liang Li <liang.z.li@intel.com>
---
 hw/i386/pc.c         | 5 +++++
 hw/i386/pc_piix.c    | 1 +
 hw/i386/pc_q35.c     | 1 +
 include/hw/i386/pc.h | 3 ++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0aeefd2..f794a84 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1115,6 +1115,11 @@ void pc_hot_add_cpu(const int64_t id, Error **errp)
     object_unref(OBJECT(cpu));
 }
 
+ram_addr_t pc_get_lowmem(PCMachineState *pcms)
+{
+   return pcms->lowmem;
+}
+
 void pc_cpus_init(PCMachineState *pcms)
 {
     int i;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6f8c2cd..268a08c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -113,6 +113,7 @@ static void pc_init1(MachineState *machine,
         }
     }
 
+    pcms->lowmem = lowmem;
     if (machine->ram_size >= lowmem) {
         pcms->above_4g_mem_size = machine->ram_size - lowmem;
         pcms->below_4g_mem_size = lowmem;
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 46522c9..8d9bd39 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -101,6 +101,7 @@ static void pc_q35_init(MachineState *machine)
         }
     }
 
+    pcms->lowmem = lowmem;
     if (machine->ram_size >= lowmem) {
         pcms->above_4g_mem_size = machine->ram_size - lowmem;
         pcms->below_4g_mem_size = lowmem;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 8b3546e..3694c91 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -60,7 +60,7 @@ struct PCMachineState {
     bool nvdimm;
 
     /* RAM information (sizes, addresses, configuration): */
-    ram_addr_t below_4g_mem_size, above_4g_mem_size;
+    ram_addr_t below_4g_mem_size, above_4g_mem_size, lowmem;
 
     /* CPU and apic information: */
     bool apic_xrupt_override;
@@ -229,6 +229,7 @@ void pc_hot_add_cpu(const int64_t id, Error **errp);
 void pc_acpi_init(const char *default_dsdt);
 
 void pc_guest_info_init(PCMachineState *pcms);
+ram_addr_t pc_get_lowmem(PCMachineState *pcms);
 
 #define PCI_HOST_PROP_PCI_HOLE_START   "pci-hole-start"
 #define PCI_HOST_PROP_PCI_HOLE_END     "pci-hole-end"
-- 
1.8.3.1
