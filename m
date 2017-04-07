From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 13/15] virtio-iommu: debug via IPC
Date: Fri,  7 Apr 2017 20:24:53 +0100
Message-ID: <20170407192455.26814-14-jean-philippe.brucker__6578.6775820472$1491593274$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192455.26814-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407192455.26814-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, lorenzo.pieralisi@arm.com, mst@redhat.com, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

Add a new parameter to lkvm debug, '-i' or '--iommu'. Commands will be
added later. For the moment, rework the debug builtin to share dump
facilities with the '-d'/'--dump' parameter.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 builtin-debug.c             |  8 +++++++-
 include/kvm/builtin-debug.h |  6 ++++++
 include/kvm/iommu.h         |  5 +++++
 include/kvm/virtio-iommu.h  |  5 +++++
 kvm-ipc.c                   | 43 ++++++++++++++++++++++++-------------------
 virtio/iommu.c              | 14 ++++++++++++++
 6 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/builtin-debug.c b/builtin-debug.c
index 4ae51d20..e39e2d09 100644
--- a/builtin-debug.c
+++ b/builtin-debug.c
@@ -5,6 +5,7 @@
 #include <kvm/parse-options.h>
 #include <kvm/kvm-ipc.h>
 #include <kvm/read-write.h>
+#include <kvm/virtio-iommu.h>
 
 #include <stdio.h>
 #include <string.h>
@@ -17,6 +18,7 @@ static int nmi = -1;
 static bool dump;
 static const char *instance_name;
 static const char *sysrq;
