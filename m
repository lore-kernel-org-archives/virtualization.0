From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH v2 5/5] ACPI/IORT: Move IORT to the ACPI folder
Date: Fri, 17 Nov 2017 18:52:11 +0000
Message-ID: <20171117185211.32593-6-jean-philippe.brucker__8809.71112424067$1510944884$gmane$org@arm.com>
References: <20171117185211.32593-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171117185211.32593-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, devel@acpica.org, linux-acpi@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: Jayachandran.Nair@cavium.com, lorenzo.pieralisi@arm.com, ashok.raj@intel.com, mst@redhat.com, marc.zyngier@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, robert.moore@intel.com, eric.auger@redhat.com, lv.zheng@intel.com, sudeep.holla@arm.com, lenb@kernel.org, robin.murphy@arm.com, joro@8bytes.org, hanjun.guo@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

IORT can be used (by QEMU) to describe a virtual topology containing an
architecture-agnostic paravirtualized device. The rationale behind this
blasphemy is explained in patch 4/5.

In order to build IORT for x86 systems, the driver has to be moved outside
of arm64/. Since there is nothing specific to arm64 in the driver, it
simply requires moving Makefile and Kconfig entries.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/acpi/Kconfig            | 3 +++
 drivers/acpi/Makefile           | 1 +
 drivers/acpi/arm64/Kconfig      | 3 ---
 drivers/acpi/arm64/Makefile     | 1 -
 drivers/acpi/{arm64 => }/iort.c | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/acpi/{arm64 => }/iort.c (100%)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5b1938f4b626..ce40275646c8 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -536,4 +536,7 @@ if ARM64
 source "drivers/acpi/arm64/Kconfig"
 endif
 
+config ACPI_IORT
+	bool
+
 endif	# ACPI
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index cd1abc9bc325..689c470c013b 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -112,3 +112,4 @@ video-objs			+= acpi_video.o video_detect.o
 obj-y				+= dptf/
 
 obj-$(CONFIG_ARM64)		+= arm64/
+obj-$(CONFIG_ACPI_IORT) 	+= iort.o
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 5a6f80fce0d6..403f917ab274 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -2,8 +2,5 @@
 # ACPI Configuration for ARM64
 #
 
-config ACPI_IORT
-	bool
-
 config ACPI_GTDT
 	bool
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 1017def2ea12..47925dc6cfc8 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1,2 +1 @@
-obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/iort.c
similarity index 100%
rename from drivers/acpi/arm64/iort.c
rename to drivers/acpi/iort.c
-- 
2.14.3