+static const char *iommu;
 
 static const char * const debug_usage[] = {
 	"lkvm debug [--all] [-n name] [-d] [-m vcpu]",
@@ -28,6 +30,7 @@ static const struct option debug_options[] = {
 	OPT_BOOLEAN('d', "dump", &dump, "Generate a debug dump from guest"),
 	OPT_INTEGER('m', "nmi", &nmi, "Generate NMI on VCPU"),
 	OPT_STRING('s', "sysrq", &sysrq, "sysrq", "Inject a sysrq"),
+	OPT_STRING('i', "iommu", &iommu, "params", "Debug virtual IOMMU"),
 	OPT_GROUP("Instance options:"),
 	OPT_BOOLEAN('a', "all", &all, "Debug all instances"),
 	OPT_STRING('n', "name", &instance_name, "name", "Instance name"),
@@ -68,11 +71,14 @@ static int do_debug(const char *name, int sock)
 		cmd.sysrq = sysrq[0];
 	}
 
+	if (iommu && !viommu_parse_debug_string(iommu, &cmd.iommu))
+		cmd.dbg_type |= KVM_DEBUG_CMD_TYPE_IOMMU;
+
 	r = kvm_ipc__send_msg(sock, KVM_IPC_DEBUG, sizeof(cmd), (u8 *)&cmd);
 	if (r < 0)
 		return r;
 
-	if (!dump)
+	if (!(cmd.dbg_type & KVM_DEBUG_CMD_DUMP_MASK))
 		return 0;
 
 	do {
diff --git a/include/kvm/builtin-debug.h b/include/kvm/builtin-debug.h
index efa02684..cd2155ae 100644
--- a/include/kvm/builtin-debug.h
+++ b/include/kvm/builtin-debug.h
@@ -2,16 +2,22 @@
 #define KVM__DEBUG_H
 
 #include <kvm/util.h>
+#include <kvm/iommu.h>
 #include <linux/types.h>
 
 #define KVM_DEBUG_CMD_TYPE_DUMP	(1 << 0)
 #define KVM_DEBUG_CMD_TYPE_NMI	(1 << 1)
 #define KVM_DEBUG_CMD_TYPE_SYSRQ (1 << 2)
+#define KVM_DEBUG_CMD_TYPE_IOMMU (1 << 3)
+
+#define KVM_DEBUG_CMD_DUMP_MASK \
+	(KVM_DEBUG_CMD_TYPE_IOMMU | KVM_DEBUG_CMD_TYPE_DUMP)
 
 struct debug_cmd_params {
 	u32 dbg_type;
 	u32 cpu;
 	char sysrq;
+	struct iommu_debug_params iommu;
 };
 
 int kvm_cmd_debug(int argc, const char **argv, const char *prefix);
diff --git a/include/kvm/iommu.h b/include/kvm/iommu.h
index 45a20f3b..60857fa5 100644
--- a/include/kvm/iommu.h
+++ b/include/kvm/iommu.h
@@ -1,6 +1,7 @@
 #ifndef KVM_IOMMU_H
 #define KVM_IOMMU_H
 
+#include <stdbool.h>
 #include <stdlib.h>
 
 #include "devices.h"
@@ -10,6 +11,10 @@
 #define IOMMU_PROT_WRITE	0x2
 #define IOMMU_PROT_EXEC		0x4
 
+struct iommu_debug_params {
+	bool				print_enabled;
+};
+
 /*
  * Test if mapping is present. If not, return an error but do not report it to
  * stderr
diff --git a/include/kvm/virtio-iommu.h b/include/kvm/virtio-iommu.h
index 5532c82b..c9e36fb6 100644
--- a/include/kvm/virtio-iommu.h
+++ b/include/kvm/virtio-iommu.h
@@ -7,4 +7,9 @@ const struct iommu_properties *viommu_get_properties(void *dev);
 void *viommu_register(struct kvm *kvm, struct iommu_properties *props);
 void viommu_unregister(struct kvm *kvm, void *cookie);
 
+struct iommu_debug_params;
+
+int viommu_parse_debug_string(const char *options, struct iommu_debug_params *);
+int viommu_debug(int fd, struct iommu_debug_params *);
+
 #endif
diff --git a/kvm-ipc.c b/kvm-ipc.c
index e07ad105..a8b56543 100644
--- a/kvm-ipc.c
+++ b/kvm-ipc.c
@@ -14,6 +14,7 @@
 #include "kvm/strbuf.h"
 #include "kvm/kvm-cpu.h"
 #include "kvm/8250-serial.h"
+#include "kvm/virtio-iommu.h"
 
 struct kvm_ipc_head {
 	u32 type;
@@ -424,31 +425,35 @@ static void handle_debug(struct kvm *kvm, int fd, u32 type, u32 len, u8 *msg)
 		pthread_kill(kvm->cpus[vcpu]->thread, SIGUSR1);
 	}
 
-	if (!(dbg_type & KVM_DEBUG_CMD_TYPE_DUMP))
-		return;
+	if (dbg_type & KVM_DEBUG_CMD_TYPE_IOMMU)
+		viommu_debug(fd, &params->iommu);
 
-	for (i = 0; i < kvm->nrcpus; i++) {
-		struct kvm_cpu *cpu = kvm->cpus[i];
+	if (dbg_type & KVM_DEBUG_CMD_TYPE_DUMP) {
+		for (i = 0; i < kvm->nrcpus; i++) {
+			struct kvm_cpu *cpu = kvm->cpus[i];
 
-		if (!cpu)
-			continue;
+			if (!cpu)
+				continue;
 
-		printout_done = 0;
+			printout_done = 0;
+
+			kvm_cpu__set_debug_fd(fd);
+			pthread_kill(cpu->thread, SIGUSR1);
+			/*
+			 * Wait for the vCPU to dump state before signalling
+			 * the next thread. Since this is debug code it does
+			 * not matter that we are burning CPU time a bit:
+			 */
+			while (!printout_done)
+				sleep(0);
+		}
 
-		kvm_cpu__set_debug_fd(fd);
-		pthread_kill(cpu->thread, SIGUSR1);
-		/*
-		 * Wait for the vCPU to dump state before signalling
-		 * the next thread. Since this is debug code it does
-		 * not matter that we are burning CPU time a bit:
-		 */
-		while (!printout_done)
-			sleep(0);
+		serial8250__inject_sysrq(kvm, 'p');
 	}
 
-	close(fd);
-
-	serial8250__inject_sysrq(kvm, 'p');
+	if (dbg_type & KVM_DEBUG_CMD_DUMP_MASK)
+		/* builtin-debug is reading, signal EOT */
+		close(fd);
 }
 
 int kvm_ipc__init(struct kvm *kvm)
diff --git a/virtio/iommu.c b/virtio/iommu.c
index 2e5a23ee..5973cef1 100644
--- a/virtio/iommu.c
+++ b/virtio/iommu.c
@@ -620,3 +620,17 @@ void viommu_unregister(struct kvm *kvm, void *viommu)
 {
 	free(viommu);
 }
+
+int viommu_parse_debug_string(const char *cmdline, struct iommu_debug_params *params)
+{
+	/* show instances numbers */
+	/* send command to instance */
+	/* - dump mappings */
+	/* - statistics */
+	return -ENOSYS;
+}
+
+int viommu_debug(int sock, struct iommu_debug_params *params)
+{
+	return -ENOSYS;
+}
-- 
2.12.1
